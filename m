Return-Path: <SRS0=4SCO=RN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5659C10F0D
	for <linux-block@archiver.kernel.org>; Sun, 10 Mar 2019 21:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32AC20657
	for <linux-block@archiver.kernel.org>; Sun, 10 Mar 2019 21:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="YiF51NDg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfCJVVs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Mar 2019 17:21:48 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:40404 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfCJVVr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Mar 2019 17:21:47 -0400
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 980C34F961F;
        Sun, 10 Mar 2019 22:21:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1552252903;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZDXGufe+RVvE9rLnjl0k6TurgSY39BAFEAfs/tNsDR4=;
        b=YiF51NDgew/mr73S+1gLlsm2+EA6heU/pKeK1wwBmR6UEROqosLvKPyZwYei8duAezVuiw
        Uh3/0yEmAfwCpL/ceo0VlLBam0Sm+Vh/mbyUCjkkU27Sk2UqkqtYn6mXZ9eGTO+Sz4phuG
        YMyon6Pwh+6KdAcuUJPGMHREslCq4ow=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 10 Mar 2019 22:21:43 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, broonie@kernel.org,
        bfq-iosched@googlegroups.com, fra.fra.800@gmail.com,
        alessio.masola@gmail.com
Subject: Re: [PATCH BUGFIX IMPROVEMENT V2 0/9] block, bfq: fix bugs, reduce
 exec time and boost performance
In-Reply-To: <20190310181137.2604-1-paolo.valente@linaro.org>
References: <20190310181137.2604-1-paolo.valente@linaro.org>
Message-ID: <8325fa983ce0e4aec257704861cfe87b@natalenko.name>
X-Sender: oleksandr@natalenko.name
User-Agent: Roundcube Webmail/1.3.8
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1552252903;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZDXGufe+RVvE9rLnjl0k6TurgSY39BAFEAfs/tNsDR4=;
        b=w+tILmqk+ayGZc25yKL03Tj2SaWacu9v+MzylUjqeVKrjJ80eIZ6a4ExsmCRqwsmscbld6
        6GcK2blWjQnk/vmbCFKqbDT6c4zxaunYo2K3icheJ5W3I6lZosB8Z4mI+AbSnJbOYYpC0J
        Jxb1HDi0GcsTnmIf4lDU5e5om6R2upM=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1552252903; a=rsa-sha256;
        cv=none;
        b=yVLjaJTzVgzYsssEIHLpzxDcY7iAv8XJOPlyZCOL9hCrNGASX/4PgJuSu4r/IoHCfTh88J
        Ijyjuu7JGmgnCroiOKP4o6H1xP64pIH3Iju0FvDsquF3aXg5b3582BEnDJA34nqwiB7QBW
        EZYDhQUUq2xi5JTNONNgUAkkzNKJYhk=
ARC-Authentication-Results: i=1;
        vulcan.natalenko.name;
        auth=pass smtp.auth=oleksandr@natalenko.name smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi.

On 10.03.2019 19:11, Paolo Valente wrote:
> this is the v2 of the series
> https://lkml.org/lkml/2019/3/7/461
> that fixes some bug affecting performance, reduces execution time a
> little bit, and boosts throughput and responsiveness.
> 
> The difference w.r.t. v1 is that Francesco has fixed compilation
> issues of patch "block, bfq: print SHARED instead of pid for shared
> queues in logs".
> 
> I took the opportunity of this v2 to also add BFQ's execution time to
> the documentation.
> 
> Let me remind again that these patches are meant to be applied on top
> of the last series I submitted:
> https://lkml.org/lkml/2019/1/29/368
> 
> Thanks,
> Paolo
> 
> Francesco Pollicino (2):
>   block, bfq: print SHARED instead of pid for shared queues in logs
>   block, bfq: save & resume weight on a queue merge/split
> 
> Paolo Valente (7):
>   block, bfq: increase idling for weight-raised queues
>   block, bfq: do not idle for lowest-weight queues
>   block, bfq: tune service injection basing on request service times
>   block, bfq: do not merge queues on flash storage with queueing
>   block, bfq: do not tag totally seeky queues as soft rt
>   block, bfq: always protect newly-created queues from existing active
>     queues
>   doc, block, bfq: add information on bfq execution time
> 
>  Documentation/block/bfq-iosched.txt |  29 +-
>  block/bfq-cgroup.c                  |   3 +-
>  block/bfq-iosched.c                 | 786 +++++++++++++++++++++++-----
>  block/bfq-iosched.h                 |  92 ++--
>  block/bfq-wf2q.c                    |   2 +-
>  5 files changed, 729 insertions(+), 183 deletions(-)
> 
> --
> 2.20.1

Builds fine this time, thanks :).

I'm running v1 series since the submission just fine (with a fix from 
zen-kernel guys [1]), and since v2 is functionally equivalent, feel free 
to add Tested-by once it is accepted.

[1] 
https://github.com/zen-kernel/zen-kernel/commit/0665ba81203c196b649d325e4ec2491d7ff1be01

-- 
   Oleksandr Natalenko (post-factum)
