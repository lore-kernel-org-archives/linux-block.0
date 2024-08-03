Received: from lounge.grep.be (lounge.grep.be [144.76.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F8F1E498;
	Sat,  3 Aug 2024 13:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722690353; cv=none; b=ccJi4Upb84sh9Ijp+6UkJ3KOSG7P1oDyt60OANnjPldQy/19UQIjFJN0c2i2OWFoMtS9x0fXrA3XlXQGdE9lPNDYcDMum1D4ASemdH0Eb/exYTz79NBi9hYwjvw2uhhcFi/nHtkOcZzusyAfUGI8+oGlereYQelvRtPnMIao/+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722690353; c=relaxed/simple;
	bh=ckUSRfNb5VPdPZdAQI2Br2VA5EoZ/Zzfk58jrMriH3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQg+N97t4gq22DNS3zkZ27ZH++QpwsBp0P9U0xuDn6TuD9ycuXqC8y3N4eqrVNV3BrdHiy/kAMKGWpxOA9/zjjricNuBqCzWzJMUXwA2cbtXiWkW5Us9CpW7YDl56Rp99l/ZIaqJxRTCcRwkHhpcL1ZD/mNNidA176qFRcVOhQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uter.be; spf=pass smtp.mailfrom=grep.be; dkim=fail (0-bit key) header.d=grep.be header.i=@grep.be header.b=qy/RpLCn reason="key not found in DNS"; arc=none smtp.client-ip=144.76.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uter.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grep.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=grep.be header.i=@grep.be header.b="qy/RpLCn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=grep.be;
	s=2017.latin; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=eBj9IYCg6lGcdagpC23O36zks5evVy6gXh/QwlwAkJk=; b=qy/RpLCnpmVWP0OJYGhxrgi6d0
	lJwbFwM0KO0ExHB4MvZHFhqzFSADQMqXRabAfr4BOAFQHQyT2uH/Cq38VvtgAS9CBpmxNmHnY3/E2
	iDd6wrXkAdUbr2BI5fghHGt6K9UuiKQLppkeCfxsGZ6EwebGuEVRSt2fJeJW2zelKG8trVRHkD2Zy
	7/f8mNhdZYYr0x2XeQa13dJiO2wmCFtY5wYT0IJf4lvPXeIBTNc3n/DK++io8/NiGLwmo71IubzvL
	6ihpisxCkUNLqoewXvXQZuyY1q83DRH90CZNDiTLDsv9sYud7Swf1i1WUxFhkc/tWGjnw1omsYLLh
	+HsImlow==;
Received: from [102.39.154.62] (helo=pc220518)
	by lounge.grep.be with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <wouter@grep.be>)
	id 1saES8-00Cb0A-1r;
	Sat, 03 Aug 2024 15:05:44 +0200
Received: from wouter by pc220518 with local (Exim 4.98)
	(envelope-from <wouter@grep.be>)
	id 1saES0-000000001ZX-48zt;
	Sat, 03 Aug 2024 15:05:36 +0200
From: Wouter Verhelst <w@uter.be>
To: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Wouter Verhelst <w@uter.be>,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] nbd: nbd_bg_flags_show: add NBD_FLAG_ROTATIONAL
Date: Sat,  3 Aug 2024 15:04:31 +0200
Message-ID: <20240803130432.5952-2-w@uter.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240803130432.5952-1-w@uter.be>
References: <20240803130432.5952-1-w@uter.be>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also handle NBD_FLAG_ROTATIONAL in our debug helper function

Signed-off-by: Wouter Verhelst <w@uter.be>
---
 drivers/block/nbd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 215e7ea9a3c3..f65df8a1602d 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1714,6 +1714,8 @@ static int nbd_dbg_flags_show(struct seq_file *s, void *unused)
 		seq_puts(s, "NBD_FLAG_SEND_TRIM\n");
 	if (flags & NBD_FLAG_SEND_WRITE_ZEROES)
 		seq_puts(s, "NBD_FLAG_SEND_WRITE_ZEROES\n");
+	if (flags & NBD_FLAG_ROTATIONAL)
+		seq_puts(s, "NBD_FLAG_ROTATIONAL\n");
 
 	return 0;
 }
-- 
2.43.0

