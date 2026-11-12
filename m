Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794460567;
	b=Tpe9HxH7vJoNQF8ZbS/Mr12mh6uvvEWt0XGxzBwc4fuz0TPaoOVYp59n6Ou9EdGeHotW
	 dxvcaiV7Fd1l4s7FQABX9YaU9QDYgE0kT8jufBdnSvp+gAv9q2gtvchVq/OsbtaARSiGs
	 Aun7UJY/KaQeJ5Lhcs+KKuwwTL/cEwUk/q72ZLyJ23aPdh6ePbpAZ4y7wrdORu+4Ufnl9
	 wiMT6VgH/MvytNgTCx8a2dODCczOv1c2g2hssUQUh/GhCvFLsVdFEMoRL6A52G9+K1oSH
	 SF/Pu1tvNGXGxpy6z8Wp+SPVyYbNF51j3OPQS46WQXWBfNWvTAY3E82lg+69W2zeCIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794460567;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=tZzg7ubUk+V+CIt/Huk6ufMRnWoRe/VHcAYk4H9izW4=;
	b=NogIL5QlqWSnnV97o3TPtFngTvLMlAnr0iipzEDqqs9jtPfL0aPTHge0Wf70pqhjM20A
	 8LPBHcW/3kKibNuOJ5bdj6Ily7h/paORs+i0xNZDxNLRZdIXPuFNaNmzgQosrur4QKwF0
	 b23ImwhFouf+BgMpPBJO/FdI/q9ZyPRqbnsa8aC2WKWsTjLHCi/LiKNctNwoPd7KnLJFF
	 CCJkm5WFF3yScG4WeB7OtA/5ns+kfaSN4PLEni2zw01SsrNiEjuunnkMLs+TkiUe+envX
	 LhmwsuGEnm9Y/010oP+ihuYbgNW6DlBEwpGEuioUAtvcPxtCKCPWpj2F1c+MMKJZzpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Fw4lFIB6;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6035160A3818
	for <linux-block@vger.kernel.org>; Thu, 12 Nov 2026 05:16:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6035160A3818
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Fw4lFIB6
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-37628596fc9so348269eec.0
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 21:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794460566; x=1795065366; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tZzg7ubUk+V+CIt/Huk6ufMRnWoRe/VHcAYk4H9izW4=;
        b=Fw4lFIB6xE/RVqYfCT40YhQtWVtKDOUbCJtaA3XvsxM6qLQ+sMew/m3seNV7CO/tfd
         dlsDQt+4fyb63j390Ox3snLreRFTJl2nAwOUoGeuQ7Ly56f7d/4coY9m9zx7V/6nt6nU
         wfDCKxDJ7/5aPt20EiIdzXzKUl3+6DuomViJLqEXCjrdTNNRYwy7CXbdRKYDQh/d8CXi
         AEkgYtKCk5xAZBI9bGnnM712Z3Hoa1wEFv1dXC0U0Vg5FfXInXErJgthdix4yWqem7vX
         6BZiZBvnmBHrgzUFyu67YS8q+YiJeWqut0y7EYKXcmw2O1dYTp9Dg01MgDvvqwge6X5e
         amKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794460566; x=1795065366;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tZzg7ubUk+V+CIt/Huk6ufMRnWoRe/VHcAYk4H9izW4=;
        b=bgEkMBGAjb6HJ2dRSl0mOimXKbvaOX/aJYwUF+1yASoPjEmN8lJaNpYKfnv1RAwcnB
         qjjBzJY0mOV7qi1IvPK8+oQCdH6nSTXMbGixNcHy6U1b/r3Bsx6otG6NHtL4DTewBL/R
         AQv8InblXt2+fMvkXWChoGvWAjhRxNMOPCHm8NPvvOEpU/TtIhgh6nYJiVDYJq3hYv9Y
         oLvwej/GuDuU0E7Sn7VEb6excvrshXCKDZVpZ1abQaVw8zd/77Dw6uWR0fOwkR3aci0q
         W/c3X8b76SnDethldnvAPUOLjFC/Szd5x/R2g9Kq+OGS+8bBOF5Df5Ryslg9YEmhuQmu
         FFmw==
