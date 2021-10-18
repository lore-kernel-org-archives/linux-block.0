Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E223BC433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 02:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9702E61260
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 02:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243042AbhJRCrL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Oct 2021 22:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243029AbhJRCrJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Oct 2021 22:47:09 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52ED9C06161C
        for <linux-block@vger.kernel.org>; Sun, 17 Oct 2021 19:44:59 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id h196so14543838iof.2
        for <linux-block@vger.kernel.org>; Sun, 17 Oct 2021 19:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ROmwgTJxUUJlIdGOwajlNQUKyGBeB/fJL+Vc0dcdPIw=;
        b=elQPJnPChhOzdCRc3okqt6RkzQ0pYE3BaoS+Bs/YD4OzeV/PoQ+kFvB3hIkUI7XCfT
         1Pop/kKmGOJkWkBX757chqWOmGp5mhc2opVor4jwrRhB5msn4X8Mt/6+mW+4CN1q3kWi
         nB0xbiE9jQYW/f6i7jciKBvVonY88ak7dNNu8pAtclbTzVe2vXr2/eaZe4+OzF3HfLGm
         ase18H//HWjWFODz+hNOAG3gmGFhUJVFqiBOpk6lX4q9kTAkZnUYYjZaM13mbm6B0TKC
         XilVvCYMrWOqNqSrYj1ltba847sRKT8U1jyCvWrlpsaOqleyUZAVJte/EmejMQgRbVZw
         uLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ROmwgTJxUUJlIdGOwajlNQUKyGBeB/fJL+Vc0dcdPIw=;
        b=Xq9gAOwaanZyYqYvikJ7TyBT4NpnlWrbMvTpFLgkZuzQiatOMvbXE07KGEAyO77Pck
         dt5Sv2iK31zHpdWPsDuEpQcItTQXvpco+U7e2HbpqZEibAIs66oYGzwKuWJCzhTQmz+H
         R+Ooo7p/1LMo5rgEpGZFPAgxgYE+5KsRDzbRk8qD+FHQ/z0ILuPlXuUDkkILQtQXj6VO
         qD/BfdYfJRdNyrP5MN30a6KFtbE/QIWO0XnQOxfufvrxoDGDn5tMIJ44bLixbBikuvTk
         e9I4woSHnU5Je+TC49SuVp6dSqD85X9sm8KLGHNNJmLO2u8ZakklvvdQv05dLqYLFKJ7
         9Krw==
X-Gm-Message-State: AOAM530fkWZ7hgRffL7dOQeNBhACT5kRTPCt4OrcmRA7deWoMvDP7TFC
        6VQsAw6/6PawLxkC3KWwOKiMYBSAmkSaIw==
X-Google-Smtp-Source: ABdhPJxw0DmfU4galpR6DrI/Mm0YI3DLQuipYX9Z/Daycs7Pm00Sm/mckNaH/VXA9+3+UyOwHcsYlg==
X-Received: by 2002:a5d:9d82:: with SMTP id ay2mr12476925iob.128.1634525098401;
        Sun, 17 Oct 2021 19:44:58 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id u15sm2271373ilv.85.2021.10.17.19.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Oct 2021 19:44:58 -0700 (PDT)
Subject: Re: [PATCH] block: don't dereference request after flush insertion
To:     Ming Lei <ming.lei@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <f2f17f46-ff3a-01c4-bfd4-8dec836ec343@kernel.dk>
 <YWzfDJ9sYBbLn741@T590>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <304eb692-db58-1cc5-a466-1ffd57fa0d43@kernel.dk>
Date:   Sun, 17 Oct 2021 20:44:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YWzfDJ9sYBbLn741@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/17/21 8:42 PM, Ming Lei wrote:
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
>>  	} else if (plug && (q->nr_hw_queues == 1 ||
>>  		   blk_mq_is_shared_tags(rq->mq_hctx->flags) ||
>>  		   q->mq_ops->commit_rqs || !blk_queue_nonrot(q))) {
> 
> From report in [1], no device close & queue release is involved, and
> request freeing could be much easier to trigger than queue release,
> so looks fine:
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> 
> Fixes: f328476e373a ("blk-mq: cleanup blk_mq_submit_bio")

Wasn't in the one I sent out, but I do have the fixes as well. Thanks,
I'll add your reviewed-by.

-- 
Jens Axboe

