Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ADA13D8B4
	for <linux-block@vger.kernel.org>; Thu, 28 Nov 2024 12:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732798246; cv=none; b=QiyS2QcLnM9PCH5dapeeZPwtj06mYKHIWUiBli6P4h90HBXsZBhACt80oUIW7wIoYTqhxqRnyRlkOEVxOFn0zDAnE2VlDL65yLpjohUBj57BQNgfZIlXrGfjnqNufDUtV8+j3FF8Sv7uNA1D4PgyZpS/CJe0ZC9ZR4BIsh7uLik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732798246; c=relaxed/simple;
	bh=4wWSCIa9AX8A5eYTcjAI6AyPQ8a6jikeS38M+TCLZBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gUSurttkAwQiobzJFUNwqfOkaG3Niz1KWCttqsWActze8x8n2SWxjiYCl8D9iPcXr/27L3749JfdF+KCeKV8SnzlGMuKm5yW6vwcmZOpOsO1RV4zqps66nTuCspRoiMRXeafG6rrsjTeNrvYpN8E803X8kJVzOdTRlL6ZLE4pLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RA8WRjfO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RA8WRjfO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732798243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qxm4ZlQiBph3a1/BqOjzFvLHtbU+5sxVqpKuHbsShnc=;
	b=RA8WRjfOuitV0/VZRlxRmvoKE3alNxis+o1kblU5nBwiTFYE+3RYMCZ2/USvQmzsMMkAuC
	ata8bXz+QZzO/mtaT33q3xBk/gxtM94l7WK3Nr2msBribz5FIEYrnjREOpXHsd/Sl4vdKa
	hVA7ZA4I74/vSaaHXqP2pGt8yxSOrQA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-77ug4DQIPnO4PKCh5vlaCw-1; Thu,
 28 Nov 2024 07:50:39 -0500
X-MC-Unique: 77ug4DQIPnO4PKCh5vlaCw-1
X-Mimecast-MFC-AGG-ID: 77ug4DQIPnO4PKCh5vlaCw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9CB14195608C;
	Thu, 28 Nov 2024 12:50:38 +0000 (UTC)
Received: from localhost (unknown [10.72.116.159])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 753CC1955D45;
	Thu, 28 Nov 2024 12:50:36 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] blktrace: fix one kind of lockdep warning
Date: Thu, 28 Nov 2024 20:50:25 +0800
Message-ID: <20241128125029.4152292-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hello,

This patchset kills one big kind of lockdep warning by cutting
dependency between q->debugfs_lock and mm->mmap_lock around copy_to_user()
and copy_from_user(().


Ming Lei (2):
  blktrace: don't centralize grabbing q->debugfs_mutex in
    blk_trace_ioctl
  blktrace: move copy_[to|from]_user() out of ->debugfs_lock

 kernel/trace/blktrace.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

-- 
2.47.0

