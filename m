Received: from mail-qv2-f41.google.com (mail-qv2-f41.google.com [74.125.230.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE334E9C09
	for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 16:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611558; cv=none; b=mOx+nVqIojtOy88kRj9W/ie4dqNxABVHEq3Hg4N+ZBrjZd1myrdrM/o3HjfCSPZ0r+u4g0vK91+eaWCFF7McVSPYrkP6UABIQjX7K4tzUQDnjoRQg//Qzq/yiOzonZSZVubWWybW8bDsTcFX1K2p4wi2qHGxY7gUKSFpJSje/RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611558; c=relaxed/simple;
	bh=OK9VYCvcNxGcMM+mG3wjRDISOd7f2u3Ql6cIqvbqGSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ikpf1xLqGmyAjaDIt6gqKE/pZ36I3sJ7wkqqjTiqMNkuY2pJblav0d+WzVMS7T2VRltjjEU1bvzjYUKw8BOEg2yJKwJyEfgprr5l73Txd+cJTTZgtKci5ZLAp8vw+XY8DzftyxZULGGjx0L/WDoT0kcHTmm3E39TSf3AJZCI8PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=LpxGVmDU; arc=none smtp.client-ip=74.125.230.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="LpxGVmDU"
Received: by mail-qv2-f41.google.com with SMTP id 6a1803df08f44-91782711448so1531936d6.2
        for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 09:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1790611553; x=1791216353; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AH+20yho7PNOwKKESU7Oa/Xa5V1uo7WLmGSEZMxA9rs=;
        b=LpxGVmDUaoS7jHhsuioaFVzD5oMWdhflzJ0kSpfoh9ugHuRShn6Z0t6DB+HrcKoAqL
         mAiPRxhhQwuAU0coIiFTcQc0VFwTSjfzmuHxBEO+RlW/9xsMwmAsDFzPtewOS00ZhArE
         YckAuiaJ3NID4V8WykE6HZ5AhEQCtQTi4OcDE7aa1iYwkgq9oXXWXv5+9bCgKQrbIbuV
         maoNbed23h2AZngjZK1zpQaAgOeOesocf9IXmZVtAasBsTYG/cQtro50s7bDu74GFOXf
         G3lIQ3Bj9T5HAnPTJSLBmnMndOlug8ydztIPp7rRkNXoAo4wxYwfykbKu5EKRHxA4Pc/
         swvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790611553; x=1791216353;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AH+20yho7PNOwKKESU7Oa/Xa5V1uo7WLmGSEZMxA9rs=;
        b=K4UzJxGPMq4PcE52h6aSsOw4JajQE//d8vC3jiw8ehH3s+jYfnd3ktZpizvKCyPrLO
         4YCSDQKXXJNrm9XFRbHGIQA8GW5b90ltZcQrgmfRhktfKKzdmk4junt3KUZKZCXHRmyN
         fWTQWM+WAkwkOG+Q8tk3BcB/nipXfzWiLiIvDPO606PVOA4kgfb/tTNRsJVBtuQPdTSU
         /0m2AUX7meGyI/nxuagpPejo25N86ksrvUk1keFI/2+mbNqS9Os+ERHf/tuJwwjSSRsP
         NB1eEIbE9kIZfh1Hz+shgoGpS+7Lujnm5DvaPwuF1kO+MiDYV49N2h2vhpUjwqKA+rMq
         mDsA==
X-Gm-Message-State: AFuF++k68WdhAODW6/9EMWVkJnTjENhnTAanJJwy9wXFWIEVLvqjGijP
	bqWi5Xqd2xwa3Cq24nsYax4AUyG2KUfEZJKuRWkmx2gbY5RPbOChcsU7vKGSV7BSiYE=
X-Gm-Gg: AYBFou0WFB4Bjw9IglNpfjZLJ9g/s/xEV/tF6Qalhu4MRGtwgVAvqmV+EhjGnNlZKOh
	Z8mSvR4azwzGE4kFH/MHyo/EgSkRvnjqCyEZv2ge+TiCy+wehkjTBxX1XKzl+/B/nq5/yGN01vI
	zbxVAKwwGL/yS2s//8dvB8H4El8ZMCXuxMtl/VPEDA5Ev9X6qaGfRfPPArjYOSooyMwr1lpLsq9
	XXfP9g0uj0BYynpJhILjxYp90b+k4Kza3fOjekMwwx8vEuVoDdoU4qmJLXdtxzpg3w7EqO5Vh6Y
	JZk4VJ50IQqOP3ri0bIFwzQJeyL0DhZZeBeybbqJ7x04qTVsFrpUZdEZyB9s2rVQkFSFwd4KHvp
	9wIQPgVb5NSKO/OWYqZQ0GxpQ7Y7PThQkvyy8y49xaNNkGNmwNZ+QOhlRNt1vs0KiSmgN/kSCdL
	cwtejTajvFEZo0ANEG/yRsz1uF0ugTft353VEIiG74tGsubV7gIPalbHCBCnVX3jYQAS2K0YE2O
	sY/F1qP/ZxBNlI=
X-Received: by 2002:a05:620a:254f:b0:939:f978:c1aa with SMTP id af79cd13be357-93c43b7e985mr2208125085a.11.1790611552856;
        Mon, 28 Sep 2026 09:05:52 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.244])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c81447bedsm181387885a.33.2026.09.28.09.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 09:05:51 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 28 Sep 2026 16:00:42 +0000
