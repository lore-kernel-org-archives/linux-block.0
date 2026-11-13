Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794568330;
	b=pSsH3LMKoUIDsFq17Ik0RATvo+LJRax4aFYd5THrYfZZN3fvqmmJKtrjTJ9EXSNaqvON
	 MTMT5LYi6JLI9j87vjpPcUPHyW1b9zieo4ruJzxP78+iLkzB3iY0XIduJN04Oumdb0Xfv
	 IE23KYEQsSlT3pDCZOUy7nyutsFqbyipx+6KWYzpNxJF35IsDkq0PXwN5A6ikfkofzGmi
	 PoZ9xVPZwo3bGvFR0q3B5MyNx0oTJiEVb5fVYBqzICqREGLR17Nfb8ijdK8LRd9qLa9s3
	 L+/QYdtFwgrlcsrAvqXn3otMmbzXKMlQ6I/bKv1Tg1ERv65nVb+LW0kuRvdTTC9VE7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794568330;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=0crRzYpZW9dxW1wNlc5vxnIxQkrZjxGjYg3H3gi691g=;
	b=JJSN46y5qhK0od8j7IoomHcoplGltqQqT3ejo9vY0l3hFrrIqB6UcMfUWpdzDGw+CODH
	 cwqHFUfjOoG5lmND3DTi9nbvcE8xdImrcnalWh9+EmNkRVrCYpWKPLvZsBEYaT3on3Mnz
	 LLRRz3xrp/7GV76Le5OFE3TA0UweX5E6mjYCexzmHqy8slknmV9QsAkV3OzpCCQSYiCb/
	 kOh2AULb2zW0UP6o2hoqcLiHnDcZMZASHyOUmgXAavFYWU00yLctgDLQSmkifra7AHa1T
	 jBR3ms8/gyN47jZMf1XEBEuMEVm/85zMS7Sl0fkcLFrzOIUidvxeFfRD62vtEK0gaiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lt7uHD8l;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26B0606A893
	for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 11:12:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A26B0606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lt7uHD8l
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso1307728eec.1
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 03:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794568329; x=1795173129; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0crRzYpZW9dxW1wNlc5vxnIxQkrZjxGjYg3H3gi691g=;
        b=lt7uHD8l1toqas3ElXYiSGHB+RSr1qoum94HaRnGkl7zHQQ+rmAqvYjFlQ5WJ0ye4L
         HRdZjC8VkeJqUE+aHiBXrn3fhjwx9lPbN4+9iqrFU4m3xRvWksL2C6Rm9Iqq48bC0dJn
         V8XpHYLbWRZF+U3u8V9cx5vp9kSkjCTDnXg1RsqOu0SUEzgKKBSdwZfhnU/oB3KtKFHL
         Ti1htwVV1oLdCkXYAkQbzvCmzIZrkLALlgsOHqf6I1JwCXV3njJUTIIvwIPQXJHl/k7w
         2OIO3KpxSxhtPALsglrF1QZnqgp9YywSNzxCxAHieFwET8P8OxPcLHM0SxLLhh7ZU5+F
         /TzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794568329; x=1795173129;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0crRzYpZW9dxW1wNlc5vxnIxQkrZjxGjYg3H3gi691g=;
        b=tj8i03tInxvnJ8dGhgF9INDxarqqOI0T4MBZl04srKmg2u7UjIfHe4U9IaC/kyrs8e
         PQyPvFpvx/+/ZFjAfgYQJT0Z9rus6cfIeOHbnpLzTMpyo29ZaJj4pYhnTd8lwTywgeXC
         TDIaKyHGhdDDkIz1pVS/W9OX/cH3qhepKudKfsC4Rraz20hnhncpNk4BR5dpiv+Fl02g
         EzuD4uawc9vkIL10a4j7+8A/wYF+fQC8bAk4OKYzW4/HL9CAI05qx5rTIqpgGdSpN0YX
         iT2NT96DGpSJO75+5K6K5K4ocQzevaOXSmBDEfWr+QC4v0Za1bfyrRWGJjIgm0pweODY
         jqvQ==
X-Forwarded-Encrypted: i=1; AL+hErGyKuhlOOzc/DuZfbrZaYmhqRhnJrfV+7+pWI8XMidPjZaSuNZXgeWz5ozzvBtwMC34ajFwtAMj/aSDgg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/RqPEJkDCTjixyXZn2EwGq/pAuXvQufnItHjdSp1cynTbvz+aG
	XfNCg5EacwAPlHau8Qe3Z8OdwZ5F2UaeUrBDiG+3wAVhUkkiiWgU8Ppgj8E1oseKzPtitY0UtGM
	K6XEY3Ki7CqF8OQRj7Ie5CA==
