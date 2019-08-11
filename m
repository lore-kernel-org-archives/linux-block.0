Return-Path: <SRS0=/IjG=WH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A0BC433FF
	for <linux-block@archiver.kernel.org>; Sun, 11 Aug 2019 17:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CBDD208C2
	for <linux-block@archiver.kernel.org>; Sun, 11 Aug 2019 17:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbfHKRXl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 11 Aug 2019 13:23:41 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43813 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfHKRXl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 11 Aug 2019 13:23:41 -0400
Received: by mail-yw1-f66.google.com with SMTP id n205so37953992ywb.10;
        Sun, 11 Aug 2019 10:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tn6nhjNQ7pdIDBNVvjNcCirLgHTb4d9vEhC1PgN0dmg=;
        b=Q4HxoqNQmDtNQG+lssU+Y9bv60ghSM7/KASV/auxtsiUOQQACxYd0jfDCBz1zp1otq
         ijytVPKRnPklz5rW4gVMY3aeiiDfQtjji8tD7gM8kG1/icmXA97OgLeWQEkihf/qYdb7
         y8eCe0uVu7iPZoScrjjaeCLbdJ9/PqfQ3yN9nhRkkBR4r4YG6G75iVo9i7sb+rhOtbkV
         jNPhiGyvuk3SfW5cxySYn1787idvlqrp8xL4aJC1RpX+jSkw2kq+7c1oRqhJzpIDBvft
         y4VhHrNUuMWjyOr9WzAI/FFZUCj77gB/gKx7q41QAC9RLA3+rU6Nyd0Wgeugvnxadrzp
         I2kQ==
X-Gm-Message-State: APjAAAV1XJkdQbB6Qsqe6DdRGW8G2GGM51q57+ql/hMISnY7pF4T3eKi
        viwTBo/I2r/KwEWWLw+pPP5Z+usWh4w=
X-Google-Smtp-Source: APXvYqyQ0YGPfGErlB97Ql1pCAIUrzC/nGiwLC0F+lrA2nquYsm718zy1jqHZRJ/vG2HIjgexdP3cQ==
X-Received: by 2002:a81:50c:: with SMTP id 12mr22280201ywf.380.1565544220073;
        Sun, 11 Aug 2019 10:23:40 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id l4sm1027236ywd.0.2019.08.11.10.23.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 11 Aug 2019 10:23:39 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>,
        xen-devel@lists.xenproject.org (moderated list:XEN BLOCK SUBSYSTEM),
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] xen/blkback: fix memory leaks
Date:   Sun, 11 Aug 2019 12:23:22 -0500
Message-Id: <1565544202-3927-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In read_per_ring_refs(), after 'req' and related memory regions are
allocated, xen_blkif_map() is invoked to map the shared frame, irq, and
etc. However, if this mapping process fails, no cleanup is performed,
leading to memory leaks. To fix this issue, invoke the cleanup before
returning the error.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 drivers/block/xen-blkback/xenbus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index 3ac6a5d..b90dbcd 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -965,6 +965,7 @@ static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
 		}
 	}
 
+	err = -ENOMEM;
 	for (i = 0; i < nr_grefs * XEN_BLKIF_REQS_PER_PAGE; i++) {
 		req = kzalloc(sizeof(*req), GFP_KERNEL);
 		if (!req)
@@ -987,7 +988,7 @@ static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
 	err = xen_blkif_map(ring, ring_ref, nr_grefs, evtchn);
 	if (err) {
 		xenbus_dev_fatal(dev, err, "mapping ring-ref port %u", evtchn);
-		return err;
+		goto fail;
 	}
 
 	return 0;
@@ -1007,8 +1008,7 @@ static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
 		}
 		kfree(req);
 	}
-	return -ENOMEM;
-
+	return err;
 }
 
 static int connect_ring(struct backend_info *be)
-- 
2.7.4

