Return-Path: <SRS0=KNqY=3X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB03C3524D
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 12:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8ECF2086A
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 12:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="w016ND5I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgBCMS6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Feb 2020 07:18:58 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:48330 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbgBCMS5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Feb 2020 07:18:57 -0500
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id EF5026B1283;
        Mon,  3 Feb 2020 13:18:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1580732334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UUaZsIgfN4rwth55A/e8XsKo48z1Y+WrEE3i3Ao4g9w=;
        b=w016ND5I9cnvobILmyGaNCSqLaAW9XD1rxaN66vCzNauL7CVS2YPNxdXMgXqWalH+KLCbQ
        fw+D4sfk1KZ9CWCVPPv8x9ZZ0z2BhaVYGQY1sG4WWitOJAumHInm1gKQUAibea+8j2Dz7c
        njP5IvTdhRsm6qRz8IQ+fAR7HkaAGSQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 03 Feb 2020 13:18:53 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, bfq-iosched@googlegroups.com,
        patdung100@gmail.com, cevich@redhat.com
Subject: Re: [PATCH BUGFIX V2 0/7] block, bfq: series of fixes, and not only,
 for some recently reported issues
In-Reply-To: <20200203104100.16965-1-paolo.valente@linaro.org>
References: <20200203104100.16965-1-paolo.valente@linaro.org>
User-Agent: Roundcube Webmail/1.4.2
Message-ID: <eb00f4213d90e1d1b171bbfc0dd5a3e6@natalenko.name>
X-Sender: oleksandr@natalenko.name
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03.02.2020 11:40, Paolo Valente wrote:
> Hi Jens,
> this the V2 of the series. The only change is the removal of ifdefs
> from around gets and puts of bfq groups. As I wrote in my previous
> cover letter, these patches are mostly fixes for the issues reported
> in [1, 2]. All patches have been publicly tested in the dev version of
> BFQ.
> 
> Thanks,
> Paolo
> 
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1767539
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=205447
> 
> Paolo Valente (7):
>   block, bfq: do not plug I/O for bfq_queues with no proc refs
>   block, bfq: do not insert oom queue into position tree
>   block, bfq: get extra ref to prevent a queue from being freed during 
> a
>     group move
>   block, bfq: extend incomplete name of field on_st
>   block, bfq: remove ifdefs from around gets/puts of bfq groups
>   block, bfq: get a ref to a group when adding it to a service tree
>   block, bfq: clarify the goal of bfq_split_bfqq()
> 
>  block/bfq-cgroup.c  | 16 ++++++++++++++--
>  block/bfq-iosched.c | 26 ++++++++++++++++++++------
>  block/bfq-iosched.h |  4 +++-
>  block/bfq-wf2q.c    | 23 +++++++++++++++++------
>  4 files changed, 54 insertions(+), 15 deletions(-)
> 
> --
> 2.20.1

Feel free to add:

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

since I'm running v5.5 with this series applied for a couple of days 
already without any visible smoke.

-- 
   Oleksandr Natalenko (post-factum)
