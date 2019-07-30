Return-Path: <SRS0=ZBGg=V3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA7FC433FF
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 13:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748A22064A
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 13:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUFM9W8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfG3Nfb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jul 2019 09:35:31 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46633 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfG3Nfb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jul 2019 09:35:31 -0400
Received: by mail-pl1-f194.google.com with SMTP id c2so28883455plz.13;
        Tue, 30 Jul 2019 06:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D0myQa878LoDhB10dhpZ38+k3ChAHNGIV6DAjCm92ls=;
        b=hUFM9W8Gj4mPlzEJyOjPQiGt5ZeJSZ4NBK0060jBEGBRBh3AR5QYMJiQZr1LaqWQD+
         SBjZBnkB72KzONPwvYCsT/HhUapKkqVx1MEL1mLT8lhPsAq+YSXi/MnjxrQ4GaYehGsO
         GrYFacs5UiwMYucENV4vGKFCJPHvJ5LAEvnaph3Unn9lxxOlYKbmiA1yNdu7nA6ycsIr
         VBRkw7M9nMn6NlE2IfaxmU2mb3C9pnssOSe+Tnx5KewLH39cb58fhjVX6+U+fkVhb5PR
         p+KVh4Wg9GS3/u8fcU4RmKessByo7eQSEIH0AR2W186hP/gbfwnFlRZhi27dwVsje0eZ
         tUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D0myQa878LoDhB10dhpZ38+k3ChAHNGIV6DAjCm92ls=;
        b=llSqXFQFd7yhUAJIVfjxEOMYYqyF8wjV0/aYST5PnC1gFHCOioyg9Su3ohcV1A4xfR
         M5MsZjOo/WMEr812UYuNmj7jVoMFcq7U3rxvqlSwneBRkfOhrYx56hfqxEsxYmEOUuAR
         ez+kQt/MCsCpg5RokOe32ldnEu9Yf8fbW4NJ/m0/xoC+okmxZg3g8DFtZNizoMD1AAec
         Mr0p5q7L+itkYVnFDm6Gqnv3Ni3NTEakxMIMZrx3ViqLL3cvpMNEk+QmttRLkRR7hngC
         dz6LIPLDb7uJRUCGg2ZLN2L+o4D3TRPr7CR7uIoEBWmhIMlQhYTWzX7aD51uDsWxad6W
         W3xQ==
X-Gm-Message-State: APjAAAWehQ5dMtcb8JuHJC7YltASNG2iTp8xhA0uuV0rpv0qEdqb5fVX
        dT+onUDFIrtmXSKXWaIldKo=
X-Google-Smtp-Source: APXvYqywgDjfpG/mRBois7D/7Z/tVtbteNVt5H2Bw8ZXuMw2EIqqPAX9RIhBUWbFXCxtOA5LZl1auA==
X-Received: by 2002:a17:902:a409:: with SMTP id p9mr116469763plq.218.1564493730500;
        Tue, 30 Jul 2019 06:35:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u3sm58383392pjn.5.2019.07.30.06.35.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 06:35:29 -0700 (PDT)
Subject: Re: [PATCH] bfq: Check if bfqq is NULL in bfq_insert_request
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Hsin-Yi Wang <hsinyi@google.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Doug Anderson <dianders@chromium.org>
References: <1563816648-12057-1-git-send-email-linux@roeck-us.net>
 <20190728151931.GA29181@roeck-us.net>
 <0BCD5EDA-6D08-4023-9EEA-087F0AB99D47@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <23890163-facd-3838-ddee-770b7c2f32ea@roeck-us.net>
