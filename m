Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: BUG: unable to handle kernel NULL pointer dereference at
 0000000000000436
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20180112041811.GA29400@ming.t460p>
Date: Fri, 12 Jan 2018 09:29:54 +0100
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block <linux-block@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Mark Brown <broonie@kernel.org>
Message-Id: <3DF9FFFB-32CF-48E9-BCCB-B4CF3A226A81@linaro.org>
References: <20180110045852.GC18922@ming.t460p>
 <05F944A5-7FD0-481E-8B4A-2D1A9E6C0AC0@linaro.org>
 <B160CE4E-F068-48E5-93C5-C6182C8E4782@linaro.org>
 <ad7b20ae-0437-54b0-eca0-1a4d52c677eb@kernel.dk>
 <20180112041811.GA29400@ming.t460p>
To: Ming Lei <ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 12 gen 2018, alle ore 05:18, Ming Lei <ming.lei@redhat.com> =
ha scritto:
>=20
> On Thu, Jan 11, 2018 at 08:40:54AM -0700, Jens Axboe wrote:
>> On 1/11/18 2:41 AM, Paolo Valente wrote:
>>>=20
>>>=20
>>>> Il giorno 11 gen 2018, alle ore 10:30, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>>>>=20
>>>>=20
>>>>=20
>>>>> Il giorno 10 gen 2018, alle ore 05:58, Ming Lei =
<ming.lei@redhat.com> ha scritto:
>>>>>=20
>>>>> Hi Paolo,
>>>>>=20
>>>>> Looks this one is introduced in recent merge, and it is triggered
>>>>> in test of IO vs. removing device on the latest for-next of block
>>>>> tree:
>>>>>=20
>>>>> [  296.151615] BUG: unable to handle kernel NULL pointer =
dereference at 0000000000000436
>>>>> [  296.152302] IP: percpu_counter_add_batch+0x25/0x9d
>>>>> [  296.152698] PGD 0 P4D 0
>>>>> [  296.152916] Oops: 0000 [#1] PREEMPT SMP
>>>>> [  296.153233] Dumping ftrace buffer:
>>>>> [  296.153517]    (ftrace buffer empty)
>>>>> [  296.153817] Modules linked in: scsi_debug(E) null_blk(E) =
isofs(E) iTCO_wdt(E) iTCO_vendor_support(E) i2c_i801(E) i2c_core(E) =
lpc_ich(E) mfd_core(E) ip_tables(E) sr_mod(E) cdrom(E) sd_mod(E) =
usb_storage(E) ahci(E) libahci(E) libata(E) crc32c_intel(E) =
virtio_scsi(E) qemu_fw_cfg(E) dm_mirror(E) dm_region_hash(E) dm_log(E) =
dm_mod(E) [last unloaded: scsi_debug]
>>>>> [  296.156199] CPU: 2 PID: 2001 Comm: scsi_id Tainted: G           =
 E    4.15.0-rc7790529290ab3_my_v4.15-rc-block-for-next #4
>>>>> [  296.156961] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 1.9.3-1.fc25 04/01/2014
>>>>> [  296.157546] RIP: 0010:percpu_counter_add_batch+0x25/0x9d
>>>>> [  296.157920] RSP: 0018:ffffc90001133b28 EFLAGS: 00010002
>>>>> [  296.158285] RAX: 0000000000000002 RBX: ffffffffffffff6e RCX: =
0000000000000001
>>>>> [  296.158779] RDX: 000000003fffffff RSI: ffffffff81e95429 RDI: =
ffffffff81e5e64c
>>>>> [  296.159276] RBP: 0000000000000416 R08: 0000000000000001 R09: =
0000000000000001
>>>>> [  296.159770] R10: ffffc90001133aa0 R11: ffff88007e96caf0 R12: =
000000003fffffff
>>>>> [  296.160273] R13: 0000000000000001 R14: 0000000000000001 R15: =
ffffe8ffffd0b180
>>>>> [  296.160780] FS:  00007f635988af80(0000) =
GS:ffff88007cf00000(0000) knlGS:0000000000000000
>>>>> [  296.161325] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> [  296.161744] CR2: 0000000000000436 CR3: 00000000717f1005 CR4: =
00000000003606e0
>>>>> [  296.162258] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
>>>>> [  296.162764] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
>>>>> [  296.163246] Call Trace:
>>>>> [  296.163445]  bfqg_stats_update_io_add+0x35/0xdc
>>>>> [  296.163754]  bfq_insert_requests+0xbb9/0xbf2
>>>>> [  296.164049]  ? blk_rq_bio_prep+0x51/0x5d
>>>>> [  296.164353]  ? blk_rq_append_bio+0x32/0x78
>>>>> [  296.164633]  ? blk_rq_map_user_iov+0x11b/0x1a0
>>>>> [  296.164940]  blk_mq_sched_insert_request+0xaf/0x12f
>>>>> [  296.165273]  blk_execute_rq+0x4b/0x93
>>>>> [  296.165586]  sg_io+0x236/0x38a
>>>>> [  296.165800]  scsi_cmd_ioctl+0x1d4/0x381
>>>>> [  296.166065]  ? seccomp_run_filters+0xee/0x12d
>>>>> [  296.166362]  ? preempt_count_add+0x6d/0x8c
>>>>> [  296.166643]  sd_ioctl+0xbb/0xde [sd_mod]
>>>>> [  296.166915]  blkdev_ioctl+0x7f2/0x850
>>>>> [  296.167167]  block_ioctl+0x39/0x3c
>>>>> [  296.167401]  vfs_ioctl+0x1b/0x28
>>>>> [  296.167622]  do_vfs_ioctl+0x4bc/0x542
>>>>> [  296.167877]  ? syscall_trace_enter+0x164/0x261
>>>>> [  296.168180]  SyS_ioctl+0x3e/0x5a
>>>>> [  296.168402]  do_syscall_64+0x71/0x168
>>>>> [  296.168654]  entry_SYSCALL64_slow_path+0x25/0x25
>>>>> [  296.168970] RIP: 0033:0x7f63593a1dc7
>>>>> [  296.169214] RSP: 002b:00007fff87210878 EFLAGS: 00000246 =
ORIG_RAX: 0000000000000010
>>>>> [  296.169823] RAX: ffffffffffffffda RBX: 00007fff872108b0 RCX: =
00007f63593a1dc7
>>>>> [  296.170303] RDX: 00007fff872108b0 RSI: 0000000000002285 RDI: =
0000000000000004
>>>>> [  296.170783] RBP: 00007fff87210f00 R08: 0000000000002006 R09: =
00000000fffffe00
>>>>> [  296.171266] R10: 00007fff87210910 R11: 0000000000000246 R12: =
00000000ffffffff
>>>>> [  296.171745] R13: 00007fff872108b0 R14: 00007fff872108ba R15: =
00007fff872112b0
>>>>> [  296.172228] Code: 5d 41 5c 41 5d c3 41 55 41 54 49 89 f5 55 53 =
48 89 fd bf 01 00 00 00 41 89 d4 e8 8c 19 d4 ff 48 c7 c7 29 54 e9 81 e8 =
fd 3d ff ff <48> 8b 45 20 49 63 d4 65 8b 18 48 63 db 4c 01 eb 48 39 d3 =
7d 0b
>>>>> [  296.173594] RIP: percpu_counter_add_batch+0x25/0x9d RSP: =
ffffc90001133b28
>>>>> [  296.174054] CR2: 0000000000000436
>>>>> [  296.174283] ---[ end trace 87b58f9235daac7e ]---
>>>>> [  296.174673] Kernel panic - not syncing: Fatal exception
>>>>> [  297.270432] Shutting down cpus with NMI
>>>>> [  297.271020] Dumping ftrace buffer:
>>>>> [  297.271262]    (ftrace buffer empty)
>>>>> [  297.271513] Kernel Offset: disabled
>>>>> [  297.271760] ---[ end Kernel panic - not syncing: Fatal =
exception
>>>>>=20
>>>>=20
>>>> Well, then don't do it! :)
>>>>=20
>>>> Jokes aside, I've been trying to reproduce this failure, with a USB
>>>> drive, but at no avail. With a just-pulled for-next, after entering
>>>>=20
>>>> echo bfq | sudo tee /sys/block/sdc/queue/scheduler && sudo dd =
if=3D/dev/zero of=3D/dev/sdc
>>>>=20
>>>> I've tried both a:
>>>>=20
>>>> echo 1 > /sys/block/sdc/device/delete
>>>>=20
>>>> and a physical unplug of the USB stick.
>>>>=20
>>>=20
>>> Just tried with reads from the USB drive too, and with an internal
>>> HDD.  Same outcome: no failure.
>>=20
>> Are you regularly running blktests on bfq as part of your testing? If
>> not, you definitely should. There are some good torture removal tests
>> there. If that isn't what Ming is running, Ming should submit his
>> test to blktests so we can get better coverage.
>>=20
>> https://github.com/osandov/blktests
>=20
> block/001 just stresses scsi_debug delete, but not running background =
IO
> meantime. I will add that in block/001.
>=20
> Paolo, please try the attached script, and pass 21 to it. And the =
issue
> should be triggered in one or several times.
>=20

Thanks Ming.  I'm afraid I might have hit a bug in scsi_debug, which
makes it impossible for me to repeat your test.

The command in your script
modprobe scsi_debug virtual_gb=3D128 max_luns=3D$COUNT =
ndelay=3D$SCSI_DBG_NDELAY max_queue=3D$CAN_QUEUE
(with COUNT=3D21, SCSI_DBG_NDELAY=3D10000, CAN_QUEUE=3D110)
hangs forever.

I have checked whether it creates devices, and it does (although
apparently slowly), but then it blocks in D+ state.  Am I doing
something wrong?  Otherwise, if there's something I can do to help
debug this, I'm willing to.

Thanks,
Paolo

> --=20
> Ming
> <scsi-stress-remove.txt>
