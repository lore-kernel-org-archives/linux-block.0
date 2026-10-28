Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205962;
	b=5LhPzFsqi+GSQWOhl0USOoZSMmJugVfWaftu8ozmVDtnCcx/HAPVH+hAImSwNOepUmoH
	 Lhn5a/7DkooBjy+4zTAu6RiJjVfD/tkgNHfz4TXKd0aegRWQoUP0IGEfwZNfUmDJwCpF9
	 lN2n1YmIfN7/2/Rylbe181pG0v1kreVYqGhVqB36Srrnlgis35qw2F96I+eNAGsvLngqc
	 7uy5idS8rcKY2E0Kuue26vSXPZ6QZ0ZHpM3AMyIFsMkWpprqVxCwKjhk6oneGhdbQ0OyX
	 20SqKXdcNoAvzapUYoqJxnZg5xrP6mcJhP0Zj1feebCp2u0EdRsL9LRC+p+00EEhHLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205962;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DzGEEs0ay7pyB2sE4++FiYEu7fZzYJC7NMBTgrhLXwY=;
	b=2G1entBPsewKsiSa5Ghp2Lm2/4PwzCRVlv3B25fLnbdUTB7NkdnqJQMAJcrKeRla/aEN
	 A65r+P7l+HahXeG1GNOEdfsX8lHhgLNC34UGYbWhYdz5yfg8CK1UQLuQ3Xyl7dywj/wO7
	 KRhhCKGcTe/fYAPnEyeEyGasyQBTzmLXrzBOv02GxWkGjKn4PX+K77fZiifK0HTX4NvfY
	 0cwVUSeGWeZRmO/wrUlwzrG/vNWxBXS85IP9+gzhpQ8jAdhO2dPtDs2vW7Pnso6UlG2y4
	 EkUEeE9oKThI5vLG30BeZuae/YIQIyw/gSYZKXl3IO177TyBOPtiuF5wEMo8JCDhoxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=KQthycbF;
	arc=none smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A2E606A327
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57A2E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=KQthycbF
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6b8e2d8df4fso964691eaf.1
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205961; x=1793810761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DzGEEs0ay7pyB2sE4++FiYEu7fZzYJC7NMBTgrhLXwY=;
        b=KQthycbFiKI/CnxnwU5nzq+QHCeJeeSswIASHTJH+3vRluVMLp0WnMvIaJupYTq19G
         9JTxW65Dyv2Y+9v3Vrg1XTwh2Do/2JiyukZ0RKpASaL0JdNuALmzXFu0uDvbWZJHiscz
         c4thB9u5oiT/7dEf7WE1mqVzPYREhb9wn4hOrrOOoyaKt433gx/OkDAlr0CBzInhxsZz
         siqZ0pSUJQrZh+CAP73hX4xlj6vKHCRAwrnwr1N4aaogwOi0YFn/8HnUbF2ySHrgFEwz
         TKbha6SOYVcAz/NWob3WTBBa9fH890HPpxVFT6uRbtB4NroVSg2RajZkiXYUCijHn40j
         sPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205961; x=1793810761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DzGEEs0ay7pyB2sE4++FiYEu7fZzYJC7NMBTgrhLXwY=;
        b=QlSnqsKTn8PuJOC0q+B4m7ReCqOwnQs+SYjFLvc4DBdUZEjsHgGztlpIqx4tc2qneK
         mWARBA2b+XUp/c9Xr8nGeyyx8GAtH5uXp+lf3rl+SM+wKwJgaxb9laRpwa1NPMAy4RGy
         tKfCW/H4l+WNrFnbateHlNLf77fQerUUxysG9K2kF+FsxNjJBefMfDCPNzegKJuBtDiz
         lft4k3TH1vYzxkKt8DwyoZYAekk01GT9GnQRzCd+/7mmdbxQ7C7P3yDcL5hjO7teNPg9
         ZNDdvLx3Bt+c9p5jW1HYKAbcBpjA9CjNz3Jw2UcJDuhObUZIjud2wgW/tXHn+aPAVrce
         kGIQ==
X-Gm-Message-State: AFq9FYI1qlXAcR4raPZDEecrdmPsGUkgONmlopNuRpA6512ZoiC3Yhnm
	ygULhbOaxfpAju63M5zncLIX1GBh0rfwUvPpeEunkOl4mDHVMaSatNhoonUJFdNCRmJC1eFFEMf
	ZV87u/gA=
X-Gm-Gg: AYBFou1pEtKXqq8SfV067/AlAhwLoWo8zFqNoK4rvfA0Q3q/3BIPfzhFKzBqnfOLfna
	+IIZPwjiM49UTqf3gwjo4K/mA3M183b/YbKJP1ovSXD+wzd2tfEGydtB9FjF0ANxTKRGACAdPLX
	qUTh7j4IgOApTLc0/Gwx1HLoI5UAohurj5DPGrKZlycjqwQGtQESbXVqF+IQ5Z3k+DWqDeOk9Yf
	zZ+hCQ9m4Pls1Xo2xzZ1pAKTb5xO3DRbPNcTDFLOSaOHEiA7LqYx1IYaMU7UiTGCcaeQ2ZMUzW3
	Cxsfz9s/Tj15cZ5gfBL0mJmvPCxdiajaq/D9JYhNslqzJXqR/Ker5SzJkeCjZtcn2izLOOy8IFa
	p4OYw5UZlYBe4xDnvlDOR1r0XEy0F1CAro43ZHcXuTI/2thW2MeAjMOTnBNnPs11oqD8MOcZQFl
	cNKzwXPU93qm2g5p5ktesrH4QnvUwUuztsYXav5r2OB+r7u2SFatOBmk1M0hceyNxcHoR0Cp4RO
	hYvJfVYNVHV4VAOmevCBk1VnqCLtZSLL2SKMDtXHPNbgNK+lLur+TRHS8c3XPoipxLyAh/YYSwF
	DzCCWFYrrZib26VH7slgI46deL13p3lvU4JQqt8JZZspu7AWJfQKdLIEE3j5UL1HTn7W+0BqDw=
	=
