Return-Path: <SRS0=ouS0=TC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982EEC43219
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 01:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 592022054F
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 01:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vHjRwZ6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfEBB5n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 21:57:43 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36563 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfEBB5n (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 21:57:43 -0400
Received: by mail-qt1-f193.google.com with SMTP id c35so788585qtk.3
        for <linux-block@vger.kernel.org>; Wed, 01 May 2019 18:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=quWrNR4eWwFTXTRzoPl4zkE3Mt6EDDpvyYkXqmbNd+4=;
        b=vHjRwZ6Vc0SpGUcKNCF6tvYyUFZbhrUPtrQa61gfXE15tHPFXJE44I2zYD38PDZcob
         KEjszwFhhLbSoBlgQVt61OM1U91bdC6j3ltG1aMzEZSwDnaLO01bxPQa2Nu8q3IEBIEN
         HcNm0tHKtIF9O4zhty689z/Nv8QyxpxercwGxY7iarHERBtV7HmZ4I/eqUIlpduP+AFZ
         oCaXzajtEHUiAvmq65/4uooVcqq+i4kba5TFH8QiGneinr/rpT5EGCmP5gGpWh/PGjqQ
         T+8qoVoSHiVmyp66f4b/9NMdCvmPV/gu3EIwic2rTJmv4hpt2pud0KuK7WCww3uZkk0S
         A0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=quWrNR4eWwFTXTRzoPl4zkE3Mt6EDDpvyYkXqmbNd+4=;
        b=FCDthPBn8I2+Z7k7bQw47mwh3pOjT02M+0TZagTvEzwDfeF/hfT6b8RH1dQbM6G9Kp
         Ym3Bo75VcZu+HhBa7jUX40xUdl946rE0yiOOgLUuAKY6h+OUr7skxa4h78gvtDfjoPLT
         45Ygx7Ofq59Cq/pJHZz5tbABnSTnuP1bL/VJByctqNLHmJJXE9KjLzP/s+uplc0JqcBC
         KdqKXPNMNZV0rZ7gOAdiaQVnmRYFwP0G5+rb6Z/as56SO18r5uf8PpbYCqjFtdj91Na6
         xa3tdBEu3gufdd7EbV/9ft1SYSj760I3B8cfwYWZcibYEcCj6HhUNFfWg+9E/p1QDarP
         Wyxw==
X-Gm-Message-State: APjAAAXTT83nBlLkyf6WrBbtH86DxQPD46gTeCUrqvuO5wNr8Wc+ljSZ
        FhG4WFrHd/9BU4WI81Sn/BXOk4vEavU=
X-Google-Smtp-Source: APXvYqy+dEcAVPwdg88VF8Lp6tTT5oBFEBR6FCa34CH2LsbEeuOlSepOingzriXqyCUzjqQxqTcbaQ==
X-Received: by 2002:ac8:7506:: with SMTP id u6mr1057914qtq.331.1556762262144;
        Wed, 01 May 2019 18:57:42 -0700 (PDT)
Received: from localhost.localdomain (189.26.185.89.dynamic.adsl.gvt.net.br. [189.26.185.89])
        by smtp.gmail.com with ESMTPSA id d55sm9031059qtb.59.2019.05.01.18.57.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 18:57:40 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: [PATCH v2 0/2] Introduce bytes_to_sectors helper in blkdev.h
Date:   Wed,  1 May 2019 22:57:26 -0300
Message-Id: <20190502015728.71468-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Changes from v2:
Rename size_to_sectors o bytes_to_sectors. (suggested by Martin K. Petersen)

Changes from v1:
Reworked the documentation of size_to_sectors by removing a sentence that was
explaining the size -> sectors math, which wasn't necessary given the
description prior to the example. (suggested by Chaitanya Kulkarni)

Let me know if you have more suggestions to this code.

Here is the cover letter of the RFC sent prior to this patchset:

While reading code of drivers/block, I was curious about the set_capacity
argument, always shifting the value by 9, and so I took me a while to realize
this is done on purpose: the capacity is the number of sectors of 512 bytes
related to the storage space.

Rather the shifting by 9, there are other places where the value if shifted by
SECTOR_SHIFT, which is more readable.
This patch aims to reduce these differences by adding a new function called
bytes_to_sectors, adding a proper comment explaining why this is needed.

null_blk was changed to use this new function.

Thanks,
Marco

Marcos Paulo de Souza (2):
  blkdev.h: Introduce bytes_to_sectors helper function
  null_blk: Make use of bytes_to_sectors helper

 drivers/block/null_blk_main.c | 18 +++++++++---------
 include/linux/blkdev.h        | 17 +++++++++++++++++
 2 files changed, 26 insertions(+), 9 deletions(-)

-- 
2.16.4

