Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793231384;
	b=iHj0U/YTwROyVwyaBR7tKzSvtk+iqqYj9X9JzX5gOQ0ddHvgjhkCWYyneuaLZQ+/LlMz
	 4S9ivrx60kJLulg1L8u/eUa+kX8q7A6jPktOIDVznpQvlkRqjzpVgNBVo+8ZStiyCIqUj
	 xKVYjF62pwsPf4Kt3jjvXkkhhojUSDwvNm5TcvRZIwnylfEXTLFh0gYsL5jz5lWuzwPM1
	 lVGGUe1AcF4EyDy+XUmDB8idAiwjs9k9Sjvnxe8IONhY9y6oOEisfZv0m6M2t/BeHgt99
	 Ej9+KAhLup7/3buAvj2mND4ChfFBnO1jkBad9Ya3iizH1rxbFeHtbhmwlhhENB8JB1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793231384;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=WMtEmggmtuphAXWr5wTbD5Be4c5CvWUhFMl906hF4ks=;
	b=bUorNapEJpUiuqxNrzCsAgGmtZzheVhowF917ComSFrCgP2XM+rhBMSV2AtU4YSvf4sU
	 o2HeFcjLvDvpz1crC5iV9/4PUkP0okhiuLlEMcxOUgf7Llef40/mGbq9DCssNrXw28hoe
	 +hzEFHcOMqiGEO7RRkGskUZrjBRbikBdbdLMRrD1sAmmCkMdG1u4nUFJtvh9tRnArJ+Z3
	 K5e+n+yl9XMwviUfZKu7l6PQ+2GoFAjjUEfrEMvlS40lz1gsrJ5nyN6iG9u9quHMres3+
	 1flLe+Hq8XGs+H4P8Nxqdhmdzo1mTjeDq+Vi+HtV0kJEOIs2mUpmsLYHhcJcXgo9uWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=hrPq1kIe;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD85606A325
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 23:49:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBD85606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=hrPq1kIe
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jFPGv2b5Dzlfvpc;
	Wed, 28 Oct 2026 23:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1793231376; x=1795823377; bh=WMtEm
	ggmtuphAXWr5wTbD5Be4c5CvWUhFMl906hF4ks=; b=hrPq1kIeBdoMzoIv/3hpn
	ESPa5z2OgXP5CvZDCNXNfXdS2/vFh+njSwKtypLkKXr5uPt7pck409Nl4rgo85NC
	ZyA1y98UFW9QSv5D4hnw4GGNYZTJuixw1Eegu2wXTJTJSV2+X8kb/OK6zd5zDgJB
	7Y4T+2D7c3HRp3YY6Rfl+4hUe3wW/7gtDx59Bj03S6UvcqUGmLjK7YhAM8duCR+x
	WCq0JVOXs6U9jERKHoKlGB+ZgyAfSVJlANjpo8GSVaUmnt2UCsFhJqRotuFTj6ma
	4VCr/+IbqfEBE9txx5CTdc/4UHOM9a2vDLMSotMGfijNo7Pjc7X486MRL6+PsW/b
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 0cTAaMz7IUBP; Wed, 28 Oct 2026 23:49:36 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jFPGk07ZkzlfvpT;
	Wed, 28 Oct 2026 23:49:33 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>,
	Chris Mason <mason@kernel.org>
Cc: Justin Sanders <justin@coraid.com>,
	linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 90/98] nvmet-rdma: disable interrupts under rsp_wr_wait_lock
Date: Wed, 28 Oct 2026 16:49:13 -0700
Message-ID: <20261028234917.3067347-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
In-Reply-To: <20261028164415.1262013-91-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk> <20261028164415.1262013-91-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 10/28/26 09:42, Jens Axboe wrote:
> -		spin_unlock(&queue->rsp_wr_wait_lock);
> +		spin_unlock_irqrestore(&queue->rsp_wr_wait_lock, flags);
>  		ret =3D nvmet_rdma_execute_command(rsp);
> -		spin_lock(&queue->rsp_wr_wait_lock);
> +		spin_lock_irqsave(&queue->rsp_wr_wait_lock, flags);

Using spin_lock_irqsave() fixes the rsp_wr_wait_lock deadlock itself,
but when nvmet_rdma_process_wr_wait_list() is reached from a bio end_io
callback in hardirq or softirq context (via nvmet_req_complete() ->
nvmet_rdma_queue_response() -> failed ib_post_send() ->
nvmet_rdma_release_rsp()), spin_unlock_irqrestore() restores that
hardirq/softirq context and calls nvmet_rdma_execute_command(rsp) ->
rsp->req.execute(&rsp->req).

The nvmet ->execute() handlers require process context:
- nvmet_bdev_execute_rw() allocates bios with GFP_KERNEL and calls
  submit_bio() -> submit_bio_noacct(), which hits might_sleep() and
  manipulates current->bio_list without interrupt synchronization.
- Admin, fabrics, auth, and PR handlers perform GFP_KERNEL allocations
  and take mutexes / rwsems.

