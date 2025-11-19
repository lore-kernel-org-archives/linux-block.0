Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23363702F2
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 03:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763521587; cv=none; b=VxH2zM2n2fNLOc8RLs+Nj+Jd6FZ5ew4GWNnR/L/rpBIPih+h/d6RGS0KS+RiLrtO5xXOH8Fcd66ggl2IhODbMVU7Gbx+IfG8QeMKI2jlA+CiE6/j98ju1FTs+FTzyj6Bbf2jioUdCyvL+nFei+qTQM/T5nU5g8rLpy7CznoEncI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763521587; c=relaxed/simple;
	bh=6gyuz9tf0hIcgg0bU/0HP/4zUnzh/1Aby046pI6j7Zc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rZ9bRxhaRlc1B5o7BD7iO3Jy8WuBoFJn4ucyzxJfjZQeiL9r9F3tjIjfGa2Q4w00i667MxPw6nTQFquyqpx20qxoqoHEgnJyQHba1bhBmCcfUbfmmOrO+xlMGq+YjYI7wHYqm5TCy1Dle6/1I97z9rVwPYGLt0nrcBS7nTH9zyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuYQ4djE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuYQ4djE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F68C19425;
	Wed, 19 Nov 2025 03:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763521586;
	bh=6gyuz9tf0hIcgg0bU/0HP/4zUnzh/1Aby046pI6j7Zc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cuYQ4djEUOxe1UXChYZimFlTMlANClR9STpuTynePIN4lgcF9VpCd9W2l0pCasQXm
	 YYeUritb8HDGQPCt+zF7Lp6O+EX/3DoN0jmEqwqV8n30WPswf6nKg28D5d1AUszTaf
	 nwMi+7KTTYdNcD1If4jNyMHVeaqVnPzQiZpHf5VdOZjZ7/KtzVvCBpIDD7CXxUofKC
	 0egPYJn1PEP0H7b9rmM1GzH8lYGhw7FmynMJgJ9rKzTKxAhT4SUjY3nYg9XEpC9Qxr
	 XLy8LuLpjtheXMSJkBwcNNcVid7HrxJ8s0ttUXzcHOSObDRzyCBi9mPQscxeUNX5Wy
	 ZSYMtx6EoTq2w==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH 2/2] MAINTAINERS: add a maintainer for zoned block device support
Date: Wed, 19 Nov 2025 12:02:20 +0900
Message-ID: <20251119030220.1611413-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251119030220.1611413-1-dlemoal@kernel.org>
References: <20251119030220.1611413-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself as the maintainer of the block layer support for the zoned
block device code and user API.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 037275e53cc5..7157e41e3fa1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28313,6 +28313,13 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	arch/x86/kernel/cpu/zhaoxin.c
 
+ZONED BLOCK DEVICE (BLOCK LAYER)
+M:	Damien Le Moal <dlemoal@kernel.org>
+L:	linux-block@vger.kernel.org
+S:	Maintained
+F:	block/blk-zoned.c
+F:	include/uapi/linux/blkzoned.h
+
 ZONED LOOP DEVICE
 M:	Damien Le Moal <dlemoal@kernel.org>
 R:	Christoph Hellwig <hch@lst.de>
-- 
2.51.1

