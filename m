Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7955C433ED
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 14:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74D5861622
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 14:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhEKONm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 May 2021 10:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbhEKONl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 May 2021 10:13:41 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A7EC061574
        for <linux-block@vger.kernel.org>; Tue, 11 May 2021 07:12:34 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id s20so10869241plr.13
        for <linux-block@vger.kernel.org>; Tue, 11 May 2021 07:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W5TZN11LlFietuRaBIKFcXLG6HQD/IpEYHu3Wt+O/eA=;
        b=rzRdmMshL/7b+Dxt2P5RHeqp+R/iuM4XGmlWUVv7CB1YKdyNIdj/OPeoIx1gKOZWUk
         ExrYLCMnJ8v3LcGhGQSB0Dj2vOwhqnWFJqddjR5T/5I9bUX2TkmbBvG1/wAieI/IlVNI
         ZJgEme/Zc54tvw34MV+1EG21wH8P107JlY/wcyOoZ6wk9zOYG+/G4S4zk/BaZf1WTQbc
         uPlg0oBi390rsqsJ7yXe4qsrSh8HBnMApGHDwDKrBvERJJ4UE3gI6H93qVPS3rLgr02T
         QGW+ub1O3qXJo3jpCdEdhglwEQnT4EkqC/kqE9mKTj1CmprmGakBX0qGjpC897E9+bpU
         SnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W5TZN11LlFietuRaBIKFcXLG6HQD/IpEYHu3Wt+O/eA=;
        b=qLzdoRkO1RUJGhwKrdHBtGM963F0Uzi8qzO6q0KlE2yCzerv73f3wW8PMpUI26YuhF
         TEAljYUfXB2skczSZklRqUlQENQmC2vT6NG2TTLgPH2pW6e93uef1bTFII7Cuh8YxSHy
         bH02x2LKy6114LVXJk1y7qI1Z8+kAdL8Yuhs0y8E8Rf3xcJDFCMsnXmLn+gpelxGr+Z3
         w5i27UmzJ/ImvHxHr3yK5/1jatyvhoMHNp6DsWit72vCHbRoko1H90ZWwS9Gx5WP2DH7
         +xSNs2GUgA1MjDxUXxQfvdW56Z2JLAK/anJFKtcfvtB7pPON0SSXpKwRWm9xph2nK9Rj
         Egbw==
X-Gm-Message-State: AOAM530eg30SbcBH4QIgRk6xtLYtNcY/e/Tb7tHFffgeWbaZPJbuTB58
        5dtoF4Jrae2CvsG6hDflUMqE2Q==
X-Google-Smtp-Source: ABdhPJxIFe/KkTAc5RG+UJRKSkUmFakheFx8uKYySEm57qCXajzMB2xdv+Q1B7B2L4vIy3gdyWukCA==
X-Received: by 2002:a17:902:be02:b029:ec:af1f:5337 with SMTP id r2-20020a170902be02b02900ecaf1f5337mr29413669pls.35.1620742353880;
        Tue, 11 May 2021 07:12:33 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id x35sm13563709pfu.209.2021.05.11.07.12.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 07:12:33 -0700 (PDT)
Subject: Re: [PATCH] kyber: fix out of bounds access when preempted
To:     Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
Cc:     kernel-team@fb.com, Jakub Kicinski <kuba@kernel.org>,
        Jianchao Wang <jianchao.w.wang@oracle.com>
References: <c7598605401a48d5cfeadebb678abd10af22b83f.1620691329.git.osandov@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f22b2f93-c6da-fa1e-dc34-ea797caac2f6@kernel.dk>
Date:   Tue, 11 May 2021 08:12:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c7598605401a48d5cfeadebb678abd10af22b83f.1620691329.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/10/21 6:05 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> __blk_mq_sched_bio_merge() gets the ctx and hctx for the current CPU and
> passes the hctx to ->bio_merge(). kyber_bio_merge() then gets the ctx
> for the current CPU again and uses that to get the corresponding Kyber
> context in the passed hctx. However, the thread may be preempted between
> the two calls to blk_mq_get_ctx(), and the ctx returned the second time
> may no longer correspond to the passed hctx. This "works" accidentally
> most of the time, but it can cause us to read garbage if the second ctx
> came from an hctx with more ctx's than the first one (i.e., if
> ctx->index_hw[hctx->type] > hctx->nr_ctx).
> 
> This manifested as this UBSAN array index out of bounds error reported
> by Jakub:
> 
> UBSAN: array-index-out-of-bounds in ../kernel/locking/qspinlock.c:130:9
> index 13106 is out of range for type 'long unsigned int [128]'
> Call Trace:
>  dump_stack+0xa4/0xe5
>  ubsan_epilogue+0x5/0x40
>  __ubsan_handle_out_of_bounds.cold.13+0x2a/0x34
>  queued_spin_lock_slowpath+0x476/0x480
>  do_raw_spin_lock+0x1c2/0x1d0
>  kyber_bio_merge+0x112/0x180
>  blk_mq_submit_bio+0x1f5/0x1100
>  submit_bio_noacct+0x7b0/0x870
>  submit_bio+0xc2/0x3a0
>  btrfs_map_bio+0x4f0/0x9d0
>  btrfs_submit_data_bio+0x24e/0x310
>  submit_one_bio+0x7f/0xb0
>  submit_extent_page+0xc4/0x440
>  __extent_writepage_io+0x2b8/0x5e0
>  __extent_writepage+0x28d/0x6e0
>  extent_write_cache_pages+0x4d7/0x7a0
>  extent_writepages+0xa2/0x110
>  do_writepages+0x8f/0x180
>  __writeback_single_inode+0x99/0x7f0
>  writeback_sb_inodes+0x34e/0x790
>  __writeback_inodes_wb+0x9e/0x120
>  wb_writeback+0x4d2/0x660
>  wb_workfn+0x64d/0xa10
>  process_one_work+0x53a/0xa80
>  worker_thread+0x69/0x5b0
>  kthread+0x20b/0x240
>  ret_from_fork+0x1f/0x30
> 
> Only Kyber uses the hctx, so fix it by passing the request_queue to
> ->bio_merge() instead. BFQ and mq-deadline just use that, and Kyber can
> map the queues itself to avoid the mismatch.

Applied, thanks Omar.

-- 
Jens Axboe

