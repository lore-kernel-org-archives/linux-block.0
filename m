Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B9CC282C4
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 10:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296482081B
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 10:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="ly7PD47l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbfBDKEJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:04:09 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:55058 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbfBDKEJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Feb 2019 05:04:09 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id B049AA02AA;
        Mon,  4 Feb 2019 11:04:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1549274647; i=@fjfi.cvut.cz;
        bh=pEd1vyMV8wDIwVTljp/3Aur/vUXf29tv3l2FbPk7xTo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References;
        b=ly7PD47lKobHrooItiQKw2MLcAJKqAUdBKfr+CH8cDBs/LdR+eH9xgIwoiHLc2BAN
         NKRGmpp1MxEhNz+csKGxti6Qxhx0XjNzuHEwV1TZgakHVtiSPUQLJJkEQ+wJE7jKek
         0j8JKDv9XntNx2am0I8zXTFjRgPUVq98U26ZhdZo=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id mGzc0RPetRUH; Mon,  4 Feb 2019 11:04:00 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id 252E2A036F;
        Mon,  4 Feb 2019 10:44:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz 252E2A036F
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id B53636004E; Mon,  4 Feb 2019 10:44:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by linux.fjfi.cvut.cz (Postfix) with ESMTP id A38AC6004D;
        Mon,  4 Feb 2019 10:44:14 +0100 (CET)
Date:   Mon, 4 Feb 2019 10:44:14 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH v4 00/16] block: sed-opal: support shadow MBR done flag
 and write
In-Reply-To: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
Message-ID: <alpine.LRH.2.21.1902041036190.15740@linux.fjfi.cvut.cz>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 1 Feb 2019, David Kozub wrote:

> This patch series extends SED OPAL support: it adds IOCTL for setting the shadow
> MBR done flag which can be useful for unlocking an OPAL disk on boot and it adds
> IOCTL for writing to the shadow MBR. Also included are some minor fixes and
> improvements.
>
> This series is based on the original work done by Jonas Rabenstein which was
> submitted in March 2018.[1]
>
> There is a fork of sed-opal-temp that can use these new IOCTLs.[2] I tested
> these on Samsung 840 EVO and 850 EVO drives, on x86-64 and arm64 systems.
>
> The series applies on v5.0-rc4.
>
> I'm resending as v4 as suggested by Scott Bauer.[3]
>
> Changes from v3 to v4:
> * added Reviewed-by from Scott, including for the patch 16/16 (details in
> [3])

So this time really the 16th patch got lost somewhere - while I have 
received it, I could not see it in https://lore.kernel.org/lkml/. So I 
re-sent it now.

Best regards,
David
