Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794460570;
	b=oMgq9Zwen7Ca5DoG9mWr9j7L3ajcIh4tUgJg9jQ7ieprJj+KHa7LTmbks0KXKOxOjiBz
	 O4xRelHncOMgmue6u6AYgSiu3mQfFNx20Va0dWr1LKf58w3+WMeBzHRrdV3bbZWsN4gnr
	 H1BD9KCvx5nghkd2GOtIHPBXdsuOuu4y/DbNPnTPkMDF7HMXQtudZ8wwNhYfTq0wGkRVc
	 UMkvjc6iX+IER87Cy1X26mWDdx6xYc827KpJUddEVAkB3idIZrW1QaS+dmHlPqvVzUekp
	 VjHOOI3hOnEz0ZEcCQV0E98ox2bittFCjSf1wo3ffFcP6oUcVh7u2hkXfNc5hNMN9/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794460570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=dZZYA4aJZW24rfHpvdxAeVS1QTPuYpP8ld4MwD2MKno=;
	b=aR1fIBCxt3BOtp5CBTgu/Veyh9W6ARbP0axRiVJL671uHJwZeY65Fg20154maOemAdCz
	 zm8UCV6g2uxFx8a9iH6RGPGOQiAF9dX5cI0PaKWlDKAsvr4eH3B/MwbxIyRMPb8CMo4HK
	 pGw51X0s5JvLNi2MQl5pVdrz0tOJRWIyb/WyPrDnvUuIBCklmfQcP3phRTbv9bCG/ZgIQ
	 nRL/7IxnTIfxnzms0nqOXpXaw5hpy2g98UWTE/qZqGwekbEZrNKzVm5pq1w/55gDVytMI
	 5jwlUO9EUjHIjjbd8y3Z6LPZBDTTXOm6gGFT/gn81cTaxcznRO3wb+cwg2Ml+OOOXnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YGZlFE86;
	arc=none smtp.remote-ip=209.85.210.198
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF77160A3827
	for <linux-block@vger.kernel.org>; Thu, 12 Nov 2026 05:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF77160A3827
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YGZlFE86
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-89f84753b43so3088909b3a.1
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 21:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794460569; x=1795065369; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dZZYA4aJZW24rfHpvdxAeVS1QTPuYpP8ld4MwD2MKno=;
        b=YGZlFE86oCC8gTSIurY4Bbc+mlwEbzfIBeVYT/JpedYaLTMsHLiUZDUSa6GVE8w8dV
         0B0dW2Lp0x7o5s1LRP2jkD0hyTVMikf8S/iVC1SU60/7WR5wA1jwHMwSKGyls4p9mrhd
         92h1tKySJMJ5i4U5mOrroXghsTnyhsKr55PTMwKNXkI8PtaWIwIXHD+9Np5F97Jpyz+a
         NvLEZc+LszDp/F8BWxtFx08mZO5aHCJrNS24BCJHoBQfzw/W8KgZAr1LvUqKEXflpgH7
         p1TtSTcV8nJGpdGN+i8Q6MfuEy/md8tvGKWJqcdUtmUNOVRti5//CToz/xemrMncfh2C
         GiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794460569; x=1795065369;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dZZYA4aJZW24rfHpvdxAeVS1QTPuYpP8ld4MwD2MKno=;
        b=yh5YdQXWn45Pn4+KbOXg+qptI7y1uo5na9SaNempQfhWnGebWPRbzo2bCdADlpDCnw
         Je2ZAChR6X9teb/Q3ayqmAUyLR4y5+BN9tK2NAyzOS/IzxMDyn3IpDc3BBJRMaDmirie
         x9+ogVbVz+FsTLz4rj3P2di4UinLx6102E5NQjaQll6dTfE3tBLuQYWCt7pqNMlERHpw
         e100oqHrfX91cwALg5RLA7bxx309rqOnXGFY0xi0THcIkmNuIXwBUDjaPuyejpWxznxd
         lvMkuvML/bUIKRx4yvKWKSid6B686BcQCUjIh80pJ1DAfMjKFFPF3XB9QJIu+/FpcvOX
         B27Q==
