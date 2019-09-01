Return-Path: <SRS0=xSfi=W4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AC5C3A5A7
	for <linux-block@archiver.kernel.org>; Sun,  1 Sep 2019 23:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD4621874
	for <linux-block@archiver.kernel.org>; Sun,  1 Sep 2019 23:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqg/I6iS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbfIAX16 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 1 Sep 2019 19:27:58 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37789 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728942AbfIAX16 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 1 Sep 2019 19:27:58 -0400
Received: by mail-qt1-f195.google.com with SMTP id y26so13922833qto.4;
        Sun, 01 Sep 2019 16:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y8jkqSuPFdPnoX723SsaKyeUfWimpBxUfbqYRxBxDds=;
        b=jqg/I6iShn3Fg6wz7IPpDO6qfKvnGjG2bs1mVk/ks7ZLF3YNdQogYTmen+Yv/ECfsl
         b26GM+tx2oAPQQvo+b1FMPNrgw1J7xxhgJgKQwq6KtPlqCYezstGNqjOTp3mCM6nsbSk
         TqxyskcQNRpZZlw5da9rfEzaWMIi6C9nB7mBDWAvNy4OKhCbENRIVmNRA2d6CFwi0lVT
         wxg0UO3LY2N3Q8EHT2bbkAagkD07yVaBp7qyQfSkP1AJOYJC9Mj6LM0RumhzWibkT2To
         xWA+YXl87CMnk7HXufPPy0qvmsTtNq9UFbUZZ81McQJxvPvLX6OoE57+leVxHK7hawwo
         9pGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y8jkqSuPFdPnoX723SsaKyeUfWimpBxUfbqYRxBxDds=;
        b=fx+pk/bQp+M0BT8poLkfWkP7ACOJTnr7W76SokEkxNgfpdt8J/8hBB9r/c1UUROlIV
         5bNk1ew9CHX4u9LbPNaOM1COdPuy5xbhioOcKCSr2V9lEB77D27CUCwimZJwFulF1wxn
         12QJSRDIpoOc8GHA9Ry4q2l2xYOn7ffiGt64sZMUGEmLtL6AEggw9zeTDB+c7nFgrJ+l
         DiMxt0cfFKC1URX1U0ikVwcxOUlnMWvS4cuYjDDAvJcDTyUDLVHT7sDhR4UK/zllsTtD
         zXYXjPoT6EdD6Axjyzm8xTEQi7TQK6jsAINfH1OPqDdN5cUz+tic33vxg/ODtI/5PtcF
         Cpsg==
X-Gm-Message-State: APjAAAUY1rPcoITNrlrwLjX7iNh6rC3s8rvNyeWdUbRpjzwa2sdHdH5m
        kPkQD/3ivtK4F6rJmClq9hqeVgUw
X-Google-Smtp-Source: APXvYqzco0F9EmfwZ/1kHDU11uj+Zergy+gM1PfzN4m+wpbd41/LhwlIA3Oie2Df8OwMN0E0BZ9Feg==
X-Received: by 2002:a0c:9c0e:: with SMTP id v14mr5422669qve.84.1567380477080;
        Sun, 01 Sep 2019 16:27:57 -0700 (PDT)
Received: from localhost.localdomain (200.146.53.87.dynamic.dialup.gvt.net.br. [200.146.53.87])
        by smtp.gmail.com with ESMTPSA id p59sm5684085qtd.75.2019.09.01.16.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2019 16:27:55 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: [PATCH v2 0/4] Remove elevator kernel parameter
Date:   Sun,  1 Sep 2019 20:29:12 -0300
Message-Id: <20190901232916.4692-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190828011930.29791-5-marcos.souza.org@gmail.com>
References: <20190828011930.29791-5-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since the last RESEND[1], I found that I used an old block/for-next to base my
changes. This version is just a rebase over
8ba64588ef2136ff7561fb2047d53debed8a7b56 ("Merge branch 'for-5.4/libata' into
for-next"), solving minor conflicts.

Original cover letter:
After the first patch sent[2], together with some background from Jens[3], this
patchset aims to remove completely elevator kernel parameter, since it is not
being used since blk-mq was set by default.

Along with elevator code, some documentation was also updated to remove elevator
references.

[1]: https://lkml.org/lkml/2019/8/27/1648
[2]: https://lkml.org/lkml/2019/7/12/1008
[3]: https://lkml.org/lkml/2019/7/13/232

Marcos Paulo de Souza (4):
  block: elevator.c: Remove now unused elevator= argument
  kernel-parameters.txt: Remove elevator argument
  Documenation: switching-sched: Remove notes about elevator argument
  Documentation:kernel-per-CPU-kthreads.txt: Remove reference to
    elevator=

 Documentation/admin-guide/kernel-parameters.txt    |  6 ------
 .../admin-guide/kernel-per-CPU-kthreads.rst        |  8 +++-----
 Documentation/block/switching-sched.rst            |  4 ----
 block/elevator.c                                   | 14 --------------
 4 files changed, 3 insertions(+), 29 deletions(-)

-- 
2.22.0

