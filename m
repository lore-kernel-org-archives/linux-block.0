Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C54E7462
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 16:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994249; cv=none; b=lRY/WrYsdO7BZ0Pt7YLx+0oPUtQeLi6o8RRdFWNSkKgCwykUpx7TCPe6Pw9VjXXeG/TuxZmkr1cLCEJy0nHtF9ID5EQC0gqPTUAWniALlUJIc0Z1eyTko3rQLar3aOAJSdnUcg00831wVeLUysStF7ayxOB7+J+hjG/ZSo8y3zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994249; c=relaxed/simple;
	bh=DhaxAfrdHGY5YDfHrXoEnLtGRmBHp7Q88Rp7T9fdblo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cGIKdk7c7RKiYnsZ0abiCygC0oZhnShLY6l/OKOLe5T+P+GD1t97I4Gj7nwkdc+GKV8mxyT0c0qKvfX7rbB1SII5JVlbeiZyQ/uSJ+4uHeOzL9c+Ar59TbyOrlPpuhFo4EdfeYkevpv7RSTgZNL7l2nFlbD7+j1cTFgiI2jxY2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TRq3Ubeq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TRq3Ubeq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744994247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/x/5B+1AeBPBo8nZIo0xWonar/Sl1BdzST3rgcQuSKs=;
	b=TRq3UbeqFnHs4+4qk2XdUv15KAE8Ud2yLKD/lryrPrl+AnYnJiGaT0UDu2Q1aUnKXl/JX+
	YVSSoPMq2b39hXqxdFqpgYtXm2RoPfo9FD8Rc2qeLUhm1Khg4pthxP2y/Z+zgwajY+09j3
	EUUSbRXw9RgtCX7kxTjKRQSu0kBSsNk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-tgmirXT1PS2mkFiKlbk1tg-1; Fri,
 18 Apr 2025 12:37:23 -0400
X-MC-Unique: tgmirXT1PS2mkFiKlbk1tg-1
X-Mimecast-MFC-AGG-ID: tgmirXT1PS2mkFiKlbk1tg_1744994242
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D759119560A7;
	Fri, 18 Apr 2025 16:37:21 +0000 (UTC)
Received: from localhost (unknown [10.72.116.50])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6BF0A180177D;
	Fri, 18 Apr 2025 16:37:19 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 00/20] block: unify elevator changing and fix lockdep warning
Date: Sat, 19 Apr 2025 00:36:41 +0800
Message-ID: <20250418163708.442085-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hello Jens,

This patchset cleans up elevator change code, and unifying it via single
helper, meantime moves kobject_add/del & debugfs register/unregister out of
queue freezing & elevator_lock. This way fixes many lockdep warnings
reported recently, especially since fs_reclaim is connected with freeze lock
manually by commit ffa1e7ada456 ("block: Make request_queue lockdep splats
show up earlier").


Thanks,

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
  block: move ELEVATOR_FLAG_DISABLE_WBT as request queue flag
  block: don't call freeze queue in elevator_switch() and
    elevator_disable()
  block: add two helpers for registering/un-registering sched debugfs
  block: move sched debugfs register into elvevator_register_queue
  block: add & pass 'struct gendisk_data' for retrying add/del disk in
    updating nr_hw_queues
  block: prevent adding/deleting disk during updating nr_hw_queues
  block: don't allow to switch elevator if updating nr_hw_queues is
    in-progress
  block: simplify elevator rebuild for updating nr_hw_queues
  block: add helper of elevator_change()
  block: move blk_unregister_queue() & device_del() after freeze wait
  block: add `struct elv_change_ctx` for unifying elevator_change
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
 block/blk-mq-debugfs.c |  12 +--
 block/blk-mq-sched.c   |  41 +++++---
 block/blk-mq.c         | 172 ++++++++++--------------------
 block/blk-sysfs.c      |  18 ++--
 block/blk-wbt.c        |   3 +-
 block/blk.h            |  10 +-
 block/elevator.c       | 231 +++++++++++++++++++++++++++--------------
 block/elevator.h       |  19 +++-
 block/genhd.c          | 158 +++++++++++++++++-----------
 include/linux/blk-mq.h |   5 +
 include/linux/blkdev.h |   3 +
 12 files changed, 374 insertions(+), 304 deletions(-)

-- 
2.47.0

