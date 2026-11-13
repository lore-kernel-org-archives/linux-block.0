Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794568332;
	b=3mzFJlfd+sdZedyuPQH+NsAjoSZawzgc3wZRuHnjohoxnZj0csVL9yR/raXT87KXZFi+
	 jh8+Cf4sJBHi+sJK2eFKSPHGKzV/MbnXP7UXMwwGVYCnGctusg5FJPhtiec2dmPG+qSlY
	 sYhbYEgQpNGkt06QDvy7hoPjbAofcKWym5hP+vTkaG04mfNA/OnrrvgMLoSHgi3fHDAx0
	 tmu/4gBXPqCZMqgSDa+tWIXZnGFT3B26H+1N2a62NjLNl1LU+MxEDzvOyVOg5UF12f6ql
	 ZpgyA/jlZKaTghA6nFIqT/7QQN/St7LtYAT9ARiyC9Nb2e5h9GZplArbzE/NiKZZ2bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794568332;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=squHT7DGI/tJX079kKnSehmb9JdmTDTTr8xWVbVGWdw=;
	b=ciCDm7WrZkWe2a+BDnsQJgGo3MNFK/1vOWXsHCKKa9PgSluZ8QM9+Dv6q45/aFIqeleJ
	 obocHivImjXwNWrZOKg/6CTqfDWoEpkSebjIFFWurwqpy7iMJC9/5s7WnXpNIltm4+T1i
	 wYynlBKtxcHbt5/UABDaGFjgTgpS1fK2KARGEhZI9q/N9UAO9jjM792wjPmg1PTOEXtHT
	 r3FSD9UrPhvf02zkoDzBaT21E/3mjoR4WQ+qvYtjsnR03xJ2960cLWCnoU64Qr25pAfMn
	 ac0cfW7yIzE5oVCpICdCoECrUGM97Z11AXdr0dU/zZBrsK6quu/lzpMUK26IDOg44Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=b6rqmBmv;
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BE0606A330
	for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 11:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28BE0606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=b6rqmBmv
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8b97460a133so624998b3a.3
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 03:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794568331; x=1795173131; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=squHT7DGI/tJX079kKnSehmb9JdmTDTTr8xWVbVGWdw=;
        b=b6rqmBmvxZg8bkfIkP2TcLwhL5LR6kwRdZai67947W2Qhj87Hg4rSW/XGCSYtGQZa6
         3Ed0tSqc6LfsqFJ6uOqthKSrHF3yhFm2jTdN4Jyq9l2WeKwu6bWAgElOafio0k74x+Px
         hjzB1DSKw3Koy1PSCGz/zM8DOgwTakwX8cACpCdAvKTXnKyUFr+P152L79ULi69JF3iB
         kSn540HyhY8v9gsBwdb3zVJcsGn+JmbMQl4ZpVNQBs43e6bH3XLtuQCDlWJhnqKQ2Qbi
         OkOdtZIICywGX8mm2VhOXJzKgLnaZdKHVi3YIP0gvYuXNhpRoEXPNxXISDe3YEQICZjd
         +ngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794568331; x=1795173131;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=squHT7DGI/tJX079kKnSehmb9JdmTDTTr8xWVbVGWdw=;
        b=gLtYWZ8bkYUjvU+xjC7ZtuFIXTOSO2voFXSb5VznNgzej9jm3uY2JE3GWfXymHDWYz
         3strecwnUACUfKCvCbWHEG5VRIRhOHIXycs8i0a2oSdVzaviPsHPFp7QqoC/ndwgRBbd
         wfDuuk6QGA2LjlCz8bTwzMicgx0wX1g0EC68p0nmLMPJ6m8gNwG2oolkYI+nfWDA53aK
         UFKehtIyXcPnwfrd6/s0SGlGGBnnyywLgK2Y8MDiJVCFIP1BjTpXNoOQKvD3/xGuRqUF
         3kb8ZxhFC8MtpzB0qomweYzqUAlunn2ZylwRLUjDPAlYyTHRNI/PukSabzpmYfwzfI0y
         nXfQ==
