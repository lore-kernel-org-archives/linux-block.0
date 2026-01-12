Received: from mail-vs1-f98.google.com (mail-vs1-f98.google.com [209.85.217.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45C2270EC1
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 22:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768258594; cv=none; b=RfimgOaKZdKq+nhpNYsjPKSu6yvWa59SxaJqNORmLuBuSi7b2VdpuQaOmmYaZI2tvja+bSsI26lzSoltmsOnPm8QfJwOWatkLhdTJdPgj+hCEe6VvRodi25pmhEJgMSu07HyRLYNXXoJCO/K5BC1UTTDeTxuTxY9+pUN5ikuSRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768258594; c=relaxed/simple;
	bh=tT7jZD+Q9wbCMb2WTlkSsORfssbTY50PwsD3mmNvOwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1V+De+rX7hNr1yp1dPV5yZq8VERYef8toeq62A4aCsHTROmcFSp50NwbjCKSW6eEISXvJpAB84l9vY4dsNsHiiMAuqOSIVUU2pbBxJaBHd4bllvCSHzclTCjfwQMPnY+A5zIFZVKW2vbABoXc427QknZdnDuTZ3FmOZn4SpfK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=QA9tvmoD; arc=none smtp.client-ip=209.85.217.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="QA9tvmoD"
Received: by mail-vs1-f98.google.com with SMTP id ada2fe7eead31-5ef31a77afbso2491936137.0
        for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 14:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1768258591; x=1768863391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyaGdMdvYKdCBNonQ+1tMJulGqath1yPwWxnyn2ej6Y=;
        b=QA9tvmoD+6/TOLcJaVdLzTzCQC/a6+1SJIlUAHPk+JBDg1sUeAEzhSA2E5q9P5qhVv
         BV8SUDIVnTdYuV1atQeuK5z5DH4XMF1SjO/HZlb4deTquO9cxoytjCagynRkE1siSDLe
         fZHQQuO/7kR43NJWH6KmlyelKWZmrNETtoOpKzWBw32XYn+AlFIPXteSpL0kZFcZQI3/
         iLtysO0rBlSPj9EDAVRCrgX67rAk4whSdhct0qWJB6F6xCaPUqaNOt5gXfW2xRofFZnB
         Z/oQ3Pp0XNNDNiGfzayJdw47GzMVwT9PxFTOxjtxtD8LWULo+Y4uBvlN2kfMejF7dd+f
         xuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768258591; x=1768863391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cyaGdMdvYKdCBNonQ+1tMJulGqath1yPwWxnyn2ej6Y=;
        b=Sn6yIBLt6SlKBW7ID73G1cboi3dnQwcEUg3XhSsnWWOA9dKNE96fVpbjTVOkwVdPDj
         gZ7EbUqGd94PCtH7/+c4SZ7+6yK6qLEi14lAc7rt222+MVbIrC2TXn9gPCxXwWMxVgLA
         x3L3Ef0xkL2rR69FiOoiA4FmGgAeZXyMcxhE5TF6dfJeRFe9vySesYztXi0odWBrfF3+
         LV9g+OszLwXyzx0moo3eCBYzKV0H0+bC4gmnnry55qe+tTBKYDwhCy0N63aSUquMsdHP
         V6av0YSvnPIB37QcVxyFDFtCOs3sMK/OmdjIF+AD3K3uI7XvSRyB+r6DR7f4mX5HWc+D
         Suzg==
X-Forwarded-Encrypted: i=1; AJvYcCVNeuX8oPod4W1mTDC4SwTHdSiG4yFDSUXr+Yg62mFzzNQvvO4ca8rL4uBMZBbP1kWK9UvB0l8mqPk0Dw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYg+BCl3sZw0PMyrQNooRrs7IpfVowi1eVmtWous/vqhqXeBwJ
	Dh+c9lwGSmlz26afyMN3Y3kpLC4v5sjFa/U8nlFAL9k5Y4nDjnxVfusyhwnji12ANmB7OvrWvaW
	cT7HLX1cA1nl2hTbD+Gs7T+jY8B3YZHSuyz53rhllObvZX3YatX1b
X-Gm-Gg: AY/fxX7dRVDpxR/lamrwEDJrBa18KEgADgaMzhu/c8Me28FY2LLBux6xucBAfGQJdq9
	MmN1anFZVo385H3GEZzeG4CGTxHbOlByjvbJg6csjN2pxrWf69SJmxvp0wLthkuqj3Qm6OuyjxO
	bLsb0hdPbwoeBCExabqS/OPFAFP5oqvvBHKxdMfCzzJgwPje3+AI8TTVTrYvZRbS+X8US0oRKp8
	2+oUCDBymEE6YMRXbHOu6Xqlbr9+6EqKvO5YYiyWazZq+KtxrCTVQhJrTaR+bWBhmYUVH9fKHpW
	syqVJ21ewvPjl+ii7pDFe1fAqCLldTLXJpp5eJew7yGQA0mbGDSccAORERyrcWKgwtC07kOs5Qu
	cghFaW459Hl7d2XmdV7xLgE2w1S0=
X-Google-Smtp-Source: AGHT+IEEBMrPSZjtLnyr+6lUV6QcogdRwUpyibbfQpagfNtfrt+tpLnVNdJaKdXUsAqNo3JsNWcPz44f6xtQ
X-Received: by 2002:a05:6102:3a0f:b0:5db:3c3b:7767 with SMTP id ada2fe7eead31-5f16ca8ba30mr485684137.16.1768258591580;
        Mon, 12 Jan 2026 14:56:31 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-5eea382dc6esm2080280137.4.2026.01.12.14.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 14:56:31 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-sconnor.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::4936])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 81AEC340686;
	Mon, 12 Jan 2026 15:56:30 -0700 (MST)
