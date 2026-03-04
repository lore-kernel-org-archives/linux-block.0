Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF961386448
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 19:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772653781; cv=none; b=OeU5PeBYgHwvqlfxJw44DYa0WnS2GxNl0quLGc2jzrc5lRMxGq+3TsXrZv+SVpC5eGJ+e2CwoDb5n2g3tAgmck1CXY11YjO3s3SX2d5II1jwIbq96rQk7wjStB4X/NQ2iI9fQ5PLt2Nqoua/gP4V2afh2sdF6iLXHswlPTNzdnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772653781; c=relaxed/simple;
	bh=3KE/6HY8yqHcG7/W489hxgiV4L8JPmmdsdc5Wtlvm1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G31GfaCXyLto8bkxKHVi8+vvVIxXP3yCP6rKYMP91CjISlDT1J1fv2V8mSUPQQVmu7DL7fIvO9qU6vClPThBMnulgepWDjNrHu0jtZ0VR8eB2dT0YWLN0jdp0yqRMNqEbi7+5O1X4jS7oH1DB6fa+Z/6kFyLUHN+JKTQiUPW5AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=N46Wxv75; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="N46Wxv75"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fR3Cm3fzZz1XM0p0;
	Wed,  4 Mar 2026 19:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1772653776; x=1775245777; bh=UYN3p
	WHjAoGH0ZpDGsfRv6ghQjDX8sbKfRXhzGHruu0=; b=N46Wxv75e/VA1btEWVRub
	k+ttlMRz/mWcqW4q8EOat3w6equad80ih/MUvpI0mmJABkOrtWzgCcyV7zABDNBX
	4mFEU1vOZe3KRAz30ylhSjfMgRKYhgh8lkCcOoFiY0st337k/MCdcwIKz/puRHZC
	Bve5yTySZpmevedchHdLFfPDeOjs9lYSpgcuHO8RvK1A6yHcqs7j+wzVbiVm6eWm
	sc0tAk7xQdk1yzqzWyY5vDStcZmpcHrVk99xQTH2tBorJgMPVgaqEkDox45XnbxZ
	oU8AW+AtFMzE36GNtFm62ZbopPIHeBx/t0ByVECXhiYLUorEjg3yJffDIaanzGZl
	Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id LmAuBDahPn15; Wed,  4 Mar 2026 19:49:36 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fR3Cg14skz1XMFkQ;
	Wed,  4 Mar 2026 19:49:34 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>,
	linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 12/14] zloop: Add a lock context annotations
Date: Wed,  4 Mar 2026 11:48:31 -0800
Message-ID: <20260304194843.760669-13-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260304194843.760669-1-bvanassche@acm.org>
References: <20260304194843.760669-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prepare for enabling lock context analysis by adding a lock context
annotation that is required for Clang.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/zloop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 51c043342127..b3654fd814c7 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -379,6 +379,7 @@ static void zloop_rw_complete(struct kiocb *iocb, lon=
g ret)
 }
=20
 static void zloop_rw(struct zloop_cmd *cmd)
+	__no_context_analysis /* conditional locking */
 {
 	struct request *rq =3D blk_mq_rq_from_pdu(cmd);
 	struct zloop_device *zlo =3D rq->q->queuedata;
