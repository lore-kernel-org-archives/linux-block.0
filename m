Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3023D30DD22
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 21:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774475178; cv=none; b=oPoTg8fS3ypTf3fUvs2lyMx2WFxRUDjz+HoKsT2ayM/4pX6TP15ULZwCF9H1cR+gANYEOSewFkP8l2axkuerLyAgAxASD2phMU5o4vGhW5oic0C1af3SfQz4jUcLNq68vHgXE8JrRVkIFrtgYyM5LLcQsNiKYwE1AJDo8fw6SZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774475178; c=relaxed/simple;
	bh=l3wqP2IAlqH81GrmYuQavZjpgwE0r4YgYOSAqal48tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1gC19p/z5SB9fo8iB3DUnTh9koRfyuIQfWTu2RghmeoGcqM9Yw5N7YkXn4x6MrGQC5L60P/Sn1pZS14qLpJW0i3fCvmmCrYDRdmEwnBKzOhgeWXjIxWaeSH/UVOIzwhWOUGtA3bgaxkQTp2ca/ImafqAe8A78SsihuOq9euJBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=cQhe3IdH; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="cQhe3IdH"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fh0pc5zGNzlgwN4;
	Wed, 25 Mar 2026 21:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1774475174; x=1777067175; bh=Oq5i7
	I0yUYmx8GlxNEpRKWCdMH1smcNGOhJuiwcCmpw=; b=cQhe3IdHaVxKEZs39XudF
	DODlj60Kk5Sm5jJCHj8Vjd9U54/YlH/9P5QIcoi6LZkkGZKc7Da0mIhPoFRwzc6V
	ocVrH2yWAtvqF966ZD8mhjAXtMCDM9kOaiqTGxco6s8YwkXyWOZamh/Gc7Ici8pB
	BrTg6HlWQQBRSMoUs1gTm0NdrTB2EcPPTo3TUaaS4pa8EugIuQmgYjxablIQKO3D
	X/4z0qsDYjJAFM0ytVTTdxuA2uM1i/59RJWuCx2uWOIuesKs3C1S4l7otSr8ylAt
	vkDFctkVAX4FdCOVYStjv/o7aYsUQPWSU81qxoVKRZGN+/V1GHkPqiPYr3+tfUVi
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 8a1JtmkxRiiZ; Wed, 25 Mar 2026 21:46:14 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fh0pY16TczlfvpM;
	Wed, 25 Mar 2026 21:46:12 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 18/26] mtip32: Enable lock context analysis
Date: Wed, 25 Mar 2026 14:44:59 -0700
Message-ID: <20260325214518.2854494-19-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260325214518.2854494-1-bvanassche@acm.org>
References: <20260325214518.2854494-1-bvanassche@acm.org>
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
