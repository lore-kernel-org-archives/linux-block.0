Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B763C43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 01:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7F8216FD
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 01:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVDBEcYK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbfD3Bcc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Apr 2019 21:32:32 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44895 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbfD3Bcb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Apr 2019 21:32:31 -0400
Received: by mail-qt1-f195.google.com with SMTP id s10so14340628qtc.11;
        Mon, 29 Apr 2019 18:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3lBPGifk0g/Ym5DzrymiWRCw58/24lXuhpA4w8u758o=;
        b=VVDBEcYKiveCHRGrj0VI42vziUd60oDkEsa//wmOyIo1CiYGSHRg7tQj6hQDIa167l
         BjmnulNGrqMlsJqJ9NMDDv4fokOAspNSHzqakJsLuiuEv/M4C0vKexL/rV59HXjsDZGC
         V9CA/IcVDM/p6Vrx5fBXlc8opKZfV66X+YRfCebj/OJJZhT44PHJ0u8AuhKlgM9+pxN5
         lbinGxS5tgeYtym9I3bYG46IsPvSXrFnR7hUTRvTMWOjaB0Tt2zFqplLEewiuyoQ0eMf
         aNUwi5gH7twMVJ2XQrUebwxMQAu4WTLakuucRXhUFwygIhGh6U51gI3l073tq4+Da1XZ
         wyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3lBPGifk0g/Ym5DzrymiWRCw58/24lXuhpA4w8u758o=;
        b=Qzd3TatspWE+7wXX6Yq71Fd+vDb6s1jO6UcV2Hi6oFxRkVi6UlPBJmcTKk7HtF7v1u
         KVNgEXcY160ab4KIj3I4hTf8BKNq9vH/tnjLZY0YPpsXBqXGBsCsQvMZsUQwN/fnB0sw
         wZM1bhT3Mew1JlhNCZfVcZyMjGl8RPlSTWEmwc79KvCsISh/VXVA7ggPWUfY+aN+lZOw
         5gcV6k30n+3ubpVaHnZ984k2rim5L4E0K4hB9pkW079sYsgCx+kWMKkvZlqZfaHWz6dq
         Bixv/qrM+s0ip5ONezZAKh/xUGvkdhcWUPTHFMK/QePda2FQIHV+vXJznI1OlWFn3adk
         994g==
X-Gm-Message-State: APjAAAWmEpJOjOaBDLFRBGltL2bCdbXkE9OCnholUgJdw7Ibd5FJVll9
        SpOqwNfrq2lYFTVtAn1VSfSbABeo
X-Google-Smtp-Source: APXvYqzxITbuuxn8ug7+GUYHKrHT6635+MSesPFyFH2L7G4OTw+rfAuViCami29mdFcTcpEN3iM4CQ==
X-Received: by 2002:aed:35fa:: with SMTP id d55mr27349020qte.169.1556587950213;
        Mon, 29 Apr 2019 18:32:30 -0700 (PDT)
Received: from laptop.suse.cz ([179.185.223.166])
        by smtp.gmail.com with ESMTPSA id v57sm5127019qtc.10.2019.04.29.18.32.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 18:32:29 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Greg Edwards <gedwards@ddn.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] blkdev.h: Introduce size_to_sectors hlper function
Date:   Mon, 29 Apr 2019 22:32:04 -0300
Message-Id: <20190430013205.1561708-2-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190430013205.1561708-1-marcos.souza.org@gmail.com>
References: <20190430013205.1561708-1-marcos.souza.org@gmail.com>
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
 Reworked the documentation of size_to_sectors by removing a sentence that was
 explaining the size -> sectors math, which wasn't necessary given the
 description prior to the example. (suggested by Chaitanya)

 include/linux/blkdev.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 317ab30d2904..f6cfe6970756 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -871,6 +871,23 @@ static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
 #define SECTOR_SIZE (1 << SECTOR_SHIFT)
 #endif
 
+/**
+ * size_to_sectors - Convert size in bytes to number of sectors of 512 bytes
+ * @size: size in bytes to be converted to sectors
+ *
+ * Description:
+ * Kernel I/O operations are always made in "sectors". In order to set the
+ * correct number of sectors for a given number of bytes, we need to group the
+ * number of bytes in "sectors of 512 bytes" by shifting the size value by 9,
+ * which is the same than dividing the size by 512.
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

