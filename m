Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B02A217F27
	for <linux-block@vger.kernel.org>; Thu, 15 Jan 2026 02:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768446000; cv=none; b=S1werzNP0ULC0Byiy7OfbLMYkP7Nkn2PgiU6uZb+/h0LBab2PywgUs0mRcVLM5lcHDjoGyKhe/nxxvRgLmXGd80fKzAmrvhGgGjRPNDXSqJHh2JxATCsDWX2bsfKGBgu2Tbtp6UUuFUsJNRN5OBdyqBpIw5+uoPYmT5x7q0zUHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768446000; c=relaxed/simple;
	bh=CVPjjd7KZtv2OZZldVANtHMlu7Q8Gw7adYZ01Gowl9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QdxUTNyDtDWLmaa/3Xae0X/gn7dA649yTXJWFaJsHrpp9ObxEOmsuFh86u53j9BTaK4EK2gEHuJ6XoDJWGFp7h3ZCGrO8l8RPDWo7MdKfJzC1/iYUSsu48Q6e8R4tCsOeVSMTB/cFEfHfazkT9TVwgjgDaR/oqLvmUfPx+Tti3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=EDFqXCQi; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="EDFqXCQi"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2a07f8dd9cdso3474035ad.1
        for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 18:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1768445998; x=1769050798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AvMGdyt/+sLcBqXRNH1/7areAi7eKp1jrXhG3SsYsRk=;
        b=EDFqXCQi2y4BLnBvQYOVMdT0v9RS5g8d9Gs7QtwuBdu2Stx8rVKCTbVl2revddq9Qa
         mwmAvP6t1ihXP/tT4691jXSJC9RZfhwN4erFqP0bqE8RpXH0fnQ8FRI2ksIaM87PsQo1
         UYQgWeNnsW7xJ5XYifOKrqRWKr0X8gO3Xm+hlU6WRczG7x+rs1TbEvy+u5NSdcaIUtC3
         nUIe1n/1C5k3lxA9UDK43vzHfhil2kcwHabmQDWhomCOonVXqN+pJUMDKEeqA4ZJbES0
         8ReqOYxJFAVWiuGaHnIou4e8WIAdBgHFczrVwKigv0umRPc5o9+xMg4S8Y2SUZ3ZbjC1
         hZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768445998; x=1769050798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AvMGdyt/+sLcBqXRNH1/7areAi7eKp1jrXhG3SsYsRk=;
        b=HZ61dZFJSqSEztftpMvoyxq+AHKN4olU4uFFOqJDjHWlsml0gr75vjNSns5vf+RPzM
         rkI7bkEdq+V/zkYOS9Ghj8axUTc2b8aLZFMKlMnBdQJ77YkJsYt+vw4eSxBgdZLu380h
         bxr6e8A7IeL7YXnqmmM/x21/efmWNiTGquCEHqHZiV7Xvq4ex+8DRa72csxB6zk4f3cl
         I0IoB7hK55aimtTEl2T2ZZpl8b/pO+rnTuUfiXtBvuUzzQxW3YDI1DVVZnKglufRpiYS
         TkRYgGNYVRVJkcOByOvv6l91qt4E3BdpdTmyBAo9tue8qt+QKHY7SlVeG06izN5Ng3xl
         oKAw==
X-Forwarded-Encrypted: i=1; AJvYcCVy/NtfoQytPsW2IR68OaK2KagRRwPqQF3df055hfqcIY/gHGePXRdKwUMwm1yN84WcvQmcuZkXEMjV7g==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl3FSdKlgSduFjfEHoUj2jidXBuPN25oZEBtWSAegaW25n7dds
	0NJ8nX3mjyiUmqQL8JMREcxkqA8q2wPgV31Wmh+LWAs0QJszWgRgXjJhFRXtnjqYA/tFJwzE2r3
	P3QMfH/sdW1VdteEXhVDoLg3Xue3tGr48tu1o
