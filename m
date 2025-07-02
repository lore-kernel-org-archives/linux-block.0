Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64A22DE71B
	for <linux-block@vger.kernel.org>; Wed,  2 Jul 2025 20:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751488778; cv=none; b=hUQ57+yvAdcU0dI9g2vw9gj7Zp7rSSHB77YRb3N949H7y/8I1tSvk6K9HSGU9tNvKxdxyiRrje8WojMlcI3yfVcxRNf9+Xpin+cUo0ESKTfqPIowPWhiwGdGZR00kTaoXHkOOzcaj31VP6oa/3C+shycfO9QLr4/4LbHsFICCLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751488778; c=relaxed/simple;
	bh=HengWA3dhhEOJBDWVn1BpdEqAsSZOkaAahzjuSpLtqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2qMGvZ+H8FSSko4i2mIYl0dEzxWuMsHpGHnyAWYHZDu2bA1C/b4tvjBbOL0zc5N215i/pfQEfuj9q3s1mC446lje+IE8ecHpZ2xGQdaKu987O+1v+afMdS0NZVIO7h/wvgjejp/GLe7xid7zBgmXDyC0rICfKWOhTRhOEHcfJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=mBMs0G0A; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="mBMs0G0A"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bXWwS1ZFdzm0Hr2;
	Wed,  2 Jul 2025 20:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1751488775; x=1754080776; bh=95nb+
	8kWbV2u0YchFZQASxhdSioclQZSF8JruroyDO8=; b=mBMs0G0AiS7h03H/urEBT
	boEWDiELpkQPPwo+J/B+QLiswXhrhD7lllwT9hKGuPNQuavEoIDn51eiOdPdEonG
	Tz0F7LEW2dxx8rFSHzbDGoTzLIpdVikBN5gfRk3Ll9loTpMUybgQ03TQMx4Ky5EB
	ACFUA0gaSfqhhcfetpUFY7YQeKCiO9sGl78mO1MtX3kEHSiDSo2hPKgDCmYUeCH/
	Yznj8s/1j/BiaVhnLnSaKjpqmeZyrJVmLWc/E2PYopU39/jZOuW2DhSti7MQr/Nk
	s4P36I9xQOYW/t5LS2vNf0cqNbPtp2LYf9AERjunLDJ5tjgXJe4aTX4bX3+EmeiL
	w==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 22tcP_LrHo-1; Wed,  2 Jul 2025 20:39:35 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bXWwL15r4zm0Hqj;
	Wed,  2 Jul 2025 20:39:29 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 7/8] swim3: Remove the quiesce/unquiesce calls on frozen queues
Date: Wed,  2 Jul 2025 13:38:42 -0700
Message-ID: <20250702203845.3844510-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250702203845.3844510-1-bvanassche@acm.org>
References: <20250702203845.3844510-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Because blk_mq_hw_queue_need_run() now returns false if a queue is frozen=
,
protecting request queue changes with blk_mq_quiesce_queue() and
blk_mq_unquiesce_queue() while a queue is frozen is no longer necessary.
Hence this patch that removes quiesce/unquiesce calls on frozen queues.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/swim3.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index 01f7aef3fcfb..8e209804ceaf 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -850,8 +850,6 @@ static void release_drive(struct floppy_state *fs)
 	spin_unlock_irqrestore(&swim3_lock, flags);
=20
 	memflags =3D blk_mq_freeze_queue(q);
-	blk_mq_quiesce_queue(q);
-	blk_mq_unquiesce_queue(q);
 	blk_mq_unfreeze_queue(q, memflags);
 }
=20
