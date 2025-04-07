Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984F9253F20
	for <linux-block@vger.kernel.org>; Mon,  7 Apr 2025 13:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031793; cv=none; b=bpDVZRG/b7wE9IPlc78OHkgSgmWjyQQsgmLNgnDqtPwCa/MNcSiYcebE/mmqWKw4sym7QwdAp/iuKTcuehdBxPq88KotYuAu3pgJkasdyVoGN9MKb+WdofO8ZGFrZE7WyYRN5iKKlJAmFEjkambIx/ILMyzbV7g8F9o5UNDMPeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031793; c=relaxed/simple;
	bh=KZq4QoKgMrAoMsQXaTYf+Nu09d4m9p5vN+/jdetsFDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vCSaX3/Jfw5EZhpu1wBCEQVqRAtiB+tVAa/LtgyuMwYjMe9pvFjkeqOA5Z4MBnaGpOw/nv0TbznfcaTYrYJE/FMAruDuKlhcQgbmSU8FlCSFet9Y/gCGq+Gx4cPASk54n44nvpM1qNkIVc3vr6pxsd4Rj88TTQ/aD63bwsjbEno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R41Z/a4w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R41Z/a4w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744031789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NJrVHBBAAJTCFsRgGR/OHfz8R7FixPaw4/6HsYQ2cOQ=;
	b=R41Z/a4wXmW6Zse41YG7qFdCM5MR5PIVH6btBjC6kblTmdXvxzDIBd27yqO+XmUUaRsjbh
	d15ynsKnK+JLNeQt2opO1LonPMXFRF5p+5Jf+T3aqgB5T7/5Y1GTChykblE7pbtNc4ffv6
	53CD9VUQmOnQzPgSHuqISc4gFEgqCeA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-1Fmo9K1pPPSS60Ht94oTew-1; Mon,
 07 Apr 2025 09:16:26 -0400
X-MC-Unique: 1Fmo9K1pPPSS60Ht94oTew-1
X-Mimecast-MFC-AGG-ID: 1Fmo9K1pPPSS60Ht94oTew_1744031785
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88F9D1956089;
	Mon,  7 Apr 2025 13:16:25 +0000 (UTC)
Received: from localhost (unknown [10.72.120.16])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8B0531801A6D;
	Mon,  7 Apr 2025 13:16:24 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 08/13] selftests: ublk: setup ring with IORING_SETUP_SINGLE_ISSUER/IORING_SETUP_DEFER_TASKRUN
Date: Mon,  7 Apr 2025 21:15:19 +0800
Message-ID: <20250407131526.1927073-9-ming.lei@redhat.com>
In-Reply-To: <20250407131526.1927073-1-ming.lei@redhat.com>
References: <20250407131526.1927073-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

It is observed that this way is more efficient for fast nvme backing
file.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index f01d8618739b..a78eaa123859 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -346,7 +346,9 @@ static int ublk_queue_init(struct ublk_queue *q)
 	}
 
 	ret = ublk_setup_ring(&q->ring, ring_depth, cq_depth,
-			IORING_SETUP_COOP_TASKRUN);
+			IORING_SETUP_COOP_TASKRUN |
+			IORING_SETUP_SINGLE_ISSUER |
+			IORING_SETUP_DEFER_TASKRUN);
 	if (ret < 0) {
 		ublk_err("ublk dev %d queue %d setup io_uring failed %d\n",
 				q->dev->dev_info.dev_id, q->q_id, ret);
-- 
2.47.0

