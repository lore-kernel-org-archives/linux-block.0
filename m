Return-Path: <colin.king@canonical.com>
From: Colin King <colin.king@canonical.com>
To: Richard Russon <ldm@flatcap.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-ntfs-dev@lists.sourceforge.net,
	linux-block@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] partitions/ldm: remove redundant pointer dgrp
Date: Mon,  2 Jul 2018 08:13:59 +0100
Message-Id: <20180702071359.6534-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-block@vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Pointer dgrp is being assigned but is never used hence it is redundant
and can be removed.

Cleans up clang warning:
warning: variable 'dgrp' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 block/partitions/ldm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/partitions/ldm.c b/block/partitions/ldm.c
index 0417937dfe99..16766f267559 100644
--- a/block/partitions/ldm.c
+++ b/block/partitions/ldm.c
@@ -830,7 +830,6 @@ static bool ldm_parse_dgr4 (const u8 *buffer, int buflen, struct vblk *vb)
 {
 	char buf[64];
 	int r_objid, r_name, r_id1, r_id2, len;
-	struct vblk_dgrp *dgrp;
 
 	BUG_ON (!buffer || !vb);
 
@@ -853,8 +852,6 @@ static bool ldm_parse_dgr4 (const u8 *buffer, int buflen, struct vblk *vb)
 	if (len != get_unaligned_be32(buffer + 0x14))
 		return false;
 
-	dgrp = &vb->vblk.dgrp;
-
 	ldm_get_vstr (buffer + 0x18 + r_objid, buf, sizeof (buf));
 	return true;
 }
-- 
2.17.1
