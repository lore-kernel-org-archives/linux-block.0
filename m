Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07171329C57
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 21:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774475167; cv=none; b=DURemYkB/POoB299O82/s0SbbSgZe0EgP6ebE7V/VRu5kUV/6kF1I4KloCKZMR2WETGZzPqd+2WtvuysRGQ0sVgS9gaNpYfZyHAG1w6JY8ndXWcm9qvTFXiXl3Z2Y0eI7djlvFyk+O689Z/DGqaRa2cXGkzwNI21l+sSf7JSx+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774475167; c=relaxed/simple;
	bh=gMgIY11ANn2eskWoTcJFNIjDiAKIwUrg7eqNmgu+Eak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHQE6+oBPezD3U9mgh73Bax0c1mgCsW3OuAYky13czqAsiBLJoTGsQ/sSJPYKvmw8Vadp+1Ym32XW3OgsX0tzkERrZrG9b5XmYvSbkBcj9VpfszDTDEGwG/vKw5kveuQkyu0M3zpgLTBxJcqIuoPrk7U5T75giw30sYAtYSkL4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=K1KZSDze; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="K1KZSDze"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fh0pP5gkVzlfvpM;
	Wed, 25 Mar 2026 21:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1774475162; x=1777067163; bh=UXbzj
	OnTbGokHQzpl1SnQz2E/UwT0MvWWobXUE5IwVw=; b=K1KZSDzeZTpV1Chv9kWPO
	RgWXyxTrBhk5spJkfPCj4DPeRoehdi2/LfGqVIiBMijRAXLRldF6yWIc8uGXZ6qc
	ihbEb3dGG3hUT7o97Az8M3eDVrpdVXMGLjzSDCiQORD6QJ6eNPwbANuPXC5S+mXv
	qLHIQ/x2dtIfsaf6pdUrwBUMImfQ3d/ckrGQhC2NgXmD7a0Lc3VJ+YNKW9jjRvmK
	MXBk8UQyCJC6aadTgmU+5jZHleZTyGA7XIYEaeKT5E3WyPeeIx5givCNbUo9oRXP
	mMHbEwoxfVPpL0iDLQLHokYRPQYGumfWA9q3RvY27yjid7OMTxFlNpumBd/UQVUj
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 4TWMr0r9E-eJ; Wed, 25 Mar 2026 21:46:02 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fh0pJ5jTVzlfdGT;
	Wed, 25 Mar 2026 21:46:00 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Justin Sanders <justin@coraid.com>
Subject: [PATCH v2 14/26] aoe: Add a lock context annotation
Date: Wed, 25 Mar 2026 14:44:55 -0700
Message-ID: <20260325214518.2854494-15-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260325214518.2854494-1-bvanassche@acm.org>
References: <20260325214518.2854494-1-bvanassche@acm.org>
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
