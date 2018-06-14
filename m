Return-Path: <lurodriguez@suse.de>
Date: Thu, 14 Jun 2018 19:37:19 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Mike Snitzer <snitzer@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, damien.lemoal@wdc.com,
	hare@suse.de, axboe@kernel.dk, jaegeuk@kernel.org,
	yuchao0@huawei.com, ghe@suse.com, mwilck@suse.com,
	tchvatal@suse.com, zren@suse.com, agk@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: dm-zoned-tools: add zoned disk udev rules for scheduler / dmsetup
Message-ID: <20180614173719.GI5527@wotan.suse.de>
References: <20180614001147.1545-1-mcgrof@kernel.org>
 <20180614123806.GA32162@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180614123806.GA32162@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jun 14, 2018 at 08:38:06AM -0400, Mike Snitzer wrote:
> On Wed, Jun 13 2018 at  8:11pm -0400,
> Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> 
> > Setting up a zoned disks in a generic form is not so trivial. There
> > is also quite a bit of tribal knowledge with these devices which is not
> > easy to find.
> > 
> > The currently supplied demo script works but it is not generic enough to be
> > practical for Linux distributions or even developers which often move
> > from one kernel to another.
> > 
> > This tries to put a bit of this tribal knowledge into an initial udev
> > rule for development with the hopes Linux distributions can later
> > deploy. Three rule are added. One rule is optional for now, it should be
> > extended later to be more distribution-friendly and then I think this
> > may be ready for consideration for integration on distributions.
> > 
> > 1) scheduler setup
> 
> This is wrong.. if zoned devices are so dependent on deadline or
> mq-deadline then the kernel should allow them to be hardcoded.  I know
> Jens removed the API to do so but the fact that drivers need to rely on
> hacks like this udev rule to get a functional device is proof we need to
> allow drivers to impose the scheduler used.

This is the point to the patch as well, I actually tend to agree with you,
and I had tried to draw up a patch to do just that, however its *not* possible
today to do this and would require some consensus. So from what I can tell
we *have* to live with this one or a form of it. Ie a file describing which
disk serial gets deadline and which one gets mq-deadline.

Jens?

Anyway, let's assume this is done in the kernel, which one would use deadline,
which one would use mq-deadline?

> > 2) backlist f2fs devices
> 
> There should porbably be support in dm-zoned for detecting whether a
> zoned device was formatted with f2fs (assuming there is a known f2fs
> superblock)?

Not sure what you mean. Are you suggesting we always setup dm-zoned for
all zoned disks and just make an excemption on dm-zone code to somehow
use the disk directly if a filesystem supports zoned disks directly somehow?

f2fs does not require dm-zoned. What would be required is a bit more complex
given one could dedicate portions of the disk to f2fs and other portions to
another filesystem, which would require dm-zoned.

Also filesystems which *do not* support zoned disks should *not* be allowing
direct setup. Today that's all filesystems other than f2fs, in the future
that may change. Those are bullets we are allowing to trigger for users
just waiting to shot themselves on the foot with.

So who's going to work on all the above?

The point of the udev script is to illustrate the pains to properly deploy
zoned disks on distributions today and without a roadmap... this is what
at least I need on my systems today to reasonably deploy these disks for
my own development.

Consensus is indeed needed for a broader picture.

> > 3) run dmsetup for the rest of devices
> 
> automagically running dmsetup directly from udev to create a dm-zoned
> target is very much wrong.  It just gets in the way of proper support
> that should be add to appropriate tools that admins use to setup their
> zoned devices.  For instance, persistent use of dm-zoned target should
> be made reliable with a volume manager..

Ah yes, but who's working on that? How long will it take?

I agree it is odd to expect one to use dmsetup and then use a volume manager on
top of it, if we can just add proper support onto the volume manager... then
that's a reasonable way to go.

But *we're not there* yet, and as-is today, what is described in the udev
script is the best we can do for a generic setup.

> In general this udev script is unwelcome and makes things way worse for
> the long-term success of zoned devices.

dm-zoned-tools does not acknowledge in any way a roadmap, and just provides
a script, which IMHO is less generic and less distribution friendly. Having
a udev rule in place to demonstrate the current state of affairs IMHO is
more scalable demonstrates the issues better than the script.

If we have an agreed upon long term strategy lets document that. But from
what I gather we are not even in consensus with regards to the scheduler
stuff. If we have consensus on the other stuff lets document that as
dm-zoned-tools is the only place I think folks could find to reasonably
deploy these things.

> I don't dispute there is an obvious void for how to properly setup zoned
> devices, but this script is _not_ what should fill that void.

Good to know! Again, consider it as an alternative to the script.

I'm happy to adapt the language and supply it only as an example script
developers can use, but we can't leave users hanging as well. Let's at
least come up with a plan which we seem to agree on and document that.

  Luis
