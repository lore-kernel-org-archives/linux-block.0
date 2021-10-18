Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5FFC433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 01:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64D43610E5
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 01:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243044AbhJRBwg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Oct 2021 21:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbhJRBwg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Oct 2021 21:52:36 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075CDC06161C
        for <linux-block@vger.kernel.org>; Sun, 17 Oct 2021 18:50:26 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id e144so14432539iof.3
        for <linux-block@vger.kernel.org>; Sun, 17 Oct 2021 18:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=856piC5HgL7RmOIjYrzQo7CEt/GbSr8Lkl9VRrI9+KU=;
        b=jjhrfJ3PDN0KaOVIcLs+ADFaf90qEjdF34Wjs7oFk5/GSOrY7vk/cGYixHcmwPWAmp
         8xqnXX7KgsKmF56bfiOXKZp9A/w1/MH1tlWPviy1v1F5ysrP+Bh+lQJ7Sfr1e+sju60R
         6f6gfs7AUxZ2m48oewAhRcg9TovyS1zPtA9BdCqnklW4JPrRtEhpFY5q6lxKiPGNcXKw
         UQ119MxCgpMr4DK5ao8d3kmxnz5W6gUwBjsd0zDNel6UH0EsieRJmSpE5/EpxOr+H74t
         BhNb4Zbx/ZyVGL6kt9bhsDgEmkMQirEkoO4V2TGRilLeIC7OcPN30TW2iWbM3y5bzoC5
         BaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=856piC5HgL7RmOIjYrzQo7CEt/GbSr8Lkl9VRrI9+KU=;
        b=Wuax2s8aaTPuTsEzqaLd6yp6U+0JiZ+ERN8r0IGyi+YvbS3KqnQdyByw4MykDJdzAw
         dslpzrF3mTMZILETqzBrGTLrdgk17C0MtkqlLFX23RZSHkyUSmZAGufo1rqpCYgM+SuD
         MttlEIzIHVD7qPlte4JdMhA0iW1r8+deKhMwbsRCEQq0xov/d2fGumSQHjKn5cGHMLcH
         CWmqphXFIuDd5vY30pCaaa9tENdg2ukciLMdFesgnm2fN6CqLy0fLTYlzm1wByfDGpne
         SIGqt6FOM55UPOuSHZ4xzAsEQPDtUOFFMT04l948ZTOrYRLhYpok5W8hKLX/3yFpfwha
         k6fA==
X-Gm-Message-State: AOAM532iK6dScCVGBjkpViZyh/U0YO/UNVSYgSpUQnPrO3HCCz4WH87Q
        QEVYa2REH0FCDAtQtPWaMwGDcqGyLG0=
X-Google-Smtp-Source: ABdhPJwoq96ICbwLCE0A3wYzer4IVpHhUGbeTagWKLNIVp8R4Oxx9ok9AWavhma3LxryAEfU+WhK5A==
X-Received: by 2002:a05:6602:2acb:: with SMTP id m11mr1467259iov.155.1634521825205;
        Sun, 17 Oct 2021 18:50:25 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id 81sm6093047iou.21.2021.10.17.18.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Oct 2021 18:50:24 -0700 (PDT)
Subject: Re: [PATCH] block: don't dereference request after flush insertion
To:     Ming Lei <ming.lei@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <f2f17f46-ff3a-01c4-bfd4-8dec836ec343@kernel.dk>
 <YWzSqzsuDF8Fl9jB@T590>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <17362528-4be4-1407-5a05-cfb0a7524910@kernel.dk>
Date:   Sun, 17 Oct 2021 19:50:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YWzSqzsuDF8Fl9jB@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/17/21 7:49 PM, Ming Lei wrote:
> On Sat, Oct 16, 2021 at 07:35:39PM -0600, Jens Axboe wrote:
>> We could have a race here, where the request gets freed before we call
>> into blk_mq_run_hw_queue(). If this happens, we cannot rely on the state
>> of the request.
>>
>> Grab the hardware context before inserting the flush.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> ---
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 2197cfbf081f..22b30a89bf3a 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -2468,9 +2468,10 @@ void blk_mq_submit_bio(struct bio *bio)
>>  	}
>>  
>>  	if (unlikely(is_flush_fua)) {
>> +		struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
>>  		/* Bypass scheduler for flush requests */
>>  		blk_insert_flush(rq);
>> -		blk_mq_run_hw_queue(rq->mq_hctx, true);
>> +		blk_mq_run_hw_queue(hctx, true);
> 
> If the request is freed before running queue, the request queue could
> be released and the hctx may be freed.

No, we still hold a queue enter ref.

-- 
Jens Axboe

