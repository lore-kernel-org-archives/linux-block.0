Return-Path: <SRS0=n79e=BX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF85C433E4
	for <linux-block@archiver.kernel.org>; Thu, 13 Aug 2020 08:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 056842080C
	for <linux-block@archiver.kernel.org>; Thu, 13 Aug 2020 08:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Pk9qIBp2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgHMINS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Aug 2020 04:13:18 -0400
Received: from mout.gmx.net ([212.227.15.19]:54791 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgHMINQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Aug 2020 04:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597306394;
        bh=+pg+gwfBz4Ihl3HJW9sGnGfCOT41Z+9kJFwiu/AzDnY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Pk9qIBp2EDX4aeqVXiOe1h/LvahobvDOy7+PImaMANPyDwbeL1hSTMaJCCm60GuFt
         2+IjhUqKj6/3L+VIlAxPxO1MPl7zVihAaf8BB9V+6En9zNvsYt4WMWS201uLsmXw6O
         DOFEqpe94c42T047OeLffnycV+cwdz+i4rb5WZ38=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls00508.pb.local ([62.217.45.26]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mzyya-1krkfE2dHi-00x6KF; Thu, 13
 Aug 2020 10:13:14 +0200
From:   Guoqing Jiang <guoqing.jiang@gmx.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     jinpu.wang@cloud.ionos.com, danil.kipnis@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH RFC V3 4/4] block: call blk_additional_{latency,sector} only when io_extra_stats is true
Date:   Thu, 13 Aug 2020 10:11:27 +0200
Message-Id: <20200813081127.4914-5-guoqing.jiang@gmx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200813081127.4914-1-guoqing.jiang@gmx.com>
References: <20200813081127.4914-1-guoqing.jiang@gmx.com>
X-Provags-ID: V03:K1:zMZP35KUZnbyRAn3cbxvcKkETieCsoQPgdS8+3jU1fr/gSv8WkX
 9L4DCi800etQEip1F0GB6gJe6UVKa6NGlVo/c75+EeKN22+vZUVuP0tNFPE+nhbfMQx8lMP
 xZVQ0LmDYSQIPq+8H6tv6BkTyXdgZr3frHg/gYZSwDQYh0c1IqVRUOCDndIXFqjVqjA9cjs
 NVBgTtI/Kz6536C0lTFuQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FQZ/QZweya4=:q4hLh1OyBU1dxwU03PMCI/
 Pc8l+hIoaHaQwdLpdHjhF3vvQanM+uTf6xKUmgbQzZsyiGCJ8NEdg0ihnnrYcbp0DmOPMQDN+
 PKSxGvBm6PqR1hv/UALnQVoGQMY5Ygo0z7msn6zSPiTzizYbD4VwOMAfz7iQ7pNcT3203be+E
 ycOwOm0I87c939LT8badhlWjbKRArRdpVgParrvxJQazl+Gh1NZC8dK46UgKTX6a4v7dOg1nR
 sjk2C9nD7gS1FesOlfLt4r1A70sNAq2eLGqfCgQ307h1w1WXK4raL7wefks0WV35TQiuRVQ8T
 5VO1CYZpw9j++XnXiiEKF+Honrj6U7gyltOch/XURrxvy9OgXikKJ6T0000eypP8jDYdE4w7u
 /6bInsZk/yIBiUErvuXUxlphqiqx0ldaXaiVnIT/eYbUE+87Yx32QIS2ZpVEzVVw1yuNGY4kF
 wD8u6NDvWL1hzq8yqoD89EXKWSh3XiVxy5yDgKQmG7baA8m2db0w0oTBWOv/fjuAfhqty82Vf
 eI35ObQEctye5y9F3fnLlezlZnzwFmN3QGUnOaRJ0KIAZSvFE5Z7jqTyEBlA7HPrCEFTrSUT+
 oiTVTeRQPqDv8BqfIeLEW1EkapQz4K5jwCXUvB4z8qBTKWKwpAYi7thNsdeQeY14XXUv+0g/0
 2JaF3po9dRZ5I5p6FG2+C+o6pDpxtzwdG5gVJ9SCXy1QeYk++Wdydlu+Tab2cwYm0LVzXBql4
 bPklwo/56NojFP0HID+1qxoEbnc5RM2uwgs/Cy88vb4ICuCE81kTJ/YCfEJI+CnCy0vJtoUlk
 RAgdPNzidkNuTW7TJ4Ac7ygNgW+nzhPXMZ03FSRwieK3CRTsJv1EO757BZ1hdlPOK7spKk0oy
 uRbDPDxc9EIP7e9Tq1boZSsj4NE7zLYYTEFEMaPdvcaJ8Rr0Ou5pT2EOweRlWCtb69gh+D/QX
 roEaEBK0YFUfbXQBeW7Pv1SfwcY+18J41u3i2iCOfDCmfNj/wL9MWgJkNLr06ZKrYClUU9fnG
 nGxGnZRhFTepjaj2OfWgdm5D2knEMQL8Su1jYdCVEYeDWvpjZk2sFu50b+y8NBSIC4Ehdp/tZ
 6fD1VGh/tSCFGLPvkCCpP6Ynk5PZyfg+0eHUVKOIY4pzEUh9bNYh66xd5x2hONL46RCNRhg3I
 X4/3lpN3Fh9dD1SGOUudwRJZfK/iCbbVsn9SQ+gVk9ZD9NG9kk1Rza8R69VCsqU+1HEBl8aKV
 7LZRRuuRk7buBMMr93rIziujwaaZ21AMphQ9ocQ==
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

If ADDITIONAL_DISKSTAT is enabled carelessly, then it is bad to people
who don't want the additional overhead.

Now add check before call blk_additional_{latency,sector}, which guarntee
only those who really know about the attribute can account the additional
data.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
=2D--
 block/blk-core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 1a8e508516c9..eafc2b390d99 100644
=2D-- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1462,7 +1462,8 @@ static void blk_account_io_completion(struct request=
 *req, unsigned int bytes)

 		part_stat_lock();
 		part =3D req->part;
-		blk_additional_sector(part, sgrp, bytes >> SECTOR_SHIFT);
+		if (blk_queue_extra_io_stat(req->q))
+			blk_additional_sector(part, sgrp, bytes >> SECTOR_SHIFT);
 		part_stat_add(part, sectors[sgrp], bytes >> 9);
 		part_stat_unlock();
 	}
