Return-Path: <SRS0=BCjA=ZF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5213C43331
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 14:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6D6222D0
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 14:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="sxga0JhF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfKMOZR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Nov 2019 09:25:17 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:51196 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfKMOZR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Nov 2019 09:25:17 -0500
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id B3925628D29;
        Wed, 13 Nov 2019 15:25:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1573655114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sFOnhcG2h9p6Leq82h9jLugL5gyFvgzjK5JNz6So8WM=;
        b=sxga0JhFMHZHIuZ6n5ejkVM3p0+cai1t1ON/G4fONpk2HwNcJ9AzXwlClxF48s9Y4Is+2N
        SkaWXY4Z4QBmto6aheOP5bAgXeVkdb8mvRob2Jaq/n8kR9j2pDLz5kNeuXApOGN9tni4AM
        22m7I/YCfNmodXWId2JM9bXsLz5YUYk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 13 Nov 2019 15:25:14 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, bfq-iosched@googlegroups.com,
        Chris Evich <cevich@redhat.com>,
        Patrick Dung <patdung100@gmail.com>,
        Thorsten Schubert <tschubert@bafh.org>
Subject: Re: [PATCH BUGFIX] block, bfq: deschedule empty bfq_queues not
 referred by any process
In-Reply-To: <2FB3736A-693E-44B9-9D1F-39AE0D016644@linaro.org>
References: <20191112074856.40433-1-paolo.valente@linaro.org>
 <bb393dcaa426786e0963cf0e70f0b062@natalenko.name>
 <2FB3736A-693E-44B9-9D1F-39AE0D016644@linaro.org>
User-Agent: Roundcube Webmail/1.4.0
Message-ID: <65fc0bffbcb2296d121b3d5a79108e76@natalenko.name>
X-Sender: oleksandr@natalenko.name
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 13.11.2019 14:52, Paolo Valente wrote:
>> I'm not sure if I see things right, but this commit along with v5.3.11 
>> kernel causes almost all boots to hang (for instance, on mounting the 
>> FS). Once the scheduler is changed to something else than BFQ (I set 
>> the I/O scheduler early via udev rule), multiple reboots go just fine.
>> 
> 
> If you switch back to bfq after the boot, can you still reproduce the 
> hang?

I didn't try to switch schedulers, but what I see now is once the system 
is able to boot with BFQ, the I/O can still hang on I/O burst (which for 
me happens to happen during VM reboot).

This may also not hang forever, but just slow down considerably. I've 
noticed this inside a KVM VM, not on a real HW.

>> Is this commit also applicable to 5.3 kernels?
> 
> It is.

OK, thanks for clarification.

-- 
   Oleksandr Natalenko (post-factum)
