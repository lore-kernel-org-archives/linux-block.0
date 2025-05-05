Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F85818DB26
	for <linux-block@vger.kernel.org>; Mon,  5 May 2025 14:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454701; cv=none; b=BGmTg4YKJq6GIlyDLBjaUWlPfvFwaiFJFnPXe270V0UcZihvs8xiQm1odYop2hXqzo1H/NkmiFlDijlv6devw9kesyL5YexUvTLkKMayBrviw/FAPgvrVYUl1LaFTvo4OQg/lSNGUxJ5LAG3lxRf+QgXCftH+FWuY+Z04A4coPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454701; c=relaxed/simple;
	bh=btfrHnJMDRjeXfR3GIBEVLBqlgnnmysnNCxwRLptffI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HPTO11ECe1I3gkjOQzxQ033JzbgP0ErweLbMpVCHGEtHS1a9FlPZ6bdvOdib1b78V/jEEUWeS62CNBiTmfHTKvnylXzcgZXcHZRVeIhANDqwf1hboCniD66dOJlnTIXEpbq8zFthAzHVh1RCQbS5rk2F+8X/0g5STDCwLZ7nqQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y1dgFrHV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1dgFrHV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746454698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nWYvBTVFnWQ+b2uUqHKlAT2vIYEponOSpHX1D07GOXc=;
	b=Y1dgFrHVGxCMYXoHhbED0/0AY8niCEGQuwcuZs2VqaBNzyYjYPeuWdgy40KImWSADbLyn9
	lvil5g+7omvcOH/Y9NMaa/Doy9n+cn4PNGZzJYosSW7NtqZu19FYF1LiuA7Xxq+ImPK4bD
	V8Sag7vYwc7VcYaXwIhamKVbVdR3EmY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-fWO0Ua4MPmiUkP5Fcdu6PQ-1; Mon,
 05 May 2025 10:18:15 -0400
X-MC-Unique: fWO0Ua4MPmiUkP5Fcdu6PQ-1
X-Mimecast-MFC-AGG-ID: fWO0Ua4MPmiUkP5Fcdu6PQ_1746454693
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5423E19560B4;
	Mon,  5 May 2025 14:18:13 +0000 (UTC)
Received: from localhost (unknown [10.72.116.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 17EBA30001A2;
	Mon,  5 May 2025 14:18:11 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 00/25] block: unify elevator changing and fix lockdep warning
Date: Mon,  5 May 2025 22:17:38 +0800
Message-ID: <20250505141805.2751237-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hello Jens,

This patchset cleans up elevator change code, and unifying it via single
helper, meantime moves kobject_add/del & debugfs register/unregister out of
queue freezing & elevator_lock. This way fixes many lockdep warnings
reported recently, especially since fs_reclaim is connected with freeze lock
manually by commit ffa1e7ada456 ("block: Make request_queue lockdep splats
show up earlier").


Thanks,
Ming

V5:
	- replace down_read_nested() with down_read(), by adding
	  helper of add_disk_final()

	- fix race between elv_iosched_store and __del_gendisk (Nilay Shoff)

	- improve elv_update_nr_hw_queues() (Christoph)

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

Ming Lei (23):
  block: move blk_mq_add_queue_tag_set() after blk_mq_map_swqueue()
  block: move ELEVATOR_FLAG_DISABLE_WBT a request queue flag
  block: don't call freeze queue in elevator_switch() and
    elevator_disable()
  block: use q->elevator with ->elevator_lock held in elv_iosched_show()
  block: add two helpers for registering/un-registering sched debugfs
  block: move sched debugfs register into elvevator_register_queue
  block: add helper add_disk_final()
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
 block/blk-mq-sched.c   |  41 +++--
 block/blk-mq.c         | 132 +++--------------
 block/blk-sysfs.c      |  29 ++--
 block/blk-wbt.c        |   9 +-
 block/blk.h            |   8 +-
 block/elevator.c       | 329 ++++++++++++++++++++++++-----------------
 block/elevator.h       |   6 +-
 block/genhd.c          | 197 +++++++++++++++---------
 include/linux/blk-mq.h |   3 +
 include/linux/blkdev.h |   8 +
 12 files changed, 402 insertions(+), 379 deletions(-)

-- 
2.47.0

