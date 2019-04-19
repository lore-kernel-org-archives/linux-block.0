Return-Path: <SRS0=cp6W=SV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520B3C282DF
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 18:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF81204EC
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 18:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4zpDSt0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfDSSfr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:35:47 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40176 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbfDSSfr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Apr 2019 14:35:47 -0400
Received: by mail-pl1-f194.google.com with SMTP id b3so2945250plr.7
        for <linux-block@vger.kernel.org>; Fri, 19 Apr 2019 11:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GdHeQhMspb/jfnjTqAtbREfQlvPtb2Eq4MQ0jcoRY84=;
        b=l4zpDSt0S3gHz27tXEb8Z4GGz07yEIYM+jBRgN10CI0B4ShkrENnbGDnK6G6x/3xuX
         JM9vZc85ekBCFNYItK20RYSImAy8JAkO24VqZLsXL26Txn3fDbzq08SoWyX8N2Uu1Cpl
         I/s3wEi6t739U5RmFZK15Ll6TxdMO/X09EDZMzBjvGxgXMfntZRBLmGoKq0k7+IILQBM
         vGkiXZvKT0peStbiCWrhaBsCnDnonHR5hDeKsEHolys2GrRtN0eNCSN87w0BI7VmLyJK
         IQ3kHQq3enBEj7T1+H8yFPClsNDyhm1lYqFrb2da0GxTzINIAa/D5txhGxBdwdGbAsTK
         +AdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GdHeQhMspb/jfnjTqAtbREfQlvPtb2Eq4MQ0jcoRY84=;
        b=IgXtxrn3QtaRGlAJckwLcSoGytBRnSPS1Zj/stVqDclYSB+pZJ4zKs80TBCRIbQnEJ
         rwXaMFQBhmWHJbyhxRLcJEdNIC3kpH6vbGiyEA8/hmRTLvicNxB8kqqkIsmczVlEumej
         qrR2U3oInfl5RAc9OyLsk7KiqGOYNWa/Jj7gRv86GsP722Qr+wHpEzrkj9+B/U1Sqi4d
         //wRBcKFoECxqqwJZnkg/+TigSzbByxKrHYnY+fsnZPHwFMAIQdwaRRU5TUoSXCI8VEy
         BusHNKcBNghDPtEvd79yWkuQQ+YhjPHj4qXqjOIIPt2j0ubpgTUBwZmmKM7Za5q9AOTs
         J6tA==
X-Gm-Message-State: APjAAAXIeiEifxXCoT0Ts34EZcU5QHzR2OipIlW491nBkcF9HpxTIZI3
        KUeV19rmxK3xmuoF2GYAong=
X-Google-Smtp-Source: APXvYqzEozBujWf5qlENeJsBcShWqvoSv1BfVvRkPA0NABnzmRrKf8MjTUc6Sm7R128wyTJZLJBXaw==
X-Received: by 2002:a17:902:e305:: with SMTP id cg5mr5338151plb.112.1555698946251;
        Fri, 19 Apr 2019 11:35:46 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a85sm10124713pfa.166.2019.04.19.11.35.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 11:35:45 -0700 (PDT)
Date:   Fri, 19 Apr 2019 11:35:43 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: avoid scatterlist offsets > PAGE_SIZE
Message-ID: <20190419183543.GA7292@roeck-us.net>
References: <20190419065624.25583-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419065624.25583-1-hch@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 19, 2019 at 08:56:24AM +0200, Christoph Hellwig wrote:
> While we generally allow scatterlists to have offsets larger than page
> size for an entry, and other subsystems like the crypto code make use of
> that, the block layer isn't quite ready for that.  Flip the switch back
> to avoid them for now, and revisit that decision early in a merge window
> once the known offenders are fixed.
> 
> Fixes: 8a96a0e40810 ("block: rewrite blk_bvec_map_sg to avoid a nth_page call")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

(cautious)

Tested-by: Guenter Roeck <linux@roeck-us.net>

Cautious because there are currently a number if crashes and runtime
warnings in -next. I don't think any are related to the block code,
but I may be wrong.

Guenter

> ---
>  block/blk-merge.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 247b17f2a0f6..21e87a714a73 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -474,9 +474,21 @@ static unsigned blk_bvec_map_sg(struct request_queue *q,
>  	while (nbytes > 0) {
>  		unsigned offset = bvec->bv_offset + total;
>  		unsigned len = min(get_max_segment_size(q, offset), nbytes);
> +		struct page *page = bvec->bv_page;
> +
> +		/*
> +		 * Unfortunately a fair number of drivers barf on scatterlists
> +		 * that have an offset larger than PAGE_SIZE, despite other
> +		 * subsystems dealing with that invariant just fine.  For now
> +		 * stick to the legacy format where we never present those from
> +		 * the block layer, but the code below should be removed once
> +		 * these offenders (mostly MMC/SD drivers) are fixed.
> +		 */
> +		page += (offset >> PAGE_SHIFT);
> +		offset &= ~PAGE_MASK;
>  
>  		*sg = blk_next_sg(sg, sglist);
> -		sg_set_page(*sg, bvec->bv_page, len, offset);
> +		sg_set_page(*sg, page, len, offset);
>  
>  		total += len;
>  		nbytes -= len;
> -- 
> 2.20.1
> 
