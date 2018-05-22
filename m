Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58086 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750820AbeEVHaZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 May 2018 03:30:25 -0400
Date: Tue, 22 May 2018 09:30:24 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Omar Sandoval <osandov@osandov.com>
Cc: Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests] Documentation: document prerequisite scriptlets
Message-ID: <20180522073024.axmhji5nel7kx4tm@linux-x5ow.site>
References: <20180514114042.12082-1-jthumshirn@suse.de>
 <20180521182904.GA14774@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180521182904.GA14774@vader>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, May 21, 2018 at 11:29:04AM -0700, Omar Sandoval wrote:
> But I'm curious about this specific example. Is this not mounted for you
> automatically? I'm guessing systemd does it for me on my setup.

No my setup is kind of special. I don't want to mess with all the
user-space so all I do is:

dracut --no-compress --kver `make kernelrelease` --kmoddir mods/ \
       --no-hostonly --no-hostonly-cmdline --modules "bash base" \
       --tmpdir `pwd`/myinitrd --force myinitrd/initrd \
       --add-drivers "loop nvme nvme-loop nvmet" \
       --install "lsblk find sort parted getopt fio tput column date \
       		 dirname mktemp ps diff awk timeout time losetup \
		 truncate wc grep stat basename cut blktrace sg_inq \
		 realpath findmnt vi dd sed rm rmdir nvme" \
		 --include "$HOME/src/blktests" "/blktests

qemu-kvm -m 4096 -smp 4 -nographic -serial mon:stdio -kernel \
	 arch/x86/boot/bzImage -initrd myinitrd/initrd \
	 -append "console=ttyS0 debug"

I have the above in a shell wrapper as I simply can't remember it, or
I just use rapido [1] which a co-worker of mine started for this job.

As minimal as possible. I try to get my rebuild - boot - test cycles
short.

With my current config I have a bootup time in qemu below half a
second on a reasonable machine in my lab and just below one second
on my laptop.

[1] https://github.com/rapido-linux/rapido

Byte,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
