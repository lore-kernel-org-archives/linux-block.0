Return-Path: <SRS0=ObBg=6G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0EAC55189
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 13:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C59D20706
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 13:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgDVNDU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Apr 2020 09:03:20 -0400
Received: from mga01.intel.com ([192.55.52.88]:18799 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbgDVNDU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 09:03:20 -0400
IronPort-SDR: +qMZtMTJkR2hOGLgf+CcLCV/vokRVERX3r4lp44VGxF8rfXVI5xL0j4OdMKoH8Fi4TE2Dp3n9L
 dcSQc/vbHT3g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 06:03:20 -0700
IronPort-SDR: p23+6rBA3QDR5/MsAuw5wRg/51MtFoQOG1G3J3+YqZbElGpAjAK0kc3TTcxuwxOheK2NIV1Tqy
 wdD6YefPabcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,414,1580803200"; 
   d="scan'208";a="290827168"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 22 Apr 2020 06:03:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0ECB558F; Wed, 22 Apr 2020 16:03:17 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Richard Russon (FlatCap)" <ldm@flatcap.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] partitions/ldm: Replace uuid_copy() with import_uuid() where it makes sense
Date:   Wed, 22 Apr 2020 16:03:17 +0300
Message-Id: <20200422130317.38683-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is a specific API to treat raw data as UUID, i.e. import_uuid().
Use it instead of uuid_copy() with explicit casting.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 block/partitions/ldm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/ldm.c b/block/partitions/ldm.c
index 6fdfcb40c537b..d333786b5c7eb 100644
--- a/block/partitions/ldm.c
+++ b/block/partitions/ldm.c
@@ -910,7 +910,7 @@ static bool ldm_parse_dsk4 (const u8 *buffer, int buflen, struct vblk *vb)
 		return false;
 
 	disk = &vb->vblk.disk;
-	uuid_copy(&disk->disk_id, (uuid_t *)(buffer + 0x18 + r_name));
+	import_uuid(&disk->disk_id, buffer + 0x18 + r_name);
 	return true;
 }
 
-- 
2.26.1

