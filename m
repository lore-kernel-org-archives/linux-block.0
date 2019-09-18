Return-Path: <SRS0=kmcw=XN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5816BC4CECD
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 00:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF8121848
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 00:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UnGEhq92"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfIRAzL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Sep 2019 20:55:11 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:4763 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbfIRAzL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 20:55:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1568768130; x=1600304130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ufJiB5njckAu/mFbbQrBrCW8lvYvyVmoxsJsJd4rw3E=;
  b=UnGEhq92mRWGoSJf3LDm+imNZ/vxBabOJhyYhO88gVcYL2wbc1/61VKJ
   MUQW0phCshC5zauIiDo2LmK9bGwbLErpdWZSynEHP0TUAkab6MwA6QabW
   KMoGFyLpDys6L9cfzUcKPEilqWQKKl/E6Gy9jsdLM7l3Rx9YnPxg5lznd
   zwwMJdaQOtboX8pt7G46X38X2lDk5cNi09C4DHx05d4//Dy3lTKwAKXE/
   i4JbAmmu7ooWt1XFjtAGvqm1q0/tuKyLh3+ts9Vyp+N7QjTC6rHypdQLA
   F1m5S4G7Q0Ug7uI1MNPnEazAG25cKZnZmsqwjL1N+inzNXQvWtE0mqyOZ
   A==;
IronPort-SDR: D3v7YiD5vgYnarQWpIFJk8hZ4T1tnoIPZtZDRXV6//l8L188+azwEsxlIUFT655GF1Zpzau8ww
 Efc3Ih1+iSwr0McR3C3cBv2vjVfohJN9Kdsfmjvg8fEJEGfPw+3QbZFs/hDK70ZzubBOP0u5rL
 WGjs143Sqq+dksuU8nN/eWlg7UkJ5xmpXQz+cMb17Ann7/DIdttrI4dFW8tBa1QYPhCCGwsPcW
 t5aWxsmX2CS9Eswz7jaG9/rlxrvgkS2PJJMrleSgxw1tWOP9+FIknP2XTDbOKQMzgERZjQ2eOT
 PRM=
X-IronPort-AV: E=Sophos;i="5.64,518,1559491200"; 
   d="scan'208";a="219271976"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2019 08:55:30 +0800
IronPort-SDR: g6cKKs0zNYYiaJmZxBSGYt8Sbf2EQdoSJDkET8KN7boQ4hrNoqn48n7SPbysi8mjS/nPqtbsV1
 QZjUWQHmQO4ovPjV0BpcA/x/Pr2VwoLOw4ysvgM4V4oIUqYv8S4C7l+t90b45HwFCR9FOvQ98N
 ZK8KlC+Qh7OhYZ6yhGxXMbMbLV52h0zJBD1Yc4zr9C8DbGWJn6d2Q73VrWbdknp6KaVTGgBHvT
 YERnyO3PqQNdqUym4x+VQOFmAy13QoTd214T+b4fmDrOk0rgM7YJH4k+edriklXW4AhuM/huYV
 xT0wzCPW0bAlwvJRwb5vV01H
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2019 17:51:40 -0700
IronPort-SDR: gRlkeU3HfwkYKTDbjnEVINUiBnQAwY0CHI1mKWNpEZbU2YMWCCZ7h+ghYfYnQ2u8psredrr4ih
 r7T2j2YEOeHNeLCV22xKYO5yog5sKRrMvS3z2BH0HoLg/7eprjVIrefGxU1dOU+ieRuxVNni65
 cy7ABGFgKygARr0zED7bO0P4qfMPJbokIlM/7q2gIXttTTg2JEwNIO6oYob5SbMXCBYKueOmhV
 jaEr39i/zPuh2vLgeR/wHK3jRV9Hh5WUCoi0tT/NHn2272EUfyxZ9PxjXGpkBe0thxGFCszLjX
 H5A=
WDCIronportException: Internal
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Sep 2019 17:55:10 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, osandov@fb.com, bvanassche@acm.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 1/2] block: add helper to check mergeable req op
Date:   Tue, 17 Sep 2019 17:54:53 -0700
Message-Id: <20190918005454.6872-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190918005454.6872-1-chaitanya.kulkarni@wdc.com>
References: <20190918005454.6872-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 include/linux/blkdev.h | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6032bb740cf4..34fecc1a3a28 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -741,23 +741,33 @@ static inline bool rq_is_sync(struct request *rq)
 	return op_is_sync(rq->cmd_flags);
 }
 
-static inline bool rq_mergeable(struct request *rq)
+static bool rq_mergeable_op(enum req_opf op)
 {
-	if (blk_rq_is_passthrough(rq))
-		return false;
+	bool ret;
 
-	if (req_op(rq) == REQ_OP_FLUSH)
+	if (blk_op_is_private(op) || blk_op_is_scsi(op))
 		return false;
 
-	if (req_op(rq) == REQ_OP_WRITE_ZEROES)
-		return false;
+	switch (op) {
+	case REQ_OP_FLUSH:
+	case REQ_OP_WRITE_ZEROES:
+		ret = false;
+		break;
+	default:
+		ret =true;
+	}
+	return ret;
+}
 
+static inline bool rq_mergeable(struct request *rq)
+{
 	if (rq->cmd_flags & REQ_NOMERGE_FLAGS)
 		return false;
+
 	if (rq->rq_flags & RQF_NOMERGE_FLAGS)
 		return false;
 
-	return true;
+	return rq_mergeable_op(req_op(rq));
 }
 
 static inline bool blk_write_same_mergeable(struct bio *a, struct bio *b)
-- 
2.17.0

