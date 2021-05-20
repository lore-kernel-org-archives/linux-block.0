Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5C4C433ED
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 04:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C14CA611AE
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 04:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhETEXy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 00:23:54 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63405 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhETEXy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 00:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621484553; x=1653020553;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=IuQdErNrCgq4pGDKQDnDOnNbcTOBLuJiLkqhDgmcHEI=;
  b=k6soq7labINe13FwXJzxDxCPDv2e7uJcZ3JWnJ/SU7eqwIGGhfjTQLUv
   EfWPgW2bi3tUFbEU3VFdJvqFK6bDLXaxCfQ5oPMNTJG7La94IAF7TgQq0
   SnMdA6wNUU+6rsCrxYg75/mRO0KU8C3Oksj1reGFbqym7GsBUlIxpw0pW
   IAG0wm2hyd2caLux/A4EagSRIQ0GldU82hcy8xa0fyD7vOriBwIVjO6HF
   JCIEG4RYbNSfJs41uAQCZnlbRMo+N2fAlzQhY3uRFztRfrlpRM9TeBrAf
   tHOd5rAOWnzIoJy6wQ4WlWPlrlItMEKSuW1bKxG7n5AhbC3d1ESoF8Ljh
   g==;
IronPort-SDR: xgo///tvFaiDJLKx+K1svpB189S04rDEMsW8HWDmAxfjTcakD3W0SvCwH739lJ3oh190KMzg4R
 LvAjJRsoHpTmT0vQMWEuuQeb5CQhrLdXCi6EYKWk+oAgzTivEvhtei2yTizSZ270GL5GKcTLI3
 IDevjETnqnSB8/M63WJLtPG5zuqX7uTHLgiE0uVNZ+G6LV9Jg6WOSL4EwM8cD4edURs1Bf2AWs
 EOds1RmeklzzbxQyuW/ZkMC9HfGsP0roOGdVlAz9WPhFrMf8Q/8EWrekBoKV8Fd2RRW/TkMKir
 RGc=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="168105838"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2021 12:22:33 +0800
IronPort-SDR: mLKILvbbAiwu7XvXlKMiFw69f7l93nlj/4Vj1lUMWDh6EwdyvuKpjueKws3P+Ac02yZkBifUl+
 jrAG2lXIGsjY5jimUoOkfAZftCEhxdm4miAOhRnZ6V64HLmONfSCK7o9x2Ym8hf1MwHPz8cKwK
 ndDqAm/5LDtN9jGScr1UFZZ86RK0UCiHVngjsRsx6gijjVKCYbB45fGVgn+nn1YjFTEhR0E6Wq
 TEGknwJWy8R0BtRsKn7BnkWmfLRJgRLEAzjxOH1qnM3GdmgQSrfJm/quE7vPB/J9s5G1Jd1EYv
 fKn9pkApXKvmXwVnLFlknSQX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 21:02:10 -0700
IronPort-SDR: CAw9+Fo4qDxasNQN/GopsJamFgI79cMYrsl9EI8NqsZOkQIFLVSxw1Q0Lp3x2zQmy0lNX4pAQf
 CMHbnNDHBmRvTOhtXDapU30f3hBZ7ZTtBtY2JcDwc7TnRQcaakwVAIqMhXiJ0lSfRhkdBNUjYG
 M1j6HdMWWHZImOKE+m6Rr9GX8LM58CM8WveF466Sr6z4hdal4gyGZI/v34ldLN8HiECxj3XS62
 C6pUWSCHUo2Xj3cA01K/OVEHvq8HqY1VVZ1kfaMofsowqbTfZmR3GXYE+TNvBgz0QhbG70nAKV
 q4g=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 May 2021 21:22:32 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 03/11] block: introduce BIO_ZONE_WRITE_LOCKED bio flag
Date:   Thu, 20 May 2021 13:22:20 +0900
Message-Id: <20210520042228.974083-4-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520042228.974083-1-damien.lemoal@wdc.com>
References: <20210520042228.974083-1-damien.lemoal@wdc.com>
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

