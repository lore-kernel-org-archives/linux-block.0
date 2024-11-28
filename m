Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547D913D8B4
	for <linux-block@vger.kernel.org>; Thu, 28 Nov 2024 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732798255; cv=none; b=eh+rSdPBoZTDO2LybquD7hegIvYyKG19IYNfRdwceblrjwW+eNxa72MRE5MwWHH5JhhhzIjAXfBKVrG9yIbMG+/Q+OumJDr+LGxEbFClo+zBp83SCXr3xikM2lJdXWbF5DFhYVmv1sFEvVwuUkH1N7TuQPRhGH4fbNpTM2cjJzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732798255; c=relaxed/simple;
	bh=/dKme3uQD+N5NuhgG9qYcMZrSV2g3Uld0xxljTwog2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fFSzrphH666HHrAknkm1y7KZBIc7wNBKniuzH1Z3ylkIYbFYhawOxh5nWpsN/o33oAobTjsolu/SUWYPEdZ8X1EWj9wXyCUfn3WyhdCWDuuY7eAxntl7BE3DFwyleQX97DMzyM2iiewaNeRVD9ZZrrfaB77dFQQk9m5LSAkH3wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dag0pUK0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dag0pUK0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732798252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iYYnNHNPukd0UTaf1Skea2hsQxxQsswzclcaKaT3NLk=;
	b=Dag0pUK0MZQjuBUPU6qECyYUFf3d5GIYF8te6PkqAi9QIwlCZkW/hILuHAvnIpYfy1wx8h
	WdquOAaqcpno3s0vXrAnsDRLB/7x04Mn09kCgXloqtYXoahd1SsL6mVW3J/e3dMDAi/sfj
	Sbjnb82UUmuph0pMYZBTCu4w90dIuq0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-9xAI2e3TOLig6edAT-WpHg-1; Thu,
 28 Nov 2024 07:50:48 -0500
X-MC-Unique: 9xAI2e3TOLig6edAT-WpHg-1
X-Mimecast-MFC-AGG-ID: 9xAI2e3TOLig6edAT-WpHg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A168A1955DCA;
	Thu, 28 Nov 2024 12:50:47 +0000 (UTC)
Received: from localhost (unknown [10.72.116.159])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 957F51955D45;
	Thu, 28 Nov 2024 12:50:45 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	syzbot+91585b36b538053343e4@syzkaller.appspotmail.com
Subject: [PATCH 2/2] blktrace: move copy_[to|from]_user() out of ->debugfs_lock
Date: Thu, 28 Nov 2024 20:50:27 +0800
Message-ID: <20241128125029.4152292-3-ming.lei@redhat.com>
In-Reply-To: <20241128125029.4152292-1-ming.lei@redhat.com>
References: <20241128125029.4152292-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Move copy_[to|from]_user() out of ->debugfs_lock and cut the dependency
between mm->mmap_lock and q->debugfs_lock, then we avoids lots of
lockdep false positive warning. Obviously ->debug_lock isn't needed
for copy_[to|from]_user().

The only behavior change is to call blk_trace_remove() in case of setup
failure handling by re-grabbing ->debugfs_lock, and this way is just
fine since we do cover concurrent setup() & remove().

Reported-by: syzbot+91585b36b538053343e4@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-block/67450fd4.050a0220.1286eb.0007.GAE@google.com/
Closes: https://lore.kernel.org/linux-block/6742e584.050a0220.1cc393.0038.GAE@google.com/
Closes: https://lore.kernel.org/linux-block/6742a600.050a0220.1cc393.002e.GAE@google.com/
Closes: https://lore.kernel.org/linux-block/67420102.050a0220.1cc393.0019.GAE@google.com/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 kernel/trace/blktrace.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index f01aae3a2f7b..18c81e6aa496 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -617,8 +617,9 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	return ret;
 }
 
-static int __blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
-			     struct block_device *bdev, char __user *arg)
+int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
+		    struct block_device *bdev,
+		    char __user *arg)
 {
 	struct blk_user_trace_setup buts;
 	int ret;
@@ -627,26 +628,17 @@ static int __blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	if (ret)
 		return -EFAULT;
 
+	mutex_lock(&q->debugfs_mutex);
 	ret = do_blk_trace_setup(q, name, dev, bdev, &buts);
+	mutex_unlock(&q->debugfs_mutex);
 	if (ret)
 		return ret;
 
 	if (copy_to_user(arg, &buts, sizeof(buts))) {
-		__blk_trace_remove(q);
+		blk_trace_remove(q);
 		return -EFAULT;
 	}
 	return 0;
-}
-
-int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
-		    struct block_device *bdev,
-		    char __user *arg)
-{
-	int ret;
-
-	mutex_lock(&q->debugfs_mutex);
-	ret = __blk_trace_setup(q, name, dev, bdev, arg);
-	mutex_unlock(&q->debugfs_mutex);
 
 	return ret;
 }
@@ -673,12 +665,14 @@ static int compat_blk_trace_setup(struct request_queue *q, char *name,
 		.pid = cbuts.pid,
 	};
 
+	mutex_lock(&q->debugfs_mutex);
 	ret = do_blk_trace_setup(q, name, dev, bdev, &buts);
+	mutex_unlock(&q->debugfs_mutex);
 	if (ret)
 		return ret;
 
 	if (copy_to_user(arg, &buts.name, ARRAY_SIZE(buts.name))) {
-		__blk_trace_remove(q);
+		blk_trace_remove(q);
 		return -EFAULT;
 	}
 
@@ -740,9 +734,7 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
 #if defined(CONFIG_COMPAT) && defined(CONFIG_X86_64)
 	case BLKTRACESETUP32:
 		snprintf(b, sizeof(b), "%pg", bdev);
-		mutex_lock(&q->debugfs_mutex);
 		ret = compat_blk_trace_setup(q, b, bdev->bd_dev, bdev, arg);
-		mutex_unlock(&q->debugfs_mutex);
 		break;
 #endif
 	case BLKTRACESTART:
-- 
2.47.0