If nvmet_rdma_process_wr_wait_list() checks !in_task() under
rsp_wr_wait_lock and schedules a per-queue wr_wait_work on system_dfl_wq
when rsp_wr_wait_list is non-empty (cancelled after ib_drain_qp() in
nvmet_rdma_destroy_queue_ib()), normal task/CQ-workqueue callers pay no
extra cost while hardirq/softirq completions safely defer command
execution to process context.

Note: patches 91/98 and 92/98 compose cleanly on top by placing the
if (done && done->wait_released) check right above if (!in_task()) and
passing NULL from nvmet_rdma_wr_wait_work().

Here is a replacement patch (checked with checkpatch.pl and
syntax-checked with Clang; not runtime-tested):

---
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 26ea4e1d62b3..60ea488db8f4 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -104,6 +104,7 @@ struct nvmet_rdma_queue {
 	struct nvmet_rdma_cmd	*cmds;
=20
 	struct work_struct	release_work;
+	struct work_struct	wr_wait_work;
 	struct list_head	rsp_wait_list;
 	struct list_head	rsp_wr_wait_list;
 	spinlock_t		rsp_wr_wait_lock;
@@ -513,7 +514,15 @@ static int nvmet_rdma_post_recv(struct nvmet_rdma_de=
vice *ndev,
=20
 static void nvmet_rdma_process_wr_wait_list(struct nvmet_rdma_queue *que=
ue)
 {
-	spin_lock(&queue->rsp_wr_wait_lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&queue->rsp_wr_wait_lock, flags);
+	if (!in_task()) {
+		if (!list_empty(&queue->rsp_wr_wait_list))
+			schedule_work(&queue->wr_wait_work);
+		spin_unlock_irqrestore(&queue->rsp_wr_wait_lock, flags);
+		return;
+	}
 	while (!list_empty(&queue->rsp_wr_wait_list)) {
 		struct nvmet_rdma_rsp *rsp;
 		bool ret;
@@ -522,16 +531,24 @@ static void nvmet_rdma_process_wr_wait_list(struct =
nvmet_rdma_queue *queue)
 				struct nvmet_rdma_rsp, wait_list);
 		list_del(&rsp->wait_list);
=20
-		spin_unlock(&queue->rsp_wr_wait_lock);
+		spin_unlock_irqrestore(&queue->rsp_wr_wait_lock, flags);
 		ret =3D nvmet_rdma_execute_command(rsp);
-		spin_lock(&queue->rsp_wr_wait_lock);
+		spin_lock_irqsave(&queue->rsp_wr_wait_lock, flags);
=20
 		if (!ret) {
 			list_add(&rsp->wait_list, &queue->rsp_wr_wait_list);
 			break;
 		}
 	}
-	spin_unlock(&queue->rsp_wr_wait_lock);
+	spin_unlock_irqrestore(&queue->rsp_wr_wait_lock, flags);
+}
+
+static void nvmet_rdma_wr_wait_work(struct work_struct *w)
+{
+	struct nvmet_rdma_queue *queue =3D
+		container_of(w, struct nvmet_rdma_queue, wr_wait_work);
+
+	nvmet_rdma_process_wr_wait_list(queue);
 }
=20
 static u16 nvmet_rdma_check_pi_status(struct ib_mr *sig_mr)
@@ -976,6 +993,7 @@ static bool nvmet_rdma_execute_command(struct nvmet_r=
dma_rsp *rsp)
 static void nvmet_rdma_handle_command(struct nvmet_rdma_queue *queue,
 		struct nvmet_rdma_rsp *cmd)
 {
+	unsigned long flags;
 	u16 status;
=20
 	ib_dma_sync_single_for_cpu(queue->dev->device,
@@ -993,9 +1011,9 @@ static void nvmet_rdma_handle_command(struct nvmet_r=
dma_queue *queue,
 		goto out_err;
=20
 	if (unlikely(!nvmet_rdma_execute_command(cmd))) {
-		spin_lock(&queue->rsp_wr_wait_lock);
+		spin_lock_irqsave(&queue->rsp_wr_wait_lock, flags);
 		list_add_tail(&cmd->wait_list, &queue->rsp_wr_wait_list);
-		spin_unlock(&queue->rsp_wr_wait_lock);
+		spin_unlock_irqrestore(&queue->rsp_wr_wait_lock, flags);
 	}
=20
 	return;
@@ -1374,6 +1392,7 @@ static bool nvmet_rdma_reclaim_rsp(struct sbitmap *=
sb, unsigned int bitnr,
 static void nvmet_rdma_destroy_queue_ib(struct nvmet_rdma_queue *queue)
 {
 	ib_drain_qp(queue->qp);
+	cancel_work_sync(&queue->wr_wait_work);
=20
 	/*
 	 * Reclaim resources of a response that is still in-flight when the
@@ -1494,6 +1513,7 @@ nvmet_rdma_alloc_queue(struct nvmet_rdma_device *nd=
ev,
 	 * inside a CM callback would trigger a deadlock. (great API design..)
 	 */
 	INIT_WORK(&queue->release_work, nvmet_rdma_release_queue_work);
+	INIT_WORK(&queue->wr_wait_work, nvmet_rdma_wr_wait_work);
 	queue->dev =3D ndev;
 	queue->cm_id =3D cm_id;
 	queue->port =3D port->nport;
