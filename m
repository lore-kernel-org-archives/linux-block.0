Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5AB2DF134
	for <linux-block@vger.kernel.org>; Fri,  5 Dec 2025 21:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764969485; cv=none; b=kU4ygRywAzrRZHxeHx17sBQXWM1JE6fNVRTB20fLQ3UyOLmBaWH1Fan4EhzMnkxxFHq+epEQGVnNMCGu8tZeAELEBokBMY7/zZJVA6ftO1e4JQUCx9fVPeI0/pJIpR/pPQkF6ow79vche+sKcoJsjbdrjHHY04WgNdZlT1uRW6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764969485; c=relaxed/simple;
	bh=Zn9jmGfeAKgfqF5dCQsRUD7bfDCKPl5vxAtyYEQSFkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ttkoGKlZ2ts2OlcTYBkDqqPi+MDzrd8pfv1xQkwA8crxdwf4LAz6+4iJHVs7dofdMhbM9eHDnUo1qp60WsM+No+O1j8mVwbmDIUiPCvcLdUkzoh43o/2cZhlpZIyOK95fas925r8S20+Ank0DyUdZCUWPHNYWXjyw/CYEtfqHXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=CMH3mH6E; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="CMH3mH6E"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2a484a0b7cfso4296155eec.1
        for <linux-block@vger.kernel.org>; Fri, 05 Dec 2025 13:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764969483; x=1765574283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxVHZtEpvAb0wwOXSSvRmivBfSUpUQhbLwoJPmBuAUM=;
        b=CMH3mH6EiKAKqMrcZ84vQiPX392pWFusHttUapXnlntAROs7vL6uwu+y2i1ylxzC3W
         Z59nVKgLFV7ouHqibC8A7yW022LJk4x7g55B7QSgZl/ZIx6jtex5O7iFgFA7PIHP0kG8
         9GakUYZhapQzn0K6QVBcELxKQ8xFvVanmBpE4bkzSnbwYcmV6H7At4w4/qqdkmn0g15c
         pwqffoFF0CigG9eMgdpV5aSiWwEenswh9aScuSHLarJPKxmQbiWUziPhVZ1/eyUhdlCn
         V6UqiGvF1QssLMV2uEM3IqIkQwUJZvDnbXYmD6PM1/n7BDPlE2PKD/LwBJVD9G9Sm9jG
         WyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764969483; x=1765574283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IxVHZtEpvAb0wwOXSSvRmivBfSUpUQhbLwoJPmBuAUM=;
        b=KbgTsTjjGTqjK8djeCMdearehX9nmNopjsLBvniJltLk5CphSIKJn/p/uPicKdDXaH
         OZ1/4UThHPT/v8iu4V4bcPS/yuIKOYL1L1xOrJJ0pZjIrMVMI8131ZhsvWeMR3UxvvwB
         vRZli78ZLFBvbeCU0Hakj23nRFYo5GdupsTmaJYc6CT2cLhGzBf134e5+YoCuo9N54my
         sHQVaGbBdiBmACRFgBM0PRxtSpTSwDbnJ5hJDjIwBJY8bdX7mSdQ0fzVw84Eaa772z56
         TWbcUEb7VJ8L6oorbXwAyt2l7KKsoOiFoAl7SBwEK994yabNLP6i7OU2RYtAfVUnizRi
         PtIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSgdorsvNQoIWqaRuc0OzQicE02KowKBWoWu/vNA2MJSQWcapwG7TCerT+1mkMKo7pIJLVsQcFwf3+Gg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yybb19Xx2bEbck0pprQERf+SpkJ+0vUdVMEBo/qazSFlZC4SgC8
	Ep+4O4uU6pf9S+PF5UuajQ+OiMTMgvAUjdZHZssrz6gIcnTSJkeLfB2WWAre+updQN4=
