Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417E633E364
	for <linux-block@vger.kernel.org>; Wed, 26 Nov 2025 16:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764174983; cv=none; b=gstLLRmxI1J0WvdzVqZCb0NEn/WPFUWvMhqSZ5LCmLTDfNYF39gssmaCCGUlvino8XcFs/s8LBMP/3BgRqOKnKQNg7t0RtydbXJLTLXd4hFgOwM/CeqR2ov16b/y8CjWYqsoLe6bSMHhsNILoW6iOVac5YxCHSASQSgtYNSBJuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764174983; c=relaxed/simple;
	bh=gyIXhfyr6nZM6LF63rYOm8b1zevtzeUIHbeqJNAK3Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7Gyy59iA7QmilmupDn8WY5ry1N58o+YVmXT/jDvAZiplikUuQ/ti8OfekO4nBCKsjatVhyM44zknF04IxouD9og0VVucFr3IZ7u7GxAFTSsVgGdOgTiKVoFc98XUv4/6YAdHqWoUDSfMPTbqE0xw6E9VLepdSky6+/bWDLGf70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PSGG4Yr2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PSGG4Yr2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764174981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4YKeJBoqj49IiVaa5396deScmldRsSYyxygJIXwbHUQ=;
	b=PSGG4Yr2f56BmaZQFjoEyfVUieWdgyNRoWZoJLvuh8H+Jh6ThFN+VRWVVCfUBGhhgPKPLn
	ggc3pXbpQWp7wylzhmVPnHbyxRQ2eEl+ifPn+ZSvuugeTf7PLbrcLeR0FYjZk9Z2aHEMZJ
	S6ndv06Z8rlAU+c6QAQJRm0HASdaOtg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-363-iV1plFoROoSzVVS9yFOPdQ-1; Wed,
 26 Nov 2025 11:36:15 -0500
X-MC-Unique: iV1plFoROoSzVVS9yFOPdQ-1
X-Mimecast-MFC-AGG-ID: iV1plFoROoSzVVS9yFOPdQ_1764174974
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C43B180057A;
	Wed, 26 Nov 2025 16:36:14 +0000 (UTC)
Received: from localhost (unknown [10.2.16.50])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8368930044E0;
	Wed, 26 Nov 2025 16:36:13 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: linux-block@vger.kernel.org
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Mike Christie <michael.christie@oracle.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-scsi@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 4/4] block: add IOC_PR_READ_RESERVATION ioctl
Date: Wed, 26 Nov 2025 11:36:00 -0500
Message-ID: <20251126163600.583036-5-stefanha@redhat.com>
In-Reply-To: <20251126163600.583036-1-stefanha@redhat.com>
References: <20251126163600.583036-1-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add a Persistent Reservations ioctl to read the current reservation.
This calls the pr_ops->read_reservation() function that was previously
added in commit c787f1baa503 ("block: Add PR callouts for read keys and
reservation") but was only used by the in-kernel SCSI target so far.

The IOC_PR_READ_RESERVATION ioctl is necessary so that userspace
applications that rely on Persistent Reservations ioctls have a way of
inspecting the current state. Cluster managers and validation tests need
this functionality.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/uapi/linux/pr.h |  7 +++++++
 block/ioctl.c           | 28 ++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/uapi/linux/pr.h b/include/uapi/linux/pr.h
index fcb74eab92c80..847f3051057af 100644
--- a/include/uapi/linux/pr.h
+++ b/include/uapi/linux/pr.h
@@ -62,6 +62,12 @@ struct pr_read_keys {
 	__u64	keys_ptr;
 };
 
+struct pr_read_reservation {
+	__u64	key;
+	__u32	generation;
+	__u32	type;
+};
+
 #define PR_FL_IGNORE_KEY	(1 << 0)	/* ignore existing key */
 
 #define IOC_PR_REGISTER		_IOW('p', 200, struct pr_registration)
@@ -71,5 +77,6 @@ struct pr_read_keys {
 #define IOC_PR_PREEMPT_ABORT	_IOW('p', 204, struct pr_preempt)
 #define IOC_PR_CLEAR		_IOW('p', 205, struct pr_clear)
 #define IOC_PR_READ_KEYS	_IOWR('p', 206, struct pr_read_keys)
+#define IOC_PR_READ_RESERVATION	_IOR('p', 207, struct pr_read_reservation)
 
 #endif /* _UAPI_PR_H */
diff --git a/block/ioctl.c b/block/ioctl.c
index e87c424c15ae9..7e6d5e532d16b 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -472,6 +472,32 @@ static int blkdev_pr_read_keys(struct block_device *bdev, blk_mode_t mode,
 	return ret;
 }
 
+static int blkdev_pr_read_reservation(struct block_device *bdev,
+		blk_mode_t mode, struct pr_read_reservation __user *arg)
+{
+	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
+	struct pr_held_reservation rsv = {};
+	struct pr_read_reservation out = {};
+	int ret;
+
+	if (!blkdev_pr_allowed(bdev, mode))
+		return -EPERM;
+	if (!ops || !ops->pr_read_reservation)
+		return -EOPNOTSUPP;
+
+	ret = ops->pr_read_reservation(bdev, &rsv);
+	if (ret)
+		return ret;
+
+	out.key = rsv.key;
+	out.generation = rsv.generation;
+	out.type = rsv.type;
+
+	if (copy_to_user(arg, &out, sizeof(out)))
+		return -EFAULT;
+	return 0;
+}
+
 static int blkdev_flushbuf(struct block_device *bdev, unsigned cmd,
 		unsigned long arg)
 {
@@ -695,6 +721,8 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
 		return blkdev_pr_clear(bdev, mode, argp);
 	case IOC_PR_READ_KEYS:
 		return blkdev_pr_read_keys(bdev, mode, argp);
+	case IOC_PR_READ_RESERVATION:
+		return blkdev_pr_read_reservation(bdev, mode, argp);
 	default:
 		return blk_get_meta_cap(bdev, cmd, argp);
 	}
-- 
2.52.0

