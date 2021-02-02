Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BCEC433DB
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D24564EAC
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbhBBFhA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 00:37:00 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:56999 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhBBFg7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 00:36:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612244232; x=1643780232;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9zWo4oeZZsNPR5Pm+0PkOJkwoqPN+592wafpaF5WL+E=;
  b=buQA2ztSMdXKrNJPKjCg3zclBND6/c2M51XFP/adMCxS7eQtOwM1FG05
   9UIaqIic9yFsy8vtSI0f+d1yIBRWJAkU+9kDdfZdbnTA9m/pHlgWrkc28
   WFO2vWZaZAHeNBFswa4eE1CG1SqGcJjrG53W+QK3GOeYWfJLbiOGDMxar
   dqJMfvUlLBmANRbAGiGtCWC/VCsYqo/FqNGUTQuZdbeYWYIo0NCvgzzNM
   M4E8A3kqD4TJanrDxuleoBPdFLKHeG8tj877LpmxSlL29J83g5Ao7CIjB
   G+G47bIPq1lB0C/Zaf5BZF9Q1iLKffsuEnZ0HM5TLJe8ELaMxmmMkDR8V
   A==;
IronPort-SDR: 2cXcH3MMywYSVOIlOv0PZVDW1qWOQyWXlhfrJ7ribhW6Ow97rCCbEyGdRLf5g9kZBJmywCp4tq
 b1vqYwzp7QBlTkL8+Pxx3EK/SiAzHp09kajecaDOWnOczF038lCk4R/vFcjkrUPIT2wrHZ2ktk
 4xTfLOlAfaBeMsBb4SaclM5fidEFw3U7R6oXNIiue+uVXAUG22L/OXHCChP+qepQ4wRCujLHpl
 ZUJwtdMP5LTbuXsqJquyW49eu5qbTymc4l+Y9U7FmqSGuZfv5UmdINpi1ctAfWl/K3XbwGnppG
 V0g=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="262961780"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 13:55:51 +0800
IronPort-SDR: yJBg4HEXRseGr3dyjwVu0Yz8Y5nQcCKeniAbV7d+bJ96wg+nzNBgc1p545ha3VmIkZiORihSat
 /jCkfi/2xMlJumGlfTzjkXqsWmaGXzDaOri34YKJMvSzfev33maouakWt+sw5ARm4WZkT9x+Mf
 s4jfsrcpP99t7rXs9GfvU5k8XVyonCu2RspLLi919kf6Vmycmrk3K22w9ZpYEa84bdpRaKijYK
 eQN5YTgU/jZodLdIY6oQB3H8J1juTKvO843DWO73dY+ui2iqmZlI8eSWCdW70/gU9bm5Ct/ssN
 tIDrnA5FyAZRiisWageRwMKs
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:20:02 -0800
IronPort-SDR: 8j9cM0dt/Bt6GCfQ7BQp/X8wKLXGyOSocuYSQEJsXVKDUdPYBvNqfClqrfl2gWBJG7phjV2UD/
 V15C5XGNDZkNMwiJhkWEPhSocWDXlsnPEA41vQyr+j7R/E4RwOS3jQba44BfYnDjAibDBxaSLR
 wjFCdJAbjjPxmEaCqQV+8mN7w4dDGUvYRAg9YbEvNQxXELUPO7MkH9mw9hqfCDiyzWKWWtPpU6
 xVfyPIMFEMn0gsp5zManTwK4HwQIDSnT7MKQQOJPCnrDKdG8M+Xc4yX9pT/1c80XZjK6b0Try0
 rTw=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Feb 2021 21:35:54 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 00/20] loop: cleanup and small improvement 
Date:   Mon,  1 Feb 2021 21:35:32 -0800
Message-Id: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

In the current loop driver, there are different coding style present
which creates confusion when adding new code e.g. variable declaration,
function parameter spacing, switch case break vs return, setting up
error code before the error condition when error code is not shared,
structure member alignment, inconsistent variable declaration style,
declaring the same variable in two switch cases, using extra variable
instead of direclty accessing structure member for one occurance in the
code etc. 

This patch-series tries to fix that and also adds some improvements such
as adding lockdep assert, reducing the memset count, using snprintf etc.

Marking it RFC since I'm sure if these little fixes are welcome or not
as code works fine without it. On confirmation I'll spend more time
building a patch-series with an an extensive test report.

Hopefully unlike my previous series this will not end up twice on the
mailing list.

-ck

Chaitanya Kulkarni (20):
  loop: use uniform alignment for struct members
  loop: add lockdep assert in loop_add()
  loop: add lockdep assert in loop_lookup()
  loop: allow user to set the queue depth
  loop: use snprintf for XXX_show()
  loop: add newline after variable declaration
  loop: use uniform variable declaration style
  loop: use uniform function header style
  loop: remove extra variable in lo_fallocate()
  loop: remove extra variable in lo_req_flush
  loop: remove local variable in lo_compat_ioctl
  loop: cleanup lo_ioctl()
  loop: remove memset in info64 to compat
  loop: remove memset in info64 from compat
  loop: remove memset in loop_info64_from_old()
  loop: remove memset in loop_info64_to_old()
  loop: change fd set err at actual error condition
  loop: configure set err at actual error condition
  loop: set error value in case of actual error
  loop: remove the extra line in declaration

 drivers/block/loop.c | 253 ++++++++++++++++++++-----------------------
 drivers/block/loop.h |  26 ++---
 2 files changed, 132 insertions(+), 147 deletions(-)

-- 
2.22.1

