Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF72C433F5
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 17:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BEE26115A
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 17:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236840AbhIVR4N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Sep 2021 13:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbhIVR4N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Sep 2021 13:56:13 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C963C061574
        for <linux-block@vger.kernel.org>; Wed, 22 Sep 2021 10:54:43 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id m26so3391078pff.3
        for <linux-block@vger.kernel.org>; Wed, 22 Sep 2021 10:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aDZ+9EodvDXcNqCR6GCy6BhCh9+FQMsDMk75DTM71yk=;
        b=Zo7sgaWbqIXn3PGZBcmvvvliN89wk6PfmZxxP+BUk6wIKqCjilU8a6CoWYj+FuA2M+
         bt+sw43/c6ycXb/FiYJlJJw5orLNIjKsG+GEHFNPlwDGMAubKHuSbvLTQHgoZ5STi6DP
         uqXjjAEIcX648Q0u4Qcp8XJtewLt03cr0I6hEiUO9gjAVOwCraoh0v4kPUNK8HBvfpKM
         4//MWeJH5Qc0lBYT8n3uDImjrhn1RTzzMFRKitBBRZ7aI0bBSk0/slxKQfifSIDEWbGR
         5W8sDoiGXCN0k0BApBB3LTgb/baq4g+u23tud9xrVYhO0TjgeTuP4yK6rZooYyGut116
         jxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aDZ+9EodvDXcNqCR6GCy6BhCh9+FQMsDMk75DTM71yk=;
        b=31wOpowMOvbTNHHBMteyymas22tkH3ze4qdjmOthXv0/SPp1gtrAp1uibScjHcZWD7
         k+oe5eROa15Mm7mjOVxGdO7pZBND1Il+RmHsKjJrfTP5hl2gX8CLEVG+GTFVlvyqc5MP
         QJK/NuV306aWZ34nhIa2+G0QIVPOb11UQ/NH0/ZctTJ1vYPPTqU0KmWR5nSFkCzt38qV
         f28noqtfXxJYo4CbyoG/129duoOqCGBcLy7cVKgFGD/5XHlVlLuGrLy36jR/kDFhk8ym
         aqeldXXKi0XA3GdJbrd+R9LoMq8ONXZuerrAb6ruxII7jwwuHZhxrgl7IyJ5UIg3OFxP
         VBzQ==
X-Gm-Message-State: AOAM531QG/LbaxtDKKPtKbt2i+MquzOemvdfje3B1YHqo0ALISyvhraM
        QGibhp0SZfNhmLvdTTAEYtOODZSiD/xx+w==
X-Google-Smtp-Source: ABdhPJxXOysym/qxf/8pSWRwf6gL4VEatLH6wqGkxMDOfv8DFZTZmLfiNguvgPV/TfRe9IeVUeDW1Q==
X-Received: by 2002:a65:434c:: with SMTP id k12mr146687pgq.17.1632333282477;
        Wed, 22 Sep 2021 10:54:42 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21cf::1527? ([2620:10d:c090:400::5:95a7])
        by smtp.gmail.com with ESMTPSA id b129sm2989951pfg.157.2021.09.22.10.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 10:54:41 -0700 (PDT)
Subject: Re: [PATCH] null_blk: Fix a NULL pointer dereference
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20210922175055.568763-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d8c3e376-145e-f29a-3cf2-210fae4c8884@kernel.dk>
Date:   Wed, 22 Sep 2021 11:54:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210922175055.568763-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/22/21 11:50 AM, Bart Van Assche wrote:
> Skip queue mapping for shared tag sets. This patch fixes the following bug:
> 
> ==================================================================
> BUG: KASAN: null-ptr-deref in null_map_queues+0x131/0x1a0 [null_blk]
> Read of size 8 at addr 0000000000000000 by task modprobe/4320
> 
> CPU: 9 PID: 4320 Comm: modprobe Tainted: G         E     5.15.0-rc2-dbg+ #2
> Call Trace:
>  show_stack+0x52/0x58
>  dump_stack_lvl+0x49/0x5e
>  kasan_report.cold+0x64/0xdb
>  __asan_load8+0x69/0x90
>  null_map_queues+0x131/0x1a0 [null_blk]
>  blk_mq_update_queue_map+0x122/0x1a0
>  blk_mq_alloc_tag_set+0x1e8/0x570
>  null_init_tag_set+0x197/0x220 [null_blk]
>  null_init+0x1dc/0x1000 [null_blk]
>  do_one_initcall+0xc7/0x440
>  do_init_module+0x10a/0x3d0
>  load_module+0x115c/0x1220
>  __do_sys_finit_module+0x124/0x1a0
>  __x64_sys_finit_module+0x42/0x50
>  do_syscall_64+0x35/0xb0
>  entry_SYSCALL_64_after_hwframe+0x44/0xae

Thanks Bart, do you mind if I fold this one in? I can add a Fixes-by tag
as well.

-- 
Jens Axboe

