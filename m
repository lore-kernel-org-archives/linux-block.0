Received: from lounge.grep.be (lounge.grep.be [144.76.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC6817B51B;
	Mon, 12 Aug 2024 13:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470733; cv=none; b=MqmEbqTqbbN2MzjUF2p7Pswflo26Ds4ob2EyqF0iYSb8SPnzBFssOA8M7edAoPsqJ+WVkHmYoYaJedes82Giwb8/Rigw3uviaN3Cre8U4KuQxkuVYMTeKMVEns2vO8HtAPIRYLhJwrj95XRLt05tNUfCCg7Dts/EDKv7rJHYFKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470733; c=relaxed/simple;
	bh=cAwbV8ZC5p+BD1zrpaL4RfTaUIEHIZ/3hYRfMPKIN40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QA5BZbtglIz+0Bbjt1zqDqlpQrOJ/mPp1zww1N7OSCuvru4U/LWLD6ItnEgcyaRKfIHCO23GPa2AP8sCEFWodNprr7SzlGBGNEd6+0Og1Woel9VH3DgIU0FRE0fUEfMcMfUl4cGFbWPRBV2RAfi+LLH1OIeUgeYLhKyAtbcdPSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uter.be; spf=pass smtp.mailfrom=grep.be; dkim=fail (0-bit key) header.d=grep.be header.i=@grep.be header.b=lejhTNoi reason="key not found in DNS"; arc=none smtp.client-ip=144.76.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uter.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grep.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=grep.be header.i=@grep.be header.b="lejhTNoi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=grep.be;
	s=2017.latin; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=CPlFTzWYOxO8KdoJEO4L163n14ZVh0BcaBrQIuR5/Qw=; b=lejhTNoiOkuHrQYDnylirgBRaU
	vhDHsj3iX9yX2EYHJ+7bKVH5m+YF/iOP+kpKZcd/NGnUiSiosnbxo+l7ugraxtMERGOqVmhFy9WrV
	wrbEYwqsk2q/2+UWEqStSibq4MNhIl0XKDZYIDmf4ed6QUI7LBPqRUEOYFV5Fu701MxPHQI2Lh5T9
	sj5pel2QK4VQLjjhcqp7dBGjl6+T9BfGgdV99j1ANOA2LnOHzendaBjiFzKh4m9iZSWMXrdC0aI9/
	kWCSs/Cnpu2CoJQOBxN2G21aXu9wU5kD3T0+8TV3FscwJwGbSPspOEHFXPVwNGMdrFjZwm+uxQgkA
	cW2sFlSQ==;
Received: from vc-gp-n-105-245-229-160.umts.vodacom.co.za ([105.245.229.160] helo=pc220518)
	by lounge.grep.be with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <wouter@grep.be>)
	id 1sdVSl-009Xjz-0O;
	Mon, 12 Aug 2024 15:51:55 +0200
Received: from wouter by pc220518 with local (Exim 4.98)
	(envelope-from <wouter@grep.be>)
	id 1sdVAp-00000000V90-3y1J;
	Mon, 12 Aug 2024 15:33:23 +0200
From: Wouter Verhelst <w@uter.be>
To: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Wouter Verhelst <w@uter.be>,
	Eric Blake <eblake@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] nbd: implement the WRITE_ZEROES command
Date: Mon, 12 Aug 2024 15:20:37 +0200
Message-ID: <20240812133032.115134-3-w@uter.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812133032.115134-1-w@uter.be>
References: <20240812133032.115134-1-w@uter.be>
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
Cc: Eric Blake <eblake@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/block/nbd.c      | 8 ++++++++
 include/uapi/linux/nbd.h | 5 ++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 5b1811b1ba5f..b2b69cc5ca23 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -352,6 +352,8 @@ static int __nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
 	}
 	if (nbd->config->flags & NBD_FLAG_ROTATIONAL)
 		lim.features |= BLK_FEAT_ROTATIONAL;
+	if (nbd->config->flags & NBD_FLAG_SEND_WRITE_ZEROES)
+		lim.max_write_zeroes_sectors = UINT_MAX >> SECTOR_SHIFT;
 
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

