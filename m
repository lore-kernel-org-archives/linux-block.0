Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97DFC4332F
	for <linux-block@archiver.kernel.org>; Tue,  4 Oct 2022 16:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiJDQmF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Oct 2022 12:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiJDQmD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Oct 2022 12:42:03 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AC05FAF9
        for <linux-block@vger.kernel.org>; Tue,  4 Oct 2022 09:42:02 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id b20so921492iof.2
        for <linux-block@vger.kernel.org>; Tue, 04 Oct 2022 09:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=0i98s1EMzTMBPsiKMIhUHBahDQAZLN3S8+2vEgOt2oE=;
        b=a0qj2Q463SqfIC+Ubs74QDDq2ZbB3HQaPsO5gIq2lbw4HV6gCGWroyQhl7cM7Tqooh
         H98g3g64Nfc9IQAZtf2zBjeUdCOuP/SpwLtixbH3S/VH0FC/8mjLvorGNNyf2jh9P5Yk
         JRQldBkXqa59oDXlPSNgoqeh7L4/hdTjAMLxHa2e2I30mKGVONGQ01QrulJk/VT57NoH
         EdhNSo2Dn68qLIyMXCEU91fmpweAbwHlyIyz6e7wHehVSmTE8B6U/WupgN+wsN7nwYGO
         SyqXSEK4WsM7eX0Tx7AAFa/Xr2R2cMvgD9kdU6k9cUXyr+Cnu4lIBdtdUNlbUomZNDSE
         GlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=0i98s1EMzTMBPsiKMIhUHBahDQAZLN3S8+2vEgOt2oE=;
        b=hRY5dDCfqDB1r50XHRwnpV2cntTTNpTPEjEURD4HEgy6recESGUOchTZGYzqoqtK8F
         FLwgPBCDd1lam4XiR980/GPtvUQLL5YAW8PV/kr/iP/UdvDsBI6ttrkrvkqcN4jkqghz
         0HC1xrCuhNdHujRVY5Sro0/MC3fDAfGPxEainT+GSx/ye+sP3QBDCL5pIsokrjRrxeOQ
         Zf3dFQiZMPFf+zg6qwY+w5jAtm5y0sQ+RbDqWjITljywl+6+PBeY5nDJ7sHJJ3n9nkWD
         u93FsadqJBxTLUguz9ZjtPcO8NB1wmd2OCm1nS877rHEjc0klXEQq0wolclHaiG0KHvQ
         YWpQ==
X-Gm-Message-State: ACrzQf2Y6R0a0x1/ZGQHLb/NB/vgx2jNV16hCRYPtWHT98vUbgBDQbr/
        +YOpo5IZ2UHYfA3hY/YTXnNXSOp2FM0RiA==
X-Google-Smtp-Source: AMsMyM62ZvTH0hn0AHpbQRffdx3Xg4I5EYsBhw3h7vAhYluNamICqCTzx6u/YvAUQwS2jPE/qZmsLQ==
X-Received: by 2002:a05:6638:3390:b0:35a:a74e:44e3 with SMTP id h16-20020a056638339000b0035aa74e44e3mr13205908jav.77.1664901721530;
        Tue, 04 Oct 2022 09:42:01 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c72-20020a02964e000000b003633ef39bd3sm1638823jai.92.2022.10.04.09.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 09:42:00 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Khazhismel Kumykov <khazhy@chromium.org>
Cc:     linux-block@vger.kernel.org,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220926220134.2633692-1-khazhy@google.com>
References: <20220926220134.2633692-1-khazhy@google.com>
Subject: Re: [PATCH] block: allow specifying default iosched in config
Message-Id: <166490172029.91699.2910906888136711371.b4-ty@kernel.dk>
Date:   Tue, 04 Oct 2022 10:42:00 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 26 Sep 2022 15:01:34 -0700, Khazhismel Kumykov wrote:
> Setting IO scheduler at device init time in kernel is useful, and moving
> this option into kernel config makes it possible to build different
> kernels with different default schedulers from the same tree.
> 
> Order deadline->none->rest to retain current behavior of using "none" by
> default if mq-deadline is not enabled.
> 
> [...]

Applied, thanks!

[1/1] block: allow specifying default iosched in config
      commit: ad9d3da2d07e0b2966e3ced843a0e2229410e26a

Best regards,
-- 
Jens Axboe


