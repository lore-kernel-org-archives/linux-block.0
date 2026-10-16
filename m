Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290413BE17E
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142370; cv=none; b=KSRm3te1JTA18MjYglnoXU1DeyRuponTMYSJya5kgqWDi9kEBN8MN3rVrAk/cFrSCCl0+vTl6cSqc6Zlh3NLAcBe3MPTnRbe6H0CBcuSHzY2nCiuAMkBqdtC/iRQcBMnHZlY6GV+RfasZLTi5KQckHXEBqJG3La3nQeQ1JAgigw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142370; c=relaxed/simple;
	bh=aTMUcqZURy19NxFvWbxUVqjPoyE/i6xWtuoBHgM6v5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gFjyZ/shk7UC/YyCnT+wMVLvvDcCZ01g6B5Km/WpuIbvktD9JQJ90RV6sWh0Zten+mhnxb4zRoASF4yE7hle/EQo5wCJFpVbpb9Jf6xaLkfW+3RxbPGC11DgMuguGC+bSG6ECbNGEy4iGlXgOhj5a2ziUzFxubvzeqOIAwi+SFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGFgvUJA; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGFgvUJA"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-16079d54c17so568239c88.0
        for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 02:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792142368; x=1792747168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xKIcc9y2gPYr67ZGxXeokwj+kkWiL3V5XBf1VhWPUVU=;
        b=FGFgvUJAv8s2A6YxIjHQoZU7x5wvf7kQ4xu+ZoTgCQWRbGCz1Xg9tKW93AcvOzwgAi
         8LRnhT3op7JDqFFFmQhJ4CHy3tDzDHQq/eYpE7xf+7T08hE5qGPUvKu7A1V6tKUEqMrW
         5rRbMspLxGfMii0OaJvlAtjKTnkXnh1k4qhjo0IfhzSLw28jh7uuFmG3QCeAQQKn7k4H
         TwN4am2PyPHq0iS6sSwbdmsEjGQi+vItStQRrGaQDavCDjQJoP6a/OnKT0QxonRz6DUH
         0A8hXHgezZb7NvG+bSP8Sjp7wAwRdQIxI2lWdw9ngKCyw7QFCCx01xdja1WWBgMAFpkO
         3NcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792142368; x=1792747168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xKIcc9y2gPYr67ZGxXeokwj+kkWiL3V5XBf1VhWPUVU=;
        b=poj7Pzt2xLA76ITWOu3pqSn9WqTvu+HHbdFZu2eqkvmnPFwCJeS4fFBT+WViNH0iii
         kNoBeLgqepVd0cZJnr1Kkedoh1h92nJ6u7QSG4R5KVjtQb3g+kGb3c1HgRzo+IqjT28L
         gT6UtOXZRUc0QY0wtD8/NvCqa8KLXBWnSso+IeSmjKPZ/oPqkG2T68miMe9+U8gQqk9B
         39jXmeRuHMyRTFwfCO6bBz++m7c3A9vP985UQA97GVknWSoGQhm95wikPfz7wvfS+J3g
         Y5XgAJ/4qNa06oT5jtCa7ZuATuE09v3ZSCppEBiRhvfIPzYZ09ppu7Q+KiA6MePnXCfq
         Zr4A==
X-Gm-Message-State: AFq9FYIAxMABgy/4unnYztC/kEaW3SuA1YjmFbJyDb61CC8WNwAeROWp
	Fi7fnkk9SB5O4LEO/YM4oRPfhdUYOVlPzK2iixceMSW/+YLNUQ9oiCI=
X-Gm-Gg: AYBFou0r3zi05PBpTqwkQVuqRtZ6RiR/nzYsBEDUr9hJZ3iHXN0k+Ld1Otd67pRBiSM
	stP9UZ/CtMD6Tcu9MwTPRx1wkJh5E+TEWxwBEKiNo4qTjdCWx5i1hXXD8Rl4iEh05kMPFQvbUoG
	D53NZWpQDvsE/km0IVe94jxP4xjfq3teuXil2elEW2RyKd1Q3nl27WoVg09gZq1Q1nkqe4ORIvM
	JMM8gLGWAMn7/rNDxzjSpicpk0+43dnG2uMSp6J//qkkuWXQMQinnvmYypO1vcYhzShGHZHSA9u
	X7D4L+PuGAzohDZIBVoLqFyiwBJ+9H1cpSL/HkeGuJhRUCV6HxaRvB982wdluUAsb8iGEv/Buer
	kFD8C8L6YjSjq6nXB5HC5EvFS1ENMWhZXg+TEe363WkTWoMhiTpPM+KWSseCQ9AblCkAnSZB8Q+
	gm5G6+M7qSX71vwwzeCCJsREeM4wGHYS7b5g1NBHZirGGtp3wQJ5AISsKrLvlReSITWNGQNq43r
	wrmaFwU8bKDmBABJ3Gvv93Ch6Kt+vC51idzQ1q4XpNJrsXaDGquPqvMek3IIYU=
X-Received: by 2002:a05:701b:4544:10b0:144:c12b:dfc6 with SMTP id a92af1059eb24-16a60ce7b43mr28678298c88.44.1792142368095;
        Fri, 16 Oct 2026 02:19:28 -0700 (PDT)
Received: from anuj-MacBookPro.. ([2406:7400:63:e55a:7bfc:fc3a:e718:89f6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082a7b33bsm9840943eec.24.2026.10.16.02.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:19:27 -0700 (PDT)
From: Anuj Gupta <anuj1072538@gmail.com>
To: asml.silence@gmail.com,
	hch@lst.de,
	djwong@kernel.org,
	cem@kernel.org,
	brauner@kernel.org,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com,
	anuj20.g@samsung.com,
	nj.shetty@samsung.com
Subject: [RFC 0/4] fs: support dma-buf backed direct I/O
Date: Fri, 16 Oct 2026 14:49:10 +0530
Message-ID: <20261016091919.971295-1-anuj1072538@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series lets an application register a dma-buf against a file,
so reads and writes go directly to the device as dma-buf backed
bios with no per-command DMA mapping.

This series builds on Pavel Begunkov's dma-buf block support v11,
https://lore.kernel.org/all/cover.1791975048.git.asml.silence@gmail.com/
which is queued in Jens Axboe's tree:
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git/log/?h=for-7.4/io_uring-dmabuf

A separate kernel tree is present here:
https://github.com/anuj7781/linux-kernel/tree/anuj/fs-dmabuf-rfc-v11-desc-v2

Nitesh Shetty (4):
  block: factor out bdev_init_dma_buf_io_ctx()
  block: refuse a dma-buf bio for a disk the buffer was not registered
    on
  iomap: add dma-buf direct I/O guards and registration helper
  xfs: support dma-buf registered buffers for direct I/O

 block/bio.c                | 15 +++++++++++++++
 block/fops.c               | 19 +++++++++++++++----
 fs/iomap/direct-io.c       | 31 ++++++++++++++++++++++++++++++-
 fs/xfs/xfs_file.c          | 30 ++++++++++++++++++++++++++++++
 include/linux/blkdev.h     |  3 +++
 include/linux/dma-buf-io.h |  2 ++
 include/linux/iomap.h      |  3 +++
 7 files changed, 98 insertions(+), 5 deletions(-)

-- 
2.43.0

