Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA478C433ED
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 02:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA5A2611BF
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 02:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237567AbhESC5C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 May 2021 22:57:02 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:5175 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237441AbhESC5C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 May 2021 22:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621392943; x=1652928943;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=lIgUcOusoJNjMDu8KPcVMKOA5N7HcVpHKeH6lBsQiik=;
  b=fWb9L0tGzo/WTSfsNwTRqWkqtWhhrVim4nrw7NpBOwNZKmYykJNZRB1d
   bldFaELrI69SI5oPHasIXq7jSZmlfLUa6BHhj4ilUi8G9swz32tNXNzcn
   Toqhi1BWi8FXydPYvk/BGvaFa/AYh3qCyGIvs97yxzpsq3IbHc/hMvYGR
   EN5deLGX3LqVRBUoz2KwygQfM7C/ArfYMfpgaNwaPOag/HvS2gMGKVK96
   V0gT+Q+8GsT9mbGijBNN0NnzJkFWGsFqViGkQ/X8apKcKkKC4yxQBXnkY
   6ZpGDdLh3TGcvzNYTsA7PFjzACuxk8rJORmLOUWpTC44KgA9X/RlgJbrk
   g==;
IronPort-SDR: P9pzfYc6qtV4joF22oYPuLOidA1G5ch1bbJvjIN/dm3UzCnUOSStrj/v+GwtmYSbxJzJa99Vx7
 G83etPUZRvqKCzvwC+ewnXQ51XLjs2kBNvANP+oIwzD8fyZ89I8sxlmcHm9HX/y9RuoCGfUAe6
 aGViTotYxtHwYnltqqrWblqBH9STMFbH7NYQD51wkeY8AVeZpWNFg7vrTQNtVjZHF5BThz/VFc
 RXy68kan3OqgouyeZ99lXdyt6lXMLTeGigSLXocTPg8N0qYgGRxpqzW47E9jrhAHmzVhd0vnIO
 o1g=
X-IronPort-AV: E=Sophos;i="5.82,311,1613404800"; 
   d="scan'208";a="173265913"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2021 10:55:43 +0800
IronPort-SDR: tbYcbzyvoA0HxGg7xQ/lebnt5/JapSvWYHufEvV9xz06pByHp99hmMhkw0KsobXO8wg7uXszFZ
 QXDZjKGBoRWa5qNiL7qnzGsO4wd6Ap1yTPdjDclna8MY1+AD0xViPrii4gQr7ZNA+Xa3YKSf2C
 w1KMW/oL4C76dl18Gq4kirZBESSlzsxDYc7KIKER/RDMomLLksbU+BqkwmBY/Dn7UTDd2ZTl85
 vmLTZqk416yuguEyCeLMKjXgWa1e68q4YhJL44EtHBIYsIeAgawYUFxsRc15zQAlUU4bqU5qXN
 cJ72Fzi1VyW043sD6XMRVIGi
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 19:35:22 -0700
IronPort-SDR: 6A8IdEnTL5S95ycxdlnSTWMMDa1i+XG5rlrA0x2Me19yJDH1rC8v/SYmy4PXFyVUtX5nY7Gbq5
 /UAZX7oR7MAcT9AJnThInzxfux3sJMTQ5XDbPPv/bQfUjkNdWH7sKV0DW6N5MoazIGXyapTa+L
 TSi/qgfKNJsUXXJVAJF0cQOGw+k6M0hCixREgHUupwDVcB5z85cIMeLA8EUHfCuh3BCTFcCYr/
 XCdiLuLPHCDN6DcnaY4sNuEjNkPnG2MTM4lgcnbFQBwRNhLf+IQl572ELvhOBnGN/GmmjDt3xv
 FeI=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 May 2021 19:55:42 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 11/11] dm crypt: Fix zoned block device support
Date:   Wed, 19 May 2021 11:55:29 +0900
Message-Id: <20210519025529.707897-12-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519025529.707897-1-damien.lemoal@wdc.com>
References: <20210519025529.707897-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Zone append BIOs (REQ_OP_ZONE_APPEND) always specify the start sector
of the zone to be written instead of the actual sector location to
write. The write location is determined by the device and returned to
the host upon completion of the operation. This interface, while simple
and efficient for writing into sequential zones of a zoned block
device, is incompatible with the use of sector values to calculate a
cypher block IV. All data written in a zone end up using the same IV
values corresponding to the first sectors of the zone, but read
operation will specify any sector within the zone resulting in an IV
mismatch between encryption and decryption.

To solve this problem, report to DM core that zone append operations are
not supported. This result in the zone append operations being emulated
using regular write operations.

Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/md/dm-crypt.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index f410ceee51d7..44339823371c 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -3280,14 +3280,28 @@ static int crypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	}
 	cc->start = tmpll;
 
-	/*
-	 * For zoned block devices, we need to preserve the issuer write
-	 * ordering. To do so, disable write workqueues and force inline
-	 * encryption completion.
-	 */
 	if (bdev_is_zoned(cc->dev->bdev)) {
+		/*
+		 * For zoned block devices, we need to preserve the issuer write
+		 * ordering. To do so, disable write workqueues and force inline
+		 * encryption completion.
+		 */
 		set_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags);
 		set_bit(DM_CRYPT_WRITE_INLINE, &cc->flags);
+
+		/*
+		 * All zone append writes to a zone of a zoned block device will
+		 * have the same BIO sector, the start of the zone. When the
+		 * cypher IV mode uses sector values, all data targeting a
+		 * zone will be encrypted using the first sector numbers of the
+		 * zone. This will not result in write errors but will
+		 * cause most reads to fail as reads will use the sector values
+		 * for the actual data locations, resulting in IV mismatch.
+		 * To avoid this problem, ask DM core to emulate zone append
+		 * operations with regular writes.
+		 */
+		DMWARN("Zone append operations will be emulated");
+		ti->emulate_zone_append = true;
 	}
 
 	if (crypt_integrity_aead(cc) || cc->integrity_iv_size) {
-- 
2.31.1

