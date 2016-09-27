Return-Path: <vgoyal@redhat.com>
Date: Tue, 27 Sep 2016 08:57:22 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Hou Tao <houtao1@huawei.com>
Subject: Re: [PATCH] blk-throttle: fix infinite throttling caused by
 non-cascading timer wheel
Message-ID: <20160927125722.GA30881@redhat.com>
References: <1473662730-184701-1-git-send-email-houtao1@huawei.com>
 <20160913134646.GA19320@redhat.com>
 <20160919210645.GE12537@redhat.com>
 <61ec807a-96ed-5363-7e0c-0ee46c3b70f4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <61ec807a-96ed-5363-7e0c-0ee46c3b70f4@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 19, 2016 at 03:11:10PM -0600, Jens Axboe wrote:
> On 09/19/2016 03:06 PM, Vivek Goyal wrote:
> > On Tue, Sep 13, 2016 at 09:46:46AM -0400, Vivek Goyal wrote:
> > > 
> > > Hi Hou Tao,
> > > 
> > > [ CC Tejun and Thomas ]
> > > 
> > > Thanks for the patch. I can reproduce it. I am wondering that why are you
> > > doing so many checks. Can't we just check if throttle group is empty or
> > > not. If it is empty and slice has expired, then start a new slice. If
> > > throttle group is not empty, then we know slice has to be an active slice
> > > and should be extended (despite the fact that it might have expired
> > > because timer function got called later than we expected it to be).
> > > 
> > > Can you please try following patch. It seems to resolve the issue for me.
> > > 
> > > Vivek
> > 
> > Hi Jens,
> > 
> > Can you please pick this patch. It seems to fix the reported issued.
> > Please let me know if you prefer a separate posting.
> 
> I'll apply it, thanks Vivek.

Hi Jens,

Did you get a chance to apply this one. Can't find it in for-next branch.

Vivek
