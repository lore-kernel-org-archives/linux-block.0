Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C690C001B0
	for <linux-block@archiver.kernel.org>; Wed, 16 Aug 2023 15:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344190AbjHPPei (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Aug 2023 11:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344232AbjHPPee (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Aug 2023 11:34:34 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE08268D
        for <linux-block@vger.kernel.org>; Wed, 16 Aug 2023 08:34:27 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b89b0c73d7so9633935ad.1
        for <linux-block@vger.kernel.org>; Wed, 16 Aug 2023 08:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692200067; x=1692804867;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szijuggdBgOnGhhlhc88VNlpdmYNCTxiLI/7liHn6JI=;
        b=nbX+MEgU/N7E71s8kgzLc8flbc7HMMP5zy/X30TZJFjP1cj00r1QO2xOWPpiTzBIKg
         ZWZG1IxiEx5tFvMu3grWy9PuFGWTPCAlbcE9EwSigc23KyMX+QI53kaPuVXuoi7sAJSN
         yds/qaECDqHmzzwzipb3JR92MfBotjmjMVaWcANj5c4qtcpE+xK+HijocSjbBDoleInB
         QxCLuQLv9Ljx/znQMiNe2TekLoi5MhxqkbPMw+RcrE2eunOyPRTcSBp4BKaC+rlE/4Ej
         1QYm56ZwyZcrYkLh4vECjVMzr9b8SqkDvxyHDx3g2xM1Q3UiaFNhJzgPllM8W8N8KNM0
         xxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692200067; x=1692804867;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szijuggdBgOnGhhlhc88VNlpdmYNCTxiLI/7liHn6JI=;
        b=UEpGxWWfHH1rXsg/npZn10AIaIQEarasfSCGGmbDFZNGgSd4Egfn48D6YW6WoIgv74
         uctKYxlxTi6ABs4bGYmUDzWG+IKGtGBK4z0d/KZ1BvSMrQLFbntCdrbFpbFS5x3J/ZBT
         U3b6FVNA1HzgHA3HvCk+L7cC2s/REuGE8eNA/bCHka7s9Vb+gy+aVVBhRYmuaAZwdWdJ
         9U31raJ52zEGp4Qx2PTiyFn9d+Z86tdBUH4WTGGNftaRyWy56/dT4x0Ppb53ZVNIuv6s
         kCbv34WAyBGG4Q4B3Le5KCOY28GSAOkLm7nGW2pewToaJnhb7PntSyfob5VRKTHE1hgN
         P6LA==
X-Gm-Message-State: AOJu0YwuWsvPyqgJlhNGHSjaTQtPkZ8j/dWCC1GzE5Q7p1YbYmvUUJUJ
        ZpZ/h+cihOSv3v3EoiMcZQQJwvTqsHDR4DMNKvg=
X-Google-Smtp-Source: AGHT+IGeTr0mgFa21N7TONbGhjcHbzLgDbgckmj9bZkZ7cVbb0OiGz04V5SIbMAZefEzVhmX4z2DQA==
X-Received: by 2002:a17:902:cec1:b0:1b8:85c4:48f5 with SMTP id d1-20020a170902cec100b001b885c448f5mr2642304plg.2.1692200066845;
        Wed, 16 Aug 2023 08:34:26 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id m11-20020a170902768b00b001bb750189desm13320648pll.255.2023.08.16.08.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 08:34:26 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>
In-Reply-To: <20230816022210.2501228-1-lizhijian@fujitsu.com>
References: <20230816022210.2501228-1-lizhijian@fujitsu.com>
Subject: Re: [PATCH] drivers/rnbd: restore sysfs interface to rnbd-client
Message-Id: <169220006570.515765.5824725604378944460.b4-ty@kernel.dk>
Date:   Wed, 16 Aug 2023 09:34:25 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Wed, 16 Aug 2023 10:22:10 +0800, Li Zhijian wrote:
> Commit 137380c0ec40 renamed 'rnbd-client' to 'rnbd_client', this changed
> sysfs interface to /sys/devices/virtual/rnbd_client/ctl/map_device
> from /sys/devices/virtual/rnbd-client/ctl/map_device.
> 
> 

Applied, thanks!

[1/1] drivers/rnbd: restore sysfs interface to rnbd-client
      commit: 8fc3dbf3dfb1ff30c9893fbbf02b0169f25944fe

Best regards,
-- 
Jens Axboe