X-Forwarded-Encrypted: i=1; AL+hErGHP941KF/eA2UX3zfb9L9zQqZ9w91QJmwnhYnkmrVMar2GQzTjj+B7rUU9/5F1tfeSjLpJYtekqFGnaQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+QOBwsJFrORSme7/VcEkMw69n5lfS9qDYYoCB4+/7ek2IxQThM
	Q5TVxrB0etBx1txL75DbZGVljTPEV132RL1r0e3MRzHlkNoLRzYdekXpnGUTeKhauGTu5kaA6eT
	qxXYN+j0Y8GCdHUToPasuNg==
X-Received: from dybfc23.prod.google.com ([2002:a05:7300:3e97:b0:36d:3429:f79f])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:e2c:b0:369:ff7d:840 with SMTP id 5a478bee46e88-376861744bamr6909025eec.21.1794460565966;
 Wed, 11 Nov 2026 21:16:05 -0800 (PST)
Date: Thu, 12 Nov 2026 13:15:41 +0800
In-Reply-To: <20261112051542.1539779-1-stanleyjhu@google.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261112051542.1539779-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261112051542.1539779-9-stanleyjhu@google.com>
Subject: [PATCH 8/9] scsi: ufs: core: Wake suspended consumer queues after
 host reset
From: Stanley Jhu <stanleyjhu@google.com>
To: linux-scsi@vger.kernel.org, "Martin K. Petersen" <mkp@kernel.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
	Bart Van Assche <bvanassche@acm.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Avri Altman <avri.altman@sandisk.com>, Bean Huo <beanhuo@micron.com>, 
	Peter Wang <peter.wang@mediatek.com>, Stanley Chu <stanley.chu@mediatek.com>, 
	Can Guo <quic_cang@quicinc.com>, "Bao D. Nguyen" <quic_nguyenb@quicinc.com>, 
	Asutosh Das <quic_asutoshd@quicinc.com>, Hongjie Fang <hongjiefang@asrmicro.com>, 
	Praveen Talari <praveen.talari@oss.qualcomm.com>, HOYOUNG SEO <hy50.seo@samsung.com>, 
	Brian Kao <powenkao@google.com>, Jens Axboe <axboe@kernel.dk>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ufshcd_err_handling_prepare() now disables runtime PM of the UFS device
W-LUN, and ufshcd_err_handling_unprepare() enables it again and learns
whether a host reset in the error handler run succeeded.
ufshcd_recover_pm_error() wakes the runtime-suspended logical units
after a host reset only when hba->dev or the W-LUN has
power.runtime_error set, so I/O waiting on a runtime-suspended logical
unit stays blocked when both flags are clear:

1. I/O to a runtime-suspended logical unit blocks in
   __bio_queue_enter() and queues a runtime resume of the logical unit.
2. START STOP UNIT fails in the resume of the W-LUN supplier, and
   rpm_resume() rolls the logical unit back to RPM_SUSPENDED with
   power.runtime_error clear.
3. A later W-LUN runtime resume succeeds.
4. A fatal error makes ufshcd_err_handler() reset the host.
5. ufshcd_recover_pm_error() finds power.runtime_error clear on both
   devices and skips the wake loop.
6. The I/O stays blocked in __bio_queue_enter() until another request
   reaches the same queue.

Request a runtime resume of every runtime-suspended logical unit from
ufshcd_err_handling_unprepare() after every successful host reset,
whether or not power.runtime_error is set. Waking an idle logical unit
sends no SCSI command, and the logical unit returns to runtime suspend
after its autosuspend delay.

Requesting the resumes from ufshcd_err_handling_unprepare() needs two
more changes. First, issue them after pm_runtime_enable() on the W-LUN.
ufshcd_recover_pm_error() runs while W-LUN runtime PM is disabled, and
rpm_get_suppliers() ignores -EACCES from a disabled supplier. A logical
unit woken there resumes while its W-LUN supplier stays RPM_SUSPENDED.
Second, also runtime resume the UFS device W-LUN, synchronously and
before the logical units. ufshcd_err_handling_prepare() disables W-LUN
runtime PM without resuming the W-LUN, so the W-LUN stays RPM_SUSPENDED
after the reset when no logical unit is left runtime suspended to resume
it through the runtime PM device link. pm_request_resume() takes no
reference on hba->dev, so the pm_runtime_put(hba->dev) that follows
can runtime suspend hba->dev while the link is active and every
logical unit is runtime suspended.

