Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A07147ACEF
	for <linux-block@vger.kernel.org>; Thu,  8 Oct 2026 11:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791459561; cv=none; b=MhgvtG5jH9aGrhopJl2HPMD8qEB/oOleBX9xNMQUHX51Z9RBLn9nCvqbNrGza/zXbKByf0MXgxj7hLzk3i+RSDaMqeT4/JyVB9iPjoLFK9QTBmVAMHi+fciplFyw3bXQ9x98gU9tRJIvuPaAXXIWtwVhuDwKoqIlTnBVAzdQ/Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791459561; c=relaxed/simple;
	bh=dJqTDX1WY2uhG7V39wJ+r8iKZiRLpuKN25IZDXTwbaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tlE9mDJyvnKOprfrCRODkStoTwMu5l4vI4MTHeLCKUE3kjf6m1kJH1IPtLI6DevVYShF0v4CBGVh8V2YskGC6FcZuiXa21xsailiqn5wetfs1Jzin5DUeRZMkyjQ/6I9IlF7znyvM/zjh8O+KKVUstRXwVivQjJrXuusY2t7SNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5/CGYnH; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5/CGYnH"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-824e6e6ed71so3957335a34.1
        for <linux-block@vger.kernel.org>; Thu, 08 Oct 2026 04:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791459559; x=1792064359; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Lwav3vqU57rzl7VXPxqY+psSVxn7RiVm0pK94kcfJ2A=;
        b=T5/CGYnHzwHaqaaCFkZ4h7L8v8cZ2ZCmao/EYSwxQoJ6hoEnnSlJNodo4KZ8LCM4zj
         X9WeshX4ypQZMvKwKZgDvYaC9Ag421OqPDcAlc4b0bOgzggTPTpBi5pgLOSCJWtXjsMQ
         HAYzawbpA0Lz+UN0/Gu0TDLpIJI12dxxFHU3MO9Lmn8I899W8EYEyreKl5Jkc/5KWCMe
         bGB2OOHewaQ/2ZnySfS9ecZ/V6BBK4tEw0kd8C4j5Oqd2U5d+5uZK0nc4VoQbxHPHUKo
         z1QTxtFKF7ze4Cu3geChRrlllNK2Zx5KylX/co4yER0O3dTPl41OHMRiNtx9ZSNLi/Ql
         py6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791459559; x=1792064359;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lwav3vqU57rzl7VXPxqY+psSVxn7RiVm0pK94kcfJ2A=;
        b=vxRlUDBlbzEZipEK48quCAXa16VrTTJTStGTuPNsfeSkZyHGpdFWcUWcxl5B3jDJWR
         Sopolky+0kh+VUnVfqbKx/EU98w4Tfxn4dVMDsxbb80spRA2rwbIgJNx8ksq0yjuhRVz
         3ytUXSozd+TdSYV1YXKpYoRgy2m1QjYr5H0UqsDwyq1Gr3B9pA0UlzeU7/cG22qVpzki
         dZ0sFatGuv/d4jnBL1FuuvhjkgwGuS5U7FAQMyR97mHXtWYc4RIzo3Rr6Uk1EpRSn23g
         Z2awQUkLlJbVs8GKoOvjpiHBbdQTgypOLYRYQ/9eVbu9Iscoslx7dw1+pjIIIjOwc02M
         4KMg==
X-Gm-Message-State: AFuF++loA8bQvdg1txRYkPVZq5GuWs0FdZisrl4ivgk6uOKxhg31RQEc
	Y9tZwhBhgUSsScTk4vtctg0wVOFm9zqwvHBsQgkncY8o0FYjBhJh5RF1GsrBu7EE
X-Gm-Gg: AYBFou1Kp7KPAbVCSHtWGZdfqQCcmv5SJBcx1y+gGk405fykvU1Z/XKllmMNX07ItiM
	6DVfO8/77E1Q+DmZnO3eJoS2euFnlIWKV2nxbaUtVl6cfS/vjY3peIzqO4E201zOh5EGAUTbdEY
	zvMCFRssFtfGnSVO6u8TCcNRTbx/iJ2m+F5eeLsbMS4Ed0moacErRER1/G5VqC65++Kqnsub7g6
	ISMHuvcMhggb4ms0NBqedoo3zNc9fJZSXeEWd/icETeL0Oo2aSs/xyhZ/t9ZN8KvFo94m2j7tSA
	RUEmD9YQJULzRbugEOQf8aRiPcmi5+Tw2vDRw1RyAG4h6Jh8Mt5dGEV8x6+3imtavpycENhNtFF
	AfBEtg5XSgfd54onAAVZpqFYK/61yBa4Tj8HxQZiP5MHuS/7FcpeFZu4URYrPlRZkR05EIeMPSL
	dx3OiV/yitACNKwRR31VCapB1bfvf69k+ZTNMgDH1JCmVrvfdZDp3BZK19dMYAiBnr2fG2VX2bQ
	ndcHQQRXUOOfMKGrMHrZvInS0GiPpJ0YTIWPNWlS1dWW+wi4pC6ZW9hZKeED9P0kvWoVpkImc38
	UAKxtHmW/D8Wr6tJXLraUZ4UUL8=
X-Received: by 2002:a4a:edc4:0:b0:6e7:9606:6c07 with SMTP id 006d021491bc7-6e7a7b03b95mr4198494eaf.74.1791459558803;
        Thu, 08 Oct 2026 04:39:18 -0700 (PDT)
