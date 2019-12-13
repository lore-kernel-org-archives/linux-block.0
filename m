Return-Path: <SRS0=J0ZO=2D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37F0C3434E
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3EA52473A
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6i0hqkB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfLMNCd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Dec 2019 08:02:33 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34279 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfLMNCd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Dec 2019 08:02:33 -0500
Received: by mail-pf1-f195.google.com with SMTP id l127so1457673pfl.1;
        Fri, 13 Dec 2019 05:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZPc8DBX2ZfbjwaEgLInVI3S8HFj/56kByg4DfIObTMc=;
        b=N6i0hqkBEVIM+jlUwMzon0U9mzngTnFvijSsH1izi82SQgmncvfMlOQRxxSCyeRErs
         WL56byCPvCe56fFydeRT2Ia4b/SzfWT2nd2PyfZ8vUpQ8onIG/VXPCnOIRrdUdSwtG63
         ch7UzZhNMp0ZTyzc0uONuiAZkgDnVOJF3coeex5qeyFLx1wEhvsqQt9hZY585vTPGgXK
         FiakZ3BYj4Xz43/FfNyprjLZut5G0uv1r90pWwxn2PrmhrU878wZcyYE3R/Nk3Xz4Ckk
         1VCU4LgCDj5ZlW7cKLFKT67YYsfp7cu4VgRy3/23ZycJBD8ly5bH5maHZuQspiTHJMfS
         OCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZPc8DBX2ZfbjwaEgLInVI3S8HFj/56kByg4DfIObTMc=;
        b=YXDdXkeaJnF/9SfzeE40XbvoWrnVzZl0+eJeTn8r2G953JKO8agILLYRkOpIHq6mh7
         +dYOAhe8uJE4biO7saUP8O651DwkLafeWs3UgsLL50gX5Ie9VGLUI7mAYMbvbrLUs2Tz
         StKGHARneNDsEJXGAOSyY09zzHQ6P5CxWJEcR6yZoB6BbxSntvlOHbw90A1vdbPiro1L
         Q5fA9BVHV0GZFl2jUYtCJQPgzlGdRqNVAJBLY7xF+AIyWKK5Vgsr74S2mSzr6W7RAUBo
         Kp06a1Zh8gOaRWPZQ5V1TbxqpYjR/hf6j0WhGxc4uEHY/zO+1fxim6OjAUlnzDEKY749
         oIlg==
X-Gm-Message-State: APjAAAX5vBeXRidGGcVRuMX+KpFw+9EbadPRVWtRjMIfmeY7/Kwkyydf
        F/9fcu+UPd2FhD4EXeyKoCo=
X-Google-Smtp-Source: APXvYqwwGYLLtINm/TP+G8Tba8uazrIqTPMf1a8m0SsSyI2D6fxD3WkOSpHXI4F9WCaxEyvwPl52lg==
X-Received: by 2002:aa7:9808:: with SMTP id e8mr16113067pfl.32.1576242152522;
        Fri, 13 Dec 2019 05:02:32 -0800 (PST)
Received: from localhost.localdomain ([12.176.148.120])
        by smtp.gmail.com with ESMTPSA id k3sm10872278pgc.3.2019.12.13.05.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 05:02:31 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     jgross@suse.com, axboe@kernel.dk, konrad.wilk@oracle.com,
        roger.pau@citrix.com
Cc:     SeongJae Park <sjpark@amazon.de>, pdurrant@amazon.com,
        sjpark@amazon.com, sj38.park@gmail.com,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/3] xenbus/backend: Add a memory pressure handler callback
Date:   Fri, 13 Dec 2019 13:02:08 +0000
Message-Id: <20191213130211.24011-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Granting pages consumes backend system memory.  In systems configured
with insufficient spare memory for those pages, it can cause a memory
pressure situation.  However, finding the optimal amount of the spare
memory is challenging for large systems having dynamic resource
utilization patterns.  Also, such a static configuration might lack
flexibility.

To mitigate such problems, this patchset adds a memory reclaim callback
to 'xenbus_driver' (patch 1) and use it to mitigate the problem in
'xen-blkback' (patch 2).  The third patch is a trivial cleanup of
variable names.

Base Version
------------

This patch is based on v5.4.  A complete tree is also available at my
public git repo:
https://github.com/sjp38/linux/tree/blkback_squeezing_v8


Patch History
-------------

Changes from v7
(https://lore.kernel.org/xen-devel/20191211181016.14366-1-sjpark@amazon.de/)
 - Update sysfs-driver-xen-blkback for new parameter
   (suggested by Roger Pau Monné)
 - Use per-xen_blkif buffer_squeeze_end instead of global variable
   (suggested by Roger Pau Monné)

Changes from v6
(https://lore.kernel.org/linux-block/20191211042428.5961-1-sjpark@amazon.de/)
 - Remove more unnecessary prefixes (suggested by Roger Pau Monné)
 - Constify a variable (suggested by Roger Pau Monné)
 - Rename 'reclaim' into 'reclaim_memory' (suggested by Roger Pau Monné)
 - More wordsmith of the commit message (suggested by Roger Pau Monné)

Changes from v5
(https://lore.kernel.org/linux-block/20191210080628.5264-1-sjpark@amazon.de/)
 - Wordsmith the commit messages (suggested by Roger Pau Monné)
 - Change the reclaim callback return type (suggested by Roger Pau Monné)
 - Change the type of the blkback squeeze duration variable
   (suggested by Roger Pau Monné)
 - Add a patch for removal of unnecessary static variable name prefixes
   (suggested by Roger Pau Monné)
 - Fix checkpatch.pl warnings

Changes from v4
(https://lore.kernel.org/xen-devel/20191209194305.20828-1-sjpark@amazon.com/)
 - Remove domain id parameter from the callback (suggested by Juergen Gross)
 - Rename xen-blkback module parameter (suggested by Stefan Nuernburger)

Changes from v3
(https://lore.kernel.org/xen-devel/20191209085839.21215-1-sjpark@amazon.com/)
 - Add general callback in xen_driver and use it (suggested by Juergen Gross)

Changes from v2
(https://lore.kernel.org/linux-block/af195033-23d5-38ed-b73b-f6e2e3b34541@amazon.com)
 - Rename the module parameter and variables for brevity
   (aggressive shrinking -> squeezing)

Changes from v1
(https://lore.kernel.org/xen-devel/20191204113419.2298-1-sjpark@amazon.com/)
 - Adjust the description to not use the term, `arbitrarily`
   (suggested by Paul Durrant)
 - Specify time unit of the duration in the parameter description,
   (suggested by Maximilian Heyne)
 - Change default aggressive shrinking duration from 1ms to 10ms
 - Merge two patches into one single patch

SeongJae Park (3):
  xenbus/backend: Add memory pressure handler callback
  xen/blkback: Squeeze page pools if a memory pressure is detected
  xen/blkback: Remove unnecessary static variable name prefixes

 .../ABI/testing/sysfs-driver-xen-blkback      |  9 +++
 drivers/block/xen-blkback/blkback.c           | 57 ++++++++++++-------
 drivers/block/xen-blkback/common.h            |  2 +
 drivers/block/xen-blkback/xenbus.c            | 11 +++-
 drivers/xen/xenbus/xenbus_probe_backend.c     | 32 +++++++++++
 include/xen/xenbus.h                          |  1 +
 6 files changed, 90 insertions(+), 22 deletions(-)

-- 
2.17.1

