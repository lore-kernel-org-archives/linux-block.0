Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D3634DB69
	for <linux-block@vger.kernel.org>; Thu,  4 Dec 2025 18:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764871963; cv=none; b=CohbQcZzlH+QmJWlujIy/wCUfBszmivTophYAXSbNGURon6zQDgBdleTaGn6CaQoclskUWf46lGdIsSPWLDUySdBL55jum0kg84mygTvS40APPCPbtXDCLKFkEe3+R6mZLzylI60S6Go94Aeibcty+/CE989F4iyhKohpk1I2G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764871963; c=relaxed/simple;
	bh=IBFwytA32Wpg7N8PNqN5bNmay2fUL5irHNcwZXj37qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XB7KjhjH8SFDqYoeSl/Ba7jkbAq/ZB4NHScfmeDC2HyVcsFA+8X2fn6EvsGQLprItK122vWeAUhRmg4XLxaMHFT2umvXRdvcU1ltwqXFs7JoMDWbMLYTg3lwG7ATRUf1IPWCDLJ3CKp2j3vHecVe1FP/9ythHicW5JiYyJjxhK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=F9gmQlpE; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="F9gmQlpE"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-bc8ceb76c04so808650a12.1
        for <linux-block@vger.kernel.org>; Thu, 04 Dec 2025 10:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764871961; x=1765476761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkTYaAp/Bwr2qvdUFL9MXQBSJP8TjVnrLBt94hBT5IA=;
        b=F9gmQlpElwMF3PNRgHMfddG8PfUmn4+z5kbYTDktqIfAQ4PUKmVqXEgcqLSMecU+Qy
         u3d7u26S6nOH+E495jYLTc7zvc71e/tKOcD5kux0/Td1jaQUfWkbv6696c8bjgiTxVNG
         rjqxLdVe0iweAUi9+EOEbvgh3MlMhA7tNhwpXlrWkTNcj4uSzTo6xNOZcyR5TTkt/rjV
         oEt4RvTKvzmUhhX1Hk1sAvPcRcCmgmGIoSNFkis1Ahi7AK3u3zUosX9P8M99+TVHC2T2
         a21yj7xG2rC4hAyH1165zKw5nfUDNzyddUKEZTaL/zkcCJ25OoyaHR/sroJTez21HzFR
         zeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764871961; x=1765476761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wkTYaAp/Bwr2qvdUFL9MXQBSJP8TjVnrLBt94hBT5IA=;
        b=eWMDxNQIRx1pXw3fXtqjw4MelxZMkUfrKdZ7FTsdFVbg6gUYc3koMxjIfNjCFwqOHU
         /pw1ZxRAz9sTo8DvMtZXQIufzoDhi5RHHgxoQx377wS7J5oDbiDL4tYNT0fP5C1PLBcG
         l5CGztXlLvV6H9aY3+sEUum0QBdgXaQAJbUR6FPBi0t3psMb1yUoJhwSn+vxLFe8inmP
         GgfCYsUti6EU+i1N7ElRa2x5XkCNqtfXwZ8TZGfbofuTJjtkfBiUTI6KGbSsQRmtVAzc
         3bPlwFgWVEE/8CnOgGN5uteyWPKG/f390J12xKWznhfdcPZtpfNLn995xhTirY8BoT7O
         188Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQSEUDud93yoqFUjoY1rZsa3l7iZ7N8aFAPff8pRlbnkXyqhw1RLqEGemgsMGBKzhfi4O2aGxa6TziTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Qu/L/pgMpL9Y3IRBmSFs/ZU2T5oOu7DKffwHSPVJ7nvE5zCi
	UC7fKeNvMRwo6h9W8iNTVCotbz4/szXF+qgMod9/gdJdVVhVI5bF5UbyAXtObb4nbv0=
X-Gm-Gg: ASbGncvcrUFGREkGJu6mmZ8bEbKZLWmjJgpF4S7FVc4kxCCMhHvS8ERKQ89hf7CtYEq
	yGQrvdH+Qy7TYnyP8uaTjAW0b0E+9cLHzX6uoqL2XDP2/Z0kQbOMhCH5qx8WB2ca/ZhDBWv9mtL
	jZBOfKiUFaP3yIxplwOhQV54R5gTwHRS7FLnduMusN6zchwpi84EGbXcCMCty27eG2HEVJgjca6
	rlHbmJLNTcKYt6nujvR+/7TCaaNSXbSpL/mCopYQ3y0wWdDdyz6YrPtPFxrIQpRqvwoH6nv7gxS
	oK1WTrk/blHiLHsTCS/fdswU3XrTat/sxbAyDLRFu9C2OOOhUyEPofntiFPh6DAJ3R0QAnbLmjN
	f6QtEIvpIcoH7WFeWTG4Crelt7EpPkhcXZJPKYJm6MHKAhEJbRxpwmgFgraYG8OVfDIyGjJJWpZ
	4nSkgOnd6y6kP4rNE99bMgUArs0R0nLEciKw==