X-Gm-Gg: AY/fxX4kHvKGLlfm80/ZhbmE/v/WGcOUsXMTEK0aFvJUqUxGzMVUTs/pbuWLq8te+93
	DaBFrRARpkfZlovWqBMju+7IpsV/1rWnbh1Yvh+OrGXr9beP/3Z0jAVA3IaqRuPYGVa/6OLlHft
	j9CoFx6/c5JpF2ZWQzYbOOXrzSZbPrvSBOKii6znnOv6dbhdijFsEeXcckuipOqt1+HzS3gBIUj
	mrYk86QJ2aB3su2pLewTUOi+jK+UlHJHShl1o7VrAUyCaE25t6pyMTA/lIXFtEPQR6xhUdQNhh9
	ulFkbJ8QQSkjRRq8YZ81J/mCqZqbdsU6PiLXWstmVtqtLJ8oeWu3dmIjsDdYYLIlPyH81757Zk7
	9WOYKGghVdmL2MLuCtUYFRmLA/TXjhi/X95zlbkq8pg==
X-Received: by 2002:a17:902:e744:b0:296:2aed:4fab with SMTP id d9443c01a7336-2a599db4201mr48921155ad.23.1768445997880;
        Wed, 14 Jan 2026 18:59:57 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3cae7d7sm28676785ad.36.2026.01.14.18.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 18:59:57 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-sconnor.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::4936])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 2BCC034040C;
	Wed, 14 Jan 2026 19:59:57 -0700 (MST)
From: Seamus Connor <sconnor@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Seamus Connor <sconnor@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4] ublk: fix ublksrv pid handling for pid namespaces
Date: Wed, 14 Jan 2026 18:59:52 -0800
Message-ID: <20260115025952.2321238-1-sconnor@purestorage.com>
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
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
Changes since v1:
 - Updated start_dev and end_recovery to respect the user-supplied pid

Changes since v2:
 - Moved pid translation into a helper function

Changes since v3:
 - Minor rework to the helper function

 drivers/block/ublk_drv.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 67d4a867aec4..898c17755135 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2852,6 +2852,15 @@ static struct ublk_device *ublk_get_device_from_id(int idx)
 	return ub;
 }
 
+static bool ublk_validate_user_pid(struct ublk_device *ub, pid_t ublksrv_pid)
+{
+	rcu_read_lock();
+	ublksrv_pid = pid_nr(find_vpid(ublksrv_pid));
+	rcu_read_unlock();
+
+	return ub->ublksrv_tgid == ublksrv_pid;
+}
+
 static int ublk_ctrl_start_dev(struct ublk_device *ub,
 		const struct ublksrv_ctrl_cmd *header)
 {
@@ -2920,7 +2929,7 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 	if (wait_for_completion_interruptible(&ub->completion) != 0)
 		return -EINTR;
 
-	if (ub->ublksrv_tgid != ublksrv_pid)
+	if (!ublk_validate_user_pid(ub, ublksrv_pid))
 		return -EINVAL;
 
 	mutex_lock(&ub->mutex);
@@ -2939,7 +2948,7 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 	disk->fops = &ub_fops;
 	disk->private_data = ub;
 
-	ub->dev_info.ublksrv_pid = ublksrv_pid;
+	ub->dev_info.ublksrv_pid = ub->ublksrv_tgid;
 	ub->ub_disk = disk;
 
 	ublk_apply_params(ub);
@@ -3274,12 +3283,32 @@ static int ublk_ctrl_stop_dev(struct ublk_device *ub)
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
@@ -3424,7 +3453,7 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 	pr_devel("%s: All FETCH_REQs received, dev id %d\n", __func__,
 		 header->dev_id);
 
-	if (ub->ublksrv_tgid != ublksrv_pid)
+	if (!ublk_validate_user_pid(ub, ublksrv_pid))
 		return -EINVAL;
 
 	mutex_lock(&ub->mutex);
@@ -3435,7 +3464,7 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 		ret = -EBUSY;
 		goto out_unlock;
 	}
-	ub->dev_info.ublksrv_pid = ublksrv_pid;
+	ub->dev_info.ublksrv_pid = ub->ublksrv_tgid;
 	ub->dev_info.state = UBLK_S_DEV_LIVE;
 	pr_devel("%s: new ublksrv_pid %d, dev id %d\n",
 			__func__, ublksrv_pid, header->dev_id);
-- 
2.43.0

