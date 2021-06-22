Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D9BC2B9F4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 23:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47F3960FE3
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 23:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhFVXWh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 19:22:37 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:13293 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhFVXWg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 19:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624404021; x=1655940021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FHYthCo6y2D8P2noT1iu3VWbPN7E+He+UXKaBy5aFXY=;
  b=WCGkTjpIPCvm9SfcQPl1AUF4OEfUG0vukm81Xz5UF0qDFNhrHy8U9rDw
   oRV2idTIcjOE3yhWdkz0saln6sxmOjPXX19vE+ssK8Q6nHColHdgUwMpG
   pWWNA3wGYNBA3bV8n0buCebwislVQMyjnkqkVwl03OarpqqtBcvlgc4VQ
   HIqKAFhkKZqP9MBtoEXgJrec9xp4ylapi9NXC1M7MVc/R4VcD7apwilKz
   PZ+8iU6is7QQo2MK8EKmylIYXH30rw4kn6nU9mqnLNsGhiny78fPHdzgm
   9DHWBQOMzbfONCa1t90Sz0p3/ZmvCjUXdkcPkKQB0ExuKoDN+PidPPQdZ
   Q==;
IronPort-SDR: ix6eArFwIsHOS/et80oVkIysl9LQykNWEs3EoDRaD8CAxbCsaxv1lvvb943V7mPOBgGF2rU76R
 KHQkyMhFgW8cI9BaZboFZn2qpr0nAbIOvv4gAcHsKxwHYOebP6Iqg+l1fX0w2fGCGC8U6hei3a
 X2tfhAAbQQgm+fcDjBOe3lqZDND7JkD8mj72h3+pB0hgqCM4CkSGbar09gsTTsPWN2HMlG5DuF
 z9fyKLeFH9ptY/1x3IZNs8PyGONSwbWIgzUmV2VEcTnZ7fPn7Vf7zcHf+Yp9G0bjBsFoiQ08aA
 /A4=
X-IronPort-AV: E=Sophos;i="5.83,292,1616428800"; 
   d="scan'208";a="276419072"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2021 07:20:29 +0800
IronPort-SDR: DBYSUF+fSlcmDZeunPrnhfpgPIU8MJEG2PXazkNCdKAJtMPOD1oWP3bW4ycpVkIGdzLXrwgN3l
 nlBrT1wmlNp4z5pH92Eh8L5LsQFFhvobVl5kAYk2P8zE/S6RlfzWqI68fErl5xTFPix3kSknkf
 Ltfltr8HqDIy5TXWpZDoS62KAfDYDQ4kY9xdSTlrwSMBo7d+qJPk2/wpCf0lgSgGJx0UZ/KM7K
 DHkL0pSvjDDPs8pRmnPzMVVEMy+XgsMcu275LkfQoAafCPSwbXixtp60iJValxLTZ0bVNr8l5+
 JNPxPTiNZcmZR5QSqSZR6jn+
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 15:57:26 -0700
IronPort-SDR: 3j0+j1yabzmT1QTW92oQHXoYoopE2TjIUIBAULgDV8iGwxJVni45uNv+6Y5OxtM95UFHiQBDFY
 ILgjqcEomYIqAwU7EB/ub/UGRKUdpbhCV/T4fttFxr7woVphQRJkoX466ZvKWo93KIhzNnKgMp
 pIxrfhRe9E48Qgx8uOc40WdlVlB16r3IJ7anz/GzEIiBw/LzrdYBfkgrSBpbYwgS3HTl6XgMsG
 EJEmK7B12U8SQHAHK6QThQ4gYVMJMRQvpeQ/ixKFHtq6iiqfmk/K0eOBBDv2zIpNOZo5/kBynz
 Yzw=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Jun 2021 16:20:10 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 1/9] loop: use sysfs_emit() in the sysfs offset show
Date:   Tue, 22 Jun 2021 16:19:43 -0700
Message-Id: <20210622231952.5625-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210622231952.5625-1-chaitanya.kulkarni@wdc.com>
References: <20210622231952.5625-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Output defects can exist in sysfs content using sprintf and snprintf.

sprintf does not know the PAGE_SIZE maximum of the temporary buffer
used for outputting sysfs content and it's possible to overrun the
PAGE_SIZE buffer length.

Use a generic sysfs_emit function that knows that the size of the
temporary buffer and ensures that no overrun is done for offset
attribute.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 081eb9aaeba8..847faa6c48fc 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -807,7 +807,7 @@ static ssize_t loop_attr_backing_file_show(struct loop_device *lo, char *buf)
 
 static ssize_t loop_attr_offset_show(struct loop_device *lo, char *buf)
 {
-	return sprintf(buf, "%llu\n", (unsigned long long)lo->lo_offset);
+	return sysfs_emit(buf, "%llu\n", (unsigned long long)lo->lo_offset);
 }
 
 static ssize_t loop_attr_sizelimit_show(struct loop_device *lo, char *buf)
-- 
2.22.1

