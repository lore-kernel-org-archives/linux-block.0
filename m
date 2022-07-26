Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1D1C433EF
	for <linux-block@archiver.kernel.org>; Tue, 26 Jul 2022 00:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiGZAm6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Jul 2022 20:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiGZAm5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jul 2022 20:42:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5919B1B785
        for <linux-block@vger.kernel.org>; Mon, 25 Jul 2022 17:42:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06986B810A9
        for <linux-block@vger.kernel.org>; Tue, 26 Jul 2022 00:42:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B54EC341C6;
        Tue, 26 Jul 2022 00:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658796172;
        bh=ZlSVJLVS3OvshiLyljYYOOWIc2+jTRy8oIB7PoNcYM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dj4yVxm58YeOMAiN5x0XaxO5k9P+0YKyko2ZwR0DQBze4PYhJn+ZZErSRpo+swcGB
         Ua6LTEO0gTgQhoKV1YABSTnIS5eFVD46OT9qKFH6nnJK4hOR9PwDWjFleoGdl4ZeW5
         KqsyRmtojwmdoQvRnzYK9NycEuZQWyKbxFO6I9kdt6gAIRyIcqU/2oT5tL7hsEacEN
         SOBoJi6HD8yj9VrKCAlaW3Rj7hSCz7rFrHn899xCuiOkWbAfphNkrHR+VojL8ONlay
         f+MYyMGGkZTxeFTSdeLpqC1lQOthw/fiv12XKo9GAsLEgJlD05UpwMfGz2B0n6J1GN
         0KkqGLq3BxxAw==
Date:   Mon, 25 Jul 2022 17:42:50 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Israel Rukshin <israelr@nvidia.com>
Cc:     Linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Nitzan Carmi <nitzanc@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH 1/1] block: Add support for setting inline encryption key
 per block device
Message-ID: <Yt84ihS95qsGWv1K@sol.localdomain>
References: <1658316391-13472-1-git-send-email-israelr@nvidia.com>
 <1658316391-13472-2-git-send-email-israelr@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658316391-13472-2-git-send-email-israelr@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 20, 2022 at 02:26:31PM +0300, Israel Rukshin wrote:
> +static int blk_crypto_ioctl_create_key(struct request_queue *q,
> +				       void __user *argp)
> +{
> +	struct blk_crypto_set_key_arg arg;
> +	u8 raw_key[BLK_CRYPTO_MAX_KEY_SIZE];
> +	struct blk_crypto_key *blk_key;
> +	int ret;
> +
> +	if (copy_from_user(&arg, argp, sizeof(arg)))
> +		return -EFAULT;
> +
> +	if (memchr_inv(arg.reserved, 0, sizeof(arg.reserved)))
> +		return -EINVAL;
> +
> +	if (!arg.raw_key_size)
> +		return blk_crypto_destroy_default_key(q);
> +
> +	if (q->blk_key) {
> +		pr_err("Crypto key is already configured\n");
> +		return -EBUSY;
> +	}

Doesn't this need locking so that multiple executions of this ioctl can't run on
the block device at the same time?

Also, the key is actually being associated with the request_queue.  I thought it
was going to be the block_device?  Doesn't it have to be the block_device so
that different partitions on the same disk can have different settings?

Also, the pr_err should be removed.  Likewise in several places below.

> +
> +	if (arg.raw_key_size > sizeof(raw_key))
> +		return -EINVAL;
> +
> +	if (arg.data_unit_size > queue_logical_block_size(q)) {
> +		pr_err("Data unit size is bigger than logical block size\n");
> +		return -EINVAL;
> +	}
> +
> +	if (copy_from_user(raw_key, u64_to_user_ptr(arg.raw_key_ptr),
> +			   arg.raw_key_size)) {
> +		ret = -EFAULT;
> +		goto err;
> +	}
> +
> +	blk_key = kzalloc(sizeof(*blk_key), GFP_KERNEL);
> +	if (!blk_key) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	ret = blk_crypto_init_key(blk_key, raw_key, arg.crypto_mode,
> +				  sizeof(u64), arg.data_unit_size);
> +	if (ret) {
> +		pr_err("Failed to init inline encryption key\n");
> +		goto key_err;
> +	}
> +
> +	/* Block key size is taken from crypto mode */
> +	if (arg.raw_key_size != blk_key->size) {
> +		ret = -EINVAL;
> +		goto key_err;
> +	}

The key size check above happens too late.  The easiest solution would be to add
the key size as an argument to blk_crypto_init_key(), and make it validate the
key size.

> +	}
> +	blk_key->q = q;
> +	q->blk_key = blk_key;

How does this interact with concurrent I/O?  Also, doesn't the block device's
page cache need to be invalidated when a key is set or removed?

> diff --git a/include/uapi/linux/blk-crypto.h b/include/uapi/linux/blk-crypto.h
> new file mode 100644
> index 000000000000..5a65ebaf6038
> --- /dev/null
> +++ b/include/uapi/linux/blk-crypto.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +
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

Instead of an enum, these should use #define's with explicit numbers.  Also,
INVALID and MAX shouldn't be included.

> +
> +#endif /* __UAPI_LINUX_BLK_CRYPTO_H */
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index bdf7b404b3e7..398a77895e96 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -121,6 +121,14 @@ struct fsxattr {
>  	unsigned char	fsx_pad[8];
>  };
>  
> +struct blk_crypto_set_key_arg {
> +	__u32 crypto_mode;
> +	__u64 raw_key_ptr;
> +	__u32 raw_key_size;
> +	__u32 data_unit_size;
> +	__u32 reserved[9];	/* must be zero */
> +};

The reserved fields should be __u64 so that it's easy to use them for pointers
or other 64-bit data later if it becomes necessary.  Also, reserved fields
should also be prefixed with "__".  Also, a padding field is needed between
crypto_mode and raw_key_ptr.  Also, it would be a good idea to make the reserved
space even larger, as people may want to add all sorts of weird settings here in
the future (look at dm-crypt).

The following might be good; it makes the whole struct a nice round size, 128
bytes:

struct blk_crypto_set_key_arg {
	__u32 crypto_mode;
	__u32 __reserved1;
	__u64 raw_key_ptr;
	__u32 raw_key_size;
	__u32 data_unit_size;
	__u64 __reserved2[13];
};

- Eric
