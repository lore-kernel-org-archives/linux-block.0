Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D604439EF10
	for <linux-block@vger.kernel.org>; Fri, 27 Mar 2026 22:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774651152; cv=none; b=g2xHY+BJSBuDjLI4l5BMA4CYY1CIzynI1pjgbs/BYoVrxXvaYlcsxhPBWMKLEUFYELGVbJxzOomEEXZFwDWS3WKdsFopdvmPGOOU75+X1otLaVbHR/WRRZkotQVyT0lvqJG28Wsy3KuIAluoLzaK/I7lc0pOT25n3s0M5nvtiZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774651152; c=relaxed/simple;
	bh=+Nsa19OovgMqEcmvVQXiBO8rCDFiw9aSSGKsvLNQaOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g2uQWgaEPoJLaYMX70jEXiqpdcid4SkK37HzEBt4rvW5UAM/CnczXR3rSMhvz1MLli248G6sTxt70qwdZrloSu6NVuDQtEE3aJHBwSIhOliK+R80p6QHJAOOWp1NiZH0Q5f/FTWwzErgbTukb8LbxXS5L+jq1ratPncVwpgl21A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=Tf++QFKk; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="Tf++QFKk"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43b41b545d9so2722140f8f.2
        for <linux-block@vger.kernel.org>; Fri, 27 Mar 2026 15:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1774651147; x=1775255947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mk2UWFlmHmW1dHnQHL6sTA+0nfmMZ6Ah6Xrxf7Z8Aq0=;
        b=Tf++QFKkmkPMWhjypEIJ0LfQ+zeONZLXcMR105trxW0XgH3+8tbQLsz6/7SrfHkeQD
         owLVAUbCnx4NmIOq49BaS42iKl6yehb4kxl9ZeJZ6Ztf+tX/vJt4AcjcjWRJr3PcKCFu
         FwCuJuUENjH4rI8IxTZPFJwCpxUS703EoOhdHXiFz2G949U9/l9kEMqyvM1QM91+oQRq
         asEMliSHCTndpKoXEIk672DLCX6DzERc0TZpdVOwqkGx2RU9jlgd0XSh72vhVKML3nag
         pzsPsXk2z5YO1kdiUbSf3SqKeYgFU5z1uKqNIcLQ7DCpe6QruJt58aPdUhfdsbNyOGfR
         aKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774651147; x=1775255947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mk2UWFlmHmW1dHnQHL6sTA+0nfmMZ6Ah6Xrxf7Z8Aq0=;
        b=otThZqhmZxMYl7HUm3IPVz16aJEkzcbuqB3+Cl61Ha9MuZdm6UpsAucSNftqoRsWHR
         tm9rQWyW4c7vObyOc4AYjZ1uoKZxp3r+DGorktTLdCwlco3C6sg2yPl+nRK4gPCG0TNF
         xYg53UkH0+elhGsJC4fVzwYcjA6ML97InQYYjbSvsDz19kBa3cdZKJ+QcjI7KmVAW6Uw
         8+HCUn+EQEgt8qq1oYI/lQuTpkWg+mE65+1kyKS0akfleYj2rr5FMxbX4M7luBGugKuq
         V7/l8ipmCUdFmRucTCPxuivzU1DrmnrgIP5lY7fmR1GxHq3WWWYHIhJsqCwwsusb1gcx
         WU3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxiWk2KcKbaTcgU3ck9sfrbdjRwqalRiH1iMxyp7d9Ipv93ISVNvPEK8aSatvnkCBNnjcDNrEeMFLscA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHO0WbIQ/aGLaacIX513ayTOK+gexwOZvMFBI/xmxv09/DEBlE
	mqbx3qCHTD+FcqHLLx4LbMdaRrzw515GQCLNMXkLIfCb/GYXghDRHRtLdPTJzcx0SD4=
X-Gm-Gg: ATEYQzyXOXEvSbuBl0KRnSoR8vsVd/nMfq6QqUnGo2YvJFtirCA2Y5ns04v5bazwr+R
	jOl9AsicoPj6AdKR800AMhV08Tnp1S62xOArBKDWv1XSDeq0AsCjmFag9Vy+o69DZzHPq+0vHtE
	USHqzrm7wsLkFXrLLqylt6wmvizpWN22Z61tV3KPZcAty62SYL/tL6l2V01qnDD1Yy8j5yWivB/
	i5r3TWGEsIcXwH8xJRGFXU1yB7aABp5RvExUx2DDxlMZoyy6gc+adriN11qHQXZZ2W+bwAZq6j2
	ElSDSLEfSQ9tJl70HdYrDElmaNPXtdjmM0wDlkioRChMpP1FzSydk694sXqW1P/HfN3qpv0306p
	Av8BHUfnQ9gg4A5nStKAyjpHeWVYYEOhaEFZ4HoPrqQv58LggYEnAsC9sayzNQ/UWu4gcGGGllc
	ECguqrCiZrh1DfDNDoMxsH5FXhSffcZjOiu0S74QL0jP2R7HsZhvrQ1mJEg4ZOh0lbeJ3mHUlio
	CjZsBw/EzSuQWzijAZtpQ==
X-Received: by 2002:a05:6000:268a:b0:43b:4ec7:f90c with SMTP id ffacd0b85a97d-43b9ea4a504mr6983962f8f.26.1774651147293;
        Fri, 27 Mar 2026 15:39:07 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf247079esm998990f8f.25.2026.03.27.15.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 15:39:06 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Joel Colledge <joel.colledge@linbit.com>
Subject: [PATCH 10/20] drbd: rename drbd_worker.c to drbd_sender.c
Date: Fri, 27 Mar 2026 23:38:10 +0100
Message-ID: <20260327223820.2244227-11-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327223820.2244227-1-christoph.boehmwalder@linbit.com>
References: <20260327223820.2244227-1-christoph.boehmwalder@linbit.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Pure rename in preparation for the DRBD 9 sender rework. The file is
renamed to reflect the architectural split where the sender thread
handles per-connection transfer log processing and replication data
transmission, while the worker thread (function remains in the renamed
file) handles per-resource background work.

Co-developed-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Co-developed-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Co-developed-by: Joel Colledge <joel.colledge@linbit.com>
Signed-off-by: Joel Colledge <joel.colledge@linbit.com>
Co-developed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/Makefile                         | 2 +-
 drivers/block/drbd/{drbd_worker.c => drbd_sender.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/block/drbd/{drbd_worker.c => drbd_sender.c} (100%)

diff --git a/drivers/block/drbd/Makefile b/drivers/block/drbd/Makefile
index 1f0776c65349..af482bea1af1 100644
--- a/drivers/block/drbd/Makefile
+++ b/drivers/block/drbd/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 drbd-y := drbd_buildtag.o drbd_bitmap.o drbd_proc.o
-drbd-y += drbd_worker.o drbd_receiver.o drbd_req.o drbd_actlog.o
+drbd-y += drbd_sender.o drbd_receiver.o drbd_req.o drbd_actlog.o
 drbd-y += drbd_main.o drbd_strings.o drbd_nl.o
 drbd-y += drbd_interval.o drbd_state.o
 drbd-y += drbd_nla.o
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_sender.c
similarity index 100%
rename from drivers/block/drbd/drbd_worker.c
rename to drivers/block/drbd/drbd_sender.c
-- 
2.53.0

