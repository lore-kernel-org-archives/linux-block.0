Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35736 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751877AbdHVRdS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Aug 2017 13:33:18 -0400
Received: by mail-pg0-f44.google.com with SMTP id u191so43290431pgc.2
        for <linux-block@vger.kernel.org>; Tue, 22 Aug 2017 10:33:18 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Hannes Reinecke <hare@suse.de>,
        Ming Lei <ming.lei@redhat.com>, Karel Zak <kzak@redhat.com>,
        Milan Broz <gmazyland@gmail.com>
Subject: [PATCH v3 4/4] loop: always return block size in LOOP_GET_STATUS
Date: Tue, 22 Aug 2017 10:33:01 -0700
Message-Id: <778264213d9a05c70fc99e067eab2105230aa95e.1503422996.git.osandov@fb.com>
In-Reply-To: <cover.1503422996.git.osandov@fb.com>
References: <cover.1503422996.git.osandov@fb.com>
In-Reply-To: <cover.1503422996.git.osandov@fb.com>
References: <cover.1503422996.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

When I was writing a test for the new loop device block size
functionality, I noticed a couple of issues with how LOOP_GET_STATUS
handles the block size:

- lo_init[0] is never filled in with the logical block size we
  previously set
- lo_flags returned from LOOP_GET_STATUS will have LO_FLAGS_BLOCKSIZE
  set if we previously called LOOP_SET_STATUS with LO_FLAGS_BLOCKSIZE
  set, which doesn't really mean anything

Instead, for LOOP_GET_STATUS, let's always fill in lo_init[0] and set
the LO_FLAGS_BLOCKSIZE flag to indicate we support it.

Tested-by: Milan Broz <gmazyland@gmail.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 drivers/block/loop.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 28026f0abaa9..b55a1f82f561 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1222,7 +1222,7 @@ loop_get_status(struct loop_device *lo, struct loop_info64 *info)
 	info->lo_rdevice = huge_encode_dev(lo->lo_device ? stat.rdev : stat.dev);
 	info->lo_offset = lo->lo_offset;
 	info->lo_sizelimit = lo->lo_sizelimit;
-	info->lo_flags = lo->lo_flags;
+	info->lo_flags = lo->lo_flags | LO_FLAGS_BLOCKSIZE;
 	memcpy(info->lo_file_name, lo->lo_file_name, LO_NAME_SIZE);
 	memcpy(info->lo_crypt_name, lo->lo_crypt_name, LO_NAME_SIZE);
 	info->lo_encrypt_type =
@@ -1232,6 +1232,7 @@ loop_get_status(struct loop_device *lo, struct loop_info64 *info)
 		memcpy(info->lo_encrypt_key, lo->lo_encrypt_key,
 		       lo->lo_encrypt_key_size);
 	}
+	LO_INFO_BLOCKSIZE(info) = queue_logical_block_size(lo->lo_queue);
 	return 0;
 }
 
-- 
2.14.1