X-Forwarded-Encrypted: i=1; AL+hErHW4gvnfgJo8i1gOZxv/cfHM2x+KI5QOuMNVk85JfEiNydlytYJngtZQeinHZLP+6lP0PZrIZ49JWEthA==@vger.kernel.org
X-Gm-Message-State: APuU4Z93SK3MNT3OpR+69IvuzsBG2VTK80OcpNXRs8AP7ZIXxI4Tg2jD
	WMnxtcsTHmt+dl+ZsDK6BUoIdEv5bjk+a7ILLWCQZ7zBrk/ZQLT2YVLo1RgMSxEO7ThK4W4hqU7
	HEfzuPLgYCuDH+IjGVFTRQg==
X-Received: from pfbci8.prod.google.com ([2002:a05:6a00:28c8:b0:88f:dade:52e])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:428f:b0:886:73c9:89d7 with SMTP id d2e1a72fcca58-8bc1c499e3fmr4256425b3a.11.1794460568903;
 Wed, 11 Nov 2026 21:16:08 -0800 (PST)
Date: Thu, 12 Nov 2026 13:15:42 +0800
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
Message-ID: <20261112051542.1539779-10-stanleyjhu@google.com>
Subject: [PATCH 9/9] scsi: ufs: core: Do not recover the link concurrently
 with a PM callback
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

From: Brian Kao <powenkao@google.com>

Commit f966e02ae521 ("scsi: ufs: core: Fix runtime suspend error
deadlock") made ufshcd_err_handler() call ufshcd_link_recovery() and
return early if hba->pm_op_in_progress is set. Commit e23ef4f22db3
("scsi: ufs: core: Fix error handler host_sem issue") moved that check
ahead of down(&hba->host_sem). The patch "scsi: ufs: core: Limit early
link recovery in the error handler to runtime PM" restricts that early
path to ufshcd_in_wl_rpm_callback() and notes in its cover
letter that during runtime resume it can still run concurrently with
__ufshcd_wl_resume(), and removing it there needs a closer look at the
deadlock that it avoids.

With this shortcut, when a fatal UIC error arrives while
__ufshcd_wl_resume() is in ufshcd_bkops_ctrl(), ufshcd_err_handler()
calls ufshcd_link_recovery() -> ufshcd_host_reset_and_restore() without
holding host_sem or waiting for the PM callback, putting the host
controller into a reset (non-working) state while ufshcd_issue_dev_cmd()
on the resume thread is still sending query requests and accessing the
controller:

  Process A (PM callback, e.g. runtime resume):
  __ufshcd_wl_resume()
    -> ufshcd_bkops_ctrl()
      -> ufshcd_query_attr_retry()
        -> ufshcd_exec_dev_cmd()
          -> ufshcd_issue_dev_cmd()
            (accesses controller while in reset state)

  Process B (UFS error handler, triggered by UIC error):
  ufshcd_err_handler()
    -> if (ufshcd_in_wl_rpm_callback(hba))
      -> ufshcd_link_recovery()
        -> ufshcd_host_reset_and_restore()
          (puts controller into reset state)

Remove the early link recovery shortcut and
ufshcd_in_wl_rpm_callback() from ufshcd_err_handler() so that
error handling waits in ufshcd_err_handling_prepare() for a runtime PM
callback and on hba->host_sem for a system PM callback to finish before
resetting the controller. This does not reintroduce the runtime suspend
deadlock because:
- If the state is UFSHCD_STATE_EH_SCHEDULED_FATAL, ufshcd_queuecommand()
  fails SCSI commands such as START STOP UNIT sent from a PM callback
  immediately with DID_BAD_TARGET, and ufshcd_issue_dev_cmd() fails
  reserved device management commands immediately with -EIO, while any
  already in-flight PM command timeout is completed by
  ufshcd_eh_timed_out().
- If the state is UFSHCD_STATE_EH_SCHEDULED_NON_FATAL,
  ufshcd_queuecommand() still dispatches START STOP UNIT because
  eh_in_progress is not set yet.
- If a dispatched START STOP UNIT times out without a pending fatal
  error, ufshcd_eh_timed_out() recovers the link directly and returns
  SCSI_EH_DONE without waiting on eh_work.
- Runtime suspend errors call ufshcd_force_error_recovery() and return
  -EBUSY.
- Runtime resume (__ufshcd_wl_resume()) does not wait on eh_work or
  host_sem. A hibern8 exit failure recovers on the PM thread, a START
  STOP UNIT failure returns an error, and query errors are ignored.

Removing the shortcut relies on the companion patches in this series,
which complete PM command timeouts in ufshcd_eh_timed_out() before
reaching SCSI error handling and disable W-LUN runtime PM in
ufshcd_err_handling_prepare().

Fixes: f966e02ae521 ("scsi: ufs: core: Fix runtime suspend error deadlock")
Fixes: e23ef4f22db3 ("scsi: ufs: core: Fix error handler host_sem issue")
Cc: stable@vger.kernel.org # 7.3.x
Signed-off-by: Brian Kao <powenkao@google.com>
[stanleyjhu: rebased onto "scsi: ufs: core: Limit early link recovery
 in the error handler to runtime PM", clarified the reserved command
 path in the commit message, and limited Cc: stable to 7.3.x]
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 drivers/ufs/core/ufshcd.c | 39 ---------------------------------------
 1 file changed, 39 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 87d475e323b1..1aecf55c0646 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -7120,23 +7120,6 @@ static bool ufshcd_abort_all(struct ufs_hba *hba)
 	return ret != 0;
 }
 