X-Forwarded-Encrypted: i=1; AL+hErGOm6C88QS/oOFhnIVY7XGuWFw5+bhg1VMrNYHXKCRBVMbG6IotW2Ea0x0wimj+BWcbUIsSxwzeP/gizw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/pP1mnYxi/wlrLGq4TVN3SQwP/ujOYM24/noGBP+ciQgjsi6VN
	MfQNe0GvMPeZhv/wbcwXoz8Pllt4OrIpAUwqtvIDuNBHFDrW+DGx2mz8n46jRcink9W2o2v0QgS
	B5gg2FTrr4B9XKtXhFWShkQ==
X-Received: from pffl16-n1.prod.google.com ([2002:a05:6a00:c350:10b0:89d:1266:bfeb])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1826:b0:89e:92e:4211 with SMTP id d2e1a72fcca58-8beb56ca152mr2264864b3a.16.1794568330920;
 Fri, 13 Nov 2026 03:12:10 -0800 (PST)
Date: Fri, 13 Nov 2026 19:12:02 +0800
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
Message-ID: <20261113111202.3551341-3-stanleyjhu@google.com>
Subject: [PATCH v2 2/2] scsi: ufs: core: Do not recover the link concurrently
 with a PM callback
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

From: Brian Kao <powenkao@google.com>

ufshcd_set_dev_pwr_mode() now recovers the link after a START STOP
UNIT timeout. ufshcd_err_handler() must not recover the link while a
PM callback runs. Its pm_op_in_progress branch still does so when a
fatal UIC error arrives during that recovery.

Remove the pm_op_in_progress branch, so ufshcd_err_handler() waits
for the callback and only one context enables the host controller.

1. Runtime suspend sends START STOP UNIT and the device does not
   answer.
2. ufshcd_set_dev_pwr_mode() starts link recovery after the timeout.
3. A fatal UIC error queues ufshcd_err_handler().
4. ufshcd_err_handler() sees pm_op_in_progress and starts a second
   link recovery. Both enable the host controller at once.

Removing the pm_op_in_progress branch needs one more change. A fatal
error during runtime resume then has no recovery:

1. A fatal UIC error queues ufshcd_err_handler(), which waits for
   the runtime resume.
2. START STOP UNIT fails with DID_BAD_TARGET and resume fails.
3. ufshcd_err_handler() resumes again and fails the same way. The
   block layer pm_only count underflows and I/O hangs.

Recover the link in __ufshcd_wl_resume() when START STOP UNIT fails
while error handling is scheduled for a fatal error, as it does after
a failed hibern8 exit.

Fixes: f966e02ae521 ("scsi: ufs: core: Fix runtime suspend error deadlock")
Fixes: e23ef4f22db3 ("scsi: ufs: core: Fix error handler host_sem issue")
Cc: stable@vger.kernel.org # 7.2.x
Signed-off-by: Brian Kao <powenkao@google.com>
[stanleyjhu: recover the link in __ufshcd_wl_resume() after a
 fatal error]
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 drivers/ufs/core/ufshcd.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 0f5365bd90f0..825906b643fa 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -7074,23 +7074,6 @@ static void ufshcd_err_handler(struct work_struct *work)
 		 hba->saved_uic_err, hba->force_reset,
 		 ufshcd_is_link_broken(hba) ? "; link is broken" : "");
 
-	if (hba->ufs_device_wlun) {
-		/*
-		 * Use ufshcd_rpm_get_noresume() here to safely perform link
-		 * recovery even if an error occurs during runtime suspend or
-		 * runtime resume. This avoids potential deadlocks that could
-		 * happen if we tried to resume the device while a PM operation
-		 * is already in progress.
-		 */
-		ufshcd_rpm_get_noresume(hba);
-		if (hba->pm_op_in_progress) {
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
@@ -10638,6 +10621,8 @@ static int __ufshcd_wl_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 
 	if (!ufshcd_is_ufs_dev_active(hba)) {
 		ret = ufshcd_set_dev_pwr_mode(hba, UFS_ACTIVE_PWR_MODE);
+		if (ret && hba->ufshcd_state == UFSHCD_STATE_EH_SCHEDULED_FATAL)
+			ret = ufshcd_link_recovery(hba);
 		if (ret)
 			goto set_old_link_state;
 		ufshcd_set_timestamp_attr(hba);
-- 
2.56.0.611.g1030f0b940-goog

