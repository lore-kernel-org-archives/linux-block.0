Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205981;
	b=0t0+PI9FH1AgO6DUsjsDprSpUNl/vQEbZTC0mMBkxQCbik3eJoXibk4SSAGRqx0hZdAE
	 X1R7u1c4fL2qpB20SGRMbJ2JHe+K4RmIxsYvQ8Wxya53FPeuEDdSKdHggBctaxg0yL5DX
	 3XwurnI7Tu13sN3xx8Rr3faNyxStmtw6lvrP1/h6GDG1qFnv0AK/YHMCGBGrE42l6rGqq
	 hcV8FMmVtG0iM6qP4sJb7kzk4BtZlpVEtYoMFz/apq71IwZPLC+VzEV46Y70UEqGjdQZk
	 dQ0ybe2hrRultbrywXBMAAFUiw3qF3CvmHXVumnvuTipO+OqLdx2ZZZvkh9LPRuRWzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205981;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ondc5tsv3qogDM/jxYbmSwDoPGsdyv7HYZbmzdedVxQ=;
	b=fMtLnNvaZ5qECrHW0NJDqKTjyKt+mHCvTcZZyRU8R2sZy0K118wI5e4DShHc+WBAaNFD
	 Xx8PQbiwJy5XfPnP+wA00W+H8narI+lRwzcXme8H2Y8W2cymZGdorgAV50rTBryjzmEUR
	 vgHUEkjCutCghUWkfQBd/4YiiTJxxS5Tz1U+rnyX+t67PTF+3W+N0LRxEHRb+OgYX4ICx
	 NvK75o0hHCwV1iDW72U+DM+rvRZrOmNyXqQTlRaTmRSKTE4FYK4vTBhLzhPpJkiABJDiW
	 IAJYIqDlKytGC6gHrkn+uB83ieX+y/znLB0vnlwelKHlgSfNIUcES2tEu1N8DbOSDyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=dEBNQszm;
	arc=none smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0AD60A260F
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B0AD60A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=dEBNQszm
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6de1ca1b05aso861705eaf.0
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205979; x=1793810779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ondc5tsv3qogDM/jxYbmSwDoPGsdyv7HYZbmzdedVxQ=;
        b=dEBNQszm3p1p5uqjuTwL+L0kpKN1ebcF2Hlvis0P2rFl3ppyt2VyUS0CzXhynmoSfu
         4IeR3FrscROYDKKcQbfGkJ+d2mo368LDuN8SoRBWKNqQlOfK4x5RYxNL1j1lJYEGfKuJ
         BflhfQBscX1avAHK5gNL7Eqt1XOz58omFAkKrhnygtICbhJzWLKeHLxEu2g4JJi8+M0n
         yBBD+hEqWuAMFyJtyPd4IYigp6JVDb/zumGdZCx0cbKho2L4FoGNLGZFZZCPgZr4+LDa
         MiyKNaoQQcPVuY7J4ViLsn6cLvcc9J0n+is4y81scMibXD8DeAY9wn0qw42aMeM8VoBU
         cGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205979; x=1793810779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ondc5tsv3qogDM/jxYbmSwDoPGsdyv7HYZbmzdedVxQ=;
        b=LsXFa+jlfHsBlfBl0jslq4NlUmLJJMV3BdgomXid6U5X62mbWnHDAVcYubY4BANwYk
         1jdHFNdxegfGZqfvTNVA1eoAb/llISttKuV6HU4aXjkZvD8U+4XfeW5xRW2734LpmUk2
         vNvYkNLM7Z6JSN7bbD0j34YbcGp0GkwMTgpyN3gdHJYY8GMfj97c0r1f/tV+yQPV2iDB
         COSfa4YhesjALks2jzAvmbzG1JQbNZ6S8e/lIWOkWuPcd4J7P4+BFsYkaJSDjz7YsdHH
         VAsviOfupI69oqY6uBw0SnxQgmgmIr6YKj2Wq9iclI2ZhQDH2IQvYrC4yNPym/+kcjlQ
         4boA==
