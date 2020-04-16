Return-Path: <SRS0=Ef4g=6A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FEBC2BB55
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 12:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 583D420767
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 12:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634759AbgDPMCa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Apr 2020 08:02:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:38838 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2634772AbgDPMC1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Apr 2020 08:02:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 92035ABF4;
        Thu, 16 Apr 2020 12:02:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F342B1E1250; Thu, 16 Apr 2020 14:02:23 +0200 (CEST)
Date:   Thu, 16 Apr 2020 14:02:23 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, tj@kernel.org,
        jack@suse.cz, bvanassche@acm.org, tytso@mit.edu,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] bdi: add a ->dev_name field to struct
 backing_dev_info
Message-ID: <20200416120223.GI23739@quack2.suse.cz>
References: <20200416071519.807660-1-hch@lst.de>
 <20200416071519.807660-4-hch@lst.de>
 <5bfcd35a-2463-3769-be93-911c4e3c38bb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bfcd35a-2463-3769-be93-911c4e3c38bb@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 16-04-20 16:34:13, Yufen Yu wrote:
> Hi,
> 
> On 2020/4/16 15:15, Christoph Hellwig wrote:
> > Cache a copy of the name for the life time of the backing_dev_info
> > structure so that we can reference it even after unregistering.
> > 
> > Fixes: 68f23b89067f ("memcg: fix a crash in wb_workfn when a device disappears")
> > Reported-by: Yufen Yu <yuyufen@huawei.com>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >   include/linux/backing-dev-defs.h |  1 +
> >   mm/backing-dev.c                 | 13 ++++++++++---
> >   2 files changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
> > index 4fc87dee005a..249590bcccf7 100644
> > --- a/include/linux/backing-dev-defs.h
> > +++ b/include/linux/backing-dev-defs.h
> > @@ -220,6 +220,7 @@ struct backing_dev_info {
> >   	wait_queue_head_t wb_waitq;
> >   	struct device *dev;
> > +	const char *dev_name;
> >   	struct device *owner;
> >   	struct timer_list laptop_mode_wb_timer;
> > diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> > index c2c44c89ee5d..4f6c05df72f9 100644
> > --- a/mm/backing-dev.c
> > +++ b/mm/backing-dev.c
> > @@ -938,9 +938,15 @@ int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
> >   	if (bdi->dev)	/* The driver needs to use separate queues per device */
> >   		return 0;
> > -	dev = device_create_vargs(bdi_class, NULL, MKDEV(0, 0), bdi, fmt, args);
> > -	if (IS_ERR(dev))
> > +	bdi->dev_name = kvasprintf(GFP_KERNEL, fmt, args);
> > +	if (!bdi->dev_name)
> > +		return -ENOMEM;
> > +
> > +	dev = device_create(bdi_class, NULL, MKDEV(0, 0), bdi, bdi->dev_name);
> > +	if (IS_ERR(dev)) {
> > +		kfree(bdi->dev_name);
> >   		return PTR_ERR(dev);
> > +	}
> >   	cgwb_bdi_register(bdi);
> >   	bdi->dev = dev;
> > @@ -1034,6 +1040,7 @@ static void release_bdi(struct kref *ref)
> >   	WARN_ON_ONCE(bdi->dev);
> >   	wb_exit(&bdi->wb);
> >   	cgwb_bdi_exit(bdi);
> > +	kfree(bdi->dev_name);
> >   	kfree(bdi);
> >   }
> 
> 
> When driver try to to re-register bdi but without release_bdi(), the old
> dev_name will be cover directly by the newer in bdi_register_va(). So, I
> am not sure whether it can cause memory leak for bdi->dev_name.

Yes, that can indeed happen. E.g. I remember that drivers/scsi/sd.c calls
device_add_disk() + del_gendisk() repeatedly for one request_queue and that
would result in leaking the name (and possibly cause use-after-free
issues). I think dev_name has to be just a static array inside
backing_dev_info which gets overwritten on reregistration. The question is
how big should be this array... Some grepping shows that 40 bytes should be
enough for everybody except fs/vboxsf/super.c which puts 'fc->source' into
the name which can be presumably rather large. Anyway, I'd make it 40 and
just truncate it case in case it does not fit. bdi_dev_name() is used for
informational purposes anyway...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
