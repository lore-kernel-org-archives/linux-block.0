Return-Path: <ming.lei@redhat.com>
Date: Tue, 30 Jan 2018 16:19:30 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: paolo.valente@linaro.org, Ivan Kozik <ivan@ludios.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	bfq-iosched@googlegroups.com, Jens Axboe <axboe@kernel.dk>,
	linus.walleij@linaro.org
Subject: Re: v4.15 and I/O hang with BFQ
Message-ID: <20180130081925.GA25183@ming.t460p>
References: <9ad0d544ab2b12f87f44eb4ef88e23a2@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9ad0d544ab2b12f87f44eb4ef88e23a2@natalenko.name>
List-ID: <linux-block@vger.kernel.org>

Hi,

On Tue, Jan 30, 2018 at 09:05:26AM +0100, Oleksandr Natalenko wrote:
> Hi, Paolo, Ivan, Ming et al.
> 
> It looks like I've just encountered the issue Ivan has already described in
> [1]. Since I'm able to reproduce it reliably in a VM, I'd like to draw more
> attention to it.
> 
> First, I'm using v4.15 kernel with all pending BFQ fixes:
> 
> ===
> 2ad909a300c4 bfq-iosched: don't call bfqg_and_blkg_put for
> !CONFIG_BFQ_GROUP_IOSCHED
> 83c97a310f83 block, bfq: release oom-queue ref to root group on exit
> 5b9eb4716af1 block, bfq: put async queues for root bfq groups too
> 3c5529454a27 block, bfq: limit sectors served with interactive weight
> raising
> e6c72be3486b block, bfq: limit tags for writes and async I/O
> e579b91d96ce block, bfq: increase threshold to deem I/O as random
> f6cbc16aac88 block, bfq: remove superfluous check in queue-merging setup
> 8045d8575183 block, bfq: let a queue be merged only shortly after starting
> I/O
> 242954975f5e block, bfq: check low_latency flag in bfq_bfqq_save_state()
> 8349c1bddd95 block, bfq: add missing rq_pos_tree update on rq removal
> 558200440cb9 block, bfq: fix occurrences of request finish method's old name
> 6ed2f47ee870 block, bfq: consider also past I/O in soft real-time detection
> e5f295dd18f2 block, bfq: remove batches of confusing ifdefs
> ===
> 
> Next, I boot an Arch VM with this kernel and emulated USB stick attached:
> 
> ===
> qemu-system-x86_64 -display gtk,gl=on -machine q35,accel=kvm -cpu host,+vmx
> -enable-kvm -drive if=pflash,format=raw,readonly,file=/mnt/vms/ovmf/code.img
> -drive if=pflash,format=raw,file=/mnt/vms/ovmf/vars.img -cdrom
> /mnt/vms/ovmf/shell.iso -netdev user,id=user.0 -device
> virtio-net,netdev=user.0 -usb -device nec-usb-xhci,id=xhci -device
> usb-tablet,bus=xhci.0 -serial stdio -m 512 -hda sda.img -hdb sdb.img -smp 4
> -drive if=none,id=stick,file=usb.img -device
> usb-storage,bus=xhci.0,drive=stick
> ===
> 
> Within the VM itself I use udev rule to set the I/O scheduler:
> 
> ===
> ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/scheduler}="bfq"
> ===

We knew there is IO hang issue on BFQ over USB-storage wrt. blk-mq, and
last time I found it is inside BFQ. You can try the debug patch in the
following link[1] to see if it is same with the previous report[1][2]:

[1] https://marc.info/?l=linux-block&m=151214241518562&w=2
[2] https://bugzilla.kernel.org/show_bug.cgi?id=198023

If you aren't sure if they are same, please post the trace somewhere,
then I can check if it is a new bug.

Or Paolo should know if the issue is fixed or not in V4.15.

Thanks,
Ming