Subject: [PATCH 6/9] ublk: split ublk_claim_cmd() out of ublk_cancel_cmd()
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-b4-ublk-cancel-stop-v1-6-4a4360232a46@toxicpanda.com>
References: <20260928-b4-ublk-cancel-stop-v1-0-4a4360232a46@toxicpanda.com>
In-Reply-To: <20260928-b4-ublk-cancel-stop-v1-0-4a4360232a46@toxicpanda.com>
To: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1790611254; l=2328;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=OK9VYCvcNxGcMM+mG3wjRDISOd7f2u3Ql6cIqvbqGSc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHe5xJmPDflD3SBKsXUtuxb5CzfenxeuXeV1C2g9gM5w7Y5k5AvUCs3x4cgxFO09Da+MOksxMQ7
 +EGsxnugpJQ8=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

ublk_cancel_cmd() marks the io as canceled, takes the command off it and
completes the command. The next patches have callers which do the first
two steps under a mutex and must not complete the command there: the
control paths complete with IO_URING_F_UNLOCKED, where
io_uring_cmd_done() takes uring_lock, and ublk_fetch() takes ub->mutex
and cancel_mutex inside of uring_lock.

Move the marking into ublk_claim_cmd(), which returns the command for the
caller to complete. ublk_cancel_cmd() is ublk_claim_cmd() followed by
io_uring_cmd_done().

No functional change.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/block/ublk_drv.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2ff6506b8664..99ac56d36dd0 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2778,8 +2778,11 @@ static void ublk_start_cancel(struct ublk_device *ub)
 	ublk_put_disk(disk);
 }
 
-static void ublk_cancel_cmd(struct ublk_queue *ubq, u16 tag,
-		unsigned int issue_flags)
+/*
+ * Mark a fetched command as canceled and take it off the io, the caller
+ * completes it
+ */
+static struct io_uring_cmd *ublk_claim_cmd(struct ublk_queue *ubq, u16 tag)
 {
 	struct ublk_io *io = &ubq->ios[tag];
 	struct ublk_device *ub = ubq->dev;
@@ -2831,6 +2834,14 @@ static void ublk_cancel_cmd(struct ublk_queue *ubq, u16 tag,
 unlock:
 	ublk_io_unlock(io);
 
+	return cmd;
+}
+
+static void ublk_cancel_cmd(struct ublk_queue *ubq, u16 tag,
+			    unsigned int issue_flags)
+{
+	struct io_uring_cmd *cmd = ublk_claim_cmd(ubq, tag);
+
 	if (cmd)
 		io_uring_cmd_done(cmd, UBLK_IO_RES_ABORT, issue_flags);
 }
@@ -3224,7 +3235,7 @@ static inline void ublk_prep_cancel(struct io_uring_cmd *cmd,
 /*
  * Called by the issue path after ublk_prep_cancel(): a cancel which found
  * the command before it was marked took it off the io and left completing
- * it here.  io->lock orders this against ublk_cancel_cmd(), which sees the
+ * it here.  io->lock orders this against ublk_claim_cmd(), which sees the
  * marking if it runs after this, and completes the command itself then.
  */
 static bool ublk_take_canceled_cmd(struct ublk_io *io)

-- 
2.55.0

