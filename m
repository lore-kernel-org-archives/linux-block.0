Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C111799F
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 07:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708586669; cv=none; b=dMEb2T0jQRV/JjjHX5vY4Dh9Whd8Hr2ylLeuipN2yNxRGpxjc8/putD2p0bBtKrWGxn/YOrRovGjshXdm3k5KcOlILTNW5kB+Vfqs50Fkfxpn6BQPwTFXHSjpWlaMO9TK06UwOdzSIhP0Htlp9DbLlDkNctrxJJL71zcgwPlpQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708586669; c=relaxed/simple;
	bh=bp7GYBlBL2or4dRhmeORwvc4sNgNyBajh9DAOA1FWI0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fZHwdVE3pYy0bssLdnRaLo8QzqN4uDWY7A2epago34wqzIvnT4M1xPHea7O7ZWrZh/3Pm2bVxfqfiYfdtla/A7KKfJXMyYqXm/QpvMyHMzI6NGLEqi2otX2rt4a26hZV7lfcK0gIGRW7Hkpc156ih2u+hGFkWoqtO1uKUoMkkM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3/KfwHSR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3/KfwHSR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=2BFULQQpf3659ifgG7eJf7nI2YTQWRMkjSUtn4KfBjI=; b=3/KfwHSR7UwxuBW8HMjTrLccLS
	qA7vCTsQcSgNv2Ty1zJ8u+kPFYQCp3Bi4uoDcUMMdtQr+8ohXqsVEbyKC3NBiaA/mx8Mot3/SF6p6
	bqvbyLpeqUpNbAk5iPYyO/g5ZP8DL0W212PCVc7uks8re0fTMwoY3k3S/fw1abkhJgif906CVxr1v
	tPm9pYjOCVTe+qKOoqGtJ03ZK+utPTSpIsQoJuCNYtnrKfPErEBZ/NK1dBMu54xqISkEMI6qUGD/p
	RCIbWoXMJmtpcR+Ba5ZinITjrhUWQU+9dQLssVhAWeq/JT7TT5mKYW4oeq1Cf+hbkNRDxVv37hp21
	B2MKcjVg==;
Received: from [2001:4bb8:19a:62b2:c70:4a89:bc61:3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd3RS-00000003ndp-3S4s;
	Thu, 22 Feb 2024 07:24:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-um@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 3/7] ubd: move setting the nonrot flag to ubd_add
Date: Thu, 22 Feb 2024 08:24:13 +0100
Message-Id: <20240222072417.3773131-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240222072417.3773131-1-hch@lst.de>
References: <20240222072417.3773131-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

No reason to delay this until open time.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/um/drivers/ubd_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index ef05157acd6b02..9dcf41f7d49606 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -799,7 +799,6 @@ static int ubd_open_dev(struct ubd *ubd_dev)
 		blk_queue_max_discard_sectors(ubd_dev->queue, UBD_MAX_REQUEST);
 		blk_queue_max_write_zeroes_sectors(ubd_dev->queue, UBD_MAX_REQUEST);
 	}
-	blk_queue_flag_set(QUEUE_FLAG_NONROT, ubd_dev->queue);
 	return 0;
  error:
 	os_close_file(ubd_dev->fd);
@@ -894,6 +893,7 @@ static int ubd_add(int n, char **error_out)
 	}
 	ubd_dev->queue = disk->queue;
 
+	blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
 	blk_queue_write_cache(ubd_dev->queue, true, false);
 	disk->major = UBD_MAJOR;
 	disk->first_minor = n << UBD_SHIFT;
-- 
2.39.2

