Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Wed, 10 Jan 2018 10:45:39 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"osandov@fb.com" <osandov@fb.com>
Subject: Re: [PATCH 3/4] block: convert REQ_ATOM_COMPLETE to stealing
 rq->__deadline bit
Message-ID: <20180110184539.GD30831@vader.DHCP.thefacebook.com>
References: <1515544167-10751-1-git-send-email-axboe@kernel.dk>
 <1515544167-10751-4-git-send-email-axboe@kernel.dk>
 <1515608975.2745.14.camel@wdc.com>
 <1ce2cc85-1217-c0a8-2ca3-afe3e1c3845c@kernel.dk>
 <1515609201.2745.15.camel@wdc.com>
 <6a128067-6a29-ed07-9d2e-511bc72d18f2@kernel.dk>
 <1515609735.2745.21.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1515609735.2745.21.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jan 10, 2018 at 06:42:17PM +0000, Bart Van Assche wrote:
> On Wed, 2018-01-10 at 11:35 -0700, Jens Axboe wrote:
> > On 1/10/18 11:33 AM, Bart Van Assche wrote:
> > > On Wed, 2018-01-10 at 11:32 -0700, Jens Axboe wrote:
> > > > On 1/10/18 11:29 AM, Bart Van Assche wrote:
> > > > > On Tue, 2018-01-09 at 17:29 -0700, Jens Axboe wrote:
> > > > > > @@ -313,8 +307,6 @@ int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq)
> > > > > >  	seq_puts(m, ", .rq_flags=");
> > > > > >  	blk_flags_show(m, (__force unsigned int)rq->rq_flags, rqf_name,
> > > > > >  		       ARRAY_SIZE(rqf_name));
> > > > > > -	seq_puts(m, ", .atomic_flags=");
> > > > > > -	blk_flags_show(m, rq->atomic_flags, rqaf_name, ARRAY_SIZE(rqaf_name));
> > > > > >  	seq_printf(m, ", .tag=%d, .internal_tag=%d", rq->tag,
> > > > > >  		   rq->internal_tag);
> > > > > >  	if (mq_ops->show_rq)
> > > > > 
> > > > > Whether or not a request has been marked complete is very useful to know. Have you
> > > > > considered to show the return value of blk_rq_is_complete() in the debugfs output?
> > > > 
> > > > Yeah, that's a good point. Let me add that in lieu of the atomic flags that
> > > > are being killed. Are you fine with the patch then?
> > > 
> > > The rest of the patch looks fine to me. This is the only comment I had about this patch.
> > 
> > http://git.kernel.dk/cgit/linux-block/commit/?h=blk-kill-atomic-flags&id=3d34009082f5e72137d6bb38cbc2ff6047f03fd1
> > 
> > Added a complete= entry for it.
> 
> For that patch: Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>

Also Reviewed-by: Omar Sandoval <osandov@fb.com>
