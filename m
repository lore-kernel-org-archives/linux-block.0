Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45157C4707F
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 21:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FBEB61417
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 21:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhEYV0i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 May 2021 17:26:38 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:36430 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbhEYV0i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 17:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621977908; x=1653513908;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=6kRIuS/fUul5WvYm1RwOlXRDAyrR8fnPc2uP9r0LZSo=;
  b=OtMngLOAhXuzazCr/J0DDOA8RX2s4kNKmAHMSNisn++i95U1ebItJF3z
   lGyAvqLhIH4SqKXTCtV7AjbguXiMgI1yt4Ele8qNWVhqXS1iJQMppc1Ct
   hueZBAF+4H0DfQ003nQEkQT4aRJhxpcCUAGdbwsXpmxZYX+1jG1YFJOTr
   cxsaAc2t31yZuIl21jnIWjgBgCEReotGK9qOZxOG5Qo08nSLQ0/JvwZ/o
   jj3MmLamuN4RsqqJsbL6rk+zw8215jxWv1myB9K6VhA93hifcEwSTyIeJ
   RGMF+G95Bi9eOd4X4cqEQTQIrjHI6L6vA4cCt5bwlctXFWvQ6NtI/MAHu
   w==;
IronPort-SDR: oVknKXiiR96A0FRWVp7vF6d/vRhk7VUjOZtJ08CWUwwW0RHdyatrLaH2xKViqwApI6naEJdCnz
 8JbUsTz23T70dFiX1AC2EDpzdj1spuq/7X5cqWN3lsXYV4y1cEfTu3vvt2lX+yqm1iYSIcaKF/
 jEBqL0JprInrF5SfC+k20i1tXfGQc+EA2QqEAlItdzJdNnoTAyQkKLCgJkJPvX3sCuSTm1tqz3
 x6qPEcBbOazgMNc0gYu3kT1chNNNkasUaM/ZLqc09BosGB4O96E6I77f+4yzSX64volLlKyE74
 dDA=
X-IronPort-AV: E=Sophos;i="5.82,329,1613404800"; 
   d="scan'208";a="168717517"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2021 05:25:07 +0800
IronPort-SDR: mqnDTol9pcB/H5Kxjt659KtIUT9r3hdXiWD77/wfHBOKYwpOhOIhFuuht5YQpgthYLHfc0jEQi
 yfmzi5lN/YLeWsVbFfM9DesbunfrA3HS3Zxx7CkLwmigDJ9fi/0ylHvgzrJY/t5dNM+LXE/mW/
 9RTp6ZqR0qshM1AXUQuYwbJuXSxiaBnbGVWGScgBRFW6QtOrAWukCcLMc/WNzqsaUCxZgruwML
 +IjkZPlmYzr6URM8Wmz1XXgKQ9qdZ5GKyczBBmUPG+siQR3iqPcRjKgH+6CXzFfEpT6VTjS0g8
 xm1wgo1WLP6H7UFS9UMQztAK
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 14:04:35 -0700
IronPort-SDR: cs03JQLS7hcWIucz1TPDpUrFjTrNuBxSxEa0ivmhTBQZlYUdzzUf0LsQmP1wn5ZwLyox9oAJul
 7A/Ft9j4Kbu5eFHderB/Nkfvjd2fU4N7j/SQXDU8THQ9+g4NBCJexgQ7U1WEVwM0Oz6w1qV5L0
 d/I0x1HE9tizeAKl7iRnrWJVPwi4HhsvP5qSLwoRZmrXJtmhohds7u930lzts9qBPl36SD0ycV
 RzLbC4oSSOxtpzuJRcKK7Q9sweMu8KAwG6MEkk1Y/VtPPq8oasAyDEUuH/erj6S+a/a8RWs9Ev
 JgQ=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 May 2021 14:25:07 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v5 03/11] block: introduce BIO_ZONE_WRITE_LOCKED bio flag
Date:   Wed, 26 May 2021 06:24:53 +0900
Message-Id: <20210525212501.226888-4-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210525212501.226888-1-damien.lemoal@wdc.com>
References: <20210525212501.226888-1-damien.lemoal@wdc.com>
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
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
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

