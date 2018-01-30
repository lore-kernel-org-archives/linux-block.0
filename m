Return-Path: <oleksandr@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 30 Jan 2018 09:05:26 +0100
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: paolo.valente@linaro.org
Cc: Ivan Kozik <ivan@ludios.org>, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 bfq-iosched@googlegroups.com, Jens Axboe <axboe@kernel.dk>,
 linus.walleij@linaro.org
Subject: v4.15 and I/O hang with BFQ
Message-ID: <9ad0d544ab2b12f87f44eb4ef88e23a2@natalenko.name>
List-ID: <linux-block@vger.kernel.org>

Hi, Paolo, Ivan, Ming et al.

It looks like I've just encountered the issue Ivan has already described 
in [1]. Since I'm able to reproduce it reliably in a VM, I'd like to 
draw more attention to it.

First, I'm using v4.15 kernel with all pending BFQ fixes:

===
2ad909a300c4 bfq-iosched: don't call bfqg_and_blkg_put for 
!CONFIG_BFQ_GROUP_IOSCHED
83c97a310f83 block, bfq: release oom-queue ref to root group on exit
5b9eb4716af1 block, bfq: put async queues for root bfq groups too
3c5529454a27 block, bfq: limit sectors served with interactive weight 
raising
e6c72be3486b block, bfq: limit tags for writes and async I/O
e579b91d96ce block, bfq: increase threshold to deem I/O as random
f6cbc16aac88 block, bfq: remove superfluous check in queue-merging setup
8045d8575183 block, bfq: let a queue be merged only shortly after 
starting I/O
242954975f5e block, bfq: check low_latency flag in bfq_bfqq_save_state()
8349c1bddd95 block, bfq: add missing rq_pos_tree update on rq removal
558200440cb9 block, bfq: fix occurrences of request finish method's old 
name
6ed2f47ee870 block, bfq: consider also past I/O in soft real-time 
detection
e5f295dd18f2 block, bfq: remove batches of confusing ifdefs
===

Next, I boot an Arch VM with this kernel and emulated USB stick 
attached:

===
qemu-system-x86_64 -display gtk,gl=on -machine q35,accel=kvm -cpu 
host,+vmx -enable-kvm -drive 
if=pflash,format=raw,readonly,file=/mnt/vms/ovmf/code.img -drive 
if=pflash,format=raw,file=/mnt/vms/ovmf/vars.img -cdrom 
/mnt/vms/ovmf/shell.iso -netdev user,id=user.0 -device 
virtio-net,netdev=user.0 -usb -device nec-usb-xhci,id=xhci -device 
usb-tablet,bus=xhci.0 -serial stdio -m 512 -hda sda.img -hdb sdb.img 
-smp 4 -drive if=none,id=stick,file=usb.img -device 
usb-storage,bus=xhci.0,drive=stick
===

Within the VM itself I use udev rule to set the I/O scheduler:

===
ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/scheduler}="bfq"
===

Things boot and work fine until I try to create a partition on the 
emulated USB stick with cfdisk. On writing a new partition table it 
blocks, and I get the following stacktrace:

===
[  225.670702] INFO: task cfdisk:416 blocked for more than 20 seconds.
[  225.681427]       Not tainted 4.15.0-pf1 #1
[  225.685341] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  225.691910] cfdisk          D    0   416    407 0x00000000
[  225.700777] Call Trace:
[  225.703654]  ? __schedule+0x35f/0x1000
[  225.706990]  ? __switch_to_asm+0x40/0x70
[  225.709943]  ? __switch_to_asm+0x34/0x70
[  225.712224]  ? __switch_to_asm+0x40/0x70
[  225.714225]  ? __switch_to_asm+0x40/0x70
[  225.716790]  schedule+0x32/0xc0
[  225.718355]  io_schedule+0x12/0x40
[  225.719747]  wait_on_page_bit+0xea/0x130
[  225.721266]  ? add_to_page_cache_lru+0xe0/0xe0
[  225.722622]  __filemap_fdatawait_range+0xbf/0x110
[  225.724625]  ? preempt_count_sub+0x50/0x90
[  225.726591]  ? sync_inodes_one_sb+0x20/0x20
[  225.727507]  filemap_fdatawait_keep_errors+0x1a/0x40
[  225.728491]  iterate_bdevs+0xa7/0x140
[  225.729304]  sys_sync+0x7c/0xb0
[  225.730095]  entry_SYSCALL_64_fastpath+0x20/0x83
[  225.732420] RIP: 0033:0x7f2631cf4a17
===

I've tried it several times with the same result. Next, I reboot the 
system, change the scheduler to Kyber, and then I can create a new 
partition successfully.

I also went further. While having Kyber activated to work with an 
emulated USB stick properly, I create RAID10 on it, then I create LVM 
PV, then VG, then LV, then XFS on top of that, then I set I/O scheduler 
back to BFQ, then reboot, and on reboot mdadm gets blocked while 
discovering things, producing the following stacktrace:

===
[   41.350763] INFO: task mdadm:354 blocked for more than 20 seconds.
[   41.356154]       Not tainted 4.15.0-pf1 #1
[   41.358674] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[   41.363046] mdadm           D    0   354    352 0x00000100
[   41.368700] Call Trace:
[   41.370417]  ? __schedule+0x35f/0x1000
[   41.372668]  ? blk_queue_exit+0x3e/0x60
[   41.374816]  ? generic_make_request+0x12f/0x2d0
[   41.377363]  schedule+0x32/0xc0
[   41.380416]  io_schedule+0x12/0x40
[   41.382698]  __blkdev_direct_IO_simple+0x206/0x360
[   41.382707]  ? bdget+0x120/0x120
[   41.382714]  ? blkdev_direct_IO+0x3a5/0x3f0
[   41.382718]  blkdev_direct_IO+0x3a5/0x3f0
[   41.382724]  ? current_time+0x18/0x70
[   41.382731]  ? __atime_needs_update+0x7f/0x190
[   41.382743]  ? generic_file_read_iter+0x8c/0x9d0
[   41.382747]  generic_file_read_iter+0x8c/0x9d0
[   41.382759]  ? __seccomp_filter+0x3b/0x260
[   41.382765]  __vfs_read+0xf5/0x170
[   41.382772]  vfs_read+0x91/0x130
[   41.382778]  SyS_read+0x52/0xc0
[   41.382819]  do_syscall_64+0x67/0x1a0
[   41.382828]  entry_SYSCALL64_slow_path+0x25/0x25
[   41.382833] RIP: 0033:0x7f4b8088a3a1
[   41.382836] RSP: 002b:00007ffdd681def8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000000
[   41.382841] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
00007f4b8088a3a1
[   41.382844] RDX: 0000000000001000 RSI: 00000000007f0000 RDI: 
0000000000000003
[   41.382846] RBP: 0000000000000003 R08: 0000000000000003 R09: 
00007f4b80b55050
[   41.382848] R10: 000000000000038b R11: 0000000000000246 R12: 
00000000007eeb10
[   41.382850] R13: 0000000000000000 R14: 00000000007f0000 R15: 
00000000007eeb10
===

If I change I/O scheduler back to Kyber, the system boots okay.

Again, since I'm able to reproduce the issue reliably, let me now what 
information I should also provide, and as usual I'm ready to test any 
patches or suggestions.

Important note: I was unable to reproduce this on v4.14 with the same 
set of BFQ patches (exactly the same case as Ivan has already 
described).

Thanks.

Regards,
   Oleksandr

[1] https://lkml.org/lkml/2017/12/1/80
