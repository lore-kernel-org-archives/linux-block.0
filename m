Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD7DC433B4
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 07:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 044E661289
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 07:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhELHDY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 03:03:24 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:33491 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhELHDW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 03:03:22 -0400
Received: by mail-pg1-f177.google.com with SMTP id i5so12775260pgm.0;
        Wed, 12 May 2021 00:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KEQWsVdB8qfNQPPhFKDCVvKDDvUBgxfqfsdWYOx3mN4=;
        b=B88sNGW4ucol4lctRcQflE0PyqY1GMVMNk23HE87Vj0p52lSxURP44RkOENQwgAoUn
         YTw7bbm+xRin/zNhPIexqPwe1t3bZGFnQrJJbMqGiitoqzhsmPeK+S8B40csdR0WgggF
         lFl64inwVdAcowm27p1HRWwjPNVCqx3Y/DvW6aYtOm4PH4sUalVVULEcdgSknng2W2be
         SWO6GIl/4taRo1GjRgIjzUVtkdkXXOElUBs8vnnNIvJBSbZYDiJ6+Opja7kQykkmbptP
         DYQqWZ8AC4ZptpXlpJNfXcgSXK08Npyv/1i1jbfgjgCz5iJuHns8MOCHA7G2hAsdYZWt
         pAxw==
X-Gm-Message-State: AOAM531VP3qMJqGeOrpRC4FiACDAIzsVCpXs4TdHg7lnbaRVmeiG2aVv
        3eXoMUQ2qKR7aYZikRTp1Mo=
X-Google-Smtp-Source: ABdhPJxTiT6ia5U6V0VRDW7JLXvx+DzDmnaBmheGKcN7zAlkHbbQu6+kUMWqLVBz7nkhn/awy1gjfw==
X-Received: by 2002:a63:4a23:: with SMTP id x35mr34265317pga.270.1620802933711;
        Wed, 12 May 2021 00:02:13 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id i197sm14838826pgc.13.2021.05.12.00.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 00:02:04 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 1562042341; Wed, 12 May 2021 06:46:35 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     bvanassche@acm.org, ming.lei@redhat.com, hch@infradead.org,
        jack@suse.cz, osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v1 0/8] block: add error handling for *add_disk*()
Date:   Wed, 12 May 2021 06:46:21 +0000
Message-Id: <20210512064629.13899-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series bumps from RFC to PATCH form for two reasons, one is that I
have run quite a bit of full blktests tests on this without finding
regressions. Second is that the only feedback from the first RFC was
from Bart asking for error injection support, and this series adds just
that.

Lemme know if you've spotted something stupid. You can find these
patches my linux-next 20210427-block-fixes-v8 branch. Yes, it is
using a slightly older linux-next, so I can respin, its just that
there were quite a bit of linux-next release which were *really*
*fscked* up lately, so I had to stick at least something slightly
stable.

https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20210427-block-fixes-v8

Luis Chamberlain (8):
  block: refcount the request_queue early in __device_add_disk()
  block: move disk announce work from register_disk() to a helper
  block: move disk invalidation from del_gendisk() into a helper
  block: move disk unregistration work from del_gendisk() to a helper
  block: add initial error handling for *add_disk()* and friends
  loop: add error handling support for add_disk()
  null_blk: add error handling support for add_disk()
  block: add add_disk() failure injection support

 .../fault-injection/fault-injection.rst       |  23 ++
 block/Makefile                                |   1 +
 block/blk-core.c                              |   1 +
 block/blk-integrity.c                         |  12 +-
 block/blk-sysfs.c                             |   5 +-
 block/blk.h                                   |  60 +++-
 block/failure-injection.c                     |  54 +++
 block/genhd.c                                 | 331 ++++++++++++------
 drivers/block/loop.c                          |   7 +-
 drivers/block/null_blk/main.c                 |   9 +-
 include/linux/genhd.h                         |  14 +-
 lib/Kconfig.debug                             |  13 +
 12 files changed, 414 insertions(+), 116 deletions(-)
 create mode 100644 block/failure-injection.c

-- 
2.30.2

