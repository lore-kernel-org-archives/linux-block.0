Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE993D6F
	for <linux-block@vger.kernel.org>; Sat, 10 Jan 2026 10:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768040274; cv=none; b=CaP0w5BhCB+VC7wun9w6zeR5OvpAM0yqExUQGLlrPPOswmRTBrU3/57+/dplCu73I115qUJvmoLzmPVLyh086Prc1hHz0PFMW0ZHcmgnZroDUbNKjXG2XeT5y5bqOKWAAqI695Zfj3NFTzzs3KWrNMh3tg1UbO59UFw/wZAljr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768040274; c=relaxed/simple;
	bh=TFElg+ocxSDjUAwDI01Y3pSQ5vBkd4pVxylV+ZF53fg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DL0GWaMhWERDDYqko05dEq0h2HNeyp6elBw48roN7WNNJNszdWsxkVRcnvKJuA7sUnDo5h2bpaJzbc9yjRudkWVgfZEax98pIAe2ue0k6klGLThqe134zCVw5vMZUT2RR0jaGHWp07TrnB/zF+19n1s0h+FNKuhbkH0HcMe0tto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cNigDMGf; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cNigDMGf"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768040273; x=1799576273;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TFElg+ocxSDjUAwDI01Y3pSQ5vBkd4pVxylV+ZF53fg=;
  b=cNigDMGf62L2BnVP2JgsmzTlc80/ndBPN1PIGd/r+zrWax2a7307f+bw
   OgZq//sY6u+C/+bja0WaAOLWO/8yPT7UG/UuRXxRHSWQGqFQZwdfKT+8i
   tU/WoMt1+nhzzne/Rd+xf2AA4GijgcFhKROKge2FW9oTqcIKuUib7y7Fh
   NKJu7fbzIHR6Xyiy9ftASKBgobdmTHp5IelOYRE2eEbQeMkfTdWbwviBz
   2yaHyrC/lIMJvOg3mGLQUecyn/I+8t6tx3kOluD/jmoHWGTI+G+4w2Rwh
   JugjPJ4BZLRrZcdveRV4OxJKurH42h9KcTbTbrW/+OY1E7fVKCS/M4qLf
   A==;
X-CSE-ConnectionGUID: FGXXtBr+Sau/vX/MyYClPw==
X-CSE-MsgGUID: NkEmX1eKSn610X3VC+Hb3w==
X-IronPort-AV: E=Sophos;i="6.21,215,1763395200"; 
   d="scan'208";a="139716034"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2026 18:16:45 +0800
IronPort-SDR: 6962270d_gB3BKMUnHlrEtPogt/4hMn9f+ylzPggkq+xBIvG9pfMMDo3
 zwoCH3RGn09U01F3LAB41EmjSTClMa3snhFjOjw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2026 02:16:45 -0800
WDCIronportException: Internal
Received: from 5cg21741b1.ad.shared (HELO shinmob.wdc.com) ([10.224.109.20])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jan 2026 02:16:43 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: mcgrof@kernel.org,
	sw.prabhu6@gmail.com,
	bvanassche@acm.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v6 0/3] replace module removal with patient module removal
Date: Sat, 10 Jan 2026 19:16:39 +0900
Message-ID: <20260110101642.174133-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series was originally authored by Luis Chamberlain [0][1]. I
reworked and post it as this series.

[0] https://lore.kernel.org/all/20221220235324.1445248-2-mcgrof@kernel.org/T/#u
[1] https://lore.kernel.org/linux-block/20251126171102.3663957-1-mcgrof@kernel.org/

Original cover letter:

We now have the modprobe --wait upstream so use that if available.

The patient module remover addresses race conditions where module removal
can fail due to userspace temporarily bumping the refcount (e.g., via
blkdev_open() calls). If your version of kmod supports modprobe --wait,
we use that. Otherwise we implement our own patient module remover.

* Changes from v5
- Dropped the 2nd patch
- 1st patch: replaced _unload_module() calls in srp/rc

* Changes from v4
- 1st patch: moved the new functions from "common/rc" to "check"
- 1st patch: reflected comments by Bart
- 2nd patch: moved the srp/rc hunk from the 1st patch
- Added the 3rd and the 4th patches

Luis Chamberlain (1):
  check,common,srp/rc: replace module removal with patient module
    removal

Shin'ichiro Kawasaki (2):
  check: reimplement _unload_modules() with _patient_rmmod()
  check: check reference count for modprobe --remove --wait success case

 check                      | 134 +++++++++++++++++++++++++++++++++----
 common/multipath-over-rdma |  10 +--
 common/null_blk            |   5 +-
 common/nvme                |   8 +--
 common/scsi_debug          |  12 +---
 tests/srp/rc               |   8 +--
 6 files changed, 138 insertions(+), 39 deletions(-)

-- 
2.52.0