Date:   Tue, 30 Jul 2019 06:35:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0BCD5EDA-6D08-4023-9EEA-087F0AB99D47@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/30/19 1:55 AM, Paolo Valente wrote:
> Hi Guenter,
> sorry for the delay (Dolomiti's fault).
> 
> I didn't consider that rq->elv-icq might have been NULL also
> because of OOM.  Thanks for spotting this issue.
> 
> As for the other places where the return value of bfq_init_rq is used,
> unfortunately I think they matter too.  Those other places are related
> to request merging, which is the alternative destiny of requests
> (instead of being just inserted).  But, regardless of whether a
> request is to be merged or inserted, that request may be destined to a
> bfq_queue (possibly merged with a request already in a bfq_queue), and
> a NULL return value by bfq_init_rq leads to a crash.  I guess you can
> reproduce your failure also for the merge case, by generating
> sequential, direct I/O with queue depth > 1, and of course by enabling
> failslab.
> 
My assumption was that requests would only be merged if they are associated
with the same io context. In that case, that IO context isn't reallocated
with ioc_create_icq() but reused, and icq would thus never be NULL.
I guess that assumption was wrong.

> If my considerations above are correct, do you want to propose a
> complete fix yourself?
> 

Sure, I'll send an updated patch.

Thanks,
Guenter

> Thanks,
> Paolo
> 
>> Il giorno 28 lug 2019, alle ore 17:19, Guenter Roeck <linux@roeck-us.net> ha scritto:
>>
>> ping ... just in case this patch got lost in Paolo's queue.
>>
>> Guenter
>>
>> On Mon, Jul 22, 2019 at 10:30:48AM -0700, Guenter Roeck wrote:
>>> In bfq_insert_request(), bfqq is initialized with:
>>> 	bfqq = bfq_init_rq(rq);
>>> In bfq_init_rq(), we find:
>>> 	if (unlikely(!rq->elv.icq))
>>> 		return NULL;
>>> Indeed, rq->elv.icq can be NULL if the memory allocation in
>>> create_task_io_context() failed.
>>>
>>> A comment in bfq_insert_request() suggests that bfqq is supposed to be
>>> non-NULL if 'at_head || blk_rq_is_passthrough(rq)' is false. Yet, as
>>> debugging and practical experience shows, this is not the case in the
>>> above situation.
>>>
>>> This results in the following crash.
>>>
>>> Unable to handle kernel NULL pointer dereference
>>> 	at virtual address 00000000000001b0
>>> ...
>>> Call trace:
>>> bfq_setup_cooperator+0x44/0x134
>>> bfq_insert_requests+0x10c/0x630
>>> blk_mq_sched_insert_requests+0x60/0xb4
>>> blk_mq_flush_plug_list+0x290/0x2d4
>>> blk_flush_plug_list+0xe0/0x230
>>> blk_finish_plug+0x30/0x40
>>> generic_writepages+0x60/0x94
>>> blkdev_writepages+0x24/0x30
>>> do_writepages+0x74/0xac
>>> __filemap_fdatawrite_range+0x94/0xc8
>>> file_write_and_wait_range+0x44/0xa0
>>> blkdev_fsync+0x38/0x68
>>> vfs_fsync_range+0x68/0x80
>>> do_fsync+0x44/0x80
>>>
>>> The problem is relatively easy to reproduce by running an image with
>>> failslab enabled, such as with:
>>>
>>> cd /sys/kernel/debug/failslab
>>> echo 10 > probability
>>> echo 300 > times
>>>
>>> Avoid the problem by checking if bfqq is NULL before using it. With the
>>> NULL check in place, requests with missing io context are queued
>>> immediately, and the crash is no longer seen.
>>>
>>> Fixes: 18e5a57d79878 ("block, bfq: postpone rq preparation to insert or merge")
>>> Reported-by: Hsin-Yi Wang  <hsinyi@google.com>
>>> Cc: Hsin-Yi Wang <hsinyi@google.com>
>>> Cc: Nicolas Boichat <drinkcat@chromium.org>
>>> Cc: Doug Anderson <dianders@chromium.org>
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>> ---
>>> block/bfq-iosched.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>>> index 72860325245a..56f3f4227010 100644
>>> --- a/block/bfq-iosched.c
>>> +++ b/block/bfq-iosched.c
>>> @@ -5417,7 +5417,7 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>>>
>>> 	spin_lock_irq(&bfqd->lock);
>>> 	bfqq = bfq_init_rq(rq);
>>> -	if (at_head || blk_rq_is_passthrough(rq)) {
>>> +	if (!bfqq || at_head || blk_rq_is_passthrough(rq)) {
>>> 		if (at_head)
>>> 			list_add(&rq->queuelist, &bfqd->dispatch);
>>> 		else
>>> -- 
>>> 2.7.4
>>>
> 
> 

