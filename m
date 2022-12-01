Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CCEC43217
	for <linux-block@archiver.kernel.org>; Thu,  1 Dec 2022 16:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiLAQRK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Dec 2022 11:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiLAQRH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Dec 2022 11:17:07 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C01143869
        for <linux-block@vger.kernel.org>; Thu,  1 Dec 2022 08:17:06 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id k2-20020a17090a4c8200b002187cce2f92so5695074pjh.2
        for <linux-block@vger.kernel.org>; Thu, 01 Dec 2022 08:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISuxPwYDzCqt8IdYKueJkJ48Z6xBeFf0NTwfB2Gkdr0=;
        b=dMeICjaNj5nIk9l6kaxxgGlMY0GCsn4ezx3phjZDb7Hf3TLpdBrqyJRj7/YpQU3g8h
         +tmxEUeoMYiGfc86DDcQUcydRybOSLcUHQXlWQlkGq7kEprBBjmuu6LW/mZgVU3vectE
         ZCQFSK/l8wj/4IA9+4aN+UrwkGvNh+8ohs46FKInANfsuNsatSZHqrE/3brRyvhSCSb5
         UMv4/bHBHd2LnoCzyMhKFOQ1hwx4cJDSL5GlxZX3GWCojxciJjpYxg3d0+x8kFUx3TIC
         +Z94RiqeGtIUhHLe3shQx4o/LA/tbiOmUAJO3/zs1LqHIaLoCgWRlQseJNC6iMGoZIDE
         IURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISuxPwYDzCqt8IdYKueJkJ48Z6xBeFf0NTwfB2Gkdr0=;
        b=roHw+4mz8QMG1S9TMp1G5ZVYPnOr82eKSsNaPG7ehk2E91RDz5nq+zbM3/L/GgMp4j
         sjVsZAFX7lLOHkWmqHf2jhuAH0ZkR6PsDm2zQcl11M94XfbOsz6MmNinleCjHz3wV13y
         FE9DwrhkQOqY2dRGt/gDBgPKn738GQF7XngN4E0NDrr9x4IatjFzC1Xfla1GSXfRb+5u
         gERg0ofunLRvoUCNU8vrWUmlshrzv4ePaS76uwMkqCkXh9h2d/3S07hujRneltrjL7DV
         eqrvdWJAXIyWEcFMc0F64SiduaxEPkkc6NZ/NfhhXLz5mO+O8uhC69R2nJbLT/7yKcbo
         bDeQ==
X-Gm-Message-State: ANoB5pl4MbaOCNMnO1MpQ+5WT9KdbXTO8btXe84L2YxSkNyvU1aee4bo
        g5ic0+O11ltf7i5aArfcHiexJ7ebGUBdIztm
X-Google-Smtp-Source: AA0mqf4OiQkCMHaBNbtThte7wfsfTN4wiDapkq1T0EYnWQCWhGB64fdu6IV8zz/m0H/6w21P0jlYng==
X-Received: by 2002:a17:902:b189:b0:189:396f:7c43 with SMTP id s9-20020a170902b18900b00189396f7c43mr45357095plr.13.1669911425646;
        Thu, 01 Dec 2022 08:17:05 -0800 (PST)
Received: from [127.0.0.1] ([2620:10d:c090:400::5:6c2d])
        by smtp.gmail.com with ESMTPSA id a4-20020a17090a480400b001fe39bda429sm3192540pjh.38.2022.12.01.08.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 08:17:05 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20221201070331.25685-1-rdunlap@infradead.org>
References: <20221201070331.25685-1-rdunlap@infradead.org>
Subject: Re: [PATCH] block: bdev & blktrace: use consistent function doc. notation
Message-Id: <166991142449.790835.5342516828140228068.b4-ty@kernel.dk>
Date:   Thu, 01 Dec 2022 09:17:04 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d377f
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 30 Nov 2022 23:03:31 -0800, Randy Dunlap wrote:
> Use only one hyphen in kernel-doc notation between the function name
> and its short description.
> 
> The is the documented kerenl-doc format. It also fixes the HTML
> presentation to be consistent with other functions.
> 
> 
> [...]

Applied, thanks!

[1/1] block: bdev & blktrace: use consistent function doc. notation
      commit: 2e833c8c8c42a3b6e22d6b3a9d2d18e425551261

Best regards,
-- 
Jens Axboe


