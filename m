Return-Path: <SRS0=4R18=SX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F28C10F14
	for <linux-block@archiver.kernel.org>; Sun, 21 Apr 2019 03:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF542087B
	for <linux-block@archiver.kernel.org>; Sun, 21 Apr 2019 03:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIk0kN3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfDUDxr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 Apr 2019 23:53:47 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36004 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfDUDxq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 Apr 2019 23:53:46 -0400
Received: by mail-qk1-f196.google.com with SMTP id m137so1155229qke.3;
        Sat, 20 Apr 2019 20:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IvxGTb8AoTq5GFeQK0fb90Mx9pOWLC32arwZ/LH3koE=;
        b=HIk0kN3Vong/hekQM3Xbagq94QRTNYMFmqICCK3UXq3EY3OJgQLhWpRJefpq+EkXzk
         GX2rI/8T1dM9Pmzvp2n0RBsTpGlxR/WjsiL8WqfYy5C7sFJR0vjhBixW3JDNCrAxAmjT
         Bbv66z4fcHcVSz0yYq3IAbMZfxhbcK5kc2+B/zQcFxriF96/a8kdy0g3CXXUhv1N3pRT
         D4d7C1We/Wxd+UzaUlOmYQG41s1o+vYRuGV4ExMW46p2uAktAvaEgkuoYQYcukOA/Lds
         dN9hzht6V25TubSZ0NOsv5o5sH4cPlaPsj31qSOrJXH0wAp78XzkeopI6bZkYgw4+GXw
         hGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IvxGTb8AoTq5GFeQK0fb90Mx9pOWLC32arwZ/LH3koE=;
        b=SX1uXZmSjYaWDEtMp+8bNOcHSESNIkPNyPvHu2+l40+4hqa7gLsTX5vZsLMUGwY8Ro
         vVdr+Brn8wmFc+ec0ga82OTAbcUg2PM5FJho38zlyv+wWcanSqp9aivG3+d/WQPGsNcw
         DaVvIs9TzogqNmeLsvI2rRi83TAfIeffdD23puch/Owl1YpmL96yzzDMhjrtdh0sVQDg
         2v+oVLJD9nX8dTO1tmagb6POpZfsH8MITqZcShXjC6+PLuRdAMdao+RH6ewHsWnl5VLy
         XB9XixDOxlMwuSPCxK8k5a1er2BBEJsALCunUqv7S4Xx9qRAuXRMXLsrRU/Uj0xW0ul+
         AnTA==
X-Gm-Message-State: APjAAAUwANdp+PJZSQr/klIK3TuZ6VsAZrbCqrIfGmXbzRkXNxGc3DLN
        Y71+cjS+0g+TqAVbJEzOd+4UniMGy3M=
X-Google-Smtp-Source: APXvYqyAmpsb0s3JHv4yEoeROCX5AO7osiIeMw0pFbPoKseCVnqw1jarpkLrPmpGJnJQLzcpSJbb6w==
X-Received: by 2002:a05:620a:150b:: with SMTP id i11mr9392824qkk.14.1555818825157;
        Sat, 20 Apr 2019 20:53:45 -0700 (PDT)
Received: from localhost.localdomain ([177.96.46.237])
        by smtp.gmail.com with ESMTPSA id b37sm7341398qtb.92.2019.04.20.20.53.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 20:53:44 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Greg Edwards <gedwards@ddn.com>,
        Hannes Reinecke <hare@suse.com>, linux-block@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [RFC PATCH 1/2] blkdev.h: Introduce size_to_sectors hlper function
Date:   Sun, 21 Apr 2019 00:53:27 -0300
Message-Id: <20190421035328.19322-2-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190421035328.19322-1-marcos.souza.org@gmail.com>
References: <20190421035328.19322-1-marcos.souza.org@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This function takes an argument to specify the size of a block device,
in bytes, and return the number of sectors of 512 bytes.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 include/linux/blkdev.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 317ab30d2904..7bf7b99161b7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -871,6 +871,24 @@ static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
 #define SECTOR_SIZE (1 << SECTOR_SHIFT)
 #endif
 
+/**
+ * size_to_sectors - Convert size in bytes to number of sectors of 512 bytes
+ * @size: size in bytes to be converted to sectors
+ *
+ * Description:
+ * Kernel I/O operation are always made in "sectors". In order to set the
+ * correct number of sectors for a given number of bytes, we need to group the
+ * number of bytes in "sectors of 512 bytes" by shifting the size value by 9,
+ * which is the same than dividing the size by 512. For example, for a capacity
+ * of 32M (33554432 bytes), the number of sectors will be 65536.
+ *
+ * Returns the number of sectors by the given number of bytes.
+ */
+static inline sector_t size_to_sectors(long long size)
+{
+	return size >> SECTOR_SHIFT;
+}
+
 /*
  * blk_rq_pos()			: the current sector
  * blk_rq_bytes()		: bytes left in the entire request
-- 
2.16.4

