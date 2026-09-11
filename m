Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97143D5221
	for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 23:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789169737; cv=none; b=NdIMHwKuxN5i4wlQ342fMeQoBS/Cc4EeOd7YECc8uw+9yLYzkvJj/uKKYwtZ9MDOBkif/5rU9VaIUO3/+tp+LiKaEJxLkzJM5TEEZNluuJl4g7EiHDr8ByZ/cy+Pe/gw68LG8Hm8rIgdjoHlFEc/s//WGWdr4BFtHhkyTyjFiUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789169737; c=relaxed/simple;
	bh=idtG4BIfN1aJLK/ksdnNSDY49721gEMSnNu4pwKBRUI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RQZhQUH4agEPmlYXm6CCZDhoqzmIZFEMEqYTGeNWO2BU9bYgU4BHBDRZXvmmxbXRgdPPzgE6X9roRzmgY2216oiOAnMRRdpI+MX+rqjXd0rN8o3cZK+7MV2KP5BL6zXgpdxv8ma73l4GUVc/lrgYc+LtcLI6HIcjqrTsf0F0NMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UhlkfC1d; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhlkfC1d"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e66390995so460755e9.2
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 16:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789169734; x=1789774534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ppxFABqW1va2B/u/vT5bBn5AGNi29bq2r/je6ReMZpY=;
        b=UhlkfC1dU9xzfybg3KvN9q2bF/upCbIJ0l4UwXSTc/hBPhrFuaveOgb2eXoX7H12ME
         gL5rS7rHcpQQ2/z+PIkutyx4jXLMmDLWfR3ku7teddwRA+PqDlOTXO2jfLung7v2aUxT
         EuAe1jyyeNTFG6taHFSF3Q3XchrymEty2pd+unfqsaMbQbwn97UY9hlEepcCdskVOCEu
         VHd3/WygCfyW3gArQ9Ri1b6baQQLkHL9fw9jr9vAH/eEWBUAy0YAnt7LN4ISL9RHPdCo
         XwNHYqLNZM2TmI7s3abuBJK1wL+9pNmN961zkLE/RScJBkIaMjhJMvdhuLtrnrXOPolG
         TsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789169734; x=1789774534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ppxFABqW1va2B/u/vT5bBn5AGNi29bq2r/je6ReMZpY=;
        b=Ytt+gYN6EYsrueyJNPUTBcUYwtb8g8ICqmcW9aaDrsrW3ewFCaGLmOe4cSGddFLg/f
         c79P4pwsG9vcC04h9V5rEZFImugGxXqzJAgUL71QU8E6ouyY+IBh42nyLlVa9IMiwiFf
         H8JVOj5TlSpxTMrc7C7E71rhF/SA/1oUInP1Mz0QgOsKupMFQmHIDu8JlxZuf+K5fkSs
         7PKzGb6JWT/bv793HgICBzS1OGgRbxiRRKyTKAuP+Gc8Vm4Jkdi3HGFqLm216Y6cxqhv
         OW9ePIyAh7gspnFPhqkd3jCXXb6VQrIwtHaRLQ2shRVpgCK4oPVVjex4WVlOsDTbgUj+
         zmMw==
X-Forwarded-Encrypted: i=1; AKwUvBx7np1WiN/ZRIlyEyzh0qGzr5pVF0KJz54kaY2UxLq1bs8JFStEE2BXw/2aAOIvrVEkLD0FlHqQ+JapZg==@vger.kernel.org
X-Gm-Message-State: AFuF++nDG9cHw/mrw93NASfL6NDa9QISAjztASDYs8OsY5/uyIVK6T6F
	OJ2FqMzfBw2TZgznLnVEyQ+ee61fv2z/ePATZxosrO/7mOpHDIbMZ1wd
X-Gm-Gg: AYBFou3rEo3/O75QQtZsf0/HCaCg/Kpp8uXC+JglxuIgRo6jJ/Tjlrg3hgYG23jKXKu
	gqMmeWySGwg21GsEO8mLbINicc231bHYTkHn5d5Tt+0MydFljfgGxowrJFVkjYd90Ljo9L8akFM
	aR8nuaEN0syLNSrevECyrjDt9M56c4EEggSJfVTeMfQUFCOWSWb/vk1eFPmEX3shD2eZ5FfAwfa
	g7eM2aaxFLiNOYm6UUMA6aAhDI65QHstub/QoH5UYV69Uox9nlCelpYWIvzs2XHJ20tQjuxjx8X
	pB3VKea31ALgtqliQHmWIzpI5m7M0ITBL1Jlonlc2f7hiNb10XOvsyAHd6uB+D27iWK6Ok81Jhe
	13cy2P1SeRn14YyH3t32Xe40FFUF1r8eYvs0PYXRPtrfvBDw4N+MNgffuEOn72xlzCs5VZJ+V+v
	yGJbLeN/ZiOmjrNUARnC8+aNqtVUcEUiyl5NcGNtd4UsG9ebW+GWBzfC4TFfVBcK2QJXeF6pIiF
	XdoiZlWatIgP+cXMm82qcR3KFUZLl6BpWNdi7VDf8IZs8kP3b9TTOay9UG6g5H1l7VixK3l3GnU
	UtTHJyD9vEWwC/CTYrNvBUmpJPkWcU5VpUkh
X-Received: by 2002:a05:600c:4f87:b0:49c:fea3:8633 with SMTP id 5b1f17b1804b1-49e6cbf758fmr3040445e9.24.1789169733994;
        Fri, 11 Sep 2026 16:35:33 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-114-033-154.95.114.pool.telefonica.de. [95.114.33.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c39086sm172107795e9.10.2026.09.11.16.35.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 11 Sep 2026 16:35:33 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: Fix the thaw_bdev reference in bdev_freeze() kernel-doc
Date: Sat, 12 Sep 2026 01:34:14 +0200
Message-Id: <20260911233415.31271-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel-doc comment of bdev_freeze() refers to thaw_bdev, which was
renamed to bdev_thaw by commit 982c3b305843 ("bdev: rename freeze and
thaw helpers"). Say bdev_thaw.

Fixes: 982c3b305843 ("bdev: rename freeze and thaw helpers")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 block/bdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bdev.c b/block/bdev.c
index cd8323083740604da145563aa8e7b55c4f627467..fac74319e9fbacc9cf2bec4a4b043b837a9678ab 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -292,7 +292,7 @@ EXPORT_SYMBOL(sync_blockdev_range);
  * The reference counter (bd_fsfreeze_count) guarantees that only the last
  * unfreeze process can unfreeze the frozen filesystem actually when multiple
  * freeze requests arrive simultaneously. It counts up in bdev_freeze() and
- * count down in bdev_thaw(). When it becomes 0, thaw_bdev() will unfreeze
+ * count down in bdev_thaw(). When it becomes 0, bdev_thaw() will unfreeze
  * actually.
  *
  * Return: On success zero is returned, negative error code on failure.
-- 
2.39.5 (Apple Git-154)

