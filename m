Return-Path: <SRS0=enhP=VS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2C6C76191
	for <linux-block@archiver.kernel.org>; Sun, 21 Jul 2019 16:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C40621743
	for <linux-block@archiver.kernel.org>; Sun, 21 Jul 2019 16:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vdxJfD4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbfGUQ4t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 Jul 2019 12:56:49 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35291 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfGUQ4s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Jul 2019 12:56:48 -0400
Received: by mail-pf1-f195.google.com with SMTP id u14so16226347pfn.2
        for <linux-block@vger.kernel.org>; Sun, 21 Jul 2019 09:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OVS4MEdSGpRv7y7usEiXEtbX3dhcWAe/BZ2X97D8/ZI=;
        b=vdxJfD4wxIDnR8+EshUfVilphMAKnAeVpb1zH9llxhLGffzOO/lgSCYZcUsmwsiLlc
         +QOj7LEpb3vrJFbS+NNBdJQUl1ogptRYsO7L5HCqRc0h6sTgA4OVQqGEVGj5NIPEX0I0
         A+nwLM4+DzfWg2fKzGTRaH0Cqk/sSGUboVVok4so3BLVV/koTF9yB5+BZJzPhpdMpuk6
         b0Coa0pIbWVSwVmvD8XlWqQ3NE+sXxDYTqAKAzAH4AAek1vjhcfc4oetbChfOzjOA9Bd
         t+y33wt63UG4LtC4tVPZyUBokK4sTFhDcaVEzh+bkeV1+ZavuGv32iOqy9aUoDChjVOF
         w4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OVS4MEdSGpRv7y7usEiXEtbX3dhcWAe/BZ2X97D8/ZI=;
        b=M7Za699Q8EdcGu5+w6WYIyTzgfyiZEHaIA7R/TTYwr/KiNC5nzNz/Imi934xDfxVYC
         7t7H1C0SX3kDac10NNu5jB4EcjfaE9MJK0jwhbFu/8Eta3nLYTQlSlt65TfEzh60tYJK
         36bwxmVn0QDt2wp5bKFEI8End9jhuQ386G/6feoDXXxCAqVyv01jc3kkEmHWWyQtNVKq
         RejOht4/ED6BEJJUOA0XVnOzt/fGj0OPcYDcT8kyn9IMfVwvLUmGxYP312uqhjWanxW2
         5HBY8HkMtCoUhnFPM+kzHECeaZgYxpaqHTSRBBGG5y4YOeDkjlYSCQiCiO6zJlODNxNx
         uzfA==
X-Gm-Message-State: APjAAAViOw3wwf6Ukf/FQdpePegykNAofcUyNCDuWSi64GaZt+Yso5f4
        G1FPXD92o+BDYxEZVUNWRG960G1HKyw=
X-Google-Smtp-Source: APXvYqzB7BL1W0Qqr8lzDWzaBBH2kCHPnnzc8K7yCRu6FVtAECO3YFFLS3OVyK7PWYeoZcfxRhjNeA==
X-Received: by 2002:a63:c44c:: with SMTP id m12mr29097040pgg.396.1563728207660;
        Sun, 21 Jul 2019 09:56:47 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id z4sm26548414pgp.80.2019.07.21.09.56.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jul 2019 09:56:46 -0700 (PDT)
Subject: Re: [PATCH] io_uring: use bytes instead of pages to decide len
 exceeding
To:     Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Cc:     linux-block@vger.kernel.org
References: <20190721155408.14009-1-liuzhengyuan@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <282d488e-ac68-bbc9-e727-07d6bf2bf3c0@kernel.dk>
Date:   Sun, 21 Jul 2019 10:56:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190721155408.14009-1-liuzhengyuan@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/21/19 9:54 AM, Zhengyuan Liu wrote:
> We are using PAGE_SIZE as the unit to determine if the total len in
> async_list has exceeded max_pages, it's not fair for smaller io sizes.
> For example, if we are doing 1k-size io streams, we will never exceed
> max_pages since len >>= PAGE_SHIFT always gets zero. So use original
> bytes to make things fair.

Thanks, we do need this for sub page sized reads to be accurate. One
minor nit:

> @@ -1121,28 +1121,27 @@ static void io_async_list_note(int rw, struct io_kiocb *req, size_t len)
>   	off_t io_end = kiocb->ki_pos + len;
>   
>   	if (filp == async_list->file && kiocb->ki_pos == async_list->io_end) {
> -		unsigned long max_pages;
> +		unsigned long max_pages, max_bytes;
>   
>   		/* Use 8x RA size as a decent limiter for both reads/writes */
>   		max_pages = filp->f_ra.ra_pages;
>   		if (!max_pages)
>   			max_pages = VM_READAHEAD_PAGES;
> -		max_pages *= 8;
> +		max_bytes = (max_pages * 8) << PAGE_SHIFT;

Let's get rid of max_pages, and just do:

	/* Use 8x RA size as a decent limiter for both reads/writes */
	max_bytes = filp->f_ra.ra_pages << (PAGE_SHIFT + 3);
	if (!max_bytes)
		max_bytes = VM_READAHEAD_PAGES << (PAGE_SHIFT + 3);

There's really no need to have both a max_pages and max_bytes variable
if we're tracking and limiting based on bytes.

-- 
Jens Axboe

