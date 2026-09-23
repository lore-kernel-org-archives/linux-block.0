Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFB65383D7
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 14:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790172399; cv=none; b=iC+ZlMEun37iaxjbp9BUNL0EyywPh9zGmNMVfORInphk76ceFScAkGTkUzM4XMgH/v5bXwBXEOfdmXxqEB+dgqD8pBp45rEJ0u9xRBQttky4as7XhcxJ6Wi/u/yDQ8apwBMPfpMzKOzmOReQ5nkUwWY03CSbHKa+rK0U15zGF5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790172399; c=relaxed/simple;
	bh=oTN0UkvymfxfGzObUk2qVdjzgU9xGJX4xG3MjkmtUl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VOki/LXTRZ5P9NCzgVxZbzbeGJnqiIfsKKjh3YO9heoHMGeRvMrL4KZCHlIAjJ72zyR7Y+gR/Kv0PJYT1BxHf6xJostUBX796lMNd03qXZmA18CmdicJsDpJUIjBGw5TzbBocDT2sB2Z7e1tfSnMnMmbOdNAlXAmMGxWZ5OeX7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=FcWphHYq; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="FcWphHYq"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6c0fce17so4962205e9.1
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 07:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1790172396; x=1790777196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yK7mZx0EiqY5laEgalU2cR5RMQsFjx+sycq1PNzq5sY=;
        b=FcWphHYqyBpbrHqC9vZvL1islSasW+iiys0n87KxDaYdqQNgvFAbHEsfvkp7NxT28F
         wyn2qEHNY0DJ0x6cLBtLk14XxOu1KAhT2/MwJTDwdypKVbJ5VQCJMdVY/L8NVhc/3WrU
         G4KRuNmDC5gqdSfBrYbnIdB/fzkWwqMw89sNA/kCXkaQGrj3weJDkw4iE5Vr7YcnH4if
         0wRjKp9HvBWX5AYt1I39uCbRX2yiNNHrldtylYcmnUzIS3LVM5x6qTQVGut8Nz+S9TeC
         nTVlexs2zrW2GY3pFAfxyac0Kzl3ahKmL/pMVCEptROJogdfgEW1hpYENwI+CypjnzY5
         oqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790172396; x=1790777196;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yK7mZx0EiqY5laEgalU2cR5RMQsFjx+sycq1PNzq5sY=;
        b=jCvSgGME39WTtUQqV1zstIHQ9KT8vS4a+PYOInGR3ooA7V7tq+1+OgpSSMud8S4sV0
         2a4nRJlXc446WMBt/qGfUtMf65r2ZF8EX/x86wCBXUt8g+SS8umWzPeYMK1EaazqvCsX
         VUAl8sBrMQTF6sYdly4GiGZ6F6SxZGhzUY3NkUBf7armfVBUx1M9JQvtXsoHNotG6kf2
         04JMaPux4IwZwP3uYUMnptynNhV0boHLXTJyFS7PQXWTv7HOQzfweJPN+dw3/Y0uEeJ5
         l0iPEf9/tKb2NqPzEQz4+IBWd2KUyWqN/jptIVBA4zdB95eM1p0yZREEy6csZfmCUhT7
         hpTg==
X-Forwarded-Encrypted: i=1; AKwUvBzjbRVgDCnfbPdjmkBE1bPXASG0hZ4LYvqxztkRAEaJXc8rhiOBJnKUWR5VaSCTnCBkfUhc1prxoLgauA==@vger.kernel.org
X-Gm-Message-State: AFuF++npb90mc/Y/Q8plMndGCIYJxY89Yp8VS68m1ckFoOfPBDc4v0CR
	vB4MJDjXaWDG9tAiEspjV80kqKm9/IJnM4IgI2P6Yg7KlLdKnhvaRRRtMhBUc6+8OLA=
