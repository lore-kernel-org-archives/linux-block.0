Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B033315793
	for <linux-block@vger.kernel.org>; Fri,  5 Jun 2026 18:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682537; cv=none; b=BJMPW4/Op/GTKBdJvNTCGixw3GZih3VFyX5dg7nWBmKR9Np83O7GBLyrBRwozlUb6CnrE85VYLV1HkgJDqBpOYO0Vmwg5w7YSmUawEwt6RqCUuyogOjmhp2N0YsU5O0Rg38AdWGJJSUZLsjF/xA6I4fOQQuoqDyuHcdR6usYI8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682537; c=relaxed/simple;
	bh=PbjejrNawT6IZ42K2OrPYLND8imh1omKlH1OmqI+iRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NxR7bhbURmpRV4dff3XcY8eK++Me6r+MZb3gUrwsyX6sOiI06xOmTJ1lldf6yjOtBgFv6QSUdp3NbTlhmgtwT8HqyaxuBG3Mq0Q0Wgzbgf584m+r81OxdNPpfDJjIi8x49MZF0qZclajoPcazP0EMOLxbTlYS7h31H37GEG4/J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=nvcVh2AU; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="nvcVh2AU"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gX8Qq25crz1XM31H;
	Fri,  5 Jun 2026 18:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1780682528; x=1783274529; bh=iLgo9
	8zo1ytdUf3y8is2IG9mUanjcWnswmRCuBZWQgc=; b=nvcVh2AUcyutAej+9aEmH
	bJqgtM5EQe/OiuqApcFjrQ5N4EPSozNkmEbT9tsQuWa5e1NH0bQto6UvGQPrFFQf
	gwG8aRdBKq1WLXu6J/r9mbijblrQLpO1aN2wImsRHaocwipvXmXcU7SI8aPNZQZS
	5OIuxcm/pwJ9n5gIsay4LVaS73hkEs63LJtj4oDpGXKoEBzHGtZxeMYU8y2OFld8
	qYR5ZnVfYTTFXOJ3BYUUThPxgPTt8yYSFqhkA20CBFyb3W8uCfty6ZJ+UkBuAyxD
	AvyWvn3oXI8Y/h69qbdRytPhssdYYlbiuiEpR2hfIN98HFgPeaHT6ES1c0fjTbh/
	Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id o329KCtQMsHg; Fri,  5 Jun 2026 18:02:08 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gX8Qk3cycz1XM0pS;
	Fri,  5 Jun 2026 18:02:06 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v7 14/14] block: Enable lock context analysis
Date: Fri,  5 Jun 2026 11:01:07 -0700
Message-ID: <e248ca3aeead238bbc489cf3afdafcbff9e41faf.1780682325.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <cover.1780682325.git.bvanassche@acm.org>
References: <cover.1780682325.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now that all block/*.c files have been annotated, enable lock context
analysis for all these source files.

Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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
