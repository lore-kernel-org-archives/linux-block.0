Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BB013D521
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744291858; cv=none; b=NMFh85XY6PpkNt/gVyi4o0hH7Z9FjJaJzJJ7Cekz3MYnW3SFhoEA7TrfZO3fzhfYnGh7fqSmGVVv8HLky9UGMpgapG9C4KTMN098iewMHwUO9czhrGNHHLE39IAs6nf/+byhqzkgw0JyUi7FLfcXSayHHkpuCUNo81WsZ9WA3qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744291858; c=relaxed/simple;
	bh=fcdL2XqMRamEKQ8LYfaosRRLxWJ2qU2Twu9uiW4BE10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BugKwtQbiE5WG21WR9xPus8RQD3XItj4PDgeXt3ZS3P7OIllM1G2CHjkFF94dB8Nv8hzlQlHpoBOUDoGhkSvY5/FkDw9VKwNVnfHXG63mkVztmruoeSKPBl7BqV4i9iSlw6pV9yQP/hXtXKHczFtVkG2bsL0bXCBUGjgTcd5azs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ezitjlzh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ezitjlzh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744291854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+J5rQ28AiVMJsmDrWxftqGn4qfpMVyspT3BT9fJ1CkU=;
	b=EzitjlzhI05WXhUihMCr5Gzy6lZJ9LUa4YmwX6EaBVlT9FJUqmXugSy9X8j00AH2uddLlZ
	x1id7hiZ00OuNs9o3a6abAcQz9n7EXJQ8PdCmdHWXwo0WmPx3Mm6hhZuAeeg3VfFoLK31v
	Q+3LSaRp9ySBFI3RptlUpwL7NDfjEM8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-eEbqzVT9NJmfYNSoK-kN7g-1; Thu,
 10 Apr 2025 09:30:51 -0400
X-MC-Unique: eEbqzVT9NJmfYNSoK-kN7g-1
X-Mimecast-MFC-AGG-ID: eEbqzVT9NJmfYNSoK-kN7g_1744291850
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC01E180025F;
	Thu, 10 Apr 2025 13:30:49 +0000 (UTC)
Received: from localhost (unknown [10.72.120.20])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 479DF19560AD;
	Thu, 10 Apr 2025 13:30:47 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 00/15] block: unify elevator changing and fix lockdep warning
Date: Thu, 10 Apr 2025 21:30:12 +0800
Message-ID: <20250410133029.2487054-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hello Jens,

The 1st 11 patch cleans up elevator change code, and unifying it via single
helper, meantime moves kobject_add/del & debugfs register/unregister out of
queue freezing & elevator_lock. This way fixes many lockdep warnings
reported recently, especially since fs_reclaim is connected with freeze lock
manually by commit ffa1e7ada456 ("block: Make request_queue lockdep splats
show up earlier").

The other 4 ones fixes lockdep warnings from bfq and updating nr_hw_queues
code.

Also the 4th patch fixes kasan warning & oops report from Shinichiro by
preventing elevator switching when updating nr_hw_queues is in-progress.

Thanks,

Ming Lei (15):
  block: don't call freeze queue in elevator_switch() and
    elevator_disable()
  block: add two helpers for registering/un-registering sched debugfs
  block: move sched debugfs register into elvevator_register_queue
  block: prevent elevator switch during updating nr_hw_queues
  block: simplify elevator reset for updating nr_hw_queues
  block: add helper of elevator_change()
  block: move blk_unregister_queue() & device_del() after freeze wait
  block: add `struct elev_change_ctx` for unifying elevator change
  block: unifying elevator change
  block: pass elevator_queue to elv_register_queue & unregister_queue
  block: move elv_register[unregister]_queue out of elevator_lock
  block: move debugfs/sysfs register out of freezing queue
  block: remove several ->elevator_lock
  block: move hctx cpuhp add/del out of queue freezing
  block: move wbt_enable_default() out of queue freezing from
    scheduler's ->exit()

 block/bfq-iosched.c    |   2 +-
 block/blk-mq-debugfs.c |  13 +--
 block/blk-mq-sched.c   |  39 +++++---
 block/blk-mq.c         | 163 +++++++++---------------------
 block/blk-sysfs.c      |  18 ++--
 block/blk.h            |  10 +-
 block/elevator.c       | 221 ++++++++++++++++++++++++++---------------
 block/elevator.h       |  16 +++
 block/genhd.c          |  25 +----
 include/linux/blk-mq.h |  10 +-
 10 files changed, 256 insertions(+), 261 deletions(-)

-- 
2.47.0

