Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187751E411D
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 12:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730292177; cv=none; b=Lb8fATp7RqUGTg2A4YXTSt5TnL6xrNtbAD24CqRFx8nY7Ydc5R1g3sj2XtjP/FdlI0pDbFUcRqoM54Q2uyOETAj3ueWEz7gnhUJ9su15stQRpUYljwM5Jmre5695baZfiY95QhFDfowYrR57P4f+pyBFxjxWie/7rzTHGdOwgUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730292177; c=relaxed/simple;
	bh=3WMPaV7NCKpHDE+kefFd7J08T0br42POPXQ82lGjIvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WDqozTVMQbnitcYHx70dq9w9qGbNHEdxxbJD7y/qXxYkPt2qjkqZY1c6fM66yRKqu8iSJJjc67ek0j4OjAm53iamgWJVuv925huWv1If3BaGzpdk4z7VA0LwYGOmqW84Y7puO3LCfc1excrfgmpTNyvxUQty1dFm67Xv/LtxHlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b1yG1e7a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b1yG1e7a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730292173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UvCVLc3+75sQG6I6Hx8fMRCBL1b/E/l2u1ROhjbBVAw=;
	b=b1yG1e7aSn0qxxNPlM18PhJphu+LgrI+YmvHx5uR9eGUf9B+DUHTWdlylRNyhllOHORaWt
	MiejVorWaxK6NaT65TSrQ33vY/U/Efb7YH0HuhMr8qCk4CQp5H4NAQuWQd8Hjj3jO85Aea
	PeSqnF7QTMOZb7eEN4xkGAepgEkAi/o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-88O6jLdzMj6UrR_TcYV6DA-1; Wed,
 30 Oct 2024 08:42:50 -0400
X-MC-Unique: 88O6jLdzMj6UrR_TcYV6DA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 780611955F3F;
	Wed, 30 Oct 2024 12:42:49 +0000 (UTC)
Received: from localhost (unknown [10.72.116.140])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 20983300018D;
	Wed, 30 Oct 2024 12:42:47 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/5] block: freeze/unfreeze lockdep fixes
Date: Wed, 30 Oct 2024 20:42:32 +0800
Message-ID: <20241030124240.230610-1-ming.lei@redhat.com>
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

The 2nd & 3rd patches add blk_mq_freeze_queue_non_owner() and apply
it on rbd.

The 4th patches fixes potential unfreeze lock verification on non-owner
context.

The 5th patch doesn't verify io lock in elevator_init_mq() for fixing
false lockdep warning.

Ming Lei (5):
  block: remove blk_freeze_queue()
  blk-mq: add non_owner variant of blk_mq_freeze_queue API
  rbd: convert to blk_mq_freeze_queue_non_owner
  block: always verify unfreeze lock on the owner task
  block: don't verify IO lock for freeze/unfreeze in elevator_init_mq()

 block/blk-core.c       |  2 +-
 block/blk-mq.c         | 98 ++++++++++++++++++++++++++++--------------
 block/blk.h            |  4 +-
 block/elevator.c       |  8 +++-
 drivers/block/rbd.c    |  2 +-
 include/linux/blk-mq.h |  1 +
 include/linux/blkdev.h |  4 ++
 7 files changed, 81 insertions(+), 38 deletions(-)

-- 
2.47.0

