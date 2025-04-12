Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4114E4A08
	for <linux-block@vger.kernel.org>; Sat, 12 Apr 2025 02:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744425082; cv=none; b=g1wDDua348c5GcL7D0r81AgiVnVDhP3r/OJQ46s6Av+vTUdMalJzetgpUzCnOWaVIet/BtDdi7aR5eMUuaUxwrUqABEsfnlnJr5O/emt1/tKoIbOYXOwowuyhtY2/32viqXvfi8yDdt6n5yc2Fys0ItyNfiNLIr/CRKpEnJz9ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744425082; c=relaxed/simple;
	bh=OQSpqOPpt0m2KQuydzvqCZfrwiQ31dNYlYhTA2Y8v5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QxExQ/C/nfI4Ku750oVKXmlGbHeGOpNJLXFyRpInzjV6jO3H53R7RNLolVTwZtyPNaBeJ3tWMsBRwK2md6W894lcLUQIeRpgwgVMHuCCGZxD1gO3Hwmy2h7dHQ+gpPFPyoOA0G0z+9Uf7G3DDbIxp/Rna8lI7xBesAuUe23TtUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SLW6wvqA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SLW6wvqA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744425080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YmPUm2VWc3cr7ayhr3Q17sSfeHo6XS9NFo2nEG8owO0=;
	b=SLW6wvqAwnY/R4FLTD7MPBRybC1s9Zx6q4EehGns7Tc9m+gxzw8Pufx1BqHLhIDU06ebHi
	PEElDy/gaRL52qBxONw4BqEsIFLUnsIJGd9O5lX0VyP0tGemAxDvXNl0lzEx9Up3HIGij4
	3HVGLifNKapUyBoYpMlMzFMtCCVTd4w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-QrVdz9BLMwWnERKjOZXGKw-1; Fri,
 11 Apr 2025 22:31:15 -0400
X-MC-Unique: QrVdz9BLMwWnERKjOZXGKw-1
X-Mimecast-MFC-AGG-ID: QrVdz9BLMwWnERKjOZXGKw_1744425074
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D2A4819560B6;
	Sat, 12 Apr 2025 02:31:14 +0000 (UTC)
Received: from localhost (unknown [10.72.116.41])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B9657180B492;
	Sat, 12 Apr 2025 02:31:13 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 07/13] selftests: ublk: setup ring with IORING_SETUP_SINGLE_ISSUER/IORING_SETUP_DEFER_TASKRUN
Date: Sat, 12 Apr 2025 10:30:23 +0800
Message-ID: <20250412023035.2649275-8-ming.lei@redhat.com>
In-Reply-To: <20250412023035.2649275-1-ming.lei@redhat.com>
References: <20250412023035.2649275-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

It is observed that this way is more efficient for fast nvme backing
file.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 381e31acaad9..c2acd874f9af 100644
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

