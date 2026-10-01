Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0718225B0AA
	for <linux-block@vger.kernel.org>; Thu,  1 Oct 2026 12:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859278; cv=none; b=UG2uY42dmWkSrk9NnlPImnaoVaNg0ii99mk0pdbmOQ6LOri9WdqFuXrEPoCQyj/veo03VyLn+rveJnmjZuvSHFFBk9RrAhbo+tp3ElJ3hpz5mUyHT5yljvUotYUnza3NXAcWrOa/lKENUcuh4nI26mpGZOMt4des2kp8Z4Hx6Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859278; c=relaxed/simple;
	bh=puJnUkkYlp2Rm81II49/RZqZo5bKWfrm76YkIDhRaY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FBlW+ppQ1IVhSjXt6DKjiIUXixqW0E/QESrOBDFii0Tfmg09pp3zXWYKXclmDTS4zEPiyupwiV3VPTKMV03cPAgsgYtMKD19rCa/unD3X0IK++OHIDB/f+5pEaP3NYVUq7Ut5MmHrrWJ4IJoETupK6Klk1u71aPuioa6LKQeEh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPAzpfVj; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPAzpfVj"
Received: by mail-oo2-f41.google.com with SMTP id 46e09a7af769-7fcb425fb68so4009053a34.0
        for <linux-block@vger.kernel.org>; Thu, 01 Oct 2026 05:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790859276; x=1791464076; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EiNikAvpmoIZ+b2XhpI8AAb7X0dMpLwZ9yMcq/0O2PE=;
        b=fPAzpfVjt34g9taJ4odd+RI/m6PshF6dM0eB7M8inl5BlD2H7hqGjjEDh4IQDJTbYs
         kiYdV4a8zMpcaBp14lgh1bplZViQRjYD6bvsg1woJgVMyqSLk0otyjb9O4c5hv5wMu7l
         SA8rn429yUk7VoqSZ+836Canv46iczQL6CbCMpjZUhSkWlIWdvp33jKMrY6/JrHunTF2
         Sy9AEWx6npepw3H2i6nEI8siNPYNz2LjtLXO7ZvDeuGkxf9BDlq9FGjOKX2feM4IfQWo
         ssKCHcBGU9cWwCX+5Q8rmJacAcvieeL9YUfRL5uZJlew6oQDgrZbj0s09NEpQt1/lHv7
         3hAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790859276; x=1791464076;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EiNikAvpmoIZ+b2XhpI8AAb7X0dMpLwZ9yMcq/0O2PE=;
        b=GTgQQS/IKJecw1pDzsw8QfJaCGzm7gpZCEMD2gd5aoPfn3HH5cVF6eM/SQywypMUEf
         0KnFbCGUMHFILl/T/RobG+emjhh1OFhAst21k1xXnQFB08pgojdxlr+2MSu23j3qD0s0
         8b7fXRjwNQ0GHNnwnRECwmv3SBMEFafJ7+dO/SvC742EQwr1NuYReryVlKH3vI9meb8T
         cpovUaoNaW4xv6kqCeKlKSQ7dVOzjWoPlD1lCuZFijCwKEMIfBlucS67XgwSEfwAuT6x
         3tG4uMToJWwEQG7e2FqnoVjiHPbPaqYsU7UYpcOhb+pi7ebulnpjYuzAS+8N++jdDIiA
         2f5w==
X-Gm-Message-State: AFuF++ktXyX12wH+UaAGBcPR8UF8m9RLYGs7zx/HyS93kbBmU4I59ciu
	jAbJr1y7WEm8YyGWyvFYm1qrOcrdxmwMPnCdIjRb7eYaEq7Tqyb/B2pw+Vj38A==
X-Gm-Gg: AYBFou3lp47XwoQDVKeT1l0GR2mEupnTweWYzaDUaN1hg23qqs8qNtssEUERDhM/3Rr
	fiYUHqGGRBL7jY8J2zeJ8EkwV42d5TJ7u5F//kTVBCBcon1JJ1T/4UqN1d65fr6zUL/6opQY5+x
	aW4f1+a0HcXf3XSKVHh/PYUdoKRwM5aZa0JCeYDK5szGDf1JTRO5kJW1Frt7EHgmr5QgGdkVvgC
	jCBDVW8aDW4kpUnQIFIxj8UaU32OHi14JC4Ilp++wpE5kYTLHPuHqdI4DEzvGhVHhkEncazu857
	hlDCWyvUDIQAr/qabS43xjQimDbkZ+LvXYqVwsos8HfvI9qgha2EkewuGUHFtZ1gEiC5NtS2Bfv
	kJM12/C53zdqucZqjETHg53YxiP8FyxqNAr6TPqPAyfHZP6TyNLDl5rVJyVms/UnCT5xKX/i25Z
	v/vq/Tsy/1BT9UwTZVrRXmWUymKSzZkPi/A1QBVLl4viKtOMWWUt5laQMELFi8g6zLs3Pg3e4TP
	2xceXnAzVyj0dIokZdc52bZVirI4q5bf0Q0Q48oecS6Zna0ikNlFxjE2rQRRa9d3foNC1ANpZag
	QSg4GcP0OLAhmyudpBwT2b8PuCo=
X-Received: by 2002:a05:6830:829b:b0:805:2785:fad5 with SMTP id 46e09a7af769-8204a96103cmr4666102a34.27.1790859275758;
        Thu, 01 Oct 2026 05:54:35 -0700 (PDT)
Received: from fedora-laptop.tail348456.ts.net ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8212b937bf2sm2504806a34.27.2026.10.01.05.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 05:54:35 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: linux-block@vger.kernel.org
Cc: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 2/8] ublk: mark the io command cancelable before publishing it
Date: Thu,  1 Oct 2026 07:54:16 -0500
Message-ID: <20261001125422.1364260-3-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001125422.1364260-1-tom.leiming@gmail.com>
References: <20261001125422.1364260-1-tom.leiming@gmail.com>
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

