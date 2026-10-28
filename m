Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205983;
	b=GjwyI5z9DpJ6Tvje5rDqg1tniU+JLzFb6t0ANOz8nRnqFCH309QTnjOfmAQrUOs88QFM
	 5TyfPtIJeRokPjmKYzL6+Rmzv8BoO1awkw5l9+bPmTWMLoOPaaiJwML8t8vXKe7j2XD0P
	 Aq0zzhw0LVOmltNTJEkbf0aj7pLUnjJV3xbZA/kvRGlPh1AfSfmHMWVjcNuK3Z/13BMuy
	 lO5QY3mcy2dv0TA1dVcUq6TJeRQgQDJ+ggxHPNeNC92bXgHRgcI31kwP+91+di3q9lM19
	 TwKIZB/I81trGFXfsOHSiRux6YLmA2A2O3euRA4FQ+BscScMD8Csf13alpe09PllSeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205983;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pfeQr79aa5oQnJoi6Rj/0W0CHmAupuy+JAx6Cdp8Tl8=;
	b=HflnNk4PbL8bXDejECNFJFZuh71aPXnHFk5Z1QdNLDxpgfSzx46/0z1uzu7kV3ThxBmX
	 23qyuVdvevhyIvHK7JO3l7+3Mk+K/RnDwPRoguOraLA9m6iH4cIZ9aeLWeTfqri9G4Xca
	 lNVJX3d2BGtkCAtctSmeqyHbicY61XPSJn0gNdxBPDjIqT3t4NYWEE7OY4FgOi3kYyzh6
	 KJtMy3N8s3aEgfd1roylzU8vH7gxMWLZBSwwIlpwYKtUUQB6AoExUFGRF35GEKO3mZxCd
	 2fYofp9Vdy6wPtPfFFp7weU6jLzwcMVQhwaoRbNGGofqZhDXIoIMt1HTHT4R06SiAIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Hxd0aDmy;
	arc=none smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2609960A380E
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:46:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2609960A380E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Hxd0aDmy
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-8253bc5a613so808567a34.0
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205982; x=1793810782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pfeQr79aa5oQnJoi6Rj/0W0CHmAupuy+JAx6Cdp8Tl8=;
        b=Hxd0aDmy9gPVNOzNyt/0OvYCavrAPRAtESR3SZa5yPVzfPx22lzW43toolT9HmXub5
         PgqN8cKDWVOliccB8Qg/LtbC0Q3Zi0oTES6OOZRZjdbqX5TVm+dASLjKo/zb+cEIMuHF
         xjQbFjwIGtCJDqf3p11ePlorEw7JUvujiTHEMck4Y1b5moFLPCflrco6eWhy68Xyh9yw
         pNjrAdHFIRvljpc0dxO3W1SMljJ5+ZFRGBsTkTu/JIKiRLQiIfgJTo7AxxpmsbAwNbCn
         7dgsDJ152LKj7VDEgjxbRCHP82lpACQaILz6yiAy0osexjK78gQJs2r2AI0Vf+8TWRqS
         pSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205982; x=1793810782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pfeQr79aa5oQnJoi6Rj/0W0CHmAupuy+JAx6Cdp8Tl8=;
        b=QFhfPs2hEiVe2/U/+obYvh8hw6794J4ORL5LYpt8xnBdFjsh0acsSeJcLWmvbMU9db
         b6EKoSbdKYm3uvTNwcMQIw41A343iA87TxatVLpFOSsiDKM94XcLUeafQrjXgcEdGG/I
         76wChs1b9nq+VWLieZ/4/o0Im1NduAh6YD+C+5o51cRMQlIQUoDDq5pE8buSu8+X6TCC
         s4PEK+iM9oMdui2oQ/GBwGoUCng/66o3x0f7Srvc4bi4IYkaabxHlhTOU137ibetQ6Cm
         80Mc9YaOH0Tq4uPYfHHI8STURQqS2XZen5Djg/UA6pFNiiMYsW/bU10ceaEhlV1hM6sz
         l4bA==
X-Gm-Message-State: AFq9FYL14q84NOTyZ0XJjMfquiuyZuY63qzwBnGqmbbuvi3qk4hZ/1AG
	jzKBcUg/uOoSR28nuHwvIaE5cPP2c7bgogq3S5aFRpQbHIO/vVk5ITPD+0gIssO7dnbYoS+HEgA
	lif8zCtY=
X-Gm-Gg: AYBFou2XRfF68Os631oHwpLuv7rCUwt4RGIMZ98AcWo1u12GrGvg5jRC1SF3+XCNQYW
	QFf3+vo9jqutEwEqTbunmr+f5PT8R5q0EinSAFuj3FHKqDTbNnx4Hr5PlM536CJs4UaZJwiPecs
	TV1v+rK02XFvJfm/pGzVb5hzi5ZN6yySKnYAeWU/PR+PYvHTvmtmYr0t9K5nYnp9x9M9q+/lqG7
	T+AiJY/JxK7KQOXg2ObNCaSLSFJQsl+jo2OfQuWTAM4fUNgGLXModN15K0kDVpqHSwJxvHky8mj
	e08FJm0u17OoWPIt8pyUN5B/GOj5f7VhBKrdHhJQQIYc0HIRPcH+PVseGytTtMvWp3/DIIM+oXK
	xs02yOtPiiHfP76SSOtDxqnGurQjpWih50xDX4qMdpXWEnEsUqLs8AdOTuHYRQeN+Au1gv5eFfl
	yekUHEAJLMOMPpyNJXHw0Cbe6kouWcUY2tR2Jjy+6JH90p+pZFT9C9zdgxyHpjpaqBb85xx/1lQ
	4R+6KkHhj2q+FshJ4Ay/h2wiRmCRoXU5m5Ctx9dCjA01axKqaMgreRftlKYvCMKJAnF+PmYQsbp
	YcPdz6h0IdZa3956oLEYXIOqPL7mzXYJGeXqHIwyv89UBBniT5yMbg/AKrjXazrpgRydgow7FAc
	N5lA4VjhZ2cpBpT0Il0M=
