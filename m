Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBAAC433F5
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 18:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A55161038
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 18:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242788AbhIWSzc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Sep 2021 14:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242767AbhIWSzc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Sep 2021 14:55:32 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654B0C061574
        for <linux-block@vger.kernel.org>; Thu, 23 Sep 2021 11:54:00 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id d11so7691218ilc.8
        for <linux-block@vger.kernel.org>; Thu, 23 Sep 2021 11:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2m0N+weGzG2qO8vFvpKw3nxtWg6SPdWR96to+3/QaUw=;
        b=fsxzb6wCcYh46HoKhARISsqgpl2IfkWIliwJGF742HyMZrS6R6gRNgWfbKYUd53JEu
         MbWEoOYBww5IBuIhSLDGnY/E4RsSaIcz6Agw8pj0jIpiq+HkHAEdctA9BYKL6wC6R0tP
         pmDFUY+V/xg/OEkTinN7nPbN8TuSSXnwSsdv05aVoRWC0Rqdy1s0tdokm0wsKA5IM1E8
         DM04+d9NwL2hCIjtbvSxTJ0F95lpvJMxnikJFCbxL936wf0FcDrLnev29Hl4ZKSrK4AC
         hTvWeYYZxYqFlc5NG+2hbK9jrdirjHoTuYXCupVqCFHqLammTh48mGR/c3pH7Xr75xIs
         jR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2m0N+weGzG2qO8vFvpKw3nxtWg6SPdWR96to+3/QaUw=;
        b=TGWGg10Lil4QnOffZmRb4jCynXXxtF1/2BLZ+dMNCjBFiNaTfvLFVcpKzI4BzHYdXp
         AmmX1n/6tlvd2aQ4fBGXjVyuiahuXVVCjRqekcfvMATpvfhIOSJirRjIiq4cGX2jhQ1b
         CMO39xRh78rN3dfYED4PGUU1I7HA1UMQ2gCFDFn6epHBcIIiiII2m4ac/m1C3yzEVHAL
         KUlo6jYgz43tp1ntmh/b5Q1XpYvB+nAxsivw05uxkscDLf8VONXuI3oE4IDQGcx5D2Do
         49QSu41UwFXyufjVsFojvgmJFYF6R962Rci+rAO15NAjxTGFlEDCZkVP4WEzB8QAdShR
         vz0w==
X-Gm-Message-State: AOAM530kdQY9QzFdJs1uOsbtWSzC/ndBmxCKpPNuOCSkilTUIckgYF+G
        JtADrIOivsX1ez0EGJlbW7UVrw==
X-Google-Smtp-Source: ABdhPJwh+LLhol1e4iCc++KLLWm4cRl5a6PoYS+4hlRRSwCN3KRsS0KHE+MR6YC+bhr7DyOWGk21xA==
X-Received: by 2002:a92:c54c:: with SMTP id a12mr4848476ilj.81.1632423239695;
        Thu, 23 Sep 2021 11:53:59 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id z4sm2893308iln.4.2021.09.23.11.53.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 11:53:59 -0700 (PDT)
Subject: Re: [PATCH] null_blk: Fix a NULL pointer dereference
From:   Jens Axboe <axboe@kernel.dk>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20210922175055.568763-1-bvanassche@acm.org>
 <d8c3e376-145e-f29a-3cf2-210fae4c8884@kernel.dk>
 <fdf80121-35aa-0295-8614-54247fd12686@acm.org>
 <ae742deb-df52-9c65-8cb1-3f66dc0bde53@acm.org>
 <4c26ddaf-1b25-7a53-6e6b-09b59ada1a99@kernel.dk>
 <941cc786-fea9-4f35-dc19-8b84461285e9@acm.org>
 <86906e1f-83dd-503f-1369-158966a2ac20@kernel.dk>
 <83d45e6b-6bd5-8e59-d0bf-6d86b18a81f4@acm.org>
 <fc3299cf-1603-fcd9-6287-1424586cb479@kernel.dk>
Message-ID: <043399af-0e2e-6f9a-8422-015c8840907c@kernel.dk>
Date:   Thu, 23 Sep 2021 12:53:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fc3299cf-1603-fcd9-6287-1424586cb479@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/23/21 11:55 AM, Jens Axboe wrote:
> On 9/23/21 11:51 AM, Bart Van Assche wrote:
>> On 9/23/21 9:39 AM, Jens Axboe wrote:
>>> On 9/23/21 10:22 AM, Bart Van Assche wrote:
>>>> On 9/23/21 9:04 AM, Jens Axboe wrote:
>>>>> What options are you loading null_blk with?
>>>>
>>>> The issues I reported are the result of running test blk/010 from the
>>>> blktests suite. That test loads the null_blk kernel module twice:
>>>>
>>>> _init_null_blk queue_mode=2 submit_queues=16 nr_devices=32
>>>> [ ... ]
>>>> _exit_null_blk
>>>> _init_null_blk queue_mode=2 submit_queues=16 nr_devices=32 shared_tags=1
>>>> [ ... ]
>>>> _exit_null_blk
>>>>
>>>> Please let me know if you need more information.
>>>
>>> Tried both that and running block/010, didn't trigger anything for me.
>>> Odd...
>>
>> Hi Jens,
>>
>> I took another look at the kernel logs from yesterday of the VM that I use
>> for testing. In that kernel log I found the following:
>> * Without any changes on top of the for-next branch of
>>    git://git.kernel.dk/linux-block (commit 4129031563d0 ("Merge branch
>>    'for-5.16/io_uring' into for-next"), test block/010 triggers the oops
>>    reported at the start of this email thread.
>> * With the patch at the start of this email thread applied, the first test
>>    that triggers a kernel oops is block/020 (blk_mq_free_rqs+0x1f4).
>>
>> This morning I rebuilt the block for-next kernel with and without my
>> null_blk patch applied. I was able to reproduce what I observed yesterday.
>> Test block/020 passes with if commit 5f7acddf706c ("null_blk: poll queue
>> support") is reverted. This is why I wrote that my patch does not seem to
>> be sufficient to fix commit 5f7acddf706c.
> 
> Ah ok, so it's block/020, not block/010 for the later one. I'll take a
> look.

I think it's the assumption that poll_queueus == submit_queues. Does this
work for you?


diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index eb5cfe189e90..dac88c5daff9 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1748,7 +1757,7 @@ static int setup_queues(struct nullb *nullb)
 	int nqueues = nr_cpu_ids;
 
 	if (g_poll_queues)
-		nqueues *= 2;
+		nqueues += g_poll_queues;
 
 	nullb->queues = kcalloc(nqueues, sizeof(struct nullb_queue),
 				GFP_KERNEL);
@@ -1814,7 +1823,7 @@ static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set *set)
 						g_submit_queues;
 	poll_queues = nullb ? nullb->dev->poll_queues : g_poll_queues;
 	if (poll_queues)
-		set->nr_hw_queues *= 2;
+		set->nr_hw_queues += poll_queues;
 	set->queue_depth = nullb ? nullb->dev->hw_queue_depth :
 						g_hw_queue_depth;
 	set->numa_node = nullb ? nullb->dev->home_node : g_home_node;

-- 
Jens Axboe

