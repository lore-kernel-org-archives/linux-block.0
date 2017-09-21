Return-Path: <zhangweiping@didichuxing.com>
Date: Fri, 22 Sep 2017 01:12:31 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] blk-sysfs: return EINVAL when user modify
 nr_request less than BLKDEV_MIN_RQ
Message-ID: <20170921171231.GB2009@localhost.didichuxing.com>
References: <cover.1506006064.git.zhangweiping@didichuxing.com>
 <da25b8d7b8ddd34e6e5f62f8c001f551ff3f1e04.1506006064.git.zhangweiping@didichuxing.com>
 <efeb86f4-2752-975b-a5c9-bd08deb7fd21@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <efeb86f4-2752-975b-a5c9-bd08deb7fd21@kernel.dk>
Return-Path: zhangweiping@didichuxing.com
List-ID: <linux-block@vger.kernel.org>

On Thu, Sep 21, 2017 at 10:38:22AM -0600, Jens Axboe wrote:
> On 09/21/2017 09:17 AM, weiping zhang wrote:
> > Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
> > ---
> >  block/blk-sysfs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> > index b8362c0..03a6e19 100644
> > --- a/block/blk-sysfs.c
> > +++ b/block/blk-sysfs.c
> > @@ -75,7 +75,7 @@ queue_requests_store(struct request_queue *q, const char *page, size_t count)
> >  		return ret;
> >  
> >  	if (nr < BLKDEV_MIN_RQ)
> > -		nr = BLKDEV_MIN_RQ;
> > +		return -EINVAL;
> 
> This is potentially breaking existing scripts.
> 
I just want this keep same behavior with the too larger case, If this
may make other side effect, I drop this patch.

Thanks
weiping
