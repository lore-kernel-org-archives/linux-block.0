Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0E4C433F5
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 16:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 234FC6103C
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 16:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242441AbhIWQGN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Sep 2021 12:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242442AbhIWQGK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Sep 2021 12:06:10 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A86EC06175F
        for <linux-block@vger.kernel.org>; Thu, 23 Sep 2021 09:04:38 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id x2so7204761ilm.2
        for <linux-block@vger.kernel.org>; Thu, 23 Sep 2021 09:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5yiXIWxI52joVczOlKsnY44XoDbDEXILWEcgMNYD+po=;
        b=Ab2LeCbDwCfOEkaNGxK7LLNIpAYdNccmRMjoPmtKU0CtsZ1+04J6Uyd88FtaUIXLWx
         sh/+N4aKUpSxHK0g3m/tDd2bP1D2YUsWSPRkYYK5lg2wFDrPv9dAQpTD4ceUZ4j9qTWA
         xyeGM9oz9gGgp73ST7WimRFQiroMSG3f7cMw1ndZyU8qMMRsWWSrb0WlG95OD/g44tOk
         uh/S0Q2MU1Nt7fcTsz+Rc023/A00Y7Bn5udjzc4LudpaSEA+ied3HlABBeCdH8XD/gO5
         MRIZI9UoSmRyXFWfoUHXv1/REei82ozlQ6DPDS6JFC8FI1UPozf4qirGHzxthinaGchg
         BIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5yiXIWxI52joVczOlKsnY44XoDbDEXILWEcgMNYD+po=;
        b=G5B8DPV9R3V1j0EhcvAZsWQ1pq0bCVS8M69kiMir0wnRyl99G3MMFx4zD/BCuiRHV6
         OWNFnMuhJhEVP/pLomKh5ncyuGSVU5F1UcFGcZednjz7o1+zZh1DkQDZ90/El2yf7kGU
         UQtyrDhFZkF4EpBaoH3IeW3IOLsbbfTgW6fIHJB6mayshZTABwgslxGNbiAlGtp18Y+2
         UyxQ/RfMal2FlwrPKUx9+BuTWigvPKiHUkxpq8SDdk8thCVyl2ttY6oyxswINX/yPZBV
         aoYIBg4kNgFf6CTckGijBqLk+ADsfWI/VtFdEeRS4Ikil7HHxi55IKJq/quOaa75Ku1m
         ueiA==
X-Gm-Message-State: AOAM530pz09h76yb4fJmrgXPjL5y8s57ALIm3nw/hjZLA81AOv4BojUM
        we/8lQXpWCQtmu34A/IyiD3A0g==
X-Google-Smtp-Source: ABdhPJzDS04L6FWfLIt52YFCPhcn0AfoEo2EHVzup6xq1kDAwR7q9tkk34xfefjJRHjcpO3v0PsSLw==
X-Received: by 2002:a05:6e02:1caa:: with SMTP id x10mr4190592ill.280.1632413077866;
        Thu, 23 Sep 2021 09:04:37 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id r13sm2879766ilh.80.2021.09.23.09.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 09:04:37 -0700 (PDT)
Subject: Re: [PATCH] null_blk: Fix a NULL pointer dereference
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20210922175055.568763-1-bvanassche@acm.org>
 <d8c3e376-145e-f29a-3cf2-210fae4c8884@kernel.dk>
 <fdf80121-35aa-0295-8614-54247fd12686@acm.org>
 <ae742deb-df52-9c65-8cb1-3f66dc0bde53@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4c26ddaf-1b25-7a53-6e6b-09b59ada1a99@kernel.dk>
Date:   Thu, 23 Sep 2021 10:04:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ae742deb-df52-9c65-8cb1-3f66dc0bde53@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/22/21 12:26 PM, Bart Van Assche wrote:
> On 9/22/21 11:03 AM, Bart Van Assche wrote:
>> On 9/22/21 10:54 AM, Jens Axboe wrote:
>>> On 9/22/21 11:50 AM, Bart Van Assche wrote:
>>>> Skip queue mapping for shared tag sets. This patch fixes the following bug:
>>>>
>>>> ==================================================================
>>>> BUG: KASAN: null-ptr-deref in null_map_queues+0x131/0x1a0 [null_blk]
>>>> Read of size 8 at addr 0000000000000000 by task modprobe/4320
>>>>
>>>> CPU: 9 PID: 4320 Comm: modprobe Tainted: G         E     5.15.0-rc2-dbg+ #2
>>>> Call Trace:
>>>>   show_stack+0x52/0x58
>>>>   dump_stack_lvl+0x49/0x5e
>>>>   kasan_report.cold+0x64/0xdb
>>>>   __asan_load8+0x69/0x90
>>>>   null_map_queues+0x131/0x1a0 [null_blk]
>>>>   blk_mq_update_queue_map+0x122/0x1a0
>>>>   blk_mq_alloc_tag_set+0x1e8/0x570
>>>>   null_init_tag_set+0x197/0x220 [null_blk]
>>>>   null_init+0x1dc/0x1000 [null_blk]
>>>>   do_one_initcall+0xc7/0x440
>>>>   do_init_module+0x10a/0x3d0
>>>>   load_module+0x115c/0x1220
>>>>   __do_sys_finit_module+0x124/0x1a0
>>>>   __x64_sys_finit_module+0x42/0x50
>>>>   do_syscall_64+0x35/0xb0
>>>>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>
>>> Thanks Bart, do you mind if I fold this one in? I can add a Fixes-by tag
>>> as well.
>>
>> That sounds good to me. In case this patch would be retained: the word "Skip"
>> in the description should be changed into "Fix".
> 
> Unfortunately my patch is not good enough. I run into other crashes with this
> patch applied since with this patch some hwctx pointers may be NULL:
> 
>      BUG: KASAN: null-ptr-deref in blk_mq_free_rqs+0x1f4/0x380
>      Read of size 8 at addr 0000000000000090 by task modprobe/5085
>      CPU: 19 PID: 5085 Comm: modprobe Tainted: G            E     5.15.0-rc1-dbg+ #7
>      Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
>      Call Trace:
>       show_stack+0x52/0x58
>       dump_stack_lvl+0x38/0x49
>       kasan_report.cold+0x64/0xdb
>       __asan_load8+0x69/0x90
>       blk_mq_free_rqs+0x1f4/0x380
>       blk_mq_sched_free_requests+0x98/0xc0
>       blk_cleanup_queue+0xe6/0x110
>       blk_cleanup_disk+0x1f/0x40
>       null_del_dev.part.0+0xdf/0x2b0 [null_blk]
>       null_exit+0x65/0xb4 [null_blk]
>       __do_sys_delete_module.constprop.0+0x1dd/0x2e0
>       __x64_sys_delete_module+0x1f/0x30
>       do_syscall_64+0x35/0xb0
>       entry_SYSCALL_64_after_hwframe+0x44/0xae

What options are you loading null_blk with?

-- 
Jens Axboe

