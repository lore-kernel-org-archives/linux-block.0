Return-Path: <msnitzer@redhat.com>
Date: Fri, 15 Jun 2018 10:50:37 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, "hare@suse.de" <hare@suse.de>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"jaegeuk@kernel.org" <jaegeuk@kernel.org>,
	"yuchao0@huawei.com" <yuchao0@huawei.com>,
	"ghe@suse.com" <ghe@suse.com>, "mwilck@suse.com" <mwilck@suse.com>,
	"tchvatal@suse.com" <tchvatal@suse.com>,
	"zren@suse.com" <zren@suse.com>, "agk@redhat.com" <agk@redhat.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: dm-zoned-tools: add zoned disk udev rules for scheduler / dmsetup
Message-ID: <20180615145037.GB1386@redhat.com>
References: <20180614001147.1545-1-mcgrof@kernel.org>
 <20180614123806.GA32162@redhat.com>
 <20180614173719.GI5527@wotan.suse.de>
 <20180614175852.GA1034@redhat.com>
 <3dca87db-d8ce-5229-0fd9-939501bc6b3a@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3dca87db-d8ce-5229-0fd9-939501bc6b3a@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jun 15 2018 at  5:59am -0400,
Damien Le Moal <Damien.LeMoal@wdc.com> wrote:

> Mike,
> 
> On 6/15/18 02:58, Mike Snitzer wrote:
> > On Thu, Jun 14 2018 at  1:37pm -0400,
> > Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> > 
> >> On Thu, Jun 14, 2018 at 08:38:06AM -0400, Mike Snitzer wrote:
> >>> On Wed, Jun 13 2018 at  8:11pm -0400,
> >>> Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> >>>
> >>>> Setting up a zoned disks in a generic form is not so trivial. There
> >>>> is also quite a bit of tribal knowledge with these devices which is not
> >>>> easy to find.
> >>>>
> >>>> The currently supplied demo script works but it is not generic enough to be
> >>>> practical for Linux distributions or even developers which often move
> >>>> from one kernel to another.
> >>>>
> >>>> This tries to put a bit of this tribal knowledge into an initial udev
> >>>> rule for development with the hopes Linux distributions can later
> >>>> deploy. Three rule are added. One rule is optional for now, it should be
> >>>> extended later to be more distribution-friendly and then I think this
> >>>> may be ready for consideration for integration on distributions.
> >>>>
> >>>> 1) scheduler setup
> >>>
> >>> This is wrong.. if zoned devices are so dependent on deadline or
> >>> mq-deadline then the kernel should allow them to be hardcoded.  I know
> >>> Jens removed the API to do so but the fact that drivers need to rely on
> >>> hacks like this udev rule to get a functional device is proof we need to
> >>> allow drivers to impose the scheduler used.
> >>
> >> This is the point to the patch as well, I actually tend to agree with you,
> >> and I had tried to draw up a patch to do just that, however its *not* possible
> >> today to do this and would require some consensus. So from what I can tell
> >> we *have* to live with this one or a form of it. Ie a file describing which
> >> disk serial gets deadline and which one gets mq-deadline.
> >>
> >> Jens?
> >>
> >> Anyway, let's assume this is done in the kernel, which one would use deadline,
> >> which one would use mq-deadline?
> > 
> > The zoned storage driver needs to make that call based on what mode it
> > is in.  If it is using blk-mq then it selects mq-deadline, otherwise
> > deadline.
> 
> As Bart pointed out, deadline is an alias of mq-deadline. So using
> "deadline" as the scheduler name works in both legacy and mq cases.
> 
> >>>> 2) backlist f2fs devices
> >>>
> >>> There should porbably be support in dm-zoned for detecting whether a
> >>> zoned device was formatted with f2fs (assuming there is a known f2fs
> >>> superblock)?
> >>
> >> Not sure what you mean. Are you suggesting we always setup dm-zoned for
> >> all zoned disks and just make an excemption on dm-zone code to somehow
> >> use the disk directly if a filesystem supports zoned disks directly somehow?
> > 
> > No, I'm saying that a udev rule wouldn't be needed if dm-zoned just
> > errored out if asked to consume disks that already have an f2fs
> > superblock.  And existing filesystems should get conflicting superblock
> > awareness "for free" if blkid or whatever is trained to be aware of
> > f2fs's superblock.
> 
> Well that is the case already: on startup, dm-zoned will read its own
> metadata from sector 0, same as f2fs would do with its super-block. If
> the format/magic does not match expected values, dm-zoned will bail out
> and return an error. dm-zoned metadata and f2fs metadata reside in the
> same place and overwrite each other. There is no way to get one working
> on top of the other. I do not see any possibility of a problem on startup.
> 
> But definitely, the user land format tools can step on each other toes.
> That needs fixing.