X-Gm-Gg: ASbGnct9xfR/GsEpnZpTTG1IkPliuj1/C9jnYVE4C/H/l9QaK26rouFnyD28O1glGml
	AtYJMEfp4W6F8QdzMUCHjghWbpduzGBzevucYbJjDi/lKBtvSSxh7gPVG0H05fwPV+brgfYjhVm
	p0wGBTvArhc6ZvS0nUIlRL3UcY20s3Z/7eAeXkdz+HeU5w3ZBcMXkViSzBICAqctPHwg3brD/vS
	e9O1YTHGbeY+uwini2jI54ijstXEExawfO/01sKwV+MlprMQ4peza5SXwiI9EUHBkMmkFJxNWim
	sLCBG10ZFzOPr+c9wMdZIVf4JgpTQZPHKg2amNcGRK7NsSmmk17GnfSYvZ6LW6rmna56smWDEP/
	Bf/KxaUiiUKoA/rlL9BL9/wtzr9DwFUwRzoZf52/0ZbZqiQP9zyxMU1n2ITQcDWbvyTeKvPqCPg
	BHX8vhUsF6ssorCZJyTPQ31So5hNyW6+P3ig==
X-Google-Smtp-Source: AGHT+IE9alKhA0GP6tatt4dkrUemaxM+deut5b3WMkwd/ve3r17ojkqfkIKKJ7dvVUDgZlXRSMLV6A==
X-Received: by 2002:a05:7300:5711:b0:2a4:626d:5c38 with SMTP id 5a478bee46e88-2aba34e59e6mr5875926eec.17.1764969482731;
        Fri, 05 Dec 2025 13:18:02 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-2aba8395d99sm25546318eec.1.2025.12.05.13.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 13:18:02 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Casey Chen <cachen@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Hannes Reinecke <hare@suse.de>,
	Ming Lei <ming.lei@redhat.com>,
	Waiman Long <llong@redhat.com>,
	Hillf Danton <hdanton@sina.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v4 1/1] block: Use RCU in blk_mq_[un]quiesce_tagset() instead of set->tag_list_lock
Date: Fri,  5 Dec 2025 13:17:02 -0800
Message-ID: <20251205211738.1872244-2-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251205211738.1872244-1-mkhalfella@purestorage.com>
References: <20251205211738.1872244-1-mkhalfella@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blk_mq_{add,del}_queue_tag_set() functions add and remove queues from
tagset, the functions make sure that tagset and queues are marked as
shared when two or more queues are attached to the same tagset.
Initially a tagset starts as unshared and when the number of added
queues reaches two, blk_mq_add_queue_tag_set() marks it as shared along
with all the queues attached to it. When the number of attached queues
drops to 1 blk_mq_del_queue_tag_set() need to mark both the tagset and
the remaining queues as unshared.

Both functions need to freeze current queues in tagset before setting on
unsetting BLK_MQ_F_TAG_QUEUE_SHARED flag. While doing so, both functions
hold set->tag_list_lock mutex, which makes sense as we do not want
queues to be added or deleted in the process. This used to work fine
until commit 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
made the nvme driver quiesce tagset instead of quiscing individual
queues. blk_mq_quiesce_tagset() does the job and quiesce the queues in
set->tag_list while holding set->tag_list_lock also.

This results in deadlock between two threads with these stacktraces:

  __schedule+0x47c/0xbb0
  ? timerqueue_add+0x66/0xb0
  schedule+0x1c/0xa0
  schedule_preempt_disabled+0xa/0x10
  __mutex_lock.constprop.0+0x271/0x600
  blk_mq_quiesce_tagset+0x25/0xc0
  nvme_dev_disable+0x9c/0x250
  nvme_timeout+0x1fc/0x520
  blk_mq_handle_expired+0x5c/0x90
  bt_iter+0x7e/0x90
  blk_mq_queue_tag_busy_iter+0x27e/0x550
  ? __blk_mq_complete_request_remote+0x10/0x10
  ? __blk_mq_complete_request_remote+0x10/0x10
  ? __call_rcu_common.constprop.0+0x1c0/0x210
  blk_mq_timeout_work+0x12d/0x170
  process_one_work+0x12e/0x2d0
  worker_thread+0x288/0x3a0
  ? rescuer_thread+0x480/0x480
  kthread+0xb8/0xe0
  ? kthread_park+0x80/0x80
  ret_from_fork+0x2d/0x50
  ? kthread_park+0x80/0x80
  ret_from_fork_asm+0x11/0x20

  __schedule+0x47c/0xbb0
  ? xas_find+0x161/0x1a0
  schedule+0x1c/0xa0
  blk_mq_freeze_queue_wait+0x3d/0x70
  ? destroy_sched_domains_rcu+0x30/0x30
  blk_mq_update_tag_set_shared+0x44/0x80
  blk_mq_exit_queue+0x141/0x150
  del_gendisk+0x25a/0x2d0
  nvme_ns_remove+0xc9/0x170
  nvme_remove_namespaces+0xc7/0x100
  nvme_remove+0x62/0x150
  pci_device_remove+0x23/0x60
  device_release_driver_internal+0x159/0x200
  unbind_store+0x99/0xa0
  kernfs_fop_write_iter+0x112/0x1e0
  vfs_write+0x2b1/0x3d0
  ksys_write+0x4e/0xb0
  do_syscall_64+0x5b/0x160
  entry_SYSCALL_64_after_hwframe+0x4b/0x53

