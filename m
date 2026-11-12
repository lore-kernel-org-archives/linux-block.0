Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794460551;
	b=Sbz8Kv2o/xb3eCa9Ar+SltiBzzzxy9cIhxj7x8KfQQPGqKHAnVfEgJSrv5hGfv65YlV2
	 sb3eTzvMCOkp8fJu1dNlxnYb5Jg1AFvaLgfRWTbroMCHK33a18IJ2WHcNNLRJpSrNlKTl
	 ivKKJX/UgZvX8Va4R4OGEf6ZqvriwxoFCRP46FtNWLGb/AJtybUgQO1iMYLVjBcHe/FQL
	 3qKJgGZKLODQavTUzl/a+2/YMbP8SlGWgkAlx0+EaXXZBHBs6rIkAun12VZCed4srKCcD
	 wz2u3806OrBe3er4hmI/aamhAKReBlPbatdO4gg8z6TmnV8GdDs3ialTwiYTc4aJnVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794460551;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=oOfImB3qy0T90q2O/tjXznngWxo1sLRzTsMD5yze5WY=;
	b=BSVvmFeTNHbRNfqz8btvaD5etCJfq5XtxeL5kgY5VvFOA9t26A0hBpP7NERzkGHAxx9y
	 254yEUDam61v656/DkUYKTUNitD3NzlxqxehwBeILcVUfhuOzNtYHJ0HBJteDxCBM3Otg
	 /EYPdtbPrOOVfYAje/lpOIuXv9UApbdlo84Z3jvNYCstHgezv7mFGNO5msra6Txk801OE
	 LiGKMD0182MbWRoIsDJnAG+r+Q8x2IsbIuNQazobh1e2FvFhCzMngPSRKCdEjcKXBEiuP
	 Wo62/bkXNqyERDiK5Mgk3jIMmLSpcU4uv8nHju7FLO7zRTGUyfe8OkMAYoBtD+QvamQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gFRMwEKA;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49BF606A898
	for <linux-block@vger.kernel.org>; Thu, 12 Nov 2026 05:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E49BF606A898
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gFRMwEKA
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cdaf2073b0cso2298704a12.0
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 21:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794460550; x=1795065350; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oOfImB3qy0T90q2O/tjXznngWxo1sLRzTsMD5yze5WY=;
        b=gFRMwEKAJw5ZuY8NYu46R1Od99zHrRk1T0WQ0ByyqQxFWo/FO8b9BYmwtbPrDKiZ4I
         8iJCPyF+DH0SbIdKg5EZqRNnZ77zN0vEGA1kJhIaWIoWSEvmP3Zav+xWvkrahTbDNTP0
         DC3CuAjEV4udKvZxQwIiIOJIM/OGdzJW+nyM1i/D+lbRkFuBfzvF0ILfOL+XDEnivDJt
         I8JW59AuBx2T2ND73bowbCI162DDMy4rcDDza7wh2NWGxem38TL8iR8ofuG9jli+UW1n
         GKl2bJ8LUOuIR+FMxw5RFrZ5jkFhw7LMLhKjPHydwZ0aGZrDTZL49OEalhPI2/d69xw8
         36bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794460550; x=1795065350;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oOfImB3qy0T90q2O/tjXznngWxo1sLRzTsMD5yze5WY=;
        b=QvbLThFgNUM5TEhJqXsPqWqhc2GNEiMLkYVSuTtbS6UayBwEIEReXyiA/Q73SbvoyB
         wpp6DcO1HUmwQazQBXsVLMff2lnA6AnjTKlmI5Y8czWt659aXCQZjzHPZtc28ZASfQPJ
         RxvFF29JAwvMhk7GATcpOazG8zgLEWVNTmPwYccd2+xzig/DuCXPnVpd7mznpLfhmxLP
         c34WFF02NxVqj0oD7LFBAU3FJA26t2iY7eF8Vk1rAn8JMjf4+fVW/KDltksH2eyVccw7
         RyGQYxux14KRsxVCMdJtfMJRoWepgZSxMFKlTFWwC8EEy9goAs5Kt/lyBZf8+Be78RTL
         RuKg==
X-Forwarded-Encrypted: i=1; AL+hErHtDciD43Vj6DmtOw2VS/mByHCch5ndHb+JdD/ySbybNMFr1SQ16rey34R5xWBlc4GyIt38RXXks0XMzQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9LX/ieRAPE8jr4TJ9akHczGFbx/gVAaQfJOx+X1tlGz2F3KCCq
	H7daUEAjX3GUbEI/c8i7XxdXqShkru/7IBzsxy21tRd37tW2GwkAJfMpYKUDZOT6TJs4lNZPufP
	IqnyhNdm+Yr19LtWSGh4Bwg==
X-Received: from pgbo22.prod.google.com ([2002:a63:5a16:0:b0:cdb:5e5a:97a0])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3988:b0:3dd:d729:c62c with SMTP id adf61e73a8af0-3f2ff4d7c53mr4552825637.54.1794460549897;
 Wed, 11 Nov 2026 21:15:49 -0800 (PST)
Date: Thu, 12 Nov 2026 13:15:35 +0800
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
Message-ID: <20261112051542.1539779-3-stanleyjhu@google.com>
Subject: [PATCH 2/9] scsi: ufs: core: Defer link recovery on reserved PM
 command timeout
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

When a device management command sent by a PM callback times out,
ufshcd_eh_timed_out() runs ufshcd_link_recovery() inline:

1. The PM callback holds hba->dev_cmd.lock, a read lock on
   hba->clk_scaling_lock, and the only reserved tag while it waits
   for the command.
