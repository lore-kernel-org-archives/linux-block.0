Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5B93EAC76
	for <linux-block@vger.kernel.org>; Wed,  6 May 2026 12:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071550; cv=none; b=HM1H+ClOS7+dt/u8l1yvc1607EuQ2Wu07yCzYC0IiRhSlz4BwYBW9T39Wf8GVfbVAlRbGIz4Z13xLLGeeVlOCdBej+ImITboQc/uOWXmgi491fFaVSN2YGSJzVNp5NMoPiWEEbTX5r4JHXVnGGe/sXg6hlJktMZ6B6DThxg8hvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071550; c=relaxed/simple;
	bh=/i5A7HvXIH2pkx3qahfYpWAzD4ix0sd0DqEnIeRVGm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mADP1pvnCY2spKQoDVTGQs8YOdexuffrDxz4n2DmxVgZLn0rmn4uczVc4zVp9cqMbphRurTFid3h2gp6JP7cYrrXSNJaUERPCFuhcF6ysKPoTwVuL7QEX7b1UOdDl8GRSOaGIsJGuEwmT/RvctnWAygbMztykLo8jxTSgLSIueQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=Ew0dgU0P; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="Ew0dgU0P"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48374014a77so75753565e9.3
        for <linux-block@vger.kernel.org>; Wed, 06 May 2026 05:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1778071547; x=1778676347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xduljJRFZGdlBnAgyasd2iQDnZmICTkUp84nQkKVvPE=;
        b=Ew0dgU0PyIBzN7nFQAobH+go1LJQYFyl16yn4w49BXltTSa27cWrbv1a0U9hTt4LKC
         rQfrCIoayHA7IM8U5CtaXHaFUS4y5wkffhLwRjhlyACXBsUYbfL8iLbUQsjK07WTPRyL
         hDjmbj50y0wIT+2MW554wv2Ft4JzH0Heur+Iq9LhRTMk84KSHgAoB84m+t6XT5p3a08f
         IwBp8U35Y1d7j2xABWqx3jQJk/US4Luijb4O93dB3mCyr/GN5MOwEryLAGDFGtVaVOWs
         23X7U3p1ygs5syU9hA+3LsuRd8lFS0in9PljTt4AmnAM0ecTRdQRdfwW7Z2KSd+CtYIo
         mnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778071547; x=1778676347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xduljJRFZGdlBnAgyasd2iQDnZmICTkUp84nQkKVvPE=;
        b=UOnUpevq5qsnpYMqnvLzMD/PM/jzM3Wk7uOnXd8LOrp8lzVdMH0+Fk1K/yTEBFBo1B
         OF38NYLTGp5nzpezRr0iElOHmhYNtXM01PMN5RiqBoJzI650JPOl5uJIooQy/eNYr4Af
         ptAK1MuWiIEeYg67scfRArrO8USledR86/UWHc1JcDyOkY7iqXIc65057lm97MV376DY
         DfFrVGdPa121G63zRyeATcRdQto/EFlkq3oQkOj29QQ8HXQokGXe6IG/B43JFLBBOfjl
         +R6nm9I38PSOHewTxRL3gktwdFAapwWXxjKDal50it/+8NlixjJF/5996pDzM8fPzful
         ClQQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Am+hYeneOV9T+jxhLCpeoW+Gli+//guCE4NTW7HwfwcLMnCxyxvqJcGkkk6J5+VGqFt0044+F6FaAdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ9prUBrclV7OR3AjXAxb2g4UR5AUWml8DAWmiBYgcDdc2tHUv
	s3HYJAygothGn+dE+QKzk77hUPpk7sbuqcRIgjvzIgTy/RM/M0jOzJNi6GdTdSaCnW8=
X-Gm-Gg: AeBDievcaDRVD8EPCdlAfsflo2R4UnV4hfiMDt2gDPMwQ57xMDLmVlEbf4Yse/LP4/z
	GdIjjMm8KbCmC+EEBYJReY1UWctscwO6SxbUyEahYnbCIRktWvP9XPoiBL/T2p2LH+rID35fszK
	nhqSsab1Miypv8HJqd93dzyLPdeiobUc7FGBv5oRh0FTMJ4NV5lUaEAbn0n0KpPrWvznU5uRDfu
	I8P4o4GITXAeVgId1kfLK8odXp+tc+u4Tg5loxo/Dgl3JuSnIz3biPlG9HhPaDWC/Mn9MrGj3yt
	/ke4NCQVGUTaZU/PMkSBK2vWcds8T6mueLLc+3J4iGa4O83bLyObv7q6OsP67rhkXj7YUIBB8ld
	cFblsFp20w0Dvhn4hz87fm6/lQneiYIrLnEsleLuXtYOvkFatg/aOUyjJkHXfBJ+uofcnxBwFxQ
	THSsQnkLt3dMI3m3JKpT4AO31522ZMJK5DYn0BUoHZBHaNom7byLTCacOS4Bz0S4XbOGykSu3cC
	HEKpXCDiXIJ0TRwwNzFVA3NDflcsp6u
X-Received: by 2002:a05:600c:4592:b0:489:1ff1:74d3 with SMTP id 5b1f17b1804b1-48e51f3c4cemr59553125e9.20.1778071546568;
        Wed, 06 May 2026 05:45:46 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538d2878sm74792275e9.15.2026.05.06.05.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 05:45:46 -0700 (PDT)
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
Subject: [PATCH v3 0/2] drbd: switch from genl_magic to YNL
Date: Wed,  6 May 2026 14:45:39 +0200
Message-ID: <20260506124541.1951772-1-christoph.boehmwalder@linbit.com>
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

Changes from v2:
- Fix compile error

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
 include/{ => uapi}/linux/drbd.h               |   45 +-
 include/uapi/linux/drbd_genl.h                |  359 +++
 include/{ => uapi}/linux/drbd_limits.h        |    2 +-
 17 files changed, 3653 insertions(+), 1466 deletions(-)
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

