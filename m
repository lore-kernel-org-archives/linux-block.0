Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205946;
	b=dI9JE2Jy8P7+72F1fs/op1maKvuSnzamGlpDscqyaxqGNZ9BnRtAC7KCAR+I5bxTn1XR
	 KM2ZaMvVBKnBfIXEeB3ZDVA0+4Tx7ZzLvVq8Ltb3rswf16su3VRSrN5GkKCREodO3DGav
	 NQ5yqaVlGS/zmiktIOaDPLD02IWgDLwGgPACCwcxyQlaUrgZQ+BcSpoifww4NhYzYlOns
	 bvX1O8ewYgPME6BE+qHzWGmQlJh00zCSYVsBBglxx7FmjNy89/5sRmfCWEAgWGv2XNkfT
	 SB8AigIK4hYEPY3f7MBdIwc83HP5atO6K0GTV4pDGO+ec88lWoqw7sz8QgH40h+lTug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205946;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zdE4k1xRk0bJfM3sE8ZdaFWRJh1puu0cIOHDdq4o11E=;
	b=YxvG+flnNQKPLHDulhvkIx5rwVbisERG11WSfQtKLC0rorORqvZxCd6RPqs5bOdbUjSN
	 JXpDXy0eWjGxpdMgdvpyEk//r35/T+5vVE40RTjjv0GJNET3VKOT3Wp6xuRNulaTUmFsQ
	 6XHNvyj6YCNukJArcdjUq329cskg4mxiE6dz7izjq0Zpu9gbtEgfUmPnHZg6wzOKDYwZS
	 gPBoyYP2jX6x2jlbC1Vi8Z6huiZLcjOIGctfTe0B8ZFHOgxwm4hHGW0dIceL296khznZ4
	 HPqVhKkcJ1wxl5tP6KE5hDRloBUbxN1Z/rO9HvsbmwB2RE8aTXSiz0YHwEzSOBHOqbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=luAHn4tK;
	arc=none smtp.remote-ip=209.85.210.52
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFFD606A31F
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDFFD606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=luAHn4tK
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-84d5e56f876so845206a34.3
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205945; x=1793810745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zdE4k1xRk0bJfM3sE8ZdaFWRJh1puu0cIOHDdq4o11E=;
        b=luAHn4tK4eEq5Yb3Lqz6wDDbvnGuh88f421c1XfpKLTGb3Wqr/goE+7AVukugCmWZx
         hKKR2/jbv7VBm1Wc5CB/sKBCkTE5aoRpKqLbvuCAL4BiRMrWqpLYCW1x4WWsCtRDrHWL
         BtFXCc3YM8YOKtFPus8gtMeS3gmIRYssRs3UnlGOjx1LT/zDlZfkxEU/LMtP+6uWo7bk
         1ecl2s0VFg13yZI7dru/X3/hbDVwVZjrWBXkz/U6uA1vrgAPbxSfyQdxKoyt7SfRSQld
         xjwQdz3Hlh/WQjRtNt5oHd1JDx9Txe97SH91o8/+DniD7C2UgR2dA5Cg3zwmwumkbUoh
         ZoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205945; x=1793810745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zdE4k1xRk0bJfM3sE8ZdaFWRJh1puu0cIOHDdq4o11E=;
        b=DZZPw61oNyVsP9Gu+oio8ZkjFEQOLCw90ktcwmaIx/lrpwdfSVecz7PMPKnMB+4cG5
         wMUdh41e19lp2gmCqQE6qVLgg55WKWv7F6QMPNzFdfrZFWs5NxcZFc3T3GJD4IjTKeSj
         9BxPIARNZ2UWHCjfpDFbCEqvRU7W01ZURidzaTb0c2vXLfGBZI5wedNooTbIdtZQeCsu
         JO85Suq1bdbE72NT+FVZ8tFiNYyffcwkHzehBNKqxYhHzIlvwIIus1PhHiVsP2TGyy7e
         W8mYvG/k7gQO8ifSEAFxGy+0ZGvQRLw5f0AoyOyEqm1JzKbiwQHTYzQwp7jsFIzxzU4O
         KnFA==
X-Gm-Message-State: AFq9FYI+JOM/EhUb9YhK16z/7v6qGjLE095g+Z7pXHjcMFVI30BXxqFE
	Fr4+Rpn1AUWxxnO/wPacfMrAc2K1vnG3HI66oiuNPn5jrQG7lfNLrGd188c2Wz19IN6cXiz9RfB
	MsGrPaF0=
