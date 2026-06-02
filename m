Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6763921D5;
	Tue,  2 Jun 2026 05:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780379196; cv=none; b=qBf4Pf8t/DPkdKtf7YXHC3jWF6xPbWf90rl4SIZvuOVg4QtyKwvDFaWrVFiQL653T6Y97lVABpveZvMNSTry4Fc0fmCaKXUXjPWPP6C1vsgdjEzbu1nroAD/wajYvulzjVQRWmxsU04CCOxARCfPNbfmYWnsLxh2iYrXUu+U+VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780379196; c=relaxed/simple;
	bh=rk6zCqij9oa+to7fzRvJZ8MCHbtHiL2Kq7QEqbY3g0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dWKre34hEWQIjzX41smzc94S80krYYWSJQwdOOu2tRR8IXUJFkidiD1LJfnTtrfD+lNg6OQBZ+DiBunngaX4TeUz5aoCq6yAEWefbZGGCF/LKeN9RhINxVbvCLL2WR6RuPYaxxMuBdDiB32pV4JB8x2re+p7f3ApUXvcLf6H2Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VId1s/dV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VId1s/dV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=J9zj0thtFWK/FRL7psZTTm5VIq8vaeH7j09NvqI2188=; b=VId1s/dVUmBaiPVJIWS21NQt25
	4Usjv3W/1IgVlsfyoUzr4kkefoJV49oCT2Kn3MNxLNBzs1carUJeKCLVT/FsAux/qwnGODExw88bq
	afQ3tyowoCkEbN3iwgElWj2FFwXu42X72qcHHcoYKqfm9KNcm+eq2aDkkmy/g7Y0Vv/fyd/G+zVlN
	obKDMC2WjF7UFtCSkBx2c1ICjhaWK1IEOiTSCnQWQgu09JRvtAdaUWKWmOSTUAKz9VatSgzhTOTsj
	la+bHX7bMSYPAC7tkyG8Hg+m3AnCYJL1hlQX/TJ8zV6l5eG2MTiB4waLyO5XxcsRZk2YqHyJLFfz6
	sx3mOfag==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUHxS-0000000CLAm-11xV;
	Tue, 02 Jun 2026 05:46:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jonathan Corbet <corbet@lwn.net>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 4/9] block: move the FAIL_MAKE_REQUEST symbol from lib/ to block/
Date: Tue,  2 Jun 2026 07:45:36 +0200
Message-ID: <20260602054615.3788425-5-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602054615.3788425-1-hch@lst.de>
References: <20260602054615.3788425-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Keep the Kconfig symbol together with the code that it guards.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/Kconfig     | 6 ++++++
 lib/Kconfig.debug | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index 15027963472d..6c942391f65e 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -209,6 +209,12 @@ config BLK_INLINE_ENCRYPTION_FALLBACK
 	  by falling back to the kernel crypto API when inline
 	  encryption hardware is not present.
 
+config FAIL_MAKE_REQUEST
+	bool "Fault-injection capability for disk IO"
+	depends on FAULT_INJECTION
+	help
+	  Provide fault-injection capability for disk IO.
+
 source "block/partitions/Kconfig"
 
 config BLK_PM
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 8ff5adcfe1e0..fb085963ec5e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2116,12 +2116,6 @@ config FAULT_INJECTION_USERCOPY
 	  Provides fault-injection capability to inject failures
 	  in usercopy functions (copy_from_user(), get_user(), ...).
 
-config FAIL_MAKE_REQUEST
-	bool "Fault-injection capability for disk IO"
-	depends on FAULT_INJECTION && BLOCK
-	help
-	  Provide fault-injection capability for disk IO.
-
 config FAIL_IO_TIMEOUT
 	bool "Fault-injection capability for faking disk interrupts"
 	depends on FAULT_INJECTION && BLOCK
-- 
2.53.0

