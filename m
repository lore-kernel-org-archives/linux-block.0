Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6565F451995
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 19:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785441557; cv=none; b=OL5HF4ZrUVm9UMRH+Ku9OwugfdTZDWFegV9HGXdHcYI7rVg6kLp2Y1dalaiXNHkp79GDzicE7G0OrgAXYmqptYq5c/caDl10IeEeU2rQBsUkHI73PBUQ/Samh2ommu14H/ytqnvqbewQ+9vjx2zd7BJPPz0QMhNaJC8QgpLlu7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785441557; c=relaxed/simple;
	bh=HDXd5DocGK3XFvHzqDZMtnFHkbey3J83oC0uzWzTN9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ly1CTGAP7ScvnTMnPR3bw14EtEI/bYK2OVrK4CmTphIVRHfzTRnBltfZQSAM/XQAJ1vXPsqZUbVsLbbT4rEZ4nLbOBjBf1OE808aAsmFUGihK2HPXnwpRD5+ZXah2xDHHhHeyWJJWDp0DIQMEOF+1GFTqHvfwA248qaGr8IvWyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=pUb1wpLb; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="pUb1wpLb"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hB0QT5T5KzlfpPB;
	Thu, 30 Jul 2026 19:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1785441550; x=1788033551; bh=EEpVY
	PznJKDDgG4onoErRDQ6/dKDYeFB35OkYhgEmRE=; b=pUb1wpLbWzkR05J1F2uDt
	HlWX4bJkuImRdFg4wVxzdZtQ2BBJBwT7dkVzsHQmOuqV23TMF9srXelmeky6YW0Z
	FwEaOzAsxRryc9uq1D4vD221K6USSWLxQDCdLkBj8FXBNcHxVQtxrnf8O4AG37fg
	EEhiCF2vUVkIVQXtLXmRJX+3P9QzwY/Nw+MlugO7sYgxDVikYaYsUjb37Up6mLRr
	SI04eJueS8z0MfSQ7pjmjEypPIZ3lPCzcgHqDkLWlq3clRT6OtEJ1mLxiACpnQEz
	KHZkuG+bh29eMsQxphobpnrOaXxokIZzg1ANSYmvbxZlZIVEyPbzWZpqUtOTS/If
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id W997ULVRMUiO; Thu, 30 Jul 2026 19:59:10 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hB0QM4Fnszlfvpx;
	Thu, 30 Jul 2026 19:59:07 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 04/12] mtip32: Enable lock context analysis
Date: Thu, 30 Jul 2026 12:58:27 -0700
Message-ID: <ee97a457fa3dc450215bb813b8dd9b0c488ec9b2.1785440858.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
In-Reply-To: <cover.1785440858.git.bvanassche@acm.org>
References: <cover.1785440858.git.bvanassche@acm.org>
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
