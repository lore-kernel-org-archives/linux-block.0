Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74705C433E0
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 07:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CB4761957
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 07:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhC3HiD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Mar 2021 03:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhC3Hh6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 03:37:58 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52F0C061762
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 00:37:57 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ce10so23337669ejb.6
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 00:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SpCsfsh5k4XDGQoyhZbcRXga5RIB1LROTe/1Fl1GftQ=;
        b=SXIqfezlT2jLed6NVR4JyPQUPR3dmHxHAtY1jDw7OSs5ydMrf8Kl3H6xHZSoRKNCb8
         y/lpfqgtWE7Vp47V22vBVO57YYV1oPD+6MRz1TGuXqOldws4zt6XYTaBEkEgTe1920H7
         +j9TR4PUCny1mD+84duyDHKqxYrjDLTjPmQD4xVZwvAm9ezXrDS0KH9C6vAABbDOUsgR
         oF2Ud1GYXf8iqVb9XNw4vMsh8sLi3caJF4q75k1unxX+MbTXD732BgJ8vOHrIRyHLlkD
         8d1DnMG4KVhzhYXvt7hGbcS5Xr1ptyq4pT/74C6hyVWbbULpITNiQ0BvajhC8z9wNlhb
         Fucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SpCsfsh5k4XDGQoyhZbcRXga5RIB1LROTe/1Fl1GftQ=;
        b=q1rkDtQN9sdnSaHpy1Merw5SkpfS4jEMYDv0DP5NlhUxVi/P9R57x3KEurrwRmhYY/
         Nq1QAi/OsSYwD6RjxhxcCVMawHcU6XcPOkXNVUXR3/3J8kRwnvFtsOvrVZ9sn/Oi53tq
         DFFdUA45iIvlIla6sdEWoRgFrgFk6fAdxksfjhvcl0f99A6JDVueW8iqcq95FgHA4EwI
         x/bCh/Z0wogz6pFOBqSkJ40jLa+nQ3Y4qNzex7KLomE9DEW530tx7GLbKqDy9MKX68t6
         P6ECx3YSnGx2x+D65iFMeDaHTpWKNX3peNURqClJAk2D8yMkNM7+mMbZDrx7+nF+yxtf
         +ozw==
X-Gm-Message-State: AOAM530hjgQ/O1puGT/7H6pXTSQJsHOFJQLeTPpplq+qu37mMdNdII46
        Y2VSCE0o5oDDLzA6voeYKS6VAJGMwjhfvQ==
X-Google-Smtp-Source: ABdhPJwSHEINxW24tbPb4+jZz6CQWnhrS8I9kjoHL21aj2zxGpksrxTrFK1NU10rcHXW+vkJhIxlpg==
X-Received: by 2002:a17:907:204c:: with SMTP id pg12mr21625380ejb.225.1617089876474;
        Tue, 30 Mar 2021 00:37:56 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id a3sm9556180ejv.40.2021.03.30.00.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 00:37:56 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 00/24] Misc update for rnbd
Date:   Tue, 30 Mar 2021 09:37:28 +0200
Message-Id: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is the misc update for rnbd. It inlcudes:
- Change maintainer
- Change domain address of maintainers' email: from cloud.ionos.com to ionos.com
- Add polling IO mode and document update
- Add some fault-injection points and document update
- Fix memory leak and some bug detected by static code analysis tools
- Code refactoring

V2->V1
- Change the title: for-rc -> for-next
- Remove unnecessary (void) casting requested by Leon

Best regards

Danil Kipnis (1):
  MAINTAINERS: Change maintainer for rnbd module

Dima Stepanov (2):
  block/rnbd-clt-sysfs: Remove copy buffer overlap in
    rnbd_clt_get_path_name
  block/rnbd: Use strscpy instead of strlcpy

Gioh Kim (13):
  Documentation/sysfs-block-rnbd: Add descriptions for remap_device and
    resize
  block/rnbd: Enable the fault-injection
  block/rnbd-srv: Inject a fault at bio processing
  block/rnbd-clt: Inject some fault points
  docs: fault-injection: Add fault-injection manual of RNBD
  docs: Add RTRS/RNBD to the index of fault-injection
  block/rnbd-clt: Replace {NO_WAIT,WAIT} with RTRS_PERMIT_{WAIT,NOWAIT}
  block/rnbd-srv: Prevent a deadlock generated by accessing sysfs in
    parallel
  block/rnbd-srv: Remove force_close file after holding a lock
  block/rnbd-clt: Fix missing a memory free when unloading the module
  block/rnbd-clt: Support polling mode for IO latency optimization
  Documentation/ABI/rnbd-clt: Add description for nr_poll_queues
  block/rnbd-srv: Remove unused arguments of rnbd_srv_rdma_ev

Guoqing Jiang (5):
  block/rnbd-clt: Remove some arguments from
    insert_dev_if_not_exists_devpath
  block/rnbd-clt: Remove some arguments from rnbd_client_setup_device
  block/rnbd-clt: Move add_disk(dev->gd) to rnbd_clt_setup_gen_disk
  block/rnbd: Kill rnbd_clt_destroy_default_group
  block/rnbd: Kill destroy_device_cb

Jack Wang (1):
  block/rnbd-clt: Remove max_segment_size

Md Haris Iqbal (1):
  block/rnbd-clt: Generate kobject_uevent when the rnbd device state
    changes

Tom Rix (1):
  block/rnbd-clt: Improve find_or_create_sess() return check

 Documentation/ABI/testing/sysfs-block-rnbd    |  18 ++
 .../ABI/testing/sysfs-class-rnbd-client       |  13 ++
 Documentation/fault-injection/index.rst       |   2 +
 .../fault-injection/rnbd-fault-injection.rst  | 208 ++++++++++++++++++
 MAINTAINERS                                   |   4 +-
 drivers/block/rnbd/rnbd-clt-sysfs.c           | 138 +++++++++---
 drivers/block/rnbd/rnbd-clt.c                 | 184 +++++++++++-----
 drivers/block/rnbd/rnbd-clt.h                 |  21 +-
 drivers/block/rnbd/rnbd-common.c              |  44 ++++
 drivers/block/rnbd/rnbd-proto.h               |  14 ++
 drivers/block/rnbd/rnbd-srv-sysfs.c           |  41 +++-
 drivers/block/rnbd/rnbd-srv.c                 |  76 +++----
 drivers/block/rnbd/rnbd-srv.h                 |  16 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c        |  75 +++++--
 drivers/infiniband/ulp/rtrs/rtrs-clt.h        |   1 -
 drivers/infiniband/ulp/rtrs/rtrs-pri.h        |   1 +
 drivers/infiniband/ulp/rtrs/rtrs-srv.c        |   4 +-
 drivers/infiniband/ulp/rtrs/rtrs.h            |  13 +-
 18 files changed, 712 insertions(+), 161 deletions(-)
 create mode 100644 Documentation/fault-injection/rnbd-fault-injection.rst

-- 
2.25.1

