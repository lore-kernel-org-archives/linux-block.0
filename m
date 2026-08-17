Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235ED3B1B4;
	Mon, 17 Aug 2026 01:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931754; cv=none; b=lq5ZHlAFL7n79h4CiKEV3CS8r8lpL66zg2+Z8Nldc1i//ieOmukhVthX4PK2+15P50Sh+jlzkbczxTY+6u/p5XTPPYsSZtFT7bHQ8N3yUfLHMBz8LveOQxgtaAX7jatdrxn6qkhx9j5oO4SAWEPw5I8N8JhTZ7Yj/DOc+Y6jAxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931754; c=relaxed/simple;
	bh=dWPrkfs/YBpk5pIzLBQ3Ca5UUgv304wkOM2A4qhnC2w=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=uAnVYw+VFXvAYeX+JXDBSVq30FYgDfuEsnwPX0bZ5DmN7zzdv6lrYiTheTntD3a+9JWSj+nAgMWX3gwS05VprDX8eiz++r5YYdsiAerYAEZRbnRyxWtCz6Qw7034+kPAtwe9IX//hjUErQDl3yIOwzWsyHSI/i4igMgQbsF5WsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QfIUwvQJ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QfIUwvQJ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 61BDDEC021D;
	Sun, 16 Aug 2026 21:55:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 16 Aug 2026 21:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786931752; x=
	1787018152; bh=lfZv3tllxNBkGbGrLZLjcEZUu+aYZBb8E3RrIcvdebA=; b=Q
	fIUwvQJotlvsTreuTYukKy6LYSu0XX0BO89x/pCdcuD1Uzv/F+HrGt9YQ51Recw+
	BrPY7I3sMPOjcSWfmEi8nz3jdnk2TwCTv+tmCKFHWseHytFL/Pt9kwTrQxniWpAH
	vDoR+cpqlmlj3ptQ9kwESuPD35ZtHNIp0390kqltZbHFkuPc1vCkvICvs/NnuXku
	9sNO/6skEowgcFtcJyw53Lo2SpJSrqMIhpAA86A8q2kkYZ8I3k+7BJMW90RtCAez
	72sPJElOeNHR1XXhkRmx2QqSL3jLTIMmkNpcpahjZrEMmwprRwrLsXZMNJZGbK9P
	J35XTr0djXYjpSLkRO1vg==
X-ME-Sender: <xms:KGqCaoAavR5jIRT58-PpDyxgWkXveSRcqzgeyThhY8LUOUIj9m_Q_A>
    <xme:KGqCakmooLx_ngZPlxZjzCFZh4trPnwfL5ueDX07aTnbsGdeuVdC1pFSJqSUlfYHR
    xqR72MY0lpe31wP7PitBlddwq7sRp4dxCmXIDRcUOZDW4O84F8wXO2u>
X-ME-Received: <xmr:KGqCareYv4zDkx4DcTJ7qXPGqES-iUFjIn8RNxv5ZY-Kb93HxUlPueNjhck_0msFAmsHl5OiidWUszPanCG8M3vgvgnI6bA4MG0>
X-ME-Proxy-Cause: dmFkZTGNmzENqalxDTfCkkFc7mFU+8/8u51l4usXC2H+kPVL/IH2s2NYJxgIYjtBYtArJA
    YWtyuDuajqQPlQd9d39HppQGgAciKWsN5vaSeS8TTvkVHVx1RLPosXGbRFJQPSd5BLLYVy
    eC1VIy4/prdxHqOKz9F9XzgS4LWYfaliKe2CMViR9dDdyGPbLM90F38TD9YW2MkJ0tIv5F
    Ml4DBCJ2CjSI2ieswFMFy7Ro4IzVcMw8i8Or1S6KLLExG4iRUFFS7PoCzWwG3m0EJF7GAr
    uN2VwdTVv1tA6XFTaF1EIrNDccscfKI9P6vDWUSZluIhB0JYi7lhYJmYYZKiGnpyDh4kJd
    SDeJ83XA+cDklCNjM/In18HHxC3Ci3BrVAl/ftjyuaIQvYge0qp9vDZHt78h7bSeCnL1Sn
    Zf58VHdIFidOQbBHR22SOYTmhgU9J2rLEvnlv12fqazee1m/E/t6HknhE49dNCpb9japh2
    T7MceQCf8POf0Gbb/nHkc4O0gIjtH6I0E99Cp7dqiKToxc+R4Ge+WVn/FwlNs0pcFwctkt
    boH7ASiE71oupPMOz2vJFUfBz6We8Nw4cQKpKsrJEzc8ALVoLeB/VFwyLDr9FuVLwnXJBd
    4dq5VQud60a9YTS+qiAKxb+r0/EEgdoVZNVlZHZHlciQuECWK2RAID+MlQ1Q
X-ME-Proxy: <xmx:KGqCagRr5Rnm85V5BJQmG6BZg4-drPhQ3aVb6BKgr_ngUynzuvD29w>
    <xmx:KGqCaqvmENiSsfkTv-gvtHRv-IfFz2zh7vbFAG-oZBGShIUCU4Pntw>
    <xmx:KGqCapf2_JIgRvh44e4tc6iMgykh065CMb8lUY1AryhvxgTgFHFsxw>
    <xmx:KGqCasY2s0iN24dUsFzbBpow4NT-1As72hyaUuu8cqtdqTPxkFwWwA>
    <xmx:KGqCaoMkwKLKWIyfEEQQkrfUTfnhwwP3yL1ZGMZmT4H2MxfinCGOcGvv>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 21:55:50 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <45b77aeeec9775000f46750766ae1186f76c879e.1786929430.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1786929430.git.fthain@linux-m68k.org>
References: <cover.1786929430.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 10/32] swim: Add track zero recalibration delay
Date: Mon, 17 Aug 2026 11:17:10 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The UPD72070 spec indicates that the track zero sensor can take 3 ms
to stabilize following a STEP command so add a call to msleep().
Remove the duplicate swim_readbit() call as there's no need for that
once the sensor signal has stabilized.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 9abf93bc0980..c9cd0748c878 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -402,16 +402,15 @@ static inline int swim_track00(struct swim __iomem *base)
 	for (try = 0; try < 100; try++) {
 
 		swim_select(base, RELAX);
+		msleep(3);
+
 		if (swim_readbit(base, TRACK_ZERO))
-			break;
+			return 0;
 
 		if (swim_step(base))
-			return -1;
+			break;
 	}
 
-	if (swim_readbit(base, TRACK_ZERO))
-		return 0;
-
 	pr_err("swim: track zero recalibration failed\n");
 	return -1;
 }
-- 
2.52.0