X-Gm-Message-State: AFq9FYIbbE0kez3JlPJtHGmlnC/VDb84l7nQ354LXfyiJ6BEiQAVvtAo
	193J5E9kh5eWkKlNbpIwHlqidPFNTB2d6pSaHq/lx6nwTv/XpP4XGY7byW2310/mG1+S70qlAEj
	1NQzAclc=
X-Gm-Gg: AYBFou0CzQ0r91CD2ThxfPjLJj28M/aUjrkHUYB3aGZ9gsuW/tKLpR4czx0gQQt+dMH
	/KuAESdfrYesauPHXAEnz+SrmkJRhk3xRmTqHSIoH3qLoysyw2AZzHUyve9ELEj7tXI4M0BtJQM
	cYTo5/hm+x/QOVLmhYRJFPPcm3sJ/ipXrKSQmjG5YJJp7UEK7h6oo7aWhAzY7Y5CkcA4QTwyAui
	Q2+dxYgVQ5v3/WySU9r3WHkjZJZkfxDufFJZXmMPRtKQp4opfXoqTA4jkSUmwrTojCkfgOQ9uTJ
	YT6TQuLgaRuzuNnI/T8lKVmMQIs8LnOhMGODZuvK7rkPWo7eUKvSkM8KfVPciCpUmL/ru+N0ket
	5RBTLPX/UDAC+V5oU7E01IXA5xoOCTJuswc0rDLsDTYl0KVBFQGarpjHdclLw8fc6zZ6VKhfYk2
	0NqN+4kVyyK7G0ToJzYGsgM/oACS6Ra6DwZ7I6wtikRVZuVQHd+3FMXO2LLeRfRgPJJQoJZlphw
	OP0YYR2U++Hjx639xI45bx+ZvLcsfo4teExM3YEp85zwna3jUcjQnhEyjz52+LFqPDVTkeAhyyf
	MmslSLUyCD4Ar0ilvaqLw50BUAKT5gmCK1pYcYo5WHtR3JVyRDWH9c/XL6Web7YprUos/YHktg=
	=
X-Received: by 2002:a05:6820:f014:b0:6c9:80d8:a201 with SMTP id 006d021491bc7-713eeb53676mr1623334eaf.62.1793205979437;
        Wed, 28 Oct 2026 09:46:19 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:46:18 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 94/98] nvmet: wait only for executing I/O in preempt and abort
Date: Wed, 28 Oct 2026 10:42:37 -0600
Message-ID: <20261028164415.1262013-95-axboe@kernel.dk>
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

nvmet_parse_io_cmd() takes the pc_ref for an I/O command as soon as it's
parsed, and "preempt and abort" waits for all pc_refs of the preempted
controllers before it releases pr_sem. But a write that still needs its
data can't complete without the host sending it and without the
transport context receiving it, and that same context is where Register,
Acquire and Release sleep on pr_sem. So a host that sends a write and
holds the data back, then preempt and abort with its own key, then
Register on the same queue, deadlocks io_work, the abort work and the
write with each other. Two well-behaved hosts get there by accident
when one fences the other while it re-registers under I/O. The
connection can't be torn down, the namespace can't be disabled, and
with nvmet_config_sem held across that, nobody can connect.

Take the pc_ref when the transport calls ->execute(), once all the data
is there: nvmet_parse_io_cmd() stashes the real execute method and
installs nvmet_pr_execute_io(), which gets the reference, rechecks the
reservation access since the host may have lost it since parse time,
and calls through. Preempt and abort then only waits for commands that
have started executing, which need neither the host nor the transport
to finish. A write whose data arrives after the abort now fails with
Reservation Conflict where it was previously executed, that's the
input the hang needs.

