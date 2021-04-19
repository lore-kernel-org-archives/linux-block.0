Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A9EC433ED
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 07:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E198761165
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 07:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237850AbhDSHiT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Apr 2021 03:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237752AbhDSHiS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Apr 2021 03:38:18 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33095C061760
        for <linux-block@vger.kernel.org>; Mon, 19 Apr 2021 00:37:49 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id e7so39338505edu.10
        for <linux-block@vger.kernel.org>; Mon, 19 Apr 2021 00:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pHRzqqI5vXzX/4lYsSu+Qi+BXY13UNPo3ubflkHZQ5c=;
        b=K1sl3AcAgaOFcrIicsdJfzgH8PjBDlnxa9VpvW2yT/YGZYbs8FY2K3dT/cT+qnYf7c
         qdVIHhLXtj0EN9k8IoJ3zCay1/k9CTOPsmabzwxYjJArPPNaQSPpvZYiUxgZQo45nCxm
         IUT/oUC1Vp9D48JF5zcPnVZHOCazddvljqkLfOiAROAoFmWhJYlZ/lBNAq6Ho0TZ5jgq
         X+R59f5Q/gPuK/Xu0SNfr4ZRWmM0LsvuwU3zDo8YxDyVU5EdnREipF9l5JdbnhuW3SSt
         Nkftytea2FUs7ipG2gutcpSaoOUpL/QyXP2a9Jw4jSQDhL7qQuQgoKBUBdzZkQjwEcAf
         JNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pHRzqqI5vXzX/4lYsSu+Qi+BXY13UNPo3ubflkHZQ5c=;
        b=fgJVhmJPxxcPSBEXttEc1y/0LByV+UEid9dBKdsleUfSaGEBA/12/d538IqQvpgSIl
         7wLvWM2S/uV9CfNBcCAhg+T6tfkbGptHJF87jy226iTMOSQ6UgTgbDmjIQThhNI1Ak2w
         Ua0dBvB/rfhAn05n052S26NEY2nyfRLgtanu8DzZ6y358ULIEc7ql2s1+RqxosiSF9Gd
         NMu238o+m1BKOw6O13Sn508FkMWY8i2EkD2zF7oijbVEBnPPH6Vb76C9A+N76jcBhX6M
         Q9Ipr2Iuc8kElRTPoVcWPieYtdC6fqhAkRQ4WMV3ySNdhbxn0edYA0J1jkod9aV0Zg1/
         LOHQ==
X-Gm-Message-State: AOAM533ED8SummybFdBjzjGv7Xe6sVn7MxwilB3cs09acLvSdeK5m4L8
        Ca0j7Kt6cETJkMIgHi0VWi8I1YWVoh5sOg==
X-Google-Smtp-Source: ABdhPJwfe/qvvTCs5kwyG+oj6rCnmMsEmdw9P7gA53tMyUeATgOMxrd14ctlPFyjZd8shvSwnKJnxA==
X-Received: by 2002:a05:6402:1393:: with SMTP id b19mr23731074edv.333.1618817867866;
        Mon, 19 Apr 2021 00:37:47 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id g22sm8701833ejz.46.2021.04.19.00.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 00:37:47 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     axboe@kernel.dk, akinobu.mita@gmail.com, corbet@lwn.net,
        hch@infradead.org, sagi@grimberg.me, bvanassche@acm.org,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv5 for-next 00/19] Misc update for rnbd
Date:   Mon, 19 Apr 2021 09:37:03 +0200
Message-Id: <20210419073722.15351-1-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This is the misc update for rnbd. It inlcudes:
- Change maintainer
- Change domain address of maintainers' email: from cloud.ionos.com to ionos.com
- Add polling IO mode and document update
- Fix memory leak and some bug detected by static code analysis tools
- Code refactoring

V5->V4 (requested by Leon)
- Replace snprintf with sysfs_emit
- Remove likely/unlikely
- Remove comments in the middle of function call

V4->V3
- Add "Acked-by Jason" to patches including changes for RTRS
- Add "Reviewed-by Chaitanya" to patches reviewed by Chaitanya
- Add "Acked-by Jack" to "Documentation/sysfs-block-rnbd: Add descriptions
for remap_device and resize"

V3->V2
- Exclude patches relevant the Fault-injection feature

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

Gioh Kim (8):
  Documentation/sysfs-block-rnbd: Add descriptions for remap_device and
    resize
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
 MAINTAINERS                                   |   4 +-
 drivers/block/rnbd/rnbd-clt-sysfs.c           |  84 ++++++---
 drivers/block/rnbd/rnbd-clt.c                 | 171 ++++++++++++------
 drivers/block/rnbd/rnbd-clt.h                 |   6 +-
 drivers/block/rnbd/rnbd-srv-sysfs.c           |   5 +-
 drivers/block/rnbd/rnbd-srv.c                 |  69 +++----
 drivers/block/rnbd/rnbd-srv.h                 |   3 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c        |  75 +++++---
 drivers/infiniband/ulp/rtrs/rtrs-clt.h        |   1 -
 drivers/infiniband/ulp/rtrs/rtrs-pri.h        |   1 +
 drivers/infiniband/ulp/rtrs/rtrs-srv.c        |   4 +-
 drivers/infiniband/ulp/rtrs/rtrs.h            |  13 +-
 14 files changed, 306 insertions(+), 161 deletions(-)

-- 
2.25.1

