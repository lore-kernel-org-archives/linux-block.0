Return-Path: <SRS0=ocaT=2I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBFDC43603
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 01:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D122176D
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 01:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="QMzMOw/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfLRBLC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Dec 2019 20:11:02 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:41635 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfLRBLC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Dec 2019 20:11:02 -0500
Received: by mail-io1-f67.google.com with SMTP id c16so182000ioo.8
        for <linux-block@vger.kernel.org>; Tue, 17 Dec 2019 17:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hldTe2GfzDtz8+/s1U4tZFCHJzt9L6rMIb8ZdEeo92M=;
        b=QMzMOw/a5W4qKEaZp38qSdUZIblniCJNgpp3AaVOVx1nmjoeWlcoGkj0RBnit3hTRq
         2/YRGKQZqNkiIW/hlIR6Ij0CGQ+sMAetS5/yuoLincAvZyf6hGf5V3/RLKdkQLK+J4bb
         nGpXFyxxxrOOReZDXhsECBsNfW2deeSzBC/HEFB/AhSPD3obC2lZ6I/At8hV6r4Q+auw
         JF1vW3L4GHWs2XLailLa1kORTiR4HVYh2rJGuxGwZHsN4h8PU7TtMH31Kn0QpvhSUUXy
         fOU4sWBLoZktFRpY72oSOd0vsDtvNnGAXBk3EBj0mkElXz12Sgtt2zlGYGMegNERUztd
         iDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hldTe2GfzDtz8+/s1U4tZFCHJzt9L6rMIb8ZdEeo92M=;
        b=jVfKBbXYv5ldlNb3UasZEuKprt79wKrBmkxWRAwYuYc0MIm9gi/F9dJrqOkdJeyYa2
         pqpcC0g9WihNzxjfIf3CEnILCVbzxWUpfDs87fNM39i/7j6kpS4xZBhuNqoiCF4E5JFB
         gaywWMJ966MpiWj1+9nfvFtsP1u6J3p9LuHlrfx7PQqztdL4+wyyPE79Wcr4WehL09kq
         4fN5iSFqg+qjwlF0fNAU/KugaJEI91HQl98aKr4Wb5ynk7wdvrxciTFJiDO80AQJyQi0
         ErpUIDko298qvCCzqKWg9KXXsHHFY+qXOf5s0t4MzHGITwYBAfL2/QQbb90uIFJldYGL
         3bWg==
X-Gm-Message-State: APjAAAWEmw41/2iCbL/pMKOVpXzGto0Q1DviCkqcY612awx5ZlgT/1EC
        ruy6jBMpMFk5nBodrbhCpIrGs62Dbvtpag==
X-Google-Smtp-Source: APXvYqx+xFBbxCkQaUDa4Eh+He6nFv0cbdePBIOpVHpBqAMazzaXrBgRoUHX2aTvVYSeoTQA9bGuuw==
X-Received: by 2002:a02:c988:: with SMTP id b8mr27880jap.122.1576631461364;
        Tue, 17 Dec 2019 17:11:01 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r7sm113362ioo.7.2019.12.17.17.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 17:11:00 -0800 (PST)
Subject: Re: [PATCH] block: Fix a lockdep complaint triggered by request queue
 flushing
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>
References: <20191218002435.48863-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a4483a73-54c6-896d-dfb2-77118bb858cc@kernel.dk>
Date:   Tue, 17 Dec 2019 18:10:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191218002435.48863-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/17/19 5:24 PM, Bart Van Assche wrote:
> Avoid that running test nvme/012 from the blktests suite triggers the
> following false positive lockdep complaint:
> 
> ============================================
> WARNING: possible recursive locking detected
> 5.0.0-rc3-xfstests-00015-g1236f7d60242 #841 Not tainted
> --------------------------------------------
> ksoftirqd/1/16 is trying to acquire lock:
> 000000000282032e (&(&fq->mq_flush_lock)->rlock){..-.}, at: flush_end_io+0x4e/0x1d0
> 
> but task is already holding lock:
> 00000000cbadcbc2 (&(&fq->mq_flush_lock)->rlock){..-.}, at: flush_end_io+0x4e/0x1d0
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&(&fq->mq_flush_lock)->rlock);
>   lock(&(&fq->mq_flush_lock)->rlock);
> 
>  *** DEADLOCK ***
> 
>  May be due to missing lock nesting notation
> 
> 1 lock held by ksoftirqd/1/16:
>  #0: 00000000cbadcbc2 (&(&fq->mq_flush_lock)->rlock){..-.}, at: flush_end_io+0x4e/0x1d0
> 
> stack backtrace:
> CPU: 1 PID: 16 Comm: ksoftirqd/1 Not tainted 5.0.0-rc3-xfstests-00015-g1236f7d60242 #841
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  dump_stack+0x67/0x90
>  __lock_acquire.cold.45+0x2b4/0x313
>  lock_acquire+0x98/0x160
>  _raw_spin_lock_irqsave+0x3b/0x80
>  flush_end_io+0x4e/0x1d0
>  blk_mq_complete_request+0x76/0x110
>  nvmet_req_complete+0x15/0x110 [nvmet]
>  nvmet_bio_done+0x27/0x50 [nvmet]
>  blk_update_request+0xd7/0x2d0
>  blk_mq_end_request+0x1a/0x100
>  blk_flush_complete_seq+0xe5/0x350
>  flush_end_io+0x12f/0x1d0
>  blk_done_softirq+0x9f/0xd0
>  __do_softirq+0xca/0x440
>  run_ksoftirqd+0x24/0x50
>  smpboot_thread_fn+0x113/0x1e0
>  kthread+0x121/0x140
>  ret_from_fork+0x3a/0x50

Applied, thanks.

-- 
Jens Axboe

