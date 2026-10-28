Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793231383;
	b=lULSrjdixXwnuN7nodRgmU8uj7xXxKEgZrSvnBYtnqzEWM22U0tJHtFw1iOJzUruHne4
	 OrxwqA7M3dEnTBc0AVnwn3jNs0rgdhuU22iBzV6qelz6zqWfeozw4ddABSvKZBcg6yq+5
	 tbLB9JILvcKCUHdIJM1HyX9nBCv+DMYzNBM/yKGNf7m/DgqszBA7i7LC1/4aqJEgI3JPr
	 yqXzOmYMf+6s4VBfoTdUpH+hy3Z48CSEc6yrmelzI3EjXAGJO84JmFoLL6IRACqKQrhdC
	 8MqanFcvjVEVN9to9r/TCRtxQtN3XHbR/REL8tmEbh9pQs+Ejy8fmZtAS/Qw0rHSyqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793231383;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=SKBEhM3MQg/PUw6p2XarbvNBrNHPZ+Tud/GCW+2PvGc=;
	b=j6F5qSWHu5YUnJgaxXaDNIYLeHl+JUHd1rAHsqAImff/yjX1eYEdXMO7+nW4Xar6d6Sr
	 o0NMxG3oKV6YSVS2PBogsW2i+kTblLZJMY8bz4oIGT19DkcdRTq7Ah/KmAs8Ez7TDhNNT
	 pZZvKt2Mfn3GzNwnZL4SCK1ey27vxS/npN8/NAdO+6Ma/R5iIMEAjmU0o2m63B8PENhz0
	 mk9vLwG+JVmcTTasSUvQ2+mK6tbGZfAie3eZU9zNm9+hULc/V5AmZUZK37rOQk54RfoHD
	 cdBuHd8mDs9DhQeqGnqnKi4hEH/jBDrq0BUrsXzi2yE0bmOUsjktethJ+UkHSbHh5YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=Uyti+sBq;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C5E606A31C
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 23:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4C5E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=Uyti+sBq
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jFPGt40Rczlfvpr;
	Wed, 28 Oct 2026 23:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1793231376; x=1795823377; bh=SKBEh
	M3MQg/PUw6p2XarbvNBrNHPZ+Tud/GCW+2PvGc=; b=Uyti+sBq4oGV8HXWNCj5F
	yUYFLJ4S8fLsDW9HelDpjz1KSj53LZcZlk55sJ9ngbRJxUvCydfW8Ba6ODNF+2m2
	BkCCNW5fhVAbmG1eoKpRI8jG3PcVYvYeCuZdWsg95KbXViqwlEgSEgWspdz0j1Um
	FSAupcMGMsllA5ZfcsXSg81aOEVzGMyGvMQn8jf11gPIc+xdtE6QLOVSr8WW4EDQ
	Y6PF415Cax7t0bria8pLoAOcMDmNmGwvJ6gcovbAtGNZB4V6dmfTHfPZEgMC8ybt
	1KRaS2f6Itdk6f5VCl265lZn2ni2N7ioDYBdbW/hl5hUrUSRA21hGEfkB7eqnoW+
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 7s3smx2bCS_j; Wed, 28 Oct 2026 23:49:36 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jFPGj2GrDzlfvq1;
	Wed, 28 Oct 2026 23:49:33 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>
Cc: Justin Sanders <justin@coraid.com>,
	linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 76/98] nvmet: fix NULL dereference in debugfs host_traddr
Date: Wed, 28 Oct 2026 16:49:12 -0700
Message-ID: <20261028234917.3067347-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
In-Reply-To: <20261028164415.1262013-77-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk> <20261028164415.1262013-77-axboe@kernel.dk>
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
> @@ -1849,6 +1849,9 @@ ssize_t nvmet_ctrl_host_traddr(struct nvmet_ctrl =
*ctrl,
>  {
>  	if (!ctrl->ops->host_traddr)
>  		return -EOPNOTSUPP;
> +	/* They all take the address from the admin queue */
> +	if (!ctrl->sqs[0])
> +		return -ENOTCONN;
>  	return ctrl->ops->host_traddr(ctrl, traddr, traddr_len);
>  }

As the commit message notes, nothing synchronizes this check with
nvmet_sq_destroy() clearing ctrl->sqs[0] and the transport freeing the
admin queue: nvmet_tcp_host_port_addr(), nvmet_rdma_host_port_addr(),
and nvmet_fc_host_traddr() all re-read ctrl->sqs[0] unlocked and
dereference the container transport queue, leaving a TOCTOU NULL
dereference and use-after-free.

Since args->sq is already passed to nvmet_alloc_ctrl() when the admin
queue creates the controller, we can pass struct nvmet_sq * directly to
ops->host_traddr, format the address once into ctrl->host_traddr before
nvmet_debugfs_ctrl_setup(ctrl), and have nvmet_ctrl_host_traddr() copy
out ctrl->host_traddr. That avoids touching ctrl->sqs[0] or the admin
transport queue after controller allocation altogether, and also keeps
debugfs host_traddr working even if the admin connection has closed.

Here is a replacement patch (checked with checkpatch.pl and
syntax-checked with Clang; not runtime-tested):

---
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index eea67fba6f92..b837c591af36 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1729,6 +1729,10 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_a=
lloc_ctrl_args *args)
 		goto init_pr_fail;
 	list_add_tail(&ctrl->subsys_entry, &subsys->ctrls);
 	nvmet_setup_p2p_ns_map(ctrl, args->p2p_client);
