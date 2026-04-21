Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695CF3803FD
	for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 19:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776800869; cv=none; b=CepUdqOZmcUg3TmIAaIo/HbA/ooSYWr+DHSeYhj9b9dqN8BmVAvUJ0uAul1RClw3mDqVjTTEsR+R23wI6Lj2IVTQ9aaIYu/nSPji3ZsWjUrFkqOmQyVkklbEr/0H0O+FwoUAx57T5ASfO3iv3wlfSWY2qSL3d8rOi6w/C/nsq3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776800869; c=relaxed/simple;
	bh=4sNNErw2gAPyRIYm6TjTmGT/loyfw3iDZAk666ZzaU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NI3/9v/vspZgQqMhX/CBsKRD+BFMqvnhbGEW3eJveWTi78FUYZ/BHnD3YyMgrCdlHIRFa5R3PdwDduiAHrgMisH0GO4bMQRgJdAMlz8aI67Tj29g7CxDUJ3MXIMh5Hs4adoV9WMqKtUTf8nBI0Baj3C2NRKjTBzFXsLl6frLe0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=N+d3scJ8; arc=none smtp.client-ip=209.85.160.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="N+d3scJ8"
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-41540f23deaso426556fac.2
        for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 12:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776800866; x=1777405666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PczJzLTjB6v6Bolkhq/enF3XwnBjQpdRCoqwwfPNnM0=;
        b=N+d3scJ8HUCOFQkEfbWGpnQ8iq6sp0CEIPup8vni/H34SfzKGCDaHy1NPyHKZl2OeO
         xANSHcGMAAN1TV+8tl1ePD43Y/XqtP118JDvbPWaAXE9m7zGZVB+Z+ZoKc7883aXrh6f
         b+jnL0Pnpm3Se+b2171xAUhsOmT8jL5FCZ022qtEd/v+taUUeVDfmVRk/jQoXefMTtUN
         XYpUhpMcsNi/y608iK6kIfs2aS/pkw/wOiaajsCrmKMysvfN7WZNSsdC7j6vRMrsV6/x
         p4Q4pE6FtIhWyfEXqjPVnWO/xDU4hcXP1pWRSvYe/ngk3ydK7PMa88F1Mi4/GT5AX1Oh
         fPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776800866; x=1777405666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PczJzLTjB6v6Bolkhq/enF3XwnBjQpdRCoqwwfPNnM0=;
        b=QhdKTbAjXc48QgVmeceQY6YqbHTq9LQvIfop5P4ZeRnOWbHLWtp9Rwe8NuFNgae0E/
         fu33i2mW6uYNwSyUEpdMi0ebZhQ4mkaNYQ2MrGaeerHwSJ+KdQY1WAlkS4UeVUGb+4Gv
         zs+cq7oe/hysaVR0q/H8+7Ekte5YGJ3BrdNm1uCK11ZRnv3sZESyFc5JZHtc9YYV89gb
         0hptjm6S8Va1FvBPchqMBUGXt1MVlbnPbp1fnzPtRA07Bo9E5t2rFs5CgSUwOgp4/Mau
         29O0YNiNHVrhCMJ+ZF+ze5cbOX5u5DqMZsM5AAOnIGJksXSLiMKxfK6QVvHgK4i8paye
         mVuA==
X-Forwarded-Encrypted: i=1; AFNElJ/15NCkH+2DCGhmiZCdQe5hPV28241nFF8rvRd8VXQLQ/nT3NLB8mWQMvNnFuowHUY+UNPswaMKc0xZIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOm5ous2Keg4Aw6meXBZnUzEbywsfxD/mMrQVarhsy/sD/cPeL
	41Bf7ls6qJZwDd29bur8CtrgJPxx7RS2i/Wr0wjdToqQyDkhHiScDZ7O5XNm7NHWo2vpg0yzGHj
	jrZZMSnOdTdxhy1mIs+miryCM0hhMBA0/FoLZ
X-Gm-Gg: AeBDieu3xvjmKXo2Hs8vjuoeuinZM4wBW/xQ5TkyT/O2GqMuJqTD8gPD/OR+Cw9T1mi
	tR9vWsAOivTEElFwhWXFIj/wvNigMAR1h6lgFsyHNcqhsjMiSdUFcNdLDJZ2s8XzOvl0hrUs84H
	JF13YCIKLn2aw4ZFtgp2N5HO7aWaYNih+ddmBUOEKILhZKgT7iyb2E7hZ/+7wqPKmFLlATBwhQi
	e/anRqLMMhvXy8LLGEIlV0qySOm5xLK+k9HiCpirZCfoITL6TLeVxXQyTslV4LD8IHvRfIflMct
	gS+fbmXqi86cquWyLrDfed6u8ExAsse7i6ikXMJsm/XTG1WNaMXICPCWeuKat5qEXp0hWhRonQ5
	US72juAVbtVsSxX5aXWUIoJJoKG7PP4Xf2HAx8hp17WTuHBxkUxIrZIOsc6hdng4i
X-Received: by 2002:a05:6871:d204:b0:417:1b7:5b9a with SMTP id 586e51a60fabf-42aded74a43mr7838417fac.6.1776800866257;
        Tue, 21 Apr 2026 12:47:46 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-42bd266b8d6sm822149fac.14.2026.04.21.12.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 12:47:46 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id D10F9340576;
	Tue, 21 Apr 2026 13:47:45 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id BC38EE41A9F; Tue, 21 Apr 2026 13:47:45 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ublk: optimize ublk_rq_has_data()
Date: Tue, 21 Apr 2026 13:47:42 -0600
Message-ID: <20260421194744.1524637-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_rq_has_data() currently uses bio_has_data(), which involves 2
indirections and several branches. Use blk_rq_bytes() instead, which
performs a single indirection with no branches.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index ef8a0705e68b..5f9b3c3876f4 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1172,11 +1172,11 @@ static inline struct ublk_queue *ublk_get_queue(struct ublk_device *dev,
 	return dev->queues[qid];
 }
 
 static inline bool ublk_rq_has_data(const struct request *rq)
 {
-	return bio_has_data(rq->bio);
+	return blk_rq_bytes(rq);
 }
 
 static inline struct ublksrv_io_desc *
 ublk_queue_cmd_buf(struct ublk_device *ub, int q_id)
 {
-- 
2.45.2

