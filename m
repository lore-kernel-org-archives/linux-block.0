Return-Path: <SRS0=hu+R=VT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B21BC7618F
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 17:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F002190F
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 17:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbfGVRMU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:12:20 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:41940 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbfGVRMU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 13:12:20 -0400
Received: by mail-pf1-f174.google.com with SMTP id m30so17689440pff.8
        for <linux-block@vger.kernel.org>; Mon, 22 Jul 2019 10:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uyKDs1QdWAzB62QtMRuVc8ziKXaswrTtWOV7lN03S7U=;
        b=rQxLaf5PIwtZK8+GOhezLmvuHpKcUk1q3UzhiTcoU+nrsvP629XU1NO8YUBZP7C7VQ
         LzjIxTMpinmowWfT9R86eqLVabe5yutqGJ37lvM539TiVujbwI32wyJxiHg8t7UezE8b
         kdQzU7yWil3b5+Qh7QDUVilVGFCYrFqfhxO70Kt8YDmMLxPq6ijzdIkOvgMOycMxcdhy
         uL7KFZuzUHKnsyc8Nelk4Xromr9k+IE+oXZI06tyCMSaUQSrsko8HvRJ4JQWpwZ2kvk0
         Q+JcYu8kGgFqH9AZZLBKGgVF2FnQFOrmHLR3KcVWKQeN0M7j1KxOUuV/uBxLLfcQ0HzX
         u3AA==
X-Gm-Message-State: APjAAAXqLkG/VSIFr/J9poRN7yIGrO6D3xNA4QbTtQo7vdnCPdSw3C4z
        ojON9UraRLtTjSsZ7JUeQ+4=
X-Google-Smtp-Source: APXvYqxYK+T3dyiAbDQ4opkiGw7vyvdTorANqRf3FquFuyUYUEpgdm/ppNEFd8y6rmxkcrWAXAIlDQ==
X-Received: by 2002:a63:c44c:: with SMTP id m12mr34204660pgg.396.1563815539395;
        Mon, 22 Jul 2019 10:12:19 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id t26sm31196528pgu.43.2019.07.22.10.12.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 10:12:18 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/5] Optimize bio splitting
Date:   Mon, 22 Jul 2019 10:12:05 -0700
Message-Id: <20190722171210.149443-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This patch series improves bio splitting in several ways:
- Reduce the number of CPU cycles spent in bio splitting code.
- Make the bio splittig code easier to read.
- Optimize alignment of split bios.

Please consider this patch series for kernel v5.4.

Thanks,

Bart.

Bart Van Assche (5):
  block: Declare several function pointer arguments 'const'
  block: Document the bio splitting functions
  block: Micro-optimize bvec_split_segs()
  block: Simplify blk_bio_segment_split()
  block: Improve physical block alignment of split bios

 block/bio.c            |   4 +-
 block/blk-merge.c      | 151 ++++++++++++++++++++++++++++-------------
 include/linux/blkdev.h |  32 ++++-----
 3 files changed, 120 insertions(+), 67 deletions(-)

-- 
2.22.0.657.g960e92d24f-goog

