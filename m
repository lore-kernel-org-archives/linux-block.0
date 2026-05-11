Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7377644E053
	for <linux-block@vger.kernel.org>; Mon, 11 May 2026 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517080; cv=none; b=B/Pty358EF2WDbP2alirueXtvdr1QWKBJqgHGQpakx5wWbeDhIVzP5euW2cEy1PCIVAhdaJYBj9mfqQMCNqfBdphappbBN/QXDrBgTGbCVv0VGB7c/j3ih+AIjgcIdBI8//+BvKReHHHqANmDfgkydDDvzkrEEeAAxrwipgjx8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517080; c=relaxed/simple;
	bh=EijhLDoL/36s8VoBWMLRxGSfZsNmUmHyqR8S9RIYawY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eh/J5pURSasqIsL4jujsmR6Qcle35D0G2TcnmmaoNAKu4gJQTjB1w7+fbuvQb1SjL4/PMbGBiDMevYqAQLhLaqBpBLQqjs3DtXQEnU8yo2IMId7YgHrUV12G1S2GzQyCyRnwH+aIgCBqlKVrEk0F756wnbQKrXuoqizAUKAXlAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=sqEVLxx/; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="sqEVLxx/"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gDlbW0Y6TzlfddR;
	Mon, 11 May 2026 16:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1778517075; x=1781109076; bh=TswD3
	QCL5sUBKmBeKuGaCQal6ah7SLen+FK0CMkfQTo=; b=sqEVLxx/qqgyDB+RftI5m
	0j5lJg2NKgxm3R//Uk1sDwokk9BL4o/p8bq5kSxK5L9pjUMeYBLejALfrZXo29XJ
	rsHZNEFfPtX/lg4g9YOvCJ1fob98itF4OFuH+jSNMuDiFwDNMAn75NtlOk18yWi7
	747ygKVt9arhLyjVBcuRFo+qo6sJrhTf4eddz0+FEfjhdChDn63XgmORUvawFpos
	4kR6Z3SLHSJHvJWvJ31hsKfiFWx3bGTs+ovUIwkprHGccsZ4uelmgUsIivQryt/p
	pth8QzczJpqM0wD4W7cIuRmTxtdNF8LZMmZX48BxypiTFNMhoarHeOpZ2DK8Cy4t
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ri2QXI8uZdFr; Mon, 11 May 2026 16:31:15 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gDlbP2BppzlfwJB;
	Mon, 11 May 2026 16:31:13 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v4 02/12] block/bdev: Annotate the blk_holder_ops callback functions
Date: Mon, 11 May 2026 09:30:44 -0700
Message-ID: <20260511163100.1887263-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
In-Reply-To: <20260511163100.1887263-1-bvanassche@acm.org>
References: <20260511163100.1887263-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The four callback functions in blk_holder_ops all release the
bd_holder_lock. Annotate these functions accordingly.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/blkdev.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 8651af4fe9d7..d0c181da2da0 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1747,22 +1747,26 @@ void blkdev_show(struct seq_file *seqf, off_t off=
set);
 #endif
=20
 struct blk_holder_ops {
-	void (*mark_dead)(struct block_device *bdev, bool surprise);
+	void (*mark_dead)(struct block_device *bdev, bool surprise)
+		__releases(&bdev->bd_holder_lock);
=20
 	/*
 	 * Sync the file system mounted on the block device.
 	 */
-	void (*sync)(struct block_device *bdev);
+	void (*sync)(struct block_device *bdev)
+		__releases(&bdev->bd_holder_lock);
=20
 	/*
 	 * Freeze the file system mounted on the block device.
 	 */
-	int (*freeze)(struct block_device *bdev);
+	int (*freeze)(struct block_device *bdev)
+		__releases(&bdev->bd_holder_lock);
=20
 	/*
 	 * Thaw the file system mounted on the block device.
 	 */
-	int (*thaw)(struct block_device *bdev);
+	int (*thaw)(struct block_device *bdev)
+		__releases(&bdev->bd_holder_lock);
 };
=20
 /*
