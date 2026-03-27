Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A413890F4
	for <linux-block@vger.kernel.org>; Fri, 27 Mar 2026 22:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774651130; cv=none; b=HI8vnglaV3cu+gcDRiFlOmIcOYDFJ8DQY1OrUgu+qpeWwKjnxDZ1vwKePqvU65iU8QGqtcZJUSQVa3Kj46mcpLNL5+sl2QpsxQhR+68I4P/5EzXfokvhxBZienXBlIn/RlTKK5P6S4E7z0G030XkLVpeFZh4Ll3pLqzcbatdys0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774651130; c=relaxed/simple;
	bh=/iAP3nD06jYRWcdSsS1v9RRiexileYML3/JfvHlOvCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tjY6Q3M81NfzJYIhmYyjqPodm9f6rMGOHnSDBOsdsdk6nCRbvBdXLm+qYrRulDQlEIL4haznhyAS62glkJ0oy/V1ACFzWcN1ta3HhBVB3hvceEUT60ZhssvvQTxCIanGJ1Pi9sz6wn/aiPM9FOKNsILcYvoyRDDDLAt9UX+Au3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=NzF9KD/F; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="NzF9KD/F"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-486fb112c09so26483365e9.1
        for <linux-block@vger.kernel.org>; Fri, 27 Mar 2026 15:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1774651126; x=1775255926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+ah7Jc7k71YR5et9OmCfsg+DC7q9Eb/m1sFtjVOghFI=;
        b=NzF9KD/FrcENJ7kwCe+h2+64epNZIKqwrCXVy6eN88KL3n1WWw/vl2ifwNc/Xz+GWA
         kX40d6NWo2ENMFEnl2yZUHi1lYVI9Qu5A8d78kjoF6Czh3N9mjAQPuB7ggmFUtAaFNj8
         QBCQllRmnrVI4U3iVQFDY56MrBlZ1udlMpO4FQC2JATTTEC/F06VTQTP/g1eztt9qqjK
         6m8yf8kUaEZcrnjLdY2sDmYWqe+QobQlJDECtt99fTyfAeJ5cYCxpMHgC77JoFbQ7w6Q
         Pllfa+mrFFFunrgYPjlJpZMJ1OBgdeLiUzpkpwdeHNS1JS5wy1PhbmTkp86f/gnWEpqc
         PSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774651126; x=1775255926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ah7Jc7k71YR5et9OmCfsg+DC7q9Eb/m1sFtjVOghFI=;
        b=hhG8/K5u0Jvx4Ja8Cre60r7ll/QdDncQJc6TtAapdlUzdEh/ixgU90edpM1sNLR/3G
         hWcdp68Tt8WFw0MjgqBl0oPbdIMX1fft0ny6s7Wp5VK/psRmeBoZWVhws4++mo0kHjTu
         F8kVZHDHncyddZoZ182L30BGTBuopMkKCjlGqLgsgm0aZRVhOg1lRXmNqKX3QJeI6xan
         i64yejOiztsjwsR6z9baZsOw2D++otH7ONHhP1MybHgiYEWxuKM/iCh4xlyR92UI+63G
         DTOKmikgIfAG6ML7/SJ8I8MN1JETi/nAfiRZU8oA+KJ1HLTf1HJlvozGovN11JEacEKp
         RyrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvhmpZBWcSqfJ/iKPSZXhYU7DPCrUAdob8yzVIR//y1HADu4Qr3jyEDl6N1KUAdU74qb0FQ2/A2UR7IA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrtyygMhDlbYlbuv3b7p4pm7uLB+0hFPU7bms/sO1HO6fhpbi5
	K4vHC/ZDK5131UtVhfOow5gSMSASCGKpX6W94raXF/6kLotdRCgqcShb14sCTKfZARFYYBXx6nS
	LYqUx
