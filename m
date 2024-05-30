Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CC717F513
	for <linux-block@vger.kernel.org>; Thu, 30 May 2024 13:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717076773; cv=none; b=tqyY3+3jg9cNLy6D2RAYLQieh1rcu2IidDgPCqsPMWdyG4dvKC3DnGXkodtVkTkTFuWQDuJRP6M2X1fTQY/y30zc55qkKn3WQLNPwqNFAdr3bN8SyrR8lpgYrzuPWBJI3fzL7awfs3VfRU1Paqmvg4DF/WXmbLuKEBX3CzjwYMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717076773; c=relaxed/simple;
	bh=juDbdX0Y8GqixK8pMaIwY4mK1Kc2Uns7SMNNeKabaC8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e0DDPwXTVUSsBCpMx0Ec8ppWIbPdJt1eZhrArT7LJPQpu1eYf3meKfJyf/MP0zS+AFkVnWfS3f2KBBRUOIRJMh8k6ltUe2XOfijlNOeeP5zX/iwzygP3B/3VTjQ5klCNd5xRphVgFCfpESEzh8Teq3U/3kccfwSGqVsY3fN9Rsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TEckmd6x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TEckmd6x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717076770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EfyjO2O9S+39QYbsHE3kG4m3i1fzVGSXeu8l7KeSxG4=;
	b=TEckmd6xdZzVOAFhmwJGyP8+sZxLRT4vsPo7e2Hs1yBvrXZUleBRazVm6zAk65YNHAL2Z3
	VfePEQbyIHm727MAtvWv61W92jObjqaem4hz6qgJ26AQdayXxYPr/+7odSEEn6cxdoAFs4
	oaE7kMeQfq6LZkYgu76kqcmcIPfmYP4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-OC8SETo-PHm4FRv1JHhA0A-1; Thu,
 30 May 2024 09:46:09 -0400
X-MC-Unique: OC8SETo-PHm4FRv1JHhA0A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF82A29AA387;
	Thu, 30 May 2024 13:46:08 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.42])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9F5CA40C6EB7;
	Thu, 30 May 2024 13:46:07 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Ming Lei <ming.lei@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Justin Forbes <jforbes@redhat.com>
Subject: [PATCH] blk-throttle: Fix incorrect display of io.max
Date: Thu, 30 May 2024 09:45:47 -0400
Message-Id: <20240530134547.970075-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Commit bf20ab538c81 ("blk-throttle: remove CONFIG_BLK_DEV_THROTTLING_LOW")
attempts to revert the code change introduced by commit cd5ab1b0fcb4
("blk-throttle: add .low interface").  However, it leaves behind the
bps_conf[] and iops_conf[] fields in the throtl_grp structure which
aren't set anywhere in the new blk-throttle.c code but are still being
used by tg_prfill_limit() to display the limits in io.max. Now io.max
always displays the following values if a block queue is used:

	<m>:<n> rbps=0 wbps=0 riops=0 wiops=0

Fix this problem by removing bps_conf[] and iops_conf[] and use bps[]
and iops[] instead to complete the revert.

Fixes: bf20ab538c81 ("blk-throttle: remove CONFIG_BLK_DEV_THROTTLING_LOW")
Reported-by: Justin Forbes <jforbes@redhat.com>
Closes: https://github.com/containers/podman/issues/22701#issuecomment-2120627789
Signed-off-by: Waiman Long <longman@redhat.com>
---
 block/blk-throttle.c | 24 ++++++++++++------------
 block/blk-throttle.h |  8 ++------
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index d907040859f9..da619654f418 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1347,32 +1347,32 @@ static u64 tg_prfill_limit(struct seq_file *sf, struct blkg_policy_data *pd,
 	bps_dft = U64_MAX;
 	iops_dft = UINT_MAX;
 
-	if (tg->bps_conf[READ] == bps_dft &&
-	    tg->bps_conf[WRITE] == bps_dft &&
-	    tg->iops_conf[READ] == iops_dft &&
-	    tg->iops_conf[WRITE] == iops_dft)
+	if (tg->bps[READ] == bps_dft &&
+	    tg->bps[WRITE] == bps_dft &&
+	    tg->iops[READ] == iops_dft &&
+	    tg->iops[WRITE] == iops_dft)
 		return 0;
 
 	seq_printf(sf, "%s", dname);
-	if (tg->bps_conf[READ] == U64_MAX)
+	if (tg->bps[READ] == U64_MAX)
 		seq_printf(sf, " rbps=max");
 	else
-		seq_printf(sf, " rbps=%llu", tg->bps_conf[READ]);
+		seq_printf(sf, " rbps=%llu", tg->bps[READ]);
 
-	if (tg->bps_conf[WRITE] == U64_MAX)
+	if (tg->bps[WRITE] == U64_MAX)
 		seq_printf(sf, " wbps=max");
 	else
-		seq_printf(sf, " wbps=%llu", tg->bps_conf[WRITE]);
+		seq_printf(sf, " wbps=%llu", tg->bps[WRITE]);
 
-	if (tg->iops_conf[READ] == UINT_MAX)
+	if (tg->iops[READ] == UINT_MAX)
 		seq_printf(sf, " riops=max");
 	else
-		seq_printf(sf, " riops=%u", tg->iops_conf[READ]);
+		seq_printf(sf, " riops=%u", tg->iops[READ]);
 
-	if (tg->iops_conf[WRITE] == UINT_MAX)
+	if (tg->iops[WRITE] == UINT_MAX)
 		seq_printf(sf, " wiops=max");
 	else
-		seq_printf(sf, " wiops=%u", tg->iops_conf[WRITE]);
+		seq_printf(sf, " wiops=%u", tg->iops[WRITE]);
 
 	seq_printf(sf, "\n");
 	return 0;
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index 32503fd83a84..8c365541a275 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -95,15 +95,11 @@ struct throtl_grp {
 	bool has_rules_bps[2];
 	bool has_rules_iops[2];
 
-	/* internally used bytes per second rate limits */
+	/* bytes per second rate limits */
 	uint64_t bps[2];
-	/* user configured bps limits */
-	uint64_t bps_conf[2];
 
-	/* internally used IOPS limits */
+	/* IOPS limits */
 	unsigned int iops[2];
-	/* user configured IOPS limits */
-	unsigned int iops_conf[2];
 
 	/* Number of bytes dispatched in current slice */
 	uint64_t bytes_disp[2];
-- 
2.43.0

