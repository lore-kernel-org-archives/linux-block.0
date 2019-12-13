Return-Path: <SRS0=J0ZO=2D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E338C341C2
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB572473C
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGmHyUFR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfLMPgR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Dec 2019 10:36:17 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41692 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbfLMPgQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Dec 2019 10:36:16 -0500
Received: by mail-pg1-f196.google.com with SMTP id x8so1750680pgk.8;
        Fri, 13 Dec 2019 07:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HItEjzDojjooTRgp7O+9O0H7zbWi0kBed0e15OEYpt0=;
        b=WGmHyUFRPZ2ZOsbgcmAPSFO/Jexvz5NhLELGWHpv4Tl7qQZg36Vg1cx8oxxQ1a/E/l
         EpkpKqjdaGAGiWyOm+O7jp87MuU04zC2UgwiOV71LLy4XY6o2Ai499milKGvgTZClPXd
         8cXbdDeNoLvi/fBx35UA9HHFm8dpmuGDNYDAltfHpPiutYGj2dPxtvwOEBxRyti/aA89
         l3D1qL3yyee9OuIAkYTHYJP/KJoLRnMdh4oqoE5+3R0TrgiP0pLEbjmjX/nLxEVtgcZx
         n4PYI+yrps2gpGDaMFk8KaqSqtDKEQaECLkTtO1OIuv5l43esfdmWGkDyuEwfX9MJgHf
         o0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HItEjzDojjooTRgp7O+9O0H7zbWi0kBed0e15OEYpt0=;
        b=ECuun0qVHpA2DuJuAtbuVZdGl5FZSDEGPpYROYHPT3Jj5WhhUMRbsoA25588fgJEfC
         v2MTekkJaid/gWV+Vy3+kmUWL2cwyYUBO1wFY4otO51lkxLYLji8eb2WNbOeLuP05I/l
         /huKHailAPOtEGOBtpZZhQLKt7vw5yDFSBNhiPGuczPR6tC34iFke592/8TbBlrw4has
         ynztKxY3AcrGdyAiLnT0uFIgZ8iaF8dHzTg8DQ7FZeW1FfCpxldEE1D3GBmvi/AR/KUk
         lQLIpoxlMI4sTFIbbbCibiL0GjFyf6AgIh4zBcSTdu7uEK1TbtBzRe4uVWGZRpNZMOwP
         OWYQ==
X-Gm-Message-State: APjAAAWZHyK1e5YFoTXberY3zDDglpyKIkLbgoFDmuIfQKxmgZqCgvL2
        f2AziWnJsKt3qcpyA+w2OXA=
X-Google-Smtp-Source: APXvYqxC4ktjLQPkeK71MAy6/aFEcGoWvqtBT2iJQcTdeQzmCeLS4XtlZzU1Y8SN2p03/7qGvSO/4A==
X-Received: by 2002:a62:1a16:: with SMTP id a22mr69199pfa.34.1576251375146;
        Fri, 13 Dec 2019 07:36:15 -0800 (PST)
Received: from localhost.localdomain ([12.176.148.120])
        by smtp.gmail.com with ESMTPSA id w131sm12039217pfc.16.2019.12.13.07.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 07:36:14 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     jgross@suse.com, axboe@kernel.dk, konrad.wilk@oracle.com,
        roger.pau@citrix.com
Cc:     SeongJae Park <sjpark@amazon.de>, pdurrant@amazon.com,
        sjpark@amazon.com, sj38.park@gmail.com,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 4/4] xen/blkback: Consistently insert one empty line between functions
Date:   Fri, 13 Dec 2019 15:35:46 +0000
Message-Id: <20191213153546.17425-5-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191213153546.17425-1-sjpark@amazon.de>
References: <20191213153546.17425-1-sjpark@amazon.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The number of empty lines between functions in the xenbus.c is
inconsistent.  This trivial style cleanup commit fixes the file to
consistently place only one empty line.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 drivers/block/xen-blkback/xenbus.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index 4f6ea4feca79..dc0ea123c74c 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -432,7 +432,6 @@ static void xenvbd_sysfs_delif(struct xenbus_device *dev)
 	device_remove_file(&dev->dev, &dev_attr_physical_device);
 }
 
-
 static void xen_vbd_free(struct xen_vbd *vbd)
 {
 	if (vbd->bdev)
@@ -489,6 +488,7 @@ static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
 		handle, blkif->domid);
 	return 0;
 }
+
 static int xen_blkbk_remove(struct xenbus_device *dev)
 {
 	struct backend_info *be = dev_get_drvdata(&dev->dev);
@@ -572,6 +572,7 @@ static void xen_blkbk_discard(struct xenbus_transaction xbt, struct backend_info
 	if (err)
 		dev_warn(&dev->dev, "writing feature-discard (%d)", err);
 }
+
 int xen_blkbk_barrier(struct xenbus_transaction xbt,
 		      struct backend_info *be, int state)
 {
@@ -656,7 +657,6 @@ static int xen_blkbk_probe(struct xenbus_device *dev,
 	return err;
 }
 
-
 /*
  * Callback received when the hotplug scripts have placed the physical-device
  * node.  Read it and the mode node, and create a vbd.  If the frontend is
@@ -748,7 +748,6 @@ static void backend_changed(struct xenbus_watch *watch,
 	}
 }
 
-
 /*
  * Callback received when the frontend's state changes.
  */
@@ -823,7 +822,6 @@ static void frontend_changed(struct xenbus_device *dev,
 	}
 }
 
-
 /* Once a memory pressure is detected, squeeze free page pools for a while. */
 static unsigned int buffer_squeeze_duration_ms = 10;
 module_param_named(buffer_squeeze_duration_ms,
@@ -844,7 +842,6 @@ static void reclaim_memory(struct xenbus_device *dev)
 
 /* ** Connection ** */
 
-
 /*
  * Write the physical details regarding the block device to the store, and
  * switch to Connected state.
-- 
2.17.1

