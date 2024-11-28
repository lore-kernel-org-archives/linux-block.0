Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9A019ABCE
	for <linux-block@vger.kernel.org>; Thu, 28 Nov 2024 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732798248; cv=none; b=jIBdtZ6Z1/6b5Hk5oK9pC+OLSBdSsp2nIWXZVbGTKZsDZpsovJ7STU2Uyiwa0G2TAE2Hcq9AF0j1J6rY9L1XRuAPRKPX8yJCQmRWJK67xMfuEdNuIujzeZ11sa0MtuSm6uI7D3Uu0meQzZbWoMoygYvOcaKLemO/cDUg59vP0mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732798248; c=relaxed/simple;
	bh=qnwKeAeKoIeOpLy9wUardJ1ziW36ogkCHDdPeoj10rM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVHSSiD0Du9KM3W4Ha82Faf+57cuOA64CZdS1V76zngAuk0fhP8IHHB5As9Bi+OdpifO3KiZ/bgInKjSIyuhJ04tjDwnsSRZDWwxm3R7fYgrVEKFr3m0PLarcyKoxC28f+9pVkFQGm08fwWXs9fTMk/aKf3ieh6zz8PG+0Vvj/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cyFQC5Ts; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cyFQC5Ts"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732798245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o1pgRsp4cfGaFnImvpUnu0IBg6IXsek3Sfai90cw6rc=;
	b=cyFQC5TspA4LDgWq2WwVfPfujeBhUnp/yt6Sc+DESEgr2W+cEzTwVPf2jCHGdSdfSJZZ4B
	EvYYfCw2HKOkJHTLUF9VeQVhV3wcf01wy7cUmfuD0MgRIAWwpaUz3pmRkfFMnP5EVQhpsF
	/vToDF8900gBzuXAqPUm+KTqNr7oEDw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-6tHQ4Pu9PsCOo5SJ_KsynA-1; Thu,
 28 Nov 2024 07:50:44 -0500
X-MC-Unique: 6tHQ4Pu9PsCOo5SJ_KsynA-1
X-Mimecast-MFC-AGG-ID: 6tHQ4Pu9PsCOo5SJ_KsynA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 36BCF19560A3;
	Thu, 28 Nov 2024 12:50:43 +0000 (UTC)
Received: from localhost (unknown [10.72.116.159])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DDB30195608A;
	Thu, 28 Nov 2024 12:50:41 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/2] blktrace: don't centralize grabbing q->debugfs_mutex in blk_trace_ioctl
Date: Thu, 28 Nov 2024 20:50:26 +0800
Message-ID: <20241128125029.4152292-2-ming.lei@redhat.com>
In-Reply-To: <20241128125029.4152292-1-ming.lei@redhat.com>
References: <20241128125029.4152292-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Call each handler directly and the handler do grab q->debugfs_mutex,
prepare for killing dependency between ->debug_mutex and ->mmap_lock.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 kernel/trace/blktrace.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 8fd292d34d89..f01aae3a2f7b 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -732,34 +732,32 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
 	int ret, start = 0;
 	char b[BDEVNAME_SIZE];
 
-	mutex_lock(&q->debugfs_mutex);
-
 	switch (cmd) {
 	case BLKTRACESETUP:
 		snprintf(b, sizeof(b), "%pg", bdev);
-		ret = __blk_trace_setup(q, b, bdev->bd_dev, bdev, arg);
+		ret = blk_trace_setup(q, b, bdev->bd_dev, bdev, arg);
 		break;
 #if defined(CONFIG_COMPAT) && defined(CONFIG_X86_64)
 	case BLKTRACESETUP32:
 		snprintf(b, sizeof(b), "%pg", bdev);
+		mutex_lock(&q->debugfs_mutex);
 		ret = compat_blk_trace_setup(q, b, bdev->bd_dev, bdev, arg);
+		mutex_unlock(&q->debugfs_mutex);
 		break;
 #endif
 	case BLKTRACESTART:
 		start = 1;
 		fallthrough;
 	case BLKTRACESTOP:
-		ret = __blk_trace_startstop(q, start);
+		ret = blk_trace_startstop(q, start);
 		break;
 	case BLKTRACETEARDOWN:
-		ret = __blk_trace_remove(q);
+		ret = blk_trace_remove(q);
 		break;
 	default:
 		ret = -ENOTTY;
 		break;
 	}
-
-	mutex_unlock(&q->debugfs_mutex);
 	return ret;
 }
 
-- 
2.47.0

