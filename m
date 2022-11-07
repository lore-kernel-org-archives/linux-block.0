Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AADC4332F
	for <linux-block@archiver.kernel.org>; Mon,  7 Nov 2022 19:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbiKGTza (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Nov 2022 14:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiKGTz3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Nov 2022 14:55:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5917320BEC
        for <linux-block@vger.kernel.org>; Mon,  7 Nov 2022 11:55:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A05026129B
        for <linux-block@vger.kernel.org>; Mon,  7 Nov 2022 19:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D429DC433C1;
        Mon,  7 Nov 2022 19:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667850926;
        bh=XXbCNstRl7sDheKpIsNu9w1XnHJ9vgekKGo3X2oGw/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jUhf+bnkr6YHmzBjuWaxzTbkwzB/toalkTgOW+87vDzRHoM1z/SxX63Vk7S+AjXg/
         vlbmwgchva+VGkbjU40QV5HGw13dppMEnzGiBPHGTosllwofuB1QJpI/Lk0VdSonR6
         xvEJZrvpomIAJeOXeHOFxBxnkmdcc/fGt0PKVsrGr3Bfk6bxyz9AU6umsAzhjL6kHb
         oH1V9bcwTbT957C3khvBOpnryeuu9wpm29qEx/pbPyaPZo270HeC7ZdFqB1QJpl21M
         Rc0R4kj0FDjKyw+NzA0KZqDy9eLDYv1X6HPY9XRMHHvJi1vEi6YkR1qza82U/9aTOL
         YS6K39D0DqiDw==
Date:   Mon, 7 Nov 2022 11:55:24 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/3] blk-crypto: pass a gendisk to
 blk_crypto_sysfs_register
Message-ID: <Y2lirLd1Gxs6+HEd@sol.localdomain>
References: <20221105080815.775721-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221105080815.775721-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Nov 05, 2022 at 09:08:13AM +0100, Christoph Hellwig wrote:
> Prepare for changes to the block layer sysfs handling by passing the
> readily available gendisk to blk_crypto_sysfs_register.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-crypto-internal.h | 4 ++--
>  block/blk-crypto-sysfs.c    | 3 ++-
>  block/blk-sysfs.c           | 2 +-
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
> index e6818ffaddbf8..32990299dace1 100644
> --- a/block/blk-crypto-internal.h
> +++ b/block/blk-crypto-internal.h
> @@ -21,7 +21,7 @@ extern const struct blk_crypto_mode blk_crypto_modes[];
>  
>  #ifdef CONFIG_BLK_INLINE_ENCRYPTION
>  
> -int blk_crypto_sysfs_register(struct request_queue *q);
> +int blk_crypto_sysfs_register(struct gendisk *disk);
>  
>  void blk_crypto_sysfs_unregister(struct request_queue *q);

Shouldn't blk_crypto_sysfs_unregister() be updated to match?

- Eric
