Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80494C677F1
	for <linux-block@archiver.kernel.org>; Mon, 16 Jan 2023 18:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbjAPS3a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Jan 2023 13:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235109AbjAPS2p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Jan 2023 13:28:45 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCE723C78
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 10:15:25 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id v23so29884746pju.3
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 10:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xxk6pBQe6EyhGAfl47JxZccyhtoId1DNdMuejrbvSlc=;
        b=ky1hQCt4geHh7G8t24WAMpCzhflncZgWinTRSwXlAKak/isb+uWx/4QnSBH2T/Psdr
         n19WTE1oAexCtsy/xTVYwC9OpUm13/L3U4O0q8YmeY6nDncJKuitS8Nj1iSoZa8IhBuk
         qKfqiQFBFkmqtR9IgWvp0mRrVo2AvRogCkfIf8XU2QzmxczUWSIDSnYyyDh6rm3vsznl
         RTvreR4wBYNgi3eWTmSY36Bl8OHTz4vPT/0HjS4GNkNO+H+ubvh2Azg//vd+yx7gr+9/
         10YqU9+BapvABRM7mP3ZNiGE68II0geyoAB5TE0kBkYFEFFfH4dLJcxroM6XtmQQVADw
         D2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xxk6pBQe6EyhGAfl47JxZccyhtoId1DNdMuejrbvSlc=;
        b=qfvinAmmx2ceNGlb5FJI01n2C/0dSaae3Y6zZYQCJMjHqdoyunVBxHaW9a8IlneLc+
         9U7jokYX546IZfwbKET/KKYd1LDfLZNieMXvsPE25svRYch4WJqR3odsJgHb/BOWgmlO
         nIZgXNptk5xlxH83xWCNhrKhBTAPRjh4fFk7Nq6GQDqTp8CIEp5yzQLyxwDf5qsSRJQO
         Nb30Im0pWjspNY+mvuS7hUYyAWrLHBxgSqZyKMF3h2uOTOTurDeYDUM5uvgCL/NuZkrb
         ik4u8WaiVRbjtHNTs70K+jlbssggM1cGkhLVszTKfcISWVkLlebMfFBt/am3YJbKVYrY
         g+sA==
X-Gm-Message-State: AFqh2koLX3oheMz6cvMCbcZh3armwYIH71E0B2usfawPmjPJBbCF7oGU
        G8eWdgYE7JG2rsQaJVaOMQHgvjBekbuKB3xn
X-Google-Smtp-Source: AMrXdXv0wtehyEq/TT/N3qCqH8depzRUURwYxTDR9DrUfPz6TYasSO38wE4yTslApAnnchBPja4UeA==
X-Received: by 2002:a17:902:f24a:b0:193:10b9:8fb9 with SMTP id j10-20020a170902f24a00b0019310b98fb9mr172480plc.1.1673892925356;
        Mon, 16 Jan 2023 10:15:25 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b2-20020a170903228200b001867fdec154sm19666288plh.224.2023.01.16.10.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 10:15:25 -0800 (PST)
Message-ID: <74da71bf-d352-0aad-3cb5-3d65cba5bc24@kernel.dk>
Date:   Mon, 16 Jan 2023 11:15:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] block: don't allow multiple bios for IOCB_NOWAIT issue
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
References: <c5631d66-3627-5d04-c810-c060c9fd7077@kernel.dk>
 <Y8WOuHQ21PP/W6Rv@infradead.org>
 <ec218e9e-5433-c6b5-a6a6-85a64fd2ea7f@kernel.dk>
In-Reply-To: <ec218e9e-5433-c6b5-a6a6-85a64fd2ea7f@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/16/23 11:03?AM, Jens Axboe wrote:
>>> +	/*
>>> +	 * We're doing more than a bio worth of IO (> 256 pages), and we
>>> +	 * cannot guarantee that one of the sub bios will not fail getting
>>> +	 * issued FOR NOWAIT as error results are coalesced across all of
>>> +	 * them. Be safe and ask for a retry of this from blocking context.
>>> +	 */
>>> +	if (iocb->ki_flags & IOCB_NOWAIT)
>>> +		return -EAGAIN;
>>>  	return __blkdev_direct_IO(iocb, iter, bio_max_segs(nr_pages));
>>
>> If the I/O is too a huge page we could easily end up with a single
>> bio here.
> 
> True - we can push the decision making further down potentially, but
> honestly not sure it's worth the effort.

And even for page merges too, fwiw. We could probably do something like
the below (totally untested), downside there would be that we've already
mapped and allocated a bio at that point.


diff --git a/block/fops.c b/block/fops.c
index a03cb732c2a7..859361011e43 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -221,6 +221,14 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 			bio_endio(bio);
 			break;
 		}
+		if (iocb->ki_flags & IOCB_NOWAIT) {
+			if (iov_iter_count(iter)) {
+				bio_release_pages(bio, false);
+				bio_put(bio);
+				return -EAGAIN;
+			}
+			bio->bi_opf |= REQ_NOWAIT;
+		}
 
 		if (is_read) {
 			if (dio->flags & DIO_SHOULD_DIRTY)
@@ -228,9 +236,6 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		} else {
 			task_io_account_write(bio->bi_iter.bi_size);
 		}
-		if (iocb->ki_flags & IOCB_NOWAIT)
-			bio->bi_opf |= REQ_NOWAIT;
-
 		dio->size += bio->bi_iter.bi_size;
 		pos += bio->bi_iter.bi_size;
 

-- 
Jens Axboe

