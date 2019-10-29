Return-Path: <SRS0=FPpm=YW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5728ACA9EAE
	for <linux-block@archiver.kernel.org>; Tue, 29 Oct 2019 16:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2828821479
	for <linux-block@archiver.kernel.org>; Tue, 29 Oct 2019 16:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wedfLyUo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390363AbfJ2QLE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Oct 2019 12:11:04 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37840 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390313AbfJ2QLE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Oct 2019 12:11:04 -0400
Received: by mail-io1-f65.google.com with SMTP id 1so15399758iou.4
        for <linux-block@vger.kernel.org>; Tue, 29 Oct 2019 09:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F6ER53BgOcOjbbASqksGEOGLpbaFeVJy95CCofNvLlk=;
        b=wedfLyUog88ghsfUG9ng4sLf1z/0VkWmVqCXwEabMblSAUIbJwdmrGPd7Ankmm1wJ2
         MRaQY7cEyNQ704VjmmdbgVmcgQedQhFQa1iQjkdzFwl4co5Q/5AzIzh1iLGjmaU1opiI
         QB9H3VXcCBtKOp0CP1xKiGhav1LWQ1KEEjHvhD9cLz1qqdZG4BqEOlKf++lL2LFE0ln4
         XqILHG9eF2S4lJ7wId87UW2m8VCZ3s7J5lcQ9QFnXb+xTdDSr+2RZwKboyKFa1xUjPy6
         BMeZi37D7mmnlqjCLFCuj3fHmkEY9ZeTWFtK2l4tHi4+81RlDOiV4b+Pr19sXKGJowcZ
         xALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F6ER53BgOcOjbbASqksGEOGLpbaFeVJy95CCofNvLlk=;
        b=ez5FXfk9rETK/UIcE1JWyKWPLtq2dyBWQKFZtkDFzZ7fjmbApT6Sz7BIyVFXUc8MXE
         yMkyizmUrMMcFQlx//WUhukiDiu6hjBDfdonAF5Dx+OfuExMod364FxYbS+tYBgnm6E/
         h7mkPEOLtD+thcHATMHja2IM5bTLGT80xzKPXNJy1AC1qy5ABEREaaYf3ZJ93p11QP4z
         1kyFYexbsxLKyKIyx2x9aow0vZxFtNqwpiZslTANN0RxtnxjtbVfyVvN664oRYjhsx0i
         Akj9eLEtq/+/pTdwfzoqs6Z4ykFCaLq026Hh5ERv7DLKfZjiAJ0ixteVKYQu1wvgBVo3
         Pamw==
X-Gm-Message-State: APjAAAWTYw8Z0QN3kdo8J0FQO5vnSxspMQv7Q+2OHkin6B+MnaQfN4Y6
        koliAph+aC6dfCntJGW4dGLpMyNvcIA2qQ==
X-Google-Smtp-Source: APXvYqyhZskMd8k1bAZr4oT8JlZ3SnlIevkxMe0j+YZP1JrfvqIqI+ZeA56Fhi9q5xKNTv9G4Gse1A==
X-Received: by 2002:a02:cac5:: with SMTP id f5mr23340042jap.113.1572365463018;
        Tue, 29 Oct 2019 09:11:03 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x17sm735843ilh.22.2019.10.29.09.11.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 09:11:02 -0700 (PDT)
Subject: Re: [PATCH] fs/iomap: remove redundant check in iomap_dio_rw()
To:     Joseph Qi <joseph.qi@linux.alibaba.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-block@vger.kernel.org
References: <1572342047-99933-1-git-send-email-joseph.qi@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c373998d-9edb-8071-3440-71c41a7bb546@kernel.dk>
Date:   Tue, 29 Oct 2019 10:11:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1572342047-99933-1-git-send-email-joseph.qi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/29/19 3:40 AM, Joseph Qi wrote:
> We've already check if it is READ iov_iter, no need check again.
> 
> Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>   fs/iomap/direct-io.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 1fc28c2..9712648 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -430,7 +430,7 @@ static void iomap_dio_bio_end_io(struct bio *bio)
>   		if (pos >= dio->i_size)
>   			goto out_free_dio;
>   
> -		if (iter_is_iovec(iter) && iov_iter_rw(iter) == READ)
> +		if (iter_is_iovec(iter))
>   			dio->flags |= IOMAP_DIO_DIRTY;
>   	} else {
>   		flags |= IOMAP_WRITE;
> 

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

