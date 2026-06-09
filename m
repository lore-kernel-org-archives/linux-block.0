Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F7C403B1E
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 22:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042752; cv=none; b=HBHpLxWz2/BJLJTOUxcLpIOntQPRfRI0VwVozzWRI659P4LQqzgP+D4sbyk9LGatMC4xTh0DGs95XvLPp20JFVkABFzPMUtGAPkMrs2j/TCNv0TiZ7yU2fbJu0LrE/8p66xAP7QwaIl0XBpk/QEfQttbpELwgMjNikawy+GE56Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042752; c=relaxed/simple;
	bh=2vP3cw7dM2qXK/Ic5NamE5W6z8AVWpPR6WZmX4WPM1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CTKw/u5xJiEM+Ul9vH3oHXCLLrXw8p8j/BVMRN3RU9hlVmB+7IKLJlzUu/DgBQ02dE4WoVeFyOGizkpbmvSoeoMOzchHPZ9OA2BZETzy0f38UUuMba8Ft+STNlIpSioUHq5Xy5GXd7Dx2AYCn2YjjD5aFCEX8nUbPvLAVV0AF1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=kJeUPtia; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="kJeUPtia"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gZjf13srMzlgwNJ;
	Tue,  9 Jun 2026 22:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1781042742; x=1783634743; bh=Sq+PP
	zdqsWaoHldfuEoHG57vdepnrzL3ccTUfdwSHJQ=; b=kJeUPtia8khhI7RcbV61U
	uIH01ib2yR/K5ERvWtgZUpoDZMzgk1prYuVStTyZE1tkKelGoiGTCGskPZSyWT41
	GfmRDNQIcYvd1oUGLa7g9+iR7bqHiyJ8Lz+0BB6YWNTGBIqDeF8c4e0b6uqaoRV1
	r8wyEiYk+0Dr+J+ZA9R/ekj9vt7KCQsUVJABMmZRSdh3iteUUPPs7FlCocoxxwT1
	hxshzynKnnBi1biTvz8aRTsZKqjxV0ak6ezPEBd6U5on/AAvjX1/qpmJiYjW0/8t
	mD71ZHPmq8Y1DiVOLu2WpQkSxlMG/uemq1jJ/YRqQcxPAEBAGydNE5NCi6hYJNR7
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id QjYaQYv93DT1; Tue,  9 Jun 2026 22:05:42 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gZjdv3cyMzlfpM6;
	Tue,  9 Jun 2026 22:05:39 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>,
	Justin Sanders <justin@coraid.com>
Subject: [PATCH 01/27] aoe: Enable lock context analysis
Date: Tue,  9 Jun 2026 15:04:48 -0700
Message-ID: <f15d4c4f4a22ab4788a40d51d88d228a649d0115.1781042470.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
In-Reply-To: <cover.1781042470.git.bvanassche@acm.org>
References: <cover.1781042470.git.bvanassche@acm.org>
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
