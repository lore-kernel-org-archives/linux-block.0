Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [dm-devel] split scsi passthrough fields out of struct request
 V2
Date: Wed, 1 Feb 2017 17:28:02 +0000
Message-ID: <1485970063.2560.3.camel@sandisk.com>
References: <1485365126-23210-1-git-send-email-hch@lst.de>
	 <1485467235.2540.14.camel@sandisk.com>
	 <e1d5f4e6-c63f-545d-710f-d4d10fa8d2e0@fb.com>
	 <1485472465.2540.19.camel@sandisk.com>
	 <e222c541-3239-104d-e0b0-40d19b012b66@fb.com>
	 <1485474426.2540.25.camel@sandisk.com>
	 <b98195e7-6e04-5a59-8b83-ce2e1c5c4e1a@fb.com>
	 <1485477510.2540.27.camel@sandisk.com>
	 <2d971693-b79d-c1b9-fb2a-f5dd04128c68@fb.com>
	 <1485479738.2540.30.camel@sandisk.com>
	 <ecca734c-7a9c-f060-9335-c2de089849c2@fb.com>
	 <37ab009a-bc2d-d2ae-a875-269ab563a430@fb.com>
	 <9cbf0ce5-ed79-0252-fd2d-34bebaafffa3@fb.com>
	 <1485535925.4267.1.camel@sandisk.com>
	 <2c696943-2a44-4f36-f0f8-0bebceb95a4a@fb.com>
	 <1485825148.2669.18.camel@sandisk.com>
	 <4D024E85-CDE7-4FB0-B8CA-F2B8C86CCFCB@kernel.dk>
	 <1485898487.3113.7.camel@sandisk.com> <1485899692.3113.9.camel@sandisk.com>
	 <2085a3e6-25fc-d104-35cb-38995d154fd2@kernel.dk>
	 <1485910862.3113.12.camel@sandisk.com>
	 <9198f024-9d55-3a28-9f77-ecbca42873b5@kernel.dk>
	 <1485967586.2560.1.camel@sandisk.com>
	 <7e963480-edf9-5687-25f3-83890373a26f@kernel.dk>
In-Reply-To: <7e963480-edf9-5687-25f3-83890373a26f@kernel.dk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On Wed, 2017-02-01 at 09:13 -0800, Jens Axboe wrote:
> On 02/01/2017 08:46 AM, Bart Van Assche wrote:
> > Thanks for having looked into this. However, after having pulled the la=
test
> > block for-next tree (dbb85b06229f) another lockup was triggered soon (0=
2-sq
> > is the name of a shell script of the srp-test suite):
> >=20
> > [  243.021265] sysrq: SysRq : Show Blocked State
> > [  243.021301]   task                        PC stack   pid father
> > [  243.022909] 02-sq           D    0 10864  10509 0x00000000
> > [  243.022933] Call Trace:
> > [  243.022956]  __schedule+0x2da/0xb00
> > [  243.022979]  schedule+0x38/0x90
> > [  243.023002]  blk_mq_freeze_queue_wait+0x51/0xa0
> > [  243.023025]  ? remove_wait_queue+0x70/0x70
> > [  243.023047]  blk_mq_freeze_queue+0x15/0x20
> > [  243.023070]  elevator_switch+0x24/0x220
> > [  243.023093]  __elevator_change+0xd3/0x110
> > [  243.023115]  elv_iosched_store+0x21/0x60
> > [  243.023140]  queue_attr_store+0x54/0x90
> > [  243.023164]  sysfs_kf_write+0x40/0x50
> > [  243.023188]  kernfs_fop_write+0x137/0x1c0
> > [  243.023214]  __vfs_write+0x23/0x140
> > [  243.023242]  ? rcu_read_lock_sched_held+0x45/0x80
> > [  243.023265]  ? rcu_sync_lockdep_assert+0x2a/0x50
> > [  243.023287]  ? __sb_start_write+0xde/0x200
> > [  243.023308]  ? vfs_write+0x190/0x1e0
> > [  243.023329]  vfs_write+0xc3/0x1e0
> > [  243.023351]  SyS_write+0x44/0xa0
> > [  243.023373]  entry_SYSCALL_64_fastpath+0x18/0xad
>=20
> So that's changing the elevator - did this happen while heavy IO was
> going to the drive, or was it idle?

Hello Jens,

The shell command that was used to set the elevator is the following
($realdev is a dm device):

echo none > /sys/class/block/$(basename "$realdev")/queue/scheduler

I'm not sure whether any I/O was ongoing when the scheduler was being
changed from "none" into "none". There are two other processes that got
stuck but running lsof against these processes did not reveal what block
device these two processes were trying to examine:

[  243.021672] systemd-udevd   D    0 10585    504 0x00000000
[  243.021700] Call Trace:
[  243.021726]  __schedule+0x2da/0xb00
[  243.021749]  schedule+0x38/0x90
[  243.021771]  schedule_timeout+0x2fe/0x640
[  243.021882]  io_schedule_timeout+0x9f/0x110
[  243.021930]  wait_on_page_bit_common+0x121/0x1e0
[  243.021977]  generic_file_read_iter+0x17c/0x790
[  243.022030]  blkdev_read_iter+0x30/0x40
[  243.022053]  __vfs_read+0xbb/0x130
[  243.022075]  vfs_read+0xa3/0x170
[  243.022098]  SyS_read+0x44/0xa0
[  243.022120]  entry_SYSCALL_64_fastpath+0x18/0xad
[  243.022298] systemd-udevd   D    0 10612    504 0x00000000
[  243.022320] Call Trace:
[  243.022341]  __schedule+0x2da/0xb00
[  243.022363]  schedule+0x38/0x90
[  243.022383]  schedule_timeout+0x2fe/0x640
[  243.022490]  io_schedule_timeout+0x9f/0x110
[  243.022543]  wait_on_page_bit_common+0x121/0x1e0
[  243.022595]  generic_file_read_iter+0x17c/0x790
[  243.022640]  blkdev_read_iter+0x30/0x40
[  243.022663]  __vfs_read+0xbb/0x130
[  243.022685]  vfs_read+0xa3/0x170
[  243.022707]  SyS_read+0x44/0xa0
[  243.022729]  entry_SYSCALL_64_fastpath+0x18/0xad

# lsof -p10585
COMMAND =A0=A0=A0=A0PID USER =A0=A0FD =A0=A0=A0=A0=A0TYPE DEVICE SIZE/OFF N=
ODE NAME
systemd-u 10585 root =A0cwd =A0=A0unknown =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/proc/10585/cwd (readlink: No such file or di=
rectory)
systemd-u 10585 root =A0rtd =A0=A0unknown =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/proc/10585/root (readlink: No such file or d=
irectory)
systemd-u 10585 root =A0txt =A0=A0unknown =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/proc/10585/exe
# lsof -p10612
COMMAND =A0=A0=A0=A0PID USER =A0=A0FD =A0=A0=A0=A0=A0TYPE DEVICE SIZE/OFF N=
ODE NAME
systemd-u 10612 root =A0cwd =A0=A0unknown =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/proc/10612/cwd (readlink: No such file or di=
rectory)
systemd-u 10612 root =A0rtd =A0=A0unknown =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/proc/10612/root (readlink: No such file or d=
irectory)
systemd-u 10612 root =A0txt =A0=A0unknown =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/proc/10612/exe

Bart.=
