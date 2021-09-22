Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503FDC433EF
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 18:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3442860F3A
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 18:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237080AbhIVS23 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Sep 2021 14:28:29 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:46713 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237047AbhIVS23 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Sep 2021 14:28:29 -0400
Received: by mail-pg1-f178.google.com with SMTP id m21so3572032pgu.13
        for <linux-block@vger.kernel.org>; Wed, 22 Sep 2021 11:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gALV8ok8p9cvWmB8PhrqIBVLc8BHnQg0yqdm0Y0Buw8=;
        b=nBb6jaX6J5XHjP3K7BZLqybra0jgUhM5W/miBT1ayjAKqCIm/N1Jgkvds7ry78VovN
         O106Hwh+r43I/7CsR34c+m2/8GHejVtIkfTbLAcU2HBXOSwUveHheed8ICR5KpPf23pG
         0LzCfRIPJVycJxkCEjqw+nihcGA+xIyd4ZjfXkjOO6rh5GKVO5UcutlJIOA2/5/hpgou
         zm0NJ49XI55lvX74J4r5TXKx8QyMiMqLmLRr3QnLk6VivF4wyqSY5EJQCyblhYyJOM7l
         vmvl7h9/lVqi5xd5aS9rpG+7XjnyyG5lqivNmQEZhdQtQSh7mQo/JzaJgBMSDRb8ZH3V
         M7Uw==
X-Gm-Message-State: AOAM533B5xjy5cb4aKC52zoSZ9R+FxlzNSo/QK8+gLW/8Q8lwbjFtJ1F
        E6/hzQI/HZE44ORXqiLQC4w=
X-Google-Smtp-Source: ABdhPJz+N151olWjPyoIS2gBRXCDG88/6dqhn+i91hxLPBKBM+3Ou1nuJDni3azO16H7WQlM53r3GA==
X-Received: by 2002:a62:645:0:b0:3f2:23bd:5fc0 with SMTP id 66-20020a620645000000b003f223bd5fc0mr169108pfg.35.1632335218443;
        Wed, 22 Sep 2021 11:26:58 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:f3b9:da7d:f0c0:c71c])
        by smtp.gmail.com with ESMTPSA id b17sm3470154pgl.61.2021.09.22.11.26.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 11:26:57 -0700 (PDT)
Subject: Re: [PATCH] null_blk: Fix a NULL pointer dereference
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20210922175055.568763-1-bvanassche@acm.org>
 <d8c3e376-145e-f29a-3cf2-210fae4c8884@kernel.dk>
 <fdf80121-35aa-0295-8614-54247fd12686@acm.org>
Message-ID: <ae742deb-df52-9c65-8cb1-3f66dc0bde53@acm.org>
Date:   Wed, 22 Sep 2021 11:26:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <fdf80121-35aa-0295-8614-54247fd12686@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/22/21 11:03 AM, Bart Van Assche wrote:
> On 9/22/21 10:54 AM, Jens Axboe wrote:
>> On 9/22/21 11:50 AM, Bart Van Assche wrote:
>>> Skip queue mapping for shared tag sets. This patch fixes the following bug:
>>>
>>> ==================================================================
>>> BUG: KASAN: null-ptr-deref in null_map_queues+0x131/0x1a0 [null_blk]
>>> Read of size 8 at addr 0000000000000000 by task modprobe/4320
>>>
>>> CPU: 9 PID: 4320 Comm: modprobe Tainted: G         E     5.15.0-rc2-dbg+ #2
>>> Call Trace:
>>>   show_stack+0x52/0x58
>>>   dump_stack_lvl+0x49/0x5e
>>>   kasan_report.cold+0x64/0xdb
>>>   __asan_load8+0x69/0x90
>>>   null_map_queues+0x131/0x1a0 [null_blk]
>>>   blk_mq_update_queue_map+0x122/0x1a0
>>>   blk_mq_alloc_tag_set+0x1e8/0x570
>>>   null_init_tag_set+0x197/0x220 [null_blk]
>>>   null_init+0x1dc/0x1000 [null_blk]
>>>   do_one_initcall+0xc7/0x440
>>>   do_init_module+0x10a/0x3d0
>>>   load_module+0x115c/0x1220
>>>   __do_sys_finit_module+0x124/0x1a0
>>>   __x64_sys_finit_module+0x42/0x50
>>>   do_syscall_64+0x35/0xb0
>>>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>>
>> Thanks Bart, do you mind if I fold this one in? I can add a Fixes-by tag
>> as well.
> 
> That sounds good to me. In case this patch would be retained: the word "Skip"
> in the description should be changed into "Fix".

Unfortunately my patch is not good enough. I run into other crashes with this
patch applied since with this patch some hwctx pointers may be NULL:

     BUG: KASAN: null-ptr-deref in blk_mq_free_rqs+0x1f4/0x380
     Read of size 8 at addr 0000000000000090 by task modprobe/5085
     CPU: 19 PID: 5085 Comm: modprobe Tainted: G            E     5.15.0-rc1-dbg+ #7
     Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
     Call Trace:
      show_stack+0x52/0x58
      dump_stack_lvl+0x38/0x49
      kasan_report.cold+0x64/0xdb
      __asan_load8+0x69/0x90
      blk_mq_free_rqs+0x1f4/0x380
      blk_mq_sched_free_requests+0x98/0xc0
      blk_cleanup_queue+0xe6/0x110
      blk_cleanup_disk+0x1f/0x40
      null_del_dev.part.0+0xdf/0x2b0 [null_blk]
      null_exit+0x65/0xb4 [null_blk]
      __do_sys_delete_module.constprop.0+0x1dd/0x2e0
      __x64_sys_delete_module+0x1f/0x30
      do_syscall_64+0x35/0xb0
      entry_SYSCALL_64_after_hwframe+0x44/0xae

Bart.
