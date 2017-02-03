Return-Path: <decui@microsoft.com>
From: Dexuan Cui <decui@microsoft.com>
To: Hannes Reinecke <hare@suse.com>, Bart Van Assche
	<Bart.VanAssche@sandisk.com>, "hare@suse.de" <hare@suse.de>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "jth@kernel.org" <jth@kernel.org>
Subject: RE: [PATCH] genhd: Do not hold event lock when scheduling workqueue
 elements
Date: Fri, 3 Feb 2017 12:22:36 +0000
Message-ID: <MWHPR03MB2669B8A45A07846AF0A06E46BF4F0@MWHPR03MB2669.namprd03.prod.outlook.com>
References: <1484732896-22941-1-git-send-email-hare@suse.de>
 <1485822639.2669.16.camel@sandisk.com>
 <532c55c4-15da-d2f9-401c-36bc4343756b@suse.com>
In-Reply-To: <532c55c4-15da-d2f9-401c-36bc4343756b@suse.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Hannes Reinecke
> Sent: Wednesday, February 1, 2017 00:15
> To: Bart Van Assche <Bart.VanAssche@sandisk.com>; hare@suse.de;
> axboe@kernel.dk
> Cc: hch@lst.de; linux-kernel@vger.kernel.org; linux-block@vger.kernel.org=
;
> jth@kernel.org
> Subject: Re: [PATCH] genhd: Do not hold event lock when scheduling workqu=
eue
> elements
>=20
> On 01/31/2017 01:31 AM, Bart Van Assche wrote:
> > On Wed, 2017-01-18 at 10:48 +0100, Hannes Reinecke wrote:
> >> @@ -1488,26 +1487,13 @@ static unsigned long
> disk_events_poll_jiffies(struct gendisk *disk)
> >>  void disk_block_events(struct gendisk *disk)
> >>  {
> >>         struct disk_events *ev =3D disk->ev;
> >> -       unsigned long flags;
> >> -       bool cancel;
> >>
> >>         if (!ev)
> >>                 return;
> >>
> >> -       /*
> >> -        * Outer mutex ensures that the first blocker completes cancel=
ing
> >> -        * the event work before further blockers are allowed to finis=
h.
> >> -        */
> >> -       mutex_lock(&ev->block_mutex);
> >> -
> >> -       spin_lock_irqsave(&ev->lock, flags);
> >> -       cancel =3D !ev->block++;
> >> -       spin_unlock_irqrestore(&ev->lock, flags);
> >> -
> >> -       if (cancel)
> >> +       if (atomic_inc_return(&ev->block) =3D=3D 1)
> >>                 cancel_delayed_work_sync(&disk->ev->dwork);
> >>
> >> -       mutex_unlock(&ev->block_mutex);
> >>  }
> >
> > Hello Hannes,
> >
> > I have already encountered a few times a deadlock that was caused by th=
e
> > event checking code so I agree with you that it would be a big step for=
ward
> > if such deadlocks wouldn't occur anymore. However, this patch realizes =
a
> > change that has not been described in the patch description, namely tha=
t
> > disk_block_events() calls are no longer serialized. Are you sure it is =
safe
> > to drop the serialization of disk_block_events() calls?
> >
> Well, this whole synchronization stuff it a bit weird; I so totally fail
> to see the rationale for it.
> But anyway, once we've converted ev->block to atomics I _think_ the
> mutex_lock can remain; will be checking.
>=20
> Cheers,
>=20
> Hannes
> --

Hi, I think I got the same calltrace with today's linux-next (next-20170203=
).

The issue happened every time when my Linux virtual machine booted and
Hannes's patch could NOT help.

The calltrace is pasted below.

Thanks,
-- Dexuan

