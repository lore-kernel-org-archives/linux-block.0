Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 12 Apr 2018 12:09:15 -0700
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"00moses.alexander00@gmail.com" <00moses.alexander00@gmail.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] block: Ensure that a request queue is dissociated from
 the cgroup controller
Message-ID: <20180412190915.GB1911913@devbig577.frc2.facebook.com>
References: <20180412015852.26014-1-bart.vanassche@wdc.com>
 <20180412135149.GX793541@devbig577.frc2.facebook.com>
 <af6dafea-d754-8a0d-b96b-81716f2ea24d@wdc.com>
 <20180412153748.GB793541@devbig577.frc2.facebook.com>
 <beafd7bc4f2fdb7e672ad97e57ff4f82464182da.camel@wdc.com>
 <20180412161247.GD793541@devbig577.frc2.facebook.com>
 <f98af37ea6755119177c26fbb73b0071ddef90b8.camel@wdc.com>
 <20180412181121.GA1911913@devbig577.frc2.facebook.com>
 <22e0bba319877407a0abccf292ef0b22454db04d.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <22e0bba319877407a0abccf292ef0b22454db04d.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Thu, Apr 12, 2018 at 06:56:26PM +0000, Bart Van Assche wrote:
> On Thu, 2018-04-12 at 11:11 -0700, tj@kernel.org wrote:
> > * Right now, blk_queue_enter/exit() doesn't have any annotations.
> >   IOW, there's no way for paths which need enter locked to actually
> >   assert that.  If we're gonna protect more things with queue
> >   enter/exit, it gotta be annotated.
> 
> Hello Tejun,
> 
> One possibility is to check the count for the local CPU of q->q_usage_counter
> at runtime, e.g. using WARN_ON_ONCE(). However, that might have a runtime
> overhead. Another possibility is to follow the example of kernfs and to use
> a lockdep map and lockdep_assert_held(). There might be other alternatives I
> have not thought of.

Oh, I'd just do straight-forward lockdep annotation on
queue_enter/exit functions and provide the necessary assert helpers.

Thanks.

-- 
tejun
