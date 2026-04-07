Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DD2342CA9
	for <linux-block@vger.kernel.org>; Tue,  7 Apr 2026 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775583253; cv=none; b=s+OeEGlrbHMKSOZ9Klw3739vgjcVaM7MRrVREyV2iO+QU1fcPeqGTnRkgypLP83q6OUOLahy4G3PEwXFM+lmN7IEYDccpYRGeUh553kAomygUe/NY9Wc0ZqlvelVsYJGxMkWkyA46k6u7qiVYY58Nw+jSEOTggB+85LLLgyRow8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775583253; c=relaxed/simple;
	bh=g2ZM5FmkM/cMVSD6A+ioyLtze+wBXuHB3O6JxpHUSc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YLGm6DFUU/O4zF/XlMciXUXETGMhmasqmOE8pk8rOgvPtx9/nmcBRImYNygeO7+A2gREbJKGY2rrCQDPFgIwbzyC1wWRH28etjfIfuA2PztCSOLpRvnTju3UBJrBv2FCro0vJ3cEbaPzi0b5ANlkdSPBAfDL0ztxUQQMUtb1QRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=lFqi79mZ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="lFqi79mZ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so49324805e9.0
        for <linux-block@vger.kernel.org>; Tue, 07 Apr 2026 10:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1775583250; x=1776188050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8RvP1qL9GHPweA7UFv71M7qDWUSH6dTBdOKH8YAv1Ek=;
        b=lFqi79mZTeg+5CMl63eOKuFMI/QQTHWniLygGpcDNMWbvhG0557PZMk/NzXO+HDPqF
         iWSkhO/mYyAE6vEm/MzzGwWK4u65n7SxifZuUEcfIzzunAmEf+6w4Y2eNP12aUp1f93n
         zDEsLnk791P9UD4D4v4DCUtwBRHCpeuf1EpK+NCOkXljPimJmO0ndYECaaykHbNls/3e
         jjSwLMy0VhE5QxMPY2rEI9BSb+aUI7m2IYJINV3/kOGSdv8Bfag8gylobJlKqO4x++z3
         2xh8rIRm3M1XGw/1SgOhAnHp5cZ13bE6LotBD0Q4J2ajpfvPe/RVpgY7APOqz+1OArDV
         EuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775583250; x=1776188050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RvP1qL9GHPweA7UFv71M7qDWUSH6dTBdOKH8YAv1Ek=;
        b=iYDVx4/o1AAJo+y6tmHQgKCqfLErgHVXRED11I2epb9/1pH59mye0eXQSOLNqShl4w
         CiDqoy/4mwfkVzHVV6PCD3dPAvVs4s8mXm8ZeMh72sRNHGCwwkSFlPsXDzseAalJ0SJC
         u8jngkSDrCBbe6qfcdEnDidB3eeMZRBQ1LBZgGMG+EjSjnmid8fMQoKysig8gD8dSOCg
         BRsWC31RNdYTY6PUzhuYDh/7li5hBWWkpIPADQf5Hm/G/xmAh0YU5xdwMRmWtl00ghz3
         y1kKAqBjPG0u4DxBLOSFWobBJFH+Tq/hSG7t3qg4RfmKl6iNfH2gJPxHreQW/L2SWiDW
         wdaA==
X-Forwarded-Encrypted: i=1; AJvYcCX4uwZlXUit4OuTfAz2a0mURlNt1nmYj2XIQhJKNZMmMlIviQlzNDLvnmITrzd0VSqEtksvTuTaBFvLJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGHFqrAD/CB4nwK8aXqxsOtbMhJ0f1JH4xRmjfj++Pcj1iLwLX
	0HMHqH4V7QlkKW37QtW5rcZZ05UnubEiPuAb76NxEaazELTaxODzNFnF6qtQBN3IxrI=