Right, I was talking about in the .ctr path for initial device creation,
not activation of a previously created dm-zoned device.

But I agree it makes most sense to do this check in userspace.

> >> f2fs does not require dm-zoned. What would be required is a bit more complex
> >> given one could dedicate portions of the disk to f2fs and other portions to
> >> another filesystem, which would require dm-zoned.
> >>
> >> Also filesystems which *do not* support zoned disks should *not* be allowing
> >> direct setup. Today that's all filesystems other than f2fs, in the future
> >> that may change. Those are bullets we are allowing to trigger for users
> >> just waiting to shot themselves on the foot with.
> >>
> >> So who's going to work on all the above?
> > 
> > It should take care of itself if existing tools are trained to be aware
> > of new signatures.  E.g. ext4 and xfs already are aware of one another
> > so that you cannot reformat a device with the other unless force is
> > given.
> > 
> > Same kind of mutual exclussion needs to happen for zoned devices.
> 
> Yes.
> 
> > So the zoned device tools, dm-zoned, f2fs, whatever.. they need to be
> > updated to not step on each others toes.  And other filesystems' tools
> > need to be updated to be zoned device aware.
> 
> I will update dm-zoned tools to check for known FS superblocks,
> similarly to what mkfs.ext4 and mkfs.xfs do.

Thanks.

> >>>> 3) run dmsetup for the rest of devices
> >>>
> >>> automagically running dmsetup directly from udev to create a dm-zoned
> >>> target is very much wrong.  It just gets in the way of proper support
> >>> that should be add to appropriate tools that admins use to setup their
> >>> zoned devices.  For instance, persistent use of dm-zoned target should
> >>> be made reliable with a volume manager..
> >>
> >> Ah yes, but who's working on that? How long will it take?
> > 
> > No idea, as is (from my vantage point) there is close to zero demand for
> > zoned devices.  It won't be a priority until enough customers are asking
> > for it.
> 
> From my point of view (drive vendor), things are different. We do see an
> increasing interest for these drives. However, most use cases are still
> limited to application based direct disk access with minimal involvement
> from the kernel and so few "support" requests. Many reasons to this, but
> one is to some extent the current lack of extended support by the
> kernel. Despite all the recent work done, as Luis experienced, zoned
> drives are still far harder to easily setup than regular disks. Chicken
> and egg situation...
> 
> >> I agree it is odd to expect one to use dmsetup and then use a volume manager on
> >> top of it, if we can just add proper support onto the volume manager... then
> >> that's a reasonable way to go.
> >>
> >> But *we're not there* yet, and as-is today, what is described in the udev
> >> script is the best we can do for a generic setup.
> > 
> > Just because doing things right takes work doesn't mean it makes sense
> > to elevate this udev script to be packaged in some upstream project like
> > udev or whatever.
> 
> Agree. Will start looking into better solutions now that at least one
> user (Luis) complained. The customer is king.
> 
> >>> In general this udev script is unwelcome and makes things way worse for
> >>> the long-term success of zoned devices.
> >>
> >> dm-zoned-tools does not acknowledge in any way a roadmap, and just provides
> >> a script, which IMHO is less generic and less distribution friendly. Having
> >> a udev rule in place to demonstrate the current state of affairs IMHO is
> >> more scalable demonstrates the issues better than the script.
> >>
> >> If we have an agreed upon long term strategy lets document that. But from
> >> what I gather we are not even in consensus with regards to the scheduler
> >> stuff. If we have consensus on the other stuff lets document that as
> >> dm-zoned-tools is the only place I think folks could find to reasonably
> >> deploy these things.
> > 
> > I'm sure Damien and others will have something to say here.
> 
> Yes. The scheduler setup pain is real. Jens made it clear that he
> prefers a udev rule. I fully understand his point of view, yet, I think
> an automatic switch in the block layer would be far easier and generate
> a lot less problem for users, and likely less "bug report" to
> distributions vendors (and to myself too).

