Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44731C433B4
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AB1C613BC
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244151AbhDFHH3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 03:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244150AbhDFHH3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 03:07:29 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708FCC06174A
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 00:07:21 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id s15so242245edd.4
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 00:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2N0ZP7s5Jfqcw+X8iq+ovVa79kHmgXVDctYYOv1/Ksk=;
        b=fc4rS7J5ry39JFtNh8AMTfvldBTlOg0/PAuAm15NscuhyNT4IHlh5XUZZ+VEBL2cTL
         AK/CoU6/QaFGeKPuZoPwbSk7UMFG2eyWDn3wjTmYiQtHA5s663ygzRojRX1inb7sPWPo
         3Z2L+UjOPkaUgZeSfdSkWPiS8LAWTZxp1IIaei2tOCVNoAvYC662LrspC4GsCfbrtEHL
         y1O5Vxh/wZj/irMLeCvg9LMJ+lsKO164/8F/LJKK6HTA2TRRroXW0y52EsNvPhVTm7oL
         HP1geG22kLWajbejzhs73sTU2r5PaYNg74kqGzNpNsr2sJulxxOX/sUP03pXCPK3OHcc
         rq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2N0ZP7s5Jfqcw+X8iq+ovVa79kHmgXVDctYYOv1/Ksk=;
        b=OarYA/nuH8vb4SZtvmPLgklP7hOVnngbavyHuqRFaOAR6Ip3Dx45mEmz9HxvVAgfIv
         fV2PxZgrWgWGGoG78er8dGGK+Oj7NtvaKHQG+HhH4qaJcC9iT3Lhiv12AamMR2zB52Z8
         WPLQk/NNFy8kui8Rydyx6IwuQyB6cJSbydEekF2t+AFdGQoD4KuqXE4WFFs07CtFrVYd
         acDQW0bBBFrUw13yFvsntuIIaOb+a7JzvXeOlrjnn+HEYt+Yk9ovKO7ahC0kpJxyuiUw
         4KEdk02HKpT7DXbfLYao9DSH/r0+f1Xj1VVSn4/cjaDHkRc2U3jxwEN3lFdBJeyb6pMF
         GnPQ==
X-Gm-Message-State: AOAM533UDHmvTDccIjV2Sx0iDZs842U76oYSw3FvKv2KweW/gahOSqJz
        /ZLplvF59oo5w1wLlOGS95jFt487JgwCWg==
X-Google-Smtp-Source: ABdhPJwUFBeX3yz4wagEK85SEoAgILa3pOOkVgyFBqzFCtzvmc8atJGntoVxc64WTCx2OUp24pcMmw==
X-Received: by 2002:a05:6402:3092:: with SMTP id de18mr4047075edb.96.1617692840110;
        Tue, 06 Apr 2021 00:07:20 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id rh6sm3976566ejb.39.2021.04.06.00.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 00:07:19 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv3 for-next 00/19] Misc update for rnbd
Date:   Tue,  6 Apr 2021 09:06:57 +0200
Message-Id: <20210406070716.168541-1-gi-oh.kim@ionos.com>
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
- Fix memory leak and some bug detected by static code analysis tools
- Code refactoring

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
 drivers/block/rnbd/rnbd-clt-sysfs.c           |  85 ++++++---
 drivers/block/rnbd/rnbd-clt.c                 | 167 ++++++++++++------
 drivers/block/rnbd/rnbd-clt.h                 |   6 +-
 drivers/block/rnbd/rnbd-srv-sysfs.c           |   5 +-
 drivers/block/rnbd/rnbd-srv.c                 |  69 +++-----
 drivers/block/rnbd/rnbd-srv.h                 |   3 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c        |  75 +++++---
 drivers/infiniband/ulp/rtrs/rtrs-clt.h        |   1 -
 drivers/infiniband/ulp/rtrs/rtrs-pri.h        |   1 +
 drivers/infiniband/ulp/rtrs/rtrs-srv.c        |   4 +-
 drivers/infiniband/ulp/rtrs/rtrs.h            |  13 +-
 14 files changed, 303 insertions(+), 161 deletions(-)

-- 
2.25.1

