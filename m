Return-Path: <SRS0=uUnX=Y5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F64CA9EC9
	for <linux-block@archiver.kernel.org>; Tue,  5 Nov 2019 00:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C417220717
	for <linux-block@archiver.kernel.org>; Tue,  5 Nov 2019 00:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387516AbfKEAOO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Nov 2019 19:14:14 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38306 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387515AbfKEAOO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Nov 2019 19:14:14 -0500
Received: by mail-pg1-f194.google.com with SMTP id j30so9214959pgn.5
        for <linux-block@vger.kernel.org>; Mon, 04 Nov 2019 16:14:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=juZfJMx9Z/FVBNdtMfsKJAbuACJdL/PMrbnI/SsnP6M=;
        b=SEI5TYIJLPn1Rb6lWctMvrtmYVDI49+fFM/Wo7crHeRiwjOrn7NoghnxoRUUdgbUAm
         2of4xsG1LApQVhJSgGfq9YTqkUDFi5D5lewDMIbZtGIsJQ5hLpAGQ03rygGJ5PJcv5A7
         aNBeDVYhYMYRhcq4vc2BbeLv5vCMrdRt0Zlwg6X8lzehwWwqri2rxvVLtigc0UB6fhpD
         10EC+NbT97DxtMonjWhPHQe1qanTHfsL+1g18hR+knhvMQuFVWYgzvAoQnk9soCIeSFO
         LWkM+MJWB5IcR8P2dIPr6JrerWQpLCdoSrX527vw2cIMUQGbkWbt6sJbDWTKVKhQsWPD
         fOng==
X-Gm-Message-State: APjAAAWG1YckPmABCaeNy5+PlB/ReKFNRHsTmDN0ILRiPGp6nHd/llJ5
        xkyEGSA/W8OGK6TrFD0ee2YNHZ8B
X-Google-Smtp-Source: APXvYqxeBkwDktF9+Pj5nujzwJwSJGR/s8LGPVyWoUP8xC563149hABUt+/9WAcuSH3Kacx8ZNFd3Q==
X-Received: by 2002:a63:d504:: with SMTP id c4mr32258064pgg.75.1572912852465;
        Mon, 04 Nov 2019 16:14:12 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id h9sm19349836pjh.8.2019.11.04.16.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2019 16:14:11 -0800 (PST)
Subject: Re: [PATCH] block: skip the split micro-optimization for devices with
 chunk size
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
References: <20191105000617.26923-1-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <2ac3f0c3-1454-3246-37a5-695a13319b8c@acm.org>
Date:   Mon, 4 Nov 2019 16:14:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105000617.26923-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/4/19 4:06 PM, Christoph Hellwig wrote:
> If the devices sets a chunk size we might have to split I/O that is
> smaller than a page size if it crosses the chunk boundary.  Skip the
> micro-optimization for small I/Os in that case.
> 
> Fixes: b072e20f0084 ("block: merge invalidate_partitions into rescan_partitions")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-merge.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 06eb38357b41..f22cb6251d06 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -317,7 +317,8 @@ void __blk_queue_split(struct request_queue *q, struct bio **bio,
>   		 * are cloned, but compared to the performance impact of cloned
>   		 * bios themselves the loop below doesn't matter anyway.
                                        ^^^^
Did you perhaps mean "test" instead of "loop"?

Thanks,

Bart.

>   		 */
> -		if ((*bio)->bi_vcnt == 1 &&
> +		if (!q->limits.chunk_sectors &&
> +		    (*bio)->bi_vcnt == 1 &&
>   		    (*bio)->bi_io_vec[0].bv_len <= PAGE_SIZE) {
>   			*nr_segs = 1;
>   			break;
> 

