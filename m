Return-Path: <SRS0=S5B1=ZN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FF1C43215
	for <linux-block@archiver.kernel.org>; Thu, 21 Nov 2019 07:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAAEF20898
	for <linux-block@archiver.kernel.org>; Thu, 21 Nov 2019 07:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="cpWxwtJK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfKUHN3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Nov 2019 02:13:29 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:48304 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfKUHN3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Nov 2019 02:13:29 -0500
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 209EA63ABEF;
        Thu, 21 Nov 2019 08:13:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1574320407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xL3ut0Gb5LSFbLI5E9f4K9lAtbTVA7+YunIPYZDbV+o=;
        b=cpWxwtJKtqIoO/RqxCc67gYWTHufAnDGJ8CkT5onyhsNXZ+wg9KxLT1h2iLinv3poL3CUQ
        kRJz6nJoEkkg3IzuwGDTNfhhJ2kDHTJf0puhf1jZey7k02yJqJLyNpuUCGv35I+3i5C/Ro
        T9m2r7IV18VLQp9jvsYY+tYX4R+T+7I=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 21 Nov 2019 08:13:27 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, paolo.valente@linaro.org
Subject: Injecting delays into block layer
User-Agent: Roundcube Webmail/1.4.0
Message-ID: <d7ee69fc368db16fa96a05643083674a@natalenko.name>
X-Sender: oleksandr@natalenko.name
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Paolo et al.

I have a strong suspect that something is going wrong when the 
underlying block device responds with a large delay. What makes me 
thinking so is that I use a VM on some cloud provider, and they have 
substantial block device latency resulting in permanently high (~20%) 
iowait. It spikes occasionally when their cluster is overloaded, and 
when that happens, the I/O in my VM may stop and never recover. This is 
a rare occasion, but it really happens.

What's worse, so far I've seen such a behaviour with BFQ only. I'm still 
testing other schedulers though.

Important note: I have no strict evidences that this is *the* case, thus 
I'm asking for some suggestions. My idea is to fire up a local VM and 
inject delays to a block device while performing some I/O from within 
the VM.

So the question is: how can those delays be injected? Using dm-delay? 
Can those delays be random?

Thanks in advance.

-- 
   Oleksandr Natalenko (post-factum)