Yeap, Jens would say that ;)  Unfortnately using udev to get this
critical configuration correct is a real leap of faith that will prove
to be a whack-a-mole across distributions.

> That said, I also like to see the current dependency of zoned devices on
> the deadline scheduler as temporary until a better solution for ensuring
> write ordering is found. After all, requiring deadline as the disk
> scheduler does impose other limitations on the user. Lack of I/O
> priority support and no cgroup based fairness are two examples of what
> other schedulers provide but is lost with forcing deadline.
> 
> The obvious fix is of course to make all disk schedulers zone device
> aware. A little heavy handed, probably lots of duplicated/similar code,
> and many more test cases to cover. This approach does not seem
> sustainable to me.

Right, it isn't sustainable.  There isn't enough zoned device developer
expertise to go around.

> We discussed other possibilities at LSF/MM (specialized write queue in
> multi-queue path). One could also think of more invasive changes to the
> block layer (e.g. adding an optional "dispatcher" layer to tightly
> control command ordering ?). And probably a lot more options, But I am
> not yet sure what an appropriate replacement to deadline would be.
> 
> Eventually, the removal of the legacy I/O path may also be the trigger
> to introduce some deeper design changes to blk-mq to accommodate more
> easily zoned block devices or other non-standard block devices (open
> channel SSDs for instance).
> 
> As you can see from the above, working with these drives all day long
> does not make for a clear strategy. Inputs from other here are more than
> welcome. I would be happy to write up all the ideas I have to start a
> discussion so that we can come to a consensus and have a plan.

Doesn't hurt to establish a future plan(s) but we need to deal with the
reality of what we have.  And all we have for this particular issue is
"deadline".  Setting anything else is a bug.

Short of the block layer reinstating the ability for a driver to specify
an elevator: should the zoned driver put a check in place that errors
out if anything other than deadline is configured?

That'd at least save users from a very cutthroat learning curve.

> >>> I don't dispute there is an obvious void for how to properly setup zoned
> >>> devices, but this script is _not_ what should fill that void.
> >>
> >> Good to know! Again, consider it as an alternative to the script.
> >>
> >> I'm happy to adapt the language and supply it only as an example script
> >> developers can use, but we can't leave users hanging as well. Let's at
> >> least come up with a plan which we seem to agree on and document that.
> > 
> > Best to try to get Damien and others more invested in zoned devices to
> > help you take up your cause.  I think it is worthwhile to develop a
> > strategy.  But it needs to be done in terms of the norms of the existing
> > infrastructure we all make use of today.  So first step is making
> > existing tools zoned device aware (even if to reject such devices).
> 
> Rest assured that I am fully invested in improving the existing
> infrastructure for zoned block devices. As mentioned above, applications
> based use of zoned block devices still prevails today. So I do tend to
> work more on that side of things (libzbc, tcmu, sysutils for instance)
> rather than on a better integration with more advanced tools (such as
> LVM) relying on kernel features. I am however seeing rising interest in
> file systems and also in dm-zoned. So definitely it is time to step up
> work in that area to further simplify using these drives.
> 
> Thank you for the feedback.

Thanks for your insight.  Sounds like you're ontop of it.

Mike
