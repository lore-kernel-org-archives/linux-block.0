Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2585C43334
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 12:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbiGUMvX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 08:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbiGUMvW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 08:51:22 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF93332DB3
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 05:51:21 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D066768AFE; Thu, 21 Jul 2022 14:51:17 +0200 (CEST)
Date:   Thu, 21 Jul 2022 14:51:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Israel Rukshin <israelr@nvidia.com>
Cc:     Linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Eric Biggers <ebiggers@kernel.org>,
        Nitzan Carmi <nitzanc@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH 1/1] block: Add support for setting inline encryption
 key per block device
Message-ID: <20220721125117.GB20555@lst.de>
References: <1658316391-13472-1-git-send-email-israelr@nvidia.com> <1658316391-13472-2-git-send-email-israelr@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658316391-13472-2-git-send-email-israelr@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +	if (bc->bc_key->q)
> +		atomic_inc(&bc->bc_key->q->blk_key_use_count);
>  }

I don't think a global atomic for each I/O is a good idea.

> +static int blk_crypto_destroy_default_key(struct request_queue *q)
> +{
> +	int ret;
> +
> +	if (!q->blk_key)
> +		return 0;
> +
> +	blk_mq_freeze_queue(q);
> +	blk_mq_quiesce_queue(q);
> +	if (atomic_read(&q->blk_key_use_count)) {

But once the queue is frozen all I/O is gone at least for blk-mq
drivers, so I don't think we'll need this as long as we limit
the feature to blk-mq drivers.  Eventually we'll need to make
blk_mq_freeze_queue also track outstanding I/Os on bio based
drivers, in which case it will work there as well.

Alternatively we can support evicting the key only if the device
is not otherwise opened only.

> +	if (q->blk_key) {
> +		pr_err("Crypto key is already configured\n");
> +		return -EBUSY;
> +	}

Don't we nee locking to make this check race free?

> +	switch (cmd) {
> +	case BLKCRYPTOSETKEY:
> +		if (mode & FMODE_EXCL)
> +			return blk_crypto_ioctl_create_key(q, argp);
> +
> +		if (IS_ERR(blkdev_get_by_dev(bdev->bd_dev, mode | FMODE_EXCL,
> +					     &bdev)))
> +			return -EBUSY;
> +		ret = blk_crypto_ioctl_create_key(q, argp);
> +		blkdev_put(bdev, mode | FMODE_EXCL);

I think we can just safely require an FMODE_EXCL open here.

>  #ifdef CONFIG_BLK_INLINE_ENCRYPTION
>  	struct blk_crypto_profile *crypto_profile;
>  	struct kobject *crypto_kobject;
> +	struct blk_crypto_key *blk_key;
> +	atomic_t blk_key_use_count;
>  #endif

Both the existing and new fields really should go into the gendisk,
but I think we need to clean up the existing bits first

> +#ifndef __UAPI_LINUX_BLK_CRYPTO_H
> +#define __UAPI_LINUX_BLK_CRYPTO_H
> +
> +enum blk_crypto_mode_num {
> +	BLK_ENCRYPTION_MODE_INVALID,
> +	BLK_ENCRYPTION_MODE_AES_256_XTS,
> +	BLK_ENCRYPTION_MODE_AES_128_CBC_ESSIV,
> +	BLK_ENCRYPTION_MODE_ADIANTUM,
> +	BLK_ENCRYPTION_MODE_MAX,
> +};

Please make these #defines so that userspace can probe for newly
added ones.  a _MAX value should not be part of the uapi headers.

> +struct blk_crypto_set_key_arg {

Why is this in fs.h and not the new blk-cryto uapi header?
