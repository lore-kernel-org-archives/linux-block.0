Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35702 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751574AbdELTaC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2017 15:30:02 -0400
Received: by mail-pg0-f51.google.com with SMTP id q125so15067281pgq.2
        for <linux-block@vger.kernel.org>; Fri, 12 May 2017 12:30:02 -0700 (PDT)
Date: Fri, 12 May 2017 12:30:00 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Markus Trippelsdorf <markus@trippelsdorf.de>
Cc: linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Subject: Re: Kyber scheduler brings system to halt when used on swap partition
Message-ID: <20170512193000.GB15267@vader.DHCP.thefacebook.com>
References: <20170511125724.GA302@x4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170511125724.GA302@x4>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, May 11, 2017 at 02:57:24PM +0200, Markus Trippelsdorf wrote:
> Using the new Kyber mq scheduler brings my system to a halt as soon as it
> starts swapping. The swap partition resides on an SSD and is the only
> partition in use on that drive.
> Symptoms are stuttering sound and non moving mouse pointer. After a
> while the monitor switches off, because it gets no signal anymore.
> At which point only a hard reset will bring the system back.
> 
> "none" works fine.

Thanks for testing, I'm taking a look to see if there's anything special
about the swap path that would trigger this. In the meantime, if you
swapoff your swap partition and do some I/O on it, what happens? Here's
a first-order guess at a fio job you could run:

fio --group_reporting --filename=$partition \
	--name swapin --numjobs=8 --ioengine=sync --rw=randread \
	--name swapout --numjobs=4 --ioengine=libaio --iodepth=8 --rw=randwrite

Interesting to note is that wbt, which Kyber borrowed ideas from, treats
kswapd specially, allowing it to queue more I/O than other processes. I
wonder if we need to do the same in Kyber.