X-Received: by 2002:a05:6820:169e:b0:713:da3b:938f with SMTP id 006d021491bc7-713ee7665bcmr1778741eaf.50.1793205961207;
        Wed, 28 Oct 2026 09:46:01 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:46:00 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 82/98] nvmet: move preempt and abort work off nvmet-wq
Date: Wed, 28 Oct 2026 10:42:25 -0600
Message-ID: <20261028164415.1262013-83-axboe@kernel.dk>
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

From: Chris Mason <mason@kernel.org>

nvmet_pr_do_abort() runs on nvmet-wq, holds pr_sem while it waits for
the preempted controllers' I/O, and releases it at the end. nvmet-wq
also runs nvmet_tcp_release_queue_work(), which cancel_work_sync()s the
io_work of a closed connection, and that io_work may be sleeping on
pr_sem in a reservation command. So a host that keeps a write in flight
on a preempted controller, sends a second preempt and abort, and then
closes enough connections with a reservation command in flight fills
nvmet-wq with release works that wait for pr_sem. When the first abort
finishes, the second one is queued on a full workqueue behind them and
never starts, pr_sem is never released, and the accept work doesn't run
either, so nobody can connect.

Queue the abort work on its own workqueue so it starts regardless. The
release works can still fill nvmet-wq while pr_sem is held, and a
file-backed namespace's flush, DSM and write zeroes need nvmet-wq
themselves, so this is a mitigation.

Fixes: 5a47c2080a73 ("nvmet: support reservation feature")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/core.c  | 11 ++++++++++-
 drivers/nvme/target/nvmet.h |  1 +
 drivers/nvme/target/pr.c    |  6 +++++-
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 142df0db5208..f96b21257169 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -29,6 +29,7 @@ struct workqueue_struct *nvmet_wq;
 EXPORT_SYMBOL_GPL(nvmet_wq);
 struct workqueue_struct *nvmet_aen_wq;
 EXPORT_SYMBOL_GPL(nvmet_aen_wq);
+struct workqueue_struct *nvmet_pr_wq;
 
 /*
  * This read/write semaphore is used to synchronize access to configuration
@@ -2034,9 +2035,14 @@ static int __init nvmet_init(void)
 	if (!nvmet_aen_wq)
 		goto out_free_nvmet_work_queue;
 
+	nvmet_pr_wq = alloc_workqueue("nvmet-pr-wq",
+				      WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
+	if (!nvmet_pr_wq)
+		goto out_free_nvmet_aen_work_queue;
+
 	error = nvmet_init_debugfs();
 	if (error)
-		goto out_free_nvmet_aen_work_queue;
+		goto out_free_nvmet_pr_work_queue;
 
 	error = nvmet_init_discovery();
 	if (error)
@@ -2052,6 +2058,8 @@ static int __init nvmet_init(void)
 	nvmet_exit_discovery();
 out_exit_debugfs:
 	nvmet_exit_debugfs();
+out_free_nvmet_pr_work_queue:
+	destroy_workqueue(nvmet_pr_wq);
 out_free_nvmet_aen_work_queue:
 	destroy_workqueue(nvmet_aen_wq);
 out_free_nvmet_work_queue:
@@ -2071,6 +2079,7 @@ static void __exit nvmet_exit(void)
 	nvmet_exit_discovery();
 	nvmet_exit_debugfs();
 	ida_destroy(&cntlid_ida);
+	destroy_workqueue(nvmet_pr_wq);
 	destroy_workqueue(nvmet_aen_wq);
 	destroy_workqueue(nvmet_wq);
 	destroy_workqueue(buffered_io_wq);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 563b966b8f75..9e8fbb2d1fc1 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -532,6 +532,7 @@ extern struct workqueue_struct *buffered_io_wq;
 extern struct workqueue_struct *zbd_wq;
 extern struct workqueue_struct *nvmet_wq;
 extern struct workqueue_struct *nvmet_aen_wq;
+extern struct workqueue_struct *nvmet_pr_wq;
 
 static inline void nvmet_set_result(struct nvmet_req *req, u32 result)
 {
diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
index 1c0d6cac1a6b..1a03f74c2e14 100644
--- a/drivers/nvme/target/pr.c
+++ b/drivers/nvme/target/pr.c
@@ -756,7 +756,11 @@ static void nvmet_execute_pr_acquire(struct nvmet_req *req)
 	if (!status && acquire_act == NVME_PR_ACQUIRE_ACT_PREEMPT_AND_ABORT) {
 		kfree(d);
 		INIT_WORK(&req->r.abort_work, nvmet_pr_do_abort);
-		queue_work(nvmet_wq, &req->r.abort_work);
+		/*
+		 * Not nvmet_wq: works on it can wait for pr_sem, which this
+		 * work releases.
+		 */
+		queue_work(nvmet_pr_wq, &req->r.abort_work);
 		return;
 	}
 
-- 
2.56.0

