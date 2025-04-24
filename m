Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CDB1C5D53
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 15:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508121; cv=none; b=Wb8KU2DbsNJaTq/EWb7PXFtoN9efhIMu2V8C+seyH5zBELfF9LYXw196BdxpRI9zi+omtLRlfouIARRoBIzGhbg0LN1RigyK7kVO8moh8RN8euXCLUw1ru1WicUqowk6HaCNx8bfbDvWWGnP8NBLVPDntQ3WP0xiqGe2aHAK06s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508121; c=relaxed/simple;
	bh=jugHZXNEuKh0sUezcBSfBPOXVOhibVR/Qw+ysF857kU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TgApymYxK2QoZr4hgB1EbNgjTY0nKPqf+LTiDa7pkqJM9VOJ3n2vXtsJSAKHkJR7TjklDYyHLjCoaXHMwR3+0i6nkaa/ZszA/S61c7IHYgyXycMj6nMUjuLppjYQg0AFzp5etE5kvBpO0SjlfIXw1paxTejCcQJO3knEoxYXdY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JrRrvbxK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JrRrvbxK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745508118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Nxnu/HNU6HcxQLsRC42AF3pI2dim7HIPa18Nj2L3Wc4=;
	b=JrRrvbxK/efn2HS2uTmuaMxOskv1C3rahf0PcdF7uqtDugqkSynk2fAo7k06+HZ/eXrdy9
	x+QmepO/WgoSDCv6h3FC59/Dk8HkjoLMO1mk6ac6Wo8i8oiMO1etFNHiYMO9C8boL0gURU
	Jp5DJTXvevY1jL16AFwcdNE0JB8Yhf8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-OxkEUodINieC_b9HC7Hrtw-1; Thu,
 24 Apr 2025 11:21:55 -0400
X-MC-Unique: OxkEUodINieC_b9HC7Hrtw-1
X-Mimecast-MFC-AGG-ID: OxkEUodINieC_b9HC7Hrtw_1745508114
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 14E4A1800446;
	Thu, 24 Apr 2025 15:21:54 +0000 (UTC)
Received: from localhost (unknown [10.72.116.90])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E1F3319560A3;
	Thu, 24 Apr 2025 15:21:52 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 00/20] block: unify elevator changing and fix lockdep warning
Date: Thu, 24 Apr 2025 23:21:23 +0800
Message-ID: <20250424152148.1066220-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hello Jens,

This patchset cleans up elevator change code, and unifying it via single
helper, meantime moves kobject_add/del & debugfs register/unregister out of
queue freezing & elevator_lock. This way fixes many lockdep warnings
reported recently, especially since fs_reclaim is connected with freeze lock
manually by commit ffa1e7ada456 ("block: Make request_queue lockdep splats
show up earlier").


Thanks,
Ming

V3:
	- replace srcu with rw_sem for avoiding race between add/del disk &
	  elevator switch and updating nr_hw_queues (Nilay Shoff)

	- add elv_update_nr_hw_queues() for elevator reattachment in case of
	updating nr_hw_queues, meantime keep elv_change_ctx as local structure
	(Christoph)

	- replace ->elevator_lock with disk->rqos_state_mutex for covering wbt
	state change

	- add new patch "block: use q->elevator with ->elevator_lock held in elv_iosched_show()"

	- small cleanup & commit log improvement

V2:
	- retry add/del disk when blk_mq_update_nr_hw_queues() is in-progress

	- swap blk_mq_add_queue_tag_set() with blk_mq_map_swqueue() in
	blk_mq_init_allocated_queue() (Nilay Shroff)

	- move ELEVATOR_FLAG_DISABLE_WBT to request queue's flags (Nilay Shoff) 

	- fix race because of delaying elevator unregister

	- define flags of `elv_change_ctx` as `bool` (Christoph)

	- improve comment and commit log (Christoph)

Ming Lei (20):
  block: move blk_mq_add_queue_tag_set() after blk_mq_map_swqueue()
  block: move ELEVATOR_FLAG_DISABLE_WBT a request queue flag
  block: don't call freeze queue in elevator_switch() and
    elevator_disable()
  block: use q->elevator with ->elevator_lock held in elv_iosched_show()
  block: add two helpers for registering/un-registering sched debugfs
  block: move sched debugfs register into elvevator_register_queue
  block: prevent adding/deleting disk during updating nr_hw_queues
  block: don't allow to switch elevator if updating nr_hw_queues is
    in-progress
  block: simplify elevator reattachment for updating nr_hw_queues
  block: move blk_unregister_queue() & device_del() after freeze wait
  block: move queue freezing & elevator_lock into elevator_change()
  block: add `struct elv_change_ctx` for unifying elevator change
  block: unifying elevator change
  block: pass elevator_queue to elv_register_queue & unregister_queue
  block: fail to show/store elevator sysfs attribute if elevator is
    dying
  block: move elv_register[unregister]_queue out of elevator_lock
  block: move debugfs/sysfs register out of freezing queue
  block: remove several ->elevator_lock
  block: move hctx cpuhp add/del out of queue freezing
  block: move wbt_enable_default() out of queue freezing from sched
    ->exit()

 block/bfq-iosched.c    |   6 +-
 block/blk-mq-debugfs.c |  12 +-
 block/blk-mq-sched.c   |  41 +++---
 block/blk-mq.c         | 132 +++---------------
 block/blk-sysfs.c      |  24 ++--
 block/blk-wbt.c        |  13 +-
 block/blk.h            |   8 +-
 block/elevator.c       | 302 ++++++++++++++++++++++++++++-------------
 block/elevator.h       |   6 +-
 block/genhd.c          | 129 +++++++++++-------
 include/linux/blk-mq.h |   3 +
 include/linux/blkdev.h |   5 +
 12 files changed, 365 insertions(+), 316 deletions(-)

-- 
2.47.0