@@ -1484,7 +1485,8 @@ void blk_account_io_done(struct request *req, u64 no=
w)
 		part =3D req->part;

 		update_io_ticks(part, jiffies, true);
-		blk_additional_latency(part, sgrp, req, 0);
+		if (blk_queue_extra_io_stat(req->q))
+			blk_additional_latency(part, sgrp, req, 0);
 		part_stat_inc(part, ios[sgrp]);
 		part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
 		part_stat_unlock();
@@ -1516,7 +1518,8 @@ unsigned long disk_start_io_acct(struct gendisk *dis=
k, unsigned int sectors,
 	update_io_ticks(part, now, false);
 	part_stat_inc(part, ios[sgrp]);
 	part_stat_add(part, sectors[sgrp], sectors);
-	blk_additional_sector(part, sgrp, sectors);
+	if (blk_queue_extra_io_stat(disk->queue))
+		blk_additional_sector(part, sgrp, sectors);
 	part_stat_local_inc(part, in_flight[op_is_write(op)]);
 	part_stat_unlock();

@@ -1534,7 +1537,8 @@ void disk_end_io_acct(struct gendisk *disk, unsigned=
 int op,

 	part_stat_lock();
 	update_io_ticks(part, now, true);
-	blk_additional_latency(part, sgrp, NULL, start_time);
+	if (blk_queue_extra_io_stat(disk->queue))
+		blk_additional_latency(part, sgrp, NULL, start_time);
 	part_stat_add(part, nsecs[sgrp], jiffies_to_nsecs(duration));
 	part_stat_local_dec(part, in_flight[op_is_write(op)]);
 	part_stat_unlock();
=2D-
2.17.1

