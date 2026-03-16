Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C43F2512C8
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 20:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691798; cv=none; b=UgiUWsW+s6qpZxk0ivQIKyJFvj9zsPYWmNYR5URpCN2xxoI60jVwDq199O0lvAmx/k66xeEYZxIPwSguDwTBEjTtzLgq2gD7Y1qpwACioCz9Rf9xNJ7rHo9mU4qfoBW2R8psB/de0DWP+V7XMDXdoF2mao4h/WipfkUAkWKxfns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691798; c=relaxed/simple;
	bh=nWUsPqEz64DRxRs4stKE7KIOmuHx0LOPxKQEjZyS+jU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s70BPTOz/DIFL2LFOKp0EaToa3mbirIbGpxU9blynrHyShQtjjR21+OnJ5P3xKIfdnoOwaSe3u/HHQTC2Tbo6/9OLFO286iAS42fiysdRN539sDrxdDkfGR/1msSEw2F3VYq6evlbIcX84Jpd+rW6mdj3fgYQKAZyTS5JbQNHso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=JYY2/j5E; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="JYY2/j5E"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fZR5c5hMBzlgyGM;
	Mon, 16 Mar 2026 20:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1773691793; x=1776283794; bh=KCtAi
	2+JuLPtiSpcUSdnD8CARriGYij4GJ/FCeNg6Zs=; b=JYY2/j5Ecx5rI3OK/EqUS
	pnGf0IGXry1acgXMy8i39vI8o+aUV56jJ8tSFWqLFJusiOKggk7d5PJ4hOlLozXw
	+41nqDOD5/VnN8nUhYPtQrMg2VCqNn+UNpSrg+oZB1eDjlBCZfEKhCfdER/05JTO
	bfh+/7DTiihGKDz6PPTrIhfUG6qEaYFdtzwiSEVPLkGX0Q2sLR6k9BRvTtAs5Ejc
	ISLalW9QcwGs2xwbbxV0rmSvG5n6gwhKtaWBaOutXEcN2BR6vx00y//Kdyf2aBp4
	YDmOlB9RsAiF2mMZ/8/EJ46/KQ4aOe1pymD7hZuDcxw+N4R8qNsU7g/cCor7s7EZ
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id K16DMEJbhgke; Mon, 16 Mar 2026 20:09:53 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fZR5T4smszlh1TR;
	Mon, 16 Mar 2026 20:09:49 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 05/12] loop: Add lock context annotations
Date: Mon, 16 Mar 2026 13:08:42 -0700
Message-ID: <20260316200901.4111651-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
In-Reply-To: <20260316200901.4111651-1-bvanassche@acm.org>
References: <20260316200901.4111651-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prepare for enabling lock context analysis by adding lock context
annotations that are compatible with Clang.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/loop.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 0000913f7efc..9c7ed9e8a442 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -107,6 +107,8 @@ static DEFINE_MUTEX(loop_validate_mutex);
  * loop_configure()/loop_change_fd()/__loop_clr_fd() calls.
  */
 static int loop_global_lock_killable(struct loop_device *lo, bool global=
)
+	__cond_acquires(0, &lo->lo_mutex)
+	__no_context_analysis /* conditional locking */
 {
 	int err;
=20
@@ -128,6 +130,8 @@ static int loop_global_lock_killable(struct loop_devi=
ce *lo, bool global)
  * @global: true if @lo was about to bind another "struct loop_device", =
false otherwise
  */
 static void loop_global_unlock(struct loop_device *lo, bool global)
+	__releases(&lo->lo_mutex)
+	__no_context_analysis /* conditional locking */
 {
 	mutex_unlock(&lo->lo_mutex);
 	if (global)
