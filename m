Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1F0EB64DA
	for <linux-block@archiver.kernel.org>; Mon, 10 Jul 2023 03:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjGJDxp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Jul 2023 23:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGJDxl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Jul 2023 23:53:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8116FD2
        for <linux-block@vger.kernel.org>; Sun,  9 Jul 2023 20:53:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1907A60B56
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 03:53:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA3CC433C8;
        Mon, 10 Jul 2023 03:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688961219;
        bh=c83HHLEuw3oaOnGz4RSWtJJZgGWARDVC09RNf9XCtKk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=X34Peei8KLsaksJEoJKslFZqLG3AIMBGn2mhcA1QXrzKXDA6EcWygZffwscnOqFOY
         u3RQa7aOSgF6LKpjafRPdMAeEpvREEUyOK4WyQjeNBb/O/9Eh/6yEnAc7NhW4AT+EJ
         NRtt3uREuoR25BVn6/dXclBui+pGNLv+CMgsVDaoxlL+mZJXe3F9Khd6XL5j1SNmSO
         fcdsW6VqPmxJlmR7Yd2VdQDltsfdC2Tn0umqazIQP93dN4bzTnex+wbXe2GFuDrulK
         WRHCnYHWPli2wkWZzYINqqOvqIA2PQ5r+XPRFck1G22PWQk+en1oY2f9UKxeESNFeG
         vVU1E1IOUEDqQ==
Message-ID: <40107b82-3091-a19a-4740-d1a9e8d7229c@kernel.org>
Date:   Mon, 10 Jul 2023 12:53:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/4] block: don't unconditionally set max_discard_sectors
 in blk_queue_max_discard_sectors
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20230707094616.108430-1-hch@lst.de>
 <20230707094616.108430-2-hch@lst.de>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230707094616.108430-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/7/23 18:46, Christoph Hellwig wrote:
> max_discard_sectors is split into a hardware and a tunable value, but
> blk_queue_max_discard_sectors sets both unconditionally, thus dropping
> any user stored value on a rescan.  Fix blk_queue_max_discard_sectors to
> only set max_discard_sectors if it either wasn't set, or the new hardware
> limit is smaller than the previous user limit.
> 
> Fixes: 0034af036554 ("block: make /sys/block/<dev>/queue/discard_max_bytes writeable")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Look OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


> ---
>  block/blk-settings.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 0046b447268f91..978d2e1fd67a51 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -179,7 +179,9 @@ void blk_queue_max_discard_sectors(struct request_queue *q,
>  		unsigned int max_discard_sectors)
>  {
>  	q->limits.max_hw_discard_sectors = max_discard_sectors;
> -	q->limits.max_discard_sectors = max_discard_sectors;
> +	if (!q->limits.max_discard_sectors ||
> +	     q->limits.max_discard_sectors > max_discard_sectors)
> +		q->limits.max_discard_sectors = max_discard_sectors;
>  }
>  EXPORT_SYMBOL(blk_queue_max_discard_sectors);
>  

-- 
Damien Le Moal
Western Digital Research

