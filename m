Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4F2C43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 19:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627EC2146D
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 19:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="gJH30wyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 627EC2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbeK3GtL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:49:11 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44505 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeK3GtL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 01:49:11 -0500
Received: by mail-pl1-f195.google.com with SMTP id k8so1537040pls.11
        for <linux-block@vger.kernel.org>; Thu, 29 Nov 2018 11:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WPjz213r2DxWgRRdSFoaNzlClsrJhUJHEj9+RlXO4MA=;
        b=gJH30wyRpPpHK3ApPTjMRJe9YjJ5hw3prHZseNAX0HCr2LYrskcRIDFYEtqasUOImI
         mzchBGYl/OF0q1bDSjKdp/zeVnsJ0kE7gLzbDHv7iaoKdUFitw8N61iTdfUJQXkbVK3F
         0Xa7ZSOcaR9Wvj0/j05tLtze+0A3E9j2ANagBEXu9zqkAEKscudGsI2rur11kyYNTsPz
         1n3xZ1PC+pMng2K0T9z9AhhVV/jT3AgDSG3bxxqDMDs//9hdeLTf+l3qOc8Zm08ZYJyT
         LaSy0DvaP5qT3WgSr3e8yQIoIxI4wW7SHdMIYxKfjIqhlrhoEs7Eiv/8cWCyKAIv5ayx
         Ydvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WPjz213r2DxWgRRdSFoaNzlClsrJhUJHEj9+RlXO4MA=;
        b=G8m5/lWOkbtKNfo5usldJ5k3Ydc+2ige+K8imWHlQ3MmuLtR+9m/vVmi7M+7clU9Tn
         oWJOOMVQB+Tml//gPKBPqxTJH993Q7jXvxfFbgBUSppnBZObst9dZgfKwoBqzvqhC6GX
         LH0/a2e0BGCVP+R4x3dPWSZMMs3IaB+TpagzwgR2XEwGBZOxsyYCPxgRl7M7gkiHOqZ1
         KmLCh5CMHY7QO9kHr6p8SfK3s6A6JsLS7+lMD7nnaFVmXDTJgogYXvaW6uTs8RaRA6Gj
         uSzvA0aymZOn88ghmnGdJgptC37KIORjHfv0AP88MPDDSrjjGnc4JDfVPj4gSAoYi1+J
         1Z3Q==
X-Gm-Message-State: AA+aEWYEP55uLHtv93cq/3Y6QUfAVBZ+ASp4I49qoGnJwiHdRtxk9E2u
        WykMU9+O/CzBANgNLEsWuHc/mgSzggk=
X-Google-Smtp-Source: AFSGD/Xe9jrfEOzT9wzXjp7Dbr5FMy50GSZ9MJQyqQAWysf0LvLEg+02yhXFyzZPccI3nUVSs1CyWA==
X-Received: by 2002:a17:902:96a:: with SMTP id 97mr2683252plm.45.1543520558571;
        Thu, 29 Nov 2018 11:42:38 -0800 (PST)
Received: from vader ([2620:10d:c090:180::1:e168])
        by smtp.gmail.com with ESMTPSA id d21sm3254752pgv.37.2018.11.29.11.42.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 11:42:37 -0800 (PST)
Date:   Thu, 29 Nov 2018 11:42:36 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] sbitmap: don't loop for find_next_zero_bit() for
 !round_robin
Message-ID: <20181129194236.GA21082@vader>
References: <de7c5294-7f97-6fa9-9729-66992a58a1db@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de7c5294-7f97-6fa9-9729-66992a58a1db@kernel.dk>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 29, 2018 at 12:34:12PM -0700, Jens Axboe wrote:
> If we aren't forced to do round robin tag allocation, just use the
> allocation hint to find the index for the tag word, don't use it for the
> offset inside the word.

Maybe also add "We're already fetching that cache line, so we might as
well check the whole word."

> This avoids a potential extra round trip in the
> bit looping.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index fdd1b8aa8ac6..2987b2ac8ed7 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -118,10 +118,19 @@ int sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint, bool round_robin)
>  
>  	index = SB_NR_TO_INDEX(sb, alloc_hint);
>  
> +	/*
> +	 * Unless we're doing round robin tag allocation, just use the
> +	 * alloc_hint to find the right word index. No point in looping
> +	 * twice in find_next_zero_bit() for that case.
> +	 */
> +	if (round_robin)
> +		alloc_hint = SB_NR_TO_BIT(sb, alloc_hint);
> +	else
> +		alloc_hint = 0;
> +
>  	for (i = 0; i < sb->map_nr; i++) {
>  		nr = __sbitmap_get_word(&sb->map[index].word,
> -					sb->map[index].depth,
> -					SB_NR_TO_BIT(sb, alloc_hint),
> +					sb->map[index].depth, alloc_hint,
>  					!round_robin);
>  		if (nr != -1) {
>  			nr += index << sb->shift;
> @@ -130,12 +139,8 @@ int sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint, bool round_robin)
>  
>  		/* Jump to next index. */
>  		index++;
> -		alloc_hint = index << sb->shift;
> -
> -		if (index >= sb->map_nr) {
> +		if (index >= sb->map_nr)
>  			index = 0;
> -			alloc_hint = 0;
> -		}

We need to set alloc_hint = 0 here for the round_robin case.

>  	}
>  
>  	return nr;
> 
> -- 
> Jens Axboe
> 
