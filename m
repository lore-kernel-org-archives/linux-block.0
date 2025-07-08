Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B15035968
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 01:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751937516; cv=none; b=JPHrA2kvKmnrRdA016QYFTl8weGBW5tU6/UsJ9YvA9Qb/yAB3g12pDDS8dV5fZvk55RuExKl44FgR62btxdp0+Ex2/LDtS6Ur/1v0zIKkHjsvutVyZJaBpaKiw3v3NBNZzds88n1hqbMij4PPdGDsFQZv2idqoQFm3rCd21mnNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751937516; c=relaxed/simple;
	bh=NMjaUXDjNK4Ob8LegIKICwIx7081kRvXDPkzp6jvHWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sc7WoRjG8ypRAehcRWIvzAZg59clpfT0ZwDt59rEY/NHvvyALNN7Gh62mel31K6RozhtzLpW89D6G5nVbPHxPRFfB+6fie6kN7KgUGdeUBwZhe6HBLpRpBYamBh6DrKhNAVLP+WPsl3aqLNPiXrkduyKOpWeXEadfosjVGwDoSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZE5M6rgL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZE5M6rgL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751937514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mA7GKrDuEhBuE9aeUMJcMjLAf7dat61/6neBVMy9zxo=;
	b=ZE5M6rgLtECiHvjCAMO8MgzluJICE8NZUf8m3Zix9vHfkALpbHvSDGJfB1tLSSMaFVglvT
	hyCMj8BEJ1sXnA4PScQ0ZMdWdUtbCg3PhMTmC0n9E+vLNV7Pd6QKLYl3a50JvJhTCjgmsh
	21yj3thJpQ2HOcw/K9F8/CeNXcWQePk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-y1-sOxDeOJe6rPBBLiENDQ-1; Mon,
 07 Jul 2025 21:18:28 -0400
X-MC-Unique: y1-sOxDeOJe6rPBBLiENDQ-1
X-Mimecast-MFC-AGG-ID: y1-sOxDeOJe6rPBBLiENDQ_1751937507
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B8FA418DA5CB;
	Tue,  8 Jul 2025 01:18:27 +0000 (UTC)
Received: from localhost (unknown [10.72.116.39])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 81562180045B;
	Tue,  8 Jul 2025 01:18:26 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 09/16] ublk: pass 'const struct ublk_io *' to ublk_[un]map_io()
Date: Tue,  8 Jul 2025 09:17:36 +0800
Message-ID: <20250708011746.2193389-10-ming.lei@redhat.com>
In-Reply-To: <20250708011746.2193389-1-ming.lei@redhat.com>
References: <20250708011746.2193389-1-ming.lei@redhat.com>
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
index 4fb5614a3910..d5fc99e175fc 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -995,7 +995,7 @@ static inline bool ublk_need_unmap_req(const struct request *req)
 }
 
 static int ublk_map_io(const struct ublk_queue *ubq, const struct request *req,
-		struct ublk_io *io)
+		       const struct ublk_io *io)
 {
 	const unsigned int rq_bytes = blk_rq_bytes(req);
 
@@ -1019,7 +1019,7 @@ static int ublk_map_io(const struct ublk_queue *ubq, const struct request *req,
 
 static int ublk_unmap_io(const struct ublk_queue *ubq,
 		const struct request *req,
-		struct ublk_io *io)
+		const struct ublk_io *io)
 {
 	const unsigned int rq_bytes = blk_rq_bytes(req);
 
-- 
2.47.0

