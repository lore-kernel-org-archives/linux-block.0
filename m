Received: from mail-qt1-f227.google.com (mail-qt1-f227.google.com [209.85.160.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6228518BBBB
	for <linux-block@vger.kernel.org>; Wed,  9 Apr 2025 01:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744162953; cv=none; b=R3UzEvQMMFWhETK2DAihMTYLxvWzcDCfPnV3T3MEjgr8giM+JM/l3nlfvoyPAu3x1wVwzDJQieb87UqiRXEDw90Kd4tLE7GKj+/jqhSVKsI985hg1RaB083f8uJjDTl5K50rOynCFbgP8xrbB5syjm0U4LwLDoalf8+cBLLRaGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744162953; c=relaxed/simple;
	bh=4Ldp2l6rBuf/UdGTjzYPoDsd0i7OfOyCP25NGXo7oXo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VvjBpEQ2UYQ+9JoF7wBQwaJG6Nvuv+nU5MpeyD/g6fOLh3Wfn8idyIG1m+Y49XX+vMlLNd+Gz+kIp7E5UpOkNDi3Ytj+w8qv5AqhaimmRft7hlxpwFgaDbt+N7AtQGRUKIkFS015va000Qgogx6IwTnhocvqJPHoXIJKfKtj0KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Nz2VcDE/; arc=none smtp.client-ip=209.85.160.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Nz2VcDE/"
Received: by mail-qt1-f227.google.com with SMTP id d75a77b69052e-4775ccf3e56so3140911cf.0
        for <linux-block@vger.kernel.org>; Tue, 08 Apr 2025 18:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744162950; x=1744767750; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MgpzTCtGeldmEWjmJqn7b6H4/Wj9w7RY3hdIrUJLwxQ=;
        b=Nz2VcDE/k5BPp3IiTic8YcJjiKPKXvXaiXE1qOz+GkMLh0UW5Gh7juCxTXDEQCGkWv
         17YXVFLhRBLEr1P2LzNpWlzGPksBg+uh1lXKzAECgj/SqTB87zJFGsaJBvkijNgcP5mb
         SENdXhjLniMmUrc34LFIkJTgQirKXSh8CY5RLZplGz72P62bdtScldc7KU+t+Dkj1ySz
         m7TW058DwgBLhCs7Kxt5WT6OSCpM0HBEmMX6pK6YaFvCkDFfCbrntKsmh5dDpwp4pt7d
         /sum0jjSUErizHKuzGcQZBGVBu8Oah3ls7wluAyRccuFozscpX33JooMrs6hOpm9Ch1T
         x1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744162950; x=1744767750;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgpzTCtGeldmEWjmJqn7b6H4/Wj9w7RY3hdIrUJLwxQ=;
        b=dEPXLNSaNxcJKv2QtioNxDObL8ot7O1qFqWk6XOsgiOV1w/QvcXqnMTGFneqRMRTCe
         pdqYS3zlMTwFa0os/kLfS3odjVzMwmOA14w0L+ef04s64AZBAFTLTLWppHASPaftwOe+
         7Ll6Dr7Z8D0XCAuFjXdkUpJwI+eNWPFsnVJ7MQPx+nmG77ZZ2pktQzjss1hrl3DWVey5
         lucL8nA0ziVK+GVlxvk6DN6ujZ6V3UrPo4fI32Fi6x2L6i6/WY8WMgdYcoqkZj4AZfkT
         /nRTPPRoPJMMhLafcoux1LG3W4vG/31C72HgPaWwGOcf8E0lbdMQUPquP39Kp6VkmkYz
         5qWg==
X-Gm-Message-State: AOJu0YzPdMWHMyZ30zg/wo172XGGVZghWPcXy+QBkJAMgqOA/lVmOXPR
	/XT/CiP+WAGYpLr03D2vz+pi7xk2+EBqsbW2jmAVA5PZN9tDIwDfheM5l68tWM3s7OF6eKMXFty
	aZJVSOgH3nyR3ogbF8qweBjSGb6wfzwFa
X-Gm-Gg: ASbGncv1XTQEG00393NJuCC+NHd/U2kipPwXwbnEZyPMI7hc9qLqQvk0/xrxw7JOA4N
	pvTFNgJRCkuMaSw7bFiHRM23FD/OEV5BCfq+q7GGKytBFOcllbwLhP2sZDeBK7/yiq9SZYFeo7a
	IeyJhoG0AMP4dY6Vbg6X0OJ0jzQqIbJ9UbvFujsAoduSX9Y9mn7Ta/yhUVbS2d0+nbR+z2b2Zz2
	mr8ABPAuCXjDjOzDUZJWoSu2Pr/wrkwKx35PXug/RSFAqyc+9zpMcTOVoXOwFKd4pNAGbh2jYwq
	ykI4t6oIcgSl6sm9aE1+qLj3CsSHLh0L3QHWX2Sb7p1mxuwmEw==
X-Google-Smtp-Source: AGHT+IEds+LY1jv8ZLyqlzOP6+065cbkz0eVWjeidKJKpoEWnDbEXV1YwhzCbfby9ff4B87McyMjD2mvmVqI
X-Received: by 2002:a05:622a:351:b0:477:51c:d853 with SMTP id d75a77b69052e-4795f08e207mr14639391cf.9.1744162950320;
        Tue, 08 Apr 2025 18:42:30 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-47964d6fba6sm58471cf.3.2025.04.08.18.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 18:42:30 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 51E6334045B;
	Tue,  8 Apr 2025 19:42:29 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 442E7E40EBE; Tue,  8 Apr 2025 19:42:29 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 08 Apr 2025 19:42:07 -0600
Subject: [PATCH v2 1/2] ublk: properly serialize all FETCH_REQs
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-ublk_task_per_io-v2-1-b97877e6fd50@purestorage.com>
References: <20250408-ublk_task_per_io-v2-0-b97877e6fd50@purestorage.com>
In-Reply-To: <20250408-ublk_task_per_io-v2-0-b97877e6fd50@purestorage.com>
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
 drivers/block/ublk_drv.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2fd05c1bd30b03343cb6f357f8c08dd92ff47af9..5535073ccd23dfbbd25830c1722c360146b95662 100644
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
@@ -1962,17 +1961,18 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
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
 
 		if (ublk_need_map_io(ubq)) {
 			/*
@@ -1980,15 +1980,16 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
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
@@ -2028,7 +2029,9 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
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

