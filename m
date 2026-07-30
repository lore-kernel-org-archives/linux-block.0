Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF0D4477F9
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 19:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785441546; cv=none; b=VID23uqrPEE3Qb5L0WuCoGrmC2kWIIZeDzh8bVDE5LM9byM49AdtSHtRS4zxBG+FqWL8KE1ka5nTkECWj6z5DKWdKjiqyQRCNAHmQbtFQLATfTYeDDYOfVdHexbv5rEIyNSINhRgtuidD8vruvl651OHsFhMV64Kzh+rrh9aPqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785441546; c=relaxed/simple;
	bh=2vP3cw7dM2qXK/Ic5NamE5W6z8AVWpPR6WZmX4WPM1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rHccbtt4AWRs8LWUGW7v0sAcEQ6NyX054OTV63mvAycS837Vc4rGoS4PDt2IPWuzdc/vIi4cWRPMJEuUi+aS/Imi5J4ifL6xsQJM3xC146sj1laaTbk/AU6QA4QZXWweHAuQqWcGEbutgv8fEHcCz/itnaVGhKiU0Cg0m6W4mOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Wr7BNpad; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Wr7BNpad"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hB0QJ47kYzlfpLt;
	Thu, 30 Jul 2026 19:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1785441540; x=1788033541; bh=Sq+PP
	zdqsWaoHldfuEoHG57vdepnrzL3ccTUfdwSHJQ=; b=Wr7BNpadjokHV7nDT5RfH
	lQNCqgCyCBUgQGBvKpCwl1ZVYRNFFzB2AEqK7XwVaCoRHMhyte8UPSpKohhkrCWJ
	X5kYt3NT0y5j96q/bnmCsvlLvitpNgz01mQsUtokaJxZxsdBwvaQEXwoJA2ljpTG
	5gZ5q+xpq4rPFzfvmLcj4FW9fFIcR9TRMbpF27NV21/bwG6eu4JDkeJ4/VjiObUs
	q5EXL/KWAlu00FAmgsRHXJmod86OBhKi5G2W4t8pXOjxbL9UznDgUwYqZYTT6Jls
	6h5rCh3ZMiHNlxqOq0KxCc4VS+HJ1jA0ok0n+efqA3/1N5NDVVj2G7LiaEPDWr5P
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 1e-v8WGA8Oqo; Thu, 30 Jul 2026 19:59:00 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hB0Q94rLLzlfvpx;
	Thu, 30 Jul 2026 19:58:57 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>,
	Justin Sanders <justin@coraid.com>
Subject: [PATCH v2 01/12] aoe: Enable lock context analysis
Date: Thu, 30 Jul 2026 12:58:24 -0700
Message-ID: <a5fdc2b4d52006c20e2519f2c395d5d5102cb52b.1785440858.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
In-Reply-To: <cover.1785440858.git.bvanassche@acm.org>
References: <cover.1785440858.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a missing __must_hold() annotation. Enable lock context analysis in t=
he
Makefile.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/aoe/Makefile | 2 ++
 drivers/block/aoe/aoecmd.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/block/aoe/Makefile b/drivers/block/aoe/Makefile
index b7545ce2f1b0..27bff6359a56 100644
--- a/drivers/block/aoe/Makefile
+++ b/drivers/block/aoe/Makefile
@@ -3,5 +3,7 @@
 # Makefile for ATA over Ethernet
 #
=20
+CONTEXT_ANALYSIS :=3D y
+
 obj-$(CONFIG_ATA_OVER_ETH)	+=3D aoe.o
 aoe-y :=3D aoeblk.o aoechr.o aoecmd.o aoedev.o aoemain.o aoenet.o
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index a4744a30a8af..54c57b9f8894 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -1193,6 +1193,7 @@ noskb:		if (buf)
  */
 static int
 ktio(int id)
+	__must_hold(&iocq[id].lock)
 {
 	struct frame *f;
 	struct list_head *pos;
