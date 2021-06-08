Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2242C4743F
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 23:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDB4061364
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 23:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbhFHXJV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 19:09:21 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:33437 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbhFHXJV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jun 2021 19:09:21 -0400
Received: by mail-pl1-f173.google.com with SMTP id c13so11552793plz.0
        for <linux-block@vger.kernel.org>; Tue, 08 Jun 2021 16:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tRjrEidGl23yhhcEuC+2wWhOTmPFon1hJ07p0nAC1Ww=;
        b=JsKH2doV3aOZoySTP86ir4g0Zr8YmnkwJYMGH3F0V98Epcm/MFjnR8g3oj4TIrACB1
         k6cfkMRr4AmDFAT5goOPHCbDkU079KgSlIBbfa4D9avlL9KrCGwlo4pagzGan2F9VNJ5
         3XAbzMWaayYmrGHWlH/FcK05DOud+nKdLFWAs+dw8Ym4iCq5lZx1lmwL/cQ+IhMHuV5R
         g3EWFRONlkXbCcEb/AT1+Ob+7BZMDoESFMniROkBVPwqX6Fd1z9O/Lif0fMLzGj1Lu24
         Q/m4zBWrwkcqy9Pt7LHIEBo7reGNtzmDfRhTZAQ2qHXaPi/vm38Ggf4/Ap8TdvNX3ZTV
         PqfQ==
X-Gm-Message-State: AOAM532aUGeJhuq4rKU18rwk3vM+edeucDHfHDm8x8erSHe0IsOj/S1A
        aSRNN1sE7bYdjobj8nF8UaKBn9BNHew=
X-Google-Smtp-Source: ABdhPJzDgLhZcT9FYV1PtRpX8K2ojKJktMeFd1YKKd/VtdbZuN8ETfKbxwhNS/O0cyFX5zjvCUeYHA==
X-Received: by 2002:a17:902:db0f:b029:f3:e5f4:87f1 with SMTP id m15-20020a170902db0fb02900f3e5f487f1mr2060294plx.26.1623193631060;
        Tue, 08 Jun 2021 16:07:11 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id s21sm11395838pfw.57.2021.06.08.16.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 16:07:10 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 00/14] Improve I/O priority support
Date:   Tue,  8 Jun 2021 16:06:49 -0700
Message-Id: <20210608230703.19510-1-bvanassche@acm.org>
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
changes:
* Add an rq-qos policy that makes the I/O priority configurable per I/O cgroup
  and also that changes the I/O priority of requests to the lower of (request
  I/O priority, cgroup I/O priority).
* Introduce one queue per I/O priority in the mq-deadline scheduler.
* Dispatch the highest priority requests first.

Please consider this patch series for kernel v5.14.

Thanks,

Bart.

Changes compared to v1:
- Moved the code for assigning an I/O priority into a new rq-qos policy.
- Dropped patch "block/mq-deadline: Reduce the read expiry time for
  non-rotational media".
- Made sure that dd->async_depth >= 1.
- Implemented an aging mechanism such that lower priority requests are not
  postponed forever.

Bart Van Assche (14):
  block/Kconfig: Make the BLK_WBT and BLK_WBT_MQ entries consecutive
  block/blk-cgroup: Swap the blk_throtl_init() and blk_iolatency_init()
    calls
  block/blk-rq-qos: Move a function from a header file into a C file
  block: Introduce the ioprio rq-qos policy
  block/mq-deadline: Add several comments
  block/mq-deadline: Add two lockdep_assert_held() statements
  block/mq-deadline: Remove two local variables
  block/mq-deadline: Rename dd_init_queue() and dd_exit_queue()
  block/mq-deadline: Improve compile-time argument checking
  block/mq-deadline: Improve the sysfs show and store macros
  block/mq-deadline: Reserve 25% of scheduler tags for synchronous
    requests
  block/mq-deadline: Add I/O priority support
  block/mq-deadline: Add cgroup support
  block/mq-deadline: Prioritize high-priority requests

 Documentation/admin-guide/cgroup-v2.rst |   26 +
 block/Kconfig                           |   19 +-
 block/Kconfig.iosched                   |    6 +
 block/Makefile                          |    3 +
 block/blk-cgroup.c                      |   14 +-
 block/blk-ioprio.c                      |  236 +++++
 block/blk-ioprio.h                      |   19 +
 block/blk-rq-qos.c                      |   15 +
 block/blk-rq-qos.h                      |   14 +-
 block/mq-deadline-cgroup.c              |  185 ++++
 block/mq-deadline-cgroup.h              |  112 +++
 block/mq-deadline-main.c                | 1171 +++++++++++++++++++++++
 block/mq-deadline.c                     |  815 ----------------
 13 files changed, 1798 insertions(+), 837 deletions(-)
 create mode 100644 block/blk-ioprio.c
 create mode 100644 block/blk-ioprio.h
 create mode 100644 block/mq-deadline-cgroup.c
 create mode 100644 block/mq-deadline-cgroup.h
 create mode 100644 block/mq-deadline-main.c
 delete mode 100644 block/mq-deadline.c

