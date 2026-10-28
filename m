Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205961;
	b=DYs0KEqn5Qy740U602PxY5NMR8U78OrmvSbm+7nIcfYyvrWR1YKaD+1620S8T5k/NfHc
	 eOk1VVCQuKQeCRLN5k0ngqbT51JefbX+nNcyes81pWuoDx/h6qaoqU4lzCLaBqejsT8jW
	 7ATbuX8ePDrV6+mjFSB+yGYq8jteDY+YvPf6uBY4GH5erIdTplbWx2iDNsODXXYnh6K+K
	 ioZudSQNDIFJ0VI101fNb3PxkuiWRKF3rjQ4w5ZaLh1t/XPO5+Ixmbw5aWIk60Z5QeeO1
	 SmAO7MZV+tIaKUAR5P09730ohHe+lyD51fWfxyRNIoHM1FSinSGM3N/ywNQSELJ7Cvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205961;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=G7gCoPt/e62Do1yOIsAYRz3yCQo0+6cGklO97umnCNs=;
	b=rLdKq3DlWrEQqHqjLFiTr3HX3VEWHa+gWk3YD95EBSoWqqMrapy7/O7zFeyh8bqDn92j
	 +gnGqewpkFRJeaeX4TrNVCj5iqj17mOoSoEXv9vi13u3ftDHsRId6FZbOKQQKtNqylwJ8
	 whs8dzmY233jDq+E70bVlzoW9IqiWihAuxE6MPKEhoGKmem3dIP+YMRwSGJ41msbtPXPb
	 AefTvqnORPMDK78t6woOfY3SxCKj8xUVaL1ydyh8wYgkOl5aLTBGeBFPar/wJttkfOwPS
	 ahIjKp5mtU7P+tw7/3ux2kr9jFrSj71t2MX/vBwssh7+rMVMIXX9GQEpiCgeNnzH+ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jrjvkyab;
	arc=none smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BEF606A31E
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:46:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14BEF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jrjvkyab
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6deb848ddd7so954635eaf.0
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205960; x=1793810760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G7gCoPt/e62Do1yOIsAYRz3yCQo0+6cGklO97umnCNs=;
        b=jrjvkyabGuyGn8j1dtnbu3McJ1U4LtM4uYd6f5Cmj0j7Gi31RU7m0eJlu+F+9a9kM9
         wilRi6WAmr1DBQAUTI3LdgcUshDYwK5LCfQ2v9kR80vhzt85ACraUxSy5LO39fSMA2ex
         /kLBZp9CQ1WS1C+Njrlhj6WPYWMl3ZD9dpk5eVm2s41MjnM8zuztiEn8gCetaCy1zdXd
         KX7vmzj21p+FU6RERB5UfQSZMKuS3jJZu/vRZKoVTxHDOpK/OFt03HWYtKXou1kqnqg4
         iwxoj9F3fW0K9VGIOpUln88nD/N2HICJeaXfNpkFrkDb/PF0NFs0iTeBdCCRwJK5ptCl
         EI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205960; x=1793810760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G7gCoPt/e62Do1yOIsAYRz3yCQo0+6cGklO97umnCNs=;
        b=z1jWGspFcFXEPEkDWnVt0Drn9d5wyS6m9QZuyK8a9W7CM4U1tbMgJy21+T5/k2ylwV
         pYuzTa7v2ZzW4fpYQ7Hc/w48uwR7f2fRFl/dWK1msc5vFX+jRo4fxViOJBvrGbYbvj0u
         3bnN0ZDCtoKxBUo5ky5dYagDhv4fHRtD24YD6fO9OCBjBW7D3sT41yvR2isrROdFN0me
         Hc0kHFgcISZZIPyO7tX5ocuYOXo4eEVzTNZFSQF4JhdXvzYtYf1vkREaj3L2NNF3nY6n
         dj5wrA89BBYh3fg9bZsIJJhLbgmvghcbkwkeFIQyKv3g1QOO4V2ziC9P/QFmb+iQmYp7
         hYfQ==
X-Gm-Message-State: AFq9FYIaPS4DR51dzM1HfXFruUNSl6YcKkibYZPLymweVNHg4roEG1Ue
	rISFr0HS3qJlH1uxQOH1vaR3jWpf4oUVwyYWDdrQBHV9Wzhy1Nz0DeBcNbE8WaC7CD7Bam3ZD6m
	w83mr0no=
