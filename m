Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680344;
	b=VjmMI4iycYBrFcnXjBFiZZwgh4+QP4i8aqPuXnEL7ioaj7tg3RpHTlVZLrgxbBmighhR
	 nXKaLjEFqkHn3m/dsPo3glDpsBETRNUQCL5NB4iehjnh4Z0ES4VWlQPRF8afL65Nn3n+N
	 F7RCzts0xXiyV/qNinm85U0SsuAXy/WnftYsLgCX085B25h5eddhvLFuSuH0MjiZLIQYh
	 KGj0ONCiJAEJOuIPqPYI1EIUshuW+TQTPegHZfjNCACcBllBcisqljM4YZfgLxAog4EAD
	 BNUOEWC9h8dFjWcgnP6nSjDa4T0vQGC8dg0KucIeqd//p521xKWWvPnGTrQHj5FXcug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680344;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YHBFmHAZzkTNwhPEuQe/n0EZjSl7NRJ9RBTHgn7pG6g=;
	b=iY5OS73KaEoZFe31q7oSQAIFepmciDlyjdZfvs5sB3DENce3R3iTN/hdH8ZeeAr+euxy
	 RuWPxqFcaQ6a+jX53U7I5U5bYJc4qy+JIbQprJC9in4AVYipSSoyUs4S6hrRaiMuBXwUZ
	 ZpFgYi59HXmq0GcKgx3r8bBOVMlHcqm3bCOr4QPAE71kHRLQDwExnBYP57KfF+AvH2SIn
	 8X48JZQ2/25NVw0pjEz/tBBRXgKlNsd1BFMs9H/LfsVmj2EWzLeIubeXe6f7fETMxYk3I
	 G43LxhXSdIfKGqBGMP60X4aspr16Cz83VKwndmx93RiXul27Xx+esAlhYJE7KfyYKpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MX4aGq+Z;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EFE606A31A
	for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 14:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40EFE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MX4aGq+Z
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-157fe9d771bso2498671c88.0
        for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 07:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792680342; x=1793285142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YHBFmHAZzkTNwhPEuQe/n0EZjSl7NRJ9RBTHgn7pG6g=;
        b=MX4aGq+Z76FGWDcCUV1LNuRvEgXiZkCR1eq0l3RwGH0V2h9pF4ulMUXNn5dSFjqW0h
         dvaIMrGEeu5BEQb/j8zn0XhshvClFROYk4h2ZW28nTXT48T5ArQH931fqAHdUOAFM4p9
         Cxr5jFg2zRStIh6zh8a6kI/jpDiYNmLNO+1TsZEfy0BZYRKJtdTTP1DjjfMTd3K1k/ym
         h4t75bJSWIoverA7ahvnVUnActI9LRbH2i9b/Tndc2tMA83g8lseNO+qnb6lWec7zavH
         S6zcElnkrdUhivd4xhakT/4gvt5ladPKD61Xb1wbseoIaQnK0I72aOoiQF/xw1Ia9BFC
         6fqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792680342; x=1793285142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YHBFmHAZzkTNwhPEuQe/n0EZjSl7NRJ9RBTHgn7pG6g=;
        b=eXuRUCRuwECAjjijVOQXYgumnCHknblEwfIBPKiBJk4d3csTg7foXhFTsmKmdKxyvR
         n8zMHOtihxovgnDRHbD/6pihLmKRJWwt+/vXv0PGW5DpBTnFsKPecHOTaHqlUZ4zaSrm
         v4JDAKcGISIQagvCfs8cRKmjKooFY+J4opmaZsIwxhIHWVbjoxQBfCI01mhKfXduYMbH
         BajN2ffNAhkOO8QYqjZvztbWpXBdzw0kyjcoMmlnVK1970BbWQql0/54svQuneAapK3R
         5DKaORuvmsuA2La2aGVi87RGEig3n0ZHnoQuxu5SBSpW+9+xg2Ez5uMQM1y9UCX4K0oL
         YWrQ==
X-Forwarded-Encrypted: i=1; AKwUvBy/Md6KiPVHr2RUPw00aZ9g8dPvGOeJZO/Z49rDVUb6ihouw4p5FTe7vH3/4N+9SLlHCgi0U7Ig6q90JA==@vger.kernel.org
X-Gm-Message-State: AFq9FYL85U7TXYY1cThz78ybiHZLhG9Zcbl1cY2GmWLma18YZfpp9rGJ
	/2i13I38Jh2atdaGpUCS7EkPMVyYmuyxBoQ7kuDs7pTYN+Q6Zz1bpcQ=