X-Gm-Gg: AYBFou33x2iR7DwcuHC8oczCNeuu9yujdEJIE4NNesYwUDLCc3/fTt2Lset/91vpNy5
	ue0RV4V3szbUITHIXRgMiOmkZOWqdB8J8+tsNxfgnctD5XVFt58tHLipmBsGvai2QQ6nQMSM8EG
	5PowQftIMBV3+0xdUC8J7uPM+1KAh8Z4R50PflnAEvpd9BOlpvF2Ms7zh291jFJ3d3AW2zvTKbB
	lOBJsOo2fjEhOrGmrvjTpUpQGiGaWjA3ulxnEjZp7o/viflRTGH7VsfF0I7z7jkJS8fL4yeI26Z
	qVVZdznZTj0bRQRUdARwgXy83ZrglGgm31CjkPdjDgWgc5vRQ+SKif9J4/ahtOgKtCDy5QZcPl0
	RvPSb8iMjkwV9DTIjUoSBz/sLn2YSPBkMrDQn8JCLdr8tmc0DDBpHB7C+ugEGMlPrDQdfNurLAU
	TJLx8ovG4Z2eLn40/M5hQ310dA7PBEMWfSZV9ksJ+FvuiFx0oMGd1XctimM6gy3TwPQ69k18McZ
	MOjTAzzhVo80l3N/iZj3fc7XkXYRsU=
X-Received: by 2002:a05:600c:a416:b0:49f:df99:ff13 with SMTP id 5b1f17b1804b1-49fdf99ffd1mr35917295e9.21.1790172396347;
        Wed, 23 Sep 2026 07:06:36 -0700 (PDT)
Received: from localhost.localdomain ([2001:4bc9:b01f:2334:39d8:9506:1776:f780])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde18a8a0sm78087455e9.5.2026.09.23.07.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:06:35 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars@linbit.com>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: [PATCH 0/7] drbd: preparation for DRBD 9
Date: Wed, 23 Sep 2026 16:06:01 +0200
Message-ID: <20260923140608.1116713-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series contains preparatory changes for bringing DRBD 9 upstream.
Each patch moves a piece of the in-tree DRBD 8.4 code to the form it
has in the out-of-tree DRBD 9 code. Doing these steps separately and
up front keeps them out of the much larger rework that follows, so
that rework shows only what DRBD 9 actually changes.

The patches are a file rename, comment and internal cleanups, and two
higher configuration maximums. Defaults are unchanged, all existing
configurations remain valid, and apart from those limits only the
wording of some log messages is visible to userspace.

Christoph Böhmwalder (7):
  drbd: rename drbd_worker.c to drbd_sender.c
  drbd: modernize the file header comments
  drbd: raise the socket buffer size limits to 128 MiB
  drbd: raise the maximum resync rate to 8 GiB/s
  drbd: replace the drbd_interval bitfields with a type and flags
  drbd: move the packet name table to drbd_strings.c
  drbd: rate limit log messages per object

 drivers/block/drbd/Makefile                   |   2 +-
 drivers/block/drbd/drbd_actlog.c              |  16 +-
 drivers/block/drbd/drbd_bitmap.c              |  18 +-
 drivers/block/drbd/drbd_debugfs.c             |   4 +
 drivers/block/drbd/drbd_debugfs.h             |   4 +
 drivers/block/drbd/drbd_int.h                 |  59 +++-
 drivers/block/drbd/drbd_interval.c            |   4 +
 drivers/block/drbd/drbd_interval.h            |  55 +++-
 drivers/block/drbd/drbd_main.c                | 106 ++------
 drivers/block/drbd/drbd_nl.c                  |  15 +-
 drivers/block/drbd/drbd_polymorph_printk.h    | 256 ++++++++++++------
 drivers/block/drbd/drbd_proc.c                |  10 +-
 drivers/block/drbd/drbd_protocol.h            |   4 +
 drivers/block/drbd/drbd_receiver.c            |  61 +++--
 drivers/block/drbd/drbd_req.c                 |  40 ++-
 drivers/block/drbd/drbd_req.h                 |  12 +-
 .../drbd/{drbd_worker.c => drbd_sender.c}     |  42 ++-
 drivers/block/drbd/drbd_state.c               |  15 +-
 drivers/block/drbd/drbd_strings.c             | 138 ++++++++--
 drivers/block/drbd/drbd_strings.h             |  27 +-
 drivers/block/drbd/drbd_vli.h                 |  12 +-
 include/uapi/linux/drbd.h                     |  12 +-
 include/uapi/linux/drbd_limits.h              |  12 +-
 23 files changed, 534 insertions(+), 390 deletions(-)
 rename drivers/block/drbd/{drbd_worker.c => drbd_sender.c} (98%)


base-commit: 85bffad4d2fea373a72d68bed8012e8cbccb8ee7
-- 
2.55.0

