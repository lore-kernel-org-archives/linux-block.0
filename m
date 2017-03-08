Return-Path: <prvs=42406fc08f=jbacik@fb.com>
Message-ID: <1488985008.9307.29.camel@fb.com>
Subject: Re: [Nbd] [PATCH 6/6] nbd: add a basic netlink interface
From: Josef Bacik <jbacik@fb.com>
To: Wouter Verhelst <w@uter.be>
CC: <axboe@kernel.dk>, <nbd-general@lists.sourceforge.net>,
        <linux-block@vger.kernel.org>, <kernel-team@fb.com>
Date: Wed, 8 Mar 2017 09:56:48 -0500
In-Reply-To: <20170308100704.xdxuhlpsttigfreq@grep.be>
References: <1488301031-3199-1-git-send-email-jbacik@fb.com>
	 <1488301031-3199-7-git-send-email-jbacik@fb.com>
	 <20170308100704.xdxuhlpsttigfreq@grep.be>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2017-03-08 at 11:07 +0100, Wouter Verhelst wrote:
> On Tue, Feb 28, 2017 at 11:57:11AM -0500, Josef Bacik wrote:
> > 
> > The existing ioctl interface for configuring NBD devices is a bit
> > cumbersome and hard to extend.  The other problem is we leave a
> > userspace app sitting in it's syscall until the device disconnects,
> > which is less than ideal.
> True.
> 
> On the other hand, it has the advantage that you leave a userspace
> app
> sitting around until the device disconnects, which allows for some
> form
> of recovery in case you're doing root-on-NBD and the server has a
> hiccup. Don't underestimate the advantage of that.
> 
> (of course, that requires that the return value of NBD_DO_IT makes a
> difference between "unexpected connection drop" and "we sent
> NBD_CMD_DISC", but that's a different matter entirely)
> 

Stay tuned for further developments ;).  Yeah the problem is that even
though we can return and allow the user to reconnect, we completely
tear down the device and will return EIO to anything that comes in
while we're reconnecting, which sucks for users.  The patches that I'm
testing now will multi-cast messages over netlink when a link goes down
so a user space application can reconnect and provide a new connection
seamlessly.  The next step after that is to allow a complete failure of
all connections and we will simply sit there and queue IO until
userspace reconnects or the configured timeout elapses at which point
we'll tear down the device.  The end goal of all of this is seamless
reconnects without throwing errors.  Thanks,

Josef