X-Gm-Gg: AYBFou0EYazMUmYDc9zvHl60/AzerwF1Kaov4x5lL++TovZg7bypd/RPKcESbyz39gM
	0HdTYHKGZywqUUk9+X00v3zUxliFhqOrNl940je7IGN9dznQf5AkFf51TX2amFEWY+BzeSQ8Hh+
	X3qwGLbjeH0U9xvccD1H5lMTX9bwNYow7C1nv/o3Knt6TKA72IfTQ7C/fhJIjOJ4ktHkWTughEJ
	GedmsG3p/JW8aEAKe6ILeQPiSvplq9krTJO3rp69A2iuWPBZ3Dsz5daKnhTDGLexv3+z9o/tgMi
	X6YaSK/zG4CTNCeB5FI78XT2S1s2a1dL+c1o6RwADKPH0r+IEbyZVtal1bRx+/f4ck41J2ZOUZR
	bqT4OHA7Y275SFRGXndZHPMHbHjDXO09og4XYgzhQTh1lneFp2TtrPxV+bAXGWEDDOS8NbUCCsT
	b99Y+WlerJMWX+Mn4wii0w3/XlyuVK587yLTwzzNtdXJSQFjI9QDVfj1TpyaihYHPqy5lSvXI00
	F++cND1Uymg/1aRKf5flySbqrKN+wHZH/7ikEAI++tSp8zGwQmtwVVeVeVDrgCbA37xdVtAMOLK
	lDH85SQl3gnrG29iYZHBsqNfJhrGU0snaz2hNbhIvKY=
X-Received: by 2002:a05:7022:286:20b0:191:17d6:ccdf with SMTP id a92af1059eb24-19117d6ccf9mr5773178c88.8.1792680342117;
        Thu, 22 Oct 2026 07:45:42 -0700 (PDT)
Received: from anuj-MacBookPro.. ([2406:7400:63:e55a:5016:92c7:7a35:f3ff])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903a275026sm23625880c88.5.2026.10.22.07.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 07:45:41 -0700 (PDT)
From: Anuj Gupta <anuj1072538@gmail.com>
To: axboe@kernel.dk,
	asml.silence@gmail.com,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	James.Bottomley@HansenPartnership.com,
	mkp@kernel.org,
	bernd@bsbernd.com,
	joannelkoong@gmail.com,
	miklos@szeredi.hu
Cc: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	joshi.k@samsung.com,
	anuj20.g@samsung.com
Subject: [PATCH v2 0/5] dma-buf backed NVMe passthrough I/O
Date: Thu, 22 Oct 2026 20:14:51 +0530
Message-ID: <20261022144501.2478417-1-anuj1072538@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for dma-buf registered buffers in NVMe
uring_cmd passthrough.

It depends on this fix:
https://lore.kernel.org/io-uring/20261022132027.2293931-1-anuj1072538@gmail.com/

Patches 1-2 add import flags to the fixed buffer import helpers, so
uring_cmd users have to opt in to dma-buf. Patch 3 adds the io_uring
side, patch 4 lets the block layer map dma-buf iterators for
passthrough, and patch 5 enables it for the NVMe namespace character
device.

Tested with this liburing test:
https://github.com/anuj7781/liburing/tree/rw-dmabuf-pt

Changes since v1:
- split into io_uring, block and nvme patches (Christoph)
- pass import flags to io_import_reg_buf() and
  io_uring_cmd_import_fixed(), and make callers opt in to dma-buf
  (Christoph, Pavel)
- add io_uring_cmd_hw_done(), so nvme no longer handles the dma-buf
  map (Pavel)
- warn if task_work is queued with a dma-buf map attached (Pavel)
- make the -EREMOTEIO conversion explicit and comment it (Christoph)
- refuse dma-bufs larger than 4GiB on the character device

v1: https://lore.kernel.org/linux-nvme/20261016103453.1129150-1-anuj1072538@gmail.com/

Anuj Gupta (5):
  io_uring/rsrc: pass import flags to io_import_reg_buf()
  io_uring/uring_cmd: add import flags to io_uring_cmd_import_fixed()
  io_uring/uring_cmd: support dma-buf registered buffers
  block: map dma-buf iterators in blk_rq_map_user_iov()
  nvme: support dma-buf registered buffers for passthrough

 block/blk-map.c              | 15 ++++++++++++++-
 drivers/nvme/host/core.c     | 16 ++++++++++++++++
 drivers/nvme/host/ioctl.c    |  5 +++--
 drivers/scsi/scsi_bsg.c      |  2 +-
 fs/fuse/dev_uring.c          |  2 +-
 include/linux/io_uring/cmd.h | 14 ++++++++++++--
 io_uring/net.c               |  6 +++---
 io_uring/rsrc.c              |  6 +++---
 io_uring/rsrc.h              | 13 +++----------
 io_uring/rw.c                |  5 +++--
 io_uring/uring_cmd.c         | 31 +++++++++++++++++++++++++++++--
 11 files changed, 88 insertions(+), 27 deletions(-)


base-commit: fd13f31ac62abac4df2166bb0a6fbff53b288e0c
prerequisite-patch-id: 6ad52e1ffc603df71c6855926838f2df402c3ed1
-- 
2.43.0
