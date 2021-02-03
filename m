Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D137C433E6
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 16:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DF1564F7E
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 16:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbhBCQUT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Feb 2021 11:20:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59674 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233683AbhBCQUQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Feb 2021 11:20:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612369130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M/MGhUnU/5e7dA2ClMOCmGk1NNyNlDc/BZFcD6gBEds=;
        b=DMam+PJWtP5VRi3e402NAJbuOQPrjm5LUy8DCg2MDzcSXFPE0+gHBakIZ2wQO9z0RAGFQR
        eSLv9ZwTB3g5nGekhUpYorgMMLqLI7txeMLbh8FB+6obMmEOrnzQPM8UV6MSrvW48LmWlC
        0unI9HpGFybIRDTMFTm1c8a1p/NxNa8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-D2m6RiGDN0arEoEDfvYHLg-1; Wed, 03 Feb 2021 11:18:45 -0500
X-MC-Unique: D2m6RiGDN0arEoEDfvYHLg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EA36801960;
        Wed,  3 Feb 2021 16:18:43 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 02FAC1971C;
        Wed,  3 Feb 2021 16:18:36 +0000 (UTC)
Date:   Wed, 3 Feb 2021 11:18:36 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     Damien.LeMoal@wdc.com, hare@suse.de, ming.lei@redhat.com,
        agk@redhat.com, corbet@lwn.net, axboe@kernel.dk, jack@suse.cz,
        johannes.thumshirn@wdc.com, gregkh@linuxfoundation.org,
        koct9i@gmail.com, steve@sk2.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavgel.tide@veeam.com
Subject: Re: [PATCH v4 2/6] block: add blk_interposer
Message-ID: <20210203161836.GB21359@redhat.com>
References: <1612367638-3794-1-git-send-email-sergei.shtepa@veeam.com>
 <1612367638-3794-3-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612367638-3794-3-git-send-email-sergei.shtepa@veeam.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 03 2021 at 10:53am -0500,
Sergei Shtepa <sergei.shtepa@veeam.com> wrote:

> blk_interposer allows to intercept bio requests, remap bio to another devices or add new bios.
> 
> Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
> ---
>  block/bio.c               |  2 +
>  block/blk-core.c          | 33 ++++++++++++++++
>  block/genhd.c             | 82 +++++++++++++++++++++++++++++++++++++++
>  include/linux/blk_types.h |  6 ++-
>  include/linux/genhd.h     | 18 +++++++++
>  5 files changed, 139 insertions(+), 2 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 1f2cc1fbe283..f6f135eb84b5 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -684,6 +684,8 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
>  	bio_set_flag(bio, BIO_CLONED);
>  	if (bio_flagged(bio_src, BIO_THROTTLED))
>  		bio_set_flag(bio, BIO_THROTTLED);
> +	if (bio_flagged(bio_src, BIO_INTERPOSED))
> +		bio_set_flag(bio, BIO_INTERPOSED);
>  	bio->bi_opf = bio_src->bi_opf;
>  	bio->bi_ioprio = bio_src->bi_ioprio;
>  	bio->bi_write_hint = bio_src->bi_write_hint;
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 7663a9b94b80..c84bc42ba88b 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1032,6 +1032,32 @@ static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
>  	return ret;
>  }
>  
> +static blk_qc_t __submit_bio_interposed(struct bio *bio)
> +{
> +	struct bio_list bio_list[2] = { };
> +	blk_qc_t ret = BLK_QC_T_NONE;
> +
> +	current->bio_list = bio_list;
> +	if (likely(bio_queue_enter(bio) == 0)) {
> +		struct gendisk *disk = bio->bi_disk;
> +
> +		if (likely(blk_has_interposer(disk))) {
> +			bio_set_flag(bio, BIO_INTERPOSED);
> +			disk->interposer->ip_submit_bio(bio);
> +		} else /* interposer was removed */
> +			bio_list_add(&current->bio_list[0], bio);

style nit:

} else {
	/* interposer was removed */
	bio_list_add(&current->bio_list[0], bio);
}

> +
> +		blk_queue_exit(disk->queue);
> +	}
> +	current->bio_list = NULL;
> +
> +	/* Resubmit remaining bios */
> +	while ((bio = bio_list_pop(&bio_list[0])))
> +		ret = submit_bio_noacct(bio);
> +
> +	return ret;
> +}
> +
>  /**
>   * submit_bio_noacct - re-submit a bio to the block device layer for I/O
>   * @bio:  The bio describing the location in memory and on the device.
> @@ -1057,6 +1083,13 @@ blk_qc_t submit_bio_noacct(struct bio *bio)
>  		return BLK_QC_T_NONE;
>  	}
>  
> +	/*
> +	 * Checking the BIO_INTERPOSED flag is necessary so that the bio
> +	 * created by the blk_interposer do not get to it for processing.
> +	 */
> +	if (blk_has_interposer(bio->bi_disk) &&
> +	    !bio_flagged(bio, BIO_INTERPOSED))
> +		return __submit_bio_interposed(bio);
>  	if (!bio->bi_disk->fops->submit_bio)
>  		return __submit_bio_noacct_mq(bio);
>  	return __submit_bio_noacct(bio);
> diff --git a/block/genhd.c b/block/genhd.c
> index 419548e92d82..39785a3ef703 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -30,6 +30,7 @@
>  static struct kobject *block_depr;
>  
>  DECLARE_RWSEM(bdev_lookup_sem);
> +DEFINE_MUTEX(bdev_interposer_mutex);

Seems you're using this mutex to protect access to disk->interposer in
attach/detach.  This is to prevent attach/detach races to same device?

Thankfully attach/detach isn't in the bio submission fast path but it'd
be helpful to document what this mutex is protecting).

A storm of attach or detach will all hit this global mutex though...

Mike

