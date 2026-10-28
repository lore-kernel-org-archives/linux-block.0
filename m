Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205952;
	b=EzVi4Fm/W8RtsKujmySpiH+Lyw8KzC8RSYVD9IhXgEbxBL3ahbyh1GCr2VY4/m71orp4
	 6eoCUzE6vzuKx7d3KTAmdmuzKemH6dy6c03gt5g/Q0kqw5O31yFBLW9thKJ+blvy3Ahzd
	 916mevU5ZyZv/HEkcjhSnTf2ycBjHfl63EAY3dqZaFcI3Sl2w+Cgdp6YDPloahsgZpVze
	 4qN+mIRMNPHgBtJ+AtcMvWUbVM/GcpfBhwY63pkF6PnVjzkpkVI647I/TOfUOZ5muw7/O
	 LCLp4oEbXAV4q5bVcoB+nUfNniTYvNj0sI6TrkJn1YKLiRxMz+4z7QWBzTDIgpLWHww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205952;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jlhI/uzOfwVf3BoL3UiUzwTILCcRcijMCYaiODSmN4s=;
	b=abIiKiXuAOfF4TXVUU9Snx1jTXqMNV4xfROZU6+udq568vNMPJPxMiFwknGiSxZnc8BX
	 ViRnIFOej0nzobCDmLt/sQG4Hkw3Ju4cjDr4p3QHwqMZbFPYCfbmzsE70dfpfrd2Rpe5r
	 ebztANHAuFYRFvXdMssAnDtB1XfhTb1sy75vN1xZPQdqVju3WQm/FAohPdxAdPh8JYMWl
	 TLwcnjppdiYqVb5OYRbDaudIbarrPYbZ5+Ht71k8LblTd5UQUbfLcELWYUY/Finf5MdCP
	 amuXE7zUD2SVWZCHliXVzZUPxtKIVcE3dZ+lOUjpRNqtMOYw3Lh6hheZiM7yWe4rZXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=DNfVvUuW;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0934A606A326
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0934A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=DNfVvUuW
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-84621d8c7aaso590100a34.2
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205951; x=1793810751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jlhI/uzOfwVf3BoL3UiUzwTILCcRcijMCYaiODSmN4s=;
        b=DNfVvUuWJ5n/LPGvvcMylkKFP1nz8ANos97XK4IRa7SaVcdR4BCtVg2chJrVlpiXRB
         b+2SqymSQZjKZKVfU7qwtIbhvJlV3N2u5rtLONtIrT9bTIK/DIAmNNtcuPLCTVZ0E3oQ
         6t29241EB6VbjtyedtQevEL+Ic+KSYfyo7KYyxqO8ul3nFi2KAgiIrubnwTi8+55xhr1
         sCfrTbRMiZsyOetSraK3gRMod2hLQqI6CCwlntKmMEKkUpDEc/nhG8Kj42NhVC0icaMh
         SZF7l4Js8FSLdWNI66wPHqzJf4zx+Z+/uzx2SLkl8k3SeZBc0XTYklL90fEpwsdObD7e
         Tikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205951; x=1793810751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jlhI/uzOfwVf3BoL3UiUzwTILCcRcijMCYaiODSmN4s=;
        b=KQ4GJivzWUKsmAPXM35lew0EWAqpEjd+tPs0suN9ms8dZrmY1ANNRdykUMWage7Aa0
         9+3fQxUMPpuKUrCsNWxO+EYDP3ymb3W3N37hnJbaPokbTIUuPxvvFrxfiEuCnXl3n/jY
         yiiu7n5bHCKWxxU0F6Tnf+mgNwGbldlnlQyEUpmcDFftLtMr4pxopCKWfDPIXJESvC7/
         lmq4QDkQdb5Y6HaAe7+3hGo3qZiBd130dbO8WL3WreF5i9XXj4Z6Frdw/qWqDB2UiK7M
         C+bfVGDHbUw1mnxFGbJzphufO0LnjTfmM6/6IiVzHFyJHkTS5LK7K+Omdc/Cwi/wF69Z
         s1bA==
X-Gm-Message-State: AFq9FYIAG5xbSW6RTGOhDAaUbNXHRR3ht5vL4SGeHwOU+6jZl3pikSRP
	cxtQL4nvcFWFWZoiaH0dGX4NhI2lgMZP0Xj8uabyP8Esncz+lv/bkY5EOYsPhUVh3T1Dsq5eslW
	OIHL+r3o=
