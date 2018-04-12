Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 12 Apr 2018 09:12:47 -0700
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"00moses.alexander00@gmail.com" <00moses.alexander00@gmail.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] block: Ensure that a request queue is dissociated from
 the cgroup controller
Message-ID: <20180412161247.GD793541@devbig577.frc2.facebook.com>
References: <20180412015852.26014-1-bart.vanassche@wdc.com>
 <20180412135149.GX793541@devbig577.frc2.facebook.com>
 <af6dafea-d754-8a0d-b96b-81716f2ea24d@wdc.com>
 <20180412153748.GB793541@devbig577.frc2.facebook.com>
 <beafd7bc4f2fdb7e672ad97e57ff4f82464182da.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <beafd7bc4f2fdb7e672ad97e57ff4f82464182da.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Thu, Apr 12, 2018 at 04:03:52PM +0000, Bart Van Assche wrote:
> On Thu, 2018-04-12 at 08:37 -0700, Tejun Heo wrote:
> > On Thu, Apr 12, 2018 at 08:09:17AM -0600, Bart Van Assche wrote:
> > > I have retested hotunplugging by rerunning the srp-test software. It
> > > seems like you overlooked that this patch does not remove the
> > > blkcg_exit_queue() call from blk_cleanup_queue()? If a device is
> > > hotunplugged it is up to the block driver to call
> > > blk_cleanup_queue(). And blk_cleanup_queue() will call
> > > blkcg_exit_queue().
> > 
> > Hmm... what'd prevent blg_lookup_and_create() racing against that?
> 
> Hello Tejun,
> 
> Did you perhaps mean blkg_lookup_create()? That function has one caller,

Ah yeah, sorry about the sloppiness.

> namely blkcg_bio_issue_check(). The only caller of that function is
> generic_make_request_checks(). A patch was posted on the linux-block mailing
> list recently that surrounds that call with blk_queue_enter() / blk_queue_exit().
> I think that prevents that blkcg_exit_queue() is called concurrently with
> blkg_lookup_create().

Yeah, that'd solve the problem for that particular path, but what
that's doing is adding another layer of refcnting which is used to
implement the revoke (or sever) semantics.  This is a fragile approach
tho because it isn't clear who's protecting what and there's nothing
in blkg's usage which suggests it'd be protected that way and we're
basically working around a different underlying problem (lock
switching) by expanding the coverage of a different lock.

I'd much prefer fixing the lock switching problem properly than
working around that shortcoming this way.

Thans.

-- 
tejun
