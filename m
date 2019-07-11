Return-Path: <SRS0=DuRR=VI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCF1C742A2
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 18:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4148C20863
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 18:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IznRdB31"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbfGKSJO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jul 2019 14:09:14 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39145 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbfGKSJO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jul 2019 14:09:14 -0400
Received: by mail-io1-f66.google.com with SMTP id f4so14562373ioh.6
        for <linux-block@vger.kernel.org>; Thu, 11 Jul 2019 11:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hgjgi94dHGC4bWnLrceImBpd8PiIudbskChydoR5xrA=;
        b=IznRdB31PQmXqukI2HchxyWLn6iopN13+FhGdn8xAR1YqRqUkvCHaBtXMvwWY4H7bc
         hF6MhLF7usTf3DSuuvyq0VLv7GSdnonV/oZqCtXGZuk3coWP7iTfbqRT4yX3zeW6w9Td
         L98Fn7TUs4mQ3N5HUdzq9B0h0+N3Bv7lsRkxXMbTyKrk0UbWmkNTnk45ro5jvPAweAb5
         663oT2GNBgQIQfB1V5E8Ea7BZMzyjzYw7dDbw0NTBrbF8u2OR1lOFmk6tDXjuP/aYZ5m
         Zlxs5MutS1LvU18zgx74DIexqRnuOAp8BkZ/LwkstAAveNX4Mdo2WE4iVR9fiz4tMgPW
         xRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hgjgi94dHGC4bWnLrceImBpd8PiIudbskChydoR5xrA=;
        b=rHD9l4/RkWB6HI/5i09ezQJOlwSfIDi0zNnavgJQlkILavurTBblgfU/V9pQ8mFAQd
         C5yoUoyg3H3CMYtwPi7fSqazxMnzE5qwYRd2394bxE7+BI1ALAoa5AKYclKGwfuF91tW
         SbReB2xnBdAZWr0sRB9f4jyQS3q9xIlF5HVaylkwrvbQWZMLXfteVtWUy84394k9SmX1
         7azCnn4E7oxU2bDlSMg01w6HM892bwwXH65mhSqOraWhFzytbIh4wLrD1Hkvo1iJAKt9
         z42AtjoCjdno5TTVQCzg8dwrVWpjvg3UQdMcQJ4rvykAr+M62kHcdedi4H8F0p6NBFQO
         RkKg==
X-Gm-Message-State: APjAAAVjVD4d+Y48ACgxBOwJI+7SALP+w6p8PSUnZAakg/ju0T86mw1c
        ULfbnfYbBAkp+vQA8DGBQeHpKzZH578=
X-Google-Smtp-Source: APXvYqz+upSBZin6uu0pHd6Y9PZ4yBo4ElT3TGFk6dzDSjW1kWVQzbKyFOK82JBjzFP6dAeMCQqF+A==
X-Received: by 2002:a02:ab99:: with SMTP id t25mr5977963jan.113.1562868552975;
        Thu, 11 Jul 2019 11:09:12 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id i3sm4970964ion.9.2019.07.11.11.09.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 11:09:12 -0700 (PDT)
Subject: Re: [PATCH] block: tidy up blk_mq_plug
To:     Christoph Hellwig <hch@lst.de>
Cc:     damien.lemoal@wdc.com, linux-block@vger.kernel.org
References: <20190711111714.4802-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <53c09d04-3f29-2cea-ede4-cdf443539a17@kernel.dk>
Date:   Thu, 11 Jul 2019 12:09:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190711111714.4802-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/11/19 5:17 AM, Christoph Hellwig wrote:
> Make the zoned device write path the special case and just fall
> though to the defaul case to make the code easier to read.  Also
> update the top of function comment to use the proper kdoc format
> and remove the extra in-function comments that just duplicate it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-mq.h | 14 ++++----------
>   1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index 32c62c64e6c2..ab80fd2b3803 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -233,7 +233,7 @@ static inline void blk_mq_clear_mq_map(struct blk_mq_queue_map *qmap)
>   		qmap->mq_map[cpu] = 0;
>   }
>   
> -/*
> +/**
>    * blk_mq_plug() - Get caller context plug
>    * @q: request queue
>    * @bio : the bio being submitted by the caller context
> @@ -254,15 +254,9 @@ static inline void blk_mq_clear_mq_map(struct blk_mq_queue_map *qmap)
>   static inline struct blk_plug *blk_mq_plug(struct request_queue *q,
>   					   struct bio *bio)
>   {
> -	/*
> -	 * For regular block devices or read operations, use the context plug
> -	 * which may be NULL if blk_start_plug() was not executed.
> -	 */
> -	if (!blk_queue_is_zoned(q) || !op_is_write(bio_op(bio)))
> -		return current->plug;
> -
> -	/* Zoned block device write operation case: do not plug the BIO */
> -	return NULL;
> +	if (blk_queue_is_zoned(q) && op_is_write(bio_op(bio)))
> +		return NULL;
> +	return current->plug;
>   }
>   
>   #endif

I agree it's more readable, but probably also means that the path that we
care the least about (zoned+write) is now the inline one.


-- 
Jens Axboe

