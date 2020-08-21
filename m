Return-Path: <SRS0=euq6=B7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A0CC433DF
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 14:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DA362075E
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 14:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Tnzci+Hs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgHUOty (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Aug 2020 10:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgHUOtv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Aug 2020 10:49:51 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D2EC061755
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 07:49:50 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id j9so1590634ilc.11
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 07:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cxwNFKr8C4GxHwwirPDVBn5gDOlxq9kCMJ9FIhV/7GY=;
        b=Tnzci+Hswj7hMTc7vA1mGeQReoVIr0yEMvnV9YEI5ZNO8EHi/EbODtgB9IZ8O9e0r4
         5331vH21P4cphP7O8x7DdidRe968kxztCR0wbRdQ90uXkHhFT2ZRndHIEd3zEwpOlUxf
         QZQ9oFO/A1IF8zu3FRLvxEqDaK6oW4Et07rabfta86yhpF5RHI90s1nuNQn1o6aGpgZV
         6dfBuucnLTzNOK1OgSpfAA8AdxMGWMlPlaxsE5B9zKCqy6CSOjIU10aRS80g9IFdlWOM
         o76/Fvv/zvyzxhhP5bsQ97og1Fcl2CciSIwyYBzZvEg5saoRAbQ8DXZ/L4UxgVmzZQTm
         SvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cxwNFKr8C4GxHwwirPDVBn5gDOlxq9kCMJ9FIhV/7GY=;
        b=Y3A8j4IV6FS81Zg/l7dtwEhzIJyIv9W/2PO+AxqAY05Tm2S0U/G/M4GtmbIWA3hrT5
         2rTvx0vvuVdSUPcQm3CxvkyhOOOf3jmDE/WjUmhA2UuslUUzvqpFAtCrY7WhhBgYsHgi
         r8ff3F938iMgG3DaW+l3zkTGyXQMJyjxhE/T9nHUnPX0CONfpZ7svHv9HsrajWblmeRs
         l4vKSOyqDMMEyWUoJHFJ/0Yi+cQq9irUV+qLOqN4bbQ4V6lmpJwXXSB8KraTdIS6LGoY
         K8WSl+/cv/3vlJmxSHzd9bMijOvdlKrQoCZrE2+khAd5T4oBEPae01+wlba8AYD1312P
         fwSg==
X-Gm-Message-State: AOAM531YexIKQyOap4Yj1e95u2H2vGgVHTrIxdyqNZ4xhs9mfVACSE3N
        ZSRQl7Ab008e5zcFHIu3BoRqZF84XrZLyXc8
X-Google-Smtp-Source: ABdhPJxsuZGimz71cVC5o58/Sc9i/i1CQIN3kGd8VVPNvdqeDBYWjghwtjziXi83vGSc+UxIgacbpA==
X-Received: by 2002:a92:660e:: with SMTP id a14mr2868783ilc.290.1598021389768;
        Fri, 21 Aug 2020 07:49:49 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p20sm1331088iod.27.2020.08.21.07.49.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 07:49:49 -0700 (PDT)
Subject: Re: [PATCH] iomap: Fix the write_count in iomap_add_to_ioend().
To:     Christoph Hellwig <hch@infradead.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc:     darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, riteshh@linux.ibm.com,
        linux-block@vger.kernel.org
References: <20200819102841.481461-1-anju@linux.vnet.ibm.com>
 <20200821060710.GC31091@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9bf274cb-15ec-f389-42b3-b8469402af3d@kernel.dk>
Date:   Fri, 21 Aug 2020 08:49:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821060710.GC31091@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/21/20 12:07 AM, Christoph Hellwig wrote:
> On Wed, Aug 19, 2020 at 03:58:41PM +0530, Anju T Sudhakar wrote:
>> From: Ritesh Harjani <riteshh@linux.ibm.com>
>>
>> __bio_try_merge_page() may return same_page = 1 and merged = 0. 
>> This could happen when bio->bi_iter.bi_size + len > UINT_MAX. 
>> Handle this case in iomap_add_to_ioend() by incrementing write_count.
>> This scenario mostly happens where we have too much dirty data accumulated. 
>>
>> w/o the patch we hit below kernel warning,
> 
> I think this is better fixed in the block layer rather than working
> around the problem in the callers.  Something like this:
> 
> diff --git a/block/bio.c b/block/bio.c
> index c63ba04bd62967..ef321cd1072e4e 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -879,8 +879,10 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
>  		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
>  
>  		if (page_is_mergeable(bv, page, len, off, same_page)) {
> -			if (bio->bi_iter.bi_size > UINT_MAX - len)
> +			if (bio->bi_iter.bi_size > UINT_MAX - len) {
> +				*same_page = false;
>  				return false;
> +			}
>  			bv->bv_len += len;
>  			bio->bi_iter.bi_size += len;
>  			return true;
> 

This looks good to me.

-- 
Jens Axboe

