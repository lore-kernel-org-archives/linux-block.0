Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C8E42188E
	for <linux-block@vger.kernel.org>; Wed,  6 May 2026 12:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071182; cv=none; b=dzXgY5lu8Yyyb7gW3zY2+rBTs7ODvzrOJ4wD34SqogtXtyFyn5e3JlAGKDPV7zg/6NlFlgQMLzP1hHIDrVm0My/5h3g7Z6j9X+L55EeBI+Bf8skn/N0/g3GGHG6dc/KpgNz5BIxBk6a37E0aENeWu2hINcbjhPRw2lYtLv68ydg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071182; c=relaxed/simple;
	bh=5fxNe/7C/qmME7G5REh94LbkahAVU1alfvlu0Z+8nzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L1Z1liw3QViOZj80Eh3OcXEQSq8U3qG1CGW8VWNGmRlKIupPmfZfuGQLDQpZ7SPH1SYYG1W78mT2GHxRwcr3/Iu+cr+tH6CEWNMUA63/GRJC1PGEnekDZQde0eBRF+FCRqnXi+MEqOqX9n0fXI4xaMaF4RUvE0pjamj5nTa31+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=G8G1bFec; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="G8G1bFec"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488ba840146so56349585e9.1
        for <linux-block@vger.kernel.org>; Wed, 06 May 2026 05:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1778071178; x=1778675978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lfZRl/C1nUWxOaIb1UiTP5bzQ2aypWAqsTH4UFzskcU=;
        b=G8G1bFecxUYPvKiOw8j007H1QdXQgtfvMaET8nGSRLbnI18sFBxJtXNRT4WGlt5HaO
         MnXHHZ2wi0ncTXxN4LpiT/hRNsv5qTOeqLy104QQIMe+T9XX5ALQh6K0f0fSBURUk/bU
         5n1p0qJ5RfnQY9YZRawJeR5eDnwyrrzZsEo7qWdh2u6DmamxmDOpzzqGWXgaXraCtNZo
         VKJ7c7v0j3ZsDlPx+Vsw7SSMZZZxBvH29mHaa6f7hIYTv4uje+5qe0d/Nc9YqSFH6yjT
         wLLSVuAT385N2nRidhxfgZzi9JslpO5tVyjkhaFkTzxN5hVB8gNMn3RSFxc/Y8OQgxjh
         6czg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778071178; x=1778675978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfZRl/C1nUWxOaIb1UiTP5bzQ2aypWAqsTH4UFzskcU=;
        b=cWCwKJDH6Y8UE6Yrd4TyICcdlbJmsAZoHDwuOaNd4d0KbPDga2+02CGsR5WkYp5wSM
         +r4DSa0OgXusVEs3RvdQJ54Zb2sX9imbZF8FFOXqPHnzfjezfF8MX5GgeZLB/Wj6Yq7w
         vdwCLt2xsMJZeG0Qgs/Vn2tQCyStG1V/xx/DbOs0EGH0wK7x8nLh8oYj8P/QgPjc/m5n
         DZHLB/Hrc6RT6T2apNlpv8isVkkt19+DEwiWZTys+AizQnXAIPkqxY3S1eC3Mcc+UCJr
         +tTHxxAMyJnxUk/SS/p0GqNznjvKL+dkelim9qBJiRG9J3pjlkl6VVw8b+T13gmjHuUR
         akwg==
X-Forwarded-Encrypted: i=1; AFNElJ+/z5l9MP9FnGWKY50WHZsQNqAgu5l60eM79luEiZrimLkbjRpg6nwP2jwyP+JQVyfy9Aum+GV3Cr9/PA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRl1NC++9ziUG/SkggzPpqfL3A1bBkS/9qgtrPQBULylkWf4Ak
	rLH6/IZfiid8q6oUSWMQmPQPI5CTUmaiPTWwwXyuMe5BaVTyFGneoATlqF+i1oMAJPU=
