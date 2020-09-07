Return-Path: <SRS0=p3ox=CQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590E1C433E2
	for <linux-block@archiver.kernel.org>; Mon,  7 Sep 2020 11:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1496B2168B
	for <linux-block@archiver.kernel.org>; Mon,  7 Sep 2020 11:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebJe3gca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgIGLj1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Sep 2020 07:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728608AbgIGL3B (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Sep 2020 07:29:01 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847FAC061574;
        Mon,  7 Sep 2020 04:29:00 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id z23so17710564ejr.13;
        Mon, 07 Sep 2020 04:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qC1Qe+Nb3BkoaUmyFCAr6TGZ4dkblgfNWZvGx4XV3VM=;
        b=ebJe3gcanTI8bgBT9KmcEKFhA084BTDUWBn3DlAo3yjyMlhegql8JBciYuC5iQsWfJ
         sOXnmaHy3jCI+xWGouQsSjtY4qbLZpRYoLKqmFlwzbOn3D9+6koC50qpddl2vWKTQvgs
         NmT5ciVzX9Y8XCbxTAsNWqj53TOpRpcbVdRoIhESZZmswYavfQoq2zxNkcHqODYEKAVq
         SOIIDZCQVFmm5DEPt8JZQmF9zXbii0CW21zMS/P1vcc1Wie+q0xaxAjbJmmbgVJW0BWc
         jCKjEPfRAIf0BIO7AIuqcNI/sQmCape6lj1O+egrIp72xyBt6K88K9Z3wl3/u+IKmCWj
         yJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qC1Qe+Nb3BkoaUmyFCAr6TGZ4dkblgfNWZvGx4XV3VM=;
        b=bFPlqLdLuodcXSjcm6BFBHU/0vgGO1iVh1CXy8IzJIjvQOIZeqX6VMFDxfSNS3cSaj
         iTZEC/LPOW/4ErWC2vxKwxvntwgVj45QQa48PnEhemGJrFRcj1fmvec+8nSLsrYoADo4
         dxf3bYKI1CYfrRyi6yPTjfqPtcCFgew6Z+2Sze31vKNRL7azyV2gnGdQ4SuWvjOcBENO
         qkToEYUQeRcf+2W2UOmr/QjLVQRmo+CdJH1OvH7Yto8tTWvWJhkv3VdjIu3zk724Wudu
         BeQUDeKQ0KSBwdrfKSXUBk2Hve3Lga4IHzgzMEdaIcST+R8xpOT+Vz9mLudEC8+KUmWY
         28kQ==
X-Gm-Message-State: AOAM530pT/qTAVKv52fOg9L0/9TRJp0GDk5K2ghB/nja2ys6/fG0AirI
        r9pEC9GqR7aUwK0fYAxXRsimsSkHOTWj2g==
X-Google-Smtp-Source: ABdhPJzTH3PYNIPavroQTHS7N3elLjN+rMaSvxkgVqGYPLb0M/V0QxPsG6tYM3Xdf6S+TsgP2xk6QQ==
X-Received: by 2002:a17:906:a0c2:: with SMTP id bh2mr21274577ejb.493.1599478139211;
        Mon, 07 Sep 2020 04:28:59 -0700 (PDT)
Received: from localhost.localdomain ([2a01:598:b902:e05f:7139:914b:4eed:99b3])
        by smtp.gmail.com with ESMTPSA id k6sm13826528edj.93.2020.09.07.04.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 04:28:58 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     beanhuo@micron.com
Subject: [PATCH v2 1/2] block: fix incorrect comment in vdc_port_probe()
Date:   Mon,  7 Sep 2020 13:28:44 +0200
Message-Id: <20200907112845.3420-2-huobean@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907112845.3420-1-huobean@gmail.com>
References: <20200907112845.3420-1-huobean@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

do_generic_file_read() has been renamed to eneric_file_buffered_read()
since commit 47c27bc46946 ("fs: pass iocb to do_generic_file_read"), so
relpace it with generic_file_buffered_read() in the comment.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/block/sunvdc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 39aeebc6837d..06262e990c9b 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -1017,9 +1017,9 @@ static int vdc_port_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 			 VDCBLK_NAME "%c", 'a' + ((int)vdev->dev_no % 26));
 	port->vdisk_size = -1;
 
-	/* Actual wall time may be double due to do_generic_file_read() doing
-	 * a readahead I/O first, and once that fails it will try to read a
-	 * single page.
+	/* Actual wall time may be double due to generic_file_buffered_read()
+	 * doing a readahead I/O first, and once that fails it will try to read
+	 * a single page.
 	 */
 	ldc_timeout = mdesc_get_property(hp, vdev->mp, "vdc-timeout", NULL);
 	port->ldc_timeout = ldc_timeout ? *ldc_timeout : 0;
-- 
2.17.1

