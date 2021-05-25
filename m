Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721D6C47084
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 02:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40C0A61420
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 02:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbhEYC1N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 May 2021 22:27:13 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:34067 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbhEYC1M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 May 2021 22:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621909543; x=1653445543;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=ygm/i9xkzin6kgnlm8TOboixA2GWMnuVg11Jbf7Pvzc=;
  b=RwP11JqCyG6OojsnBsdd5ykyok7nSPPU8uaiJ39Staq18JDm4TASG9tn
   9oeE4EkkTfF9/mMlLY4z2RvuomIOnOsHHZ9C8AJnL40TShGM0eS5N8Wv1
   b8u2ro86Ulk+xHxm47u7IbrF+fw5/sUfJXvLvXCC3ZGiPlSdkBh7vt4SJ
   AiQT06Sj+lRl92X1Od5wwKJBLuBFQbafoB8tESFchXjb0T7DxH0X612hr
   j+u3B+lXhkN5oe//R/EPmG4ZRuirB4HhvAQdTMSd70S4ouztD9VTe6BJN
   YJap+suFHn7e2Kq7loYix4kl7w92JyfXa27QWAyMvlG2v+6qvrWoIyP0V
   w==;
IronPort-SDR: jKG8M4DEoRxw37UXVExGTxYtflPfJjQnAW5v+T8Fccw+uTXCQ4GKL+b3ERWUiFvsCSCPLoe6MT
 7SWp1SwOTWhiYTTz3cy6zqinsSnfSDLU+yFpoFygbhrRI6y5BKSOS8vDmC3ykGTBk9opT2shMi
 wCs+APPmsceNGvuaLOOIjXjA5RsWggC5U2IRKTmdM1w2dgI6ivU0BuYKIDwkYhqOc7+IS0OuhC
 nOtnwjF+sk+7t5CLHsCJF4gvQQwELr0dDNwVNm3RH7xPob/WgY1uwyZwWaHECLMOFf7QEHZLID
 dNQ=
X-IronPort-AV: E=Sophos;i="5.82,327,1613404800"; 
   d="scan'208";a="173981324"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2021 10:25:43 +0800
IronPort-SDR: +67JHhwmT2NWcjy0BzgoC2r95iCbZrCKGfMSKl8hOyKG77rhL/ah9dCZqDI5k1O9HW/tP9YTEw
 uY6ON+1c6hPE9shqeiCU4JHwMO5OM/rhCjxo5SenQi66aRrmUqqmy+PuUPzGWXsB+DAfa7T0Ed
 3PC3o4ZAY4sRdKYimNlKeSfxWtDH4SesoC4qIAzzeqtpXhmQ3kKcVD9usihgqNCcJOCTMN8vpJ
 KsbALlsgLiSq/8gMc5W+5EOKSt+hc6U0BUPsJjMpc0zyOYJTYOOV9+mL+DmzKxHDr5ZAOkymx4
 ZVl1dyV4fv7a/RR9rY1jfqQX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 19:03:58 -0700
IronPort-SDR: vKZCpJiDMYS2oJJbpIiyHtZCQWcB1ETJ2IpBF7qPbf8ODehVsQoPNM/4cAc9DdnRwu0MP9S7Yo
 zC4IV1Wwt9BVArLNehcCN8nL5Ufhics3Vl8atwMjF2AiypoO3+ZeA2DHoEpC30o4JHkUvELtJn
 i6tkvfjghv4AFvMo8Eu0dVZZn507xr3BlfKByP4ZjjX+XibxK1Nq/RhvgdmqiELDUhYmXV1mhO
 ghb/7j6b7SIL3Uia/VBF1D5gsodfUexHjRNCDsqFgNpHCKqmO3xUiF8zcOYFoUCV7VkO0+zcDc
 rhA=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 May 2021 19:25:43 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 03/11] block: introduce BIO_ZONE_WRITE_LOCKED bio flag
Date:   Tue, 25 May 2021 11:25:31 +0900
Message-Id: <20210525022539.119661-4-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210525022539.119661-1-damien.lemoal@wdc.com>
References: <20210525022539.119661-1-damien.lemoal@wdc.com>
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
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
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

