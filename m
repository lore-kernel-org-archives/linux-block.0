Return-Path: <SRS0=XMJ3=U3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065D4C4321A
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 13:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E07208E3
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 13:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wun9D4eS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfF1NpE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jun 2019 09:45:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33285 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfF1NpE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jun 2019 09:45:04 -0400
Received: by mail-pg1-f194.google.com with SMTP id m4so2629235pgk.0
        for <linux-block@vger.kernel.org>; Fri, 28 Jun 2019 06:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XbPOuTGysikAITXS24kr0Gn9yAEvZ2nHVWbh4wIZuOc=;
        b=wun9D4eSGb7Iasfxj7gOKN1Y0eX5kR7Hq96Od97Cj9YnvQj+gRosUVQ3Ku4oYt8GMr
         NZIICpU4ObsOI8c6++GhMXsW7gzO8At+tcAJG4AG7ytOr5Ef6rUHHdiJTEPkzy4Ktv5H
         jK8aFmYkwB4ApRZOiRFPMSxJ5mCuIXztFDi0nEszzyXT/O/W1s3uv9V078Xa1BdNg8mT
         DaFCkd+ax8PvpUqd++C047JITLuIt/3UvCwoecCQC9c4ZUySfat7tay4qCnkcLkXOmmX
         /Lp6gygEr6nipTARPNddbs84Gh5zDPj6CKQR6IrgjK5hUdoPOaDdSnfXCZV4K0TCpQDZ
         ELWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XbPOuTGysikAITXS24kr0Gn9yAEvZ2nHVWbh4wIZuOc=;
        b=UjZq/7sAl5nV0I5c+ZtrfMkVwgbTB1g+qIoN5GFgp7uNWFLQM0O/iQ5ThNby4cfZb0
         KQ9H2WW+Wiy/a7m1JK+vTiUOWFTWuqoGuzmjntda9F+BB+oUAWklZ2YGxzzbrKPZIAUL
         RPlVorj5b8O9V1NSVCH5L9LALjvnIl3LI41YuybFQuLfGxfcydGpXLKZQvk1NjKfYX/X
         N01hKX7uP/eOcmAXzM4hT92bn3VlTvyyXRm7zDM40l5Gfy3fyhIqVC0W8qawkKcqPtnW
         FnO0a6fVwWeQikaL9tJSrqsqdvyFbBranCAHhOxEiSLHC1B3xEInjMQ9PQedKo31HLDp
         piIA==
X-Gm-Message-State: APjAAAWf3q/tYze2fBCYMWcF21O4jTX3n0Y8lvWYL7Iho3p19qEtJk/T
        gTdpiM2Vp8eK3xP+6wHyD18yVg==
X-Google-Smtp-Source: APXvYqzyFlO9g2fJA/Bw9M9oo/erU+84oIwDj5JrmbJWEGYU6LOw4J/6q9ZW7xquajGG4wt73WVFJg==
X-Received: by 2002:a63:5444:: with SMTP id e4mr8773310pgm.451.1561729503213;
        Fri, 28 Jun 2019 06:45:03 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id u2sm2096104pjv.30.2019.06.28.06.45.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 06:45:01 -0700 (PDT)
Subject: Re: [PATCH] block, bfq: NULL out the bic when it's no longer valid
To:     Douglas Anderson <dianders@chromium.org>,
        Paolo Valente <paolo.valente@linaro.org>
Cc:     groeck@chromium.org, drinkcat@chromium.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190628044409.128823-1-dianders@chromium.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9048aa45-ecf3-c80d-a973-4aeb86adde23@kernel.dk>
Date:   Fri, 28 Jun 2019 07:45:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190628044409.128823-1-dianders@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/27/19 10:44 PM, Douglas Anderson wrote:
> In reboot tests on several devices we were seeing a "use after free"
> when slub_debug or KASAN was enabled.  The kernel complained about:
> 
>    Unable to handle kernel paging request at virtual address 6b6b6c2b
> 
> ...which is a classic sign of use after free under slub_debug.  The
> stack crawl in kgdb looked like:
> 
>   0  test_bit (addr=<optimized out>, nr=<optimized out>)
>   1  bfq_bfqq_busy (bfqq=<optimized out>)
>   2  bfq_select_queue (bfqd=<optimized out>)
>   3  __bfq_dispatch_request (hctx=<optimized out>)
>   4  bfq_dispatch_request (hctx=<optimized out>)
>   5  0xc056ef00 in blk_mq_do_dispatch_sched (hctx=0xed249440)
>   6  0xc056f728 in blk_mq_sched_dispatch_requests (hctx=0xed249440)
>   7  0xc0568d24 in __blk_mq_run_hw_queue (hctx=0xed249440)
>   8  0xc0568d94 in blk_mq_run_work_fn (work=<optimized out>)
>   9  0xc024c5c4 in process_one_work (worker=0xec6d4640, work=0xed249480)
>   10 0xc024cff4 in worker_thread (__worker=0xec6d4640)
> 
> Digging in kgdb, it could be found that, though bfqq looked fine,
> bfqq->bic had been freed.
> 
> Through further digging, I postulated that perhaps it is illegal to
> access a "bic" (AKA an "icq") after bfq_exit_icq() had been called
> because the "bic" can be freed at some point in time after this call
> is made.  I confirmed that there certainly were cases where the exact
> crashing code path would access the "bic" after bfq_exit_icq() had
> been called.  Sspecifically I set the "bfqq->bic" to (void *)0x7 and
> saw that the bic was 0x7 at the time of the crash.
> 
> To understand a bit more about why this crash was fairly uncommon (I
> saw it only once in a few hundred reboots), you can see that much of
> the time bfq_exit_icq_fbqq() fully frees the bfqq and thus it can't
> access the ->bic anymore.  The only case it doesn't is if
> bfq_put_queue() sees a reference still held.
> 
> However, even in the case when bfqq isn't freed, the crash is still
> rare.  Why?  I tracked what happened to the "bic" after the exit
> routine.  It doesn't get freed right away.  Rather,
> put_io_context_active() eventually called put_io_context() which
> queued up freeing on a workqueue.  The freeing then actually happened
> later than that through call_rcu().  Despite all these delays, some
> extra debugging showed that all the hoops could be jumped through in
> time and the memory could be freed causing the original crash.  Phew!
> 
> To make a long story short, assuming it truly is illegal to access an
> icq after the "exit_icq" callback is finished, this patch is needed.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> Most of the testing of this was done on the Chrome OS 4.19 kernel with
> BFQ backported (thanks to Paolo's help).  I did manage to reproduce a
> crash on mainline Linux (v5.2-rc6) though.
> 
> To see some of the techniques used to debug this, see
> <https://crrev.com/c/1679134> and <https://crrev.com/c/1681258/1>.
> 
> I'll also note that on linuxnext (next-20190627) I saw some other
> use-after-frees that seemed related to BFQ but haven't had time to
> debug.  They seemed unrelated.

Applied for 5.3, but I marked it for stable as well.

-- 
Jens Axboe

