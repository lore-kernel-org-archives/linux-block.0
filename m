Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A0AEB64D9
	for <linux-block@archiver.kernel.org>; Mon, 10 Jul 2023 03:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjGJDyy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Jul 2023 23:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGJDyx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Jul 2023 23:54:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE2ED2
        for <linux-block@vger.kernel.org>; Sun,  9 Jul 2023 20:54:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3176760B38
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 03:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E295EC433C8;
        Mon, 10 Jul 2023 03:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688961291;
        bh=nU3ffBEWaeGa+g/w+fIOFK5rD8bAOgNBOmWPTbZKkbQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Tuox4OAYXoDk3DJe8/PPH2kLdCIdDw9UJBVIkUmPm8vJ6V0KNQ+C0MUgDu92k5r9A
         3PjnViuB7KH+pN2UgggViKsOEZIGIgpIn08pKaZay01NL6B3NG7aI4OmHtoWahzOHj
         EuaEIMEH53hlVxQeLfsPioQGSkejSOt4VUqcS+IbUgH3QDAV7deoxw9Vu7OOkfCOru
         f08RnuVy6lW/+rTFe1qTN7b7//oTm3HCKB8nftAyAC4E5ptXNQJI2cgEJy0KQ+b9kg
         6hZN2yG2UaWJSx8nsDPoiVuWS0j+Fzeq9fk724PVLlBXRE6byP/23qediot7Od4Q+o
         YFFz+s0paxEew==
Message-ID: <ea6e5b23-e793-a883-5722-51f2f589f847@kernel.org>
Date:   Mon, 10 Jul 2023 12:54:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/4] nvme: update discard limits in nvme_config_discard
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20230707094616.108430-1-hch@lst.de>
 <20230707094616.108430-3-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230707094616.108430-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/7/23 18:46, Christoph Hellwig wrote:
> nvme_config_discard currently skips updating the discard limits if they
> were set before because blk_queue_max_discard_sectors used to update the
> configurable max_discard_sectors limit unconditionally.  Now that this
> has been fixed we can update the discard limits even if they were set
> to deal with the case of a reset changing the limits after e.g. a
> firmware update.
> 
> Fixes: 3831761eb859 ("nvme: only reconfigure discard if necessary")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Look OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  drivers/nvme/host/core.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 47d7ba2827ff29..2d6c1f4ad7f5c8 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1734,10 +1734,6 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
>  
>  	queue->limits.discard_granularity = size;
>  
> -	/* If discard is already enabled, don't reset queue limits */
> -	if (queue->limits.max_discard_sectors)
> -		return;
> -
>  	blk_queue_max_discard_sectors(queue, ctrl->max_discard_sectors);
>  	blk_queue_max_discard_segments(queue, ctrl->max_discard_segments);
>  

-- 
Damien Le Moal
Western Digital Research