X-Received: by 2002:a05:6830:680f:b0:81c:a8c5:633c with SMTP id 46e09a7af769-85ab7b0d6b0mr2736696a34.17.1793205981988;
        Wed, 28 Oct 2026 09:46:21 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:46:21 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 96/98] nvmet: take sq->ref in nvmet_sq_fatal_error()
Date: Wed, 28 Oct 2026 10:42:39 -0600
Message-ID: <20261028164415.1262013-97-axboe@kernel.dk>
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

nvmet_sq_destroy() kills sq->ref, waits for the commands to drop it,
then puts the controller and clears sq->ctrl. So sq->ctrl may only be
used while holding sq->ref. nvmet_sq_fatal_error() reads it without,
and its transport callers hold nothing either: in nvmet-rdma the
completion handlers run until the QP is drained, which
nvmet_rdma_release_queue_work() does only after nvmet_sq_destroy(), and
in nvmet-tcp io_work can run between the two cancels of the release
work. A short capsule or a failed completion that races the disconnect
then dereferences a NULL sq->ctrl, or locks ctrl->lock and queues
fatal_err_work in a freed controller. The host needs nothing but a
Connect, reproduced over rxe with a sleep added to widen the window.

Take sq->ref with percpu_ref_tryget_live() around the body. If the ref
is already dead the queue is going away and the error is dropped, which
is the mitigation: nothing can tell a call that would have finished in
time from one that wouldn't. tryget_live after percpu_ref_exit() is
fine, it sees __PERCPU_REF_DEAD and touches nothing freed, and
nvmet_req_init() already relies on that. nvmet_auth_fatal_error() runs
in a command that holds the ref, so it calls the body directly.

Fixes: 14c862dbb0a0 ("nvmet-rdma: drain the queue-pair just before freeing it")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/core.c             | 21 ++++++++++++++++++++-
 drivers/nvme/target/fabrics-cmd-auth.c |  3 ++-
 drivers/nvme/target/nvmet.h            |  1 +
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b78a4d4eb838..19f96f1b7e74 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1833,8 +1833,11 @@ EXPORT_SYMBOL_GPL(nvmet_ctrl_fatal_error);
  * A fatal error on one queue.  The Connect command of an I/O queue needs no
  * secret, so until the queue has authenticated it may be anybody's: do not
  * let it take down the controller of the host whose NQN it has named.
+ *
+ * The caller holds sq->ref, as a command that is being executed does: until it
+ * is put, nvmet_sq_destroy() waits, and does not clear sq->ctrl.
  */
-void nvmet_sq_fatal_error(struct nvmet_sq *sq)
+void __nvmet_sq_fatal_error(struct nvmet_sq *sq)
 {
 	struct nvmet_ctrl *ctrl = sq->ctrl;
 
@@ -1843,6 +1846,22 @@ void nvmet_sq_fatal_error(struct nvmet_sq *sq)
 	else
 		nvmet_ctrl_fatal_error(ctrl);
 }
+
+/*
+ * A transport calls this with no reference of its own, concurrently with
+ * nvmet_sq_destroy(), which puts the controller and clears sq->ctrl.  As in
+ * nvmet_req_init(), the call can come after percpu_ref_exit():
+ * percpu_ref_tryget_live() then sees that the ref is dead and touches nothing
+ * that is freed.
+ */
+void nvmet_sq_fatal_error(struct nvmet_sq *sq)
+{
+	if (!percpu_ref_tryget_live(&sq->ref))
+		return;
+
+	__nvmet_sq_fatal_error(sq);
+	percpu_ref_put(&sq->ref);
+}
 EXPORT_SYMBOL_GPL(nvmet_sq_fatal_error);
 
 ssize_t nvmet_ctrl_host_traddr(struct nvmet_ctrl *ctrl,
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index cb6be285b3c4..020a989fe263 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -33,12 +33,13 @@ static void nvmet_auth_expired_work(struct work_struct *work)
 	mutex_unlock(&sq->auth_lock);
 }
 
+/* Called from a command that is being executed, which holds sq->ref. */
 static void nvmet_auth_fatal_error(struct nvmet_sq *sq, bool passed)
 {
 	if (passed)
 		nvmet_ctrl_fatal_error(sq->ctrl);
 	else
-		nvmet_sq_fatal_error(sq);
+		__nvmet_sq_fatal_error(sq);
 }
 
 void nvmet_auth_sq_init(struct nvmet_sq *sq)
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 29105e2a7022..3519537705f8 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -631,6 +631,7 @@ void nvmet_sq_destroy(struct nvmet_sq *sq);
 int nvmet_sq_init(struct nvmet_sq *sq, struct nvmet_cq *cq);
 
 void nvmet_ctrl_fatal_error(struct nvmet_ctrl *ctrl);
+void __nvmet_sq_fatal_error(struct nvmet_sq *sq);
 void nvmet_sq_fatal_error(struct nvmet_sq *sq);
 
 void nvmet_update_cc(struct nvmet_ctrl *ctrl, u32 new);
-- 
2.56.0

