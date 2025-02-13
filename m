Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AE221128A
	for <linux-block@vger.kernel.org>; Thu, 13 Feb 2025 10:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739441182; cv=none; b=i9MJdfzoEzjPMsIcOzEi4sHd7gObns7aKZH+4r2/zQdC7zOkFsNEmSq94ZbDRq7GFfcIISl8TjpnZRaw1a8uDkvnP4RuteL6JR9InC0jRh2ek76RQ0ZpS+WIaZntTnZHhwwTWFSCeaSaOaLhDrHJmv2ACMgHNqneNTcCOy78jXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739441182; c=relaxed/simple;
	bh=IrFbBbfqEiJa0zHa0999cM4RYYVv3FsmmGN25izoDuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S6pNG0Nl55yLbLYQHgLNHH8s/VeXSEla/oQkkQiL0g7BTo40/rSkKLg0/3DccGic7nf4ghfaMIPDqKdl5N3UdpPidaQNMiq4k4+332B2Az6M0vOy66OzIzxGthDKJYaJQZZrrws/tojj7k0AS1mL7z9ZCP/yShGAzwjIl+RCTjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=MHcRMTDr; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="MHcRMTDr"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f7f1e1194so16681675ad.2
        for <linux-block@vger.kernel.org>; Thu, 13 Feb 2025 02:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1739441178; x=1740045978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ULrQM8jS/N8rKIapgYLPr6eiDKMqeLmtTdffubtbGqg=;
        b=MHcRMTDrg+lsu0sUpHRMJjp+JMFX2lLQ2nFLlnE+AMbugCryu6Gn6YdQwcp9ao9YgN
         y4t4svLPL3ri2aWYvIiEsgHo3ALVbQa+FElys5QvqCDxQG33438t5/okWNVF7uDtK+Mq
         0BPlkYNCzOv/f+r9m6n4rd5zxOcoIdqA3kO7UkFb6a7VpoFJN58b5hBrsWXL/6laiDAZ
         ExxPt6PVspAuZwzvMrIyINXuaObh+rFIuGi+vJiUCy38PFYm15A4sXkZ5sIP6xLNmjBm
         VJl8RL46cVh+rIjDCoZhssuj3v4wBH8iN0nlnrIkAXJlXWH/EC7vwA0jzF3aE3TS/wqR
         1XDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739441178; x=1740045978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ULrQM8jS/N8rKIapgYLPr6eiDKMqeLmtTdffubtbGqg=;
        b=g54RC5uW7m2eoE2rQLtp6K9p5/lx2A1JF9U3Y5w+1CkgQ/FQivE4mnXNc6swt22uTZ
         B+3GfjfLRtcV3pAMBSOPuAuAndUTqW0lKwQZxnGtH1lN5ExfzVUdbgaK19Gqr/NeF3lw
         SeDE4lMMct1OzTxL8R2UnM3yg8t9U/l6/btXQxWO3D2WiQI/4DJ9CTb6+LgiJrmXw2nu
         SZo1Xj9tVRDTvHHlJ+Sr1vq56jfNGAtd5dSzTk1y4kEFOBkzuf5ulGDiuVVeGF+95n50
         THvXpUugEPrf1me28oo86Ikhf98VyuvLHml1Q9LdLrHlgZ0C4MuLHFx0xVfKsDzFOdmx
         7wfw==
X-Gm-Message-State: AOJu0YwuaVoHvmcDxM/+J77ud1dIcEdDR2+yg9tzD7WOHTL7d3jGe6Jk
	IZg8IfaiG951OMoqx44u8cXIN2Z8Zv8m9tVHAs7mhKDpaZPZ4fzZXHqnTPrKSsM=
X-Gm-Gg: ASbGncvWMt87Ev7ywAdvXemeyzAZWB2ijel952uHjKPK+6u1Iuy1/iv6CAJrbL0vPvU
	Wvdfx+beR4SX/3Ccb7KrPhMEXGqOBwzG6OManjB4BiUlUrQOjgWiE+K36lLyMZ9AnUftJtNncMM
	SNY+VDvXGWwoitBTLZlj7HiHFkA++JBTS/9NBWwTi6dFeNYsTreSPKGGi2TdmWnuXXwbjix5gco
	jpQGXAxfk6xFxVK2hI1auqL2o2CBbfr/9WDkSBBnApb7HZnfNmk8MHKV5OaEJzxLvhoJ27pY6c6
X-Google-Smtp-Source: AGHT+IFZcuS+n+mUKTvU8TcdE7azW/glC+u+MrACA5Bttms/YcqUyP54Tik2TARGAWcwEBYeIi+8Qw==
X-Received: by 2002:a05:6a00:1d99:b0:732:2170:b6aa with SMTP id d2e1a72fcca58-7322c3f4df1mr9438701b3a.16.1739441178506;
        Thu, 13 Feb 2025 02:06:18 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242761569sm937442b3a.130.2025.02.13.02.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 02:06:17 -0800 (PST)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: yukuai1@huaweicloud.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH v2 0/2] Fix and cleanup some comments in blk-wbt
Date: Thu, 13 Feb 2025 18:06:09 +0800
Message-Id: <20250213100611.209997-1-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

v2: Take Yuai's advice. Modify the subject of patch #1. Move the
modifications to the comments for wb_timer_fn to patch #2.

Tang Yizhou (2):
  blk-wbt: Fix some comments
  blk-wbt: Cleanup a comment in wb_timer_fn

 block/blk-wbt.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

-- 
2.25.1

