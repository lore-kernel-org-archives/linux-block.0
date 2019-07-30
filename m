Return-Path: <SRS0=ZBGg=V3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFC5C0650F
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 18:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6160208E4
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 18:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfG3ShC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:37:02 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40802 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfG3ShB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jul 2019 14:37:01 -0400
Received: by mail-pl1-f193.google.com with SMTP id a93so29180225pla.7
        for <linux-block@vger.kernel.org>; Tue, 30 Jul 2019 11:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u1+USCvVqRpxIIBrcb55PgoPHEQ9d97lDpESWa31i5M=;
        b=SEmigexUm+eZO93pxXLqv4OXU+hyhi5auDbtVVZJlECOY3ntLnLIuxYB7+meyHCPgd
         ZZz9r4SCQpXOIT97x7jVddcvV71XWm0ywBfTAfr+GYemAxshEt3PpAv1rxR0XPdzxaTA
         3NdtcooADsG0ct8VPbzUSUSNru8Oebkdu8wgBjIcRNbcvyJOAC8gDL8DRutsuo2ALA+C
         7WnrUsM+wSnax3SIORRRwD4oF3VxXK19+6ypJsx8R9pI6yPDaU4reA8hXaWDUkCrthxO
         7AT5SYHAdouQshVFkneKkPuSyCD6ExQytZreoJ/mHV41FsQpWJguYh2IYhVjvcL2OkEs
         2oQQ==
X-Gm-Message-State: APjAAAUBMf9rXScg9aX2zLG6+V9zU8MK+Ge6oZUiyBGGkRB0b5VpoIIf
        qdxcr1TBb0H67CEcVaXV+7M=
X-Google-Smtp-Source: APXvYqxpXlaEivOcb6S1ui7inOMjTb00jf+q3IxnWZ3sd/2IFnt7R2EmxFCnUS4p6p5JeENZJEbATQ==
X-Received: by 2002:a17:902:4c:: with SMTP id 70mr116117750pla.308.1564511821101;
        Tue, 30 Jul 2019 11:37:01 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id a128sm73759777pfb.185.2019.07.30.11.36.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:37:00 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 0/2] Fix a race condition triggered by submit_bio()
Date:   Tue, 30 Jul 2019 11:36:51 -0700
Message-Id: <20190730183653.253579-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

One of the consequences of the switch to blk-mq is that generic_make_request()
calls, a function called by submit_bio(), must be protected by a
blk_queue_enter() / blk_queue_exit() pair to avoid that the block-cgroup
functions called by generic_make_request() trigger a race condition. This patch
series makes the kernel report a warning if that race condition is hit and also
adds the necessary protection in submit_bio(). Please consider these patches
for kernel v5.4.

Thanks,

Bart.

Changes compared to v1:
- Use the full syzbot ID in patch 2/2 instead of abbreviating it.

Bart Van Assche (2):
  block: Verify whether blk_queue_enter() is used when necessary
  block: Fix a race condition in submit_bio()

 block/blk-cgroup.c         |  2 ++
 block/blk-core.c           | 34 +++++++++++++++++++++++++++++++++-
 include/linux/blk-cgroup.h |  2 ++
 include/linux/blkdev.h     |  8 ++++++++
 4 files changed, 45 insertions(+), 1 deletion(-)

-- 
2.22.0.709.g102302147b-goog

