Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C8C25B69D
	for <linux-block@vger.kernel.org>; Mon,  5 May 2025 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454777; cv=none; b=Mxdyg8OkwUFJQ06OpDVaqDAxIi7UFjLB40q81xkqY4YZU7i8v2XCqnb+2YGsKiQS5WFOrRp/yWzzmMx4+1P7gSoxXxgVLp+oXhf+jQ9xpE+bIfS2b+LAhdvsbDGXLL7EQ/epj1PIMAEuPVWjVxbwZgb6njPgZDmqXOeuO5BCt04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454777; c=relaxed/simple;
	bh=qvpyfY9N2mQyCQ4/EAs3fXFy0n3s1W6G7rr0VjTsfGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAGEdseueKqWOvfdFsg/IwIoL676BQZb9hejRusQ0vR+V3BFokCOOlMR5sFdaH2jMh2rEj975/c6lmgxUiLswtrHjBZpcuFBpioE/hTvSOHQlhOsUSmrjsWHk3MtI0B6Lm1UU7vuYoe/Ex6A1TlnQ89plL05088fTJI0UWBG0B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MOkgEJz1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MOkgEJz1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746454775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hWtrxTqRlgy/L+cSC7FeoKi93ReJRcoBdlt8DUKBTM8=;
	b=MOkgEJz1nt3r1wjGWzBfD4y4QAaORJ7+afW9HL03zk7Xso5N8qH7GQh1AAIvli+ez6TmKy
	njZvpGyGBvGyzeULROkDuqLNhKJDx7c1HeZKMBQi5ydMuoZ+sllYhF5agFFLFeP6HK4brN
	ryMfgPal29dkUQPpWR83fcNltZknDjw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-xDvc1UwuPFmHIPyYXIFVww-1; Mon,
 05 May 2025 10:19:33 -0400
X-MC-Unique: xDvc1UwuPFmHIPyYXIFVww-1
X-Mimecast-MFC-AGG-ID: xDvc1UwuPFmHIPyYXIFVww_1746454772
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 82E751800983;
	Mon,  5 May 2025 14:19:32 +0000 (UTC)
Received: from localhost (unknown [10.72.116.4])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 65878180045B;
	Mon,  5 May 2025 14:19:30 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH V5 18/25] block: remove elevator queue's type check in elv_attr_show/store()
Date: Mon,  5 May 2025 22:17:56 +0800
Message-ID: <20250505141805.2751237-19-ming.lei@redhat.com>
In-Reply-To: <20250505141805.2751237-1-ming.lei@redhat.com>
References: <20250505141805.2751237-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

elevatore queue's type is assigned since its allocation, and never
get cleared until it is released.

So its ->type is always not NULL, remove the unnecessary check.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index eb7140a678d5..fa436417da3b 100644
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

