Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D7CC432BE
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 03:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A784360F11
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 03:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbhHKDhe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Aug 2021 23:37:34 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:34648 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbhHKDha (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Aug 2021 23:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628653027; x=1660189027;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TWCAljC1dx1YD2EZP0iY2/a0tIzDQsxuj/cNzvYBxDk=;
  b=S4aQe5TWV0YSLNbmOJWlfcTmzTNuLdS9DVVjmuIL9xs0pmr2ybQX4Y7f
   QfskoDZbZDwi20/sr9T0M4g5f1lo2aqpp/oG/Rm1KhKY2QViJkqCTvQA8
   NVz/7DZp/tRjrK4CHUS71WpN6CQS5MyLhlnXhxwJNTDnWKY0DTFNszxNL
   q+fPCvXx6H2zQXRjg/pyujbgNYXF29EiP3NSA8vXk6hZacncAc+teFZqJ
   JOb4Pm+OYSm8fb8bJrBWTD8A29q6K4FpSHwgGqDKF92HeZbIU4GuLuM3Y
   d4PgS6kQ9RxKEGrzx/qYgzMB80KQRAIxRLZb+9qUnhhoz7e+ZMnTAQrkC
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,311,1620662400"; 
   d="scan'208";a="177454810"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2021 11:37:05 +0800
IronPort-SDR: eoI9uDyeSIUFN5Igx5kyyAWTB0+Ig6i82nVD7ND6fuxhPPXZqUrB/7YxxYMuOeXyQ5FSuKyCMZ
 SDID/uphZbxKuPNJ1/3CC68JBIfnFK2pMXJJoLr5EueHRHlJu+2XnPaPLqG+zArSRnNrA3lefL
 diMGh45uBWvZyS3/7i+SSAXF+NmGu2B0fa9ScfrM8i2lGet2trblxkdOqJ1GEfHyrvuk0VgBPw
 JAxZ4MsvhxNYhTk82npo+rsW4WBBuVkDAREXijsKJuBPCYKLvBF/C4AC3UqG6jbkDd9VO1iXom
 EgjUlN8mwOtyTH+6KFeqI26r
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 20:14:25 -0700
IronPort-SDR: qWpNUjsACDhWC0msNjVZw2DqXZyL+GyC++rO9ZylPLgNjE1KBjvCC62fAc32e19T3FsN+ZCZsu
 Pr48HgqwZDP4ZYVne5Nuca5zS16ItAZ8fqKM65JdcrAVTi4H7KV0BtsNDaBU7w6ZyS+r/WWbvZ
 LrycWVM9okuAhx5b33/B8rggnCgOpoD0xT20orIZGlCyA9aNFx8u80j82BvqIrfLZzlr1ayPPu
 S+W6WGje+933Bu4FDeEhV7q+VxkfS5do7VnmhFjTdnnDF5TduzOjvQmPuSGqrDcAklhwJcdFPK
 vzY=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Aug 2021 20:37:03 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v4 0/6] IO priority fixes and improvements
Date:   Wed, 11 Aug 2021 12:36:56 +0900
Message-Id: <20210811033702.368488-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series fixes problems with IO priority values handling and cleans
up several macro names and code for clarity.

Changes from v3:
* Split former patch 2 into patches 2, 3 and 4 to facilitate review and
  have more descriptive commit titles.
* In patch 5, keep IOPRIO_BE_NR as an alias for the new IOPRIO_NR_LEVELS
  macro. Change this patch title and commit message accordingly.
* In patch 6, define IOPRIO_BE_NORM as an alias of IOPRIO_NORM.

Changes from v2:
* Fixed typo in a comment in patch 3
* Added reviewed-by tags

Changes from v1:
* Added patch 4 to unify the default priority value used in various
  places.
* Fixed patch 2 as suggested by Bart: remove extra parenthesis and move
  ioprio_valid() from the uapi header to the kernel header.
* In patch 2, add priority value masking.

Damien Le Moal (6):
  block: bfq: fix bfq_set_next_ioprio_data()
  block: improve ioprio class description comment
  block: change ioprio_valid() to an inline function
  block: fix IOPRIO_PRIO_CLASS() and IOPRIO_PRIO_VALUE() macros
  block: Introduce IOPRIO_NR_LEVELS
  block: fix default IO priority handling

 block/bfq-iosched.c          | 10 +++++-----
 block/bfq-iosched.h          |  4 ++--
 block/bfq-wf2q.c             |  6 +++---
 block/ioprio.c               |  9 ++++-----
 drivers/nvme/host/lightnvm.c |  2 +-
 fs/f2fs/sysfs.c              |  2 +-
 include/linux/ioprio.h       | 17 ++++++++++++++++-
 include/uapi/linux/ioprio.h  | 34 ++++++++++++++++++++--------------
 8 files changed, 52 insertions(+), 32 deletions(-)

-- 
2.31.1

