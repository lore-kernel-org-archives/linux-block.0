Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DBAC433DB
	for <linux-block@archiver.kernel.org>; Sun, 14 Feb 2021 10:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68C8164DCF
	for <linux-block@archiver.kernel.org>; Sun, 14 Feb 2021 10:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhBNKcA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Feb 2021 05:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhBNKb7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Feb 2021 05:31:59 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16932C061574
        for <linux-block@vger.kernel.org>; Sun, 14 Feb 2021 02:31:19 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id jt13so6648297ejb.0
        for <linux-block@vger.kernel.org>; Sun, 14 Feb 2021 02:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N98p0U+cHuyXVmhjuFaGftj4NomTav3ZwnLGwBYW7yk=;
        b=JCEO7BqkPSUjU0hZhMcBwr/YwuhC0rjiQN5bj/n09RF9q+Lr973E76m/UB3FYu4u1s
         mP1gNL7SPNs8+o0INtfPFlPjhbtS10VSm921W6rKRDu1lLFMdKDRl5bxmSxhwSDd6Ww/
         vqIw9aCQQkYuxeoN8WMGlH6i+Cpl3s8dxnJvaDMI454bmZm5zIv2dwCqltehHFCQ8hVM
         RwAz4B2RnoXn8HF6XbytWyC2vxxpwEicdgm2Yahzgf3QjowJvQlHbSWzvGod/E6Fezzk
         0X0bSejdKxeitdObPy6k7mDYBGcdNy1TFsj6h/fclj2Bw+OWyHaVqqg4JnzI32vwUY99
         4AHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N98p0U+cHuyXVmhjuFaGftj4NomTav3ZwnLGwBYW7yk=;
        b=BihE7X+NuhTwa3j41bPl2CkX7IfrP7Hadpb4LRuHOXTMPuS+qFkjg/YhSNn8v+rNA6
         VXtiD1Y+tOU3PVAdzaNRApOEI0Alu9Uhz0fuIVeCz8PYkW8QRUqbpeHIoHT2MA9gi5w6
         iaTorDhBAbV0d4VDolmXnZNmJ9f3k7FNiKCrotjVXaYx/7t8nrXxqme9jqw9M2QT0hxb
         01aTIXl7Uq7PMcnX8K0ecI4iBFaE34NH2SSWAtiCrwiG8yNE4efXFprN1Okl6lPeU0Zc
         wBr6AUsgxdke8m1kfWQmNy5HDYUY8GzrQ937q/ebDQSRh26eSj21CDwOBgxc2ZyXcvks
         zvLA==
X-Gm-Message-State: AOAM531v3TMdQ7hFmi32Na5nG7s13bflx70MIhpNzZqhgw/tpzB6B6YO
        /xlgrkgB+YgxiSsm8nf2iRFOkg==
X-Google-Smtp-Source: ABdhPJzzNSODDIvlXa8P06ebtwjBqnQl/HjxcNxU1rynJ5c5rLBU3umOtzh7uYtHMhSocUjri0PydA==
X-Received: by 2002:a17:906:6696:: with SMTP id z22mr10810989ejo.322.1613298677773;
        Sun, 14 Feb 2021 02:31:17 -0800 (PST)
Received: from dellx1.cphwdc ([87.116.37.42])
        by smtp.googlemail.com with ESMTPSA id c18sm8180512edu.20.2021.02.14.02.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 02:31:17 -0800 (PST)
From:   "=?UTF-8?q?Matias=20Bj=C3=B8rling?=" <mb@lightnvm.io>
X-Google-Original-From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>
To:     axboe@kernel.dk, m@bjorling.me
Cc:     linux-block@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>
Subject: [PATCH 0/2] lightnvm pull request
Date:   Sun, 14 Feb 2021 10:31:01 +0000
Message-Id: <20210214103103.122312-1-matias.bjorling@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

A small PR for 5.12. Can you please pick them up when convenient.

Thank you, Matias

Andy Shevchenko (1):
  lightnvm: pblk: Replace guid_copy() with export_guid()/import_guid()

Tian Tao (1):
  lightnvm: fix unnecessary NULL check warnings

 drivers/lightnvm/pblk-core.c     | 5 ++---
 drivers/lightnvm/pblk-gc.c       | 3 +--
 drivers/lightnvm/pblk-recovery.c | 3 +--
 3 files changed, 4 insertions(+), 7 deletions(-)

--
2.25.1

