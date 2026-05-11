Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97EE46AF33
	for <linux-block@vger.kernel.org>; Mon, 11 May 2026 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517103; cv=none; b=XFM+0JuIU02+YzZGWtXRNRlaop8ZNBToalu2p56JW6QyxwDKRb3uWvGtKvTlk4lINQnYLJlnLEos3GDs8/a7OxAsmDNH13NftSYEGb6esK/J6idhrh8n8jkz+Y+oCivqBeWQbALjgsrLEaScksmJpPBzNWhYZQ/avVu4yFb9Jkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517103; c=relaxed/simple;
	bh=k7L4UigFG9RtH8rF3fSiua0sdY9POVY5hNPSfcW3jsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2NIY6+FBT3ws4pG7qa9bBQ8BmE7E+5taX2Jn/EDSY615V3UmAGn50N/lQMTiVpGmbLQ8d1UnYZzw4c/GwUQZBL3yEpg39fCyMJVS1EiKc11zX/0c5ZE/kcd9zz9tjOXzvkGEu//8DXCf273gyA+6nXPIIfJa0iqnLeIkCvAZtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=0urg4qhO; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="0urg4qhO"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gDlbw4mK7zlfddR;
	Mon, 11 May 2026 16:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1778517098; x=1781109099; bh=6NbH4
	rNgGbE+WQFo+E01o3eAWSCIvVjj2EdAsH8xE2o=; b=0urg4qhOlVLIn4c4pfC/1
	c9Anyz6e+UDfgJVjH3uOlJsp4VIFOVVmhURgwIzCDMbHWXasFoLbGI5YCgACg3xs
	eP82hgxVSCvFO2Tnu+zZWSByopfmESAJxANPsxPLZWZwezVzl/2yG9qnEAgmQyrL
	TV7EMh579sRLGLhi5aX1UqzPm2O3gayvg4zFoHsloIn5e57Q/7MIWBtyrRF+Tt0N
	wYFSDFiGNhoAVzGBi0QxGTB62JRF9s+KM8LuDGqlnweKI4ZKp46hXhNLO3qSpoRx
	rkLgpGikamJ1K+axsz9TSLZlRnObZ8krdGW/28W2ia2+z0loG51G3oCH5sEmuuRT
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Y_KFRHVni22G; Mon, 11 May 2026 16:31:38 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gDlbr69cnzlh2fv;
	Mon, 11 May 2026 16:31:36 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v4 12/12] block: Enable lock context analysis
Date: Mon, 11 May 2026 09:30:54 -0700
Message-ID: <20260511163100.1887263-13-bvanassche@acm.org>
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

Now that all block/*.c files have been annotated, enable lock context
analysis for all these source files.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/Makefile b/block/Makefile
index 7dce2e44276c..54130faacc21 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -3,6 +3,8 @@
 # Makefile for the kernel block layer
 #
=20
+CONTEXT_ANALYSIS :=3D y
+
 obj-y		:=3D bdev.o fops.o bio.o elevator.o blk-core.o blk-sysfs.o \
 			blk-flush.o blk-settings.o blk-ioc.o blk-map.o \
 			blk-merge.o blk-timeout.o blk-lib.o blk-mq.o \