The top stacktrace is showing nvme_timeout() called to handle nvme
command timeout. timeout handler is trying to disable the controller and
as a first step, it needs to blk_mq_quiesce_tagset() to tell blk-mq not
to call queue callback handlers. The thread is stuck waiting for
set->tag_list_lock as it tries to walk the queues in set->tag_list.

The lock is held by the second thread in the bottom stack which is
waiting for one of queues to be frozen. The queue usage counter will
drop to zero after nvme_timeout() finishes, and this will not happen
because the thread will wait for this mutex forever.

Given that [un]quiescing queue is an operation that does not need to
sleep, update blk_mq_[un]quiesce_tagset() to use RCU instead of taking
set->tag_list_lock, update blk_mq_{add,del}_queue_tag_set() to use RCU
safe list operations. Also, delete INIT_LIST_HEAD(&q->tag_set_list)
in blk_mq_del_queue_tag_set() because we can not re-initialize it while
the list is being traversed under RCU. The deleted queue will not be
added/deleted to/from a tagset and it will be freed in blk_free_queue()
after the end of RCU grace period.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Fixes: 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
---
 block/blk-mq.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d626d32f6e57..05db3d20783f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -335,12 +335,12 @@ void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
 {
 	struct request_queue *q;
 
-	mutex_lock(&set->tag_list_lock);
-	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(q, &set->tag_list, tag_set_list) {
 		if (!blk_queue_skip_tagset_quiesce(q))
 			blk_mq_quiesce_queue_nowait(q);
 	}
-	mutex_unlock(&set->tag_list_lock);
+	rcu_read_unlock();
 
 	blk_mq_wait_quiesce_done(set);
 }
@@ -350,12 +350,12 @@ void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set)
 {
 	struct request_queue *q;
 
-	mutex_lock(&set->tag_list_lock);
-	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(q, &set->tag_list, tag_set_list) {
 		if (!blk_queue_skip_tagset_quiesce(q))
 			blk_mq_unquiesce_queue(q);
 	}
-	mutex_unlock(&set->tag_list_lock);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(blk_mq_unquiesce_tagset);
 
@@ -4294,7 +4294,7 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
 	struct blk_mq_tag_set *set = q->tag_set;
 
 	mutex_lock(&set->tag_list_lock);
-	list_del(&q->tag_set_list);
+	list_del_rcu(&q->tag_set_list);
 	if (list_is_singular(&set->tag_list)) {
 		/* just transitioned to unshared */
 		set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
@@ -4302,7 +4302,6 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
 		blk_mq_update_tag_set_shared(set, false);
 	}
 	mutex_unlock(&set->tag_list_lock);
-	INIT_LIST_HEAD(&q->tag_set_list);
 }
 
 static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
@@ -4321,7 +4320,7 @@ static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
 	}
 	if (set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
 		queue_set_hctx_shared(q, true);
-	list_add_tail(&q->tag_set_list, &set->tag_list);
+	list_add_tail_rcu(&q->tag_set_list, &set->tag_list);
 
 	mutex_unlock(&set->tag_list_lock);
 }
-- 
2.51.2

