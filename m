Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E7FC77B7F
	for <linux-block@archiver.kernel.org>; Sat, 20 May 2023 02:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjETCRY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 May 2023 22:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjETCRX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 22:17:23 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91473F4
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 19:17:22 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ab0595fc69so893875ad.0
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 19:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684549041; x=1687141041;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psZw7XAh2HX45Y2hbyKCPHM8JEpSed/V+JSlzJpn4rs=;
        b=A5SZCoxgk/R+JDZHRfyB+FhHNfZnXXiOHOZ0Ddp7BXsfKY+RBLtm223iD6i5XriLZt
         RxtgS4uLKVWTvRWyGYW7XzrbmwNh+lFF/dVNTnJEYmEVhsupx17dSxpvSsgmIZsL0x9Q
         FnW1RQI3iKZBfOrfQKCR00A4tk5aBwZlG/s6k0WTrsvt/jM2ydUcSwOTmQtNYoVXaA+j
         7Myz2JmO3CpFbq2nhwRAfJq7VlVJ6OwaQT1KoIgTcAHgaKCC3fZJNza1NwVQ408vgzr4
         oqDSfuACHCRzJy2e51HpvZVsWDQ4e4yTcx0M40i5HyX5pHpV6pi7dbcG9jwnQ/GfaATx
         dQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684549041; x=1687141041;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=psZw7XAh2HX45Y2hbyKCPHM8JEpSed/V+JSlzJpn4rs=;
        b=QrM9Ossamc3B4RBjbu88wbYsBh1lMLYTV1Oc0B92TCVc1i1obMnm3PFpR1l/imwJAY
         eXlhjE2eOXKqgErhwiW0SO+MgR2G8x0g8xonJjejgW+NDwpYLweKExGCpwMmPhbUMwNa
         gUGCQ+PWQCToKp+LUpm5lU3c36p3fcP8sLXO4cwVZD7YaE4NeYEdgDzrso0OmQ2tBZ/O
         b2VAvKodyPysR7fBDXiomw4OemSH8xL6qzsgFnIAr+wQb7wQgJl/ZgD5yG8lJQEnU+ox
         N4NT0TZtEoNZD98WYnEwTk4Mtzuxqw7Kz5r+rTP+VgP5R95qurICoLcIhgdSkvo1YnRN
         IjmA==
X-Gm-Message-State: AC+VfDwcrtZPKek656AkVaEyFEiLVxG4FS9ti6XS1KeX8KhhiYq6VUkA
        R0Zjjwiw2M0uhePY9gz7SxEqySstKDt5RbDjsFA=
X-Google-Smtp-Source: ACHHUZ4DB+RD8pYin3ocD/JNEKad/8Brd/CqqKTs1Jow/8puMQfI1f2w49leYl5IXPQ5Ck/5gZiNBA==
X-Received: by 2002:a17:902:ec8a:b0:1a9:6467:aa8d with SMTP id x10-20020a170902ec8a00b001a96467aa8dmr4845869plg.1.1684549041540;
        Fri, 19 May 2023 19:17:21 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 1-20020a170902ee4100b001ab25a19cfbsm292795plo.139.2023.05.19.19.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 19:17:20 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20230510074223.991297-1-loic.poulain@linaro.org>
References: <20230510074223.991297-1-loic.poulain@linaro.org>
Subject: Re: [PATCH] block: Deny writable memory mapping if block is
 read-only
Message-Id: <168454904056.390379.11320556325676488044.b4-ty@kernel.dk>
Date:   Fri, 19 May 2023 20:17:20 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Wed, 10 May 2023 09:42:23 +0200, Loic Poulain wrote:
> User should not be able to write block device if it is read-only at
> block level (e.g force_ro attribute). This is ensured in the regular
> fops write operation (blkdev_write_iter) but not when writing via
> user mapping (mmap), allowing user to actually write a read-only
> block device via a PROT_WRITE mapping.
> 
> Example: This can lead to integrity issue of eMMC boot partition
> (e.g mmcblk0boot0) which is read-only by default.
> 
> [...]

Applied, thanks!

[1/1] block: Deny writable memory mapping if block is read-only
      commit: 69baa3a623fd2e58624f24f2f23d46f87b817c93

Best regards,
-- 
Jens Axboe



