Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D7D5103F
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 11:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752580420; cv=none; b=boY1O9E7huIZmXmyaOrq3A/ISpB2hSGcqAc6DmjSnPc1+3T7LOPiIzgghX80yxrnx/q/QuNp9HI/TV+6rZY/owb1Rzvz3oivUu0RtQVAD3M3rkNJY8DsWRNwkmo1ouOglsfJAzMhj9xoV7w79mWOGsjsG6EI24IXWK3osBT/iJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752580420; c=relaxed/simple;
	bh=TiQ0o5i5/f1vBeL0IbmGhKG1XJt+cNQQdzIIh9lEI0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bnQgRwRx1haVc/dIEuTqc5JqlunKs/hosmLUmMuNcygaVOKOpscGWKAx4BPcia7w7PviNhzN9cb0iGTGRcKBviduEwZu2nzAdUXsQy+EniHGRksxADCJW26b3odR1jzog0fIvO1MiiMUfSas09H4jb2TrkSUZ/f9xLxiHav2a3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cmTuWVn6; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cmTuWVn6"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752580418; x=1784116418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TiQ0o5i5/f1vBeL0IbmGhKG1XJt+cNQQdzIIh9lEI0Q=;
  b=cmTuWVn6pudGpmvcp6xxasG3RjNic2tgOhiJn4ydVExWfXzDGDx0wNX/
   f2/WpdgE6vyNsrhsxhiEfy3vMh9AaXMkPjr23LlqZj493AcGBw+AGHQjG
   UDl5CfHTunWeVqST4T0+89Sr0Fla5cpXKJQkjFSn48jpJ+YgDfZDzRgZm
   NmeMusQWT9DiFWw7Y0IiaIFopaclRbZDn+gIEXE095FIvhyBZ9LQZ+t3U
   9oLRpxQUT6JJmDftVYg5IMi5b2txD4/F8jGXWwj61HXwdBIiw5QgdAP0R
   wYwhTAlb2aFIzUlKlIPl90CUToanLZQYHUxIXK6foNjhWBGTqmOEPeF8v
   Q==;
X-CSE-ConnectionGUID: xRCay86uT0mLQBHAd7EkEg==
X-CSE-MsgGUID: Q9+cs4//RKSV5oc2qf388w==
X-IronPort-AV: E=Sophos;i="6.16,313,1744041600"; 
   d="scan'208";a="87768578"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jul 2025 19:53:38 +0800
IronPort-SDR: 687632a1_SyOpv9NJKEUtInZplqG2KwpVLqArDEqG+AFmxU31uu0tzOi
 iatYCWv7FigFxbrD5FUeXMYI+OBMgKLewIkPuag==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jul 2025 03:51:14 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Jul 2025 04:53:37 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	linux-block@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v3 1/5] blktrace: add zoned block commands to blk_fill_rwbs
Date: Tue, 15 Jul 2025 13:53:20 +0200
Message-Id: <20250715115324.53308-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250715115324.53308-1-johannes.thumshirn@wdc.com>
References: <20250715115324.53308-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add zoned block commands to blk_fill_rwbs:

- ZONE APPEND will be decoded as 'ZA'
- ZONE RESET will be decoded as 'ZR'
- ZONE RESET ALL will be decoded as 'ZRA'
- ZONE FINISH will be decoded as 'ZF'
- ZONE OPEN will be decoded as 'ZO'
- ZONE CLOSE will be decoded as 'ZC'

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
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
index 3f6a7bdc6edf..47168d2afbf1 100644
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
+			rwbs[i++] = 'A';
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

