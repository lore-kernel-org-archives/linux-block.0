Return-Path: <SRS0=cAVD=QH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E09C282D7
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 00:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152542184D
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 00:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpzQtOoI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbfAaAke (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 19:40:34 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35173 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfAaAkd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 19:40:33 -0500
Received: by mail-pg1-f193.google.com with SMTP id s198so595825pgs.2;
        Wed, 30 Jan 2019 16:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Ws/bebS5D5heJLhhBKnGPolq32ODto2YIw6c7Bl1Vz4=;
        b=OpzQtOoI8LLovZiH2njLYWMY+hnv+Fv6YByTYHyTKzcsreQ3G4115Rkmgdcj0HGkKJ
         lJrgoWTeFVFM+vDiszEr/pLUPk13bfSUQOuHmPfrv/d3xmslxXEkD4AENK8ErG0sF8QS
         Q6JDfPB7f1kkDqO7bf2mzcpDOLb1wVY76oTNBUIbRa+lV2rvfWCZAfd6eNuLdf8MsRA0
         YdRLX4AK10n9s5ttVlAFbSBL1Bubx4ghir8pyHCjBFr0PtkM+2dus6VO3GcZztKJtch7
         qyb7/eNZdT7G0Js6XawmGyNtt1AEYovqYTiEyA3Js5xPCR2VZRzH3RpiCyZgLMQYLlcO
         qgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Ws/bebS5D5heJLhhBKnGPolq32ODto2YIw6c7Bl1Vz4=;
        b=tsgetetWuhIPGQU0HvHPwcCRRXcfkPu0fgi+EjO0fC8P0r2Jwvmb7BWa/dyx6Oht17
         cFMnv4uczY9s93enK5e/2fY7yV3UT+znyktUndbeTGPJDVjfER2xpV26KKb6dYWKamrq
         261Lg53UqVbozaNLpBCWHxYCHs8dYIKr3CUTji1MLumTzdxeAIc/mxI+omixha9kuNiv
         0bb4RyrT3yx3fW6oGoivykiBFMrTT2aITor4ko0m9rggJ6PWu+pv3mf2M9Y5TzCvN5t5
         Ii7fOl+as7Kcqo1VQRt4WmuSAhImQ3dM1Dp0/3c9yyaohuZcWrRWMxg+PQvevKSk8krA
         gUGw==
X-Gm-Message-State: AJcUukdU5i9pvLJ73XULVobKyEDkyEPrct12AED/rnu4uUoayjPGC7yN
        eS/AGljNP9cAbYhOPO4jQIs=
X-Google-Smtp-Source: ALg8bN6Gq35ZeyfERh0xqDoVqF6RC8FQ/Sch+EalVkNDR/UuyK26P5IyU7pAuNkS5CsMND7/Zkssmg==
X-Received: by 2002:a63:3d49:: with SMTP id k70mr29618194pga.191.1548895233186;
        Wed, 30 Jan 2019 16:40:33 -0800 (PST)
Received: from ?IPv6:2001:df0:0:200c:11a4:fbe0:820d:335a? ([2001:df0:0:200c:11a4:fbe0:820d:335a])
        by smtp.gmail.com with ESMTPSA id a4sm3174588pgv.70.2019.01.30.16.40.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 16:40:32 -0800 (PST)
Subject: Re: [PATCH v7 0/2] Amiga RDB partition support fixes
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org
References: <1539570747-19906-1-git-send-email-schmitzmic@gmail.com>
Message-ID: <db30c3e0-f611-fc04-57dd-0cb0aa0b8ebf@gmail.com>
Date:   Thu, 31 Jan 2019 13:40:28 +1300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1539570747-19906-1-git-send-email-schmitzmic@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

All,

is there anything further I could do to speed up acceptance of these 
patches?

Cheers,

     Michael


On 15/10/18 3:32 PM, Michael Schmitz wrote:
> (hopefully) final version of the Amiga RDB partition table patch follows.
>   
> I've split off the part fixing the incorrect use of signed int
> for partition start address and size as separate patch. It does fix the
> bug that Martin Steigerwald reported six years ago for a 2 TB disk.
> I have tested this patch with the identical RDB partition data that
> Martin saw the bug with. I have incorporated Andreas' feedback on proper
> use of casts to avoid integer overflow in this version.
>
> The simple fix still leaves ample room for overflows in calculating start
> address and size of a RDB partition, though such overflows should only be
> seen in rather unusual cases. To address these potential overflows, checks
> are added in the second patch of this series. Comments by Geert have been
> addressed in full.
>
> Both patches now reviewed by Geert - Reviewed-by tags added.
>
> Cheers,
>
>          Michael
>
