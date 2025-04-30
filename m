Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B23210FB
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 04:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745987810; cv=none; b=njMyRmNrHCwamA4xA1q8hAqjX0uBIuM/DVSQJUOR2wWzw2MQ5/7O0r4bvLSp0CoRWMPkjXWp6ndPLndfcsnM4YbszUg2C8UoKYFWr1fI4g6US9ayQTLo3pC5eSCuygG6ZO4ykQc0x3TxHY3GXdBaz6tb62Q516JCIrj3XeKQyXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745987810; c=relaxed/simple;
	bh=bSfiMhtpd5ddG+uTOi4aUVTsk9c32RkWN91HR16Z6PI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pXAfkQjIdLJ/ROcXyCVCYSMhl1HOwCNREY6WAg/5IeTkwCz5Nh5xpmFmiPDIfc/d6zxsArBiCe+04jwu20G3HIjpFMk5rN1Fiwr2WywtaSUF56997s4Qv6ldvyuw0l8I5FMzTyitzqZNFqO6E5lXbIWW1ZbTwCgASHP9MNTBMWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a/TISD20; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a/TISD20"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745987807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rMDoSAyTwzcYL9bf+goJ4obTuaPsOtOLkHKKRZLOKqM=;
	b=a/TISD20OFdlUIZUNH4RoB7yzHyUdaZmtqfK4OEJPAtvIvP1iaSajNsSsy0HoefyCeinKM
	M1QO2/BUaZY6xSfgeNR82IqdkxR0SrcJ2+hckkrcmsGjsCrlwFdmp6nycpQinaUs+O7Ocd
	vEWwJR+xorpZZ8nCYwwlat+ls0RiSBU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-B4oM-kpvOdiP_oLeZbpfwA-1; Wed,
 30 Apr 2025 00:36:42 -0400
X-MC-Unique: B4oM-kpvOdiP_oLeZbpfwA-1
X-Mimecast-MFC-AGG-ID: B4oM-kpvOdiP_oLeZbpfwA_1745987801
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E2D21956089;
	Wed, 30 Apr 2025 04:36:41 +0000 (UTC)
Received: from localhost (unknown [10.72.116.48])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2FD6E1956094;
	Wed, 30 Apr 2025 04:36:39 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 17/24] block: remove elevator queue's type check in elv_attr_show/store()
Date: Wed, 30 Apr 2025 12:35:19 +0800
Message-ID: <20250430043529.1950194-18-ming.lei@redhat.com>
In-Reply-To: <20250430043529.1950194-1-ming.lei@redhat.com>
References: <20250430043529.1950194-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

elevatore queue's type is assigned since its allocation, and never
get cleared until it is released.

So its ->type is always not NULL, remove the unnecessary check.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 2b16394972c0..86e448bc12ae 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -425,7 +425,7 @@ elv_attr_show(struct kobject *kobj, struct attribute *attr, char *page)
 
 	e = container_of(kobj, struct elevator_queue, kobj);
 	mutex_lock(&e->sysfs_lock);
-	error = e->type ? entry->show(e, page) : -ENOENT;
+	error = entry->show(e, page);
 	mutex_unlock(&e->sysfs_lock);
 	return error;
 }
@@ -443,7 +443,7 @@ elv_attr_store(struct kobject *kobj, struct attribute *attr,
 
 	e = container_of(kobj, struct elevator_queue, kobj);
 	mutex_lock(&e->sysfs_lock);
-	error = e->type ? entry->store(e, page, length) : -ENOENT;
+	error = entry->store(e, page, length);
 	mutex_unlock(&e->sysfs_lock);
 	return error;
 }
-- 
2.47.0

