Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Tue, 7 Mar 2017 08:28:23 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Lekshmi Pillai <lekshmicpillai@in.ibm.com>,
	Tejun Heo <tj@kernel.org>, NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 0/13 v2] block: Fix block device shutdown related races
Message-ID: <20170307162823.GA20922@vader>
References: <20170221170958.21845-1-jack@suse.cz>
 <7734fd93-e4fd-65a7-bf32-08012de83c1e@kernel.dk>
 <20170222102425.GB23312@quack2.suse.cz>
 <20170301072528.GA9377@vader>
 <20170301072653.GB9377@vader>
 <20170301151109.GI20512@quack2.suse.cz>
 <20170306203818.GC16893@vader.DHCP.thefacebook.com>
 <20170307135730.GG2578@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170307135730.GG2578@quack2.suse.cz>
List-ID: <linux-block@vger.kernel.org>

On Tue, Mar 07, 2017 at 02:57:30PM +0100, Jan Kara wrote:
> On Mon 06-03-17 12:38:18, Omar Sandoval wrote:
> > Unfortunately, this patch actually seems to have introduced a
> > regression. Reverting the patch fixes it.
> > 
> > I'm running a QEMU kvm vm with a virtio-scsi device and I get oopses
> > like this:
> 
> What workload do you run? Or is it enough to just boot the kvm with
> virtio-scsi enabled? Can you send me the kvm setup so that I can reproduce
> this?

This is just while booting. In fact, you don't even need a virtio-scsi
disk attached, it's enough to have the virtio-scsi-pci controller. This
is my exact command line:

qemu-system-x86_64 -nodefaults -nographic -serial mon:stdio -cpu kvm64 \
	-enable-kvm -smp 1 -m 2G -watchdog i6300esb \
	-netdev user,id=vlan0,hostfwd=tcp:127.0.0.1:2222-:22 \
	-device virtio-net,netdev=vlan0 \
	-drive file=Silver/Silver.qcow2,index=0,media=disk,if=virtio,cache=none \
	-device virtio-scsi-pci \
	-kernel /home/osandov/linux/builds/virtio-scsi-crash/arch/x86/boot/bzImage \
	-virtfs local,path=/home/osandov/linux/builds/virtio-scsi-crash,security_model=none,readonly,mount_tag=modules \
	-append 'root=/dev/vda1 console=ttyS0,115200 scsi_mod.use_blk_mq=y'

My kernel config is here:
https://github.com/osandov/osandov-linux/blob/master/configs/qemu.config

> At least the KASAN error could be a result of the situation where someone
> called bdi_register() but didn't call bdi_unregister() before dropping the
> last bdi reference (which would make sense given I've moved
> bdi_unregister() call). However I'd expect a warning from bdi_exit() in that
> case and I don't see that in your kernel log. So I'll try to reproduce the
> issue and debug more.
> 
> 								Honza

Thanks for taking a look!
