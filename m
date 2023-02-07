Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C521BC636CC
	for <linux-block@archiver.kernel.org>; Tue,  7 Feb 2023 18:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjBGScJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Feb 2023 13:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbjBGScF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Feb 2023 13:32:05 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54692A5CE
        for <linux-block@vger.kernel.org>; Tue,  7 Feb 2023 10:31:50 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id l7so6007147ioa.7
        for <linux-block@vger.kernel.org>; Tue, 07 Feb 2023 10:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rjbym9T42skdhF3uprIyztEKnRUBwwO5JRXMfWu4kCE=;
        b=gDm3Jh36GzECUYz3DEmO/uU/d8Fzj76lmFWCFJIhZkfWVYtqk3zemDDW2K3Um4VvGY
         x4O/btY5sPmlw/V3dG/yuRMq7PkBrGCcxSKE8OifIbdnEkYGgJEKswnn3EF6Lu8dGsqr
         aA7mrG00AmuC3emnhKTeS0ufeWqKKD36fzBmfSxtwU9LWoPr9xuXezWSOSs+IgfcJESN
         jEIdYUiXU54YElX1VgP34784cGElVrrgVG3sKttM8qvz8JosIuD7Zfi/fHK92axOD167
         /SMPWJc8NfWiOU1txcdKHOQ2f+8jXaTpW6JSSE7ojbiB3BkkfukNRrUIQLYZmA4QOBuS
         a+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rjbym9T42skdhF3uprIyztEKnRUBwwO5JRXMfWu4kCE=;
        b=Mx/Wk6BxQJyt36G1CY5mFKa3l+62KuiQ5i44UNveTUgL6nhqCTwePC77N8RxMZfJLZ
         87CqughJFbQlNtdbzGZiyg8JDC982t/rb0duB2VsAXhwBA5sM4SecJ3twjFQ2aCrnYWH
         VHJmTDiqlywCG1QB21wiIAufvZeh3rAfeoLs7AC2BOhCGV1hdpVz2SbawJBTlzfKSUx0
         v+gijDqouNFo5sRRME12/rNe0D+Sl3Vl33HFEN1zO7aJbwF2N9Armk5trjZfAPX7xrK3
         ociBsP5MrnIuIrHK5coy5FjoQ4Tqy3XeyQ4en5k53FVojL8z6k8msF2wuvwLyQzjJ661
         0IYA==
X-Gm-Message-State: AO0yUKXN3en+2dHrI9DyRK6UdVp4y+bND7WDQdgHBsmA6UliqgdJIM0z
        0261viNtuKT/kKWal6udj1mKTw==
X-Google-Smtp-Source: AK7set+kKa8MSqpN9ip1YSu+ZSBe0pk67J4DGBXcnAdqH79MN97IWjNReIVmgvraOjNw+qoFnzIuhg==
X-Received: by 2002:a6b:ed05:0:b0:716:8f6a:f480 with SMTP id n5-20020a6bed05000000b007168f6af480mr3494848iog.0.1675794709421;
        Tue, 07 Feb 2023 10:31:49 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id o184-20020a6bbec1000000b006e02c489089sm4148604iof.32.2023.02.07.10.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 10:31:48 -0800 (PST)
Message-ID: <4321724d-9a24-926c-5d2d-5d5d902bda72@kernel.dk>
Date:   Tue, 7 Feb 2023 11:31:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: block: sleeping in atomic warnings
Content-Language: en-US
To:     Dan Carpenter <error27@gmail.com>, linux-block@vger.kernel.org
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maobibo <maobibo@loongson.cn>,
        Matthew Wilcox <willy@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
References: <20230129060452.7380-1-zhanghongchen@loongson.cn>
 <CAHk-=wjw-rrT59k6VdeLu4qUarQOzicsZPFGAO5J8TKM=oukUw@mail.gmail.com>
 <Y+EjmnRqpLuBFPX1@bombadil.infradead.org>
 <4ffbb0c8-c5d0-73b3-7a4e-2da9a7b03669@inria.fr> <Y+Ja5SRs886CEz7a@kadam>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y+Ja5SRs886CEz7a@kadam>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/7/23 7:06?AM, Dan Carpenter wrote:
> block/blk-mq.c:206 blk_freeze_queue() warn: sleeping in atomic context
> rexmit_timer() <- disables preempt
> -> aoedev_downdev()
>    -> blk_mq_freeze_queue()
>       -> blk_freeze_queue()

That is definitely a legit bug, aoe should punt to a workqueue or
similar.

> block/blk-mq.c:4083 blk_mq_destroy_queue() warn: sleeping in atomic context
> nvme_fc_match_disconn_ls() <- disables preempt
> -> nvme_fc_ctrl_put()
>    -> nvme_fc_ctrl_free()
>       -> nvme_remove_admin_tag_set()
> nvme_fc_ctrl_free() <duplicate>
> -> nvme_remove_io_tag_set()
>          -> blk_mq_destroy_queue()

Also looks like a legitimate bug.

> block/blk-mq.c:2174 __blk_mq_run_hw_queue() warn: sleeping in atomic context
> __blk_mq_run_hw_queue() <duplicate>
> -> blk_mq_sched_dispatch_requests()
>    -> __blk_mq_sched_dispatch_requests()
>       -> blk_mq_do_dispatch_sched()
> blk_mq_do_dispatch_sched() <duplicate>
> -> __blk_mq_do_dispatch_sched()
>    -> blk_mq_dispatch_hctx_list()
> __blk_mq_do_dispatch_sched() <duplicate>
> __blk_mq_sched_dispatch_requests() <duplicate>
> -> blk_mq_do_dispatch_ctx()
> __blk_mq_sched_dispatch_requests() <duplicate>
>       -> blk_mq_dispatch_rq_list()
> __blk_mq_do_dispatch_sched() <duplicate>
> blk_mq_do_dispatch_ctx() <duplicate>
> -> blk_mq_delay_run_hw_queues()
>          -> blk_mq_delay_run_hw_queue()

This one I'm not really following... Would it be possible to expand the
reporting to be a bit more verbose?

> sg_remove_sfp_usercontext() <- disables preempt
> block/blk-wbt.c:843 wbt_init() warn: sleeping in atomic context
> ioc_qos_write() <- disables preempt
> -> wbt_enable_default()
>    -> wbt_init()

Also definitely a bug.

-- 
Jens Axboe

