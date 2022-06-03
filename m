Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F7DC43334
	for <linux-block@archiver.kernel.org>; Fri,  3 Jun 2022 02:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbiFCCTK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jun 2022 22:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiFCCTK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jun 2022 22:19:10 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D38C193E7
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 19:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654222748; x=1685758748;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QPOoq/55hfROcbQr6JrcSvVlM/CD+CrNgHW0khnwMaY=;
  b=OmApV2eyXnc4KJJT1CLdW9Vssc1cW6nCbOdCTxQV8eS+mnteibioYEZT
   dD6kj0GngeB26Ve/lPEnd4Zy2e+5XE8SAlpZiNLcGgl1HY3a6dW2WGr8i
   m97IOgGt88HO1t0L+0b/0nIPXEB7SQpnySjm3xgZfMo9Mwsyh5j19qR4f
   r6PY1ykUiq00PkQqMjanTqhWCYrcZ4MF/JF7BKO06gVTTSUF0mvs7kdnC
   n0j6RT0vFUIi2isDZTClbHVOFbwCXpPxMqB2CMypa4g9mrY2l/nuvOrn6
   m0BlvwS6uibvKzW8LPoADjEa5WcnHn3JJYH1oZ6ce8KCvJ6C43ccpbgqF
   A==;
X-IronPort-AV: E=Sophos;i="5.91,273,1647273600"; 
   d="scan'208";a="202159821"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jun 2022 10:19:08 +0800
IronPort-SDR: MpuItvxOGcYiSRVcUpCAr0tGclYqdkaNt7FjxkQWkh+93pt0RRr/GjHCjfkMcE/Oa1m395Vpqg
 3xh5z/ttK/I6NbNjkyZtxwrMr+mr7PJVmVDP2uLdAt/mi2sj6Z7jkG/Uapv55lh8f+3xhTtUFD
 kpDvNqH2DWrmL+wjpaWnFfmjTu688LYtWI62kCngkLCi80RCacZ3ePB+WF78UViieA52YNhE0l
 usAhxxEtyTlfI14jpXXAJM++1Hg9DIlGJYbJuhLvD/FgXr9nipaOYhpnYwDKcxHwwGw4gwywiD
 VGKfu6eo8l856e4qa7EUOD8y
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jun 2022 18:38:17 -0700
IronPort-SDR: CArx8DYE0Qaw4NBlG5Bv81cEUfQwWjUQPVy5WOw2znvZErpXwxLUkPiZN3mnOLvgSYqAeF5AWH
 1QrlrcTZBaNQFdQdfjkp6d4KU1ST9ez6Ehg6C8qDhWZNMDXmIIjHfd2byRWe2B82UvxkcHO6dd
 3iEUwyJKWeaPk1ZdPzyB/2mhqiVUESbDbWxB/Zn6bTpMNgPuszgc9K4ypvrIcljCTjkt6ulBrU
 LafwfNHJaZia7FqMsC/OYNU9b4GE+f/5ylmMwg0eSaItPBqS7rJPObeZSdYDjuSJKXnxVWsrMS
 Qok=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jun 2022 19:19:08 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LDmlw2JRYz1Rwrw
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 19:19:08 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1654222747;
         x=1656814748; bh=QPOoq/55hfROcbQr6JrcSvVlM/CD+CrNgHW0khnwMaY=; b=
        lkiSUUoXnd/NLucRN77voQSV1IFzXnhf4ybuF3q8b4CVpT0ztmphWCO1FFd6x4d8
        zg2I4yLJfeaDl7j6bh/KsE8ytzCbO/jPb+EMH/GXO7m+P7XKKghYpuqNfGb1w4bQ
        juHd9OIFcOyIfrlprF1FubrX6eQCyldLIPdtrj8WEUBrDmldRM9tYzsi7akCqxk4
        mVI8C0Aw4QK3ngleE27qsx6pbp1wjF90X8DqCt55dB24YQGVOTumR+VJAjUloV2A
        +U1FUtKOh63IyJ/IQw9noq1Q3EWvbEk0AOqaExStufg7dJfaQbG0UWtiR7WzonZ0
        FvcIjwq5/OR/TUhg+YD5Jg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cRoak93JUr8Y for <linux-block@vger.kernel.org>;
        Thu,  2 Jun 2022 19:19:07 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LDmlt5f6jz1Rvlc;
        Thu,  2 Jun 2022 19:19:06 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Tyler Erickson <tyler.erickson@seagate.com>,
        Muhammad Ahmad <muhammad.ahmad@seagate.com>
Subject: [PATCH] block: Fix potential deadlock in blk_ia_range_sysfs_show()
Date:   Fri,  3 Jun 2022 11:19:05 +0900
Message-Id: <20220603021905.1441419-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When being read, a sysfs attribute is already protected against removal
with the kobject node active reference counter. As a result, in
blk_ia_range_sysfs_show(), there is no need to take the queue sysfs
lock when reading the value of a range attribute. Using the queue sysfs
lock in this function creates a potential deadlock situation with the
disk removal, something that a lockdep signals with a splat when the
device is removed:

[  760.703551]  Possible unsafe locking scenario:
[  760.703551]
[  760.703554]        CPU0                    CPU1
[  760.703556]        ----                    ----
[  760.703558]   lock(&q->sysfs_lock);
[  760.703565]                                lock(kn->active#385);
[  760.703573]                                lock(&q->sysfs_lock);
[  760.703579]   lock(kn->active#385);
[  760.703587]
[  760.703587]  *** DEADLOCK ***

Solve this by removing the mutex_lock()/mutex_unlock() calls from
blk_ia_range_sysfs_show().

Fixes: a2247f19ee1c ("block: Add independent access ranges support")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 block/blk-ia-ranges.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/block/blk-ia-ranges.c b/block/blk-ia-ranges.c
index 18c68d8b9138..56ed48d2954e 100644
--- a/block/blk-ia-ranges.c
+++ b/block/blk-ia-ranges.c
@@ -54,13 +54,8 @@ static ssize_t blk_ia_range_sysfs_show(struct kobject =
*kobj,
 		container_of(attr, struct blk_ia_range_sysfs_entry, attr);
 	struct blk_independent_access_range *iar =3D
 		container_of(kobj, struct blk_independent_access_range, kobj);
-	ssize_t ret;
=20
-	mutex_lock(&iar->queue->sysfs_lock);
-	ret =3D entry->show(iar, buf);
-	mutex_unlock(&iar->queue->sysfs_lock);
-
-	return ret;
+	return entry->show(iar, buf);
 }
=20
 static const struct sysfs_ops blk_ia_range_sysfs_ops =3D {
--=20
2.36.1

