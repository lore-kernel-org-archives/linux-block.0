Return-Path: <SRS0=jajD=TE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8905C43219
	for <linux-block@archiver.kernel.org>; Sat,  4 May 2019 18:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963AD205F4
	for <linux-block@archiver.kernel.org>; Sat,  4 May 2019 18:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="mZQNX0D5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfEDSi2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 May 2019 14:38:28 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:42198 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfEDSi2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 May 2019 14:38:28 -0400
Received: by mail-lj1-f172.google.com with SMTP id y10so1330569lji.9
        for <linux-block@vger.kernel.org>; Sat, 04 May 2019 11:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iEdmR9hS0Zj+TCn7686thFow/VL6EAoMYgZ3XNuV/tY=;
        b=mZQNX0D52F0GprJ4T66jTfynaH6SaD6Sv6/FATNQFgeG7uNDvtIP/ygq5wbJIr95Dc
         sYBeupb6vqwK3PbDOZfY3dGN1d5GkWldEH222MT4afN3w7RzSUsnFDO7LRSc8Q5CHxOa
         1kNS0v68HeU31LDJBHQaiBXrTW151D54udA3SrJvvV8mvw4fm0EcO6PmSUAMl3RQI8ok
         3SqJsW3LEb9p1UFerYBNQbBnd3BlIGvGYmJtojzPYkeJJKjNJOuluafWcdy/MNDuNRco
         P3zv//uwcsMCnjykXmyza+Q5WVjrCL6G3vuUxYLtnaAE6Ix8z54OazdJAIhE1ms/p9Jm
         ySig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iEdmR9hS0Zj+TCn7686thFow/VL6EAoMYgZ3XNuV/tY=;
        b=e9raXS2PFWsWqtF4hNviL4L6ubkBABs73FR3idB0UQKLvnrQjPwqUSTpbcE5vXNTdp
         OwqI7AleHfxEuxHYWQqXidc7tGe+CVgBasZ117wD52YkbYMdyItVhqQ5voxD3NO0B8ks
         DdhSs7lEOCWwxYtqzNx9/YAkSapIqyZ3FltxpU9QJ7BY47lot8iHeglkUec2G/XZRcrX
         HnZBFNDuMukLk8/zsT0/bDbAbM/a9cMOnCmlk/mGUbGb3VpM3I2J/J+hdMM7dOrHdA2t
         Db/zvzbDitDjWi3xxNNWaJkajmVfgfMx4WfkPDfhLeyz0Q2d9Ciu3HhElU5jNnY1DY0W
         GLXg==
X-Gm-Message-State: APjAAAV/7JGbYgX4o7NT/oYJV2e6gTYMeCsrZz6WE89HRfYJUTA34Ico
        3YLqc9COLZwoNii+NT9cUNpo2Q==
X-Google-Smtp-Source: APXvYqyLPZjyhW0rh+9xfky9uA4OQUDxKky+nydy6B/+icJxNDCRQ6iIOAp++0Uk3QsDvZbXD+8lrA==
X-Received: by 2002:a2e:9f44:: with SMTP id v4mr8767781ljk.72.1556995106772;
        Sat, 04 May 2019 11:38:26 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id q21sm1050260lfa.84.2019.05.04.11.38.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:38:26 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 00/26] lightnvm updates for 5.2
Date:   Sat,  4 May 2019 20:37:45 +0200
Message-Id: <20190504183811.18725-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Can you please pick up the following patches for the 5.2 window if
it is too late.

Igor and Marcin from Intel has been very active in this release,
fixing up a ton of race conditions, improving memory usage,
and making pblk more compatible with existing OCSSD devices.

Thank you!
Matias

Chansol Kim (1):
  lightnvm: pblk: fix bio leak when bio is split

Igor Konopko (23):
  lightnvm: pblk: line reference fix in GC
  lightnvm: pblk: rollback on error during gc read
  lightnvm: pblk: reduce L2P memory footprint
  lightnvm: pblk: remove unused smeta_ssec field
  lightnvm: pblk: gracefully handle GC vmalloc fail
  lightnvm: pblk: fix race during put line
  lightnvm: pblk: ensure that erase is chunk aligned
  lightnvm: pblk: cleanly fail when there is not enough memory
  lightnvm: pblk: set proper read status in bio
  lightnvm: Inherit mdts from the parent nvme device
  lightnvm: pblk: fix lock order in pblk_rb_tear_down_check
  lightnvm: pblk: kick writer on write recovery path
  lightnvm: pblk: fix update line wp in OOB recovery
  lightnvm: pblk: propagate errors when reading meta
  lightnvm: pblk: wait for inflight IOs in recovery
  lightnvm: pblk: remove internal IO timeout
  lightnvm: pblk: GC error handling
  lightnvm: pblk: IO path reorganization
  lightnvm: pblk: recover only written metadata
  lightnvm: track inflight target creations
  lightnvm: do not remove instance under global lock
  lightnvm: pblk: simplify partial read path
  lightnvm: pblk: use nvm_rq_to_ppa_list()

Marcin Dziegielewski (2):
  lightnvm: pblk: set propper line as data_line after gc
  lightnvm: prevent race condition on pblk remove

 drivers/lightnvm/core.c          |  82 ++++---
 drivers/lightnvm/pblk-cache.c    |   8 +-
 drivers/lightnvm/pblk-core.c     |  65 +++--
 drivers/lightnvm/pblk-gc.c       |  52 ++--
 drivers/lightnvm/pblk-init.c     |  65 ++---
 drivers/lightnvm/pblk-map.c      |   1 +
 drivers/lightnvm/pblk-rb.c       |  13 +-
 drivers/lightnvm/pblk-read.c     | 392 +++++++++----------------------
 drivers/lightnvm/pblk-recovery.c |  74 +++---
 drivers/lightnvm/pblk-write.c    |   1 +
 drivers/lightnvm/pblk.h          |  28 +--
 drivers/nvme/host/lightnvm.c     |   1 +
 include/linux/lightnvm.h         |   2 +
 13 files changed, 325 insertions(+), 459 deletions(-)

-- 
2.19.1

