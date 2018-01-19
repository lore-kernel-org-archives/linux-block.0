Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43299 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750784AbeASA5y (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jan 2018 19:57:54 -0500
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-block@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 2/2] xfs: remove assert to check bytes returned
Date: Thu, 18 Jan 2018 18:57:41 -0600
Message-Id: <20180119005741.32058-2-rgoldwyn@suse.de>
In-Reply-To: <20180119005741.32058-1-rgoldwyn@suse.de>
References: <20180119005741.32058-1-rgoldwyn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Since we can return less than count in case of partial direct
writes, remove the ASSERT.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/xfs/xfs_file.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 8601275cc5e6..8fc4dbf66910 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -590,12 +590,6 @@ xfs_file_dio_aio_write(
 	ret = iomap_dio_rw(iocb, from, &xfs_iomap_ops, xfs_dio_write_end_io);
 out:
 	xfs_iunlock(ip, iolock);
-
-	/*
-	 * No fallback to buffered IO on errors for XFS, direct IO will either
-	 * complete fully or fail.
-	 */
-	ASSERT(ret < 0 || ret == count);
 	return ret;
 }
 
-- 
2.15.1
