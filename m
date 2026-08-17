Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8F52771B;
	Mon, 17 Aug 2026 01:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931908; cv=none; b=UuX/8IWV+HIIxLIoVvEcBzzX+LI0bPsecXEEDZK5QHOym0J6kOL3Pii1vEm+X7tJNwMeRk/RCg7s0tLvD/HuA+iR7cyQ2v7Vqwo+1CyuUbW6PvU3YlQri2gWWge9Ac3Lqc5/+uYEdibGFz18z9geEuoTvf6yvw4GkGOzEevWc7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931908; c=relaxed/simple;
	bh=aXLo1JK6qFUgLHFQIIM/r09ViSkkI2l1Vbvy0xub9j0=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=Gz49vIwsoy5iVtvNm6b1z/224FvLlTl6+cAIuHyc4AM1TzYSWQZBML9hapAz+tJmjYmfNeRAtb088D+C0tIBOeWnryc3nzWxckUm38qg1L9KKIxCyJ+hL5V/bVSalHcgl0qL1uNkG/pyk9/8nlHjH5KFbbEHVBB6FA7OOpsHTko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jIH9uMGO; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jIH9uMGO"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id ABEC1EC0203;
	Sun, 16 Aug 2026 21:58:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sun, 16 Aug 2026 21:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786931906; x=
	1787018306; bh=K1LULaoZc5SGoxvsL/uTCXlF5BYDi1pVX97BP2zuHTw=; b=j
	IH9uMGO6BX4VipXBgEY8bZ7VikQ3Q11bGCrnyArMIDviKFrQFARq9tPA3JXE8RNa
	w+6em2i+gfR+zfLkCkJWMUEkyuj+gPw4rKvoTO+SXpIED3k0SQRHHK+xDDp0U9Dk
	P/KDs38ajZc71KyUJTapDk/MamPTCs6ibiHNYvTEfEuW7UEFZXnnOPp1Y/B7ZtLU
	bkO1JKJmqBYsYTEAN0eWHROj6caLRM37p0jCOpCYDoFncSYDb7lIvUXIoLn2cjtg
	YZ9eCL93eQxw8LfnDlaGJzyOfLjjkCWyS6aVq88LeBG5dsfGznfh9e7Q0I7+ggOb
	z1BkVUYeZ6dOa6l3oOlPg==
X-ME-Sender: <xms:wmqCapYaQGwceI3ip_3eWS9ZHW4s6P4emUEA_L9PQQO4fwyRQ1_ofg>
    <xme:wmqCaqd1w5fdQEsMU_o17_ETCporTqU1Cxd6GkLdDFQN3VM-1wHVOwYpx2LP6QT3z
    9DRGGHrI1a9Tt1HAtifqdx4UBJF3hYKuexo_9HJwS5a1oZfU2TFA0U>
X-ME-Received: <xmr:wmqCar19u_VdfXtZho6zykw2RMMDv0z7l5aHiU6NtFqK6HTPS99-mg0Bnc3MYHDeHg3qaqrCPcfqN8U1p-jMI10MW8dzAINt0LA>
X-ME-Proxy-Cause: dmFkZTGGfSHbL2fI02qi3PxN23Kck6mI5WuUw/IvRcvpbY119ewffFmgrLaJZrOewmv0V9
    +yVjmNFRAF5v6NwN93pp2/ef5Xe4c3LI9irOXMRuZYHRPaDMJE6WMter/2+BypR/48/QT6
    HY5IjuzvgSjmo92SyO1FOx3Pzj+F3Bo7QzXF7kAkGOLlhjpoHeFsUQfm7dkDIAS3zbzZQZ
    kdzEEhr46dUOQtvTauSfnNDphJtrhISaD9OmmoKzjI1J4txcn9eV52lgr1VrqNf0UkcCn2
    OchZn8Fy5DmAdO0OzTlRhd5sxDSBZbWOqIe4VCopfX4yIdP6r//KsVzdicR3q2dH2I0XrH
    U95mLLql20IiJ6F1orgyA0rNkl4tL+Una+djqMYtvAdpRj+9+dZFc353ODd3HEb3pcKQmt
    GKd+moC1J3lRiQDubiGRhrMO1zl/U0GodMKmBQ4es1frXO7w75LL6Ra5kWV51fSpIyKNNS
    H5B2p1gjAZqm/Jm0P1YEJv/JrZ+4L53OTZwlT8tgE8vRWIlJ095Z02IIY6MoCENLAk5CYq
    6KU1CkAwpUZBsaZlQrfbMVzfE/PlqD8gBoU4I2toN0I4rVpF6NpFM5HVKWpZHd3FHRXUi+
    yYo+BslZXhFcRaLOx0DJ3kKgutk6YTS0+2U+k71hrqXLdzkPeGWW3kJO0ehg
X-ME-Proxy: <xmx:wmqCapJScXIbKGnIGQDiv-XcWEdftlmDKvVWiMDy1-uwbMULCq0bZg>
    <xmx:wmqCaiESlNgXAPkF-6ojQp7TjdElxztFMuvBcSFUHrngtGlw0dBK4g>
    <xmx:wmqCatV7qggYYgw6SDm450oYBO5KsO3dW63NTOlYu3JnPN7lS2lbqw>
    <xmx:wmqCaiymcuIMkHM1Xynmnuv17ELkuMZmYtxJM_z5ZKv3hQ84oO5LUg>
    <xmx:wmqCauLlYxYbaVigBn6VYuXFPvPvbj5ZMHyLfRgpHKSkmzKJ4LGbD072>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 21:58:24 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <2edba6fa539e96afc0e9412ea81843b3523b60b4.1786929430.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1786929430.git.fthain@linux-m68k.org>
References: <cover.1786929430.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 26/32] swim: Move swd initialization
Date: Mon, 17 Aug 2026 11:17:10 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

For better readability, initialize the swd backpointer along with the
other floppy_state struct members. No functional change.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index ae31b302dac4..c204108c50f0 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -761,6 +761,7 @@ static void swim_add_floppy(struct swim_priv *swd, enum drive_location location)
 	if (swim_track00(base))
 		goto out;
 
+	fs->swd = swd;
 	fs->location = location;
 
 	fs->type = HD_MEDIA;
@@ -849,8 +850,6 @@ static int swim_floppy_init(struct platform_device *pdev)
 			err = PTR_ERR(swd->unit[drive].disk);
 			goto exit_put_disks;
 		}
-
-		swd->unit[drive].swd = swd;
 	}
 
 	for (drive = 0; drive < swd->floppy_count; drive++) {
-- 
2.52.0

