Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEB3C4338F
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 05:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13AB6611C9
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 05:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242898AbhHFFL7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Aug 2021 01:11:59 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:64546 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhHFFL7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Aug 2021 01:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628226703; x=1659762703;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gNBdiDD6x/yNjv/Ff1lf1OHWLKH/Q4+rYKGZ6B1EdjE=;
  b=WcXFj6Hw8iwaevnx/sEMOHwGFBRJxGg5D0kY0gWi2A14ffz9DkCcg/X5
   5DYznCrbQRwQCZlsj/nersYGdh4RfT9Z4yITc6Y/PTQ+KxQd0uONIj5o6
   B0FAJ2tECQpDjN7esRWY+uGP491gzzpFNe/hDUWpChYox0tYdqB9OIrzQ
   2z7yyr8zq4N3c/YyvwpzX3Vy/mtfYt/GAXDQs9g+GQKVam072sgpbedl3
   Tn7Qpm17CMTTbi5R6vx6sQEm36nZ+/R0JUeaR/NCakdNBl3o4yYZdgQ6J
   RgUIbfZFhZM7xjhDgPCqiPQz4caGryQkYBqKLoVXDQIIxb6ZGczQ1EPNx
   w==;
X-IronPort-AV: E=Sophos;i="5.84,299,1620662400"; 
   d="scan'208";a="176473062"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Aug 2021 13:11:43 +0800
IronPort-SDR: 9ivUWqJzkncGtAPOX0M7ppzPtvX0tPvTiQMB0Nw/HGybbyuNbzvWH8StEi+x25vyQ1vkk7nKcl
 2MuQ6wX2VewEt54WmKNsU39QBYn/t5HVEDh0daW+TU/KhdlOGE8eTt1dr+PUlU+5V6bLuQITnF
 M/wCl1PzhFYGPV3MOXFP9XIGbajt29nfunZKhxYkHnXLAQ6y0D/Ypyno2gjbrcp2poCTe116iB
 DAYiJutUkHjgL8xMIGqGIPSQfPe8wFKYtLjbPYDxeQdU4W3VQiElIcgCc/wnEwva++a6T0fCoj
 Kbhx7RwmDjehwspP1AwqotTx
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2021 21:49:12 -0700
IronPort-SDR: Dasbz1sPEb225juJaMs5Lc3oN/myHAeiFF0S+7T+7mg0CeEADTCOLBbxt+JBqz3EysSoIeJ76y
 ym8aepy/zZCj1mvI1xL2yZkn61iWUnaD+tXjcY0TFT312+b7pKlMMWf3sHtEBc0AZXJeHQffGl
 GQPM6093S6hULmCfZJ21Zl/iQqFpI/gAbEQ/K8bS9/ZncYtnpARmlPn6s4w3oGbRhqgo4qiu4r
 rPZqlRlduk7jJqNu39z9wslfrTp+Sz2Eee+kfTJtpyjQQk0JlrG3AbLXFVG3C9lTPxkEfeGNCZ
 ujQ=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Aug 2021 22:11:43 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2 0/4] IO priority fixes and improvements
Date:   Fri,  6 Aug 2021 14:11:36 +0900
Message-Id: <20210806051140.301127-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series fixes problems with IO priority values handling and cleans
up several macro names and code for clarity.

Changes from v1:
* Added patch 4 to unify the default priority value used in various
  places.
* Fixed patch 2 as suggested by Bart: remove extra parenthesis and move
  ioprio_valid() from the uapi header to the kernel header.
* In patch 2, add priority value masking.

Damien Le Moal (4):
  block: bfq: fix bfq_set_next_ioprio_data()
  block: fix ioprio interface
  block: rename IOPRIO_BE_NR
  block: fix default IO priority handling

 block/bfq-iosched.c          | 10 +++++-----
 block/bfq-iosched.h          |  4 ++--
 block/bfq-wf2q.c             |  6 +++---
 block/ioprio.c               |  9 ++++-----
 drivers/nvme/host/lightnvm.c |  2 +-
 fs/f2fs/sysfs.c              |  2 +-
 include/linux/ioprio.h       | 22 ++++++++++++++++++----
 include/uapi/linux/ioprio.h  | 23 +++++++++++++----------
 8 files changed, 47 insertions(+), 31 deletions(-)

-- 
2.31.1

