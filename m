Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3371A944E
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 01:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749603662; cv=none; b=MytifPyrZUwPseHiBIvtokmt0NRbl4IYxJrCZ1KEBK/vM+YakgUwrZhEB4aEQo1tTmuYM/0oOcWA2TGnBFiBdd7vcGGfi2ROMd4UCnIpX86fIcmDsKv74Lo2PJ2ltLAh+FxXWu2gEqN+Nk48VOILHhFtKvMFqoWOlIVqXmx9Qxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749603662; c=relaxed/simple;
	bh=//0NF7uzK4ZCE1x76TDXvyCr3kcfoNKXX1v/NS+7wDs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KRSxJcGQuLpSxYzmCtithvUEVVh7WtUNDQnowmuyDFermiRFmJv+bu8G1kPO4n1GQev8WkJxJTloXfJrjGZImQXmkKPmF0MMy3N1lp18DIq4fGvicFoQoQTBygom5x3sj48FV4aF1/Pp1YRar/sqpGehlZ1T/Cz8PPXWHM/xWgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuk87nmX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuk87nmX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B252C4CEED;
	Wed, 11 Jun 2025 01:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749603661;
	bh=//0NF7uzK4ZCE1x76TDXvyCr3kcfoNKXX1v/NS+7wDs=;
	h=From:To:Subject:Date:From;
	b=fuk87nmX+UXR9qIey8EWA8nNSk+N/KiE0HGkeFiaJvgFfSUCLRi2dopsFUxX8yfRw
	 MEOQ6soaQJMtDmLeFS1ZhDYlNBfCoyR0RzqrezR6F03VZkVrPMbJCtrOyowFg4BKR0
	 jvTDDkjPbGTlj5Ua9YkNdgyXN1WvLUteRfugwLnoaOlAenp+H5SA8qmH9jJmZanFgX
	 7i22+cVUNBmXf9kC1TCaCqnYMkCDIJkavPWD0LF3VdL1RkF6IWouFte2i1rRbIBH4i
	 eJTd5WmrfpK61kyEFgSzMDoiMBsxRQUxYbmHxZZ1twyV7TIkh9Ui8BCKce5TlF+4ag
	 M0oERDHgTAOOg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH] block: Clear BIO_EMULATES_ZONE_APPEND flag on BIO completion
Date: Wed, 11 Jun 2025 09:59:15 +0900
Message-ID: <20250611005915.89843-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When blk_zone_write_plug_bio_endio() is called for a regular write BIO
used to emulate a zone append operation, that is, a BIO flagged with
BIO_EMULATES_ZONE_APPEND, the BIO operation code is restored to the
original REQ_OP_ZONE_APPEND but the BIO_EMULATES_ZONE_APPEND flag is not
cleared. Clear it to fully return the BIO to its orginal definition.

Fixes: 9b1ce7f0c6f8 ("block: Implement zone append emulation")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index dfcef04ea8b4..55e64ca869d7 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1254,6 +1254,7 @@ void blk_zone_write_plug_bio_endio(struct bio *bio)
 	if (bio_flagged(bio, BIO_EMULATES_ZONE_APPEND)) {
 		bio->bi_opf &= ~REQ_OP_MASK;
 		bio->bi_opf |= REQ_OP_ZONE_APPEND;
+		bio_clear_flag(bio, BIO_EMULATES_ZONE_APPEND);
 	}
 
 	/*
-- 
2.49.0