X-Gm-Gg: AYBFou2an8u/W/gO4oiJsv8HdL0o0r/xg/qklhImDVpkqxx/LwEmrycB4Sadyo7nOL6
	7sb9vW5CKLJo8rxJfgciyNyo3B63DIcX/Yw4AwKR/O4KJst8RpL09uiDL/txx43fmE0iJyA3sZa
	tcu2KlfEdyEocMoT62V/ZbGeRpD/aHCHxn2GaqM7ReyjWuIck47lifFtN7NsNsv+Ru+i/patHF1
	l+Io49kzeqKQ6RmPPyTYx3g9IwGYd4lPERnWnnwT9aaJzfWgEuQUX/a4VbNadk/4JuT3PIkXBD1
	IYK8UcNoqocmCWUb08P56S2gon8QesttMg1aAfnb7XQet23ktmgT2uEuTwDzzEU5vrRpBlZCX/C
	/VyGYcQi6DB8hqFv0EXRe5FZKmO1XoUozPeKlR6JrbaoTZqYRGR/Q/APDLmSk54hb7TbmNAS6MQ
	Y1KWCiQS+Vv4opp96iixLG4hva5jgPOhVbdbQJNz7Qw5PdGP/gG4feXoLWsdSaqtKwithBoxM49
	t/ubhIJ3r0/NZ2t7xbMfBUrP6AvmmkcdqBiBg0kJfADW0aM8TgU4m8aA5DChTMmI9DqrL6hefrj
	f6PbZNsUohX+qjY24GjHZsI7WTi7VNOmm4JwB401Pik4LsFk8azOxTCJRtCAnqemufh9QZtyWg=
	=
X-Received: by 2002:a05:6820:2203:b0:6d7:a325:35f7 with SMTP id 006d021491bc7-713f05cff45mr1543561eaf.81.1793205959984;
        Wed, 28 Oct 2026 09:45:59 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:59 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 81/98] nvmet: fix pc_ref use-after-free in preempt and abort
Date: Wed, 28 Oct 2026 10:42:24 -0600
Message-ID: <20261028164415.1262013-82-axboe@kernel.dk>
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

With reservations enabled on a namespace, the target keeps a pc_ref per
controller, a percpu_ref counting that controller's I/O on the
namespace. "Preempt and abort" kills the pc_refs of the preempted
controllers and waits for the kill to be confirmed in
nvmet_pr_set_ctrl_to_abort(), then waits for the count to drop to zero
and resurrects them in nvmet_pr_do_abort(). Neither holds a reference
to the pc_ref, only pr_sem. nvmet_ctrl_destroy_pr() frees the pc_refs
under subsys->lock when the controller goes away, so a host that
registers a key, disconnects, and sends preempt and abort with that key
over a second connection frees a pc_ref that the abort is sleeping on:

    preempt and abort on C1            last put of C2
    nvmet_pr_set_ctrl_to_abort()
      percpu_ref_kill_and_confirm()
      wait_for_completion()
                                       nvmet_ctrl_destroy_pr()
                                         percpu_ref_exit()
                                         kfree(pc_ref)
    percpu_ref_switch_to_atomic_rcu()  /* use after free */

Put the pc_refs that an abort has killed on a per-namespace list.
nvmet_ctrl_destroy_pr() only flags a pc_ref on that list, and
nvmet_pr_do_abort() frees flagged ones once it's done with them. The
list and the flag are written under the xarray lock.

