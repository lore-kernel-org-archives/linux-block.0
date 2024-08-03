Received: from lounge.grep.be (lounge.grep.be [144.76.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB249847B;
	Sat,  3 Aug 2024 13:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722691680; cv=none; b=sFONsCUQRgzRdWZfdO3JUK3vVHEtmHpuyChiKlCYp2lHRynNjxyXcj/wXl0M4OYvq6DexiXVy/DtKVV5IdE+YsccLhxQ5RJydhyTaPaCAo1eIkMPKscIJwNyXQgywhOgoOt/rmV3dFEYkDqVDvAsGLSULTsb8Uv/OjEEP9hwWIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722691680; c=relaxed/simple;
	bh=lBtW6B9bCQWBP7gNW6PL+A+p4hgYnhTrL80VojCqqK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YVh6h0ysOFelaeaMh+zHI7RD5C13wyuZcrCLMS0GeJFhYL9D7ZG84jGuHS2nF/aeZb8hHuUm+GSxbrrF/c35HKUdiD/A7i7egRxWKJfQuBsajbKqLNzjqzdct3R/q4A9wDnUXBMPjDuMH1huGqgFnnOUyk1nyWqFhtrar+yTPhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uter.be; spf=pass smtp.mailfrom=grep.be; dkim=fail (0-bit key) header.d=grep.be header.i=@grep.be header.b=XZT3XKFc reason="key not found in DNS"; arc=none smtp.client-ip=144.76.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uter.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grep.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=grep.be header.i=@grep.be header.b="XZT3XKFc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=grep.be;
	s=2017.latin; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mTmrVs40Cd7CzbdJDjAxo2PlQHK4j3xD7Gp2kwSFalY=; b=XZT3XKFcrTcnILrWffFUGC+EnY
	AsCxRvwdh0ss5Ea1fl2jvYnwr4CQ9DbVdzeZ7UWWtZ3I7AbZLLjzCZTpp/8PNwaRSpClU8x+/Kqj1
	frwB0XIdMNoaOV7KIdyvw73NrTUXKmUurw3azOtj4q+h2zEEYJ7gt2x3jJNeQsY+lh65uAVUaaKMP
	pvwPkuzULAqT0wXFggzs99ZcXB7FymzYf+a1S0f7cV15L2w5ayhEIiUncj5IgPgATuVL3EQnvwn6p
	cQzV1rO5NlEXLseQppLpUBLNNl3/m5kZlg+5N+gUdJhvytoLKueSzf+KFLpcuVC/U9h1xcaQGoYDR
	ouUdTUAg==;
Received: from [102.39.154.62] (helo=pc220518)
	by lounge.grep.be with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <wouter@grep.be>)
	id 1saERy-00CawW-1s;
	Sat, 03 Aug 2024 15:05:34 +0200
Received: from wouter by pc220518 with local (Exim 4.98)
	(envelope-from <wouter@grep.be>)
	id 1saERr-000000001ZC-0nJ7;
	Sat, 03 Aug 2024 15:05:27 +0200
From: Wouter Verhelst <w@uter.be>
To: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Wouter Verhelst <w@uter.be>,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] nbd: implement the WRITE_ZEROES command
Date: Sat,  3 Aug 2024 15:04:30 +0200
Message-ID: <20240803130432.5952-1-w@uter.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NBD protocol defines a message for zeroing out a region of an export

Add support to the kernel driver for that message.

Signed-off-by: Wouter Verhelst <w@uter.be>
---
 drivers/block/nbd.c      | 8 ++++++++
 include/uapi/linux/nbd.h | 5 ++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 5b1811b1ba5f..215e7ea9a3c3 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -352,6 +352,8 @@ static int __nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
 	}
 	if (nbd->config->flags & NBD_FLAG_ROTATIONAL)
 		lim.features |= BLK_FEAT_ROTATIONAL;
+	if (nbd->config->flags & NBD_FLAG_SEND_WRITE_ZEROES)
+		lim.max_write_zeroes_sectors = UINT_MAX;
 
 	lim.logical_block_size = blksize;
 	lim.physical_block_size = blksize;
@@ -421,6 +423,8 @@ static u32 req_to_nbd_cmd_type(struct request *req)
 		return NBD_CMD_WRITE;
 	case REQ_OP_READ:
 		return NBD_CMD_READ;
+	case REQ_OP_WRITE_ZEROES:
+		return NBD_CMD_WRITE_ZEROES;
 	default:
 		return U32_MAX;
 	}
@@ -637,6 +641,8 @@ static blk_status_t nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd,
 
 	if (req->cmd_flags & REQ_FUA)
 		nbd_cmd_flags |= NBD_CMD_FLAG_FUA;
+	if ((req->cmd_flags & REQ_NOUNMAP) && (type == NBD_CMD_WRITE_ZEROES))
+		nbd_cmd_flags |= NBD_CMD_FLAG_NO_HOLE;
 
 	/* We did a partial send previously, and we at least sent the whole
 	 * request struct, so just go and send the rest of the pages in the
@@ -1706,6 +1712,8 @@ static int nbd_dbg_flags_show(struct seq_file *s, void *unused)
 		seq_puts(s, "NBD_FLAG_SEND_FUA\n");
 	if (flags & NBD_FLAG_SEND_TRIM)
 		seq_puts(s, "NBD_FLAG_SEND_TRIM\n");
+	if (flags & NBD_FLAG_SEND_WRITE_ZEROES)
+		seq_puts(s, "NBD_FLAG_SEND_WRITE_ZEROES\n");
 
 	return 0;
 }
diff --git a/include/uapi/linux/nbd.h b/include/uapi/linux/nbd.h
index d75215f2c675..f1d468acfb25 100644
--- a/include/uapi/linux/nbd.h
+++ b/include/uapi/linux/nbd.h
@@ -42,8 +42,9 @@ enum {
 	NBD_CMD_WRITE = 1,
 	NBD_CMD_DISC = 2,
 	NBD_CMD_FLUSH = 3,
-	NBD_CMD_TRIM = 4
+	NBD_CMD_TRIM = 4,
 	/* userspace defines additional extension commands */
+	NBD_CMD_WRITE_ZEROES = 6,
 };
 
 /* values for flags field, these are server interaction specific. */
@@ -53,11 +54,13 @@ enum {
 #define NBD_FLAG_SEND_FUA	(1 << 3) /* send FUA (forced unit access) */
 #define NBD_FLAG_ROTATIONAL	(1 << 4) /* device is rotational */
 #define NBD_FLAG_SEND_TRIM	(1 << 5) /* send trim/discard */
+#define NBD_FLAG_SEND_WRITE_ZEROES (1 << 6) /* supports WRITE_ZEROES */
 /* there is a gap here to match userspace */
 #define NBD_FLAG_CAN_MULTI_CONN	(1 << 8)	/* Server supports multiple connections per export. */
 
 /* values for cmd flags in the upper 16 bits of request type */
 #define NBD_CMD_FLAG_FUA	(1 << 16) /* FUA (forced unit access) op */
+#define NBD_CMD_FLAG_NO_HOLE	(1 << 17) /* Do not punch a hole for WRITE_ZEROES */
 
 /* These are client behavior specific flags. */
 #define NBD_CFLAG_DESTROY_ON_DISCONNECT	(1 << 0) /* delete the nbd device on
-- 
2.43.0

