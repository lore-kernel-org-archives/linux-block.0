Received: from mail-yb1-f227.google.com (mail-yb1-f227.google.com [209.85.219.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0293D2111
	for <linux-block@vger.kernel.org>; Fri, 11 Apr 2025 00:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744330691; cv=none; b=rb08AqDAKfLwVxf09ARLs2VilVjtHid+28xS0sylcJTgnkg8zZr5J6v93m0lreBcYwx2kxXvfK1taB18O8mDyidKyFiwQ3H56HFJ/jLRsy1syAkxBe2xp09/khGGbPE5E4Ti+u5NBAn7c835PvXw39XGZKAEMVf7Ah8UqSXWQ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744330691; c=relaxed/simple;
	bh=1bbPk4nVXbYSm5TyEHMtONnL4+3dFePnH4zVplRm4eE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Goe/pUtmjA28Vj6QNeWvuGzb3qgJftdHOTG92r+BVybS3KdaJlWTGKmFfiEWGGlKQWg6loFr/qjDYKTe8eTzNV//HzEm0mAzKHVFqIH8BoO/Hw5GpBiTSAb5QOL5cWLSBDCpyRNOK+Pf+2KLKRZ3LYDd2X32k+LQDLFeVKyUhrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=HSdslIH1; arc=none smtp.client-ip=209.85.219.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="HSdslIH1"
Received: by mail-yb1-f227.google.com with SMTP id 3f1490d57ef6-e53a91756e5so1361426276.1
        for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 17:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744330689; x=1744935489; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m1pEANpTFfOrSvpkXaufSvJPRX8F1QDAo8Dwnj8gdwI=;
        b=HSdslIH1hb4mOOSdJHH4H31WiGBNL3S+7VOElruChUCzcIMlBD5ek4dUQ3GwSBQd1o
         9Zaeap7bsqKb058ULDWOWl5xdnuQF9Lcm9hA2DxB8VEwcEo1Nk2UrBR9Ei89oNKCRD8/
         4RJG68La+31dECVRachXfo0F9nFMMLcmUTYNrHsWicbuErTU5qGo2LJ77w8Wrdwz4W0p
         16OEepGQrHg3MA1RarpZAsPoUyZdOFYsXYocJoS/AAxMFs5mE4bOUrjrGJH6wQGz8pkY
         6aDvlekBnvEdsrOjp4wFNaVXO46N4sz/QIFEOM8pXUhGB3CXWnh44yyATk4Gh9EgkCaq
         KrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744330689; x=1744935489;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1pEANpTFfOrSvpkXaufSvJPRX8F1QDAo8Dwnj8gdwI=;
        b=lRJ6xvrGBT7BaJOOhRhqCHAyWpN6IBlJyS3QTwWYv5IdWNN1Y0iBj1IjT8JNp+1UbC
         UI1im5cWDYLU3r1vppwKKpAa1UpQ0pSnHSTzYVwhW6l9JRhObWwaVAqnhwylBDVU+Z/e
         cZ/nuwu8EQZaG51LuJVl+rNdeDk0x4qitg1UujkDN0gDG85Sb4ZgBQtogwAi2T/kcaF2
         awGIB93BK8DX55QUMwxnJV2uAuimIL419rWHuHyHTO3b2boWA3wYrFz26dH8cQOmv3J7
         BkiHiFkp76JTW9grInEuPFE2kF2+ywaeEoBGyDYfrmDDSgy91RAkzS9TWCpSadpvdMdt
         JmGw==
X-Gm-Message-State: AOJu0YyNI3N71yPu80eaNoyFsev49YLsemPLbSJvnRpWzWfxwVUd60VO
	gzjTZXoprdfUHh7RwT+z08z29L4VyAMr29HHE3ZQ8aC9rEWS2TpOC8k3vac9RNzkUHS1eBSJagQ
	Zxbf2NxOV1OiJoyfmeZQiR0Nq7VC4YurT
X-Gm-Gg: ASbGnctnC89fF7pTEdzEc6phSqCXEfK9ZNBFUXoZKI6F3OmKkKEdGVIGhUy2g1VbefL
	jgj+tP/s1cGHwzNT9AxuHHaz9pxxeyjrSf7VDY8+3Hu8Jc06Zy/zNxjVCr//Ptnv/bKSiNqaoEU
	mcL/188hAoRU1KJHtwWjdQ+dSlTMB80FKw4FXIh+ro71XruuMyvzBnRTm2p0KK4A337Ilh+EnRi
	OfdxxbYYaXtQ/0jsXNQQDkdXcuu+S41x2V2dXcnCq3NTWhYlq9dEQnp4Mayzu8HGxYa+VlO5Jm0
	EkAAVkt9iGXVmxBOpUAP3pdSIGRyOYk9cwkMQWB38TWa/Q==
X-Google-Smtp-Source: AGHT+IHDCddYSn9Z3YDHDroSQbsXGr5+M9ESeMT8G112Xnc9Bogsb1I8tuT7iew7Or2Cc/2KbfFi0jjlmACE
X-Received: by 2002:a05:6902:cc6:b0:e5b:3823:4176 with SMTP id 3f1490d57ef6-e704de9bf92mr1781004276.13.1744330688844;
        Thu, 10 Apr 2025 17:18:08 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 3f1490d57ef6-e7032479f34sm340868276.15.2025.04.10.17.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 17:18:08 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id D55D3340971;
	Thu, 10 Apr 2025 18:18:07 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id D3145E40E5F; Thu, 10 Apr 2025 18:18:07 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Thu, 10 Apr 2025 18:17:50 -0600
Subject: [PATCH v3 1/2] ublk: properly serialize all FETCH_REQs
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-ublk_task_per_io-v3-1-b811e8f4554a@purestorage.com>
References: <20250410-ublk_task_per_io-v3-0-b811e8f4554a@purestorage.com>
In-Reply-To: <20250410-ublk_task_per_io-v3-0-b811e8f4554a@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
X-Mailer: b4 0.14.2

Most uring_cmds issued against ublk character devices are serialized
because each command affects only one queue, and there is an early check
which only allows a single task (the queue's ubq_daemon) to issue
uring_cmds against that queue. However, this mechanism does not work for
FETCH_REQs, since they are expected before ubq_daemon is set. Since
FETCH_REQs are only used at initialization and not in the fast path,
serialize them using the per-ublk-device mutex. This fixes a number of
data races that were previously possible if a badly behaved ublk server
decided to issue multiple FETCH_REQs against the same qid/tag
concurrently.

Reported-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 drivers/block/ublk_drv.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2fd05c1bd30b03343cb6f357f8c08dd92ff47af9..812789f58704cece9b661713cd0107807c789531 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1809,8 +1809,8 @@ static void ublk_nosrv_work(struct work_struct *work)
 
 /* device can only be started after all IOs are ready */
 static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
+	__must_hold(&ub->mutex)
 {
-	mutex_lock(&ub->mutex);
 	ubq->nr_io_ready++;
 	if (ublk_queue_ready(ubq)) {
 		ubq->ubq_daemon = current;
@@ -1822,7 +1822,6 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
 	}
 	if (ub->nr_queues_ready == ub->dev_info.nr_hw_queues)
 		complete_all(&ub->completion);
-	mutex_unlock(&ub->mutex);
 }
 
 static void ublk_handle_need_get_data(struct ublk_device *ub, int q_id,
@@ -1962,17 +1961,25 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	case UBLK_IO_UNREGISTER_IO_BUF:
 		return ublk_unregister_io_buf(cmd, ub_cmd->addr, issue_flags);
 	case UBLK_IO_FETCH_REQ:
+		mutex_lock(&ub->mutex);
 		/* UBLK_IO_FETCH_REQ is only allowed before queue is setup */
 		if (ublk_queue_ready(ubq)) {
 			ret = -EBUSY;
-			goto out;
+			goto out_unlock;
 		}
 		/*
 		 * The io is being handled by server, so COMMIT_RQ is expected
 		 * instead of FETCH_REQ
 		 */
 		if (io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)
-			goto out;
+			goto out_unlock;
+
+		/*
+		 * Check again (with mutex held) that the I/O is not
+		 * active - if so, someone may have already fetched it
+		 */
+		if (io->flags & UBLK_IO_FLAG_ACTIVE)
+			goto out_unlock;
 
 		if (ublk_need_map_io(ubq)) {
 			/*
@@ -1980,15 +1987,16 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			 * DATA is not enabled
 			 */
 			if (!ub_cmd->addr && !ublk_need_get_data(ubq))
-				goto out;
+				goto out_unlock;
 		} else if (ub_cmd->addr) {
 			/* User copy requires addr to be unset */
 			ret = -EINVAL;
-			goto out;
+			goto out_unlock;
 		}
 
 		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
 		ublk_mark_io_ready(ub, ubq);
+		mutex_unlock(&ub->mutex);
 		break;
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
 		req = blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], tag);
@@ -2028,7 +2036,9 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	ublk_prep_cancel(cmd, issue_flags, ubq, tag);
 	return -EIOCBQUEUED;
 
- out:
+out_unlock:
+	mutex_unlock(&ub->mutex);
+out:
 	pr_devel("%s: complete: cmd op %d, tag %d ret %x io_flags %x\n",
 			__func__, cmd_op, tag, ret, io->flags);
 	return ret;

-- 
2.34.1

