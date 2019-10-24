Return-Path: <SRS0=pYcy=YR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA11CCA9EAF
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 17:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0AE5205C9
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 17:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732485AbfJXRbB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Oct 2019 13:31:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:47282 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729458AbfJXRbB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Oct 2019 13:31:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 59819B0DA;
        Thu, 24 Oct 2019 17:30:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2C231DA733; Thu, 24 Oct 2019 19:31:11 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-block@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] block: reorder bio::__bi_remaining for better packing
Date:   Thu, 24 Oct 2019 19:31:10 +0200
Message-Id: <dacdf91e8d1af60ce5675a87615bdf271e9a3e17.1571938064.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Simple reordering of __bi_remaining can reduce bio size by 8 bytes that
are now wasted on padding (measured on x86_64):

struct bio {
        struct bio *               bi_next;              /*     0     8 */
        struct gendisk *           bi_disk;              /*     8     8 */
        unsigned int               bi_opf;               /*    16     4 */
        short unsigned int         bi_flags;             /*    20     2 */
        short unsigned int         bi_ioprio;            /*    22     2 */
        short unsigned int         bi_write_hint;        /*    24     2 */
        blk_status_t               bi_status;            /*    26     1 */
        u8                         bi_partno;            /*    27     1 */

        /* XXX 4 bytes hole, try to pack */

        struct bvec_iter   bi_iter;                      /*    32    24 */

        /* XXX last struct has 4 bytes of padding */

        atomic_t                   __bi_remaining;       /*    56     4 */

        /* XXX 4 bytes hole, try to pack */
[...]
        /* size: 104, cachelines: 2, members: 19 */
        /* sum members: 96, holes: 2, sum holes: 8 */
        /* paddings: 1, sum paddings: 4 */
        /* last cacheline: 40 bytes */
};

Now becomes:

struct bio {
        struct bio *               bi_next;              /*     0     8 */
        struct gendisk *           bi_disk;              /*     8     8 */
        unsigned int               bi_opf;               /*    16     4 */
        short unsigned int         bi_flags;             /*    20     2 */
        short unsigned int         bi_ioprio;            /*    22     2 */
        short unsigned int         bi_write_hint;        /*    24     2 */
        blk_status_t               bi_status;            /*    26     1 */
        u8                         bi_partno;            /*    27     1 */
        atomic_t                   __bi_remaining;       /*    28     4 */
        struct bvec_iter   bi_iter;                      /*    32    24 */

        /* XXX last struct has 4 bytes of padding */
[...]
        /* size: 96, cachelines: 2, members: 19 */
        /* paddings: 1, sum paddings: 4 */
        /* last cacheline: 32 bytes */
};

Signed-off-by: David Sterba <dsterba@suse.com>
---
 include/linux/blk_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index d688b96d1d63..1e7eeec16458 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -153,10 +153,10 @@ struct bio {
 	unsigned short		bi_write_hint;
 	blk_status_t		bi_status;
 	u8			bi_partno;
+	atomic_t		__bi_remaining;
 
 	struct bvec_iter	bi_iter;
 
-	atomic_t		__bi_remaining;
 	bio_end_io_t		*bi_end_io;
 
 	void			*bi_private;
-- 
2.23.0

