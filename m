Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10CBC169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 11:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 721062085B
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 11:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WbkUwJCR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfA2LG7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:06:59 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:55529 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfA2LG7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 06:06:59 -0500
Received: by mail-wm1-f54.google.com with SMTP id y139so17189699wmc.5
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 03:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OBnFM/XIhxHzbGT5UAJB0ZZJxNSlY59fz6h2Eg7eW9s=;
        b=WbkUwJCRmIH2RfhYlxhHjEZMgD213VXH6j5eQaVHYKUzwrZt29oXELYLSLASO06+56
         mmM01lH/T1qqTcCbluQCqB5kBkpVSbOMNFDiV7Lurj0KUPeLhKEdbWDa9B3nnEBSMTev
         sjJO25qarnzm7ERth6KwqVP9BuV7GKVxyOEeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OBnFM/XIhxHzbGT5UAJB0ZZJxNSlY59fz6h2Eg7eW9s=;
        b=KItLHCORg0ulS+gnhw+BJVqMicZ8OcxjLQZomBSLC6YA93sZ+8EcvHgrEW5UInB11T
         /b9NOEMuozLv21/8dVY8IirFZLreGycXnEIQKwLA9eJMFeuqdtL/vfnqvfFGcwvaWENR
         67Azwwgi5hNBgVZDE9BtG9QcKw4mrUtX/PtFKiX+GNLbESz4PC1o67Fhg8ILSKSQIfh2
         uuZs2i3TZ3iPfb5MUbQQdeEwg5+8mhOFkVELrh8G+0lXvzRoXxMPQEtvMvXFRalje6HK
         Ey/38OKt1Cw5Oq8NRm7DfLSduoZXXYmDMCJ0+b/wA5YYQsnw2wotae+paOQdau3Q38eP
         QgQw==
X-Gm-Message-State: AJcUukcGe+4CpQ+0nUO7t92jRxtKKd/EGWCCOEw/AZZoHSReUA8ZHe3q
        U9mFY3/J9UpzLvG7EBEvffh1WQ==
X-Google-Smtp-Source: ALg8bN4lLwEl1ng2GOYJ0HTZl/6RwcB+VKWXQCabKAP527Am8ZVwbqpubISiLRtpJzQ6P1MQToTpJQ==
X-Received: by 2002:a1c:e913:: with SMTP id q19mr21170180wmc.55.1548760017135;
        Tue, 29 Jan 2019 03:06:57 -0800 (PST)
Received: from localhost.localdomain ([88.147.67.218])
        by smtp.gmail.com with ESMTPSA id s132sm2066112wmf.28.2019.01.29.03.06.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 03:06:56 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, mancha@tower-research.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT 00/14] batch of patches for next linux release
Date:   Tue, 29 Jan 2019 12:06:24 +0100
Message-Id: <20190129110638.12652-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
this batch of patches provides fixes and improvements for throughput
and latency. Every patch has been under test for at least one month,
some patches for much longer.

Thanks,
Paolo

Paolo Valente (14):
  block, bfq: do not consider interactive queues in srt filtering
  block, bfq: avoid selecting a queue w/o budget
  block, bfq: make sure queue budgets are not below service received
  block, bfq: remove case of redirected bic from insert_request
  block, bfq: consider also ioprio classes in symmetry detection
  block, bfq: split function bfq_better_to_idle
  block, bfq: do not plug I/O of in-service queue when harmful
  block, bfq: unconditionally plug I/O in asymmetric scenarios
  block, bfq: fix sequential rq detection in rate estimation
  block, bfq: fix queue removal from weights tree
  block, bfq: reduce threshold for detecting command queueing
  block, bfq: port commit "cfq-iosched: improve hw_tag detection"
  block, bfq: do not overcharge writes in asymmetric scenarios
  block, bfq: fix in-service-queue check for queue merging

 block/bfq-iosched.c | 705 ++++++++++++++++++++++++--------------------
 block/bfq-iosched.h |  11 +-
 block/bfq-wf2q.c    |  18 +-
 3 files changed, 400 insertions(+), 334 deletions(-)

--
2.20.1
