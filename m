Return-Path: <SRS0=YBZ7=DG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA7CC4727C
	for <linux-block@archiver.kernel.org>; Tue, 29 Sep 2020 14:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2472208B8
	for <linux-block@archiver.kernel.org>; Tue, 29 Sep 2020 14:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="XosY/dpN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgI2OLM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Sep 2020 10:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgI2OLM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Sep 2020 10:11:12 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EE5C061755
        for <linux-block@vger.kernel.org>; Tue, 29 Sep 2020 07:11:11 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id f15so5024580ilj.2
        for <linux-block@vger.kernel.org>; Tue, 29 Sep 2020 07:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aUy8gE4vdjsR21D0XeZwxyprEabtWM9p71pamzJI95M=;
        b=XosY/dpNlZ/fW8pC2AriyYGvZQxkaiHSZHoZGjnbsqqiU2c1oyFITHsLWFnn8hVp7I
         etPImSXCERU53YcxTzGA3wf49c63y8496JL7uELfFtvknxpFwB81jjqxKZkmsTIt/YEC
         RblV4UoOntIFi5E6Re7rP9gbMdNyCYUXLMSgZd6SqAEGOjkujUyN3kH7R88gfPUHxi/A
         RXJLUqsLEQC7Z+M9R6vpEALTNvgfrVELP296lXrB/ULT97P7G9Gm57GTXI0QtXWiBXxa
         ocmUOQAVf+kX68FQS991P9GHzK7SLKzaluRvXonVwYu7IDaraHsUkuzWypId21PdvOzU
         Pt/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aUy8gE4vdjsR21D0XeZwxyprEabtWM9p71pamzJI95M=;
        b=bE3HOBm+ZdtjxKPgLzEICHBk2xPnOQOQOCSjN5jHdNPGkbEF6s+Z024oxuBU2h+qT5
         EGLmSPTpmA8kU8140nJyD5kJ73+De0fDItIb/6cUCzXxmne7SlW38rWmYD4oeSCN4FZk
         xU7/zFUlltaFXQYlYs3qlQIYOEBnK71+XJej/oBc2kkx5c4YhZ0ChbQmFzB1d2PxlVmY
         o5sKdmq5VmJuXMa43a+EbWKnzEeVdDy8atAw7dHrcFwGcBPZ150wMGIqkpKEBkMXKYKm
         +uGVZm/39pQfkQogw2+Ilr3D21eNYkMnGeKKRSYZdYf225ebgy2eK87Xd0opcCfBwPwQ
         iAng==
X-Gm-Message-State: AOAM532ugHI3DX1Fd9QFGAG4hL6K7KSqnwebp9zorDgpdWncG4cRC7Qn
        ydBsdFwrkHmHdgqz+R50P7G1QQ==
X-Google-Smtp-Source: ABdhPJwnQbsTdOWtzBtygQkkiXKw9pV27ZhkDwR7vTdQgw4Sp7Odr1QkdEqjMnk5qa7R+DKFMCpssg==
X-Received: by 2002:a05:6e02:cd3:: with SMTP id c19mr3208690ilj.249.1601388670711;
        Tue, 29 Sep 2020 07:11:10 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f11sm1855524ioj.27.2020.09.29.07.11.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 07:11:10 -0700 (PDT)
Subject: Re: [PATCH] block-mq: fix comments in blk_mq_queue_tag_busy_iter
To:     yangerkun <yangerkun@huawei.com>
Cc:     linux-block@vger.kernel.org, ming.lei@redhat.com, hch@lst.de
References: <20200919035425.3316563-1-yangerkun@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7c825ff9-6005-471b-2750-dcedb6c5c031@kernel.dk>
Date:   Tue, 29 Sep 2020 08:11:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200919035425.3316563-1-yangerkun@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/18/20 9:54 PM, yangerkun wrote:
> 'f5bbbbe4d635 ("blk-mq: sync the update nr_hw_queues with
> blk_mq_queue_tag_busy_iter")' introduce a bug what we may sleep between
> rcu lock. Then '530ca2c9bd69 ("blk-mq: Allow blocking queue tag iter
> callbacks")' fix it by get request_queue's ref. And 'a9a808084d6a ("block:
> Remove the synchronize_rcu() call from __blk_mq_update_nr_hw_queues()")'
> remove the synchronize_rcu in __blk_mq_update_nr_hw_queues. We need
> update the confused comments in blk_mq_queue_tag_busy_iter.

Applied, thanks.

-- 
Jens Axboe

