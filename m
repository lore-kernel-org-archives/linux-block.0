Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3895C433ED
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 12:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABD0361107
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 12:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbhDNMYf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Apr 2021 08:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbhDNMYe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Apr 2021 08:24:34 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A06C061574
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 05:24:10 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id s15so23454897edd.4
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 05:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MxYCiPYk8bw1boN/CLPSn7Xtpfkc83SZ3wWfmQcTPO4=;
        b=Y+J2XcXnSRNaHk6d2Ajfj8yCuH8rSQJqUwitF0//QwyRMNKsubKZ/XGjo/mAfcaxWd
         lA6zQhrCunZ4rkfeVW0SC0HHEykxBCAEscdf7yYUTgeuNKnZ1KvB6C9iXQHOTSnfA+Ly
         3iXSF+Z2HUEd+CeG0TuUqNPAAvQpuIRbv4tk5USqnBvhSzxMT8nJ6HSTlTvHDo3/M3pw
         lMdgaOS/78hcVuAETssvZuyuwrjLG4m5HPHyx2cRwlVSjcsm7A4/KjPpm937veZKXGLk
         +4ai4Y+uySRF1un59uVYXK2je7ILhnUpgIF0/MxkCakbZNoFhTxZ0EJGi9BSXPCLhGS7
         Vxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MxYCiPYk8bw1boN/CLPSn7Xtpfkc83SZ3wWfmQcTPO4=;
        b=OjMUhxgv3EJc/vdGOxFAqbv16j62asjqIw9vIRGwJ26WjywgMlxpHO4a+U5OF+ji01
         PQiPgOmnQxUfMxgQTS/KQ4MuUpB2ZqrX2Ryf0UNbB3NKlbdCOiuEoR4xjvBLyErUVq3R
         HkJDfBY2Eo38EwW8QoX+ameX8dskXtGA1ypb0QpevBzp4/xe5CnQuwVrgGfrj01p4j53
         4UsFcitbCjw6E00rGE5n3vtBBPHe+fz3wWAPCSbbSCvn5byTXmekqDnuic0+RG9KyKh/
         4tJxoWUspvy+IOcBWrbIxJvZaVlMQppDWcpoXtJhUpoLBPNnYHSD5Yv+z/zVW6urZus6
         vDxA==
X-Gm-Message-State: AOAM530hy7VQAnv5QPglPTnoyJM7JOO20IgagbXSXSUFODOvNQu+1fxK
        bw5+608WRD0UTRcZd3yX8VcIrkWxl/qwdQ==
X-Google-Smtp-Source: ABdhPJwnMlA8GH3pHDQUho5DQ9CjUZas8RtjCg1mqYislB4Y5GuquBuWyWPuahdTJYqMR71NSOxNTA==
X-Received: by 2002:a05:6402:42d3:: with SMTP id i19mr40765045edc.220.1618403048935;
        Wed, 14 Apr 2021 05:24:08 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id y26sm6201306ejj.98.2021.04.14.05.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 05:24:08 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv4 for-next 00/19] Misc update for rnbd
Date:   Wed, 14 Apr 2021 14:23:43 +0200
Message-Id: <20210414122402.203388-1-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

I am sending v4 because there is no reply for v3 I sent last week.
The changes from v3 to v4 are described below. 

This is the misc update for rnbd. It inlcudes:
- Change maintainer
- Change domain address of maintainers' email: from cloud.ionos.com to ionos.com
- Add polling IO mode and document update
- Fix memory leak and some bug detected by static code analysis tools
- Code refactoring

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

