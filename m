Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D562DEB64D8
	for <linux-block@archiver.kernel.org>; Thu, 22 Jun 2023 13:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjFVNsc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Jun 2023 09:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjFVNsc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Jun 2023 09:48:32 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2A7118
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2023 06:48:31 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6687b209e5aso1015287b3a.0
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2023 06:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687441710; x=1690033710;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFktY9FC/v0cPdpdf64j1Ie2wHP439HGYf6tFxhBVcM=;
        b=vXUL0VErem8EcKKyP4ApMucyMO2JjPrXXRJsVU2xryjChX4J03icCFflLFaNdfki0L
         JH6MnDjwbXL5i+kZUrZyko7L2S/6BaQPOXOmwf06sQCvZLNB5YjKSuszufgdRTDamLJ4
         x+9sy7g6KnKw3DXQoivntkMNjUNwvIKpTgc3/nhW1jJQW0Daf4+DnubJURw26BiUUy00
         j5je2E97bKaNHeU60nYHlQr5whEpLOsWYNdohaMnBW+t+rMDfYSqNF6u9V7H6ikUVnHl
         EFSxUK/7XJZoo2ZxxCWX6fq8gkkqLalv0ZQQrc1uJnHmgA/a227sPPGYetDC7GJhxKjD
         Opxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687441710; x=1690033710;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFktY9FC/v0cPdpdf64j1Ie2wHP439HGYf6tFxhBVcM=;
        b=azGJg4gAdlcxCo82J9f1gGlqS+j0G0TBIE3UQG+SNPSyxyA+NmAwJUcGG0bd2ONoUy
         PF+1JKnWZel2hdW7/vzMcoaB41fUFLZH31EsefS1725i59v5dBi+67CIXQgYx9EAro4/
         SPN22rbHRgHUvIeB2UCYWkTOObJ1APMHJjz+Y35/okuo3LjgRwGIxGmspV+HP080gf68
         kqJAEE1tx3MNZovXacQg6nWHJgpMJRgnXhZ5yWR9EszmpSmHCKR0076OiTbv4OGw/ZG/
         k8FrriAlesTziYd0zzDffZso6jgtOo0ynp/A0Q8l+Rm4Mz5GjIpxOKO6Wct0xizZeDsW
         sjEw==
X-Gm-Message-State: AC+VfDwUNpaD0rhMJqe9ThYEhZLNG0DMZCaia3Ys7KJ1T2e7/zcCLcsN
        TE/mXIZVCdGPG8Pqpo/IKX5xuoZg+AU4ExySTuI=
X-Google-Smtp-Source: ACHHUZ7i9QJqekc9rx3wLczR8Hh3OyeFRjgzfJafgInhkDo9Om+RdiBa4VnhbLW2z2I8oULQtkZvUg==
X-Received: by 2002:a05:6a21:7899:b0:11f:c8f4:8418 with SMTP id bf25-20020a056a21789900b0011fc8f48418mr18061498pzc.4.1687441710262;
        Thu, 22 Jun 2023 06:48:30 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c3-20020a63ef43000000b0054fd46531a1sm4921094pgk.5.2023.06.22.06.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 06:48:29 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20230617113828.1230-1-phil@philpotter.co.uk>
References: <20230617113828.1230-1-phil@philpotter.co.uk>
Subject: Re: [PATCH 0/1] cdrom: spectre-v1 patch for 6.5
Message-Id: <168744170928.15217.13556349226963095661.b4-ty@kernel.dk>
Date:   Thu, 22 Jun 2023 07:48:29 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-d8b83
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Sat, 17 Jun 2023 12:38:27 +0100, Phillip Potter wrote:
> Please apply the following patch from Jordy Zomer, which introduces a
> spectre-v1 mitigation within the CDROM_MEDIA_CHANGED ioctl handler of
> drivers/cdrom/cdrom.c, to your for-6.5/block branch.
> 
> Many thanks in advance.
> 
> Regards,
> Phil
> 
> [...]

Applied, thanks!

[1/1] cdrom: Fix spectre-v1 gadget
      commit: 8270cb10c0681d52fce508f827dfa1688d3acc3a

Best regards,
-- 
Jens Axboe



