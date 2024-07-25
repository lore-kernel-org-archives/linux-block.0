Received: from lounge.grep.be (lounge.grep.be [144.76.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CA619D091;
	Thu, 25 Jul 2024 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721926119; cv=none; b=KIqPfOiMvfR/VdwlIyPtGtBLlE2aEXSbZxiAazt4eZVdOS9aR3OUhUak5rHN0DtS90efrtYMIQBEO0C1jBKpkjzMvE5LNxvo+qraGKSz004IVfEqhTBV5cp0lJ9lhzSYnEz5tvQT1FglBdScF0kNporjb0emBWDyH5rdO0Buwek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721926119; c=relaxed/simple;
	bh=i2Yya81zygY1AcEXqh9Bj0E8EDuI8ZXvjEkFEOBH8Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P3S+vCifmYYnKCrvsN2yIALAAW85Fiy3UHtqmtDUeX73vHJGbsr8BD0rMkz/IvQ1Ol1zgNQcTVBAQVJ5Ddb0IrWvSx5xmKTmjXbKpxw6VYqKghnlOwgHiSKgUfeeQM6vUpg/L2tN0BGiYRDhv6MLZuHhfQxCpCJepIi1o7pf7DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uter.be; spf=pass smtp.mailfrom=grep.be; dkim=fail (0-bit key) header.d=grep.be header.i=@grep.be header.b=RxgMcDiW reason="key not found in DNS"; arc=none smtp.client-ip=144.76.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uter.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grep.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=grep.be header.i=@grep.be header.b="RxgMcDiW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=grep.be;
	s=2017.latin; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bYMsa0EfB+GNYJVPoJ4Xm4fN7+npU33jjsrAMpuBdNE=; b=RxgMcDiWstD5hscgD2SgTjjIjc
	rQnufE60L4dbwjTveCNvx0DAaA5HLu13n+xNYlsUulQxsewCzqygo6YJ/lr3EWEluphNSIP5IW9Fo
	L9CeDUh4ZgUoC9oOqy4Mm5DLdi9qHfLRQhLtYnVQ8uhZOv2ghqcR4G3I+WsUqpT1NDXH1N62Ttylx
	YQqQFxEFuPgibseD8j0cHwjFwcbKqKwuN8WZBl2FeMcx+Re8hiaG/SwTKUI+fEVWkRZdvfVF8VyxU
	qFhtA465YqNkoez7d7nT0tUae4JYQOaX4cEuUhfhCg/54L9tHwYJWT4EdJaiac0e6UZNse4GaJSbV
	iRZfXhFg==;
Received: from [102.39.153.168] (helo=pc220518)
	by lounge.grep.be with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <wouter@grep.be>)
	id 1sX1dm-004ZKR-2B;
	Thu, 25 Jul 2024 18:48:30 +0200
Received: from wouter by pc220518 with local (Exim 4.98)
	(envelope-from <wouter@grep.be>)
	id 1sX1bT-00000005MAZ-1rhp;
	Thu, 25 Jul 2024 18:46:07 +0200
From: Wouter Verhelst <w@uter.be>
To: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Wouter Verhelst <w@uter.be>,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nbd: add support for rotational devices
Date: Thu, 25 Jul 2024 18:45:36 +0200
Message-ID: <20240725164536.1275851-1-w@uter.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NBD protocol defines the flag NBD_FLAG_ROTATIONAL to flag that the
export in use should be treated as a rotational device.

Add support for that flag to the kernel driver.

Signed-off-by: Wouter Verhelst <w@uter.be>
---
 drivers/block/nbd.c      | 3 +++
 include/uapi/linux/nbd.h | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 41a90150b501..5b1811b1ba5f 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -350,6 +350,9 @@ static int __nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
 		lim.features |= BLK_FEAT_WRITE_CACHE;
 		lim.features &= ~BLK_FEAT_FUA;
 	}
+	if (nbd->config->flags & NBD_FLAG_ROTATIONAL)
+		lim.features |= BLK_FEAT_ROTATIONAL;
+
 	lim.logical_block_size = blksize;
 	lim.physical_block_size = blksize;
 	error = queue_limits_commit_update(nbd->disk->queue, &lim);
diff --git a/include/uapi/linux/nbd.h b/include/uapi/linux/nbd.h
index 80ce0ef43afd..d75215f2c675 100644
--- a/include/uapi/linux/nbd.h
+++ b/include/uapi/linux/nbd.h
@@ -51,8 +51,9 @@ enum {
 #define NBD_FLAG_READ_ONLY	(1 << 1) /* device is read-only */
 #define NBD_FLAG_SEND_FLUSH	(1 << 2) /* can flush writeback cache */
 #define NBD_FLAG_SEND_FUA	(1 << 3) /* send FUA (forced unit access) */
-/* there is a gap here to match userspace */
+#define NBD_FLAG_ROTATIONAL	(1 << 4) /* device is rotational */
 #define NBD_FLAG_SEND_TRIM	(1 << 5) /* send trim/discard */
+/* there is a gap here to match userspace */
 #define NBD_FLAG_CAN_MULTI_CONN	(1 << 8)	/* Server supports multiple connections per export. */
 
 /* values for cmd flags in the upper 16 bits of request type */
-- 
2.43.0