X-Google-Smtp-Source: AGHT+IFD8CHpgTKYp8RFzQjUFrV5P/g6cRtnJMlYeMKwqO9XKKGl7WN6jCHnhXjaV11aIP/wrSJptA==
X-Received: by 2002:a05:7300:cc9c:b0:2a4:3644:4be3 with SMTP id 5a478bee46e88-2ab92ee527fmr4333722eec.27.1764871960337;
        Thu, 04 Dec 2025 10:12:40 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-2aba8816ae9sm6998935eec.5.2025.12.04.10.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:12:39 -0800 (PST)
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
Subject: [PATCH 1/1] block: Use RCU in blk_mq_[un]quiesce_tagset() instead of set->tag_list_lock
Date: Thu,  4 Dec 2025 10:11:53 -0800
Message-ID: <20251204181212.1484066-2-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251204181212.1484066-1-mkhalfella@purestorage.com>
References: <20251204181212.1484066-1-mkhalfella@purestorage.com>
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

  __schedule+0x48e/0xed0
  schedule+0x5a/0xc0
  schedule_preempt_disabled+0x11/0x20
  __mutex_lock.constprop.0+0x3cc/0x760
  blk_mq_quiesce_tagset+0x26/0xd0
  nvme_dev_disable_locked+0x77/0x280 [nvme]
  nvme_timeout+0x268/0x320 [nvme]
  blk_mq_handle_expired+0x5d/0x90
  bt_iter+0x7e/0x90
  blk_mq_queue_tag_busy_iter+0x2b2/0x590
  ? __blk_mq_complete_request_remote+0x10/0x10
  ? __blk_mq_complete_request_remote+0x10/0x10
  blk_mq_timeout_work+0x15b/0x1a0
  process_one_work+0x133/0x2f0
  ? mod_delayed_work_on+0x90/0x90
  worker_thread+0x2ec/0x400
  ? mod_delayed_work_on+0x90/0x90
  kthread+0xe2/0x110
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x2d/0x50
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork_asm+0x11/0x20

  __schedule+0x48e/0xed0
  schedule+0x5a/0xc0
  blk_mq_freeze_queue_wait+0x62/0x90
  ? destroy_sched_domains_rcu+0x30/0x30
  blk_mq_exit_queue+0x151/0x180
  disk_release+0xe3/0xf0
  device_release+0x31/0x90
  kobject_put+0x6d/0x180
  nvme_scan_ns+0x858/0xc90 [nvme_core]
  ? nvme_scan_work+0x281/0x560 [nvme_core]
  nvme_scan_work+0x281/0x560 [nvme_core]
  process_one_work+0x133/0x2f0
  ? mod_delayed_work_on+0x90/0x90
  worker_thread+0x2ec/0x400
  ? mod_delayed_work_on+0x90/0x90
  kthread+0xe2/0x110
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x2d/0x50
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork_asm+0x11/0x20

The top stacktrace is showing nvme_timeout() called to handle nvme
command timeout. timeout handler is trying to disable the controller and
as a first step, it needs to blk_mq_quiesce_tagset() to tell blk-mq not
to call queue callback handlers. The thread is stuck waiting for
set->tag_list_lock as it tires to walk the queues in set->tag_list.

The lock is held by the second thread in the bottom stack which is
waiting for one of queues to be frozen. The queue usage counter will
drop to zero after nvme_timeout() finishes, and this will not happen
because the thread will wait for this mutex forever.

Given that [un]quescing queue is an operation that does not need to
sleep, update blk_mq_[un]quiesce_tagset() to use RCU instead of taking
set->tag_list_lock. Also update blk_mq_{add,del}_queue_tag_set() to use
RCU safe list operations. This should help avoid deadlock seen above.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 block/blk-mq.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d626d32f6e57..ceb176ac154b 100644
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
@@ -4302,6 +4302,8 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
 		blk_mq_update_tag_set_shared(set, false);
 	}
 	mutex_unlock(&set->tag_list_lock);
+
+	synchronize_rcu();
 	INIT_LIST_HEAD(&q->tag_set_list);
 }
 
@@ -4321,7 +4323,7 @@ static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
 	}
 	if (set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
 		queue_set_hctx_shared(q, true);
-	list_add_tail(&q->tag_set_list, &set->tag_list);
+	list_add_tail_rcu(&q->tag_set_list, &set->tag_list);
 
 	mutex_unlock(&set->tag_list_lock);
 }
-- 
2.51.2