From: Seamus Connor <sconnor@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Seamus Connor <sconnor@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2] ublk: fix ublksrv pid handling for pid namespaces
Date: Mon, 12 Jan 2026 14:56:14 -0800
Message-ID: <20260112225614.1817055-1-sconnor@purestorage.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAB5MrP5YbxdUe0378VfKBMb_n9=6G-C=TPixYoMaV48trgtWBg@mail.gmail.com>
References: <CAB5MrP5YbxdUe0378VfKBMb_n9=6G-C=TPixYoMaV48trgtWBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When ublksrv runs inside a pid namespace, START/END_RECOVERY compared
the stored init-ns tgid against the userspace pid (getpid vnr), so the
check failed and control ops could not proceed. Compare against the
caller’s init-ns tgid and store that value, then translate it back to
the caller’s pid namespace when reporting GET_DEV_INFO so ublk list
shows a sensible pid.

Testing: start/recover in a pid namespace; `ublk list` shows
reasonable pid values in init, child, and sibling namespaces.

Fixes: d37a224fc119 ("ublk: validate ublk server pid")
Signed-off-by: Seamus Connor <sconnor@purestorage.com>
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
---
Changes since v1:
 - Updated start_dev and end_recovery to respect the user-supplied pid

 drivers/block/ublk_drv.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 79847e0b9e88..4a4673e64668 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2922,6 +2922,10 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 	if (wait_for_completion_interruptible(&ub->completion) != 0)
 		return -EINTR;
 
+	rcu_read_lock();
+	ublksrv_pid = pid_nr(find_vpid(ublksrv_pid));
+	rcu_read_unlock();
+
 	if (ub->ublksrv_tgid != ublksrv_pid)
 		return -EINVAL;
 
@@ -3276,12 +3280,32 @@ static int ublk_ctrl_stop_dev(struct ublk_device *ub)
 static int ublk_ctrl_get_dev_info(struct ublk_device *ub,
 		const struct ublksrv_ctrl_cmd *header)
 {
+	struct task_struct *p;
+	struct pid *pid;
+	struct ublksrv_ctrl_dev_info dev_info;
+	pid_t init_ublksrv_tgid = ub->dev_info.ublksrv_pid;
 	void __user *argp = (void __user *)(unsigned long)header->addr;
 
 	if (header->len < sizeof(struct ublksrv_ctrl_dev_info) || !header->addr)
 		return -EINVAL;
 
-	if (copy_to_user(argp, &ub->dev_info, sizeof(ub->dev_info)))
+	memcpy(&dev_info, &ub->dev_info, sizeof(dev_info));
+	dev_info.ublksrv_pid = -1;
+
+	if (init_ublksrv_tgid > 0) {
+		rcu_read_lock();
+		pid = find_pid_ns(init_ublksrv_tgid, &init_pid_ns);
+		p = pid_task(pid, PIDTYPE_TGID);
+		if (p) {
+			int vnr = task_tgid_vnr(p);
+
+			if (vnr)
+				dev_info.ublksrv_pid = vnr;
+		}
+		rcu_read_unlock();
+	}
+
+	if (copy_to_user(argp, &dev_info, sizeof(dev_info)))
 		return -EFAULT;
 
 	return 0;
@@ -3426,6 +3450,10 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 	pr_devel("%s: All FETCH_REQs received, dev id %d\n", __func__,
 		 header->dev_id);
 
+	rcu_read_lock();
+	ublksrv_pid = pid_nr(find_vpid(ublksrv_pid));
+	rcu_read_unlock();
+
 	if (ub->ublksrv_tgid != ublksrv_pid)
 		return -EINVAL;
 
-- 
2.43.0

