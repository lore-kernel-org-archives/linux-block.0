Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4531134FF4D
	for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 23:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773789803; cv=none; b=Vx0DWww3G5WYQLQ4nwExlhWH1FaC8GYjOwPP4810c1w/n7PhD5S6d0SJNyt5mgMevcvfcrXUq3WnKnWJ9UOfbMCKiTT5bQ1PuBYkELx7T/NIIqpqcO3ZEa1qIfqGuQNV/vh/MVerESJ4NVpCaIo41ePQPSFGNg1P41dufUo6dUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773789803; c=relaxed/simple;
	bh=+nWtQs07r0pE+Ze4LkjAmQmhutwoys7wbSABJeTYcqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OdzupMjjjkaBWXLGaBZSvyLSYKgVPsuSrb2UQUtMJgDgQJm+TJCx7xLzhjUrlp5HorJeFtI0Vh7Iw/4MEZt6iRslrn2Qh5lowSFKoIP1+KIeuvJpYRYuEkFDyF8YR6TG8KAEu0mM6QJ5s6lxm03qnWgu7m4eibHzBx8GvgG6eiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pb8qhOux; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pb8qhOux"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-793fdbb8d3aso64220207b3.3
        for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 16:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773789801; x=1774394601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bBa9pDPqbGfhOBwqPMjjiTOMbtTfvieka9d6hhFj70=;
        b=Pb8qhOuxXHE5LBfgsEwoSIB8p8wiHxRSdWJFQ9+ZjO5KpbTEaK+n/09xTFXwa9kYx/
         gSMEQfnYtD9Z5NzXmgyPZETu6TrpUWhZQfQC8VjavUSj3jMF7RIVUDky6BFL6Uwtv60d
         ZuegBAvYD4FCtdzmYRV4uHolZfAtUT43306IPNrJ4iKfxpFVN8+4VZhHeXSldMbv/E8f
         HJkYWr+qc6IxKex1ytNQBSYmpapP1j3c9Tb4ih4RnXBPNyn8yWLijH+ciZgR9k7ISlBw
         yDN5RCVqSfh/FjwkRCTPGat2Xzln2rJ5XaVlKk4NknOWI7ONhirRUBFHXpPRbUwqgTT8
         J5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773789801; x=1774394601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1bBa9pDPqbGfhOBwqPMjjiTOMbtTfvieka9d6hhFj70=;
        b=I3Bmvi1GWK/5Hvy2ios0SFt6MrjMuGpuvk5BEF8hE34uhNB1LjXQyN6gG0iIgShVNO
         5hTnjY8EppL57FDO3rYjabKq8ouB7q046ePdsiXohfTOsx59TbjY6zNwJxhQCpnWL/G+
         cOryVYk00ouTK3BRewJdkWQwwnb1h0iv84CSzZDTErLCseaFHwbOlk7TroW5vY5I8Tg5
         s+8zGft2TgH5jx+HjOfThqVtGHq4DzVvZ9eikktQAsBfzMaDwXSY2t1sW0qAfrQWKF63
         ZQPPIw4K6IrAucdb3VQ3jNuva42Ojviyk+t7p0R/uAhYcK0RkGbog0sk6317YYi+s5yV
         P14Q==
X-Forwarded-Encrypted: i=1; AJvYcCXXpnZ4TeA2UO8kraFCjl5BOLTW3/Bct3txAJsOsXmSEiz3+pJ+fOC3bcHp03hcql8ydtiEPx6jSrQ/kA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhUQlvchbOMBxWGzZtO9faoQfs/X3S/tafa6aaKxavWM7i7rih
	sOwNlJakzzCCRSTommlUrsJSdtB+PwAPK8Gk75Swxgorbf1mxf+gDBRy
X-Gm-Gg: ATEYQzxp3xlPXgj4EuoU2D9T/VXYgRmQifqdomdmF8sp2dM4loxhlPN+Mbd/A1jolaw
	1WughgdUrGcEw+0VCkddlO3lRq+sB9iT8ic1ScuM3cqsC40FOZD9J8UF4EMm0lgtTws3JaIWxIj
	KdhNyrzuKFQ1SOGCM0D/3TLQLaRTDGN0giUtHXMs0aHBgYBt+ELAs1I3EQk84Tdmg4n0xTrKinH
	NGfg143a6mS1Nqwgh2JDB7mmZ8juLlImxyyuT8Y4LUGmDj54oyO1tu4+dV4gFzPBZp3gv+yYOs5
	8aH/SKb8eXUqHFIqSOBJxcPYeRoCnsD4nrScJ/h3BZEoZXEbnlagm9zVuy7+pIzmuH4Sjmv+b26
	16HEHjSWDT31P6QPy/P4FHQeZ3Clu+rkYwrg/ATpZaS8n10v31899UONo6KWuQ/q8Qve1WiefAs
	17/EHERE8JmnMPA9HIZ2XGjKmXCLr7MgThRqel1gG/J/lat8Sym1Pfqmdzi/83Y9nEST1KLcWhq
	WwlZRiHdpV0NFXHc4IF9yn/
X-Received: by 2002:a05:690c:c1dc:b0:79a:3e2a:7b5e with SMTP id 00721157ae682-79a71637f2fmr12821057b3.0.1773789801257;
        Tue, 17 Mar 2026 16:23:21 -0700 (PDT)
Received: from tux ([2601:7c0:c37e:2360::f769])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a715d221dsm6858217b3.37.2026.03.17.16.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 16:23:21 -0700 (PDT)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH 1/4] drbd: Fix out-of-bounds access
Date: Tue, 17 Mar 2026 18:23:15 -0500
Message-ID: <20260317232318.18923-2-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317232318.18923-1-ethantidmore06@gmail.com>
References: <20260317232318.18923-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The array sync_rule_names[] has 22 elements and rule is used to access
this array. The variable rule has the possibility of being index 22
because the condition (rule > ARRAY_SIZE(sync_rule_names)) could
evaluate to 22 > 22 which would be false and then rule would be used to
index sync_rule_names[] which would cause and out-of-bounds bug.

Change condition from (rule > ARRAY_SIZE(sync_rule_names)) to
(rule >= ARRAY_SIZE(sync_rule_names)).

Detected by Smatch:
drivers/block/drbd/drbd_receiver.c:280 drbd_sync_rule_str() error:
buffer overflow 'sync_rule_names' 22 <= 22

Fixes: 851f106c134a3 ("drbd: rework receiver for DRBD 9 transport and protocol")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 drivers/block/drbd/drbd_receiver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 06d83b5ffafb..280be2ee7d7e 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -273,7 +273,7 @@ static void drbd_cancel_conflicting_resync_requests(struct drbd_peer_device *pee
 
 static const char *drbd_sync_rule_str(enum sync_rule rule)
 {
-	if (rule < 0 || rule > ARRAY_SIZE(sync_rule_names)) {
+	if (rule < 0 || rule >= ARRAY_SIZE(sync_rule_names)) {
 		WARN_ON(true);
 		return "?";
 	}
-- 
2.53.0