[    9.718802] scsi host2: storvsc_host_t
[    9.723854] scsi 2:0:0:0: Direct-Access     Msft     Virtual Disk     1.=
0  PQ: 0 ANSI: 5
[    9.753161] sd 2:0:0:0: Attached scsi generic sg1 type 0
[    9.766383] scsi host3: storvsc_host_t
[    9.771759] scsi 3:0:0:0: Direct-Access     Msft     Virtual Disk     1.=
0  PQ: 0 ANSI: 5
[    9.781836] hv_utils: VSS IC version 5.0
[    9.822511] sd 3:0:0:0: Attached scsi generic sg2 type 0
[    9.829039] sd 3:0:0:0: [sdb] 266338304 512-byte logical blocks: (136 GB=
/127 GiB)
[    9.838525] sd 3:0:0:0: [sdb] 4096-byte physical blocks
[    9.845350] sd 3:0:0:0: [sdb] Write Protect is off
[    9.851077] sd 3:0:0:0: [sdb] Mode Sense: 0f 00 00 00
[    9.859765] sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    9.872728]  sdb: sdb1
[    9.877279] sd 3:0:0:0: [sdb] Attached SCSI disk
[    9.964093] psmouse serio1: trackpoint: failed to get extended button da=
ta
[   14.864110] psmouse serio1: trackpoint: IBM TrackPoint firmware: 0x01, b=
uttons: 0/0
[   14.876423] input: TPPS/2 IBM TrackPoint as /devices/platform/i8042/seri=
o1/input/input3
[   14.887216] input: AT Translated Set 2 keyboard as /devices/LNXSYSTM:00/=
LNXSYBUS:00/PNP0A03:00/device:07/VMBUS:01/d34b2567-b9b6-42b9-8778-0a4ec0b95=
5bf/serio2/input/input5
[   44.644061] random: crng init done
[   66.524169] hv_utils: KVP IC version 4.0
Begin: Loading essential drivers ... done.
Begin: Running /scripts/init-premount ... done.
Begin: Mounting root file system ... Begin: Running /scripts/local-top ... =
done.
Begin: Running /scripts/local-premount ... done.
Begin: Waiting for root file system ... Begin: Running /scripts/local-block=
 ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
