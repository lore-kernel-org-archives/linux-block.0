Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FC323FC42
	for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503918; cv=none; b=fPHQV5z3zBa0PKCSTe0AXQYcpnqyf1d2NSM9ngAY5SlfGLXN6VpbzJe4c4cKLc886ZVvkwENZlGIV6q0KmDeJZ+iAZs1eOzdH6iwro2TBEn6ckiqoFSV0ozlOuYd/rY0OWU0GIJ/PgQBz5nVUt0GgZ5FO1C6Wph4jmTKSAPm+Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503918; c=relaxed/simple;
	bh=fhDkuG1yIE1LQ3pKVS/RWsEChi2G/eQGi73JJYRF2K4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BSjm1k2OFiqOrXv+BjYsQoVjTurY9sCHK136OYNYezr/M9N193QaNRBClp+U/zuS3SFCJNqMP+wDB1iZm/xVG2bwZGNEgOJVmoZkS+/ujQwyz5cPQABLzKdxn7qSdTzeI5Eo/Oz0My7O5Br5OsX/opOppdKpQN2rGJHciEWkqEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YISaJ0G7; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YISaJ0G7"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752503916; x=1784039916;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fhDkuG1yIE1LQ3pKVS/RWsEChi2G/eQGi73JJYRF2K4=;
  b=YISaJ0G7vYjqWMtCm5mKFrhjufyTfWFxmIt9Tcbltqw0I7+LcxpYVd88
   ZKw9DtE8YrI6XUhsloFltZc7jajGxcpj2kOCC4eyk7J6pT+LzxRUSoxd0
   CEfxs9UpaJN8TxDKYpWlnbSpBwTxBY399isqxMzHdqd8unXoxHg1cEbFm
   45iHPXPEJSvXhO580rAbkEcAslbbTMyUUVQxkB1IjyO4Ks3rn+SBm9ToG
   aLWKOaGTXitd0/fKkQXeZAbf6jvXDW/YYBFN1yb+t9Wiv/lmueMlDFSJg
   I91jlk9yNIF5L7RQk+VO3FByAFOcmC5HEhfz9GSHYhQP4LRRrKV5bvHTj
   g==;
X-CSE-ConnectionGUID: fyz94YuzTVqbCk0Tl5P6QA==
X-CSE-MsgGUID: hUHRIzulS5O0NAk/smADmQ==
X-IronPort-AV: E=Sophos;i="6.16,311,1744041600"; 
   d="scan'208";a="86591348"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2025 22:38:32 +0800
IronPort-SDR: 687507c9_/nQfGWSE9pv0NGQ9EZHmWzMmZMR0R/SxOmPUGwE20qn6QWe
 4BqaxvvYRPqpjThVF5RnV52Ba1KABfXY6F15hZg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jul 2025 06:36:09 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Jul 2025 07:38:30 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 1/5] blktrace: add zoned block commands to blk_fill_rwbs
Date: Mon, 14 Jul 2025 16:38:21 +0200
Message-Id: <20250714143825.3575-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250714143825.3575-1-johannes.thumshirn@wdc.com>
References: <20250714143825.3575-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add zoned block commands to blk_fill_rwbs:

- ZONE APPEND will be decoded as 'ZA'
- ZONE RESET and ZONE RESET ALL will be decoded as 'ZR'
- ZONE FINISH will be decoded as 'ZF'
- ZONE OPEN will be decoded as 'ZO'
- ZONE CLOSE will be decoded as 'ZC'

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/trace/events/block.h |  2 +-
 kernel/trace/blktrace.c      | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 14a924c0e303..d88669b3ce02 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -11,7 +11,7 @@
 #include <linux/tracepoint.h>
 #include <uapi/linux/ioprio.h>
 
-#define RWBS_LEN	9
+#define RWBS_LEN	10
 
 #define IOPRIO_CLASS_STRINGS \
 	{ IOPRIO_CLASS_NONE,	"none" }, \
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 3f6a7bdc6edf..e0fdefe374b4 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1875,6 +1875,29 @@ void blk_fill_rwbs(char *rwbs, blk_opf_t opf)
 	case REQ_OP_READ:
 		rwbs[i++] = 'R';
 		break;
+	case REQ_OP_ZONE_APPEND:
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'A';
+		break;
+	case REQ_OP_ZONE_RESET:
+	case REQ_OP_ZONE_RESET_ALL:
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'R';
+		if ((opf & REQ_OP_MASK) == REQ_OP_ZONE_RESET_ALL)
+			 rwbs[i++] = 'A';
+		break;
+	case REQ_OP_ZONE_FINISH:
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'F';
+		break;
+	case REQ_OP_ZONE_OPEN:
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'O';
+		break;
+	case REQ_OP_ZONE_CLOSE:
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'C';
+		break;
 	default:
 		rwbs[i++] = 'N';
 	}
@@ -1890,6 +1913,8 @@ void blk_fill_rwbs(char *rwbs, blk_opf_t opf)
 	if (opf & REQ_ATOMIC)
 		rwbs[i++] = 'U';
 
+	WARN_ON_ONCE(i >= RWBS_LEN);
+
 	rwbs[i] = '\0';
 }
 EXPORT_SYMBOL_GPL(blk_fill_rwbs);
-- 
2.50.0

