Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200482EDD78
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 19:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779997579; cv=none; b=VnAjrrrRBEddryCUUhFsOMEoeF54o2PmogVlwg6lM5K2vXq8K1Y+iNvmj8UYsPERjxN31vtKGU5am+5vA/euWn+YwaUx1eMwnV6S+AaLYV+3/bba0XRCRi7rtdKFB1wCQKlhCBQqG/HzT1Kf2Tiv5xqAVkzMJaEA6JYG4Iq+Zjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779997579; c=relaxed/simple;
	bh=MjMk04CFpUUYoFkUp3h0Mqe6Z0y2dVuE3K9If/T291I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4AFadv57A2AOmZK/zQCiCMXsBk4epfjlERJzCo5QMrz3mUJBf5ePY3/MPubUytpIEFgfvvE9G14VPw8GDgxGGXOXAeDluwBVJu2pfbaMMHHrAHsjF9rU4ZOWo8Wx/HlnSRFy8u5UCoZjqsjhW0O2r0jhCDo+8kvzg9jOD85R24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=IY8zUoKN; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="IY8zUoKN"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gRH6d4v1Qz1XM0pk;
	Thu, 28 May 2026 19:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1779997574; x=1782589575; bh=3ufyK
	TxiE2gqOc27SlwquxrKpUMexU/35mQWCNwk4yo=; b=IY8zUoKNp+4dwc8PDphr3
	FyAimmdz530HbhECvXJzUpNmDBGe1dc9Sw+EqV7iSvdcw0Di32ihsaj7oMGyXsvQ
	bbthA6VTV0vBwg5EH4SoRBH1yMa/f+dwelCXSXlLKaQWNtUewfzvgZnWrrait6JE
	KKAer0nh3oWmKfPgA93Xrq94C46k+hJBdWYI8AzOMtVckGIIDzgvvcjWIbGDqFVU
	ORfD9Zbc73NU8CMl36Ay29aUdgN0A6ugLqW2HOnH4x+7WBcEPyQeZtpfg//GxLWi
	T/IDV9ns18wbf3xslYNTvS7a3Eh/4FItk+Q/dBo+Q08ym8d03QA19ZIiI2IuFhsf
	Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id StHXuaXuK2bo; Thu, 28 May 2026 19:46:14 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gRH6W3Cjzz1XM0pY;
	Thu, 28 May 2026 19:46:11 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v5 02/12] block/bdev: Annotate the blk_holder_ops callback functions
Date: Thu, 28 May 2026 12:45:39 -0700
Message-ID: <b0541615a41fc06f1c0636575db48dd3d7f30e64.1779997063.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
In-Reply-To: <cover.1779997063.git.bvanassche@acm.org>
References: <cover.1779997063.git.bvanassche@acm.org>
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
index 65efbd7fe1a3..57e84d59a642 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1746,22 +1746,26 @@ void blkdev_show(struct seq_file *seqf, off_t off=
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
