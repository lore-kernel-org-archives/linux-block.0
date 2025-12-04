Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A49D2F9D85
	for <linux-block@vger.kernel.org>; Thu,  4 Dec 2025 02:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764816499; cv=none; b=uxI0amDuHZRS0fbyAG2myACkjXSSHhvBqcMbcIbKjYEmdA7Gs1ukFy5H8lauW0K5UhdosegeXXsyQyA7i8b/7lGQzsLKRuzYO1ZAR7x3JONUIJ6lztGaQGqswrwJcG9b0/wSupO0aSeQL5/IwCCdEK8y/CLshH2hvDo+3FAiEew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764816499; c=relaxed/simple;
	bh=X+yZ/K1ZTsaoVE0DJ49j3nn1ER6Lnivz4II/94xrrZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jQuASSZFTmVMATnvgs7TXWjwht/AoLBn6NFd7Gks783mvf1KVBQEETvW4HrqAywpXoIiHjqraTNQW4icI871gU7OrtPQ5mQ/saFXv91Osvp2m8mLhG+OwRq3ylnc89k3VftWyB+09cHVTbhM0lpP8EHEUZxyTbo+1VIuBdDz0ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDBaazNW; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDBaazNW"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so320245b3a.3
        for <linux-block@vger.kernel.org>; Wed, 03 Dec 2025 18:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764816494; x=1765421294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k7UnwontmyLPrQKRk7Kie3LanJLCzBGPcKe/gr+3MdM=;
        b=nDBaazNWiZOU1HPZ8pFLoHwD0HmeGoP9iqZ5tWirFav0/oGio4gtM2FJ3uP+nledvv
         0Q0BMEJ0Q8NyLJw/CduVHi/u+ch03MFkBQnc8vwRA8NNBdmEnB9jqS4VdwXQTFYg9vXO
         oeRBVmvsV4RFVMbvfzf+RcLPjwN9tMzRqXuq/5xIbdA01AF+I6u2xq2JMHjwCzvE3xqX
         XiGiaV/n7jEPgVrVTBgQhKT5MSEgqmZgNEu+Z2HB3Vo8VfQWMIH80ArCGOAkX+0fyb5q
         THr0pym2eg8NhmkoFSURd830JL93hyPqk3peNAYtAOGgL3g0SzRYJ3nHzqMSatSAq25m
         tKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764816494; x=1765421294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7UnwontmyLPrQKRk7Kie3LanJLCzBGPcKe/gr+3MdM=;
        b=QGslc6MZG2oXJNqYauwFSWq8OhXgtWb2JgbWobzBD64/sWFcx2L0sfzJAQXHOiYpSv
         REJtEyH2ffTaQIjeFbtmg0qeUT1NE0X8XHwMMjZ0Yik3rocNJD6j3FWlOXir35QQ/Rnz
         BhDBYIXS6LFdLqJDi3OASso5PK5Jfe2oPfFxaHUK6lkposqhNrmwB2PvnBkKG1QmDrey
         kykFv0yuwHEj5zZVpMUVZyzto5kC6qT4z9rr712y9DobUXUlViGGLHq8uO4Dl71amsKV
         WLO89AwhugeiGo/SZOoE5EYdtAtXE/j4kuNG2Er96+IBY75QqgAXy/qDzo5an7WR8mqa
         5Khw==
X-Gm-Message-State: AOJu0YykOe1AQ/0oRsjKE3DSMUUx+AeehCCUm512GIdkzFHZPOmMXbao
	Rq9Go7tNUraerWz2yhWU/zB188bsBFcgrDDnZuqpZFf5LQ7VYCnSB8Zo
X-Gm-Gg: ASbGncu8rbLHKzm3K15ERn41DTr+yw4GW1ytFBATl22GRmWwPuJNLS3QzQ4xlcWgneh
	fY4A4Vl80zBgFbpIguoSa+3ue2lyGcdqT0LDWjDMvMxqhENlZbCfLkivxKy/pPjfmfc08VRfWWI
	xX7XBkP2O6WMlyw8UxewTaPV5Lydr5IC8XRgbTXMp4b9yGPzALYmT4jAEAFEAjz1ev9i3VLpNgL
	Xeu8bnX+G1fdtSETO03Hq3528tC3nGafjgdY8A+wn9m1RENqhxAkrZcqJTjZRSSkh7y6PgzO0lY
	FVeJ8GicD3WMSIe+N9HhqfxH7jmWchECDM5dzonwkUnBQn49YNXIXkXvDcTw9tXZfFQgHOBLc+o
	WQK+mBfSOvdE9HJVGKDAf3r0l2Fde410wv2eWDOUJQXnFgTd0wbzfbgf346I6LXSDW/IjN3Rd7D
	jHOykQwW5s0pgLd63yJh3LGVJg0w==
X-Google-Smtp-Source: AGHT+IFOKtCW31i4FdwWaXVGRlDrC9YoWC6jwT8zUUWeS8OToViJXaHXySQmsIjV9v+TS3YVMPQbKg==
X-Received: by 2002:a05:7022:ea4a:b0:119:e56b:98a7 with SMTP id a92af1059eb24-11df6463f28mr613468c88.14.1764816493587;
        Wed, 03 Dec 2025 18:48:13 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.41])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76e2f3csm1838847c88.5.2025.12.03.18.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 18:48:13 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: Johannes.Thumshirn@wdc.com,
	hch@infradead.org,
	agruenba@redhat.com,
	ming.lei@redhat.com,
	hsiangkao@linux.alibaba.com,
	csander@purestorage.com,
	colyli@fnnas.com
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH v5 0/3] Fix bio chain related issues
Date: Thu,  4 Dec 2025 10:47:45 +0800
Message-Id: <20251204024748.3052502-1-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

This series addresses incorrect usage of bio_chain_endio().

Note: Patch 2 depends on changes introduced in patch 1. Therefore, patch
1 is still included in this series even though Coly suggested sending it
directly to the bcache mailing list:
https://lore.kernel.org/all/20251201082611.2703889-1-zhangshida@kylinos.cn/

V5:
- Patch 2: Replaced BUG_ON(1) with BUG().
- Patch 3: Rephrased the commit message.

v4:
- Removed unnecessary cleanups from the series.
https://lore.kernel.org/all/20251201090442.2707362-1-zhangshida@kylinos.cn/

v3:
- Remove the dead code in bio_chain_endio and drop patch 1 in v2 
- Refined the __bio_chain_endio changes with minor modifications (was
  patch 02 in v2).
- Dropped cleanup patches 06 and 12 from v2 due to an incorrect 'prev'
  and 'new' order.
https://lore.kernel.org/all/20251129090122.2457896-1-zhangshida@kylinos.cn/

v2:
- Added fix for bcache.
- Added BUG_ON() in bio_chain_endio().
- Enhanced commit messages for each patch
https://lore.kernel.org/all/20251128083219.2332407-1-zhangshida@kylinos.cn/

v1:
https://lore.kernel.org/all/20251121081748.1443507-1-zhangshida@kylinos.cn/

Shida Zhang (3):
  bcache: fix improper use of bi_end_io
  block: prohibit calls to bio_chain_endio
  block: prevent race condition on bi_status in __bio_chain_endio

 block/bio.c                 | 11 ++++++++---
 drivers/md/bcache/request.c |  6 +++---
 2 files changed, 11 insertions(+), 6 deletions(-)

-- 
2.34.1

