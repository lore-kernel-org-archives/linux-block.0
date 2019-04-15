Return-Path: <SRS0=7FI7=SR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10634C10F0E
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 16:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7232183F
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 16:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfDOQBc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:01:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:44186 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725997AbfDOQBc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Apr 2019 12:01:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B9064AFF4;
        Mon, 15 Apr 2019 16:01:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 07B451E09BA; Mon, 15 Apr 2019 18:01:30 +0200 (CEST)
Date:   Mon, 15 Apr 2019 18:01:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Yufen Yu <yuyufen@huawei.com>, axboe@kernel.dk, jack@suse.cz,
        viro@zeniv.linux.org.uk, bart.vanassche@wdc.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v3] block: fix use-after-free on gendisk
Message-ID: <20190415160130.GG13684@quack2.suse.cz>
References: <20190402120634.51040-1-yuyufen@huawei.com>
 <1555343795.161891.103.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555343795.161891.103.camel@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon 15-04-19 08:56:35, Bart Van Assche wrote:
> On Tue, 2019-04-02 at 20:06 +0800, Yufen Yu wrote:
> > diff --git a/block/genhd.c b/block/genhd.c
> > index 961b2bc4634f..a4ef0068dbb2 100644
> > --- a/block/genhd.c
> > +++ b/block/genhd.c
> > @@ -529,6 +529,18 @@ void blk_free_devt(dev_t devt)
> >         }
> >  }
> >  
> > +/**
> > + *     We invalidate devt by assigning NULL pointer for devt in idr.
> > + */
> > +void blk_invalidate_devt(dev_t devt)
> > +{
> > +       if (MAJOR(devt) == BLOCK_EXT_MAJOR) {
> > +               spin_lock_bh(&ext_devt_lock);
> > +               idr_replace(&ext_devt_idr, NULL, blk_mangle_minor(MINOR(devt)));
> > +               spin_unlock_bh(&ext_devt_lock);
> > +       }
> > +}
> 
> Did you perhaps copy the above code from blk_free_devt()? If so, please
> modify blk_free_devt() such that it calls blk_invalidate_devt() instead
> of introducing a copy of most of blk_free_devt().

I guess you've misread the patch. blk_free_devt() does idr_remove(). Here
we do idr_replace(). Subtle difference but an important one!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