X-Gm-Gg: AYBFou2vbtJHHAZM1uG4W5vRB16tCy7XzHZWz5/FQFu2Yv6NzIpNsZ8aUNQLWcLH1Iu
	NENGyK/MrdeyB4H+4hyDP0b6pJVwnJQuei38XGxfWRglZHKrQ6Y9FwjfjyXfVe82rhQptdGc18t
	7I7NBpgeFOvaqY3QKig2l/3HdV+mPT9P+Ed1Pi8gOE2kwvrLfefknX6w4TJ80HFD/ICnd7QeKMy
	wvrZkS6QlZ66kWd9t8dEFmlnDN32yPHwTRdwgoV6HyEnB89uRuL4+Is62SH+5jhFbUjw5So+hXU
	0JTNuyNctbPMIXDlrblKNaawRWH+KEV7vIgmle0TWRc4DO5FDJOsg/kq5nk7FCu83v0+y+dN3Yy
	KrHbIEPAohtQ+YIdtOxhAF7kEoiE4cebsEM31xUx3qflSgjCfdr7Z+JZZEbQU2dyO2OUly32fRC
	KmYIo1Jv5hIlxg9SlG1YFwMNMyrPV5QpaIGRwQw/iVdiwCEox+CMJ3LQYsbJOCs30Pl1HgyFbbp
	4hUvUOHTctQVkOlXh8fm1ijz1UjCq6EAAhB7vgRkKA/5fsguwjCBOB4k0AkhJtnDjhEEZUTCaj/
	oHTBFjJwDlzqM0iQvXqBapUZwc5qUs5Fq/qi83VQtyGOOQ0HGv6lAdtM1H5StR2WtLp4q8C6kg=
	=
X-Received: by 2002:a05:6830:2690:b0:846:5d82:8bc8 with SMTP id 46e09a7af769-85ababeb330mr2721965a34.0.1793205951053;
        Wed, 28 Oct 2026 09:45:51 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:50 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 74/98] nvme-tcp: keep the page frag cache with the controller
Date: Wed, 28 Oct 2026 10:42:17 -0600
Message-ID: <20261028164415.1262013-75-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

nvme_tcp_init_request() allocates the PDU from the queue's page frag
cache under pf_cache_lock, and it's called not just for the tag set but
for the flush request of every hctx of a new namespace. The cache and
the lock are torn down and reinitialized with the connection though,
and a namespace scan isn't stopped by error recovery, so it allocates
from a cache that's being drained or set up:

  WARNING: kernel/locking/mutex.c:625 at __mutex_lock+0xa25/0x1a30
   nvme_tcp_init_request+0x8c/0x1a0
   blk_mq_alloc_and_init_hctx+0x28e/0x6c0

Without lock debugging a waiter can spin forever on a mutex that's
being reinitialized, an allocation beside the drain can return a
fragment of a freed page, and what's allocated after the drain leaks if
the controller goes away. The target, or anyone who can break the
connection, picks the moment.

The PDUs outlive the connection anyway. Initialize the lock with the
controller and drain the caches when it's freed.

Fixes: a5053c92b3db ("nvme-tcp: fix memory leak when freeing a queue")
Fixes: 36ac05f7cfd5 ("nvme-tcp: fix usage of page_frag_cache")
Cc: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/tcp.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c9531e653a2c..4aa666dd0266 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -162,6 +162,7 @@ struct nvme_tcp_queue_setup_ctx {
 struct nvme_tcp_ctrl {
 	/* read only in the hot path */
 	struct nvme_tcp_queue	*queues;
+	int			nr_queues;	/* allocated, see queue_count */
 	struct blk_mq_tag_set	tag_set;
 
 	/* other member variables */
@@ -1668,8 +1669,6 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	if (!test_and_clear_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
 		return;
 
-	page_frag_cache_drain(&queue->pf_cache);
-
 	/**
 	 * Prevent memory reclaim from triggering block I/O during socket
 	 * teardown. The socket release path fput -> tcp_close ->
@@ -1692,7 +1691,6 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 
 	kfree(queue->pdu);
 	mutex_destroy(&queue->send_mutex);
-	mutex_destroy(&queue->pf_cache_lock);
 }
 
 static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
@@ -2021,7 +2019,6 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	INIT_LIST_HEAD(&queue->send_list);
 	mutex_init(&queue->send_mutex);
 	INIT_WORK(&queue->io_work, nvme_tcp_io_work);
-	mutex_init(&queue->pf_cache_lock);
 
 	if (qid > 0)
 		queue->cmnd_capsule_len = nctrl->ioccsz * 16;
@@ -2153,7 +2150,6 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	queue->sock = NULL;
 err_destroy_mutex:
 	mutex_destroy(&queue->send_mutex);
-	mutex_destroy(&queue->pf_cache_lock);
 	return ret;
 }
 
@@ -2840,6 +2836,10 @@ static void nvme_tcp_stop_ctrl(struct nvme_ctrl *ctrl)
 static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
+	int i;
+
+	for (i = 0; i < ctrl->nr_queues; i++)
+		page_frag_cache_drain(&ctrl->queues[i].pf_cache);
 
 	if (list_empty_careful(&ctrl->list))
 		goto free_ctrl;
@@ -3265,9 +3265,15 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 		ret = -ENOMEM;
 		goto out_free_ctrl;
 	}
-	/* A poller may try the lock of a queue that has been freed */
-	for (i = 0; i < ctrl->ctrl.queue_count; i++)
+	ctrl->nr_queues = ctrl->ctrl.queue_count;
+	/*
+	 * A poller may try the lock of a queue that has been freed, and a
+	 * request of a new namespace may be set up for one.
+	 */
+	for (i = 0; i < ctrl->nr_queues; i++) {
 		mutex_init(&ctrl->queues[i].queue_lock);
+		mutex_init(&ctrl->queues[i].pf_cache_lock);
+	}
 
 	ctrl->net = get_net(current->nsproxy->net_ns);
 
-- 
2.56.0

