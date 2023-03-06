Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96F1C678D4
	for <linux-block@archiver.kernel.org>; Mon,  6 Mar 2023 14:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjCFOjW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Mar 2023 09:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjCFOjO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Mar 2023 09:39:14 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704F6F950
        for <linux-block@vger.kernel.org>; Mon,  6 Mar 2023 06:38:46 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id n2so12943368lfb.12
        for <linux-block@vger.kernel.org>; Mon, 06 Mar 2023 06:38:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678113188;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y4O7nglR7O8YYBFJO+aAK2WOTd497QXA4VvGjiZbUAY=;
        b=Eu/fsOwBuUR35YPlEGO9BKtHeQW/U8LeCEqhlu2Fn/DKp9Cinsi4wl76lrhhHsJ1Ak
         cWgSSXky2hlxE+bOUBFnmFCluSTjgTNFq/L2+u0PFQU3BCH94TMNQELnQrSushJc26hz
         DjFYVdBdD/PYURpkvKT4sIBikdHr7XrAcX/MemXFptq8QWvDxPhE0RB9p5OGJdjkAHJh
         N001G5DaKjJeTBCblw4TBXTWcjVzXIR76Q5fpeTlMDq/U/42VT858aMdE8PYRaL3TaIj
         cyX2NODyNE6dLQQGBtapV3AZ9zvRsZWEnyrxYosBVoc1z7lrSHrCZPnG4Z0YKr6+tWod
         03FQ==
X-Gm-Message-State: AO0yUKXNWq8Tk9G1NNHaBF+nNgAwjv799Oks3fDHmLgNtNqrRaZueGRD
        7L5F3GQ00HX0hSPRgFotnjArZMctelU=
X-Google-Smtp-Source: AK7set/hn+mj3DDuFDNC/fWfNafv2COZcQffLjEGX7e+CXLf0owq1LjHuTVi4n/D6GblZiruBgdlXg==
X-Received: by 2002:adf:e60b:0:b0:2c7:1c72:699f with SMTP id p11-20020adfe60b000000b002c71c72699fmr6945230wrm.4.1678112469957;
        Mon, 06 Mar 2023 06:21:09 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o13-20020a5d670d000000b002c8476dde7asm10010667wru.114.2023.03.06.06.21.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 06:21:09 -0800 (PST)
Message-ID: <125e291a-5225-6565-e800-e6bdb6be35f3@grimberg.me>
Date:   Mon, 6 Mar 2023 16:21:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] nvme: fix handling single range discard request
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org
References: <20230303231345.119652-1-ming.lei@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230303231345.119652-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/4/23 01:13, Ming Lei wrote:
> When investigating one customer report on warning in nvme_setup_discard,
> we observed the controller(nvme/tcp) actually exposes
> queue_max_discard_segments(req->q) == 1.
> 
> Obviously the current code can't handle this situation, since contiguity
> merge like normal RW request is taken.
> 
> Fix the issue by building range from request sector/nr_sectors directly.
> 
> Fixes: b35ba01ea697 ("nvme: support ranged discard requests")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/nvme/host/core.c | 28 +++++++++++++++++++---------
>   1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index c2730b116dc6..d4be525f8100 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -781,16 +781,26 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
>   		range = page_address(ns->ctrl->discard_page);
>   	}
>   
> -	__rq_for_each_bio(bio, req) {
> -		u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
> -		u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
> -
> -		if (n < segments) {
> -			range[n].cattr = cpu_to_le32(0);
> -			range[n].nlb = cpu_to_le32(nlb);
> -			range[n].slba = cpu_to_le64(slba);
> +	if (queue_max_discard_segments(req->q) == 1) {
> +		u64 slba = nvme_sect_to_lba(ns, blk_rq_pos(req));
> +		u32 nlb = blk_rq_sectors(req) >> (ns->lba_shift - 9);
> +
> +		range[0].cattr = cpu_to_le32(0);
> +		range[0].nlb = cpu_to_le32(nlb);
> +		range[0].slba = cpu_to_le64(slba);
> +		n = 1;
> +	} else {
> +		__rq_for_each_bio(bio, req) {
> +			u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
> +			u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
> +
> +			if (n < segments) {
> +				range[n].cattr = cpu_to_le32(0);
> +				range[n].nlb = cpu_to_le32(nlb);
> +				range[n].slba = cpu_to_le64(slba);
> +			}
> +			n++;
>   		}
> -		n++;
>   	}
>   
>   	if (WARN_ON_ONCE(n != segments)) {


Maybe just set segments to min(blk_rq_nr_discard_segments(req), 
queue_max_discard_segments(req->q)) and let the existing code do
its thing?
