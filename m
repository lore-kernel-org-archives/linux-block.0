Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593E61E0DCB
	for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 20:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768423651; cv=none; b=glw9WdK3ecAAbsl9adfbfTi/CrLddSC8iwswUdeFyJ5/xpJZo6sUAScV5ZpmLKnwesGjxK3H4hKkmltB9jwjybP1zYVYXWufdXBEjbOAC7w7pFy4Zy5Ejhsoh/5NUQBORaoSFkjBleNQffj1EIg6w11EMqnD8NXHLz5C8xPIkDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768423651; c=relaxed/simple;
	bh=1pW7O9UH3C0KS4RTlj2iVVMII/k9SWeXJzZS3nyoe10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ARO3U9rUCXCdzAjvAV5Tf22Ogt37PdzxRqP2zW+QahtmRxh12Q8mg/xjWz97pahMteqhCzRFCwBD0TpcxXph8e4pGRAEy+cpnJ4gQ4c1EiAa9KHb4gmod/68IFcCJKSxhFjge3XE22LZ25vQU35MdLL0NPYOnhy035VFGUh6x6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=J5MTcxV4; arc=none smtp.client-ip=209.85.128.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="J5MTcxV4"
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-7926b269f03so1719677b3.2
        for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 12:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1768423649; x=1769028449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWLEQRO/UH0YKdM5ksbNTiP+oqc7ppfRc6exwkWZK9U=;
        b=J5MTcxV409kYTmONScMLdGdV1DAO2MhGVYWTZYGupWDn2s98O59L8nFkZ5YhDlUBms
         XzZ1aV/yMwzGUk4WTNyixVdauskD868RS2DvcoI/mqV4WCsgo3pdTM2Ktcc8XWH+/Rjn
         Puwi12NspHT3Cjp2QuaxySjMrLFb2LgIwRz3KZpE37fB7JLaYIynOvbbR4oO65VjBIA/
         Db0sIlT4r0RsiKq6bbTKpVXfO8EzoL/xPft2nx6VdfG0GNqWrmi8Idd1Np5J8/dt0f2G
         JoYB+go5m/sHJSMM+4s2ROJ3fhlAgFvjOAG46XKvMlNmGSEYlOSbDee5ChjF1MsiGhqk
         9yMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768423649; x=1769028449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TWLEQRO/UH0YKdM5ksbNTiP+oqc7ppfRc6exwkWZK9U=;
        b=JbPJSZv4mgYu3PWd1Ze9jGOWsiZ92mTF3LBR7BhCExqXouXlHfcf5ieLqBj5YJsDn5
         tAWq/tDKfK6vWy6LUM22Uu+Uvukjnf3wnmRIntfTxBFz7brjo9A3GpOswTw9SdXTAeXp
         vHB7WzsKqnVQSBdLusmfajcSl2STaBhEEVBU14dB/ioHnLf58z02ZKYKpJBJMlQGr0gs
         1n7vfL2BfU0cs06gUqgAgxxZLJipkusoQJXj3XoF/oHJCLP9oIzKd8mCVw7Y2dQ072WV
         D7wdZvFEwNqPVlSzTzFiaJswvHEnTSQDZehAWyLAiM6ZihqsOLQG9STsub9dethfw/TR
         sQJA==
X-Forwarded-Encrypted: i=1; AJvYcCW0uWxjNZXNogR177TgeG0CvV3tv/8v3r9FdRsRZwvnkcuIX5GaG8t6X/LeeaEGuG4AhFkNn9toCm3xsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKlS7SpPHK2+vzz4E1rj++CepOP4ROPz3HHKOFkTy2+eZ1X1RI
	cIbXMEGRRCz7xetEiTg70VPHq20LXK1SzQsGQ7z+VgjrWFV++3GVTo5bAcxj8QZchCmIAVmq45M
	OjY8Gn+P+ZioGMqAG9XupLLspbJmBu4LM8hZV
X-Gm-Gg: AY/fxX7CNKWoanSAe1HmYloDEfGz8WXIP2WqHPwcRCJoSNABcepm4O3BsTwtsAJ2f6u
	MlqeQ4ou9LbbVNlQ+UcfnBHTuKNbt92vc5MuhRJ/fyU7nSaawFcZehzwIKtSyPxBGGGJICIgNVT
	aGtCtmCD3yDibNpA3dIdYoBivRuljTPHzYV5w5glgtC1YRE9tw6JPLbaZgizXWnpgAW2RAPiJvV
	3fC+M8gm0w0i/NwG29FnrWU84KGwIpFcIiaaXVp6xjrOBX99NDNbFmdUQH/9PpVyopAG6EARLjR
	puuJLcp5OrK6Ws0RylsePMU4ik1T2s77H2C39BjHVgQXpWNfLXT/kc5AgFuu1gxAbrDleo+CTkH
	MRXoEh1F6TcZRbKbbIbrzVGfECRlxEmSAYsy9aj6vUA==
X-Received: by 2002:a05:690c:18:b0:786:a774:e415 with SMTP id 00721157ae682-793a1d89a8bmr66756277b3.56.1768423649142;
        Wed, 14 Jan 2026 12:47:29 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-790aa563f21sm18353387b3.4.2026.01.14.12.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 12:47:29 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-sconnor.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::4936])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 3269F3400AF;
	Wed, 14 Jan 2026 13:47:28 -0700 (MST)
From: Seamus Connor <sconnor@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Seamus Connor <sconnor@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3] ublk: fix ublksrv pid handling for pid namespaces
Date: Wed, 14 Jan 2026 12:47:04 -0800
Message-ID: <20260114204705.2249961-1-sconnor@purestorage.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260112225614.1817055-1-sconnor@purestorage.com>
References: <20260112225614.1817055-1-sconnor@purestorage.com>
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

Changes since v2:
 - Moved pid translation into a helper function

 drivers/block/ublk_drv.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 67d4a867aec4..01747d256ff5 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2852,6 +2852,15 @@ static struct ublk_device *ublk_get_device_from_id(int idx)
 	return ub;
 }
 
+static pid_t ublk_translate_user_pid(pid_t ublksrv_pid)
+{
+	rcu_read_lock();
+	ublksrv_pid = pid_nr(find_vpid(ublksrv_pid));
+	rcu_read_unlock();
+
+	return ublksrv_pid;
+}
+
 static int ublk_ctrl_start_dev(struct ublk_device *ub,
 		const struct ublksrv_ctrl_cmd *header)
 {
@@ -2920,6 +2929,8 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 	if (wait_for_completion_interruptible(&ub->completion) != 0)
 		return -EINTR;
 
+	ublksrv_pid = ublk_translate_user_pid(ublksrv_pid);
+
 	if (ub->ublksrv_tgid != ublksrv_pid)
 		return -EINVAL;
 
@@ -3274,12 +3285,32 @@ static int ublk_ctrl_stop_dev(struct ublk_device *ub)
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
@@ -3424,6 +3455,8 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 	pr_devel("%s: All FETCH_REQs received, dev id %d\n", __func__,
 		 header->dev_id);
 
+	ublksrv_pid = ublk_translate_user_pid(ublksrv_pid);
+
 	if (ub->ublksrv_tgid != ublksrv_pid)
 		return -EINVAL;
 
-- 
2.43.0

