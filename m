Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED862D63E2
	for <linux-block@vger.kernel.org>; Wed,  2 Jul 2025 20:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751488767; cv=none; b=YY48qi7kqVZff49SeCN7xA33Soqq2pbH6sTmeRATRq7YySpqe5/sOiRGh/ZdeYPbKgJpJnVnCStdAhUsh8S6pKURuZS3rQRO4egXw7btsgqqQ2ZVMddUJ1CH5O4nHgrQ6u7QvoMNXyfVnj52OCqZbS3QdcBlMFMOAoDtMvFP7c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751488767; c=relaxed/simple;
	bh=pTG4P+B2NNAhoUHWW7xyPD00nZ+IcyGMPtc/DTu208c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kyhX0nNT5j7s++MCDCmoX/XTZRJJAujA+MphzwoGLUjRSxYaPQcCDGc4p/E01K4FjKBZ/QajNMKVQyH7hld1+B2ghA2QmwruQyTOF2/xQkiquxM5MmsZC2uLYpL1zeeHJXyzb0Tekb4nYtY1Hb3QMBHwqvCp5OurJQ17HytoLZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=BM3hgArd; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="BM3hgArd"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bXWwF29cpzm0Hqf;
	Wed,  2 Jul 2025 20:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1751488763; x=1754080764; bh=0Z847
	ORISnrJYKFud034vZJ4RblOdX9ip6yUQYiONAc=; b=BM3hgArdfheZwugDORPCz
	rpFsINuYouO8ukRY0jGmHd0GrGqsUT+Es7tgPSzPpxnVhBhv7EUffnbTKo4OozWg
	NGXyuyTbbxk3cWSNblp1wweW/eblyy2fqRy5ihKh4hQP46qyIcoJlENYspPktUcT
	j9iPlaR6jrH11cKRALFNc2oIWHmxkZ3rrfm9c1i36UbY1anGR4hsxBoonPpuuI6W
	HjE4Gy/5/68LF0Scatq3abuCdF5QEIGCWycu9G4HD3MejpAW2VS8L3bYR4llktRT
	ILVGzV4TjjlnbiAhzeQLatF45a551iNwBS07PIGHA8cZw2dSkYQ3LxbIdxCwoEWx
	A==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id F61kHr9Nr_a8; Wed,  2 Jul 2025 20:39:23 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bXWw82W1Nzm0Hqg;
	Wed,  2 Jul 2025 20:39:19 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 5/8] ataflop: Remove the quiesce/unquiesce calls on frozen queues
Date: Wed,  2 Jul 2025 13:38:40 -0700
Message-ID: <20250702203845.3844510-6-bvanassche@acm.org>
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
 drivers/block/ataflop.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index 7fe14266c12c..0475f3bc6fbd 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -760,7 +760,6 @@ static int do_format(int drive, int type, struct atar=
i_format_descr *desc)
=20
 	q =3D unit[drive].disk[type]->queue;
 	memflags =3D blk_mq_freeze_queue(q);
-	blk_mq_quiesce_queue(q);
=20
 	local_irq_save(flags);
 	stdma_lock(floppy_irq, NULL);
@@ -817,7 +816,6 @@ static int do_format(int drive, int type, struct atar=
i_format_descr *desc)
 	finish_fdc();
 	ret =3D FormatError ? -EIO : 0;
 out:
-	blk_mq_unquiesce_queue(q);
 	blk_mq_unfreeze_queue(q, memflags);
 	return ret;
 }
