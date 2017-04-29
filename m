Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59856 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755599AbdD2LAv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Apr 2017 07:00:51 -0400
Date: Sat, 29 Apr 2017 19:00:44 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "osandov@fb.com" <osandov@fb.com>
Subject: Re: [PATCH 4/4] blk-mq: dump new introduced flag of
 BLK_MQ_F_SCHED_USE_HW_TAG
Message-ID: <20170429110043.GE12421@ming.t460p>
References: <20170428151539.25514-1-ming.lei@redhat.com>
 <20170428151539.25514-5-ming.lei@redhat.com>
 <1493403021.2767.11.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1493403021.2767.11.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Apr 28, 2017 at 06:10:22PM +0000, Bart Van Assche wrote:
> On Fri, 2017-04-28 at 23:15 +0800, Ming Lei wrote:
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-mq-debugfs.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> > index bcd2a7d4a3a5..bc390847a60d 100644
> > --- a/block/blk-mq-debugfs.c
> > +++ b/block/blk-mq-debugfs.c
> > @@ -220,6 +220,7 @@ static const char *const hctx_flag_name[] = {
> >  	[ilog2(BLK_MQ_F_SG_MERGE)]	= "SG_MERGE",
> >  	[ilog2(BLK_MQ_F_BLOCKING)]	= "BLOCKING",
> >  	[ilog2(BLK_MQ_F_NO_SCHED)]	= "NO_SCHED",
> > +	[ilog2(BLK_MQ_F_SCHED_USE_HW_TAG)]	= "SCHED_USE_HW_TAG",
> >  };
> >  
> >  static int hctx_flags_show(struct seq_file *m, void *v)
> 
> Hello Ming,
> 
> Please combine patches 1/4 and 4/4.

OK!


Thanks,
Ming
