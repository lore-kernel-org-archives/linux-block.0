Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04D14A2617
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 09:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792055481; cv=none; b=nFxepEa6bHNFWyLLf92DFXInuniyi+CJqgtPxndVp83dkIh1svk7b+ImVtUHxkuFBUfZzSDD8x9pmLUF/GD+aByC/8FsIYDVQWPYO+FZN5i1wszM+Nj1mHToleIe6L1eshYcUmVU0wA3hTht8bmpicdSewxahytVW1aWeebNen4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792055481; c=relaxed/simple;
	bh=z7htjFtNdmyDjxtzMIUkA5kmK2peP8WrA+vCIBzfMQI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Uff5GKgpVOV0u0gzAk18VGZyKit8lZYCZ6S5omhCDvEsFiLqmpOmdwUFaxVX4a8kJloqooaDpiVGkpnfl3WLKM5v1ZYFM+WmgFgSex+vKhimE5ly44GMg3BRsWkRpjjMdvOh0kwYbryz0n24l5pdYPPolVUd2VYGKM/PQcO9WRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=aAM/lsE1; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="aAM/lsE1"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc50ad2d650so3854477a12.1
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 02:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1792055476; x=1792660276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mGOn0xOwuTcpXWjs4SNmPz8oRcx6kK3kpK0yQjNzznM=;
        b=aAM/lsE1Y8rfvck3UgiqriLEM0WHIEw+n+XA3TSLCB2DQ6gK+FStNIuFXZOZmFDs5c
         8Xury2EUxaKm4w34XvVFIcHD18YytFFb58jkZqXe9hlvoPnG97M4yPQh62lsO3re1nDG
         W9FXXofzXJ4lU23MBEd5syyjq7nLMmMSCBxTezboYmr5adXrFEuU2tVVMw260gQhRm/a
         HuRrBd57LlMI4lWMSogfGTDv2iEWw1fq9JNMLgTExoBbTsQws4rMo+ZTIDbxSQbrduxY
         WVCtRntQlEAoH9i5u4hbh6atEuRRiQTgfs3rWIHIxNDj9VGiE5zZN/7afoNbXeJzfMeT
         HXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792055476; x=1792660276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mGOn0xOwuTcpXWjs4SNmPz8oRcx6kK3kpK0yQjNzznM=;
        b=Nd2P2Di2bFA5zLJmBssWjWWvoOelCOzmIF4waQ+v7vm8sjP2X4kJaWPYow9N9/9c72
         hHttwcIbWOGYyE+RBEAPNyJp3jwGC/Ot1qZDv2YH9ntHF288K7BksoKTqZjMtShLSKF7
         zK+pLQY1mkAKyfRikxelnVtSvO7iHNZOTESRRtCLT0XwbITgYqib7xfz5UVKisUMhY5Y
         0EQcBoIm2iCa1LXl7hNbHadiBQ83z5xH940yD9T4ZWJrO9c7IhXbgj4fzpGb9eS0oMqK
         KmSHnZ+ASvVdd2oHmFT2FWlJ+6/YzzlaNU1RpJzYjwj6VW6cK7CwCpvLPoej+heliR5m
         MpHQ==
X-Gm-Message-State: AFq9FYKrx3IoifaDQAhL5ZkEv3L4P2nk8BNKKxWtX75E6L6nGKRIqCo7
	Okp0feWXl6jl7m3ktx1dGuh1ZA3QZNI8bxPgwrkIMKnaBrijGfFvsp6s8X6w+S2L4VvXr2bs9Jl
	5ujev
X-Gm-Gg: AYBFou0nFTSCHh119IKcRBPKaZmq4qH66Ll+Ca3jytz432nCynpNa8fM8F8+ZmE/+pI
	h8J2r10c7zZnqp63FXEmT6IO8EGxOt9ScPDKEsJr4Q4PJkrgUoQ8M2bC4k6lXsSxijzuFO2MQ8g
	SySZbS2q/lPFSY2hCAnlTCZNq8IJhH4Fvc7ZiaTmoJjYnP1IoSnK2Gdd2EywVCS/Q/sQrBtWybe
	ugwnbkxsQ7zllkxTea034tFD3EwiMegrMECRn3TRdv2Ndc3wzeCJ++ZwH6ApqTDPpRA3j0vVwTJ
	aeR950XxxiYEN8jQD6WioP9IghBmv2aTNtoLAQr89ijt6AMpg+7RpBYdWFJjV95AuLVXG0wi6Yh
	5e+sVM8QbWGSss3KvRMikEcdjNLTGCn5EoL/e1wPM9j5qBDomXRUs0rL8O1aos2YLrOM8ISAMS4
	ZED7rWUxlkCxwByUNKSTWf5Hde8F2SA360P/9oJBqqmlypdWD6pCs3U2CsuKknbamw98RiUsU3u
	Q==
X-Received: by 2002:a17:90b:4d88:b0:3a4:a850:6982 with SMTP id 98e67ed59e1d1-3ab3a7786e4mr16579148a91.26.1792055475591;
        Thu, 15 Oct 2026 02:11:15 -0700 (PDT)
Received: from localhost ([106.38.226.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac945e74bcsm3531055a91.3.2026.10.15.02.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 02:11:15 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-block@vger.kernel.org
Cc: jack@suse.cz,
	axboe@kernel.dk,
	viro@zeniv.linux.org.uk,
	mcgrof@kernel.org,
	djwong@kernel.org
Subject: [PATCH 0/2] block: fix NOWAIT handling and locking in buffered write fallback
Date: Thu, 15 Oct 2026 17:11:03 +0800
Message-Id: <20261015091105.1315605-1-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series fixes two issues in buffered fallback for direct writes to
block devices.

1. NOWAIT requests can fall back to buffered I/O and wait for writeback.
2. The fallback path lacks shared inode locking against set_blocksize().

Julian Sun (2):
  block: reject NOWAIT buffered write fallback
  block: take the inode lock for buffered write fallback

 block/fops.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

-- 
2.39.5
