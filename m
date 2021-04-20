Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44421C43461
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 11:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC0F2613AF
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 11:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbhDTLVC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Apr 2021 07:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbhDTLVA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Apr 2021 07:21:00 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0041AC06174A;
        Tue, 20 Apr 2021 04:20:27 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id y22-20020a17090a8b16b0290150ae1a6d2bso3344579pjn.0;
        Tue, 20 Apr 2021 04:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ofHxaRyyKpRDMdCVSjRvb7ZTVTofpXbk5m17HljUXic=;
        b=OEvo5MITFasPABJapUuyfWnQdo/V2Wf6fwYvJHJBl1PtU/eGlrJsb8Vjrixcf/sYo7
         r7gZiBpKTaZlFPFVrM+2D96T2DYDpufXeV5A5QzQl18uaPGzvvhTXWHl9VtT9grE/GZR
         ayca1Rpc5H8pyTrU04flakJR8W1ViImKvcfSS1DrNo0GruJATKuvkED7l7R70015EZWI
         JqGJFE6/hpeYO3zasasSWy9SmfvBBzHns1PCE3pQIcCt3Qa6ZeNhGPtpdfFumtClUWra
         me6nvB10uTHI12LlRq49H1KHYFjfxIZ5uSujUYngbcFbf2T5cftwdERxKGMcT8lxGODz
         kivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ofHxaRyyKpRDMdCVSjRvb7ZTVTofpXbk5m17HljUXic=;
        b=NG9XwZ6CjbZ4KqoioaVRTZRUP/P68041699taD6SUW5+a+L+0avJk6TIuTGsTPiP2Z
         D4cW1RGBhxO+PwLMwAAtmiTYxm8jPU3GSvt3h5fV5C2GKpWfxuz4j+6DUA6fo6BHkIha
         84pJcSkRcyKMwmFDM3Ji3ifTZsx11M7YcK8tV8yHVDtaoSitKUc4pYnpgxhMEIzwJLAD
         ArwwcwwB1qN3djsE2aMmVZRr2yJSskB6J1Lid8NiJRw8xDKufmVe6GRedSR1z+udBc7P
         G9xCR2ihHNO3NJUcHOmXxYZmsVvTASBY19543n3trC2PXJx/7kQJdfvvZcNGFTd4CwxQ
         I12g==
X-Gm-Message-State: AOAM532HDzI07k4BEj4FAoh+mRzJYrjt6oO9aIUVGzfC/i5xBL1ZPsp+
        QZ8ByKbMeTVZbmR/xDFESfKR9sLN+tnU0w==
X-Google-Smtp-Source: ABdhPJx23shqacMRY+QjbJAkD8rdboIts8cLDY3UKjrU6UZARYlnIjb92ywDxlcJRX2IP+7Z58Lw2g==
X-Received: by 2002:a17:90a:df81:: with SMTP id p1mr4547188pjv.22.1618917627598;
        Tue, 20 Apr 2021 04:20:27 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id s40sm14187367pfw.100.2021.04.20.04.20.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Apr 2021 04:20:27 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] bfq: misc updates
Date:   Tue, 20 Apr 2021 19:20:17 +0800
Message-Id: <cover.1618916839.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Some misc updates, put together mainly to facilitate patch management.

Chunguang Xu (8):
  bfq: introduce bfq_entity_to_bfqg helper method
  bfq: convert the type of bfq_group.bfqd to bfq_data*
  bfq: limit the IO depth of CLASS_IDLE to 1
  bfq: keep the minimun bandwidth for CLASS_BE
  bfq: remove unnecessary initialization logic
  bfq: optimize the calculation of bfq_weight_to_ioprio()
  bfq: reset entity->prio_changed in bfq_init_entity()
  bfq: remove unnecessary BFQ_DEFAULT_GRP_IOPRIO

 block/bfq-cgroup.c  | 13 +++-----
 block/bfq-iosched.c | 17 +++++++++--
 block/bfq-iosched.h | 15 ++++++----
 block/bfq-wf2q.c    | 86 +++++++++++++++++++++++++++++++++++++----------------
 4 files changed, 88 insertions(+), 43 deletions(-)

-- 
1.8.3.1

