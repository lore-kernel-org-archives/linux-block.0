Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1987519D091
	for <linux-block@vger.kernel.org>; Thu, 31 Oct 2024 13:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730381858; cv=none; b=DyAPZT/mhhSG2dEG4MBgdbo4KxBpmaukV9OYKxLYxdJuhWeaT9cCPd3F3w3MYgAnXhUAu3fd7zAsBIohUsmmt3Rrlh87cJHONp/t+OH0B371UupuuFlIC5Wa/5nB7OXQBy7+C5GE7SpNmqZ9CnF/02ihaNFQiH7uKn4VtNY4fEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730381858; c=relaxed/simple;
	bh=+yrUysu17UuWft70wHGdFKIZ1qotPRLm4//pVD12NkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OyVTM7hv5uWlUOG6ZZTYBkS7/zr1utjKyLuuTMReMTqHN0SpWoA8JPhfrk2yRSWA6T0bzYRMZY2mFk7K7rk8DG3bfv2fSfW52DoPWliKCXSlmmb2/x/7N/GTRXMEnbwnyJapjF08tGBkh9XxdLTa2OU0wx6bHkDMxG1l5mh6pMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cii32UBV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cii32UBV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730381854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N1SDQ0O9Wbbs92TiFwOLvS7MO1pUHtfkixe3WZh8UaI=;
	b=Cii32UBVLZtfYsIe+lf6zX3+mCw806JA32PIbswFjhVYbu6ZUFlUF4GIXtME8oOCqDDYUb
	ijrM9c5l6vzDF1o9WgaB6qQ8Sf/EHd1YCinnt+hEFE5cgcbQYMz4xHR9p+yBVuTA/aMRi0
	705MRlCriaZJ8XNYaLcisjyWfRS2cMo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-P-z9JRvROwOhPOIKNeI3jw-1; Thu,
 31 Oct 2024 09:37:33 -0400
X-MC-Unique: P-z9JRvROwOhPOIKNeI3jw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C2451956089;
	Thu, 31 Oct 2024 13:37:32 +0000 (UTC)
Received: from localhost (unknown [10.72.116.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B37CF300018D;
	Thu, 31 Oct 2024 13:37:30 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/4] block: freeze/unfreeze lockdep fixes
Date: Thu, 31 Oct 2024 21:37:16 +0800
Message-ID: <20241031133723.303835-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hello,

The 1st patch removes blk_freeze_queue().

The 2nd patch fixes freeze uses in rbd.

The 3rd patches fixes potential unfreeze lock verification on non-owner
context.

The 4th patch doesn't verify io lock in elevator_init_mq() for fixing
false lockdep warning.

V2:
	- drop patch 1 and fix rbd by adding unfreeze (Christoph)
	- add reviewed-by


Ming Lei (4):
  block: remove blk_freeze_queue()
  rbd: unfreeze queue after marking disk as dead
  block: always verify unfreeze lock on the owner task
  block: don't verify IO lock for freeze/unfreeze in elevator_init_mq()

 block/blk-core.c       |  2 +-
 block/blk-mq.c         | 84 +++++++++++++++++++++++++++---------------
 block/blk.h            |  4 +-
 block/elevator.c       | 10 ++++-
 drivers/block/rbd.c    |  1 +
 include/linux/blkdev.h |  4 ++
 6 files changed, 71 insertions(+), 34 deletions(-)

-- 
2.47.0