Fixes: eef1d74bf88f ("PM: runtime: Only set runtime_error on suspend callback failures")
Cc: stable@vger.kernel.org # 7.3.x
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 drivers/ufs/core/ufshcd.c | 51 +++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 286ffb44772d..87d475e323b1 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -6961,6 +6961,33 @@ static bool ufshcd_err_handling_prepare(struct ufs_hba *hba)
 	return vops_resumed;
 }
 
+#ifdef CONFIG_PM
+/*
+ * A logical unit whose runtime resume failed against the W-LUN may still have
+ * bios waiting in blk_queue_enter(). Request a runtime resume for every
+ * suspended logical unit to unblock them. Resume the W-LUN first and
+ * synchronously. ufshcd_err_handling_prepare() disabled its runtime PM
+ * without resuming it, and the caller drops its hba->dev reference next.
+ */
+static void ufshcd_resume_sdevs_after_reset(struct ufs_hba *hba)
+{
+	struct scsi_device *sdev;
+	struct request_queue *q;
+
+	ufshcd_rpm_resume(hba);
+	shost_for_each_device(sdev, hba->host) {
+		q = sdev->request_queue;
+		if (q->dev && (q->rpm_status == RPM_SUSPENDED ||
+			       q->rpm_status == RPM_SUSPENDING))
+			pm_request_resume(q->dev);
+	}
+}
+#else
+static inline void ufshcd_resume_sdevs_after_reset(struct ufs_hba *hba)
+{
+}
+#endif
+
 static void ufshcd_err_handling_unprepare(struct ufs_hba *hba,
 					  bool vops_resumed, bool pm_recovered)
 {
@@ -6981,6 +7008,9 @@ static void ufshcd_err_handling_unprepare(struct ufs_hba *hba,
 	if (ufshcd_is_clkscaling_supported(hba))
 		ufshcd_clk_scaling_suspend(hba, false);
 	pm_runtime_enable(&hba->ufs_device_wlun->sdev_gendev);
+	/* The W-LUN and logical units resume only after pm_runtime_enable(). */
+	if (pm_recovered)
+		ufshcd_resume_sdevs_after_reset(hba);
 	ufshcd_rpm_put(hba);
 	pm_runtime_put(hba->dev);
 }
@@ -6998,10 +7028,6 @@ static inline bool ufshcd_err_handling_should_stop(struct ufs_hba *hba)
 static void ufshcd_recover_pm_error(struct ufs_hba *hba)
 {
 	struct scsi_target *starget = hba->ufs_device_wlun->sdev_target;
-	struct Scsi_Host *shost = hba->host;
-	struct scsi_device *sdev;
-	struct request_queue *q;
-	bool resume_sdev_queues = false;
 
 	hba->is_sys_suspended = false;
 
@@ -7012,7 +7038,6 @@ static void ufshcd_recover_pm_error(struct ufs_hba *hba)
 	if (hba->dev->power.runtime_error) {
 		/* hba->dev has no functional parent thus simplily set RPM_ACTIVE */
 		pm_runtime_set_active(hba->dev);
-		resume_sdev_queues = true;
 	}
 
 	if (hba->ufs_device_wlun->sdev_gendev.power.runtime_error) {
@@ -7023,22 +7048,6 @@ static void ufshcd_recover_pm_error(struct ufs_hba *hba)
 		pm_runtime_get_sync(&starget->dev);
 		pm_runtime_set_active(&hba->ufs_device_wlun->sdev_gendev);
 		pm_runtime_put_sync(&starget->dev);
-		resume_sdev_queues = true;
-	}
-
-	/*
-	 * If wlun device had runtime error, we also need to resume those
-	 * consumer scsi devices in case any of them has failed to be
-	 * resumed due to supplier runtime resume failure. This is to unblock
-	 * blk_queue_enter in case there are bios waiting inside it.
-	 */
-	if (resume_sdev_queues) {
-		shost_for_each_device(sdev, shost) {
-			q = sdev->request_queue;
-			if (q->dev && (q->rpm_status == RPM_SUSPENDED ||
-				       q->rpm_status == RPM_SUSPENDING))
-				pm_request_resume(q->dev);
-		}
 	}
 }
 #else
-- 
2.56.0.567.gdb80ae8cd5-goog

