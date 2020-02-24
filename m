Return-Path: <SRS0=9TSA=4M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00866C11D2F
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 16:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E4C21556
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 16:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="oNY2pE6b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgBXQkP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Feb 2020 11:40:15 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:35673 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbgBXQkO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Feb 2020 11:40:14 -0500
Received: by mail-il1-f195.google.com with SMTP id g12so8263806ild.2
        for <linux-block@vger.kernel.org>; Mon, 24 Feb 2020 08:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lIEGN7rDHGU+KfgWQjfUP7OUuyyUqLxOvYnNG3e/4Ik=;
        b=oNY2pE6bCSISi6D2LFYDQPeJ/3RxCsmiru6s3X2PF8+pWyqdt7TTSBxjn2qNTejnF8
         6Zycp2/akRa4PMxdjn8Hpg87bMxG4TNus1DlfKoUGE7rE6zcT/RJwd1+2DCPknFcVWWx
         xGZ19GtHiCMljwBGC85gR8ZFJqOTjskoPbKsV6SIn6pK2CG8TTmPqx4/Dh5fsMhlEMCL
         kX11nKT0ES0zHHWSRWZZJ3IkI1yUW6DfrS0Qv81vZgDbS3VGAO/hjf+9J/VFwbd0Hkcp
         BhgpYtNuVkFwwHFtEXRH+yJA1v8JcjOjIXnZByQHWdB3r8M7XMFqLk8CXKS4cfaRr5KI
         kK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lIEGN7rDHGU+KfgWQjfUP7OUuyyUqLxOvYnNG3e/4Ik=;
        b=NUtgsmIY5UYUIhm2sPwudc6SJCyOSfVfTZfmmiNGFiLwjCiDCtJ20mU3sSJd1ZuFS4
         VURYDqwc68N6dxEJuZsgCV0xhlTJkexjTq1qMXRJ2cqD7uQNdnBiSZvCgvrkPlCi+9ic
         GGsBOw1EJbfp45BMAOtD47XoLP9WGBnnO8ILRGE/3aa3l4eBRvzLOtBC1E7juEGMQl7E
         1cbmcOuCmImHl+eSGsLZX51vgmI1ExPPiOR0sUESUviFT+MazTjPGfGul1Eod8N3RQLp
         oyauMmSjlzBlVJGxfJ6RetmUXDD1yudmccwZpVTmxxmb9Swake/JE5ewW2MIuWcWmu5a
         5ITg==
X-Gm-Message-State: APjAAAWmWKJ/tp94Ve+jijNZmaXf97phzdSzoOpS3CaDEPg7VvLK6yZe
        5/44AzFQP8jyfV7ersy6ssffWZa800w=
X-Google-Smtp-Source: APXvYqw67ZTeubZhQ/BkGlIL1i5RL2SebkgEAuEpPkaMLB0jIuq8Ci3KzcUHsLBiX3crsgmuDSv2qw==
X-Received: by 2002:a92:d185:: with SMTP id z5mr64684924ilz.132.1582562414272;
        Mon, 24 Feb 2020 08:40:14 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o6sm4466620ilm.74.2020.02.24.08.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 08:40:13 -0800 (PST)
Subject: Re: [PATCH] block/bio-integrity: simplify the way of calculate
 nr_pages
To:     Bob Liu <bob.liu@oracle.com>, linux-block@vger.kernel.org
Cc:     martin.petersen@oracle.com
References: <20200224131258.18156-1-bob.liu@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2116fbd7-58d4-6cba-2d37-b12a9138f546@kernel.dk>
Date:   Mon, 24 Feb 2020 09:40:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224131258.18156-1-bob.liu@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/24/20 6:12 AM, Bob Liu wrote:
> Remove unnecessary start/end variables.
> 
> Signed-off-by: Bob Liu <bob.liu@oracle.com>
> ---
>  block/bio-integrity.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index bf62c25..575df98 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -202,7 +202,6 @@ bool bio_integrity_prep(struct bio *bio)
>  	struct blk_integrity *bi = blk_get_integrity(bio->bi_disk);
>  	struct request_queue *q = bio->bi_disk->queue;
>  	void *buf;
> -	unsigned long start, end;
>  	unsigned int len, nr_pages;
>  	unsigned int bytes, offset, i;
>  	unsigned int intervals;
> @@ -241,9 +240,7 @@ bool bio_integrity_prep(struct bio *bio)
>  		goto err_end_io;
>  	}
>  
> -	end = (((unsigned long) buf) + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
> -	start = ((unsigned long) buf) >> PAGE_SHIFT;
> -	nr_pages = end - start;
> +	nr_pages = (len + PAGE_SIZE - 1) >> PAGE_SHIFT;

This is incorrect if you straddle a page boundary, the existing code is
correct.

-- 
Jens Axboe

