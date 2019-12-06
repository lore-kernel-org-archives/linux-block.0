Return-Path: <SRS0=tn0U=Z4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CBAC43603
	for <linux-block@archiver.kernel.org>; Fri,  6 Dec 2019 19:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7C32173E
	for <linux-block@archiver.kernel.org>; Fri,  6 Dec 2019 19:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="bnL54PGB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfLFTu2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Dec 2019 14:50:28 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:47708 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfLFTu2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Dec 2019 14:50:28 -0500
Received: from mail.natalenko.name (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 64A20657D91;
        Fri,  6 Dec 2019 20:50:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1575661825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZC7LwodZ7z+kUm1VSnC0q0hquvRi0Hg0suhCMNuHAlo=;
        b=bnL54PGBpefxiGlUjY3n4UNDX0IsSGQuU7z1x5G4j7vCSsLOf7TJ2ZkbYvrE2nb9whkoKX
        41ggtAc+TrUxuIcPqr5f6bGp+AJnO4YpxrOSm5GNnp0ajnZnIgrO64OUSeSea2sxZef1E0
        +ZW4z+18dZl/zyFNTGduUWjXTO08ZXo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 06 Dec 2019 20:50:25 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        SIMONE RICHETTI <206161@studenti.unimore.it>
Subject: Re: Injecting delays into block layer
In-Reply-To: <942604AE-5A91-4E05-869F-74A7EAC5A247@linaro.org>
References: <d7ee69fc368db16fa96a05643083674a@natalenko.name>
 <3D695D19-B226-4093-9C27-CE561ED08CB7@linaro.org>
 <942604AE-5A91-4E05-869F-74A7EAC5A247@linaro.org>
User-Agent: Roundcube Webmail/1.4.1
Message-ID: <9f0b26c537f298defc56b7e39468db22@natalenko.name>
X-Sender: oleksandr@natalenko.name
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello.

On 06.12.2019 17:17, Paolo Valente wrote:
> Simone (in CC) and I have worked a little bit on reproducing the I/O
> freeze you report.  Simone made a small change in SCSI_debug, which
> makes the latter serve I/O with a highly varying random delay (100ms -
> 1s), about twice a second.
> 
> Then, to generate some fluctuating and heavy I/O, he ran the
> comm_startup_lat.sh script of my S suite with SCSI_debug a few times.
> Unfortunately, he didn't succeed in reproducing the problem.  If you
> want, we can send you a patch with his change for SCSI_debug.
> 
> Any news on your side?

I was playing with dm-delay in an isolated VM, but so far got no luck. 
I'll try to find another way to trigger this (if the bug is still 
present in 5.4) and get back to you in case of success.

For me it is a rare occurrence in production, and since I've upgraded to 
5.4 and disabled BFQ I haven't seen any at all. At this point I'm not 
even sure what I'm looking at. I'll try to re-enable BFQ soon to stress 
my production VMs again.

Thank you.

-- 
   Oleksandr Natalenko (post-factum)
