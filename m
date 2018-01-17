Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1516155470.3179.6.camel@wdc.com>
References: <20180116181752.25847-1-bart.vanassche@wdc.com>
 <20180116181752.25847-4-bart.vanassche@wdc.com> <20180116223207.GA32637@redhat.com>
 <1516147421.2844.70.camel@wdc.com> <CACVXFVMtUq8Mru8f7AD+6rQch+59=yRNL0-xOc4k7mmp4VanpA@mail.gmail.com>
 <1516155470.3179.6.camel@wdc.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 17 Jan 2018 21:04:26 +0800
Message-ID: <CACVXFVNMkdyudH7VhpiAJbofx8pb8-+Qb86V9vXLyNAijxYvpw@mail.gmail.com>
Subject: Re: [PATCH 3/3] block: Protect less code with sysfs_lock in blk_{un,}register_queue()
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"snitzer@redhat.com" <snitzer@redhat.com>, "axboe@kernel.dk" <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Wed, Jan 17, 2018 at 10:17 AM, Bart Van Assche
<Bart.VanAssche@wdc.com> wrote:
> On Wed, 2018-01-17 at 09:23 +0800, Ming Lei wrote:
>> On Wed, Jan 17, 2018 at 8:03 AM, Bart Van Assche <Bart.VanAssche@wdc.com> wrote:
>> > On Tue, 2018-01-16 at 17:32 -0500, Mike Snitzer wrote:
>> > > Therefore it seems to me that all queue_attr_{show,store} are racey vs
>> > > blk_unregister_queue() removing the 'queue' kobject.
>> > >
>> > > And it was just that __elevator_change() was myopicly fixed to address
>> > > the race whereas a more generic solution was/is needed.  But short of
>> > > that more generic fix your change will reintroduce the potential for
>> > > hitting the issue that commit e9a823fb34a8b fixed.
>> > >
>> > > In that light, think it best to leave blk_unregister_queue()'s
>> > > mutex_lock() above the QUEUE_FLAG_REGISTERED clearing _and_ update
>> > > queue_attr_{show,store} to test for QUEUE_FLAG_REGISTERED while holding
>> > > sysfs_lock.
>> > >
>> > > Then remove the unicorn test_bit for QUEUE_FLAG_REGISTERED from
>> > > __elevator_change().
>> >
>> > Thanks Mike for the feedback. However, I think a simpler approach exists than
>> > what has been described above, namely by unregistering the sysfs attributes
>> > earlier. How about the patch below?
>> >
>> > [PATCH] block: Protect less code with sysfs_lock in blk_{un,}register_queue()
>> > ---
>> >  block/blk-sysfs.c | 39 ++++++++++++++++++++++++++-------------
>> >  block/elevator.c  |  4 ----
>> >  2 files changed, 26 insertions(+), 17 deletions(-)
>> >
>> > diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>> > index 4a6a40ffd78e..ce32366c6db7 100644
>> > --- a/block/blk-sysfs.c
>> > +++ b/block/blk-sysfs.c
>> > @@ -853,6 +853,10 @@ struct kobj_type blk_queue_ktype = {
>> >         .release        = blk_release_queue,
>> >  };
>> >
>> > +/**
>> > + * blk_register_queue - register a block layer queue with sysfs
>> > + * @disk: Disk of which the request queue should be registered with sysfs.
>> > + */
>> >  int blk_register_queue(struct gendisk *disk)
>> >  {
>> >         int ret;
>> > @@ -909,11 +913,12 @@ int blk_register_queue(struct gendisk *disk)
>> >         if (q->request_fn || (q->mq_ops && q->elevator)) {
>> >                 ret = elv_register_queue(q);
>> >                 if (ret) {
>> > +                       mutex_unlock(&q->sysfs_lock);
>> >                         kobject_uevent(&q->kobj, KOBJ_REMOVE);
>> >                         kobject_del(&q->kobj);
>> >                         blk_trace_remove_sysfs(dev);
>> >                         kobject_put(&dev->kobj);
>> > -                       goto unlock;
>> > +                       return ret;
>> >                 }
>> >         }
>> >         ret = 0;
>> > @@ -923,6 +928,13 @@ int blk_register_queue(struct gendisk *disk)
>> >  }
>> >  EXPORT_SYMBOL_GPL(blk_register_queue);
>> >
>> > +/**
>> > + * blk_unregister_queue - counterpart of blk_register_queue()
>> > + * @disk: Disk of which the request queue should be unregistered from sysfs.
>> > + *
>> > + * Note: the caller is responsible for guaranteeing that this function is called
>> > + * after blk_register_queue() has finished.
>> > + */
>> >  void blk_unregister_queue(struct gendisk *disk)
>> >  {
>> >         struct request_queue *q = disk->queue;
>> > @@ -934,28 +946,29 @@ void blk_unregister_queue(struct gendisk *disk)
>> >         if (!test_bit(QUEUE_FLAG_REGISTERED, &q->queue_flags))
>> >                 return;
>> >
>> > -       /*
>> > -        * Protect against the 'queue' kobj being accessed
>> > -        * while/after it is removed.
>> > -        */
>> > -       mutex_lock(&q->sysfs_lock);
>> > -
>> >         spin_lock_irq(q->queue_lock);
>> >         queue_flag_clear(QUEUE_FLAG_REGISTERED, q);
>> >         spin_unlock_irq(q->queue_lock);
>> >
>> > -       wbt_exit(q);
>> > -
>> > +       /*
>> > +        * Remove the sysfs attributes before unregistering the queue data
>> > +        * structures that can be modified through sysfs.
>> > +        */
>> > +       mutex_lock(&q->sysfs_lock);
>> >         if (q->mq_ops)
>> >                 blk_mq_unregister_dev(disk_to_dev(disk), q);
>> > -
>> > -       if (q->request_fn || (q->mq_ops && q->elevator))
>> > -               elv_unregister_queue(q);
>> > +       mutex_unlock(&q->sysfs_lock);
>> >
>> >         kobject_uevent(&q->kobj, KOBJ_REMOVE);
>> >         kobject_del(&q->kobj);
>>
>> elevator switch still can come just after the above line code is completed,
>> so the previous warning addressed in e9a823fb34a8b can be triggered
>> again.
>>
>> >         blk_trace_remove_sysfs(disk_to_dev(disk));
>> > -       kobject_put(&disk_to_dev(disk)->kobj);
>> >
>> > +       wbt_exit(q);
>> > +
>> > +       mutex_lock(&q->sysfs_lock);
>> > +       if (q->request_fn || (q->mq_ops && q->elevator))
>> > +               elv_unregister_queue(q);
>> >         mutex_unlock(&q->sysfs_lock);
>> > +
>> > +       kobject_put(&disk_to_dev(disk)->kobj);
>> >  }
>> > diff --git a/block/elevator.c b/block/elevator.c
>> > index e87e9b43aba0..4b7957b28a99 100644
>> > --- a/block/elevator.c
>> > +++ b/block/elevator.c
>> > @@ -1080,10 +1080,6 @@ static int __elevator_change(struct request_queue *q, const char *name)
>> >         char elevator_name[ELV_NAME_MAX];
>> >         struct elevator_type *e;
>> >
>> > -       /* Make sure queue is not in the middle of being removed */
>> > -       if (!test_bit(QUEUE_FLAG_REGISTERED, &q->queue_flags))
>> > -               return -ENOENT;
>> > -
>>
>> The above check shouldn't be removed, as I explained above.
>
> Hello Ming,
>
> Sorry but I think what you wrote is wrong. kobject_del(&q->kobj) waits until all
> ongoing sysfs callback methods, including elv_iosched_store(), have finished and
> prevents that any new elv_iosched_store() calls start. That is why I think the
> above changes do not reintroduce the race fixed by commit e9a823fb34a8 ("block:
> fix warning when I/O elevator is changed as request_queue is being removed").

But your patch basically reverts commit e9a823fb34a8, and I just saw the warning
again after applying your patch in my stress test of switching elelvato:

[  225.999503] ------------[ cut here ]------------
[  225.999505] kobject_add_internal failed for iosched (error: -2 parent: queue)
[  225.999521] WARNING: CPU: 0 PID: 12707 at lib/kobject.c:244
kobject_add_internal+0x236/0x24c
[  225.999522] Modules linked in: scsi_debug ebtable_filter ebtables
ip6table_filter ip6_tables xt_CHECKSUM iptable_mangle ipt_MASQUERADE
nf_nat_masquerade_ipv4 iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4
nf_nat_ipv4 nf_nat nf_conntrack libcrc32c bridge stp llc fuse
iptable_filter ip_tables sd_mod sg sdhci_pci sdhci bcache usb_storage
crc32c_intel mmc_core ahci lpc_ich mfd_core virtio_scsi libahci libata
nvme shpchp qemu_fw_cfg nvme_core binfmt_misc dm_mod iscsi_tcp
libiscsi_tcp libiscsi scsi_transport_iscsi null_blk configs [last
unloaded: scsi_debug]
[  225.999551] CPU: 0 PID: 12707 Comm: elv-switch Tainted: G        W
      4.15.0-rc7+ #119
[  225.999552] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.9.3-1.fc25 04/01/2014
[  225.999554] RIP: 0010:kobject_add_internal+0x236/0x24c
[  225.999555] RSP: 0018:ffffc900012bfca8 EFLAGS: 00010286
[  225.999556] RAX: 0000000000000000 RBX: ffff88016ec23010 RCX: 0000000000000001
[  225.999556] RDX: 0000000000000000 RSI: ffffffff81e545b2 RDI: 00000000ffffffff
[  225.999557] RBP: ffff880178f8e6a8 R08: 00000047c13e75ba R09: ffffffff8275daf0
[  225.999560] R10: ffffc900012bfd60 R11: ffffffff826e3fb1 R12: 00000000fffffffe
[  225.999560] R13: ffff880178f8e6a8 R14: 0000000000000006 R15: ffff880178f8e4e0
[  225.999561] FS:  00007fcd1445a700(0000) GS:ffff88017bc00000(0000)
knlGS:0000000000000000
[  225.999562] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  225.999563] CR2: 00007f623847a750 CR3: 0000000279974001 CR4: 00000000003606f0
[  225.999565] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  225.999565] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  225.999566] Call Trace:
[  225.999570]  kobject_add+0x9e/0xc5
[  225.999573]  elv_register_queue+0x35/0xa2
[  225.999575]  elevator_switch+0x7a/0x1a4
[  225.999577]  elv_iosched_store+0xd2/0x103
[  225.999579]  queue_attr_store+0x66/0x82
[  225.999581]  kernfs_fop_write+0xf3/0x135
[  225.999583]  __vfs_write+0x31/0x142
[  225.999585]  ? _raw_spin_unlock+0x16/0x27
[  225.999586]  ? __alloc_fd+0x147/0x159
[  225.999588]  ? preempt_count_add+0x6d/0x8c
[  225.999589]  ? preempt_count_add+0x7a/0x8c
[  225.999590]  ? _raw_spin_lock+0x13/0x30
[  225.999591]  vfs_write+0xcb/0x16e
[  225.999593]  SyS_write+0x5d/0xab
[  225.999595]  entry_SYSCALL_64_fastpath+0x1a/0x7d
[  225.999597] RIP: 0033:0x7fcd13f76a10
[  225.999597] RSP: 002b:00007fffd6b565c8 EFLAGS: 00000246
[  225.999599] Code: eb 31 48 85 ed 49 c7 c0 2f 5a ea 81 74 04 4c 8b
45 00 48 8b 13 44 89 e1 48 c7 c6 10 e5 cc 81 48 c7 c7 23 5b ea 81 e8
83 6b a7 ff <0f> ff eb 04 80 4b 3c 02 5b 44 89 e0 5d 41 5c 41 5d 41 5e
41 5f
[  225.999619] ---[ end trace 83f7e40aaf041cea ]---

-- 
Ming Lei
