Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179FA4D9EA
	for <linux-block@vger.kernel.org>; Fri, 10 May 2024 20:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715372306; cv=none; b=OCrCxG0eCP5Lu4+RQv+gpBNPR2Nd4AS+Kf5WKG8ZlFiMYmzLuYFrrqwsYEidqOs1ALLHAS0cBcCM6Qg0KsawWuXeu9JXNd1R6EMw89FASE/TZVvtlvO2VsufZ2x4C8UUJgl1i1RvxD8Ef+LH6ugEbebQqjy0dr3wiGb1zYX3vG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715372306; c=relaxed/simple;
	bh=pRT+ap3eWc1yWz3qSF6mzb8zUpTmFnzNHzCZsZsBlhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fJgUxSuimpo0wJjzg816sEUYS1+c+qtyabSij4UDwa56lAPI403peLi1ltlr6IWj/UFErBaneLLjJP0kBu59EAA1Bqnq/uKphrZR6DVxYhiZWjzxg6a9Xs/A4O561guMebLO7lxrs6dUxrIzzX88ZNr4kpbdbFHlsudaG49I8nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Qg1Hdhp/; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Qg1Hdhp/"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VbgDw2Gx2z6Cnk8y;
	Fri, 10 May 2024 20:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1715372301; x=1717964302; bh=/OAYqQCDaLAYlEw2E5FPzc4npfgTmODj2ln
	MswQNp0M=; b=Qg1Hdhp/pvhgEb4xUEJ65SXeDYBTFBO3icQ/HBldZINFh+DdmNS
	kNT98Lbm4YlAnzUEFIXZCRkhgc3dz6QRJ4tmmmKyKTR91veK7mGkYvo8j1gWwgSY
	PAlJ/kkJk9Wuyr/r+kwi3VuAbYA+2MWhbsLlNom+ms/11h5FR1F0JBYG3cpvSq4F
	ye5+AFr57DBsyedV1EOXYtPt1vqnXOH6PZEX5FyM7SUg5wtfSY3KXxxYYeAyNUmj
	KfCbYwWIpa0SGjdcEGL9Q9atmq8MiKPKbSCPOfA6hhayPATmJcl8KrhHcz2FEd/W
	/L2v4Mr/zFFSkE9AbAvt7h3GEcpNIC8yXjw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 0bQIN5zA1Ah7; Fri, 10 May 2024 20:18:21 +0000 (UTC)
Received: from asus.hsd1.ca.comcast.net (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VbgDs1FSdz6Cnk8s;
	Fri, 10 May 2024 20:18:20 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH] null_blk: Fix two sparse warnings
Date: Fri, 10 May 2024 13:18:16 -0700
Message-ID: <20240510201816.24921-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix the following sparse warnings:

drivers/block/null_blk/main.c:1243:35: warning: incorrect type in return =
expression (different base types)
drivers/block/null_blk/main.c:1243:35:    expected int
drivers/block/null_blk/main.c:1243:35:    got restricted blk_status_t
drivers/block/null_blk/main.c:1291:30: warning: incorrect type in return =
expression (different base types)
drivers/block/null_blk/main.c:1291:30:    expected restricted blk_status_=
t
drivers/block/null_blk/main.c:1291:30:    got int

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/null_blk/main.c  | 2 +-
 drivers/block/null_blk/trace.h | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.=
c
index 4005a8b685e8..5d56ad4ce01a 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1218,7 +1218,7 @@ static int null_transfer(struct nullb *nullb, struc=
t page *page,
 	return err;
 }
=20
-static int null_handle_rq(struct nullb_cmd *cmd)
+static blk_status_t null_handle_rq(struct nullb_cmd *cmd)
 {
 	struct request *rq =3D blk_mq_rq_from_pdu(cmd);
 	struct nullb *nullb =3D cmd->nq->dev->nullb;
diff --git a/drivers/block/null_blk/trace.h b/drivers/block/null_blk/trac=
e.h
index ef2d05d5f0df..82b8f6a5e5f0 100644
--- a/drivers/block/null_blk/trace.h
+++ b/drivers/block/null_blk/trace.h
@@ -36,7 +36,12 @@ TRACE_EVENT(nullb_zone_op,
 	    TP_ARGS(cmd, zone_no, zone_cond),
 	    TP_STRUCT__entry(
 		__array(char, disk, DISK_NAME_LEN)
-		__field(enum req_op, op)
+		/*
+		 * __field() uses is_signed_type(). is_signed_type() does not
+		 * support bitwise types. Use __field_struct() instead because
+		 * it does not use is_signed_type().
+		 */
+		__field_struct(enum req_op, op)
 		__field(unsigned int, zone_no)
 		__field(unsigned int, zone_cond)
 	    ),