-/*
- * Whether a runtime PM callback of the WLUN runs __ufshcd_wl_suspend() or
- * __ufshcd_wl_resume().
- */
-static bool ufshcd_in_wl_rpm_callback(struct ufs_hba *hba)
-{
-#ifdef CONFIG_PM
-	enum rpm_status status =
-		READ_ONCE(hba->ufs_device_wlun->sdev_gendev.power.runtime_status);
-
-	return READ_ONCE(hba->pm_op_in_progress) &&
-	       (status == RPM_SUSPENDING || status == RPM_RESUMING);
-#else
-	return false;
-#endif
-}
-
 /**
  * ufshcd_err_handler - handle UFS errors that require s/w attention
  * @work: pointer to work structure
@@ -7163,28 +7146,6 @@ static void ufshcd_err_handler(struct work_struct *work)
 		 hba->saved_uic_err, hba->force_reset,
 		 ufshcd_is_link_broken(hba) ? "; link is broken" : "");
 
-	if (hba->ufs_device_wlun) {
-		/*
-		 * Use ufshcd_rpm_get_noresume() here to safely perform link
-		 * recovery even if an error occurs during runtime suspend or
-		 * runtime resume. This avoids potential deadlocks that could
-		 * happen if we tried to resume the device while a PM operation
-		 * is already in progress.
-		 *
-		 * Do this only while the PM callbacks run for a runtime PM
-		 * operation. The system PM and poweroff callbacks hold
-		 * host_sem, and shutting_down makes the regular path below
-		 * stop, so it does not reset the link concurrently with them.
-		 */
-		ufshcd_rpm_get_noresume(hba);
-		if (ufshcd_in_wl_rpm_callback(hba)) {
-			ufshcd_link_recovery(hba);
-			ufshcd_rpm_put(hba);
-			return;
-		}
-		ufshcd_rpm_put(hba);
-	}
-
 	down(&hba->host_sem);
 	spin_lock_irqsave(&hba->host->host_lock, flags);
 	if (ufshcd_err_handling_should_stop(hba)) {
-- 
2.56.0.567.gdb80ae8cd5-goog

