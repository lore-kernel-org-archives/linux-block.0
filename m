Received: from lounge.grep.be (lounge.grep.be [144.76.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8673B174EEB;
	Mon, 12 Aug 2024 14:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723472500; cv=none; b=GpNSuIkCn/28R27p4bZfcTJ2k7qVjJNouRE4J0Xy/6/oF8nWPGJ/c4DHXi9oHRuwoAI/fCDIe3NQlECXFBJ2Gy7mLLl0VSeEYrGoG7suqtJZyv4Tjfm6gYSYP6OP0CiH1No1OLhzDO79ubrtv9ZJvg84t/LBxSGYg9WDAhNiX5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723472500; c=relaxed/simple;
	bh=JeY1TPFy1DrkJKqz6R7Y3R7apZx4kYrch19xGM9uAVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgzAHV7OgI8pmsSrgNpJnys6+7nljDLpcj9F9PGbvubDTB8qr0xntlxbrug1dOYN08N0JRWSU17xRgYpSMiRxBRQhMlJbPIFZeTRbGrN1TUHjeRLK/lIbTJHDbcvKk5rryA801ksyINFvGVtnCzjjvflUb1JyIM0vGGMNYl8cIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uter.be; spf=pass smtp.mailfrom=grep.be; dkim=fail (0-bit key) header.d=grep.be header.i=@grep.be header.b=ozuxj6QP reason="key not found in DNS"; arc=none smtp.client-ip=144.76.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uter.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grep.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=grep.be header.i=@grep.be header.b="ozuxj6QP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=grep.be;
	s=2017.latin; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=UfNjOcnK0rNibgV49Da6IoKbw+3WWkpzfO/rH4LGQ2U=; b=ozuxj6QP1tspTE3TBAu18U913q
	AIntpY3wB0RxJJ6TK2UHI8gWC+TiWayDwqRmi6o9x0e7ZLtRIRM6EckASCCezzKJt1usuB7H9Hpml
	x3gAkojbdIE6xK28Z7Dyn5kfdqkFIl2AFjnZStooQjDW2HIi5V80ShWXqDknbKxTbHL9s572i4pRU
	UbvNdlX3b129LyaaBRtGurYTUcf1LtJ53oriiM1NoPrjyJ76HEVRZc+lXKu3VXCNoSOnNUhwRAx68
	f1LnqJiNXDPkJPrhrO+dQeEn9T+3qu4q/mjHp3RYufcEs0Mwuz0WK2DdsSoizVfjowgKiA/QrUUhQ
	zpTe/vkA==;
Received: from [196.210.96.185] (helo=pc220518)
	by lounge.grep.be with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <wouter@grep.be>)
	id 1sdVvS-009n08-13;
	Mon, 12 Aug 2024 16:21:34 +0200
Received: from wouter by pc220518 with local (Exim 4.98)
	(envelope-from <wouter@grep.be>)
	id 1sdVBo-00000000VH7-1PHN;
	Mon, 12 Aug 2024 15:34:24 +0200
From: Wouter Verhelst <w@uter.be>
To: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Wouter Verhelst <w@uter.be>,
	Eric Blake <eblake@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-kernel@vger.kernel.org,
	Eric Blake <eblake@redhat.Com>
Subject: [PATCH v4 3/3] nbd: correct the maximum value for discard sectors
Date: Mon, 12 Aug 2024 15:20:42 +0200
Message-ID: <20240812133032.115134-8-w@uter.be>
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

The version of the NBD protocol implemented by the kernel driver
currently has a 32 bit field for length values. As the NBD protocol uses
bytes as a unit of length, length values larger than 2^32 bytes cannot
be expressed.

Update the max_hw_discard_sectors field to match that.

Signed-off-by: Wouter Verhelst <w@uter.be>
Fixes: 268283244c0f ("nbd: use the atomic queue limits API in nbd_set_size")
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Cc: Eric Blake <eblake@redhat.Com>
---
 drivers/block/nbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index fdcf0bbedf3b..235ab5f59608 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -339,7 +339,7 @@ static int __nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
 
 	lim = queue_limits_start_update(nbd->disk->queue);
 	if (nbd->config->flags & NBD_FLAG_SEND_TRIM)
-		lim.max_hw_discard_sectors = UINT_MAX;
+		lim.max_hw_discard_sectors = UINT_MAX >> SECTOR_SHIFT;
 	else
 		lim.max_hw_discard_sectors = 0;
 	if (!(nbd->config->flags & NBD_FLAG_SEND_FLUSH)) {
-- 
2.43.0

