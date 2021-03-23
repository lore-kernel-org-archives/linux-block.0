Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD0DC433DB
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 16:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5604619BB
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 16:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbhCWQkr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Mar 2021 12:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbhCWQkj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 12:40:39 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEBFC061574
        for <linux-block@vger.kernel.org>; Tue, 23 Mar 2021 09:40:26 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id z9so18701191ilb.4
        for <linux-block@vger.kernel.org>; Tue, 23 Mar 2021 09:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Iw5CPLlTcGucRxEu7vlzfvI+RatbIeTpMhtRqIEzc3g=;
        b=XeWlpbtwG7WfTuQUp7SZmDJSOwsohY1N9qLcBgXcqWgJ+GIwuvfzmv+u2zpdaOzpGN
         H4Huggo0IplQmkVZQ0je4OFfvE3pgy02g2USgkVnDUuSlF89axZfEAJrpqiV5R9kCxen
         5VSPDh3jC9tUJYnnr16CrGyNTd3zE6xKlSipFHStAqrtArxsKmYdRxFBun94Gr1xquHv
         jLyEQCyvm7wutJNqsGwOogtH2Uh5+JzTUNBqDFdO4MtCBRsaVhYld5hFdJAXd0H7ihQB
         6AGFy/hXlN0XSiyxH3fthMMg8PfJoWQvhVZ6kkuGMw1wYg80NAFtYTZr5Ee0TfIy1Nu/
         irhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Iw5CPLlTcGucRxEu7vlzfvI+RatbIeTpMhtRqIEzc3g=;
        b=q6T7tI50DNPNUn3ze1zLQJYr1Iur1o2D/tkUbPXQoEN3qn1WvvYqABQvTGhDcO/F0T
         nfIFCt4gVM57y6+G16RWReh5oyhPxPc23KdQkL9rCDsQ4uOj/YWr8GAxeejA6KDMT2Ur
         IheZeFwbwHPZwXG/0BJUvB8fV5q2/sSmaRQZFPZ+NCJGeFJjRL1+r7P9aRQXS3wKeVbx
         xqMb65ML9Z87A874XlT7EWdq5TtUcRA+Wy5oEvqJrhyez0pfelz1mWwzFjzK7/AUHLUB
         g3idNp83yjnjkHajnw4aVHMlnll+eBfQG1OEwEu87iC1pSeJuEYfMUVNi3lOssajpbav
         sqyg==
X-Gm-Message-State: AOAM530bx04agl5RsYqiU3Xfnv9QW8sqyb1h2T84wOMA9YsMdEl28IEE
        QAOFNcRRrMo7wslG3IE2coMdsTorEDT0ew==
X-Google-Smtp-Source: ABdhPJzCr77dVHWyAc4qjt5c40JPw0/DpGt+ZZ6j6DqfBUTusQj/f9exqT1TWBsUpPlogIl6004RUw==
X-Received: by 2002:a05:6e02:13d4:: with SMTP id v20mr5423377ilj.1.1616517625651;
        Tue, 23 Mar 2021 09:40:25 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d1sm2797866ils.49.2021.03.23.09.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 09:40:23 -0700 (PDT)
Subject: Re: [PATCH v2] block: recalculate segment count for multi-segment
 discards correctly
To:     David Jeffery <djeffery@redhat.com>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20210211143807.GA115624@redhat>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c04bac6b-8375-ba5f-53f4-ee737ad33743@kernel.dk>
Date:   Tue, 23 Mar 2021 10:40:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210211143807.GA115624@redhat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/11/21 7:38 AM, David Jeffery wrote:
> When a stacked block device inserts a request into another block device
> using blk_insert_cloned_request, the request's nr_phys_segments field gets
> recalculated by a call to blk_recalc_rq_segments in
> blk_cloned_rq_check_limits. But blk_recalc_rq_segments does not know how to
> handle multi-segment discards. For disk types which can handle
> multi-segment discards like nvme, this results in discard requests which
> claim a single segment when it should report several, triggering a warning
> in nvme and causing nvme to fail the discard from the invalid state.
> 
>  WARNING: CPU: 5 PID: 191 at drivers/nvme/host/core.c:700 nvme_setup_discard+0x170/0x1e0 [nvme_core]
>  ...
>  nvme_setup_cmd+0x217/0x270 [nvme_core]
>  nvme_loop_queue_rq+0x51/0x1b0 [nvme_loop]
>  __blk_mq_try_issue_directly+0xe7/0x1b0
>  blk_mq_request_issue_directly+0x41/0x70
>  ? blk_account_io_start+0x40/0x50
>  dm_mq_queue_rq+0x200/0x3e0
>  blk_mq_dispatch_rq_list+0x10a/0x7d0
>  ? __sbitmap_queue_get+0x25/0x90
>  ? elv_rb_del+0x1f/0x30
>  ? deadline_remove_request+0x55/0xb0
>  ? dd_dispatch_request+0x181/0x210
>  __blk_mq_do_dispatch_sched+0x144/0x290
>  ? bio_attempt_discard_merge+0x134/0x1f0
>  __blk_mq_sched_dispatch_requests+0x129/0x180
>  blk_mq_sched_dispatch_requests+0x30/0x60
>  __blk_mq_run_hw_queue+0x47/0xe0
>  __blk_mq_delay_run_hw_queue+0x15b/0x170
>  blk_mq_sched_insert_requests+0x68/0xe0
>  blk_mq_flush_plug_list+0xf0/0x170
>  blk_finish_plug+0x36/0x50
>  xlog_cil_committed+0x19f/0x290 [xfs]
>  xlog_cil_process_committed+0x57/0x80 [xfs]
>  xlog_state_do_callback+0x1e0/0x2a0 [xfs]
>  xlog_ioend_work+0x2f/0x80 [xfs]
>  process_one_work+0x1b6/0x350
>  worker_thread+0x53/0x3e0
>  ? process_one_work+0x350/0x350
>  kthread+0x11b/0x140
>  ? __kthread_bind_mask+0x60/0x60
>  ret_from_fork+0x22/0x30
> 
> This patch fixes blk_recalc_rq_segments to be aware of devices which can
> have multi-segment discards. It calculates the correct discard segment
> count by counting the number of bio as each discard bio is considered its
> own segment.

Applied, thanks.

-- 
Jens Axboe

