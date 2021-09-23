Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67C1C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 19:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1B086124C
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 19:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237009AbhIWTRn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Sep 2021 15:17:43 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:39597 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242930AbhIWTRg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Sep 2021 15:17:36 -0400
Received: by mail-pf1-f182.google.com with SMTP id g2so2521200pfc.6
        for <linux-block@vger.kernel.org>; Thu, 23 Sep 2021 12:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o4CI5bfU/1Xk1/EZ8YQdTs3J89md9iM2+sZPSkqAmWw=;
        b=66gOLCW5O31BXwR2aPdzZbOfs98T4e03BPCckVjLWsXQPtKLvotieQrH+b5gt7L42S
         fXDA6XD8/s+KAWgE86AxTFwU4xvabA9LbQTnyZwCxpQc/9YmyU3VOrv2hgGo9/0VXp/z
         tTO1XZ8QTvDiuNNIaBBU03RslSiu0ou35m013ABchSSRZAf/wGeiUw48nlpbwNfHYdiW
         cvzYej6S9GWCsprBsM+cAGHNPHNze+fGFpYxYquGePA6mmZPbIjXdfwH7EX2ax1Fclph
         RL1FJZoK7W4ndmzkn4Wp+hptsQFNBMBKjCPUvMr+QgDcsnfrMrNjJqQSV5abbh9a+noX
         QSfA==
X-Gm-Message-State: AOAM533IKTm0HHcnKnZTyiu4iWoIirywQb0fwBba62DQshU4uXwUqb5l
        M3zYfh6uDHpcuMMk8yHzSv8=
X-Google-Smtp-Source: ABdhPJxtsrSKXFtUdm+b/cuA6GJkDxVkchvLI/Kbud9in1CnrknOnLknWen1qvC9UbtP3fHRMRoiRA==
X-Received: by 2002:a63:dd51:: with SMTP id g17mr275803pgj.47.1632424563707;
        Thu, 23 Sep 2021 12:16:03 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3c28:de2e:5efb:9f34])
        by smtp.gmail.com with ESMTPSA id g12sm7478098pgp.78.2021.09.23.12.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 12:16:03 -0700 (PDT)
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
 <83d45e6b-6bd5-8e59-d0bf-6d86b18a81f4@acm.org>
 <fc3299cf-1603-fcd9-6287-1424586cb479@kernel.dk>
 <043399af-0e2e-6f9a-8422-015c8840907c@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <5bd1b4d6-ae4b-cf5b-a8ce-92bf6d273f85@acm.org>
Date:   Thu, 23 Sep 2021 12:16:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <043399af-0e2e-6f9a-8422-015c8840907c@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/23/21 11:53 AM, Jens Axboe wrote:
> I think it's the assumption that poll_queueus == submit_queues. Does this
> work for you?
> 
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index eb5cfe189e90..dac88c5daff9 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1748,7 +1757,7 @@ static int setup_queues(struct nullb *nullb)
>   	int nqueues = nr_cpu_ids;
>   
>   	if (g_poll_queues)
> -		nqueues *= 2;
> +		nqueues += g_poll_queues;
>   
>   	nullb->queues = kcalloc(nqueues, sizeof(struct nullb_queue),
>   				GFP_KERNEL);
> @@ -1814,7 +1823,7 @@ static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set *set)
>   						g_submit_queues;
>   	poll_queues = nullb ? nullb->dev->poll_queues : g_poll_queues;
>   	if (poll_queues)
> -		set->nr_hw_queues *= 2;
> +		set->nr_hw_queues += poll_queues;
>   	set->queue_depth = nullb ? nullb->dev->hw_queue_depth :
>   						g_hw_queue_depth;
>   	set->numa_node = nullb ? nullb->dev->home_node : g_home_node;

Hi Jens,

That patch makes test block/020 pass but unfortunately is not sufficient to
make test block/029 pass. This is what is triggered by test block/029:

null_blk: module loaded
==================================================================
BUG: KASAN: null-ptr-deref in blk_mq_map_swqueue+0x2d2/0x820
Read of size 8 at addr 0000000000000128 by task check/6065

CPU: 11 PID: 6065 Comm: check Tainted: G            E     5.15.0-rc1-dbg+ #1
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
  show_stack+0x52/0x58
  dump_stack_lvl+0x49/0x5e
  kasan_report.cold+0x64/0xdb
  kasan_check_range+0x14f/0x1a0
  __kasan_check_read+0x11/0x20
  blk_mq_map_swqueue+0x2d2/0x820
  __blk_mq_update_nr_hw_queues+0x358/0x670
  blk_mq_update_nr_hw_queues+0x31/0x50
  nullb_device_submit_queues_store+0xc1/0x130 [null_blk]
  configfs_write_iter+0x18b/0x220
  new_sync_write+0x287/0x390
  vfs_write+0x442/0x590
  ksys_write+0xbd/0x150
  __x64_sys_write+0x42/0x50
  do_syscall_64+0x35/0xb0
  entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7ff43deb0367
Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
RSP: 002b:00007ffcabaa5df8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007ff43deb0367
RDX: 0000000000000002 RSI: 000055c2e105a510 RDI: 0000000000000001
RBP: 000055c2e105a510 R08: 000000000000000a R09: 00007ff43df464e0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007ff43df83520 R14: 0000000000000002 R15: 00007ff43df83700
==================================================================



