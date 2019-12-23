Return-Path: <SRS0=vQdV=2N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16171C2D0C8
	for <linux-block@archiver.kernel.org>; Mon, 23 Dec 2019 00:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A855120684
	for <linux-block@archiver.kernel.org>; Mon, 23 Dec 2019 00:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="rC+8/udN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfLWAKX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 Dec 2019 19:10:23 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:39474 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfLWAKX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Dec 2019 19:10:23 -0500
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id A17CB66A2C3;
        Mon, 23 Dec 2019 01:10:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1577059820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4nuc1AoyG636k7YM3XrC/oDbYE0mXjxK+LkO7UE/R7g=;
        b=rC+8/udNxj1AKXwCy4zpbuZBGwDe69x2NVua5uDpde2nu2jnucbjQ4R2PaFph7S4pQWTHe
        v3v7N+uwBriOz51Yf8BWdL9NnE5q47iIPZmdKas96L3v72TqOy1u04X19IbMjpjb9P8ruy
        fptiLJaqSFKrFhiW8dVqWqX2OTRrrQU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 23 Dec 2019 01:10:20 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        SIMONE RICHETTI <206161@studenti.unimore.it>, tytso@mit.edu
Subject: Re: Injecting delays into block layer
In-Reply-To: <942604AE-5A91-4E05-869F-74A7EAC5A247@linaro.org>
References: <d7ee69fc368db16fa96a05643083674a@natalenko.name>
 <3D695D19-B226-4093-9C27-CE561ED08CB7@linaro.org>
 <942604AE-5A91-4E05-869F-74A7EAC5A247@linaro.org>
User-Agent: Roundcube Webmail/1.4.1
Message-ID: <21d34f9558a286c60352b5634f291f71@natalenko.name>
X-Sender: oleksandr@natalenko.name
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi.

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

FWIW, I guess I'm safe to exclude BFQ at the moment since I've 
encountered a very similar issue without having BFQ enabled.

Also, I think this might be unrelated to the block layer at all. I 
suspect there's some race between MADV_MERGEABLE and MADV_DONTNEED since 
this is what's hammering the affected tasks and what I see from the call 
traces.

I'll investigate further and probably talk to MM people instead. Sorry 
for the noise.

-- 
   Oleksandr Natalenko (post-factum)