X-Gm-Gg: AeBDieuvSWVLNDp4RN5WMht2zAYuIENoDWtXJHoUmOZx5BhBxkTUKXKU2OZnK6P+Idr
	2CxtSaJjLCaP2ZXSa9y1TgZVY72OLcilCoICbOWe9QdXFQM8A8bWWVzaYhGM3IK18CJu3bZKDjP
	WtD6LJ3INq39k+1mIuti2S9WSMNwex+hPMyNDJQ6vvjRiI3yM8x6UblcL3zPllG8f5w6cQvOkEX
	2WSqRWiM/5e6dWHlqMd3GH+X2Xks4zZmuUwSFX0KnhRSsYVLDnCRW2civfvwRs6v0edfd5Xyz2r
	MLmpuuSkpeF4YyQL9NHnARAoThSdOs+tDUjPVaWNttHZp8ELOwr/vsyAA78jSKkAZ74bcd75ASE
	jL7WO5kaFFGZuJepo1edI9zOSndawNi5k+LSNrBUmKcZPTz0S7i3Ipkfz9CtuHjSmiLsE67EmWH
	CaaviBqtS6M1x4mb90myLmbR0jBixO0T+ufOQAFZzgQW39pz8ybcveVI1ZLs6lv6Pwb0KlDA7Wb
	5Z2sqrGN81Du8PtqZXxwvhlIEPTIlBn
X-Received: by 2002:a05:600c:b8a:b0:48a:5333:811e with SMTP id 5b1f17b1804b1-48e51f2f91cmr56154685e9.15.1778071178092;
        Wed, 06 May 2026 05:39:38 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e53891d62sm76399015e9.1.2026.05.06.05.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 05:39:37 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH v2 0/2] drbd: switch from genl_magic to YNL
Date: Wed,  6 May 2026 14:39:24 +0200
Message-ID: <20260506123926.1944290-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

DRBD's genetlink interface was defined using a custom multi-include
macro system, genl_magic_{func,struct}.h. This system generated struct
definitions, netlink policies, serialization functions and more
from a single "magic" header.
It never really caught on; DRBD is its only user, its internal macro
jungle is next to impossible to understand, and even harder to debug.

This series replaces it with the standard solution, YNL.
The *_gen.[ch] files were created with a modified YNL generator, but
these modifications are not shipped because the current DRBD family is
effectively frozen.

Note: this family primarily aims for compatibility with existing
userspace. The next planned step is a new (also YNL-based) family,
"drbd2", which will implement all the actual modern recommendations for
new netlink families.

Changes from v1:
- Remove YNL generator patches, ship just the generated code

Christoph Böhmwalder (2):
  drbd: move UAPI headers to include/uapi/linux/
  drbd: replace genl_magic with explicit netlink serialization

 drivers/block/drbd/Makefile                   |    1 +
 drivers/block/drbd/drbd_buildtag.c            |    2 +-
 .../block/drbd}/drbd_config.h                 |    0
 drivers/block/drbd/drbd_debugfs.c             |    2 +-
 drivers/block/drbd/drbd_int.h                 |    6 +-
 drivers/block/drbd/drbd_main.c                |    6 +-
 drivers/block/drbd/drbd_nl.c                  |  416 +--
 drivers/block/drbd/drbd_nl_gen.c              | 2606 +++++++++++++++++
 drivers/block/drbd/drbd_nl_gen.h              |  395 +++
 drivers/block/drbd/drbd_proc.c                |    2 +-
 include/linux/drbd_genl.h                     |  536 ----
 include/linux/drbd_genl_api.h                 |   56 -
 include/linux/genl_magic_func.h               |  413 ---
 include/linux/genl_magic_struct.h             |  272 --
 include/{ => uapi}/linux/drbd.h               |   42 +-
 include/uapi/linux/drbd_genl.h                |  359 +++
 include/{ => uapi}/linux/drbd_limits.h        |    2 +-
 17 files changed, 3650 insertions(+), 1466 deletions(-)
 rename {include/linux => drivers/block/drbd}/drbd_config.h (100%)
 create mode 100644 drivers/block/drbd/drbd_nl_gen.c
 create mode 100644 drivers/block/drbd/drbd_nl_gen.h
 delete mode 100644 include/linux/drbd_genl.h
 delete mode 100644 include/linux/drbd_genl_api.h
 delete mode 100644 include/linux/genl_magic_func.h
 delete mode 100644 include/linux/genl_magic_struct.h
 rename include/{ => uapi}/linux/drbd.h (87%)
 create mode 100644 include/uapi/linux/drbd_genl.h
 rename include/{ => uapi}/linux/drbd_limits.h (99%)


base-commit: a9c4b1d37622ed01b75f94a4f68cf55f33153a31
-- 
2.53.0