X-Received: from dybhh46.prod.google.com ([2002:a05:7301:292e:b0:376:93cf:d6ce])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:d189:b0:36e:e349:f2cb with SMTP id 5a478bee46e88-3796628e28amr1996025eec.19.1794568328133;
 Fri, 13 Nov 2026 03:12:08 -0800 (PST)
Date: Fri, 13 Nov 2026 19:12:01 +0800
In-Reply-To: <20261113111202.3551341-1-stanleyjhu@google.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113111202.3551341-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261113111202.3551341-2-stanleyjhu@google.com>
Subject: [PATCH v2 1/2] scsi: ufs: core: Recover link in ufshcd_set_dev_pwr_mode()
 on timeout
From: Stanley Jhu <stanleyjhu@google.com>
To: linux-scsi@vger.kernel.org, "Martin K. Petersen" <mkp@kernel.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
	Bart Van Assche <bvanassche@acm.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Bean Huo <beanhuo@micron.com>, Peter Wang <peter.wang@mediatek.com>, 
	Brian Kao <powenkao@google.com>, Can Guo <can.guo@oss.qualcomm.com>, 
	"Bao D. Nguyen" <quic_nguyenb@quicinc.com>, Hongjie Fang <hongjiefang@asrmicro.com>, 
	Praveen Talari <praveen.talari@oss.qualcomm.com>, Hoyoung Seo <hy50.seo@samsung.com>, 
	John Garry <john.garry@linux.dev>, Hyeoncheol Jeong <hyenc.jeong@samsung.com>, 
	Jens Axboe <axboe@kernel.dk>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Stanley Jhu <stanleyjhu@google.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ufshcd_eh_timed_out() calls ufshcd_link_recovery() when a command
times out during a power management operation. Link recovery sends a
NOP OUT, which needs hba->dev_cmd.lock and the only reserved tag.

1. Runtime resume sends a query with the reserved tag while it holds
   hba->dev_cmd.lock.
2. The device does not answer and the query times out.
3. ufshcd_eh_timed_out() calls ufshcd_link_recovery().
4. In MCQ mode ufshcd_verify_dev_init() waits for hba->dev_cmd.lock
   while __ufshcd_wl_resume() waits for the query. Resume hangs.
5. In legacy mode the query completes but the timeout handler still
   holds the reserved tag. The NOP OUT fails with -ENOMEM and the
   host enters UFSHCD_STATE_ERROR.

Stop the host controller in ufshcd_eh_timed_out() and recover the
link in ufshcd_set_dev_pwr_mode(), which issues START STOP UNIT
without hba->dev_cmd.lock or the reserved tag. For modes other than
active, ufshcd_set_dev_pwr_mode() then fails and the caller aborts
the power transition.

Recovering the link there needs four more changes. First, START STOP
UNIT is completed with DID_TRANSPORT_FAILFAST and is not retried.
ufshcd_set_dev_pwr_mode() also recovers the link if START STOP UNIT
succeeds but the controller is disabled. Hosts with
UFSHCI_QUIRK_BROKEN_HCE do not use the HCE bit, so
ufshcd_set_dev_pwr_mode() checks only the timeout result on them.
Second, in MCQ mode ufshcd_eh_timed_out() reaps the completion queue
before it completes the command, so a late completion cannot complete
the tag twice. Third, a timed-out reserved request forces
ufshcd_err_handler(), because no power management caller recovers
after it. Fourth, in MCQ mode ufshcd_err_handler() does not poll the
completion queues while the controller is disabled.

Fixes: 01d5e237b339 ("scsi: ufs: core: Handle PM commands timeout before SCSI EH")
Cc: stable@vger.kernel.org # 7.2.x
Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 drivers/ufs/core/ufshcd.c | 43 ++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index ddc953b45ce9..0f5365bd90f0 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -7108,8 +7108,12 @@ static void ufshcd_err_handler(struct work_struct *work)
 	ufshcd_set_eh_in_progress(hba);
 	spin_unlock_irqrestore(&hba->host->host_lock, flags);
 
