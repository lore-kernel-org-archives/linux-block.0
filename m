Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D52C47089
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 01:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1239961378
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 01:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbhE0BDT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 May 2021 21:03:19 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:40673 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbhE0BDS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 May 2021 21:03:18 -0400
Received: by mail-pg1-f171.google.com with SMTP id j12so2409615pgh.7
        for <linux-block@vger.kernel.org>; Wed, 26 May 2021 18:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w8+CmbfF/52DaOmrlJTjLUbveP86RUru9c4rHXoDr0g=;
        b=arcdbOAcyMsHhPq3OCyLvl5TrsWC+2PjR2UAqWynSgdKnA3W8eTqIkqESl/f7IEhVe
         A3gEut887tbarsVVkPbTm0m9O55IX8uirF+QU5+cws3di79GmFOO9IAjUKg9Vb8/K9bM
         3qWvFHbnB9Xq6YnG2z5233bRlr+Y9EAcic46z2Xv20CZcis4E0JkQjpsglBq5q1znzhy
         M5ITB6zSm4cILetU2aYYfpeaidK7ikHIBwP6eHngNwubAeTf0xCZXiFJZoIuBpfkIuTL
         xWsoDkz2b+0AEA+P7fBghNXv+0JTULNmfz2aYt8ChMDQvnB1DnROSy1lGoSsKOkvdlvw
         wTuw==
X-Gm-Message-State: AOAM533QlMVaAeB71dHhFPYMiyqjyoY8e1dkS3eGmN1tu4ySNjJY/8xy
        qGLxvZRLPF+CRJIEHh4AAYYe2pukiWs=
X-Google-Smtp-Source: ABdhPJwrAKEO7/hpX/9yH9GJt07Z2k13lWwH1JQwbVxN0WVAE6KjZks02pznRWdGrNIP9psDLqWFNg==
X-Received: by 2002:a05:6a00:234f:b029:2c4:b8d6:843 with SMTP id j15-20020a056a00234fb02902c4b8d60843mr1162940pfj.71.1622077305406;
        Wed, 26 May 2021 18:01:45 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id j22sm310707pfd.215.2021.05.26.18.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 18:01:44 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <adam.manzanares@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/9] Improve I/O priority support
Date:   Wed, 26 May 2021 18:01:25 -0700
Message-Id: <20210527010134.32448-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

A feature that is missing from the Linux kernel for storage devices that
support I/O priorities is to set the I/O priority in requests involving page
cache writeback. Since the identity of the process that triggers page cache
writeback is not known in the writeback code, the priority set by ioprio_set()
is ignored. However, an I/O cgroup is associated with writeback requests
by certain filesystems. Hence this patch series that implements the following
changes for the mq-deadline scheduler:
* Make the I/O priority configurable per I/O cgroup.
* Change the I/O priority of requests to the lower of (request I/O priority,
  cgroup I/O priority).
* Introduce one queue per I/O priority in the mq-deadline scheduler.

Please consider this patch series for kernel v5.14.

Thanks,

Bart.

Bart Van Assche (9):
  block/mq-deadline: Add several comments
  block/mq-deadline: Add two lockdep_assert_held() statements
  block/mq-deadline: Remove two local variables
  block/mq-deadline: Rename dd_init_queue() and dd_exit_queue()
  block/mq-deadline: Improve compile-time argument checking
  block/mq-deadline: Reduce the read expiry time for non-rotational
    media
  block/mq-deadline: Reserve 25% of tags for synchronous requests
  block/mq-deadline: Add I/O priority support
  block/mq-deadline: Add cgroup support

 block/Kconfig.iosched      |   6 +
 block/Makefile             |   1 +
 block/mq-deadline-cgroup.c | 206 +++++++++++++++
 block/mq-deadline-cgroup.h |  73 ++++++
 block/mq-deadline.c        | 524 +++++++++++++++++++++++++++++--------
 5 files changed, 695 insertions(+), 115 deletions(-)
 create mode 100644 block/mq-deadline-cgroup.c
 create mode 100644 block/mq-deadline-cgroup.h

