Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C99C433F5
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 18:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF99460FE8
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 18:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236945AbhIVSFS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Sep 2021 14:05:18 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:37495 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236888AbhIVSFS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Sep 2021 14:05:18 -0400
Received: by mail-pl1-f169.google.com with SMTP id j14so2316045plx.4
        for <linux-block@vger.kernel.org>; Wed, 22 Sep 2021 11:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hux/PRp0DDpHXoVYbplMTFua30bBLW++RMCeJEPh8XM=;
        b=ZKSjIw5DE2WD+AkSHlV5mijw2WnMK5Ogu7IBsyze77AO/vNjH+Tu5rSyuMgQPY+Rpx
         6hWAnWZemGbbj4H4xcZ4jJt2rJtATosap2uxLbscqXfqA30DgIq9gk+LhnXPxLU7ko68
         DiCMG8vD6Wydu0+s2mKmxwYvQHBeV42OZAWeVRVbJRtvg0Cm52NpIaxuYzZyEbH8NguG
         GcHxV110paWulPQB93PFHcNz5ByHAlC5qvTA90ZVnJxneZyW7lixJAAIEvN/e7E0NrLC
         SHotwl1xuoCw3Bxv7adA92nHUM51D951Cgqrp5AUn0s+ULqnb5o+8z+3FXcKGugsX7M4
         MQ0g==
X-Gm-Message-State: AOAM531MHcRQIA1vZyffANekbUc0rSF8yeXHzJMXsg7wOhhHvOW1AXRl
        cp+U6/CrenR/Bmv/egnYyqY=
X-Google-Smtp-Source: ABdhPJxtYp2ky/aNq/wJ1uiduf0w3GO9oihxR9b/yhZFHeVgYvyZ0Y3pgUOnnS6nPv5VchhowLvlvg==
X-Received: by 2002:a17:903:11c8:b0:138:d85a:7f09 with SMTP id q8-20020a17090311c800b00138d85a7f09mr139471plh.75.1632333827384;
        Wed, 22 Sep 2021 11:03:47 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:f3b9:da7d:f0c0:c71c])
        by smtp.gmail.com with ESMTPSA id e14sm3479243pga.23.2021.09.22.11.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 11:03:46 -0700 (PDT)
Subject: Re: [PATCH] null_blk: Fix a NULL pointer dereference
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20210922175055.568763-1-bvanassche@acm.org>
 <d8c3e376-145e-f29a-3cf2-210fae4c8884@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <fdf80121-35aa-0295-8614-54247fd12686@acm.org>
Date:   Wed, 22 Sep 2021 11:03:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <d8c3e376-145e-f29a-3cf2-210fae4c8884@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/22/21 10:54 AM, Jens Axboe wrote:
> On 9/22/21 11:50 AM, Bart Van Assche wrote:
>> Skip queue mapping for shared tag sets. This patch fixes the following bug:
>>
>> ==================================================================
>> BUG: KASAN: null-ptr-deref in null_map_queues+0x131/0x1a0 [null_blk]
>> Read of size 8 at addr 0000000000000000 by task modprobe/4320
>>
>> CPU: 9 PID: 4320 Comm: modprobe Tainted: G         E     5.15.0-rc2-dbg+ #2
>> Call Trace:
>>   show_stack+0x52/0x58
>>   dump_stack_lvl+0x49/0x5e
>>   kasan_report.cold+0x64/0xdb
>>   __asan_load8+0x69/0x90
>>   null_map_queues+0x131/0x1a0 [null_blk]
>>   blk_mq_update_queue_map+0x122/0x1a0
>>   blk_mq_alloc_tag_set+0x1e8/0x570
>>   null_init_tag_set+0x197/0x220 [null_blk]
>>   null_init+0x1dc/0x1000 [null_blk]
>>   do_one_initcall+0xc7/0x440
>>   do_init_module+0x10a/0x3d0
>>   load_module+0x115c/0x1220
>>   __do_sys_finit_module+0x124/0x1a0
>>   __x64_sys_finit_module+0x42/0x50
>>   do_syscall_64+0x35/0xb0
>>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Thanks Bart, do you mind if I fold this one in? I can add a Fixes-by tag
> as well.

Hi Jens,

That sounds good to me. In case this patch would be retained: the word "Skip"
in the description should be changed into "Fix".

Thanks,

Bart.


