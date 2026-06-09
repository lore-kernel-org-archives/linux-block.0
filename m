Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5B147F2CB
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 22:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042798; cv=none; b=nJDQNc/+83TYZ+FnGDfhUPVjlysaKF2mOiU7W89DGG7KXmX7SAx/79p6+kizyDz+PRzGS0lo/6yc2pxDrY+lpc9O/bc1PjEJPmODiyyjIOwF4bTOcjj2wWzJzWar5TBXzvKexDSZGGmJTpBXpoAXaTOS+JWiDsI8aQxBiHD2THg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042798; c=relaxed/simple;
	bh=HDXd5DocGK3XFvHzqDZMtnFHkbey3J83oC0uzWzTN9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XsrufRwI8trvMlN1Ao5//DgyB63WtDBMkEbk+jRNwzU0eRoY9cfQyIWp53eprurQHQT4rRJ6Zn3OD0c7zhXPKNAhEqaFplr1wWJv/OFblk+Pxpqx7645XsgNcPjnZHYGanYgpjYgniaADLxd5fkpYbE6r2mYZAYMv27OGZKHE2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=zAwb3k9k; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="zAwb3k9k"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gZjg10KVDzlh2rH;
	Tue,  9 Jun 2026 22:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1781042794; x=1783634795; bh=EEpVY
	PznJKDDgG4onoErRDQ6/dKDYeFB35OkYhgEmRE=; b=zAwb3k9krX2LRNwSrf5Py
	kKuWOdtF4BPftrCag6wnv77avyEqRCbTa5OskKBLsqfdxpd1DdNw4O87SsbL+wJ1
	FwI/WPFZs1u7ntMRJ9rJL+WIczzVFoEZbw1Q6gAEpJD4HmBsp7om4EKwjK4UVqHN
	2fFfJzL9vlz4Dq9dyPY+HJ1T2SdDdJ0J/vDpV4JZNQ+qHKUYMeCaGTaxtHTm6jSk
	M15zYFJX4696Z6A1b7edq4fpYYhokMj/uwGECFZuyYaJbI0tXXfsLjpK+sqNzMDw
	dxRKSzfvc66HsgiqGz/9kjflw1jP+NgbYc8fX/dobsGCeLO1kicQZJqOfisX6M7A
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id N2YmXTQ1iEmn; Tue,  9 Jun 2026 22:06:34 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gZjfx0k5GzlfddT;
	Tue,  9 Jun 2026 22:06:32 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 19/27] mtip32: Enable lock context analysis
Date: Tue,  9 Jun 2026 15:05:06 -0700
Message-ID: <f511013682f7a1281298ab128e74ea1eba887ef6.1781042470.git.bvanassche@acm.org>
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

Let the compiler verify lock and unlock calls. Enable lock context analys=
is
in the Makefile.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/mtip32xx/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/mtip32xx/Makefile b/drivers/block/mtip32xx/Mak=
efile
index bff32b5d3c19..233961fdb41b 100644
--- a/drivers/block/mtip32xx/Makefile
+++ b/drivers/block/mtip32xx/Makefile
@@ -3,4 +3,6 @@
 # Makefile for  Block device driver for Micron PCIe SSD
 #
=20
+CONTEXT_ANALYSIS :=3D y
+
 obj-$(CONFIG_BLK_DEV_PCIESSD_MTIP32XX) +=3D mtip32xx.o
