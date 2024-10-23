Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEA919E961
	for <linux-block@vger.kernel.org>; Wed, 23 Oct 2024 09:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729677304; cv=none; b=PeGkvjwu+tOunjDKkc9Sh7WQ0fKp9139ASLPhQ3kv9rj7WzeWWKZRW5eAAEAMKMFiw5oPERMh0Wa71Ea4cn7kpVl75cIRueucRCYmaj6+2XCHkqn1a8lX9fXNqwSO5YlSThuSJKUsilRIFrvvkp+HqvmdZMHt4OLt33BqtpmRts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729677304; c=relaxed/simple;
	bh=ilyyfFvTwu8vOIQRUOMZatULsC3+sIzA+zAFb1KPYaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hXw++X9iNv/IaPyqkyPqhd1Nm6KSMO8X1NgN3MlnWkhDQseiPYF44QqQUaVDub5dbpdcZTdeCF0WanBV8iMrfkVETFWyhz21g9ohu5GhICkxA5UY+GpyhFRbL3gHWLCdf81ildKI7AUAtMPzE+0nt8LuneFzlNgZxXpB0Lqk3mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ModVRk1z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ModVRk1z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729677301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6vwE1/iGfj50Q+b/VNNSTomLnHqoxJY9qASWv2lAwZc=;
	b=ModVRk1z0BNss2cNA+kfgnJK+lQB/RlW6kcuMpohMiuy5Sa38hwCVrU7X/GUShrUuSCW10
	BLcQuEAgaJ30CAxPPzLZDAhqTLzjeNNdYnokm8Cfv/UvItdrYF/WLmCYLBgXGF7OPtZ1gr
	sBy1EfZcXFodKue/jJIcUGmS82hwYKg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-_HRqKl-rM1mNYw0EKn7-6w-1; Wed,
 23 Oct 2024 05:54:56 -0400
X-MC-Unique: _HRqKl-rM1mNYw0EKn7-6w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A4B519560BD;
	Wed, 23 Oct 2024 09:54:54 +0000 (UTC)
Received: from localhost (unknown [10.72.116.171])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B8A011956056;
	Wed, 23 Oct 2024 09:54:52 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/3] block: model freeze/enter queue as lock for lockdep
Date: Wed, 23 Oct 2024 17:54:32 +0800
Message-ID: <20241023095438.3451156-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hello,

The 1st patch adds non_owner variants of start_freeze/unfreeze queue
API.

The 2nd patch applies the non_owner variants on nvme_freeze() & nvme_unfreeze(). 

The 3rd patch models freeze/enter queue as lock for lockdep support.


Ming Lei (3):
  blk-mq: add non_owner variant of start_freeze/unfreeze queue APIs
  nvme: core: switch to non_owner variant of start_freeze/unfreeze queue
  block: model freeze & enter queue as lock for supporting lockdep

 block/blk-core.c         | 18 +++++++++++++++--
 block/blk-mq.c           | 43 +++++++++++++++++++++++++++++++++++++---
 block/blk.h              | 29 ++++++++++++++++++++++++---
 block/genhd.c            | 15 ++++++++++----
 drivers/nvme/host/core.c |  4 ++--
 include/linux/blk-mq.h   |  2 ++
 include/linux/blkdev.h   |  6 ++++++
 7 files changed, 103 insertions(+), 14 deletions(-)

-- 
2.46.0

