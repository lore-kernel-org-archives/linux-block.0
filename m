Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7173E221554
	for <linux-block@vger.kernel.org>; Sun, 27 Jul 2025 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753634846; cv=none; b=hAjtmw2P2otDkwY1lcpam+12QpvV+DV+ZRWN8fGZAnVvYbf/mSv9XFf1N+Tc5brACi4amXwroKly2QJqJQywh3f1G/cjFgUJeNYKyhgQnS/MyANvnu3ZEsj/Zz2jhg5ieg/wZkb6NzBfFzwOV7BD/sSlbtLw5mvenNKW3hBDXf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753634846; c=relaxed/simple;
	bh=HKybxJbAZ7QkEnEA4dC3PJkGsGcMK5dMhQWxitevWMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jdxbzKVsNORLc4lEyNLPpYeK0168UdLc9vjXq9cYPKgLwo4oObPfiaGtA4Gr+LzvytHt2KZy6ULbQuub1cSUzdvt2RE4Q2TGbO+1kbm7F+DuMTZFJMLX1EHjQb3V2I6rm+lSHrGRcpvt9l7WPaVQpaIfHVwY0NhhjWga2iQqHTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=bJgv4qTb; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="bJgv4qTb"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-748d982e97cso3321829b3a.1
        for <linux-block@vger.kernel.org>; Sun, 27 Jul 2025 09:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1753634845; x=1754239645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+nlZLhgbzNu4yHryVz/Cin3yxvevrJXaOVe2qbhyTGQ=;
        b=bJgv4qTbFFumPxlLpQIvVEWvmeXQs8ZDqwY9TKLco6itXAYh2deyYFwRhz/6VODmuz
         dI1Figfge0QSN2zFi3cIESyBESCJf3AZOjCVS9etxGPuH4VfIfJzNtx6vLdkCe5jJn4C
         jGRYyvs5C1/goNdYtJul9RjBHtjPPHwKUUv7kUmahYcPEdBRAL9duRxi/mElWAMImXzm
         IKEOCU/x3iwDgAYcnfrzArzWV5e+ZXezUy3/fZpc5L/I4hOcL41vPJib2PVbgynFxSj+
         QJg8L6rVIyd9bWprVskQsbqbMs4TCXUjn/QPFv8o4+yRwVNcltFne2udiRJ6S2379cSH
         +N9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753634845; x=1754239645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+nlZLhgbzNu4yHryVz/Cin3yxvevrJXaOVe2qbhyTGQ=;
        b=LHMkSmoOBdSkdoldlG004Fv2WLF6Ar6m++MPFdYbrFHvH1iYFDepnG8bYqDNEWWqwS
         Q4yM3v5wwgu1S5J6+LbU4dsSsV/SN4keAK5ZOrcjDuyz322hMrK4Uq4b6ESp3IF32RLz
         K2dgg7h6GzZVmMowKBiHEG6dG7fvSld+g3tzxsmm6vFBUuF15eEq1JRCqc7DwIzWmgSv
         p6qYSkGk2lPtwjon2JhFiKS8ywLYRlJ9r58QU+g/kBN4KSiYZgcq0gI/5OO6QMSYfI2d
         G++/os9ureHbmJISE9Zh8LG0mfQxzUJZ1R0UeCGm6LeaV7kEBcNC56CW2j4W0zM3gbpI
         Mp/A==
X-Gm-Message-State: AOJu0YwFbnBHh/i+a9bmdBcVeY/uXhp4dxkIYNzQJ4bmPr1gcgx8vAx2
	B8vgJNKHRwbQuzXxaOgWbzIFLiiS4lWer4YC0iMdR5F4gQbfMJaBDsjpAnRaHbFn2HU=
X-Gm-Gg: ASbGnctUy9GJvs3Gtw58XwJD8TGJdG+PsIivHb+dAsdgunBk36YBJ7Ud4yuqcA7fQmI
	ymzu98yMCu/BoUfO826w4XtejsMGhMHmv6MaABXrYvwMdy/X1+fbsU7PwmGPFOOq+vLWlYWpYez
	NS5DY40w1/0mwMGdPhh2timIfNDj1cKAYyOrCrKGBCeGyfrP1vSE8IAPxP6BxJoJjbW16XwN6gj
	hesW78lHjhZX8noa17OMMSgy96qoEH5IDLXqehjxRuopPyk6SSzKHh4MAoGbQQCsnXA2T+w2v/U
	Zc2675iKkBuya4rvadPx37A5RN2xHmqPSjU27jeUSLnRWRaTunEccEBqDjXroy+rpYgWmFhRubb
	TmO18/zE=
X-Google-Smtp-Source: AGHT+IFpUf9ixp3WbtCQwIdkg8l0/FnIXF3k5K0FTTBfnxUvBgBg78uuQYfEkC1Bz/scBmfJWi1w7g==
X-Received: by 2002:a05:6a00:1395:b0:75f:9622:4ec4 with SMTP id d2e1a72fcca58-76334fac30amr13104977b3a.20.1753634844674;
        Sun, 27 Jul 2025 09:47:24 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640baa00a9sm3402878b3a.140.2025.07.27.09.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 09:47:23 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: axboe@kernel.dk,
	hch@lst.de,
	jack@suse.cz
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tangyeechou@gmail.com,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH v2 3/3] blk-wbt: doc: Update the doc of the wbt_lat_usec interface
Date: Mon, 28 Jul 2025 00:47:09 +0800
Message-Id: <20250727164709.96477-4-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250727164709.96477-1-yizhou.tang@shopee.com>
References: <20250727164709.96477-1-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

The symbol wb_window_usec cannot be found. Update the doc to reflect the
latest implementation, in other words, the cur_win_nsec member of struct
rq_wb.

Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 Documentation/ABI/stable/sysfs-block | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 4ba771b56b3b..277d89815edd 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -731,7 +731,7 @@ Contact:	linux-block@vger.kernel.org
 Description:
 		[RW] If the device is registered for writeback throttling, then
 		this file shows the target minimum read latency. If this latency
-		is exceeded in a given window of time (see wb_window_usec), then
+		is exceeded in a given window of time (see cur_win_nsec), then
 		the writeback throttling will start scaling back writes. Writing
 		a value of '0' to this file disables the feature. Writing a
 		value of '-1' to this file resets the value to the default
-- 
2.25.1

