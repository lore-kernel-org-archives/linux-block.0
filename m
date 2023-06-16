Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2383AEB64D7
	for <linux-block@archiver.kernel.org>; Fri, 16 Jun 2023 11:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240464AbjFPLxC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Jun 2023 07:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344397AbjFPLxB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2023 07:53:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C55191;
        Fri, 16 Jun 2023 04:52:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8799763810;
        Fri, 16 Jun 2023 11:52:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538D6C433C9;
        Fri, 16 Jun 2023 11:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686916378;
        bh=vLi/Ctgz4882UqtH6fdv5YzHK0VG2XkpSMNA82BO34A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JZ4veK4EM7+Drhrqe3EyyEUcnY6OgSUIEC7RF1MHwJu+WzBt9DEbjvnkfxJe79VN+
         Ou6mweWotByj1Kulm6TEnmAvJkLNzSFElkCx0xCySJShFtFaejz95r8dXwVj6X7HiR
         lFvLJx1TsvYupHgIbqKsaj051h8g8zA7tzAowgCc/jLmFTHNXzwG3d6dfXAuWMo4bV
         ipYTECvuzi4e2N/EOKcQkF4BAC1WROnIVxG7p/1zfmOzXQZl7McORump73TNOxkpk6
         CYGRPzKA5CBgUKflc2qZm4tOrw0xyr5owilv4yiWPgMMdpj+RNMEeGdhGPTCituBpT
         JtaEAN/3B8l2w==
Message-ID: <5b0eaf1d-60b1-532e-7d12-c67810541902@kernel.org>
Date:   Fri, 16 Jun 2023 20:52:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3] block: add capacity validation in bdev_add_partition()
Content-Language: en-US
To:     "min.li" <min15.li@samsung.com>, axboe@kernel.dk,
        willy@infradead.org, hch@lst.de, gregkh@linuxfoundation.org,
        wsa@kernel.org, vkoul@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20230616092054epcas5p340e977377808d2df7210dc4a7d6c1d8e@epcas5p3.samsung.com>
 <20230616171913.13045-1-min15.li@samsung.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230616171913.13045-1-min15.li@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/17/23 02:19, min.li wrote:
> In the function bdev_add_partition(),there is no check that the start
> and end sectors exceed the size of the disk before calling add_partition.
> When we call the block's ioctl interface directly to add a partition,
> and the capacity of the disk is set to 0 by driver,the command will
> continue to execute.
> 
> Signed-off-by: min.li <min15.li@samsung.com>

I am guessing this should be:

Signed-off-by: Min Li <min15.li@samsung.com>

No ? The signed-off-by tag, and any other tag, must have your full name
correctly written.

> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> ---
> Changes from v1:
> 
> - Check for overflows of the start + length value.
> - Place the capacity check at the beginning of the function.
> 
> Changes from v2:
> 
> - Place the assignment on the first line and merge the two lines into one.
> - Modify the singed name.
> ---
>  block/partitions/core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index 49e0496ff23c..b511f88bf558 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -436,10 +436,21 @@ static bool partition_overlaps(struct gendisk *disk, sector_t start,
>  int bdev_add_partition(struct gendisk *disk, int partno, sector_t start,
>  		sector_t length)
>  {
> +	sector_t capacity = get_capacity(disk), end;
>  	struct block_device *part;
>  	int ret;
>  
>  	mutex_lock(&disk->open_mutex);
> +	if (check_add_overflow(start, length, &end)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (start >= capacity || end > capacity) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
>  	if (!disk_live(disk)) {
>  		ret = -ENXIO;
>  		goto out;

-- 
Damien Le Moal
Western Digital Research

