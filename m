Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20D718C02E;
	Thu, 15 May 2025 06:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747289865; cv=none; b=MrhvGepRlvai7vGuagdWmR4TBCBZO8zdTYTXZVpN1sxMD50H4sp+gOZJFZRd1rgvlyNB9aKGJLCm9c50AQ6HS8telqVUP8KG8j72dT6MfCsSKMqVeYFk2dIfAp8WBlPTYF3pTD0Po4nd2rxR65i0SV3d7aVPBY7ryepsng4l9Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747289865; c=relaxed/simple;
	bh=oru/zjh4HWQQQVjgjm5hZII0Yl/eTwNGeswMe2zOaG0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QCfJtQlA9ihXi6ceuhActQesdviAJPXB4JQQEBsobBENFG7hfibaqu2ey/XWWe/p0QR9a9uQhLunKHZKjgGLeSDk0VjKbfK5/pX/mP2Dfh+ElatQsttWs0frix/20Pt+Z+kkKvPu2l6zrM7gO9F/TjRKWg2WLUaTWKUaVy8t8D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bx6YLr8G; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bx6YLr8G"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b13e0471a2dso285682a12.2;
        Wed, 14 May 2025 23:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747289863; x=1747894663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hubB3bq5hrgLVSF8PoDBX4VrowZwZMhu6qQo8MKJuAA=;
        b=bx6YLr8GbrKYX8N+26a/RctPWo5g6LFsVEEVgjhenNHK9kf5kwFlZWxKimXV5Aku9X
         JcwW+tyYW5rwrbr2eyKf1+Xtp/6OL9stj0fO1R7cmIMgUMkXSjgPnh9jdn6m5PClXVZi
         +igRxbr7cJDLKYuz19nKKqzT3SLKIPHf2QzqZ+IOgkXfb4z1X6iKul1KugnuRyZcv+zz
         e7zTvp6DuOJd7ngDVSq2/hgNe+NBB7kCi995Pig1KvOa2v5eV4X8cbH1MxTK3Fuul0b+
         xdiSKfbL3c9WkBMfSNZQhK7Kuo/8yfcV5WhHp1EAKA2FX3DX9xCksMK//cdLzofkRUPr
         0p2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747289863; x=1747894663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hubB3bq5hrgLVSF8PoDBX4VrowZwZMhu6qQo8MKJuAA=;
        b=Korh+bvt8lJQRAw/o7GD3OpGtpMLdpz+3dfIttXMdV/2UC/KuxUi9b6XHddrwVZjeY
         ChuFVhxns3a7kPmZ2iQz8dT5TDP69nHkpY6ekTb/j+Gsyl0mskpW0osyH46s9hFSdMrJ
         nhs28XFtAOiT+q44hl6Nc1CYdNpZ4tx8RKk0Knlhr83xsEweAJhUJQHcwSNq1LeSqkLR
         sHw9JZoQjCeBHTfMwZBR1U8rHSnmICg+BCicsA73PC9qdqgx0BZaOfFnsTffY+nzGCa7
         4ocfBSNOScPqTBamcLIeQrofJ+G8VEzjvKvd60vYGeHOnmQg62YMT2Vfu1YfpkrOuqSK
         wYuw==
X-Forwarded-Encrypted: i=1; AJvYcCX0G06Yn9SUp3QPIGIQiHkC0OnldPMb8kiZbxVkKV/R1fWE+aGP/DYsZJK+UbPdr1GMn5Hc4HB0nX+LcQ==@vger.kernel.org, AJvYcCXo7qMmeoIiFYpVYT8C+KpRsmPqhnnQ/c7rTQGSOkoTsOqQts2+yL/262YpXo8prULglR5fNCB8GD0UCOoDghD52xRi@vger.kernel.org
X-Gm-Message-State: AOJu0YxjwiOiKeprAkgr2Up5n+iaZfpAlzhEI8htsk+d/AAjCoMpmrAW
	zHJBUrhwnTRWCDdLJZrffK4EQzYlbDkgd8TJOiULp4BWG9AbCT7e
X-Gm-Gg: ASbGnctmqet+STCXihzV6J1xxDeomm/dBdnTk2nmlgDbgA7coiH1w6wWlKRL3nEN7/b
	kAz3PEzPuEpsrtp8Kpxr6ZXBcKwmbNDRGVCLtaaXDAgUsfdIKZDDELK1zqoikKytIWn6CT/yAwr
	inchVkLLS9pIKPXGbx4IVIGva1TtkvylS8cl5Znt0u1Se+YILVlYyLxDJeGqyNsm2ihGaHnVcHT
	umr11Wj198c8ZiKrPRCTSvfd5yxK9tp4mNcBPgChLVgONoKuQn/OPUdfF9JgvhIGNXy29AvmLwa
	G7Dj+bVrDV5IArx+92TEp9XNIsbH3QNP+0JwIyr0+0V4uwAZ8SukCqbTF5mczD1qZhEl61Gjtwg
	tkqhmoUhSME10UOBtfueMcAWEBG6MiKdKNQ==
X-Google-Smtp-Source: AGHT+IGlYnQb7Enm3HGEax4wj7K5Yq5K1lhUoJJzjXGCVjDzOtMUonq2TACY0cPT/bA97WY+fMSi6A==
X-Received: by 2002:a17:903:228f:b0:21f:85d0:828 with SMTP id d9443c01a7336-231b5eba1e0mr21553355ad.41.1747289862974;
        Wed, 14 May 2025 23:17:42 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc8273d93sm109242375ad.150.2025.05.14.23.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 23:17:42 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: axboe@kernel.dk,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH v2 0/4] relayfs: misc changes
Date: Thu, 15 May 2025 14:16:39 +0800
Message-Id: <20250515061643.31472-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

The series mostly focuss on the error counters which helps every user
debug their own kernel module. More patches making the relayfs more
robust and functional are around the corner :)

---
Note: this series is made on top of this cleanup[1] and unmerged commit[1]
[1]: https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/log/?h=mm-nonmm-unstable
[2]: https://lore.kernel.org/all/20250507134225.63248-1-kerneljasonxing@gmail.com/

*** BLURB HERE ***

Jason Xing (4):
  relayfs: support a counter tracking if per-cpu buffers is full
  relayfs: introduce dump of relayfs statistics function
  blktrace: use rbuf->stats.full as a drop indicator in relayfs
  relayfs: support a counter tracking if data is too big to write

 include/linux/relay.h   | 19 ++++++++++++++-
 kernel/relay.c          | 51 +++++++++++++++++++++++++++++++++++------
 kernel/trace/blktrace.c | 22 ++----------------
 3 files changed, 64 insertions(+), 28 deletions(-)

-- 
2.43.5

