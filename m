Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DC1C433DB
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 15:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF48961A16
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 15:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhCYP3y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 11:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhCYP3n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 11:29:43 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24314C06174A
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 08:29:42 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id jy13so3620480ejc.2
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 08:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sCn7AN/n/Avrv20DRDeXNTIuV39yqYHfUMIlSjIbMEg=;
        b=Kp8xgK178LtMqYkAKY6d+MGcS80zvoitmZ0Q8Gep01huBuL7mXgD3zL84w7ezHhCeD
         V6+ZFwR43hx7dGWvB3WlXDdOVQ09cQfJcR8ib5usBg+gdQpOrB6aakRf2JX3J6jKJKke
         A5NxamCwu6pQ8YbVdduxSHWNkPxHHa8OLXKjGs7l3uoV5WTyMGE4FySfwQDAJoAYw/Se
         RXXXxsj4c5hND6AayfCIeiZRkrfo3OyVzGCSiJ5EYI1orgHE5l6bJPzV2lxZpCzIg77k
         bEA3T+V+BKWBJuV1HosbmP67GPZLUqepT8VN116hyTX6v3wqHUXiFrfwG8Unq36mTiQY
         Q/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sCn7AN/n/Avrv20DRDeXNTIuV39yqYHfUMIlSjIbMEg=;
        b=TMcqJpwcshhHXt1XzKpysr+dcSWxgHex/xvC8u8G/GOOs9N0pThoKpvfIVjhtSa2Cs
         aT41QNeOfFsO0VxWnZc6nr7fxdYYBNY6BDnAaX1gMeHKHoAyDGamyNfJXZy6JH3fIjdA
         J41ySIrUyfOEqJkgeW8mk2YBtiJImBRIruvSg56yagMFsRq0uKg6WeZ5TLj7ZY5KwpLG
         Nl6RU+HGgYpzWDJqTLTdzwp9t2wEbIuND/HQMxPk/4tUEZYt1ENbwyaVCwZE3/4XR5sG
         AwmF/Qj2kJf+dYyxVx2uNJSQLF3h1RHpIsiqgpnQtJerGpab3S2P+9qEbJ3Hefq6oclr
         12Uw==
X-Gm-Message-State: AOAM5302AOKz6OwbiLHIfuDv6HTuyIubxHj73wb7brnOEXjSa2ex4mxi
        vR6LjTrMaALElNpGfLUb+vcdhqOuUHRslQ==
X-Google-Smtp-Source: ABdhPJwaEC/71lyxNRKzUar45HvejJQRlXSsJ1ETnIw4bJokZplFgmxGg5cZk4CxcZWc2wl5bJ/G7A==
X-Received: by 2002:a17:906:5d05:: with SMTP id g5mr10008783ejt.489.1616686180686;
        Thu, 25 Mar 2021 08:29:40 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id b18sm2574837ejb.77.2021.03.25.08.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:29:40 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-rc 00/24] Misc update for rnbd
Date:   Thu, 25 Mar 2021 16:28:47 +0100
Message-Id: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This is the misc update for rnbd. It inlcudes:
- Change maintainer
- Change domain address of maintainers' email: from cloud.ionos.com to ionos.com
- Add polling IO mode and document update
- Add some fault-injection points and document update
- Fix memory leak and some bug detected by static code analysis tools
- Code refactoring

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