[  242.652127] INFO: task systemd-udevd:183 blocked for more than 120 secon=
ds.
[  242.661008]       Not tainted 4.10.0-rc6-next-20170203+ #2
[  242.697270] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.
[  242.707872] systemd-udevd   D    0   183    170 0x00000004
[  242.714654] Call Trace:
[  242.717904]  __schedule+0x27d/0x8d0
[  242.724618]  schedule+0x36/0x80
[  242.729042]  schedule_timeout+0x235/0x3f0
[  242.736667]  ? sched_clock+0x9/0x10
[  242.741144]  ? try_to_wake_up+0x4a/0x460
[  242.745580]  wait_for_completion+0xa5/0x120
[  242.751417]  ? wake_up_q+0x70/0x70
[  242.759394]  flush_work+0x11a/0x1c0
[  242.764846]  ? worker_detach_from_pool+0xb0/0xb0
[  242.770943]  __cancel_work_timer+0xf3/0x1b0
[  242.776073]  ? disk_map_sector_rcu+0x70/0x70
[  242.783857]  cancel_delayed_work_sync+0x13/0x20
[  242.789438]  disk_block_events+0x34/0x40
[  242.794641]  __blkdev_get+0x10c/0x470
[  242.799227]  blkdev_get+0x11a/0x320
[  242.803161]  ? unlock_new_inode+0x49/0x80
[  242.807451]  ? bdget+0x110/0x130
[  242.811415]  blkdev_open+0x5b/0x70
[  242.820215]  do_dentry_open+0x208/0x310
[  242.825336]  ? blkdev_get_by_dev+0x50/0x50
[  242.836362]  vfs_open+0x4c/0x70
[  242.839839]  ? may_open+0x9b/0x100
[  242.843803]  path_openat+0x297/0x13e0
[  242.848410]  ? _copy_to_user+0x2e/0x40
[  242.852966]  ? move_addr_to_user+0xa3/0xc0
[  242.857961]  do_filp_open+0x7e/0xe0
[  242.862154]  ? _cond_resched+0x1a/0x50
[  242.867045]  ? kmem_cache_alloc+0x156/0x1b0
[  242.872004]  ? getname_flags+0x56/0x1f0
[  242.881609]  ? __alloc_fd+0x46/0x170
[  242.891812]  do_sys_open+0x11b/0x1f0
[  242.896506]  SyS_open+0x1e/0x20
[  242.900365]  entry_SYSCALL_64_fastpath+0x1e/0xad
[  242.905607] RIP: 0033:0x7efd3827aca0
[  242.909773] RSP: 002b:00007ffd7ceaeb38 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000002
[  242.918778] RAX: ffffffffffffffda RBX: 0000555fdf1a2d40 RCX: 00007efd382=
7aca0
[  242.925725] RDX: 0000555fde106058 RSI: 00000000000a0800 RDI: 0000555fdf1=
a2ff0
[  242.929715] RBP: 0000000000000000 R08: 0000000000000073 R09: 00000000000=
00003
[  242.933921] R10: 00007efd37fe6520 R11: 0000000000000246 R12: 00000000000=
00000
[  242.942260] R13: 0000555fdf1a2d40 R14: 00007ffd7ceaea00 R15: 00000000000=
00000
[  242.952780] INFO: task systemd-udevd:191 blocked for more than 120 secon=
ds.
[  242.960994]       Not tainted 4.10.0-rc6-next-20170203+ #2
[  242.966936] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.
[  242.975395] systemd-udevd   D    0   191    170 0x00000004
[  242.983460] Call Trace:
[  242.986694]  __schedule+0x27d/0x8d0
[  242.992603]  ? mutex_lock+0x12/0x40
[  242.996467]  ? kprobes_module_callback+0x15b/0x1d0
[  243.001934]  schedule+0x36/0x80
[  243.005908]  async_synchronize_cookie_domain+0x91/0x130
[  243.012331]  ? wake_atomic_t_function+0x60/0x60
[  243.017690]  async_synchronize_full+0x17/0x20
[  243.022662]  do_init_module+0xc1/0x1ff
[  243.026965]  load_module+0x2313/0x29a0
[  243.031232]  ? __symbol_put+0x40/0x40
[  243.035347]  ? security_kernel_post_read_file+0x6b/0x80
[  243.042541]  SYSC_finit_module+0xbc/0xf0
[  243.045130]  SyS_finit_module+0xe/0x10
[  243.049116]  entry_SYSCALL_64_fastpath+0x1e/0xad
[  243.054517] RIP: 0033:0x7efd37fa1c19
[  243.058744] RSP: 002b:00007ffd7ceae188 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000139
[  243.067483] RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007efd37f=
a1c19
[  243.075801] RDX: 0000000000000000 RSI: 00007efd38497e2a RDI: 00000000000=
0000c
[  243.084162] RBP: 00007ffd7cead190 R08: 0000000000000000 R09: 00000000000=
00000
[  243.093738] R10: 000000000000000c R11: 0000000000000246 R12: 0000555fdf1=
a3300
[  243.103158] R13: 00007ffd7cead170 R14: 0000000000000005 R15: 000000000ab=
a9500
[  363.484110] INFO: task systemd-udevd:183 blocked for more than 120 secon=
ds.
[  363.493200]       Not tainted 4.10.0-rc6-next-20170203+ #2
[  363.500109] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.
[  363.509635] systemd-udevd   D    0   183    170 0x00000004
[  363.516428] Call Trace:
[  363.519492]  __schedule+0x27d/0x8d0
[  363.523850]  schedule+0x36/0x80
[  363.529927]  schedule_timeout+0x235/0x3f0
[  363.534884]  ? sched_clock+0x9/0x10
[  363.539006]  ? try_to_wake_up+0x4a/0x460
[  363.543686]  wait_for_completion+0xa5/0x120
[  363.548831]  ? wake_up_q+0x70/0x70
[  363.552993]  flush_work+0x11a/0x1c0
[  363.557236]  ? worker_detach_from_pool+0xb0/0xb0
[  363.562851]  __cancel_work_timer+0xf3/0x1b0
[  363.567942]  ? disk_map_sector_rcu+0x70/0x70
[  363.572973]  cancel_delayed_work_sync+0x13/0x20
[  363.580271]  disk_block_events+0x34/0x40
[  363.585284]  __blkdev_get+0x10c/0x470
[  363.589774]  blkdev_get+0x11a/0x320
[  363.593851]  ? unlock_new_inode+0x49/0x80
[  363.598509]  ? bdget+0x110/0x130
[  363.602272]  blkdev_open+0x5b/0x70
[  363.606254]  do_dentry_open+0x208/0x310
[  363.610722]  ? blkdev_get_by_dev+0x50/0x50
[  363.615493]  vfs_open+0x4c/0x70
[  363.619287]  ? may_open+0x9b/0x100
[  363.623386]  path_openat+0x297/0x13e0
[  363.627752]  ? _copy_to_user+0x2e/0x40
[  363.633978]  ? move_addr_to_user+0xa3/0xc0
[  363.638833]  do_filp_open+0x7e/0xe0
[  363.642809]  ? _cond_resched+0x1a/0x50
[  363.647070]  ? kmem_cache_alloc+0x156/0x1b0
[  363.651785]  ? getname_flags+0x56/0x1f0
[  363.656285]  ? __alloc_fd+0x46/0x170
[  363.660490]  do_sys_open+0x11b/0x1f0
[  363.664655]  SyS_open+0x1e/0x20
[  363.668405]  entry_SYSCALL_64_fastpath+0x1e/0xad
[  363.674075] RIP: 0033:0x7efd3827aca0
[  363.678582] RSP: 002b:00007ffd7ceaeb38 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000002
[  363.689873] RAX: ffffffffffffffda RBX: 0000555fdf1a2d40 RCX: 00007efd382=
7aca0
[  363.698127] RDX: 0000555fde106058 RSI: 00000000000a0800 RDI: 0000555fdf1=
a2ff0
[  363.706494] RBP: 0000000000000000 R08: 0000000000000073 R09: 00000000000=
00003
[  363.714696] R10: 00007efd37fe6520 R11: 0000000000000246 R12: 00000000000=
00000
[  363.722922] R13: 0000555fdf1a2d40 R14: 00007ffd7ceaea00 R15: 00000000000=
00000
[  363.731123] INFO: task systemd-udevd:191 blocked for more than 120 secon=
ds.
[  363.739454]       Not tainted 4.10.0-rc6-next-20170203+ #2
[  363.745246] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.
[  363.753890] systemd-udevd   D    0   191    170 0x00000004
[  363.760085] Call Trace:
[  363.763006]  __schedule+0x27d/0x8d0
[  363.767016]  ? mutex_lock+0x12/0x40
[  363.770943]  ? kprobes_module_callback+0x15b/0x1d0
[  363.780593]  schedule+0x36/0x80
[  363.785119]  async_synchronize_cookie_domain+0x91/0x130
[  363.793021]  ? wake_atomic_t_function+0x60/0x60
[  363.798351]  async_synchronize_full+0x17/0x20
[  363.803405]  do_init_module+0xc1/0x1ff
[  363.807564]  load_module+0x2313/0x29a0
[  363.811786]  ? __symbol_put+0x40/0x40
[  363.815895]  ? security_kernel_post_read_file+0x6b/0x80
[  363.821852]  SYSC_finit_module+0xbc/0xf0
[  363.826433]  SyS_finit_module+0xe/0x10
[  363.830732]  entry_SYSCALL_64_fastpath+0x1e/0xad
[  363.836311] RIP: 0033:0x7efd37fa1c19
[  363.842740] RSP: 002b:00007ffd7ceae188 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000139
[  363.852003] RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007efd37f=
a1c19
[  363.860774] RDX: 0000000000000000 RSI: 00007efd38497e2a RDI: 00000000000=
0000c
[  363.869669] RBP: 00007ffd7cead190 R08: 0000000000000000 R09: 00000000000=
00000
[  363.878494] R10: 000000000000000c R11: 0000000000000246 R12: 0000555fdf1=
a3300
[  363.887931] R13: 00007ffd7cead170 R14: 0000000000000005 R15: 000000000ab=
a9500
[  484.316121] INFO: task systemd-udevd:183 blocked for more than 120 secon=
ds.
[  484.327141]       Not tainted 4.10.0-rc6-next-20170203+ #2
[  484.333747] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.
[  484.342486] systemd-udevd   D    0   183    170 0x00000004
[  484.348790] Call Trace:
[  484.351712]  __schedule+0x27d/0x8d0
[  484.355904]  schedule+0x36/0x80
[  484.359718]  schedule_timeout+0x235/0x3f0
[  484.364932]  ? sched_clock+0x9/0x10
[  484.368892]  ? try_to_wake_up+0x4a/0x460
[  484.376582]  wait_for_completion+0xa5/0x120
[  484.383779]  ? wake_up_q+0x70/0x70
[  484.389885]  flush_work+0x11a/0x1c0
[  484.394048]  ? worker_detach_from_pool+0xb0/0xb0
[  484.399464]  __cancel_work_timer+0xf3/0x1b0
[  484.404326]  ? disk_map_sector_rcu+0x70/0x70
[  484.409379]  cancel_delayed_work_sync+0x13/0x20
[  484.414449]  disk_block_events+0x34/0x40
[  484.418615]  __blkdev_get+0x10c/0x470
[  484.423391]  blkdev_get+0x11a/0x320
[  484.429312]  ? unlock_new_inode+0x49/0x80
[  484.433618]  ? bdget+0x110/0x130
[  484.437300]  blkdev_open+0x5b/0x70
[  484.441376]  do_dentry_open+0x208/0x310
[  484.446108]  ? blkdev_get_by_dev+0x50/0x50
[  484.450946]  vfs_open+0x4c/0x70
[  484.454693]  ? may_open+0x9b/0x100
[  484.458682]  path_openat+0x297/0x13e0
[  484.462656]  ? _copy_to_user+0x2e/0x40
[  484.467125]  ? move_addr_to_user+0xa3/0xc0
[  484.472370]  do_filp_open+0x7e/0xe0
[  484.479195]  ? _cond_resched+0x1a/0x50
[  484.484027]  ? kmem_cache_alloc+0x156/0x1b0
[  484.488851]  ? getname_flags+0x56/0x1f0
[  484.493049]  ? __alloc_fd+0x46/0x170
[  484.496899]  do_sys_open+0x11b/0x1f0
[  484.500784]  SyS_open+0x1e/0x20
[  484.504284]  entry_SYSCALL_64_fastpath+0x1e/0xad
[  484.510767] RIP: 0033:0x7efd3827aca0
[  484.515460] RSP: 002b:00007ffd7ceaeb38 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000002
[  484.527246] RAX: ffffffffffffffda RBX: 0000555fdf1a2d40 RCX: 00007efd382=
7aca0
[  484.537307] RDX: 0000555fde106058 RSI: 00000000000a0800 RDI: 0000555fdf1=
a2ff0
[  484.545620] RBP: 0000000000000000 R08: 0000000000000073 R09: 00000000000=
00003
[  484.554372] R10: 00007efd37fe6520 R11: 0000000000000246 R12: 00000000000=
00000
[  484.563267] R13: 0000555fdf1a2d40 R14: 00007ffd7ceaea00 R15: 00000000000=
00000
[  484.571966] INFO: task systemd-udevd:191 blocked for more than 120 secon=
ds.
[  484.580711]       Not tainted 4.10.0-rc6-next-20170203+ #2
[  484.589555] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.
[  484.598799] systemd-udevd   D    0   191    170 0x00000004
[  484.605231] Call Trace:
[  484.608308]  __schedule+0x27d/0x8d0
[  484.612702]  ? mutex_lock+0x12/0x40
[  484.617071]  ? kprobes_module_callback+0x15b/0x1d0
[  484.621625]  schedule+0x36/0x80
[  484.623511]  async_synchronize_cookie_domain+0x91/0x130
[  484.626443]  ? wake_atomic_t_function+0x60/0x60
[  484.629059]  async_synchronize_full+0x17/0x20
[  484.635723]  do_init_module+0xc1/0x1ff
[  484.640226]  load_module+0x2313/0x29a0
[  484.645030]  ? __symbol_put+0x40/0x40
[  484.649870]  ? security_kernel_post_read_file+0x6b/0x80
[  484.658016]  SYSC_finit_module+0xbc/0xf0
[  484.662676]  SyS_finit_module+0xe/0x10
[  484.667374]  entry_SYSCALL_64_fastpath+0x1e/0xad
[  484.673822] RIP: 0033:0x7efd37fa1c19
[  484.677771] RSP: 002b:00007ffd7ceae188 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000139
[  484.688668] RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007efd37f=
a1c19
[  484.697959] RDX: 0000000000000000 RSI: 00007efd38497e2a RDI: 00000000000=
0000c
[  484.707793] RBP: 00007ffd7cead190 R08: 0000000000000000 R09: 00000000000=
00000
[  484.716695] R10: 000000000000000c R11: 0000000000000246 R12: 0000555fdf1=
a3300
[  484.724415] R13: 00007ffd7cead170 R14: 0000000000000005 R15: 000000000ab=
a9500
