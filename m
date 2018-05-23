Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34479 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753502AbeEWAPd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 May 2018 20:15:33 -0400
Received: by mail-pl0-f67.google.com with SMTP id ay10-v6so11873898plb.1
        for <linux-block@vger.kernel.org>; Tue, 22 May 2018 17:15:32 -0700 (PDT)
Date: Tue, 22 May 2018 17:15:30 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests] Documentation: document prerequisite scriptlets
Message-ID: <20180523001530.GJ9536@vader>
References: <20180514114042.12082-1-jthumshirn@suse.de>
 <20180521182904.GA14774@vader>
 <20180522073024.axmhji5nel7kx4tm@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180522073024.axmhji5nel7kx4tm@linux-x5ow.site>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, May 22, 2018 at 09:30:24AM +0200, Johannes Thumshirn wrote:
> On Mon, May 21, 2018 at 11:29:04AM -0700, Omar Sandoval wrote:
> > But I'm curious about this specific example. Is this not mounted for you
> > automatically? I'm guessing systemd does it for me on my setup.
> 
> No my setup is kind of special. I don't want to mess with all the
> user-space so all I do is:
> 
> dracut --no-compress --kver `make kernelrelease` --kmoddir mods/ \
>        --no-hostonly --no-hostonly-cmdline --modules "bash base" \
>        --tmpdir `pwd`/myinitrd --force myinitrd/initrd \
>        --add-drivers "loop nvme nvme-loop nvmet" \
>        --install "lsblk find sort parted getopt fio tput column date \
>        		 dirname mktemp ps diff awk timeout time losetup \
> 		 truncate wc grep stat basename cut blktrace sg_inq \
> 		 realpath findmnt vi dd sed rm rmdir nvme" \
> 		 --include "$HOME/src/blktests" "/blktests
> 
> qemu-kvm -m 4096 -smp 4 -nographic -serial mon:stdio -kernel \
> 	 arch/x86/boot/bzImage -initrd myinitrd/initrd \
> 	 -append "console=ttyS0 debug"
> 
> I have the above in a shell wrapper as I simply can't remember it, or
> I just use rapido [1] which a co-worker of mine started for this job.
> 
> As minimal as possible. I try to get my rebuild - boot - test cycles
> short.
> 
> With my current config I have a bootup time in qemu below half a
> second on a reasonable machine in my lab and just below one second
> on my laptop.
> 
> [1] https://github.com/rapido-linux/rapido
> 
> Byte,
> 	Johannes

Cool setup :) I have my own fanciness [1] which lets met boot straight
into a test kernel without packaging it up in any way.

Anyways, I added some documentation based on yours. Thanks!

1: https://github.com/osandov/osandov-linux#vm-setup
