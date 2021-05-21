Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A70C43460
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 03:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 865706128A
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 03:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbhEUDCs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 23:02:48 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:25389 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbhEUDCr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 23:02:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621566085; x=1653102085;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=rWxjqEF/31OQ9k25vywpYFOLdpWY41q2iRDiStGTtjU=;
  b=Pk578Ko+TUj2TP8oSWUI0HCsoUbgDJb1QvlFRGVjqIsOH9Rz8dB6IAz5
   iSslVwgJ/qDSdlGwDTmzLu2BobNBJlxfI92IWkUCwi4RG1ohF9c9xq6GQ
   p7/F1rYnfPP4PoLlsZiXXfWw301AXHNvFhJmfJbsX3kW9yTrGFb3aRzDK
   PQbTOo0J6CRr0AUrliGPGMIN6jY5dC3peM4npQHUz+L3tjVKNhmVqvClz
   IaXDEU0osWf+1kfdGCP2f4cAZX8kAaw1peximWdG/MIsFfQBJAm2l7eKm
   yrkgGvfJwDwz96eDOFRFz9Adw7Cd4YJBnbWvSjoiacnSqnd70IEoNTO+F
   Q==;
IronPort-SDR: cM9HXBAku8ZRK658Gmy7OCHSLWcwawxIXSjgF6IJaG8L1gLJr5934tbZt4d8u9FEvgldFPAQ71
 4p9UymV+0HpT0zJPTKwlt0FtVz0u2RQydkwEQcKDE4UZAa0y+OKYBV9ACExQoPR9TGaZFkDaaG
 oiUxwqv4MFoF9ez6WBus2klgC+OSp5FTpN7MtXyku4FgskG5g/qZRdzIWexqJKQgX5FwtuCH/l
 65t0l9uuSmM0gGD6AmjS5VvPlI6Jx30hIuUq4udIfhFTanIxEyuHeMctAJxaaaYQ3+jwLTxPqn
 IYU=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="168943815"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2021 11:01:25 +0800
IronPort-SDR: vAVnWW6/6GQqHNFGJcKU7s1Z4BQ/+cGeTN3BeX8sE5S3g1lEcSebyASlRDIBMdyOWG7vi7LTnx
 ge8oWSz4cH09CzFq/ZqbaS8QOsa4QhyWFcJqr/k8SzkEOM1i8GN6bzKxZuFB/ZRTCI7ssXIaLy
 SV49nQ2+mcp3eWq6KtOWwkNrkW4SsSjfdsDpD3lwhFthLlSw86mtAwbkANGodKN63m4d2bm97q
 otRoWvvm7ueYt2L6BIlzjwy1s/Ag8JnGvrWRfOtih0Gb1PRo5R15E67B4l9WesHy6noaKQZMUh
 Ht4c9kAAawgTqLWZsfWwVhNB
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 19:41:01 -0700
IronPort-SDR: lAeiAp2b2gKV5TvRtg7Y01nKMN1o+nLd9OPWRivCMfl0DYPczAwXLajZ/jH7mBhVJbmqj9wkPI
 uj7RC1OY/oGqX8O/TtxTRpLNsQIYXTazwJbj/0Hf/qxzYtaEOHjOcDleSypSecySFst/QaWyJZ
 AbwwnpdJepMU7ynqzJ4dHI1oJtHqor8WHfh1IiAYfYTztuk9jQkNBKo/1clea0dahCnuVSz6yd
 2HLMC2lcN8ZnbwXC6t8zEvhLE0FwzIn0iuVzZRTRiJ3gc6BjKLVofR6uIIw9jHtaaWpgzqjmiZ
 2V4=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 May 2021 20:01:25 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 03/11] block: introduce BIO_ZONE_WRITE_LOCKED bio flag
Date:   Fri, 21 May 2021 12:01:11 +0900
Message-Id: <20210521030119.1209035-4-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210521030119.1209035-1-damien.lemoal@wdc.com>
References: <20210521030119.1209035-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce the BIO flag BIO_ZONE_WRITE_LOCKED to indicate that a BIO owns
the write lock of the zone it is targeting. This is the counterpart of
the struct request flag RQF_ZONE_WRITE_LOCKED.

This new BIO flag is reserved for now for zone write locking control
for device mapper targets exposing a zoned block device. Since in this
case, the lock flag must not be propagated to the struct request that
will be used to process the BIO, a BIO private flag is used rather than
changing the RQF_ZONE_WRITE_LOCKED request flag into a common REQ_XXX
flag that could be used for both BIO and request. This avoids conflicts
down the stack with the block IO scheduler zone write locking
(in mq-deadline).

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 include/linux/blk_types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index db026b6ec15a..e5cf12f102a2 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -304,6 +304,7 @@ enum {
 	BIO_CGROUP_ACCT,	/* has been accounted to a cgroup */
 	BIO_TRACKED,		/* set if bio goes through the rq_qos path */
 	BIO_REMAPPED,
+	BIO_ZONE_WRITE_LOCKED,	/* Owns a zoned device zone write lock */
 	BIO_FLAG_LAST
 };
 
-- 
2.31.1

