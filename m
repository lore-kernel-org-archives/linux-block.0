Return-Path: <SRS0=ouS0=TC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC120C43219
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 01:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79941205C9
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 01:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EF+G73WB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfEBB5t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 21:57:49 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45839 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfEBB5s (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 21:57:48 -0400
Received: by mail-qt1-f195.google.com with SMTP id t1so51875qtc.12;
        Wed, 01 May 2019 18:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z+DRQaFjZkBlZYOjQJXjHBpmiOuABPVHwmMcg8Ng0pg=;
        b=EF+G73WBZk1M7Xoi3RyKWPF+13GKMkKe9MjVF+zQsg4hIUYj418u686I5KU1WDbrco
         DdhJ/za0mzWk4alweKYT2vGuVOGQT/H50P7+E6RjGUm8RIIKeQj2VlmyOCiHgqxirpJo
         OXD5N6IDmKF8eEZi0J9zuzXBDIdkEIOk3YIJOzUNf5peUkEUxukBkdeI6BXA0f06w7t2
         nJcPEv9wFb1OvrOX1QkZ17MPoJwwvNg6fK7bRRlk+5cGCy2PFyxpN4++CMy9pHtxeOja
         7Furc0HOXpB8KyeTanrig84OfZWf5Zv+KDyBO89cpkWWs088qkpgZHsAAIePkHjssXdn
         wtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z+DRQaFjZkBlZYOjQJXjHBpmiOuABPVHwmMcg8Ng0pg=;
        b=APUch7H2eIquwMLV2ulVSCLfUstwCnFpJBJLzSISYRS7H/s6C98vNEItU8H5LsyaRP
         yEgKmpe9khe9nHC6iQf9CRQ875pwpr/2lm7G/NiABQetNNhAnOZv6EsCo8Yyzqoqiewx
         49XN25RuTUGgbjylF6l9c9zjQyUU+1uspoS3dpHX/+YHKC+yMoh6dBqG6fYn1z2+BNOd
         uPTeaOO20Z0xQ/oYTQXRPuwPUe7NMnJ4EpbZaM5QKhrDPkl27IG1rud40b43xq52V8fB
         MyLs/vPf6P7b2kK8pRZlv513HOCPAYZ3ftx2Ic0/VdCCsFl9fu9IKVxj7dHG9JwgoOBp
         aUVg==
X-Gm-Message-State: APjAAAWLvXgIFg6VySPj8YFjbhj6cvlf950BPiHQqjmuUAAq4xwKlG8i
        6jPPE/kYX3sicfg5zrb5H8qLZVtzp6U=
X-Google-Smtp-Source: APXvYqy7LW/LUMw4O7vB+JMioj0y9zvvE+9HVQB3/3M1B7S640Jp8OxbzTdOnco4YkD+yRWmVQdfAg==
X-Received: by 2002:a0c:99d7:: with SMTP id y23mr1171716qve.0.1556762267214;
        Wed, 01 May 2019 18:57:47 -0700 (PDT)
Received: from localhost.localdomain (189.26.185.89.dynamic.adsl.gvt.net.br. [189.26.185.89])
        by smtp.gmail.com with ESMTPSA id d55sm9031059qtb.59.2019.05.01.18.57.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 18:57:46 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Greg Edwards <gedwards@ddn.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] blkdev.h: Introduce bytes_to_sectors helper function
Date:   Wed,  1 May 2019 22:57:27 -0300
Message-Id: <20190502015728.71468-2-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190502015728.71468-1-marcos.souza.org@gmail.com>
References: <20190502015728.71468-1-marcos.souza.org@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This function takes an argument to specify the size of a block device,
in bytes, and return the number of sectors of 512 bytes.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 Changes from v1:
 Rename size_to_sectors to bytes_to_sectors. (Martin K. Petersen)

 Changes from RFC:
 Reworked the documentation of size_to_sectors by removing a sentence that was
 explaining the size -> sectors math, which wasn't necessary given the
 description prior to the example. (suggested by Chaitanya)

 include/linux/blkdev.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 317ab30d2904..7ade2e24dbae 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -871,6 +871,23 @@ static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
 #define SECTOR_SIZE (1 << SECTOR_SHIFT)
 #endif
 
+/**
+ * bytes_to_sectors - Convert size in bytes to number of sectors of 512 bytes
+ * @bytes: number of bytes to be converted to sectors
+ *
+ * Description:
+ * Kernel I/O operations are always made in "sectors". In order to set the
+ * correct number of sectors for a given number of bytes, we need to group the
+ * number of bytes in "sectors of 512 bytes" by shifting the size value by 9,
+ * which is the same than dividing the size by 512.
+ *
+ * Returns the number of sectors by the given number of bytes.
+ */
+static inline sector_t bytes_to_sectors(long long bytes)
+{
+	return bytes >> SECTOR_SHIFT;
+}
+
 /*
  * blk_rq_pos()			: the current sector
  * blk_rq_bytes()		: bytes left in the entire request
-- 
2.16.4

