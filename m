Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794460561;
	b=bfnzSCG/aoNN7kHz4c4TMC0TQRmtKcw58teMD3sgBSxgp6F3UhaYKhdp4HiodhLgj1GF
	 k6cOV+UKsdQNkHD4aQ3Ob92lxKqMh7UfmASu7BOwYhpILg8+7yKB3mkt9tNzo92YxHyEQ
	 su/wDLY+DPl2lkL/TuA3zapnrRj/bWhWx7VzZ8NQH69wdOKz2NXLLSsdCeNrkR2NBuhcm
	 dasQ47W2bnK25hqrxXEv9OCe9+7rA9NfODSvPEGDIs5E52iTgdkD4zLzbimvHtN1nXe+W
	 zeMWm406TxTWe9zkTHLFPy5pUkPhHVgMnKqcUfRPq5E/Htsp1Ixo5Z/D1OnA6Mmc6SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794460561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=38SEYBGC31BgpBsDoNzZVkowpJQe097lJNh7iv1j8Yo=;
	b=RFms1qdWDprgOgKq05oE0FQzG8I9dYzGUrLLg/94A8d/FQufV4jZORTRrpxyplCtlK+z
	 0JySFDEDC/dkRf3dLuIZ5si0zOWpKqHQ0cwECxcxc2WwhJQug6q7lOSqeo1vr3UYsewnW
	 aS01J0feQ8WlxIVZlNr5w7Is8OJr18LsftdFwGg2XFJxzrdkZls1vGRE9v1EPLQcQB+c1
	 Dxuc/rc7Cx/CnFCzE+FbIlN3/hwvsFzHVz+5vMJgpWh8Ha1+7i+AVBWexsc03PIUGr3C7
	 nWNacVK4dDs4zfPO1yLsGbr14oXDmaM4lV5xi6sBRvqkvttdwmhXIqBpiowDsK+6+KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UPDXCgSy;
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2962960A262A
	for <linux-block@vger.kernel.org>; Thu, 12 Nov 2026 05:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2962960A262A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UPDXCgSy
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cdd4dafdcf3so3386387a12.2
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 21:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794460560; x=1795065360; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=38SEYBGC31BgpBsDoNzZVkowpJQe097lJNh7iv1j8Yo=;
        b=UPDXCgSyLv3EbblpgXUGuGRXIxXUg/mP3ljpu04R8XwdbOynXLMukkUCUy9/T2ovba
         0pI3une0vD33vP+M/ehlzlCInQGUhTpm78+4tKJ+cLpSVpwfmlKMgHYaV1A2gK+pKchh
         jNM4mrfyTTCLNVpRbKJJyWBiPMU2SV7Yt3PiaYtUNJFnIvTOTX5pvpq4XqtHFJWoSIU1
         xDO/sfpG7a93VX8FpPOv5EZ4EDdoLz4TUuguGpgIXikrBbeZ2/9zf0tfcHywuFZl/gbx
         7bJj9Y+SQQ3VJ7cBN3FHQeo904xGWVZdmo23hK8809lA/FFdDcggeM8Xwm4iKt4+KbAx
         +2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794460560; x=1795065360;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=38SEYBGC31BgpBsDoNzZVkowpJQe097lJNh7iv1j8Yo=;
        b=V/PmEaN6GaPXTS1bT/6oFtZHSKfrL8BRbj5xS5eAc+GDDu6gq+eUSGT7X1iYEpBgJ8
         hV/uhN9ZFdgTA4/cQPjKwct+0XYlzeu2+QAUWihWdocUbFMAMPrTbGpS+8EzscPacvD+
         P1qtYr/G6LNMBL5tI3r6v4ImUVuQdA7qgywqjLjzGibCdZcGtYeCcseB5PRp8H2ILacS
         aaJEOuLr4kUml0PGvscxs02PcEvD0NAk0C8iwJzhrtSYq30G7ZTYe9F9gSiB0zYcBD4a
         euIxibR5hXUDNBAepTl0sfpIl2H1Juz4Gikap8SEALC+uumOQ9KVS1kH00jhIlwUuFPo
         /bqA==
X-Forwarded-Encrypted: i=1; AL+hErEXahhcUPQBn1hpuWO05a/aSIQoVr5BlF3H28Q2WoACFBZCD8RViswOCNZgBn16ZH2VBNDQ8X3orOn/3A==@vger.kernel.org
X-Gm-Message-State: APuU4Z84TdcbDqH6l1mFtjVn1R3xX4eCwGnG1xCfFdekXiM/F004zAXy
	H0kwB+Tl6e7q03illoHkd0x/qPeiX+VKRYv7e8V7P2SZikxhDCi5iTjZe+jSAmyABwAnymoPv9L
	EpNU6PnNtxdhaSl8fbP8Sew==
