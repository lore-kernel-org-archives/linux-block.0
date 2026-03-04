Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3AA38645C
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 19:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772653779; cv=none; b=jHU6Rhs/C9Bsw4EfSHkKejrw/VW0bxdSH+RJtcs5OgGPsvyO0vpSjOtnIZHJ2uCL1uDCRTdC8Y0h1CPUqiKqU0IPD743makpoJ0aFn1LhNT22UH8wUfOSma8jzB0O8BOWCY5uDpFy6EaqI3ILufWyl5TdBMTFq2Uobd5f7Vf+VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772653779; c=relaxed/simple;
	bh=L6TAVjg7sv+OPxG/g8P6vYp/daYdDljx94pVN3kNdHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iiRPtlfjVCGF40bX1btbJWE9ApJijGz8HY62PMioNr5hHOrAF/vxD9UvgFGVrH/PGuiMXK+TM32rfmKv6YgI6uDMLopH/4hqy4GkBiOv/20JfInx+s3UBYmeBzvk0C5JggBVRfD1AhpvJ8lpwAuw8GQRf4jSvBDMxoVQ9G9kuAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=wIpsGyPn; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="wIpsGyPn"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fR3Cj6Qf4z1XMFvJ;
	Wed,  4 Mar 2026 19:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1772653772; x=1775245773; bh=7B10S
	+sJnVAXlchT8ImoLMbPxZITPlWs+WhTQU+3xj8=; b=wIpsGyPnhTHGVJvUX/ta3
	K7c/JMke0jVaFA7ExImHZvtdqBMpiHuqMmDyp+e5Eyt0/Kd1SXHERt5iVXCHPrAE
	BfMTTGJ2kYLBDy5MhA38bQVImEep4K+ayfeWGsglUHSvpeUFz80orOCwWjfkSnpE
	N/CZu/tulzZBb3TmzP8AB5vLli5iSbFRF9THZAlCYwXtpyIan2HO9lknJPIJRJyF
	GwAqFKhx/YfRddjuP1AVLi21eSL72z2FYSskcGu+ONPt3CZbtwLodq1Jq1Pjq6Mz
	2tw84JgOLSaCdoxeNNDTUNHEG60j/haGL5izT3TtEjugSddLgYEbySDbiFYf5307
	Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id CTbEidalZIT7; Wed,  4 Mar 2026 19:49:32 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fR3CY6wrCz1XM0p0;
	Wed,  4 Mar 2026 19:49:29 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>,
	linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 10/14] rnbd: Add more lock context annotations
Date: Wed,  4 Mar 2026 11:48:29 -0800
Message-ID: <20260304194843.760669-11-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260304194843.760669-1-bvanassche@acm.org>
References: <20260304194843.760669-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prepare for enabling lock context analysis by adding the lock context
annotations required by Clang.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/rnbd/rnbd-clt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.=
c
index 4d6725a0035e..7f0f29b8e75a 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -833,6 +833,7 @@ static int wait_for_rtrs_connection(struct rnbd_clt_s=
ession *sess)
 static void wait_for_rtrs_disconnection(struct rnbd_clt_session *sess)
 	__releases(&sess_lock)
 	__acquires(&sess_lock)
+	__must_hold(sess_lock)
 {
 	DEFINE_WAIT(wait);
=20
@@ -855,6 +856,7 @@ static void wait_for_rtrs_disconnection(struct rnbd_c=
lt_session *sess)
 static struct rnbd_clt_session *__find_and_get_sess(const char *sessname=
)
 	__releases(&sess_lock)
 	__acquires(&sess_lock)
+	__must_hold(sess_lock)
 {
 	struct rnbd_clt_session *sess, *sn;
 	int err;
