Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91659C43470
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 18:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 626C96112E
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 18:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbhDASDN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Apr 2021 14:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236288AbhDAR5l (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Apr 2021 13:57:41 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0AAC05BD33
        for <linux-block@vger.kernel.org>; Thu,  1 Apr 2021 06:04:09 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id f17so1014347plr.0
        for <linux-block@vger.kernel.org>; Thu, 01 Apr 2021 06:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=02h3yuYtCDeLrFtLERehN2koHoxziGpmS6QEtH714RU=;
        b=c9P77fxGGLlXuO1I1cSLHtXkwUM5dXul4sy1noUL2RhzIQsqc7bVRe1jjr9Pr0d0qK
         IQWIHcwWqSgEojqw4knzoSr5J4j0QqbAwc39gN5bowgOP1OiMT+OxMJZITVsvK7QBgoa
         t3LTysUxug2yRB8IQ9fS+QAX2IGqJtk7yUHR5mZEt9PHZjQKUUX4Q8mf/6grd03NGNFH
         QU6jT2ZEKbU26yqSdlNLzpn0Q6143V0khY12A7pLWsWFS/C1DiS2HbThguKM56Nzaw/K
         15vrqRqwtQM0+cvg6ME70S9ZSlDUTCM51yb2ASu4oB57bRQrxlYSM5dlMXUNvSHq3RcU
         G7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=02h3yuYtCDeLrFtLERehN2koHoxziGpmS6QEtH714RU=;
        b=KyirKLh8dPkxmjb0ZOz+jDxjy2KOQuj74a15vLJ9YnQGOy+b0n4UQsYI9xpdCeNkzn
         PVL5EQHh5Qk5a9BF10/9pHQAWLLe6+LB+Kt0IZS8Whpe2j4MQqn+H5SfLX9w/CmpMZ0B
         raG5QmpcXFn1Flox0lY8/yBT230BN4Kj0cpqz8qX5ZXZvs1ziKebZXBwMs+xFEaEKlok
         m65Noo/Eu9g8zqL5MaGF1eestsYf41mQzVhHvtN1W+pTrfwmUakRbwsEjDleqYNVnxkR
         pmPIgtKAw7IH/bCuLfgukJYSP7g6lDjuWAO0f1blvb14gO47fYFuu/UqJ8wmZKu2Zonr
         6aDg==
X-Gm-Message-State: AOAM532wYQ0VJyk+c+giTsCHwagabm5CvS5wyI4RGM5VZwHROMGKKswy
        k9oswCZzI+LaTO4zNb97MZuBiGdHYsMLWQ==
X-Google-Smtp-Source: ABdhPJzLwMrkCL7oi6nmY9pT+fmHMLiQPQFmeMGnz3yBvJ/Z7O05ATkXWC22XrJ4P3VCb1QTVVS8rg==
X-Received: by 2002:a17:902:c389:b029:e7:1029:8ba5 with SMTP id g9-20020a170902c389b02900e710298ba5mr7894337plg.55.1617282248993;
        Thu, 01 Apr 2021 06:04:08 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id y15sm6942053pgi.31.2021.04.01.06.04.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 06:04:07 -0700 (PDT)
Subject: Re: [PATCH] null_blk: fix command timeout completion handling
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20210331225244.126426-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5993cd68-2e5a-af12-ed22-a2602c8ad6c3@kernel.dk>
Date:   Thu, 1 Apr 2021 07:04:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210331225244.126426-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/31/21 4:52 PM, Damien Le Moal wrote:
> Memory backed or zoned null block devices may generate actual request
> timeout errors due to the submission path being blocked on memory
> allocation or zone locking. Unlike fake timeouts or injected timeouts,
> the request submission path will call blk_mq_complete_request() or
> blk_mq_end_request() for these real timeout errors, causing a double
> completion and use after free situation as the block layer timeout
> handler executes blk_mq_rq_timed_out() and __blk_mq_free_request() in
> blk_mq_check_expired(). This problem often triggers a NULL pointer
> dereference such as:
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000050
> RIP: 0010:blk_mq_sched_mark_restart_hctx+0x5/0x20
> ...
> Call Trace:
>   dd_finish_request+0x56/0x80
>   blk_mq_free_request+0x37/0x130
>   null_handle_cmd+0xbf/0x250 [null_blk]
>   ? null_queue_rq+0x67/0xd0 [null_blk]
>   blk_mq_dispatch_rq_list+0x122/0x850
>   __blk_mq_do_dispatch_sched+0xbb/0x2c0
>   __blk_mq_sched_dispatch_requests+0x13d/0x190
>   blk_mq_sched_dispatch_requests+0x30/0x60
>   __blk_mq_run_hw_queue+0x49/0x90
>   process_one_work+0x26c/0x580
>   worker_thread+0x55/0x3c0
>   ? process_one_work+0x580/0x580
>   kthread+0x134/0x150
>   ? kthread_create_worker_on_cpu+0x70/0x70
>   ret_from_fork+0x1f/0x30
> 
> This problem very often triggers when running the full btrfs xfstests
> on a memory-backed zoned null block device in a VM with limited amount
> of memory.
> 
> Avoid this by executing blk_mq_complete_request() in null_timeout_rq()
> only for commands that are marked for a fake timeout completion using
> the fake_timeout boolean in struct null_cmd. For timeout errors injected
> through debugfs, the timeout handler will execute
> blk_mq_complete_request()i as before. This is safe as the submission
> path does not execute complete requests in this case.
> 
> In null_timeout_rq(), also make sure to set the command error field to
> BLK_STS_TIMEOUT and to propagate this error through to the request
> completion.

Applied, thanks.

-- 
Jens Axboe

