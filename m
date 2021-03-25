Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFF2C433E0
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 08:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2080A619DC
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 08:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhCYIEX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 04:04:23 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:34846 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbhCYIEF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 04:04:05 -0400
Received: from localhost (kaktus.kanapka.ml [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id C647B9F8952;
        Thu, 25 Mar 2021 09:03:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1616659429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y+CNu6WHVjo3O2a9yzLiBEhOnf++0pR8/mDBhwQbchg=;
        b=oETMIZRxJL1+sdBMVCGoT19fmKwxBB/1fZEbktxqZetMXHItWtsLzAvCAYznfF7DPgY6C3
        urPOfIXHqMsld49GeLeU4QBD4ADD3mdmEylSggbiJUUCqK2qhv4nUDb2oolJqbHnPJnPRZ
        w0t+hP2sb1Qww8Ls3e2wddlAM70vvn4=
Date:   Thu, 25 Mar 2021 09:03:49 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH BUGFIX/IMPROVEMENT V2 0/6] revised version of third and
 last batch of patches
Message-ID: <20210325080349.3sism2hvkoboartp@spock.localdomain>
References: <20210304174627.161-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304174627.161-1-paolo.valente@linaro.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello.

On Thu, Mar 04, 2021 at 06:46:21PM +0100, Paolo Valente wrote:
> Hi,
> this is the V2 for the third and last batches of patches that I
> proposed recently [1].
> 
> I've tried to address all issues raised in [1].
> 
> In more detail, main changes for V1 are:
> 1. I've improved code as requested in "block, bfq: merge bursts of
> newly-created queues"
> 2. I've improved comments as requested in "block, bfq: put reqs of
> waker and woken in dispatch list"
> 
> Thanks,
> Paolo
> 
> [1] https://www.spinics.net/lists/linux-block/msg64333.html
> 
> Paolo Valente (6):
>   block, bfq: always inject I/O of queues blocked by wakers
>   block, bfq: put reqs of waker and woken in dispatch list
>   block, bfq: make shared queues inherit wakers
>   block, bfq: fix weight-raising resume with !low_latency
>   block, bfq: keep shared queues out of the waker mechanism
>   block, bfq: merge bursts of newly-created queues
> 
>  block/bfq-cgroup.c  |   2 +
>  block/bfq-iosched.c | 399 +++++++++++++++++++++++++++++++++++++++++---
>  block/bfq-iosched.h |  15 ++
>  block/bfq-wf2q.c    |   8 +
>  4 files changed, 402 insertions(+), 22 deletions(-)
> 
> --
> 2.20.1

I'm running the kernel with this submission applied on multiple machines
for 3 weeks now and haven't encountered any visible issues.

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

Thanks.

-- 
  Oleksandr Natalenko (post-factum)
