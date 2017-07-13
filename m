Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:36103 "EHLO smtp2.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752889AbdGMUYR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jul 2017 16:24:17 -0400
Date: Thu, 13 Jul 2017 23:24:12 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org
Subject: 4.12 NULL pointer dereference in kmem_cache_free on USB storage
 removal
Message-ID: <alpine.LRH.2.20.1707132319290.24138@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Just found this in dmesg, on disconnecting unmounted camera USB storage.

[219369.449387] usb 3-2: new full-speed USB device number 3 using xhci_hcd
[219369.598434] usb 3-2: New USB device found, idVendor=054c, idProduct=05be
[219369.598437] usb 3-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[219369.598439] usb 3-2: Product: USB Bus-powered Device
[219369.598440] usb 3-2: Manufacturer: Sony
[219369.598442] usb 3-2: SerialNumber: C67320732569
[219369.605665] input: Sony USB Bus-powered Device as /devices/pci0000:00/0000:00:14.0/usb3/3-2/3-2:1.0/0003:054C:05BE.0002/input/input14
[219369.605843] hid-generic 0003:054C:05BE.0002: input,hidraw1: USB HID v1.11 Device [Sony USB Bus-powered Device] on usb-0000:00:14.0-2/input0
[219369.626538] usb 3-2: USB disconnect, device number 3
[219373.529247] usb 3-2: new high-speed USB device number 4 using xhci_hcd
[219373.671251] usb 3-2: New USB device found, idVendor=054c, idProduct=0529
[219373.671254] usb 3-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[219373.671255] usb 3-2: Product: DSC-RX100
[219373.671257] usb 3-2: Manufacturer: Sony
[219373.671258] usb 3-2: SerialNumber: C67320732569
[219373.672166] usb-storage 3-2:1.0: USB Mass Storage device detected
[219373.672280] scsi host7: usb-storage 3-2:1.0
[219374.687670] scsi 7:0:0:0: Direct-Access     Sony     DSC              1.00 PQ: 0 ANSI: 0
[219374.688100] sd 7:0:0:0: Attached scsi generic sg7 type 0
[219374.796049] sd 7:0:0:0: [sdg] 62676992 512-byte logical blocks: (32.1 GB/29.9 GiB)
[219374.796934] sd 7:0:0:0: [sdg] Write Protect is off
[219374.796937] sd 7:0:0:0: [sdg] Mode Sense: 03 00 00 00
[219374.798338] sd 7:0:0:0: [sdg] No Caching mode page found
[219374.798343] sd 7:0:0:0: [sdg] Assuming drive cache: write through
[219374.811127]  sdg: sdg1
[219374.817442] sd 7:0:0:0: [sdg] Attached SCSI removable disk
[219378.245104] FAT-fs (sdg1): utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
[219378.286284] FAT-fs (sdg1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
[255861.349304] usb 3-3: USB disconnect, device number 2
[255861.706636] usb 3-3: new low-speed USB device number 5 using xhci_hcd
[255861.851692] usb 3-3: New USB device found, idVendor=046d, idProduct=c00e
[255861.851697] usb 3-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[255861.851699] usb 3-3: Product: USB-PS/2 Optical Mouse
[255861.851701] usb 3-3: Manufacturer: Logitech
[255861.855516] input: Logitech USB-PS/2 Optical Mouse as /devices/pci0000:00/0000:00:14.0/usb3/3-3/3-3:1.0/0003:046D:C00E.0003/input/input15
[255861.855767] hid-generic 0003:046D:C00E.0003: input,hidraw0: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:14.0-3/input0
[258062.212706] usb 3-2: USB disconnect, device number 4
[258062.320255] BUG: unable to handle kernel NULL pointer dereference at 0000000000000009
[258062.320290] IP: kmem_cache_free+0x12/0x160
[258062.320303] PGD 0 
[258062.320303] P4D 0 

[258062.320324] Oops: 0000 [#1] SMP
[258062.320334] Modules linked in: nls_utf8 nls_cp775 vfat fat joydev uinput snd_hrtimer uas usb_storage xt_CT iptable_raw xt_length xt_mark iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat ipt_REJECT nf_reject_ipv4 xt_tcpudp nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack libcrc32c iptable_filter cpufreq_powersave cpufreq_userspace usbhid snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic x86_pkg_temp_thermal intel_powerclamp kvm_intel iTCO_wdt iTCO_vendor_support kvm irqbypass crct10dif_pclmul i915 crc32c_intel iosf_mbi i2c_algo_bit drm_kms_helper drm sr_mod cdrom intel_gtt agpgart xhci_pci e1000e syscopyarea snd_hda_intel xhci_hcd ehci_pci snd_hda_codec sysfillrect ehci_hcd pcspkr serio_raw sysimgblt snd_hda_core e100 ptp usbcore lpc_ich fb_sys_fops
[258062.320536]  mii sg pps_core usb_common snd_hwdep mfd_core i2c_i801 nuvoton_cir rc_core video coretemp hwmon 8021q garp mrp stp llc snd_seq_dummy snd_seq_oss snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq snd_seq_device snd_timer snd soundcore parport_pc lp parport ip_tables x_tables autofs4
[258062.320623] CPU: 2 PID: 21200 Comm: kworker/2:2 Not tainted 4.12.0 #181
[258062.320641] Hardware name:                  /DH77KC, BIOS KCH7710H.86A.0110.2013.0513.1018 05/13/2013
[258062.320668] Workqueue: events __blk_release_queue
[258062.320682] task: ffff88010da0ea00 task.stack: ffffc900029f8000
[258062.320700] RIP: 0010:kmem_cache_free+0x12/0x160
[258062.320713] RSP: 0018:ffffc900029fbdb8 EFLAGS: 00010202
[258062.320729] RAX: ffffffff813ab050 RBX: ffff8802151e1880 RCX: 0000000000000003
[258062.320749] RDX: ffff880213736840 RSI: ffff8802151e1880 RDI: 0000000000000000
[258062.320768] RBP: ffffc900029fbdc8 R08: ffff880213736920 R09: 0000000180800040
[258062.320788] R10: ffffc900029fbe20 R11: 0000000000000c00 R12: 0000000000000000
[258062.320807] R13: 0000000000000000 R14: 0000000000000000 R15: ffff88021f318700
[258062.320828] FS:  0000000000000000(0000) GS:ffff88021f300000(0000) knlGS:0000000000000000
[258062.320850] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[258062.320866] CR2: 0000000000000009 CR3: 0000000001809000 CR4: 00000000001406e0
[258062.320886] Call Trace:
[258062.320897]  scsi_exit_rq+0x4d/0x60
[258062.320909]  free_request_size+0x1c/0x30
[258062.320923]  mempool_destroy+0x1d/0x60
[258062.320935]  blk_exit_rl+0x1b/0x40
[258062.320946]  __blk_release_queue+0x7d/0x120
[258062.320959]  process_one_work+0x1af/0x340
[258062.320972]  worker_thread+0x43/0x3e0
[258062.320984]  kthread+0xfe/0x130
[258062.320995]  ? create_worker+0x170/0x170
[258062.321007]  ? kthread_create_on_node+0x40/0x40
[258062.321022]  ret_from_fork+0x22/0x30
[258062.321033] Code: de 49 89 45 28 e9 77 ff ff ff 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 41 54 49 89 fc 53 48 89 f3 0f 1f 44 00 00 <f6> 47 09 01 0f 85 8e 00 00 00 4d 85 e4 0f 84 80 00 00 00 bf 00 
[258062.321099] RIP: kmem_cache_free+0x12/0x160 RSP: ffffc900029fbdb8
[258062.321116] CR2: 0000000000000009
[258062.327259] ---[ end trace e89ecb12fb91da47 ]---

-- 
Meelis Roos (mroos@linux.ee)
