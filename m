Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B92C433DB
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 10:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA11E64F60
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 10:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbhBDKHT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 05:07:19 -0500
Received: from mx4.veeam.com ([104.41.138.86]:38260 "EHLO mx4.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235302AbhBDKHT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Feb 2021 05:07:19 -0500
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id EDA60874F7;
        Thu,  4 Feb 2021 13:06:34 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx4;
        t=1612433195; bh=9Db75ZmRMikGsOb+9U+OZ6pWHWJ+9SIXaqigvPh1SI0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To:From;
        b=eIf5dY0lfRBubBO9VnQNP7z8iz0Yx+z2D5HAsbDslBCHXhi0iUpuzKPO7pL0AfGAW
         kb4skIYCVq5plycqMBaJThxdvQIznk/yrh5RdfUJyNcOsT8W8pF2nGDK3RhVxMhklc
         5Ob57DAQeYPu/qggU2pwnM3/XAQhSJyielDmR9XU=
Received: from veeam.com (172.24.14.5) by prgmbx01.amust.local (172.24.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Thu, 4 Feb 2021
 11:06:33 +0100
Date:   Thu, 4 Feb 2021 13:06:31 +0300
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     Mike Snitzer <snitzer@redhat.com>
CC:     <Damien.LeMoal@wdc.com>, <hare@suse.de>, <ming.lei@redhat.com>,
        <agk@redhat.com>, <corbet@lwn.net>, <axboe@kernel.dk>,
        <jack@suse.cz>, <johannes.thumshirn@wdc.com>,
        <gregkh@linuxfoundation.org>, <koct9i@gmail.com>, <steve@sk2.org>,
        <dm-devel@redhat.com>, <linux-block@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pavgel.tide@veeam.com>
Subject: Re: [PATCH v4 2/6] block: add blk_interposer
Message-ID: <20210204100631.GB4325@veeam.com>
References: <1612367638-3794-1-git-send-email-sergei.shtepa@veeam.com>
 <1612367638-3794-3-git-send-email-sergei.shtepa@veeam.com>
 <20210203161836.GB21359@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20210203161836.GB21359@redhat.com>
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx01.amust.local (172.24.0.171) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29C604D265667362
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The 02/03/2021 11:18, Mike Snitzer wrote:
> On Wed, Feb 03 2021 at 10:53am -0500,
> Sergei Shtepa <sergei.shtepa@veeam.com> wrote:
> 
> > blk_interposer allows to intercept bio requests, remap bio to another devices or add new bios.
> > 
> > Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
> > ---
> >  block/bio.c               |  2 +
> >  block/blk-core.c          | 33 ++++++++++++++++
> >  block/genhd.c             | 82 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/blk_types.h |  6 ++-
> >  include/linux/genhd.h     | 18 +++++++++
> >  5 files changed, 139 insertions(+), 2 deletions(-)
> > 
> > diff --git a/block/bio.c b/block/bio.c
> > index 1f2cc1fbe283..f6f135eb84b5 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -684,6 +684,8 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
> >  	bio_set_flag(bio, BIO_CLONED);
> >  	if (bio_flagged(bio_src, BIO_THROTTLED))
> >  		bio_set_flag(bio, BIO_THROTTLED);
> > +	if (bio_flagged(bio_src, BIO_INTERPOSED))
> > +		bio_set_flag(bio, BIO_INTERPOSED);
> >  	bio->bi_opf = bio_src->bi_opf;
> >  	bio->bi_ioprio = bio_src->bi_ioprio;
> >  	bio->bi_write_hint = bio_src->bi_write_hint;
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index 7663a9b94b80..c84bc42ba88b 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -1032,6 +1032,32 @@ static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
> >  	return ret;
> >  }
> >  
> > +static blk_qc_t __submit_bio_interposed(struct bio *bio)
> > +{
> > +	struct bio_list bio_list[2] = { };
> > +	blk_qc_t ret = BLK_QC_T_NONE;
> > +
> > +	current->bio_list = bio_list;
> > +	if (likely(bio_queue_enter(bio) == 0)) {
> > +		struct gendisk *disk = bio->bi_disk;
> > +
> > +		if (likely(blk_has_interposer(disk))) {
> > +			bio_set_flag(bio, BIO_INTERPOSED);
> > +			disk->interposer->ip_submit_bio(bio);
> > +		} else /* interposer was removed */
> > +			bio_list_add(&current->bio_list[0], bio);
> 
> style nit:
> 
> } else {
> 	/* interposer was removed */
> 	bio_list_add(&current->bio_list[0], bio);
> }
> 
> > +
> > +		blk_queue_exit(disk->queue);
> > +	}
> > +	current->bio_list = NULL;
> > +
> > +	/* Resubmit remaining bios */
> > +	while ((bio = bio_list_pop(&bio_list[0])))
> > +		ret = submit_bio_noacct(bio);
> > +
> > +	return ret;
> > +}
> > +
> >  /**
> >   * submit_bio_noacct - re-submit a bio to the block device layer for I/O
> >   * @bio:  The bio describing the location in memory and on the device.
> > @@ -1057,6 +1083,13 @@ blk_qc_t submit_bio_noacct(struct bio *bio)
> >  		return BLK_QC_T_NONE;
> >  	}
> >  
> > +	/*
> > +	 * Checking the BIO_INTERPOSED flag is necessary so that the bio
> > +	 * created by the blk_interposer do not get to it for processing.
> > +	 */
> > +	if (blk_has_interposer(bio->bi_disk) &&
> > +	    !bio_flagged(bio, BIO_INTERPOSED))
> > +		return __submit_bio_interposed(bio);
> >  	if (!bio->bi_disk->fops->submit_bio)
> >  		return __submit_bio_noacct_mq(bio);
> >  	return __submit_bio_noacct(bio);
> > diff --git a/block/genhd.c b/block/genhd.c
> > index 419548e92d82..39785a3ef703 100644
> > --- a/block/genhd.c
> > +++ b/block/genhd.c
> > @@ -30,6 +30,7 @@
> >  static struct kobject *block_depr;
> >  
> >  DECLARE_RWSEM(bdev_lookup_sem);
> > +DEFINE_MUTEX(bdev_interposer_mutex);
> 
> Seems you're using this mutex to protect access to disk->interposer in
> attach/detach.  This is to prevent attach/detach races to same device?

Yes. There is a probability of 0.00...01% that two different modules will
try to attach/detach to the same disk at the same time.
Since the attach/detach operation is infrequent, using mutex is quite appropriate.
> 
> Thankfully attach/detach isn't in the bio submission fast path but it'd
> be helpful to document what this mutex is protecting).

I'll think about the name of this mutex and add a comment.

> 
> A storm of attach or detach will all hit this global mutex though...
> 
> Mike
> 

Thank you for the review.
I am very interested in your opinion about [PATCH v4 4/6] and [PATCH v4 5/6].
However, the kernel test robot has already found something there on sparc.

-- 
Sergei Shtepa
Veeam Software developer.