2. The command times out and ufshcd_eh_timed_out() resets the host.
3. The reset runs ufshcd_verify_dev_init(), which needs the same tag
   and lock, so host init fails with -ENOMEM in SDB mode and
   deadlocks on hba->dev_cmd.lock in MCQ mode.

Instead, stop the host controller, schedule the error handler and
complete the command with DID_TIME_OUT, so the PM callback releases
the tag and locks before recovery runs.

The remaining tail of ufshcd_eh_timed_out() then only handles SCSI
commands, so drop the reserved command branch there.

Fixes: 01d5e237b339 ("scsi: ufs: core: Handle PM commands timeout before SCSI EH")
Cc: stable@vger.kernel.org # 7.3.x: cd37a69c367b: scsi: ufs: core: Remove an always-false WARN_ONCE()
Cc: stable@vger.kernel.org # 7.3.x: 22d14117ec18: scsi: ufs: core: Add a helper for clearing hba->outstanding_reqs
Cc: stable@vger.kernel.org # 7.3.x: 3a7e551ae4bc: scsi: ufs: core: Fix double release in ufshcd_eh_timed_out()
Cc: stable@vger.kernel.org # 7.3.x
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 drivers/ufs/core/ufshcd.c | 60 +++++++++++++++++++++++++++++++++------
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index e9dcab35a4cd..6a5f5fa732d9 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -7147,7 +7147,7 @@ static void ufshcd_err_handler(struct work_struct *work)
 	spin_unlock_irqrestore(&hba->host->host_lock, flags);
 
 	/* Complete requests that have door-bell cleared by h/w */
-	if (!stop)
+	if (!stop && ufshcd_is_hba_active(hba))
 		ufshcd_complete_requests(hba, false);
 	spin_lock_irqsave(&hba->host->host_lock, flags);
 again:
@@ -9689,6 +9689,50 @@ static void ufshcd_async_scan(void *data, async_cookie_t cookie)
 		dev_err(hba->dev, "%s failed: %d\n", __func__, ret);
 }
 
+/*
+ * Claim @scmd before stopping the HBA in case normal completion raced with
+ * scsi_timeout(), then complete @scmd so the PM caller releases
+ * hba->dev_cmd.lock and the reserved tag before error recovery runs.
+ */
+static void ufshcd_eh_pm_cmd_timed_out(struct ufs_hba *hba,
+				       struct scsi_cmnd *scmd)
+{
+	struct request *rq = scsi_cmd_to_rq(scmd);
+	struct ufs_hw_queue *hwq;
+
+	if (!hba->mcq_enabled) {
+		if (!ufshcd_clear_outstanding_reqs(hba, BIT(rq->tag)))
+			return;
+		ufshcd_hba_stop(hba);
+		ufshcd_force_error_recovery(hba);
+		set_host_byte(scmd, DID_TIME_OUT);
+		scsi_done(scmd);
+		return;
+	}
+
+	hwq = ufshcd_mcq_req_to_hwq(hba, rq);
+	if (ufshcd_is_hba_active(hba))
+		ufshcd_mcq_poll_cqe_lock(hba, hwq);
+	scoped_guard(spinlock_irqsave, &hwq->cq_lock) {
+		if (test_bit(SCMD_STATE_COMPLETE, &scmd->state))
+			return;
+	}
+	spin_lock_irq(&hba->host->host_lock);
+	hba->force_reset = true;
+	if (hba->ufshcd_state != UFSHCD_STATE_ERROR)
+		hba->ufshcd_state = UFSHCD_STATE_EH_SCHEDULED_FATAL;
+	spin_unlock_irq(&hba->host->host_lock);
+	ufshcd_hba_stop(hba);
+	ufshcd_mcq_compl_all_cqes_lock(hba, hwq);
+	ufshcd_force_error_recovery(hba);
+	scoped_guard(spinlock_irqsave, &hwq->cq_lock) {
+		if (!test_bit(SCMD_STATE_COMPLETE, &scmd->state)) {
+			set_host_byte(scmd, DID_TIME_OUT);
+			scsi_done(scmd);
+		}
+	}
+}
+
 static enum scsi_timeout_action ufshcd_eh_timed_out(struct scsi_cmnd *scmd)
 {
 	struct ufs_hba *hba = shost_priv(scmd->device->host);
@@ -9698,6 +9742,11 @@ static enum scsi_timeout_action ufshcd_eh_timed_out(struct scsi_cmnd *scmd)
 		return SCSI_EH_NOT_HANDLED;
 	}
 
+	if (!ufshcd_is_scsi_cmd(scmd)) {
+		ufshcd_eh_pm_cmd_timed_out(hba, scmd);
+		return SCSI_EH_DONE;
+	}
+
 	/*
 	 * Handle the timeout directly to prevent a deadlock between
 	 * ufshcd_set_dev_pwr_mode() and ufshcd_err_handler().
@@ -9718,13 +9767,8 @@ static enum scsi_timeout_action ufshcd_eh_timed_out(struct scsi_cmnd *scmd)
 				return SCSI_EH_DONE;
 		}
 
-		if (ufshcd_is_scsi_cmd(scmd)) {
-			set_host_byte(scmd, DID_REQUEUE);
-			ufshcd_release_scsi_cmd(hba, scmd);
-		} else {
-			set_host_byte(scmd, DID_TIME_OUT);
-		}
-
+		set_host_byte(scmd, DID_REQUEUE);
+		ufshcd_release_scsi_cmd(hba, scmd);
 		scsi_done(scmd);
 	}
 
-- 
2.56.0.567.gdb80ae8cd5-goog

