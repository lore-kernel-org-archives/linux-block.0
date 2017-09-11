Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 11 Sep 2017 09:37:56 -0700
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>, "neilb@suse.com" <neilb@suse.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"cl@linux.com" <cl@linux.com>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 1/5] percpu-refcount: Introduce
 percpu_ref_switch_to_atomic_nowait()
Message-ID: <20170911163756.GF1774378@devbig577.frc2.facebook.com>
References: <20170908235226.26622-1-bart.vanassche@wdc.com>
 <20170908235226.26622-2-bart.vanassche@wdc.com>
 <20170911131331.GE1774378@devbig577.frc2.facebook.com>
 <1505146151.2802.21.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1505146151.2802.21.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Mon, Sep 11, 2017 at 04:09:12PM +0000, Bart Van Assche wrote:
> On Mon, 2017-09-11 at 06:13 -0700, Tejun Heo wrote:
> > On Fri, Sep 08, 2017 at 04:52:22PM -0700, Bart Van Assche wrote:
> > > The blk-mq core keeps track of the number of request queue users
> > > through q->q_usage_count. Make it possible to switch this counter
> > > to atomic mode from the context of the block layer power management
> > > code by introducing percpu_ref_switch_to_atomic_nowait().
> > 
> > Do you ever have to switch back?  If so, how do you know whether the
> > previous transition finished?
> 
> The way I would like to use this function is to check for completion of the
> transition by calling percpu_ref_is_zero(). That function namely not only
> checks the value of the refcount but also whether it is in atomic mode. See
> also "[PATCH 5/5] blk-mq: Implement power management support"
> (https://www.spinics.net/lists/linux-block/msg17143.html). Do you think this
> will work?

Probably but that sounds really hairy.  I'd much prefer if it could be
done through the usual kill / confirm / release and re-init.  That's
not a possibility?

Thanks.

-- 
tejun