-	/* Complete requests that have door-bell cleared by h/w */
-	ufshcd_complete_requests(hba, false);
+	/*
+	 * Complete requests that have door-bell cleared by h/w.
+	 * CQTPy must not be read while the controller is disabled.
+	 */
+	if (!hba->mcq_enabled || ufshcd_is_hba_active(hba))
+		ufshcd_complete_requests(hba, false);
 	spin_lock_irqsave(&hba->host->host_lock, flags);
 again:
 	needs_restore = false;
@@ -9660,17 +9664,20 @@ static enum scsi_timeout_action ufshcd_eh_timed_out(struct scsi_cmnd *scmd)
 	}
 
 	/*
-	 * Handle the timeout directly to prevent a deadlock between
-	 * ufshcd_set_dev_pwr_mode() and ufshcd_err_handler().
+	 * Stop the host controller so that @scmd can be completed here.
+	 * ufshcd_set_dev_pwr_mode() recovers the link for START STOP
+	 * UNIT. ufshcd_err_handler() recovers it for other commands.
 	 */
-	ufshcd_link_recovery(hba);
-	dev_info(hba->dev, "%s() finished; outstanding_tasks = %#lx.\n",
-		 __func__, hba->outstanding_tasks);
+	ufshcd_hba_stop(hba);
+	if (!ufshcd_is_scsi_cmd(scmd))
+		ufshcd_force_error_recovery(hba);
+	if (hba->mcq_enabled) {
+		struct ufs_hw_queue *hwq =
+			ufshcd_mcq_req_to_hwq(hba, scsi_cmd_to_rq(scmd));
+
+		ufshcd_mcq_compl_all_cqes_lock(hba, hwq);
+	}
 
-	/*
-	 * ufshcd_link_recovery() may already have completed @scmd, e.g. via
-	 * the existing MCQ force-completion path.
-	 */
 	if (!test_bit(SCMD_STATE_COMPLETE, &scmd->state)) {
 		if (!hba->mcq_enabled) {
 			struct request *rq = scsi_cmd_to_rq(scmd);
@@ -9680,7 +9687,7 @@ static enum scsi_timeout_action ufshcd_eh_timed_out(struct scsi_cmnd *scmd)
 		}
 
 		if (ufshcd_is_scsi_cmd(scmd)) {
-			set_host_byte(scmd, DID_REQUEUE);
+			set_host_byte(scmd, DID_TRANSPORT_FAILFAST);
 			ufshcd_release_scsi_cmd(hba, scmd);
 		} else {
 			set_host_byte(scmd, DID_TIME_OUT);
@@ -10137,6 +10144,9 @@ static int ufshcd_execute_start_stop(struct scsi_device *sdev,
 {
 	const unsigned char cdb[6] = { START_STOP, 0, 0, 0, pwr_mode << 4, 0 };
 	struct scsi_failure failure_defs[] = {
+		{
+			.result = DID_TRANSPORT_FAILFAST << 16,
+		},
 		{
 			.allowed = 2,
 			.result = SCMD_FAILURE_RESULT_ANY,
@@ -10172,6 +10182,7 @@ static int ufshcd_set_dev_pwr_mode(struct ufs_hba *hba,
 	struct scsi_sense_hdr sshdr;
 	struct scsi_device *sdp;
 	unsigned long flags;
+	bool fenced;
 	int ret;
 
 	spin_lock_irqsave(&hba->host->host_lock, flags);
@@ -10199,6 +10210,7 @@ static int ufshcd_set_dev_pwr_mode(struct ufs_hba *hba,
 	 * already suspended childs.
 	 */
 	ret = ufshcd_execute_start_stop(sdp, pwr_mode, &sshdr);
+	fenced = ret > 0 && host_byte(ret) == DID_TRANSPORT_FAILFAST;
 	if (ret) {
 		sdev_printk(KERN_WARNING, sdp,
 			    "START_STOP failed for power mode: %d, result %x\n",
@@ -10212,6 +10224,13 @@ static int ufshcd_set_dev_pwr_mode(struct ufs_hba *hba,
 		hba->curr_dev_pwr_mode = pwr_mode;
 	}
 
+	if (fenced || (!(hba->quirks & UFSHCI_QUIRK_BROKEN_HCE) &&
+		       !ufshcd_is_hba_active(hba))) {
+		ret = ufshcd_link_recovery(hba);
+		if (!ret && hba->curr_dev_pwr_mode != pwr_mode)
+			ret = -EIO;
+	}
+
 	scsi_device_put(sdp);
 	WRITE_ONCE(hba->host->eh_noresume, 0);
 	return ret;
-- 
2.56.0.611.g1030f0b940-goog

