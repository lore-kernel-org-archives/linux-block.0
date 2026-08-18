Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38FD3EC69A
	for <linux-block@vger.kernel.org>; Tue, 18 Aug 2026 18:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787078535; cv=none; b=Nd6dcawDOxOOCBiccZ5gZ/qlxVw+YYQUT7gCKz7Zy1vbOm1TIYbMtKB0ryvPX131/pKVQjraHnyBS8PvSznEQsm4E37oP3BFnipDQ/6U9vdTiZ3DIiuIICBRFBBu50daKVelBkKTe6jvf0SX9l5n/Rlq3m4P3s0/GJkuo7oCPww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787078535; c=relaxed/simple;
	bh=N1PwiA3l9sN+V/4bbYu2eCDS2YepexRNNqOhf785bQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TXHwXFzXLhyFPLlastJcvNdt3o3hhViXQA7aZBjJzVmFooy6Ux450Itoo3aQFHarJVVxs7aGSuSmkjEuTvPvf9ARPzCyc6bQWOqwi7BiMuCj2itaqKsHVG95mbAD1SGccZZ3Cve4VwD6aFvMc4vUBzbU1wF7Pr+XC8b8U84N0hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZUCYF7a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZUCYF7a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7721A1F00A3D;
	Tue, 18 Aug 2026 18:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787078533;
	bh=oFGib0CJDAkN2xFfALWXvO221aWfjs+b0TGw1MXk1BU=;
	h=From:To:Cc:Subject:Date;
	b=XZUCYF7aMFXf1gWkOZQoctVLwKjnmGa+utF6US+MsffCwOXjAHLoecTN9d2DOfKcp
	 CHy9N1bqI3HQOBmNKxsuz7ShLKaq+tORywYeoQoftas17IMZbV3PSxPBDSZNA+U8EL
	 TdKDTr4VSDYeasPMnHbB+cYSf8bYofekcJSJQv9DWG2HKHhkvQVXvGSpyToNkM7GqR
	 Ymi0MyD/8m34pDq4Qwrot2LWt2YQZXcvz8stQ9OHcvDIicuI3fcUuh81PQrz0zfjTv
	 eLs0e1igWh6WzRM8q2l95c/TXJcOF5UmUkhvbSojlpeTryAUnmRtuOJXtRyTb9dvgz
	 EdQMosuGr6JBw==
From: Mark Brown <broonie@kernel.org>
To: Miklos Szeredi <mszeredi@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH] io_uring: Add missing include for ITER_SOURCE and ITER_DEST
Date: Tue, 18 Aug 2026 19:41:34 +0100
Message-ID: <20260818184134.384991-1-broonie@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix IWYU issues:

/tmp/next/build/include/linux/io_uring_types.h:56:32: error: 'ITER_DEST'
undeclared here (not in a function)
   56 |         IO_BUF_DEST     = 1 << ITER_DEST,
      |                                ^~~~~~~~~
/tmp/next/build/include/linux/io_uring_types.h:57:32: error: 'ITER_SOURCE'
undeclared here (not in a function)
   57 |         IO_BUF_SOURCE   = 1 << ITER_SOURCE,
      |                                ^~~~~~~~~~~

Fixes: 95961b72c57b2 ("io_uring/rsrc: rename and export IO_IMU_DEST / IO_IMU_SOURCE")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/io_uring_types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index b516d9feb0f14..39629ee77b911 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -6,6 +6,7 @@
 #include <linux/task_work.h>
 #include <linux/bitmap.h>
 #include <linux/llist.h>
+#include <linux/uio.h>
 #include <uapi/linux/io_uring.h>
 
 struct iou_loop_params;
-- 
2.47.3