X-Gm-Gg: ATEYQzwO9nEfFKdbZU32Qa5kCWnsu1sYoE9xiQrgbAF1yVt525oVCjkFaLAxT40awo7
	6WW1OdxKT4VtfUWx/lPe5DAzxLtFwihMlr04UfRoIhG0DaKZ7ljEJbshyQZLQoj15TCP0P9bniO
	gguHAs+A33oncKiHWk+YOVqopNYSbbj02CBy/pf1ppPsDj79nevoOTnZ//fsjlTAdxUrU3eVqT/
	ZnFKE9tC18va5yPjEbb2dO1vZ9q8yh94+A9RH+YCVTHVBfd3h+8XHBMLaFXIJJ8wnPgfmK8Ytlk
	RO5WsK5OtomubINwWgC45xzNz1VTFdu9Nt9WFyHgYKzPb5rUgbKmMiTybSAEJIa+amSBQxo8tPn
	rs8QZXsJHdlQQizpIoRuzo6mW2zD1rW/UZ91VxW4bxaoEL0lLf1o/iAQ3dCRaY5cXKNmVl7gTsb
	OTTA5EDhKo7EKljnPHiYo7jadlSKSa0UM3THuRhxqkXE/3J5txrPV01uzvFoOSvgqG0+VxUq1iC
	HgdRwFUcPioxed0saDawA==
X-Received: by 2002:a05:6000:2006:b0:43b:41df:705e with SMTP id ffacd0b85a97d-43b9ea77850mr7212627f8f.49.1774651126061;
        Fri, 27 Mar 2026 15:38:46 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf247079esm998990f8f.25.2026.03.27.15.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 15:38:45 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 00/20] DRBD 9 rework
Date: Fri, 27 Mar 2026 23:38:00 +0100
Message-ID: <20260327223820.2244227-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As discussed (context: [0]), here is the first version of our DRBD 9
rework series, intended for for-next via for-7.1/drbd.

This replays about 10-15 years of active out-of-tree development work
[1], depending on your way of counting. The out-of-tree module has
severely diverged from the in-tree version over the years, which is
what we are aiming to fix now.

Hopefully that somewhat excuses (or at least explains) the massive
diffs -- we've tried to come up with a way to group the changes by
topic, but I realize it's still not exactly trivial to review.

We've been polishing this series for a while now, and we have taken
great care to make it as "upstream-presentable" as possible. That said,
there are still probably imperfections. It's a start -- feedback welcome!

The main blocker that still remains is that this technically breaks
userspace: some ancient versions of the DRBD userspace utilities will
not be able to talk to this version of the driver (v8 and v9 genetlink
families are completely incompatible).
We will fix that by introducing a completely new genetlink family (think
"drbd2") that follows all modern conventions. Then we can register both
families, going through a compat layer for the old family.

A prerequisite for that is converting the genl_magic macro
infrastructure we use now to YNL. That is already in the pipeline, we
expect to have it ready by the 7.2 merge window.

The plan is to submit one new version of this series for every merge
window, which should end up in linux-next. Within a few kernel
releases, we will hopefully be close enough to get this over the line
and submitted for real.

Thanks,
Christoph

[0] https://lore.kernel.org/linux-next/899e0337-9642-4ca6-9050-aeab14fa22ef@kernel.dk/
[1] https://github.com/LINBIT/drbd

