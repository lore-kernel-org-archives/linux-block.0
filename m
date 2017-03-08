Return-Path: <wouter@grep.be>
Date: Wed, 8 Mar 2017 21:44:41 +0100
From: Wouter Verhelst <w@uter.be>
To: Josef Bacik <jbacik@fb.com>
Cc: axboe@kernel.dk, nbd-general@lists.sourceforge.net,
	linux-block@vger.kernel.org, kernel-team@fb.com
Subject: Re: [Nbd] [PATCH 6/6] nbd: add a basic netlink interface
Message-ID: <20170308204441.ywvrsoyrk2qpyji7@grep.be>
References: <1488301031-3199-1-git-send-email-jbacik@fb.com>
 <1488301031-3199-7-git-send-email-jbacik@fb.com>
 <20170308100704.xdxuhlpsttigfreq@grep.be>
 <1488985008.9307.29.camel@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1488985008.9307.29.camel@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Mar 08, 2017 at 09:56:48AM -0500, Josef Bacik wrote:
> On Wed, 2017-03-08 at 11:07 +0100, Wouter Verhelst wrote:
> > On Tue, Feb 28, 2017 at 11:57:11AM -0500, Josef Bacik wrote:
> > > 
> > > The existing ioctl interface for configuring NBD devices is a bit
> > > cumbersome and hard to extend.��The other problem is we leave a
> > > userspace app sitting in it's syscall until the device disconnects,
> > > which is less than ideal.
> > True.
> > 
> > On the other hand, it has the advantage that you leave a userspace
> > app
> > sitting around until the device disconnects, which allows for some
> > form
> > of recovery in case you're doing root-on-NBD and the server has a
> > hiccup. Don't underestimate the advantage of that.
> > 
> > (of course, that requires that the return value of NBD_DO_IT makes a
> > difference between "unexpected connection drop" and "we sent
> > NBD_CMD_DISC", but that's a different matter entirely)
> 
> Stay tuned for further developments ;).

Heh.

> Yeah the problem is that even
> though we can return and allow the user to reconnect, we completely
> tear down the device and will return EIO to anything that comes in
> while we're reconnecting, which sucks for users.

Quite, yes.

>�The patches that I'm testing now will multi-cast messages over netlink
> when a link goes down so a user space application can reconnect and
> provide a new connection seamlessly. �The next step after that is to
> allow a complete failure of all connections and we will simply sit
> there and queue IO until userspace reconnects or the configured
> timeout elapses at which point we'll tear down the device. �The end
> goal of all of this is seamless reconnects without throwing errors.

Awesome. That would mean userspace would need to sit around, but I
suppose that isn't something we can't live with (and actually has other
advantages, too).

Thanks,

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