X-Gm-Gg: AeBDieugBHWenoogy9EXtWcPki7TbWFjZTuTC1Jn4qHj0vSxQ0zy0QcHmUaaF8TiGiJ
	kI4qU18PLH2WBi/X97lgBUSOGBNY3T6pVJcqZNgapEkCSxath7vl48ij+eDjVmFcdrNr/En3O4b
	Z1Vc9Vjr4MkSUoZsi3o5aYp0E3ZKApH2GY+RvBJvKnDb6U6qGcmDToMg7Ap4OmxQ9aKijKQA7oA
	uSEtGClZ875TM9d/1BCU2hS1p0qTA4B0Eb45RcuMKEhA6nLdJb6f3OGhPnIcPjyLPg57owTMlMq
	BFIE3aXHBVl8cYWQfY9ZphDmSU7lsgVIyKck0MfEcnQWBy0JdyhC/4d+d+WA1CHG18LOmeWxh0q
	/aDKsSL7GzPkCamPdAE/+Ty7p+SebZi/oDKJODZxk1hu9ZRm69ymu3HjnCA9YRN5d6ObFHQUNZX
	6Zkm/ewbd4nEe1OT6P1Ctx30JbqsmlIGU1cveheV3oFS2nK+08kBCZyDUiOEknMIJfHsIk1Qkc8
	XGhI1Xor1wDJm+NimyJsA==
X-Received: by 2002:a05:600c:4b23:b0:488:a723:ea53 with SMTP id 5b1f17b1804b1-488a723ebddmr100893325e9.7.1775583249679;
        Tue, 07 Apr 2026 10:34:09 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488c4e930c7sm6667275e9.6.2026.04.07.10.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 10:34:09 -0700 (PDT)
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
Subject: [PATCH 0/4] drbd: switch from genl_magic to YNL
Date: Tue,  7 Apr 2026 19:33:52 +0200
Message-ID: <20260407173356.873887-1-christoph.boehmwalder@linbit.com>
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

First, shuffle some headers around because the YNL generator expects
to generate UAPI headers.
Then, add some optional extensions to the YNL generator to support a
minimal set of old genl_magic features required for backward
compatibility.
Then create a "genetlink-legacy" based spec for DRBD and switch to it.

Note: this family primarily aims for compatiblity with existing
userspace. The next planned step is a new (also YNL-based) family,
"drbd2", which will implement all the actual modern recommendations for
new netlink families.

Christoph Böhmwalder (4):
  drbd: move UAPI headers to include/uapi/linux/
  tools: ynl-gen-c: optionally emit structs and helpers
  drbd: add YNL genetlink specification
  drbd: switch from genl_magic macros to YNL-generated code

 Documentation/netlink/genetlink-legacy.yaml   |   23 +
 Documentation/netlink/specs/drbd.yaml         | 1109 +++++++
 drivers/block/drbd/Makefile                   |    1 +
 drivers/block/drbd/drbd_buildtag.c            |    2 +-
 .../block/drbd}/drbd_config.h                 |    0
 drivers/block/drbd/drbd_debugfs.c             |    2 +-
 drivers/block/drbd/drbd_int.h                 |    6 +-
 drivers/block/drbd/drbd_main.c                |    6 +-
 drivers/block/drbd/drbd_nl.c                  |  416 +--
 drivers/block/drbd/drbd_nl_gen.c              | 2610 +++++++++++++++++
 drivers/block/drbd/drbd_nl_gen.h              |  399 +++
 drivers/block/drbd/drbd_proc.c                |    2 +-
 include/linux/drbd_genl.h                     |  536 ----
 include/linux/drbd_genl_api.h                 |   56 -
 include/linux/genl_magic_func.h               |  413 ---
 include/linux/genl_magic_struct.h             |  272 --
 include/{ => uapi}/linux/drbd.h               |   45 +-
 include/uapi/linux/drbd_genl.h                |  363 +++
 include/{ => uapi}/linux/drbd_limits.h        |    2 +-
 tools/net/ynl/pyynl/ynl_gen_c.py              |  293 +-
 20 files changed, 5087 insertions(+), 1469 deletions(-)
 create mode 100644 Documentation/netlink/specs/drbd.yaml
 rename {include/linux => drivers/block/drbd}/drbd_config.h (100%)
 create mode 100644 drivers/block/drbd/drbd_nl_gen.c
 create mode 100644 drivers/block/drbd/drbd_nl_gen.h
 delete mode 100644 include/linux/drbd_genl.h
 delete mode 100644 include/linux/drbd_genl_api.h
 delete mode 100644 include/linux/genl_magic_func.h
 delete mode 100644 include/linux/genl_magic_struct.h
 rename include/{ => uapi}/linux/drbd.h (86%)
 create mode 100644 include/uapi/linux/drbd_genl.h
 rename include/{ => uapi}/linux/drbd_limits.h (99%)


base-commit: a9c4b1d37622ed01b75f94a4f68cf55f33153a31
-- 
2.53.0