X-Gm-Gg: AYBFou3FyvjXzKiyTbhaNR4QwF+Xxl8v/ziXqWpYK1fGmzsK7xlTUam6XMpvF6WspJj
	3n5R3DSR2ZQAXSH3rhiKeEjMv9hjzUfdOei/TOVwjAxBeQ2nn9LVqIZ/aX8wVL9CFKKIPHX7ngf
	D4MIJXfQSxwRvlLhPSoRj9V4l1bDN11qUtq3ysc2DvJhTkyBYCngjI3XUfkG21vonVXkEOpAzsE
	AdaAEDBnvyXGK3FTqrf66my736/js/vFGOVFgsxuRglCppepE/VV8rv7/9l7kV/7/866N2ZDWhm
	rJEHNR4TqRQBTGyJIDl/3KupT1yXtBQk4WcEQAv3/z4NeXEm1P6pmtfI9rr+si6HwQ500skiByh
	Zwe0vTUyMMI/l+FplPAso5V1uGbUkRE/12w/r+F8ZRoxzA+674fWDku8iBV/5ZEWXAHPF2NHMNd
	RGpGY+VAll7OK9+EgtrpSCNN12viCwS2o/n4oLeqlUqjvcuPrquiAEKFNCzezLNgMO+4fLzh4/w
	PRavUQ2cGopHhAFWhYvVlMHg0mqCbGKn5H6I+qbt0GovfERk4NvPjax4lD46Hd6jn/wIkt8Uine
	IzKbJ1jQj/fLrSbLVzRM6rKCS+ebjBsbVv3DYkl3rPUrPQ6JAlNn2xE+UU72pk1PLn6Jb8UWXg=
	=
X-Received: by 2002:a05:6830:3d8f:b0:844:d1b5:df47 with SMTP id 46e09a7af769-85ac070710dmr2760387a34.19.1793205944893;
        Wed, 28 Oct 2026 09:45:44 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:44 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 69/98] nvmet: confine fatal errors of unauthenticated queues
Date: Wed, 28 Oct 2026 10:42:12 -0600
Message-ID: <20261028164415.1262013-70-axboe@kernel.dk>
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

The Connect of an I/O queue names its controller by NQNs and cntlid and
needs no secret, DH-HMAC-CHAP comes after it. But a fatal error on any
queue, a failed authentication or a transport error like an unknown PDU
type, takes the whole controller down. So anyone who can reach the port
and knows the NQNs can attach a queue to an authenticated host's
controller and kick that host out, repeatedly.

Add a ->disconnect_queue() transport op and, for an I/O queue that
hasn't passed the authentication asked of it, disconnect just that
queue. Transports without the op (fc, loop) take the controller down as
before. A queue that had authenticated and fails to do so again is the
host's own, there the controller goes down as before too.

[axboe: resolved against the per-queue auth_lock and expiry work that
 is upstream now]

Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
Cc: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/auth.c             |  9 ++++++---
 drivers/nvme/target/core.c             | 16 ++++++++++++++++
 drivers/nvme/target/fabrics-cmd-auth.c | 20 ++++++++++++++++----
 drivers/nvme/target/nvmet.h            |  7 +++++++
 drivers/nvme/target/rdma.c             |  9 ++++++++-
 drivers/nvme/target/tcp.c              | 11 ++++++++++-
 6 files changed, 63 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 5809ce32a2e4..335cf8f3f79e 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -261,10 +261,8 @@ void nvmet_destroy_auth(struct nvmet_ctrl *ctrl)
 #endif
 }
 
-bool nvmet_check_auth_status(struct nvmet_req *req)
+bool nvmet_sq_auth_status(struct nvmet_sq *sq)
 {
-	struct nvmet_sq *sq = req->sq;
-
 	if (!sq->ctrl->host_key || sq->authenticated)
 		return true;
 
@@ -272,6 +270,11 @@ bool nvmet_check_auth_status(struct nvmet_req *req)
 	return sq->qid && nvmet_queue_tls_keyid(sq);
 }
 
