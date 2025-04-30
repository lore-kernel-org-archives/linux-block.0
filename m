Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47651D89E3
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 04:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745987745; cv=none; b=As2qrLlDEi6OFhxea3FQ4SxdOe8qphpm2adD/QPNH3+Q6W+e3Ba0/NlE3G+oZAsgbE/mRC9mn0K4NtCdIqEoxR8/xf1BMbaErOXMu530rvTn89kYLMpmFjzNVh4rVmRi2Pqu00URKpAipbvVFGt4DWeAq593Zkqb+uJ7m3VT4GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745987745; c=relaxed/simple;
	bh=tXTpHbi+G0v8E44baR+TjKh0n95yvYKAJUm9QQ6DUT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HH/1tQi9yZ0Aw+cPej7XoD6m/aGtWzSr+9vz4NSsa095EnD1Z03YQULIPnATPQoEsjns8TCTdZsw312vh2LCgGik8tc08niR9p/4ivKpbnMvVS7yLx4OUu3a7zJYVqXxkiyxkjL9nVJiyJiU7CZPZTtRFU4/c3dOyE9vDuNfH/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jSjQUyo5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jSjQUyo5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745987742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8vK0zAhznsSY6Y5mNieskX5NA0u0v/wHhffceaI8E/4=;
	b=jSjQUyo5JY7ud8ZwFtSV0/SiUsdZ9/8VdYZfaE9TlA7x73JmfnKy8VVnJJ4oXnjFO1AJXp
	ShyOi0LyVtNtyzypyjf6WbjAqmWyOoal4+CaqD2pGACvCm7dD36dtWJJ9GPao+SrvX+nM1
	gR1CJ74eUa2QcnQGmGLaVZpZWCt527c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-0WQrv4ulNAuPOy147eVcBA-1; Wed,
 30 Apr 2025 00:35:38 -0400
X-MC-Unique: 0WQrv4ulNAuPOy147eVcBA-1
X-Mimecast-MFC-AGG-ID: 0WQrv4ulNAuPOy147eVcBA_1745987737
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE940195608C;
	Wed, 30 Apr 2025 04:35:36 +0000 (UTC)
Received: from localhost (unknown [10.72.116.48])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 870601956094;
	Wed, 30 Apr 2025 04:35:35 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 00/24] block: unify elevator changing and fix lockdep warning
Date: Wed, 30 Apr 2025 12:35:02 +0800
Message-ID: <20250430043529.1950194-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hello Jens,

This patchset cleans up elevator change code, and unifying it via single
helper, meantime moves kobject_add/del & debugfs register/unregister out of
queue freezing & elevator_lock. This way fixes many lockdep warnings
reported recently, especially since fs_reclaim is connected with freeze lock
manually by commit ffa1e7ada456 ("block: Make request_queue lockdep splats
show up earlier").


Thanks,
Ming

V4:
	- pull Christoph's two elevator change/switch cleanup patches first,
	then the following elevator change unifying is simplified a lot(Christoph)

	- fold Nilay's patch into the last patch for avoiding one new
	lock warning on rqos_state_mutex (Nilay Shoff)

	- drop patch "block: move blk_unregister_queue() & device_del() after freeze
	wait" which may cause MD hang during shutdown, and add new patch "block: add
    new helper for disabling elevator switch when deleting disk" for dealing with
    one small race window (Christoph)

	- add patch "block: remove elevator queue's type check in elv_attr_show/store()"
	(Christoph)

    - rename ->update_nr_hwq_sema as ->update_nr_hwq_lock (Christoph)

	- add small patch "block: move blk_queue_registered() check into elv_iosched_store()"

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

Christoph Hellwig (2):
  block: look up the elevator type in elevator_switch
  block: fold elevator_disable into elevator_switch

Ming Lei (22):
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
  block: move blk_queue_registered() check into elv_iosched_store()
  block: simplify elevator reattachment for updating nr_hw_queues
  block: move queue freezing & elevator_lock into elevator_change()
  block: add `struct elv_change_ctx` for unifying elevator change
  block: unifying elevator change
  block: pass elevator_queue to elv_register_queue & unregister_queue
  block: remove elevator queue's type check in elv_attr_show/store()
  block: fail to show/store elevator sysfs attribute if elevator is
    dying
  block: add new helper for disabling elevator switch when deleting disk
  block: move elv_register[unregister]_queue out of elevator_lock
  block: move hctx debugfs/sysfs registering out of freezing queue
  block: don't acquire ->elevator_lock in blk_mq_map_swqueue and
    blk_mq_realloc_hw_ctxs
  block: move hctx cpuhp add/del out of queue freezing
  block: move wbt_enable_default() out of queue freezing from sched
    ->exit()

 block/bfq-iosched.c    |   6 +-
 block/blk-mq-debugfs.c |  13 +-
 block/blk-mq-sched.c   |  41 ++++--
 block/blk-mq.c         | 132 +++--------------
 block/blk-sysfs.c      |  29 ++--
 block/blk-wbt.c        |   9 +-
 block/blk.h            |   8 +-
 block/elevator.c       | 322 ++++++++++++++++++++++++-----------------
 block/elevator.h       |   6 +-
 block/genhd.c          | 151 ++++++++++++-------
 include/linux/blk-mq.h |   3 +
 include/linux/blkdev.h |   8 +
 12 files changed, 369 insertions(+), 359 deletions(-)

-- 
2.47.0

