import Gio from 'gi://Gio';
import GObject from 'gi://GObject';
import Gtk from 'gi://Gtk';
import Adw from 'gi://Adw';
// Path exacto documentado para el proceso de preferencias en GNOME 45-48
import { ExtensionPreferences, gettext as _ } from 'resource:///org/gnome/Shell/Extensions/js/extensions/prefs.js';

export default class FildemPreferences extends ExtensionPreferences {
    fillPreferencesWindow(window) {
        const settings = this.getSettings();

        const page = new Adw.PreferencesPage();
        window.add(page);

        const group = new Adw.PreferencesGroup({
            title: _('Settings'),
        });
        page.add(group);

        // min-padding
        const paddingRow = new Adw.ActionRow({
            title: _('Button paddings'),
            subtitle: _('Tweak this if the menu and items desynchronize'),
        });
        const paddingSpin = new Gtk.SpinButton({
            adjustment: new Gtk.Adjustment({
                lower: 0,
                upper: 50,
                step_increment: 1,
            }),
            valign: Gtk.Align.CENTER,
        });
        settings.bind('min-padding', paddingSpin, 'value', Gio.SettingsBindFlags.DEFAULT);
        paddingRow.add_suffix(paddingSpin);
        group.add(paddingRow);

        // show-only-when-hover
        const hoverRow = new Adw.SwitchRow({
            title: _('Show menu only when hover'),
            subtitle: _('Show menu only when the mouse is over the panel'),
        });
        settings.bind('show-only-when-hover', hoverRow, 'active', Gio.SettingsBindFlags.DEFAULT);
        group.add(hoverRow);

        // hide-app-menu
        const hideAppRow = new Adw.SwitchRow({
            title: _('Hide app menu'),
            subtitle: _('Hide the app label when showing the menu'),
        });
        settings.bind('hide-app-menu', hideAppRow, 'active', Gio.SettingsBindFlags.DEFAULT);
        group.add(hideAppRow);
    }
}
