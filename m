Return-Path: <SRS0=sY57=XB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08604C43331
	for <linux-block@archiver.kernel.org>; Fri,  6 Sep 2019 19:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D298C20838
	for <linux-block@archiver.kernel.org>; Fri,  6 Sep 2019 19:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="p07sFviy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393266AbfIFTYU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Sep 2019 15:24:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42844 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390263AbfIFTYU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Sep 2019 15:24:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id p3so4016891pgb.9
        for <linux-block@vger.kernel.org>; Fri, 06 Sep 2019 12:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ybtj7N8tv6raX51VSFDWTi/d7KmFChjN9aq8OMTDtfs=;
        b=p07sFviyD6a/Tc3KKYj30wk29cr2c5/ojlxWqL1IDKg9nanKrVeV2cUqUamxNj8Men
         muba8GXRnnvgwzZ+6/WTAE7dPkbuA5qmPYQYn+/FMaLbjzGt/HTiuN0teZ9oWgQ3eJar
         exfFw+MqnUlGZgGjXTpnj4DlE2HmCF7Wrt/JhdE0VUUsGNLXHLVutWv4YVye6rbmRu2+
         B3NZ421vr/9Yn9RV42Qgdlflrt6VF3PVNSr3Vl3ljZVjj1VPWaglOJCd2c1WXLpgvQrf
         ccfrFxmbMbObVlY1NkY3lGNjNv5sQ7pqGtiVtZRKFDrKgyvJX03tIcZS4V3b3RnWKY7h
         B5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ybtj7N8tv6raX51VSFDWTi/d7KmFChjN9aq8OMTDtfs=;
        b=Soa8sgvmqnR5QapyOgFadyT4rUKiO05eL2X6vPqVy2rnggcKGTeS2fE9uaRUvuM1xe
         CmSwr4VjxKN24skI06LNbRdiDkR7Txc2XlJhFZuZQ84+oLMmTY3bLBB/U9NOE6thcK4a
         0sfF9pNoSR48ZZLnIuH0iegHoQJSuWM5j186Wq9+uOiWZvCs5DS1TSDoFG194TCsPRs8
         2JeeQM1cMsGwsgsBRDeTPBrI743nEaY6xnPbk/KFZDipER40VafyuKi+CqItN+SbR2Wb
         4TP6I7BKHGZiY7zacs/upFiw3f496N2Ddo/g64HgUjiOoKAt2OozjporWC75Frl2ZLt7
         sLYQ==
X-Gm-Message-State: APjAAAWBkptRhy2Ub1ujdHsFTjZoddSnryK+jfRzOKuKhDFBvunkgXTm
        WvEQg3xHVX/x9mMBE5yU++CZpfgBnO9uNA==
X-Google-Smtp-Source: APXvYqxcMhxqtAZcP7OjiKxwiXLCCLoArzrxDQ9oz/Ht914G8wxizquxBqRmYK7xYuf0ZVZlJhBuXA==
X-Received: by 2002:a62:2b51:: with SMTP id r78mr12400275pfr.149.1567797859212;
        Fri, 06 Sep 2019 12:24:19 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id k8sm4965990pgm.14.2019.09.06.12.24.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 12:24:18 -0700 (PDT)
Subject: Re: [PATCH 1/2] liburing/test: There are now 4 reserved fields
To:     Hristo Venev <hristo@venev.name>
Cc:     linux-block@vger.kernel.org
References: <c0ab3b6a-3e30-8a91-512e-aed9218015a7@kernel.dk>
 <20190906191252.30332-1-hristo@venev.name>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <39e068aa-5c88-c8b6-46fe-6d96f73f97b2@kernel.dk>
Date:   Fri, 6 Sep 2019 13:24:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906191252.30332-1-hristo@venev.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/6/19 1:12 PM, Hristo Venev wrote:
> Signed-off-by: Hristo Venev <hristo@venev.name>> ---
>   test/io_uring_setup.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/test/io_uring_setup.c b/test/io_uring_setup.c
> index 2dd3763..73b0398 100644
> --- a/test/io_uring_setup.c
> +++ b/test/io_uring_setup.c
> @@ -67,8 +67,8 @@ dump_resv(struct io_uring_params *p)
>   	if (!p)
>   		return "";
>   
> -	sprintf(resvstr, "0x%.8x 0x%.8x 0x%.8x 0x%.8x 0x%.8x", p->resv[0],
> -		p->resv[1], p->resv[2], p->resv[3], p->resv[4]);
> +	sprintf(resvstr, "0x%.8x 0x%.8x 0x%.8x 0x%.8x", p->resv[0],
> +		p->resv[1], p->resv[2], p->resv[3]);
>   
>   	return resvstr;
>   }
> @@ -118,7 +118,7 @@ main(int argc, char **argv)
>   
>   	/* resv array is non-zero */
>   	memset(&p, 0, sizeof(p));
> -	p.resv[0] = p.resv[1] = p.resv[2] = p.resv[3] = p.resv[4] = 1;
> +	p.resv[0] = p.resv[1] = p.resv[2] = p.resv[3] = 1;
>   	status |= try_io_uring_setup(1, &p, -1, EINVAL);
>   
>   	/* invalid flags */

Forgot to push this one out, but I already fixed that up by adding
support for printing ->features as well.

-- 
Jens Axboe