+bool nvmet_check_auth_status(struct nvmet_req *req)
+{
+	return nvmet_sq_auth_status(req->sq);
+}
+
 int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 			 unsigned int shash_len)
 {
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index d01f8abed66c..eea67fba6f92 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1828,6 +1828,22 @@ void nvmet_ctrl_fatal_error(struct nvmet_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvmet_ctrl_fatal_error);
 
+/*
+ * A fatal error on one queue.  The Connect command of an I/O queue needs no
+ * secret, so until the queue has authenticated it may be anybody's: do not
+ * let it take down the controller of the host whose NQN it has named.
+ */
+void nvmet_sq_fatal_error(struct nvmet_sq *sq)
+{
+	struct nvmet_ctrl *ctrl = sq->ctrl;
+
+	if (sq->qid && ctrl->ops->disconnect_queue && !nvmet_sq_auth_status(sq))
+		ctrl->ops->disconnect_queue(sq);
+	else
+		nvmet_ctrl_fatal_error(ctrl);
+}
+EXPORT_SYMBOL_GPL(nvmet_sq_fatal_error);
+
 ssize_t nvmet_ctrl_host_traddr(struct nvmet_ctrl *ctrl,
 		char *traddr, size_t traddr_len)
 {
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 8c48140eb542..cb6be285b3c4 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -33,6 +33,14 @@ static void nvmet_auth_expired_work(struct work_struct *work)
 	mutex_unlock(&sq->auth_lock);
 }
 
+static void nvmet_auth_fatal_error(struct nvmet_sq *sq, bool passed)
+{
+	if (passed)
+		nvmet_ctrl_fatal_error(sq->ctrl);
+	else
+		nvmet_sq_fatal_error(sq);
+}
+
 void nvmet_auth_sq_init(struct nvmet_sq *sq)
 {
 	/* Initialize in-band authentication */
@@ -253,11 +261,13 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 	void *d;
 	u32 tl;
 	u16 status = 0;
+	bool passed;
 	u8 dhchap_status;
 
 	mutex_lock(&req->sq->auth_lock);
 	mutex_lock(&ctrl->auth_lock);
-
+	/* A queue that fails to authenticate again is no stranger's. */
+	passed = nvmet_sq_auth_status(req->sq);
 	if (req->cmd->auth_send.secp != NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER) {
 		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		req->error_loc =
@@ -430,7 +440,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 	/* Final states, clear up variables */
 	nvmet_auth_sq_free(req->sq);
 	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE2)
-		nvmet_ctrl_fatal_error(ctrl);
+		nvmet_auth_fatal_error(req->sq, passed);
 
 complete:
 	mutex_unlock(&ctrl->auth_lock);
@@ -551,10 +561,12 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
 	void *d;
 	u32 al;
 	u16 status = 0;
+	bool passed;
 
 	mutex_lock(&req->sq->auth_lock);
 	mutex_lock(&ctrl->auth_lock);
-
+	/* A queue that fails to authenticate again is no stranger's. */
+	passed = nvmet_sq_auth_status(req->sq);
 	if (req->cmd->auth_receive.secp != NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER) {
 		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		req->error_loc =
@@ -641,7 +653,7 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
 		nvmet_auth_sq_free(req->sq);
 	else if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE1) {
 		nvmet_auth_sq_free(req->sq);
-		nvmet_ctrl_fatal_error(ctrl);
+		nvmet_auth_fatal_error(req->sq, passed);
 	}
 	mutex_unlock(&ctrl->auth_lock);
 	mutex_unlock(&req->sq->auth_lock);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index cc7fface77de..e354a71514ae 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -441,6 +441,7 @@ struct nvmet_fabrics_ops {
 	int (*add_port)(struct nvmet_port *port);
 	void (*remove_port)(struct nvmet_port *port);
 	void (*delete_ctrl)(struct nvmet_ctrl *ctrl);
+	void (*disconnect_queue)(struct nvmet_sq *sq);
 	void (*disc_traddr)(struct nvmet_req *req,
 			struct nvmet_port *port, char *traddr);
 	ssize_t (*host_traddr)(struct nvmet_ctrl *ctrl,
@@ -622,6 +623,7 @@ void nvmet_sq_destroy(struct nvmet_sq *sq);
 int nvmet_sq_init(struct nvmet_sq *sq, struct nvmet_cq *cq);
 
 void nvmet_ctrl_fatal_error(struct nvmet_ctrl *ctrl);
+void nvmet_sq_fatal_error(struct nvmet_sq *sq);
 
 void nvmet_update_cc(struct nvmet_ctrl *ctrl, u32 new);
 
@@ -989,6 +991,7 @@ void nvmet_destroy_auth(struct nvmet_ctrl *ctrl);
 void nvmet_auth_sq_free(struct nvmet_sq *sq);
 void nvmet_auth_sq_destroy(struct nvmet_sq *sq);
 int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id);
+bool nvmet_sq_auth_status(struct nvmet_sq *sq);
 bool nvmet_check_auth_status(struct nvmet_req *req);
 int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 			 unsigned int hash_len);
@@ -1015,6 +1018,10 @@ static inline void nvmet_auth_sq_init(struct nvmet_sq *sq)
 static inline void nvmet_destroy_auth(struct nvmet_ctrl *ctrl) {};
 static inline void nvmet_auth_sq_free(struct nvmet_sq *sq) {};
 static inline void nvmet_auth_sq_destroy(struct nvmet_sq *sq) {};
+static inline bool nvmet_sq_auth_status(struct nvmet_sq *sq)
+{
+	return true;
+}
 static inline bool nvmet_check_auth_status(struct nvmet_req *req)
 {
 	return true;
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index ffa1e172c259..c4b848f84465 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -687,7 +687,7 @@ static void nvmet_rdma_release_rsp(struct nvmet_rdma_rsp *rsp)
 static void nvmet_rdma_error_comp(struct nvmet_rdma_queue *queue)
 {
 	if (queue->nvme_sq.ctrl) {
-		nvmet_ctrl_fatal_error(queue->nvme_sq.ctrl);
+		nvmet_sq_fatal_error(&queue->nvme_sq);
 	} else {
 		/*
 		 * we didn't setup the controller yet in case
@@ -1848,6 +1848,12 @@ static int nvmet_rdma_cm_handler(struct rdma_cm_id *cm_id,
 	return ret;
 }
 
+static void nvmet_rdma_disconnect_queue(struct nvmet_sq *sq)
+{
+	nvmet_rdma_queue_disconnect(container_of(sq, struct nvmet_rdma_queue,
+						 nvme_sq));
+}
+
 static void nvmet_rdma_delete_ctrl(struct nvmet_ctrl *ctrl)
 {
 	struct nvmet_rdma_queue *queue, *n;
@@ -2078,6 +2084,7 @@ static const struct nvmet_fabrics_ops nvmet_rdma_ops = {
 	.remove_port		= nvmet_rdma_remove_port,
 	.queue_response		= nvmet_rdma_queue_response,
 	.delete_ctrl		= nvmet_rdma_delete_ctrl,
+	.disconnect_queue	= nvmet_rdma_disconnect_queue,
 	.disc_traddr		= nvmet_rdma_disc_port_addr,
 	.host_traddr		= nvmet_rdma_host_port_addr,
 	.get_mdts		= nvmet_rdma_get_mdts,
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index a2a5f39d2bb7..c8f0c52a1b95 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -412,7 +412,7 @@ static void nvmet_tcp_socket_error(struct nvmet_tcp_queue *queue, int status)
 	if (status == -EPIPE || status == -ECONNRESET || !queue->nvme_sq.ctrl)
 		kernel_sock_shutdown(queue->sock, SHUT_RDWR);
 	else
-		nvmet_ctrl_fatal_error(queue->nvme_sq.ctrl);
+		nvmet_sq_fatal_error(&queue->nvme_sq);
 }
 
 static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
@@ -2223,6 +2223,14 @@ static void nvmet_tcp_remove_port(struct nvmet_port *nport)
 	kfree(port);
 }
 
+static void nvmet_tcp_disconnect_queue(struct nvmet_sq *sq)
+{
+	struct nvmet_tcp_queue *queue =
+		container_of(sq, struct nvmet_tcp_queue, nvme_sq);
+
+	kernel_sock_shutdown(queue->sock, SHUT_RDWR);
+}
+
 static void nvmet_tcp_delete_ctrl(struct nvmet_ctrl *ctrl)
 {
 	struct nvmet_tcp_queue *queue;
@@ -2300,6 +2308,7 @@ static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
 	.remove_port		= nvmet_tcp_remove_port,
 	.queue_response		= nvmet_tcp_queue_response,
 	.delete_ctrl		= nvmet_tcp_delete_ctrl,
+	.disconnect_queue	= nvmet_tcp_disconnect_queue,
 	.install_queue		= nvmet_tcp_install_queue,
 	.disc_traddr		= nvmet_tcp_disc_port_addr,
 	.host_traddr		= nvmet_tcp_host_port_addr,
-- 
2.56.0

