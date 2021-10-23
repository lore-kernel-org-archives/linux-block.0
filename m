Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69E9C433FE
	for <linux-block@archiver.kernel.org>; Sat, 23 Oct 2021 16:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A35BF603E9
	for <linux-block@archiver.kernel.org>; Sat, 23 Oct 2021 16:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhJWQsu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 23 Oct 2021 12:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhJWQsr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 Oct 2021 12:48:47 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F85FC061714
        for <linux-block@vger.kernel.org>; Sat, 23 Oct 2021 09:46:27 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 84-20020a1c0457000000b003232b0f78f8so7618947wme.0
        for <linux-block@vger.kernel.org>; Sat, 23 Oct 2021 09:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5zACOqXUKHzHxjDZfa2fg0c4xU76COEI06vWw/LZ9FI=;
        b=WhU+ImgOL9WewkAb0WyD248bfwfv3x48VOMIedBF/EZfKH0+ap9zam82WdDLXKe+kP
         yckkCZWnc4b+r12HGIRc6YU+rfeG/VHH1cH6YmHl2Wk65+AOekZwoUz/1XnF10iJVYNT
         x5ORNj91TfZINSgzcJQYJTPYB5PX37nGkB/vqYVzffDNZV6Pj/EF3e9QYc1VTKEp690T
         Qj1Azf500GF/7KcX2KuRngdTP1kBdemiYJbU4MKXVQpdTX78AYEJ9Potl2Q97o7OqTgc
         6BoWAX82437PtzgP6jaFPzzXqGNILl30RKrDPPa4yRgOqW1meUH6W82TfSj3QUbwLWhM
         XeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5zACOqXUKHzHxjDZfa2fg0c4xU76COEI06vWw/LZ9FI=;
        b=YPwD5i8g48JIDjEhglDB2iuiOSN+d/gn+cFP4pFnfA7+dvY0+d1ED/TF0qASYY6qRh
         pLnPgJgHo/GFBbHC40lMJsu6qgL32shOwjkQ+Yhf02Pi9G8HqJmLJQs04NTKGILo4PNo
         lBuD9tP91f3i7jQC8e/jHKQgKGH5yPazF9rK2DayyzubSa7GI2pGMzvbSGZIbQJw3k+f
         uVf1QXuSwD+Z2U6sYXZxNcKLMC/LR1QuknMTZpFkUTkr1F5L5iTQt8xhJEVkLHSp8Yw4
         d4BGQaad+wAlW9IalmN54zsseexPUwajCOPC/1pLoNoNNIcn/BMGY7L77wdhOMFVKHow
         Q+Nw==
X-Gm-Message-State: AOAM530NK0XofctmSPRlHaGjcWegcyGFxkAtBW4YB0YtU3VWXy23s91E
        2Lh47r1EjHTrfYlisiPjLnDq1P7dDH8=
X-Google-Smtp-Source: ABdhPJz7ZSJ14SInVOhP1lg8VjEwvYMpCOPzRIJa6PfrG5di0+JUy1V5TzE0wU/ExjjF36S486VOTw==
X-Received: by 2002:a05:600c:3b89:: with SMTP id n9mr36053036wms.7.1635007585694;
        Sat, 23 Oct 2021 09:46:25 -0700 (PDT)
Received: from [192.168.8.198] ([148.252.133.195])
        by smtp.gmail.com with ESMTPSA id j7sm14663897wmq.32.2021.10.23.09.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Oct 2021 09:46:25 -0700 (PDT)
Message-ID: <9200437d-d5b7-fca2-b8e3-32a01603b281@gmail.com>
Date:   Sat, 23 Oct 2021 17:46:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 4/5] block: kill unused polling bits in
 __blkdev_direct_IO()
Content-Language: en-US
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
References: <cover.1635006010.git.asml.silence@gmail.com>
 <2e63549f6bce3442c27997fae83082f1c9f4e6c3.1635006010.git.asml.silence@gmail.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <2e63549f6bce3442c27997fae83082f1c9f4e6c3.1635006010.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/23/21 17:21, Pavel Begunkov wrote:
> With addition of __blkdev_direct_IO_async(), __blkdev_direct_IO() now
> serves only multio-bio I/O, which we don't poll. Now we can remove
> anything related to I/O polling from it.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>   block/fops.c | 20 +++-----------------
>   1 file changed, 3 insertions(+), 17 deletions(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index 8800b0ad5c29..997904963a9d 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -190,7 +190,6 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>   	struct blk_plug plug;
>   	struct blkdev_dio *dio;
>   	struct bio *bio;
> -	bool do_poll = (iocb->ki_flags & IOCB_HIPRI);
>   	bool is_read = (iov_iter_rw(iter) == READ), is_sync;
>   	loff_t pos = iocb->ki_pos;
>   	int ret = 0;
> @@ -216,12 +215,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>   	if (is_read && iter_is_iovec(iter))
>   		dio->flags |= DIO_SHOULD_DIRTY;
>   
> -	/*
> -	 * Don't plug for HIPRI/polled IO, as those should go straight
> -	 * to issue
> -	 */
> -	if (!(iocb->ki_flags & IOCB_HIPRI))
> -		blk_start_plug(&plug);

I'm not sure, do we want to leave it conditional here?

-- 
Pavel Begunkov
