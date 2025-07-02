Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0376D1E1A33
	for <linux-block@vger.kernel.org>; Wed,  2 Jul 2025 04:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751429080; cv=none; b=mXzOb54X0/7E5pBI+k/n3R8p9V8FFisGX3Y9NB9vlBvn539rfHk4+h2id8p7xs9CLkjuakf/oT7U4RAUOsODN1+GXgkR1O8RBWFjeimFg1GgA+vMkxEuroINQPD9iYdAdFScP+zARkMZc0DiOxo2zZB907CsqvR80JF8edYi1FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751429080; c=relaxed/simple;
	bh=X8TBOK4gChzyjHcltOulk6qDzAFvJwNfmK+EflYDrfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSKz4osnWC0UcyM12hAHAHK+Q/lAOdzc+sRdxDUJeCxgMAsDghuV54om4nCWC2OZkzezPVlCv3ILwJU9B16wzIiLdTZARX7HOeUbmY9ee+OfmNc/Sl5udO/igpNzMWr1ygf1rW4Yk/6q2TiLHlC6JFw3xkEDwqDiWUiOMvNP+4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h9BmPj+3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9BmPj+3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751429078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y5Jj8xXi/hn7szA/qPUOf0ID+X36Jai8T4QhCGTYif0=;
	b=h9BmPj+3uiN72ozl/DNGolnq8zU3AgLWOPn1EwMSvWZP+YmNr3H9ug+C79TFotrmmDwKAg
	rerRsfuKLwjnBFyMQcXiPlWtP+Gvecnr42U2Rvd2COIuRc/117ofKfQKzi+q4AjnApDfuG
	ryd6ueHV6mjcpsyxR8QGU+ODQhwY+oo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-GlT5p2kdMCyOFRlR0zphQg-1; Wed,
 02 Jul 2025 00:04:34 -0400
X-MC-Unique: GlT5p2kdMCyOFRlR0zphQg-1
X-Mimecast-MFC-AGG-ID: GlT5p2kdMCyOFRlR0zphQg_1751429073
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B8352180136B;
	Wed,  2 Jul 2025 04:04:33 +0000 (UTC)
Received: from localhost (unknown [10.72.116.27])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DCBD218003FC;
	Wed,  2 Jul 2025 04:04:32 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 09/16] ublk: pass 'const struct ublk_io *' to ublk_[un]map_io()
Date: Wed,  2 Jul 2025 12:03:33 +0800
Message-ID: <20250702040344.1544077-10-ming.lei@redhat.com>
In-Reply-To: <20250702040344.1544077-1-ming.lei@redhat.com>
References: <20250702040344.1544077-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Pass 'const struct ublk_io *' to ublk_[un]map_io() since just io->addr
and io->res are read in the two helpers.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 13c6b1e0e1ef..3934254f7b99 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -993,7 +993,7 @@ static inline bool ublk_need_unmap_req(const struct request *req)
 }
 
 static int ublk_map_io(const struct ublk_queue *ubq, const struct request *req,
-		struct ublk_io *io)
+		       const struct ublk_io *io)
 {
 	const unsigned int rq_bytes = blk_rq_bytes(req);
 
@@ -1017,7 +1017,7 @@ static int ublk_map_io(const struct ublk_queue *ubq, const struct request *req,
 
 static int ublk_unmap_io(const struct ublk_queue *ubq,
 		const struct request *req,
-		struct ublk_io *io)
+		const struct ublk_io *io)
 {
 	const unsigned int rq_bytes = blk_rq_bytes(req);
 
-- 
2.47.0