X-Received: from pfdr8.prod.google.com ([2002:aa7:8b88:0:b0:8a0:ecf:f0fa])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:6a06:b0:3ef:cbb4:4dc3 with SMTP id adf61e73a8af0-3f2fa09c4a1mr5109013637.5.1794460560288;
 Wed, 11 Nov 2026 21:16:00 -0800 (PST)
Date: Thu, 12 Nov 2026 13:15:39 +0800
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
Message-ID: <20261112051542.1539779-7-stanleyjhu@google.com>
Subject: [PATCH 6/9] block: Keep RPM_ACTIVE in blk_pre_runtime_resume() when
 already active
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

Since commit eef1d74bf88f ("PM: runtime: Only set runtime_error on
suspend callback failures"), a failed runtime resume leaves
dev->power.runtime_error at 0 with runtime_status set to RPM_SUSPENDED,
so later runtime resume requests run sdev_runtime_resume() again:

1. A runtime suspend increments q->pm_only from 0 to 1 and sets
   q->rpm_status to RPM_SUSPENDED.
2. The first runtime resume fails in the driver callback, and
   blk_post_runtime_resume() sets q->rpm_status to RPM_ACTIVE and calls
   blk_clear_pm_only(), decrementing q->pm_only from 1 to 0 so recovery
   commands can enter the queue (intended since
   commit 6e1fcab00a23 ("scsi: block: pm: Always set request queue
   runtime active in blk_post_runtime_resume()")).
3. A retried runtime resume calls blk_pre_runtime_resume(), which
   overwrites q->rpm_status from RPM_ACTIVE to RPM_RESUMING, so
   blk_post_runtime_resume() sees old_status != RPM_ACTIVE and calls
   blk_clear_pm_only() a second time without a matching
   blk_set_pm_only().
4. q->pm_only underflows from 0 to -1 (triggering WARN_ON_ONCE in
   blk_clear_pm_only()), blocking non-PM requests in blk_queue_enter()
   and __bio_queue_enter() while the device is RPM_ACTIVE, and the next
   runtime suspend increments q->pm_only from -1 to 0, letting non-PM
   requests dispatch while RPM_SUSPENDED. This hits the UFS device
   well-known LUN by default and SCSI disks with
   manage_runtime_start_stop enabled (ATA and FireWire sbp2 defaults).

Transition q->rpm_status to RPM_RESUMING in blk_pre_runtime_resume()
only when it is RPM_SUSPENDED, and call blk_clear_pm_only() in
blk_post_runtime_resume() only when old_status is RPM_RESUMING, pairing
each clear with a completed runtime suspend.

Fixes: eef1d74bf88f ("PM: runtime: Only set runtime_error on suspend callback failures")
Cc: stable@vger.kernel.org # 7.3.x
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 block/blk-pm.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/block/blk-pm.c b/block/blk-pm.c
index 8d3e052f91da..34cc7c5ca04e 100644
--- a/block/blk-pm.c
+++ b/block/blk-pm.c
@@ -142,7 +142,8 @@ EXPORT_SYMBOL(blk_post_runtime_suspend);
  *
  * Description:
  *    Update the queue's runtime status to RESUMING in preparation for the
- *    runtime resume of the device.
+ *    runtime resume of the device if the queue is runtime suspended, or keep
+ *    RPM_ACTIVE if a previous failed runtime resume already reactivated it.
  *
  *    This function should be called near the start of the device's
  *    runtime_resume callback.
@@ -153,7 +154,9 @@ void blk_pre_runtime_resume(struct request_queue *q)
 		return;
 
 	spin_lock_irq(&q->queue_lock);
-	q->rpm_status = RPM_RESUMING;
+	/* Keep RPM_ACTIVE if a prior failed resume reactivated the queue. */
+	if (q->rpm_status == RPM_SUSPENDED)
+		q->rpm_status = RPM_RESUMING;
 	spin_unlock_irq(&q->queue_lock);
 }
 EXPORT_SYMBOL(blk_pre_runtime_resume);
@@ -168,8 +171,8 @@ EXPORT_SYMBOL(blk_pre_runtime_resume);
  *    driver or error handler will need to communicate with the device.
  *
  *    This function should be called near the end of the device's
- *    runtime_resume callback to correct queue runtime PM status and re-enable
- *    peeking requests from the queue.
+ *    runtime_resume callback to mark the queue runtime active and clear
+ *    pm_only if the queue was resuming.
  */
 void blk_post_runtime_resume(struct request_queue *q)
 {
@@ -185,7 +188,7 @@ void blk_post_runtime_resume(struct request_queue *q)
 	pm_request_autosuspend(q->dev);
 	spin_unlock_irq(&q->queue_lock);
 
-	if (old_status != RPM_ACTIVE)
+	if (old_status == RPM_RESUMING)
 		blk_clear_pm_only(q);
 }
 EXPORT_SYMBOL(blk_post_runtime_resume);
-- 
2.56.0.567.gdb80ae8cd5-goog