Fixes: 5a47c2080a73 ("nvmet: support reservation feature")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/nvmet.h |  5 ++
 drivers/nvme/target/pr.c    | 92 ++++++++++++++++++++++++++-----------
 2 files changed, 69 insertions(+), 28 deletions(-)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 5c2021b89ec4..563b966b8f75 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -88,6 +88,8 @@ struct nvmet_pr {
 	 */
 	struct semaphore	pr_sem;
 	struct list_head	registrant_list;
+	/* The pc_refs that a running "preempt and abort" has killed. */
+	struct list_head	abort_list;
 };
 
 struct nvmet_pr_per_ctrl_ref {
@@ -95,6 +97,9 @@ struct nvmet_pr_per_ctrl_ref {
 	struct completion	free_done;
 	struct completion	confirm_done;
 	uuid_t			hostid;
+	/* Both are written under the lock of ns->pr_per_ctrl_refs. */
+	struct list_head	abort_entry;
+	bool			ctrl_gone;
 };
 
 struct nvmet_ns {
diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
index 14eaa99f98fa..1c0d6cac1a6b 100644
--- a/drivers/nvme/target/pr.c
+++ b/drivers/nvme/target/pr.c
@@ -468,18 +468,54 @@ static void nvmet_pr_confirm_ns_pc_ref(struct percpu_ref *ref)
 	complete(&pc_ref->confirm_done);
 }
 
+static void nvmet_pr_free_pc_ref(struct nvmet_pr_per_ctrl_ref *pc_ref)
+{
+	percpu_ref_exit(&pc_ref->ref);
+	kfree(pc_ref);
+}
+
+/*
+ * The controller goes away. "Preempt and abort" sleeps on the pc_refs on its
+ * list, so leave the free of such a pc_ref to nvmet_pr_do_abort().
+ */
+static void nvmet_pr_erase_pc_ref(struct nvmet_ns *ns, unsigned long cntlid)
+{
+	struct nvmet_pr_per_ctrl_ref *pc_ref;
+
+	xa_lock(&ns->pr_per_ctrl_refs);
+	pc_ref = __xa_erase(&ns->pr_per_ctrl_refs, cntlid);
+	if (pc_ref && !list_empty(&pc_ref->abort_entry)) {
+		pc_ref->ctrl_gone = true;
+		pc_ref = NULL;
+	}
+	xa_unlock(&ns->pr_per_ctrl_refs);
+
+	if (pc_ref)
+		nvmet_pr_free_pc_ref(pc_ref);
+}
+
 static void nvmet_pr_set_ctrl_to_abort(struct nvmet_req *req, uuid_t *hostid)
 {
 	struct nvmet_pr_per_ctrl_ref *pc_ref;
 	struct nvmet_ns *ns = req->ns;
 	unsigned long idx;
 
+	xa_lock(&ns->pr_per_ctrl_refs);
 	xa_for_each(&ns->pr_per_ctrl_refs, idx, pc_ref) {
-		if (uuid_equal(&pc_ref->hostid, hostid)) {
-			percpu_ref_kill_and_confirm(&pc_ref->ref,
-						nvmet_pr_confirm_ns_pc_ref);
-			wait_for_completion(&pc_ref->confirm_done);
-		}
+		if (uuid_equal(&pc_ref->hostid, hostid) &&
+		    list_empty(&pc_ref->abort_entry))
+			list_add_tail(&pc_ref->abort_entry,
+				      &ns->pr.abort_list);
+	}
+	xa_unlock(&ns->pr_per_ctrl_refs);
+
+	list_for_each_entry(pc_ref, &ns->pr.abort_list, abort_entry) {
+		/* Killed for another host that this command preempts. */
+		if (percpu_ref_is_dying(&pc_ref->ref))
+			continue;
+		percpu_ref_kill_and_confirm(&pc_ref->ref,
+					    nvmet_pr_confirm_ns_pc_ref);
+		wait_for_completion(&pc_ref->confirm_done);
 	}
 }
 
@@ -618,20 +654,27 @@ static u16 nvmet_pr_preempt(struct nvmet_req *req,
 static void nvmet_pr_do_abort(struct work_struct *w)
 {
 	struct nvmet_req *req = container_of(w, struct nvmet_req, r.abort_work);
-	struct nvmet_pr_per_ctrl_ref *pc_ref;
+	struct nvmet_pr_per_ctrl_ref *pc_ref, *tmp;
 	struct nvmet_ns *ns = req->ns;
-	unsigned long idx;
+	bool ctrl_gone;
 
 	/*
 	 * The target does not support abort, just wait per-controller ref to 0.
 	 */
-	xa_for_each(&ns->pr_per_ctrl_refs, idx, pc_ref) {
-		if (percpu_ref_is_dying(&pc_ref->ref)) {
-			wait_for_completion(&pc_ref->free_done);
-			reinit_completion(&pc_ref->confirm_done);
-			reinit_completion(&pc_ref->free_done);
-			percpu_ref_resurrect(&pc_ref->ref);
-		}
+	list_for_each_entry_safe(pc_ref, tmp, &ns->pr.abort_list, abort_entry) {
+		wait_for_completion(&pc_ref->free_done);
+		reinit_completion(&pc_ref->confirm_done);
+		reinit_completion(&pc_ref->free_done);
+		percpu_ref_resurrect(&pc_ref->ref);
+
+		/* Off the list, the pc_ref belongs to its controller again. */
+		xa_lock(&ns->pr_per_ctrl_refs);
+		list_del_init(&pc_ref->abort_entry);
+		ctrl_gone = pc_ref->ctrl_gone;
+		xa_unlock(&ns->pr_per_ctrl_refs);
+
+		if (ctrl_gone)
+			nvmet_pr_free_pc_ref(pc_ref);
 	}
 
 	up(&ns->pr.pr_sem);
@@ -1052,6 +1095,8 @@ static int nvmet_pr_alloc_and_insert_pc_ref(struct nvmet_ns *ns,
 	init_completion(&pc_ref->free_done);
 	init_completion(&pc_ref->confirm_done);
 	uuid_copy(&pc_ref->hostid, hostid);
+	INIT_LIST_HEAD(&pc_ref->abort_entry);
+	pc_ref->ctrl_gone = false;
 
 	ret = xa_insert(&ns->pr_per_ctrl_refs, idx, pc_ref, GFP_KERNEL);
 	if (ret)
@@ -1067,7 +1112,6 @@ static int nvmet_pr_alloc_and_insert_pc_ref(struct nvmet_ns *ns,
 int nvmet_ctrl_init_pr(struct nvmet_ctrl *ctrl)
 {
 	struct nvmet_subsys *subsys = ctrl->subsys;
-	struct nvmet_pr_per_ctrl_ref *pc_ref;
 	struct nvmet_ns *ns = NULL;
 	unsigned long idx;
 	int ret;
@@ -1095,19 +1139,14 @@ int nvmet_ctrl_init_pr(struct nvmet_ctrl *ctrl)
 
 free_per_ctrl_refs:
 	nvmet_for_each_enabled_ns(&subsys->namespaces, idx, ns) {
-		if (ns->pr.enable) {
-			pc_ref = xa_erase(&ns->pr_per_ctrl_refs, ctrl->cntlid);
-			if (pc_ref)
-				percpu_ref_exit(&pc_ref->ref);
-			kfree(pc_ref);
-		}
+		if (ns->pr.enable)
+			nvmet_pr_erase_pc_ref(ns, ctrl->cntlid);
 	}
 	return ret;
 }
 
 void nvmet_ctrl_destroy_pr(struct nvmet_ctrl *ctrl)
 {
-	struct nvmet_pr_per_ctrl_ref *pc_ref;
 	struct nvmet_ns *ns;
 	unsigned long idx;
 
@@ -1115,12 +1154,8 @@ void nvmet_ctrl_destroy_pr(struct nvmet_ctrl *ctrl)
 	mutex_destroy(&ctrl->pr_log_mgr.lock);
 
 	nvmet_for_each_enabled_ns(&ctrl->subsys->namespaces, idx, ns) {
-		if (ns->pr.enable) {
-			pc_ref = xa_erase(&ns->pr_per_ctrl_refs, ctrl->cntlid);
-			if (pc_ref)
-				percpu_ref_exit(&pc_ref->ref);
-			kfree(pc_ref);
-		}
+		if (ns->pr.enable)
+			nvmet_pr_erase_pc_ref(ns, ctrl->cntlid);
 	}
 }
 
@@ -1136,6 +1171,7 @@ int nvmet_pr_init_ns(struct nvmet_ns *ns)
 	atomic_set(&ns->pr.generation, 0);
 	sema_init(&ns->pr.pr_sem, 1);
 	INIT_LIST_HEAD(&ns->pr.registrant_list);
+	INIT_LIST_HEAD(&ns->pr.abort_list);
 	ns->pr.notify_mask = 0;
 
 	xa_init(&ns->pr_per_ctrl_refs);
-- 
2.56.0