+	if (ctrl->ops->host_traddr && args->sq &&
+	    ctrl->ops->host_traddr(args->sq, ctrl->host_traddr,
+				   sizeof(ctrl->host_traddr)) < 0)
+		ctrl->host_traddr[0] =3D '\0';
 	nvmet_debugfs_ctrl_setup(ctrl);
 	mutex_unlock(&subsys->lock);
 	up_read(&nvmet_config_sem);
@@ -1849,7 +1853,9 @@ ssize_t nvmet_ctrl_host_traddr(struct nvmet_ctrl *c=
trl,
 {
 	if (!ctrl->ops->host_traddr)
 		return -EOPNOTSUPP;
-	return ctrl->ops->host_traddr(ctrl, traddr, traddr_len);
+	if (!ctrl->host_traddr[0])
+		return -EINVAL;
+	return strscpy(traddr, ctrl->host_traddr, traddr_len);
 }
=20
 static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *por=
t,
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index eecdffefa24f..1e1583c8b7e7 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -2960,10 +2960,9 @@ nvmet_fc_discovery_chg(struct nvmet_port *port)
 }
=20
 static ssize_t
-nvmet_fc_host_traddr(struct nvmet_ctrl *ctrl,
+nvmet_fc_host_traddr(struct nvmet_sq *sq,
 		char *traddr, size_t traddr_size)
 {
-	struct nvmet_sq *sq =3D ctrl->sqs[0];
 	struct nvmet_fc_tgt_queue *queue =3D
 		container_of(sq, struct nvmet_fc_tgt_queue, nvme_sq);
 	struct nvmet_fc_tgtport *tgtport =3D queue->assoc ? queue->assoc->tgtpo=
rt : NULL;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 5c2021b89ec4..e05cbf463751 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -297,6 +297,7 @@ struct nvmet_ctrl {
 	u32			nr_changed_ns;
=20
 	char			hostnqn[NVMF_NQN_FIELD_LEN];
+	char			host_traddr[NVMF_TRADDR_SIZE];
=20
 	struct device		*p2p_client;
 	struct radix_tree_root	p2p_ns_map;
@@ -444,7 +445,7 @@ struct nvmet_fabrics_ops {
 	void (*disconnect_queue)(struct nvmet_sq *sq);
 	void (*disc_traddr)(struct nvmet_req *req,
 			struct nvmet_port *port, char *traddr);
-	ssize_t (*host_traddr)(struct nvmet_ctrl *ctrl,
+	ssize_t (*host_traddr)(struct nvmet_sq *sq,
 			char *traddr, size_t traddr_len);
 	u16 (*install_queue)(struct nvmet_sq *nvme_sq);
 	void (*discovery_chg)(struct nvmet_port *port);
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index c4b848f84465..5e24cdb3a71f 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -2050,10 +2050,9 @@ static void nvmet_rdma_disc_port_addr(struct nvmet=
_req *req,
 	}
 }
=20
-static ssize_t nvmet_rdma_host_port_addr(struct nvmet_ctrl *ctrl,
+static ssize_t nvmet_rdma_host_port_addr(struct nvmet_sq *nvme_sq,
 		char *traddr, size_t traddr_len)
 {
-	struct nvmet_sq *nvme_sq =3D ctrl->sqs[0];
 	struct nvmet_rdma_queue *queue =3D
 		container_of(nvme_sq, struct nvmet_rdma_queue, nvme_sq);
=20
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 908614fa82b0..57b00f3ae988 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2348,10 +2348,9 @@ static void nvmet_tcp_disc_port_addr(struct nvmet_=
req *req,
 	}
 }
=20
-static ssize_t nvmet_tcp_host_port_addr(struct nvmet_ctrl *ctrl,
+static ssize_t nvmet_tcp_host_port_addr(struct nvmet_sq *sq,
 			char *traddr, size_t traddr_len)
 {
-	struct nvmet_sq *sq =3D ctrl->sqs[0];
 	struct nvmet_tcp_queue *queue =3D
 		container_of(sq, struct nvmet_tcp_queue, nvme_sq);
=20
