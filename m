Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2542D1D9350
	for <linux-block@vger.kernel.org>; Wed, 15 Jan 2025 22:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736981253; cv=none; b=NLVM9uxLrrFLL9VEofaedOKPCe4VaYTO+TmoWlX9g1E3EEgtrQk7Zzazb2sC1ddJS7ykc4GT5G23sVt5AN2CRkr4GC+k4u7Ew44OsH/5BxcNrWIyvN6FJ1F68CpwU9ik4AkpnXGyhWs/8q3nuIX6bUZarWHbq36zEBNrVSI2+1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736981253; c=relaxed/simple;
	bh=yLVqPbvQvuO7qewjYJfIewsSWHJZ1Ake4gMns2/vMvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9wuGJ8pY3H+x1aN8wjCdFqEPYIJEuG8TdJhEsEXflg8peVA/PdjB60x/RIz6eN6kkzlwJNLhbqA9jKOqSxE1Z8BvTdsoI3QbP5kdSJDsdFOinl8jm/lpX+CSadC4FHeQbTVqKXZfMrmJ7fSa+PXr3FmL55bsyX8RxQ8HrFO+rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=JqSGov9g; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="JqSGov9g"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YYLjb3jp2z6CmQvG;
	Wed, 15 Jan 2025 22:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1736981247; x=1739573248; bh=EAkuB
	2xypSUVIPiBl8SymBTYsDKGpfY48lwKCQ0aKug=; b=JqSGov9gfWFMNp/ET/EfO
	+s3JNn9idQSGyJ31OWEGu17aNUZ/ecF1pxVfi4bWqgOL/XNYgoa3oPE/OPPrbwTM
	TVwJnJ2q4Bq2kiTJLTiGWGDqHferg6+UFSnvPTK11wZ4lnzwMlqTrG5Z9X6HA5Za
	MHI8P6PTmVG2cY0G/kqaeb5zCdN4f/iUt7tAHfBmUujlyt66a3Oxdfm0XOaVNdS1
	3zEhqBcqHjIxeSsqhoqp7r1ZWVlPc8zC9jPJaTuitHjhPNjLB25pgKWwvg8zRZxF
	QgEXKYSgjQeDBRZksdRiDvsV3JYI9kVkO/1T1byIFhRFwMAbn8WSvzfDtcMwOul3
	g==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Y6lsaAbzsiqa; Wed, 15 Jan 2025 22:47:27 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YYLjT2Qgmz6CmM6X;
	Wed, 15 Jan 2025 22:47:24 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v17 11/14] scsi: sd: Increase retry count for zoned writes
Date: Wed, 15 Jan 2025 14:46:45 -0800
Message-ID: <20250115224649.3973718-12-bvanassche@acm.org>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
In-Reply-To: <20250115224649.3973718-1-bvanassche@acm.org>
References: <20250115224649.3973718-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the write order is preserved, increase the number of retries for
write commands sent to a sequential zone to the maximum number of
outstanding commands because in the worst case the number of times
reordered zoned writes have to be retried is (number of outstanding
writes per sequential zone) - 1.

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/sd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index d9e3235d7fd0..2594debb756c 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1403,6 +1403,13 @@ static blk_status_t sd_setup_read_write_cmnd(struc=
t scsi_cmnd *cmd)
 	cmd->transfersize =3D sdp->sector_size;
 	cmd->underflow =3D nr_blocks << 9;
 	cmd->allowed =3D sdkp->max_retries;
+	/*
+	 * Increase the number of allowed retries for zoned writes if the drive=
r
+	 * preserves the command order.
+	 */
+	if (rq->q->limits.driver_preserves_write_order &&
+	    blk_rq_is_seq_zoned_write(rq))
+		cmd->allowed +=3D rq->q->nr_requests;
 	cmd->sdb.length =3D nr_blocks * sdp->sector_size;
=20
 	SCSI_LOG_HLQUEUE(1,
