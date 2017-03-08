Return-Path: <wouter@grep.be>
Date: Wed, 8 Mar 2017 11:07:04 +0100
From: Wouter Verhelst <w@uter.be>
To: Josef Bacik <jbacik@fb.com>
Cc: axboe@kernel.dk, nbd-general@lists.sourceforge.net,
	linux-block@vger.kernel.org, kernel-team@fb.com
Subject: Re: [Nbd] [PATCH 6/6] nbd: add a basic netlink interface
Message-ID: <20170308100704.xdxuhlpsttigfreq@grep.be>
References: <1488301031-3199-1-git-send-email-jbacik@fb.com>
 <1488301031-3199-7-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1488301031-3199-7-git-send-email-jbacik@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Feb 28, 2017 at 11:57:11AM -0500, Josef Bacik wrote:
> The existing ioctl interface for configuring NBD devices is a bit
> cumbersome and hard to extend.  The other problem is we leave a
> userspace app sitting in it's syscall until the device disconnects,
> which is less than ideal.

True.

On the other hand, it has the advantage that you leave a userspace app
sitting around until the device disconnects, which allows for some form
of recovery in case you're doing root-on-NBD and the server has a
hiccup. Don't underestimate the advantage of that.

(of course, that requires that the return value of NBD_DO_IT makes a
difference between "unexpected connection drop" and "we sent
NBD_CMD_DISC", but that's a different matter entirely)

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