Received: from fedora-laptop.tail348456.ts.net ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-82adcb187c8sm6045154a34.22.2026.10.08.04.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 04:39:18 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: linux-block@vger.kernel.org
Cc: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 02/11] ublk: mark the io command cancelable before publishing it
Date: Thu,  8 Oct 2026 06:38:58 -0500
Message-ID: <20261008113907.4000838-3-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008113907.4000838-1-tom.leiming@gmail.com>
References: <20261008113907.4000838-1-tom.leiming@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

FETCH, COMMIT_AND_FETCH and NEED_GET_DATA publish the command in io->cmd
before marking it cancelable. A cancel from the control path (STOP_DEV,
QUIESCE_DEV) can complete it in between:

  issue path                       control-path cancel
  io->cmd = C
                                   take C, io_uring_cmd_done(C):
                                     C not marked, nothing to unlink
  ublk_prep_cancel(C)
    the completed C is linked on the cancelable list
  ring exit: the cancel walk hits it → GPF (KASAN, with a delay added)

Mark the command before ublk_fill_io_cmd() publishes it. The handlers
run with uring_lock held, as io_uring's cancel walk does, so marking
takes no lock and the walk can't see a marked command before it is
published. smp_wmb() orders the mark before the io->cmd store; the
cancel loads cmd with READ_ONCE(io->cmd) before reading cmd->flags.

A marked command has to be completed by io_uring_cmd_done(), so a failed
FETCH and the inline UBLK_IO_RES_OK of NEED_GET_DATA now do that. The CQE
is the same.

Fixes: 216c8f5ef0f2 ("ublk: replace monitor with cancelable uring_cmd")
Cc: stable@vger.kernel.org
Tested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk_drv.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 38ed7d0e3979..6015fb2fb925 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2800,7 +2800,8 @@ static void ublk_cancel_cmd(struct ublk_queue *ubq, u16 tag,
 	done = !!(io->flags & UBLK_IO_FLAG_CANCELED);
 	if (!done) {
 		io->flags |= UBLK_IO_FLAG_CANCELED;
-		cmd = io->cmd;
+		/* dependency ordered against smp_wmb() in ublk_prep_cancel() */
+		cmd = READ_ONCE(io->cmd);
 		io->cmd = NULL;
 	}
 	spin_unlock(&ubq->cancel_lock);
@@ -3163,6 +3164,12 @@ ublk_fill_io_cmd(struct ublk_io *io, struct io_uring_cmd *cmd)
 	return req;
 }
 
+/*
+ * Call before ublk_fill_io_cmd() publishes @cmd in io->cmd: a control-path
+ * cancel may complete any command found there, and io_uring_cmd_done() only
+ * takes it off the cancelable list if it is marked already. The handlers
+ * hold uring_lock, so marking takes no lock.
+ */
 static inline void ublk_prep_cancel(struct io_uring_cmd *cmd,
 				    unsigned int issue_flags,
 				    struct ublk_queue *ubq, u16 tag)
@@ -3176,6 +3183,8 @@ static inline void ublk_prep_cancel(struct io_uring_cmd *cmd,
 	pdu->ubq = ubq;
 	pdu->tag = tag;
 	io_uring_cmd_mark_cancelable(cmd, issue_flags);
+	/* pairs with the cancel loading cmd from io->cmd, then cmd->flags */
+	smp_wmb();
 }
 
 static void ublk_io_release(void *priv)
@@ -3423,11 +3432,11 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		ret = ublk_check_fetch_buf(ub, addr);
 		if (ret)
 			goto out;
+		/* before ublk_fetch() publishes io->cmd, see ublk_prep_cancel() */
+		ublk_prep_cancel(cmd, issue_flags, ubq, tag);
 		ret = ublk_fetch(cmd, ub, io, addr, q_id);
 		if (ret)
-			goto out;
-
-		ublk_prep_cancel(cmd, issue_flags, ubq, tag);
+			goto out_done;
 		return -EIOCBQUEUED;
 	}
 
@@ -3471,6 +3480,7 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		if (ret)
 			goto out;
 		io->res = result;
+		ublk_prep_cancel(cmd, issue_flags, ubq, tag);
 		req = ublk_fill_io_cmd(io, cmd);
 		ublk_apply_io_buf(ub, io, cmd, addr, &auto_buf, &buf_idx);
 		if (buf_idx != UBLK_INVALID_BUF_IDX)
@@ -3489,19 +3499,24 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		 * uring_cmd active first and prepare for handling new requeued
 		 * request
 		 */
+		ublk_prep_cancel(cmd, issue_flags, ubq, tag);
 		req = ublk_fill_io_cmd(io, cmd);
 		io->buf.addr = addr;
 		if (likely(ublk_get_data(ubq, io, req))) {
 			__ublk_prep_compl_io_cmd(io, req);
-			return UBLK_IO_RES_OK;
+			ret = UBLK_IO_RES_OK;
+			goto out_done;
 		}
 		break;
 	default:
 		goto out;
 	}
-	ublk_prep_cancel(cmd, issue_flags, ubq, tag);
 	return -EIOCBQUEUED;
 
+ out_done:
+	/* marked cancelable: complete through io_uring_cmd_done() */
+	io_uring_cmd_done(cmd, ret, issue_flags);
+	return -EIOCBQUEUED;
  out:
 	pr_devel("%s: complete: cmd op %d, tag %d ret %x io_flags %x\n",
 			__func__, cmd_op, tag, ret, io ? io->flags : 0);
-- 
2.55.0

