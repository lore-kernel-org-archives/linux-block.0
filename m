Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FDAC433F5
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 17:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCD4A61019
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 17:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241666AbhIWRxa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Sep 2021 13:53:30 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:39796 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241689AbhIWRxa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Sep 2021 13:53:30 -0400
Received: by mail-pg1-f182.google.com with SMTP id g184so7108368pgc.6
        for <linux-block@vger.kernel.org>; Thu, 23 Sep 2021 10:51:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zhHBU4RPPu8LJIPv7n2EekaIyggsXTrL19OUK52dHOM=;
        b=CK32HEhBB71ME2ekX4hhaYLfsiNt2whkV4GOl4vk+FH7Tczuh4mDFXFdamPORSiY7x
         xJQCvVupm6HT27C4aTs/SmJABZG5SLdrGnSksSCGrmI38/XOEAImkFhlsOzpJLwHmLJ1
         KjbLSIUu6tWjrGnKZCgXJ8MYNwSKRkVI8DAPNqcQFCE+25t/zXXKntqUDw/ONzzsPDEe
         ixaFLt51B/8wnAcz0CuJU34fFNM54S0uId+oLfEstWeOVlVQ3ay2YVrPMUFGJIaBNWie
         gEN6ph1yqvhJLzAC5pauoa6T6AFS1p85EfjEekD0c5OxItb/Lkdg6VnZVKjt6/bB8lSs
         KdDQ==
X-Gm-Message-State: AOAM5309L9SLRH7npkJH4d10n80D7pYDEWUmDzUpgAyHOxg+LpS9gjEE
        ra0ecmoceM8LqF0XjT8Abr0=
X-Google-Smtp-Source: ABdhPJwPCl5zjtQR7WcyBK54TK5BszMAGL+8G2/334gzefkCmH8G//pUXl9dck6Sk1YNQS9I1tGPwA==
X-Received: by 2002:a05:6a00:d60:b0:43d:f987:66be with SMTP id n32-20020a056a000d6000b0043df98766bemr5803722pfv.37.1632419518141;
        Thu, 23 Sep 2021 10:51:58 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3c28:de2e:5efb:9f34])
        by smtp.gmail.com with ESMTPSA id y2sm5857354pjl.6.2021.09.23.10.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 10:51:57 -0700 (PDT)
Subject: Re: [PATCH] null_blk: Fix a NULL pointer dereference
To:     Jens Axboe <axboe@kernel.dk>
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
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <83d45e6b-6bd5-8e59-d0bf-6d86b18a81f4@acm.org>
Date:   Thu, 23 Sep 2021 10:51:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <86906e1f-83dd-503f-1369-158966a2ac20@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/23/21 9:39 AM, Jens Axboe wrote:
> On 9/23/21 10:22 AM, Bart Van Assche wrote:
>> On 9/23/21 9:04 AM, Jens Axboe wrote:
>>> What options are you loading null_blk with?
>>
>> The issues I reported are the result of running test blk/010 from the
>> blktests suite. That test loads the null_blk kernel module twice:
>>
>> _init_null_blk queue_mode=2 submit_queues=16 nr_devices=32
>> [ ... ]
>> _exit_null_blk
>> _init_null_blk queue_mode=2 submit_queues=16 nr_devices=32 shared_tags=1
>> [ ... ]
>> _exit_null_blk
>>
>> Please let me know if you need more information.
> 
> Tried both that and running block/010, didn't trigger anything for me.
> Odd...

Hi Jens,

I took another look at the kernel logs from yesterday of the VM that I use
for testing. In that kernel log I found the following:
* Without any changes on top of the for-next branch of
   git://git.kernel.dk/linux-block (commit 4129031563d0 ("Merge branch
   'for-5.16/io_uring' into for-next"), test block/010 triggers the oops
   reported at the start of this email thread.
* With the patch at the start of this email thread applied, the first test
   that triggers a kernel oops is block/020 (blk_mq_free_rqs+0x1f4).

This morning I rebuilt the block for-next kernel with and without my
null_blk patch applied. I was able to reproduce what I observed yesterday.
Test block/020 passes with if commit 5f7acddf706c ("null_blk: poll queue
support") is reverted. This is why I wrote that my patch does not seem to
be sufficient to fix commit 5f7acddf706c.

Thanks,

Bart.



