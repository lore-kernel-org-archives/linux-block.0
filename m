Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBE7C2B9F4
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 00:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF31A613BD
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 00:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbhFRArN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jun 2021 20:47:13 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:44728 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbhFRArN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jun 2021 20:47:13 -0400
Received: by mail-pl1-f181.google.com with SMTP id x22so2271855pll.11
        for <linux-block@vger.kernel.org>; Thu, 17 Jun 2021 17:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=asCXYMpTL2TPvjrAJY6dwYJXl4/rhc3YG8y2UZKPA/c=;
        b=NxwNYBr6TiPC4JuHXC0JXkr3qzHtWeIOSPP3sOXTu+gEm7Htihs9LqFDS+vNP5Un3o
         1atHaF7SDu+Me9apV/HGdVMgUuxQDeo7n7FkQAYVvJ4/wL2Ly2Z+MUXxF4pvLiW1ctJp
         DrNZXXuij7I0OFtGp+GNImnhFQ7do4+LbAZPeeMqzDy5hmrumIW36nAW6fvfIQEVxzWY
         PgdKyYweZzaNzsjbA69d6B5WRbKOKJzs5US3/mueqJ9+2WAleKsJSyh37xlUGlytyd6p
         pu+Wnrtdc/QTv6jj8OUufITbAlDzJQBuTKkrfg+B6goaMkrYWIfKkRz7K8Pwc5ORnF4I
         Zzmw==
X-Gm-Message-State: AOAM533sJobMVaTz7I/e1dXdF62F7RNmCSeRf7z726xkxVFU9nTxZVrQ
        CZS+za254xTzz0uQmwrsC/k=
X-Google-Smtp-Source: ABdhPJyet+4gI4pnVezlwHnyiblpoOvx8t+PDFEnzgnISPFKXRz5qzpnU0F1RtRCO/oQ9VbxPhpPug==
X-Received: by 2002:a17:90a:1d0a:: with SMTP id c10mr7371732pjd.39.1623977103427;
        Thu, 17 Jun 2021 17:45:03 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id b10sm6215573pff.14.2021.06.17.17.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 17:45:02 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 00/16] Improve I/O priority support
Date:   Thu, 17 Jun 2021 17:44:40 -0700
Message-Id: <20210618004456.7280-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0
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

Changes compared to v2:
- For the blk-ioprio rq-qos policy, switched from numeric to textual policy
  names.
- Moved rq_qos_id_to_name() into debugfs code.
- Moved the mq-deadline I/O statistics into io.stat.
- Introduced the dd_per_prio data structure.
- Switched from a single sort list to one sort list per I/O priority.
- Removed the WARN_ON_ONCE(blkcg == NULL) statements.

Changes compared to v1:
- Moved the code for assigning an I/O priority into a new rq-qos policy.
- Dropped patch "block/mq-deadline: Reduce the read expiry time for
  non-rotational media".
- Made sure that dd->async_depth >= 1.
- Implemented an aging mechanism such that lower priority requests are not
  postponed forever.

Bart Van Assche (16):
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
  block/mq-deadline: Micro-optimize the batching algorithm
  block/mq-deadline: Add I/O priority support
  block/mq-deadline: Track I/O statistics
  block/mq-deadline: Add cgroup support
  block/mq-deadline: Prioritize high-priority requests

 Documentation/admin-guide/cgroup-v2.rst |   55 ++
 block/Kconfig                           |   19 +-
 block/Kconfig.iosched                   |    6 +
 block/Makefile                          |    3 +
 block/blk-cgroup.c                      |   14 +-
 block/blk-ioprio.c                      |  262 +++++
 block/blk-ioprio.h                      |   19 +
 block/blk-mq-debugfs.c                  |   15 +
 block/blk-rq-qos.h                      |   14 +-
 block/mq-deadline-cgroup.c              |  126 +++
 block/mq-deadline-cgroup.h              |  114 +++
 block/mq-deadline-main.c                | 1173 +++++++++++++++++++++++
 block/mq-deadline.c                     |  815 ----------------
 13 files changed, 1797 insertions(+), 838 deletions(-)
 create mode 100644 block/blk-ioprio.c
 create mode 100644 block/blk-ioprio.h
 create mode 100644 block/mq-deadline-cgroup.c
 create mode 100644 block/mq-deadline-cgroup.h
 create mode 100644 block/mq-deadline-main.c
 delete mode 100644 block/mq-deadline.c

