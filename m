Return-Path: <SRS0=/o95=RK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D82C43381
	for <linux-block@archiver.kernel.org>; Thu,  7 Mar 2019 22:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0405620657
	for <linux-block@archiver.kernel.org>; Thu,  7 Mar 2019 22:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="ojceyxaP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfCGWOR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Mar 2019 17:14:17 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:17934 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfCGWOR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Mar 2019 17:14:17 -0500
X-Greylist: delayed 568 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Mar 2019 17:14:15 EST
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id DECA84F4FAE;
        Thu,  7 Mar 2019 23:04:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1551996285;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Dh1v6nRRoPDMR08JHSiAFiJ7kRk4SEnXotOw9B/r+Y=;
        b=ojceyxaPPC8ineATAXPfrZ9B1kXAFrn8yFnASj89Io/HBa9KViEy4IVnrVOrCqDxgfICRP
        i2Rh4LSoG9DUGGeDpnnV4DMN/0QfwgkB4MAfGBH19VqiVIWWCq9nxJlEYMFlzvkX/8v9xp
        +elDdB295jZT5G6i00G4uNYD9Jsj3fY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 07 Mar 2019 23:04:45 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, broonie@kernel.org,
        bfq-iosched@googlegroups.com, fra.fra.800@gmail.com
Subject: Re: [PATCH BUGFIX IMPROVEMENT 0/8] block, bfq: fix bugs, reduce exec
 time and boost performance
In-Reply-To: <20190307162554.77205-1-paolo.valente@linaro.org>
References: <20190307162554.77205-1-paolo.valente@linaro.org>
Message-ID: <44c14c771a77db13289bd99d2fc0d029@natalenko.name>
X-Sender: oleksandr@natalenko.name
User-Agent: Roundcube Webmail/1.3.8
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1551996285;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Dh1v6nRRoPDMR08JHSiAFiJ7kRk4SEnXotOw9B/r+Y=;
        b=P2BGJxoJ8bURWBijItkeqU9zLkJV4VYfI4goLHneNBgRaZ//23iIkt+Q/3C0uCSz69AjUQ
        LXerPGWYtBp93ycaHOgSugelIFwxZRy474quP8jpu8cWbFjEGcfQz2GTucBAmuh4N2aodP
        XwYcmiGwqhDGQupyZTH+n0AeBAC8ccQ=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1551996286; a=rsa-sha256;
        cv=none;
        b=PdQEbygoHNRe0+vd6A0oM6azJ93L4vJu/9b4CpAZIFX+ZWCv2iorLPyS7vcAdeWLcnRo1g
        70OQRZ1CUhThlkXaqT+VB6uXT6TXWzluGRNdD0vBskAEWklYg4QbnMX5MpVspy6JUT/N9U
        dvfeU3fpTo1cJo68PpvXBkaDwx8uRbU=
ARC-Authentication-Results: i=1;
        vulcan.natalenko.name;
        auth=pass smtp.auth=oleksandr@natalenko.name smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi.

On 07.03.2019 17:25, Paolo Valente wrote:
> since I didn't make it to submit these ones for 5.1, let me be
> early for 5.2 :)
> 
> These patches fix some bug affecting performance, reduce execution
> time a little bit, and boost throughput and responsiveness.
> 
> They are meant to be applied on top of the last series I submitted:
> https://lkml.org/lkml/2019/1/29/368
> 
> Thanks,
> Paolo
> 
> Francesco Pollicino (2):
>   block, bfq: print SHARED instead of pid for shared queues in logs
>   block, bfq: save & resume weight on a queue merge/split
> 
> Paolo Valente (6):
>   block, bfq: increase idling for weight-raised queues
>   block, bfq: do not idle for lowest-weight queues
>   block, bfq: tune service injection basing on request service times
>   block, bfq: do not merge queues on flash storage with queueing
>   block, bfq: do not tag totally seeky queues as soft rt
>   block, bfq: always protect newly-created queues from existing active
>     queues
> 
>  block/bfq-cgroup.c  |   3 +-
>  block/bfq-iosched.c | 786 ++++++++++++++++++++++++++++++++++++--------
>  block/bfq-iosched.h |  87 +++--
>  block/bfq-wf2q.c    |   2 +-
>  4 files changed, 704 insertions(+), 174 deletions(-)
> 
> --
> 2.20.1

Fails for me with:

===
[11966s] ld: block/bfq-wf2q.o: in function `bfq_pid_to_str':
[11966s] bfq-wf2q.c:(.text+0x3b0): multiple definition of 
`bfq_pid_to_str'; block/bfq-iosched.o:bfq-iosched.c:(.text+0x1ab0): 
first defined here
[11966s] ld: block/bfq-cgroup.o: in function `bfq_pid_to_str':
[11966s] bfq-cgroup.c:(.text+0x3a0): multiple definition of 
`bfq_pid_to_str'; block/bfq-iosched.o:bfq-iosched.c:(.text+0x1ab0): 
first defined here
[11966s] make: *** [Makefile:1021: vmlinux] Error 1
===

-- 
   Oleksandr Natalenko (post-factum)