Fixes: 5a47c2080a73 ("nvmet: support reservation feature")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/core.c  |  2 +-
 drivers/nvme/target/nvmet.h |  4 +++-
 drivers/nvme/target/pr.c    | 42 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index f96b21257169..b78a4d4eb838 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1171,7 +1171,7 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 		if (ret)
 			return ret;
 
-		ret = nvmet_pr_get_ns_pc_ref(req);
+		nvmet_pr_set_execute(req);
 	}
 	return ret;
 }
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 9e8fbb2d1fc1..29105e2a7022 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -517,6 +517,8 @@ struct nvmet_req {
 	struct nvmet_port	*port;
 
 	void (*execute)(struct nvmet_req *req);
+	/* what nvmet_pr_execute_io() calls once it has the pc_ref */
+	void (*pr_execute)(struct nvmet_req *req);
 	const struct nvmet_fabrics_ops *ops;
 
 	struct pci_dev		*p2p_dev;
@@ -1051,7 +1053,7 @@ void nvmet_pr_exit_ns(struct nvmet_ns *ns);
 void nvmet_execute_get_log_page_resv(struct nvmet_req *req);
 u16 nvmet_set_feat_resv_notif_mask(struct nvmet_req *req, u32 mask);
 u16 nvmet_get_feat_resv_notif_mask(struct nvmet_req *req);
-u16 nvmet_pr_get_ns_pc_ref(struct nvmet_req *req);
+void nvmet_pr_set_execute(struct nvmet_req *req);
 static inline void nvmet_pr_put_ns_pc_ref(struct nvmet_pr_per_ctrl_ref *pc_ref)
 {
 	percpu_ref_put(&pc_ref->ref);
diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
index 1a03f74c2e14..798f5ce9011f 100644
--- a/drivers/nvme/target/pr.c
+++ b/drivers/nvme/target/pr.c
@@ -1060,7 +1060,7 @@ u16 nvmet_pr_check_cmd_access(struct nvmet_req *req)
 	return status;
 }
 
-u16 nvmet_pr_get_ns_pc_ref(struct nvmet_req *req)
+static u16 nvmet_pr_get_ns_pc_ref(struct nvmet_req *req)
 {
 	struct nvmet_pr_per_ctrl_ref *pc_ref;
 
@@ -1072,6 +1072,46 @@ u16 nvmet_pr_get_ns_pc_ref(struct nvmet_req *req)
 	return NVME_SC_SUCCESS;
 }
 
+static void nvmet_pr_execute_io(struct nvmet_req *req)
+{
+	u16 status;
+
+	status = nvmet_pr_get_ns_pc_ref(req);
+	if (!status) {
+		/*
+		 * The host can have lost its registration since the command was
+		 * parsed. A get that succeeds after "preempt and abort" has
+		 * resurrected the pc_ref has to see that. In percpu mode the
+		 * get orders no later load, so this pairs with the
+		 * smp_store_release() in __percpu_ref_switch_to_percpu(). While
+		 * the resurrect is under way the get is a fully ordered
+		 * atomic_long_inc_not_zero(). queue_work() in
+		 * nvmet_execute_pr_acquire() orders the unregistration before
+		 * the resurrect.
+		 */
+		smp_rmb();
+		status = nvmet_pr_check_cmd_access(req);
+	}
+	if (status) {
+		nvmet_req_complete(req, status);
+		return;
+	}
+
+	req->pr_execute(req);
+}
+
+/*
+ * "Preempt and abort" waits for the commands that hold a pc_ref. Until the
+ * transport calls ->execute(), the end of a command can depend on the host,
+ * which may still have to send the data, and on the context and the resources
+ * of the transport. So a command gets its pc_ref only then.
+ */
+void nvmet_pr_set_execute(struct nvmet_req *req)
+{
+	req->pr_execute = req->execute;
+	req->execute = nvmet_pr_execute_io;
+}
+
 static void nvmet_pr_ctrl_ns_all_cmds_done(struct percpu_ref *ref)
 {
 	struct nvmet_pr_per_ctrl_ref *pc_ref =
-- 
2.56.0

