Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAE5C433EF
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 17:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C17F5611C3
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 17:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbhJERGS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Oct 2021 13:06:18 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:34481 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbhJERGS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Oct 2021 13:06:18 -0400
Received: by mail-pl1-f175.google.com with SMTP id b22so2755463pls.1
        for <linux-block@vger.kernel.org>; Tue, 05 Oct 2021 10:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9fGvxgXFduiY6z8QQRuybjyPiW8cwm3v4xLwA26s7OI=;
        b=BG6DWEHoDBHl8sfoxaU5VhbV6Ma8ycyyugztsA4kGk5I8bj3ty88JtjOxhh9c0/+Dp
         mS8VurIREQ8E/XvJH8HUGZ3tHA3Y+S2ybg7O6nlcfPAm1BAjDzE4oxSDPnRdqKxjlOb8
         U5OV3aAik1mHCWjQqfjxPEnVw5n+sLGSvTFSC+2CwAxx0bueqamZbqzW7PSGQj3jqGCp
         xFdZoLcVfEaV9PgN/Gabw2EiPYD5qHA8lM8L/hIDU0ZAPsdKq4JEpo7lbda+FaV5neum
         ZG79qvYA80kdXkFFkeDUnOoGvwQ12QXmZ+P/24eh/tmxSGl1QOtO0LqbsYy6fNccwJ0H
         XeLw==
X-Gm-Message-State: AOAM530OcjBwWkC6JhE01RBicwUP19HRB3VZRn499uh5eDMHbreecQgr
        zAeIomfLAdYElgYGNt5AsZKTUNyGN00=
X-Google-Smtp-Source: ABdhPJzw4cWyVuICTc5FhZesHQto7XXyIllYH+r4+xq0069QmAw0sfzKD1XuMkl2S0Xvl3RAUc3q6g==
X-Received: by 2002:a17:902:d707:b0:13d:bbe8:bcff with SMTP id w7-20020a170902d70700b0013dbbe8bcffmr6173232ply.75.1633453466662;
        Tue, 05 Oct 2021 10:04:26 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:e8fc:af57:dd49:3964])
        by smtp.gmail.com with ESMTPSA id q12sm18878754pgv.26.2021.10.05.10.04.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 10:04:25 -0700 (PDT)
Subject: Re: [PATCH] block: don't call should_fail_request() for
 !CONFIG_FAIL_MAKE_REQUEST
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <50093280-104b-545a-c4c9-2fc3efd45520@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <69b72109-a488-e0c2-3f8a-0fff917e66dd@acm.org>
Date:   Tue, 5 Oct 2021 10:04:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <50093280-104b-545a-c4c9-2fc3efd45520@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/5/21 8:32 AM, Jens Axboe wrote:
> Unnecessary function call, if we don't have that specific configuration
> option enabled.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 5454db2fa263..a267f11f55cb 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -697,8 +697,10 @@ static inline bool bio_check_ro(struct bio *bio)
>   
>   static noinline int should_fail_bio(struct bio *bio)
>   {
> +#ifdef CONFIG_FAIL_MAKE_REQUEST
>   	if (should_fail_request(bdev_whole(bio->bi_bdev), bio->bi_iter.bi_size))
>   		return -EIO;
> +#endif
>   	return 0;
>   }
>   ALLOW_ERROR_INJECTION(should_fail_bio, ERRNO);

Has the performance impact of this patch been measured? I'm asking because I
found the following in blk-core.c:

#ifdef CONFIG_FAIL_MAKE_REQUEST
[ ... ]
#else /* CONFIG_FAIL_MAKE_REQUEST */
static inline bool should_fail_request(struct block_device *part,
					unsigned int bytes)
{
	return false;
}
#endif /* CONFIG_FAIL_MAKE_REQUEST */

Thanks,

Bart.