Christoph Böhmwalder (20):
  drbd: mark as BROKEN during DRBD 9 rework
  drbd: extend wire protocol definitions for DRBD 9
  drbd: introduce DRBD 9 on-disk metadata format
  drbd: add transport layer abstraction
  drbd: add TCP transport implementation
  drbd: add RDMA transport implementation
  drbd: add load-balancing TCP transport
  drbd: add DAX/PMEM support for metadata access
  drbd: add optional compatibility layer for DRBD 8.4
  drbd: rename drbd_worker.c to drbd_sender.c
  drbd: rework sender for DRBD 9 multi-peer
  drbd: replace per-device state model with multi-peer data structures
  drbd: rewrite state machine for DRBD 9 multi-peer clusters
  drbd: rework activity log and bitmap for multi-peer replication
  drbd: rework request processing for DRBD 9 multi-peer IO
  drbd: rework module core for DRBD 9 transport and multi-peer
  drbd: rework receiver for DRBD 9 transport and multi-peer protocol
  drbd: rework netlink management interface for DRBD 9
  drbd: update monitoring interfaces for multi-peer topology
  drbd: remove BROKEN for DRBD

 drivers/block/drbd/Kconfig                    |    58 +
 drivers/block/drbd/Makefile                   |     9 +-
 drivers/block/drbd/drbd_actlog.c              |  1122 +-
 drivers/block/drbd/drbd_bitmap.c              |  1824 +--
 drivers/block/drbd/drbd_buildtag.c            |     2 +-
 drivers/block/drbd/drbd_config.h              |    38 +
 drivers/block/drbd/drbd_dax_pmem.c            |   158 +
 drivers/block/drbd/drbd_dax_pmem.h            |    40 +
 drivers/block/drbd/drbd_debugfs.c             |  1657 ++-
 drivers/block/drbd/drbd_debugfs.h             |     2 +
 .../block/drbd}/drbd_genl_api.h               |    19 +-
 drivers/block/drbd/drbd_int.h                 |  3278 +++--
 drivers/block/drbd/drbd_interval.c            |    35 +-
 drivers/block/drbd/drbd_interval.h            |   156 +-
 drivers/block/drbd/drbd_legacy_84.c           |   564 +
 drivers/block/drbd/drbd_legacy_84.h           |    27 +
 drivers/block/drbd/drbd_main.c                |  6008 +++++---
 drivers/block/drbd/drbd_meta_data.h           |   126 +
 drivers/block/drbd/drbd_nl.c                  |  7248 ++++++---
 drivers/block/drbd/drbd_nla.c                 |     2 +-
 drivers/block/drbd/drbd_nla.h                 |     7 +-
 drivers/block/drbd/drbd_polymorph_printk.h    |   265 +-
 drivers/block/drbd/drbd_proc.c                |   320 +-
 drivers/block/drbd/drbd_protocol.h            |   519 +-
 drivers/block/drbd/drbd_receiver.c            | 12258 +++++++++++-----
 drivers/block/drbd/drbd_req.c                 |  2990 ++--
 drivers/block/drbd/drbd_req.h                 |   303 +-
 drivers/block/drbd/drbd_sender.c              |  3871 +++++
 drivers/block/drbd/drbd_state.c               |  7724 +++++++---
 drivers/block/drbd/drbd_state.h               |   298 +-
 drivers/block/drbd/drbd_state_change.h        |    66 +-
 drivers/block/drbd/drbd_strings.c             |   219 +-
 drivers/block/drbd/drbd_strings.h             |    25 +-
 drivers/block/drbd/drbd_transport.c           |   403 +
 drivers/block/drbd/drbd_transport.h           |   340 +
 drivers/block/drbd/drbd_transport_lb-tcp.c    |  1905 +++
 drivers/block/drbd/drbd_transport_rdma.c      |  3496 +++++
 drivers/block/drbd/drbd_transport_tcp.c       |  1670 +++
 drivers/block/drbd/drbd_transport_template.c  |   160 +
 drivers/block/drbd/drbd_worker.c              |  2223 ---
 include/linux/drbd.h                          |   190 +-
 include/linux/drbd_config.h                   |    16 -
 include/linux/drbd_genl.h                     |   352 +-
 include/linux/drbd_limits.h                   |   112 +-
 include/linux/genl_magic_func.h               |    50 +-
 45 files changed, 45891 insertions(+), 16264 deletions(-)
 create mode 100644 drivers/block/drbd/drbd_config.h
 create mode 100644 drivers/block/drbd/drbd_dax_pmem.c
 create mode 100644 drivers/block/drbd/drbd_dax_pmem.h
 rename {include/linux => drivers/block/drbd}/drbd_genl_api.h (68%)
 create mode 100644 drivers/block/drbd/drbd_legacy_84.c
 create mode 100644 drivers/block/drbd/drbd_legacy_84.h
 create mode 100644 drivers/block/drbd/drbd_meta_data.h
 create mode 100644 drivers/block/drbd/drbd_sender.c
 create mode 100644 drivers/block/drbd/drbd_transport.c
 create mode 100644 drivers/block/drbd/drbd_transport.h
 create mode 100644 drivers/block/drbd/drbd_transport_lb-tcp.c
 create mode 100644 drivers/block/drbd/drbd_transport_rdma.c
 create mode 100644 drivers/block/drbd/drbd_transport_tcp.c
 create mode 100644 drivers/block/drbd/drbd_transport_template.c
 delete mode 100644 drivers/block/drbd/drbd_worker.c
 delete mode 100644 include/linux/drbd_config.h


base-commit: 67807fbaf12719fca46a622d759484652b79c7c3
-- 
2.53.0

