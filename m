Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5093BC678D7
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 13:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjAJNPb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Jan 2023 08:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238284AbjAJNPQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2023 08:15:16 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5588643A1C
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 05:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673356515; x=1704892515;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R2Z83dzCeZHKddXeuTUmcn0ovi37DfKGzvD49wy2LNI=;
  b=ITg/H93O9mcCtMnsWldkId76iEph51XoDUrsVgYHj0Dn7d9jWzhZ2xkG
   hn83e+lmopeLP1bHdSEpVhay5NDuUpAypz+zePv56DGBgCg2xB68M6wZX
   qhyVQ+nD83ZmNizjcAV2uHgcERYr2yiqGLZK+8MdxZZuBYIc5re8iJF5U
   tOriiVz3rFQmSF1QGFO8r15lVNfbUV/i4coCLVxU09LjbsMGSSYvbcTWp
   lsSUw6/hDgjKXmPSKAns1BaxLwJnfvgE8D0MyTz53iGmJA1tGPo7aU/4V
   i+FjSSYOgJpjPdrhmO8jvA/UHw5Qhr9exRaeYOjJp5MsfZ4GO7ECuFMh6
   w==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665417600"; 
   d="scan'208";a="324740903"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 21:15:13 +0800
IronPort-SDR: ePM4mv6az79NpJS7TuqSRW/o/+vhs2rmNJ5rrDddB9pJ1K191vAyaGxBt04Nptyk0uHD9cMalj
 dj1pslmNkxis8FzhlKTqySydjZU4cTvMJfRM25B45yUlRAPIYh0MgsZs5f+PkioRfP3ODwVYyd
 4Xq7yG9CQoD25PnWIhp2QtCVVAi4HFxsToqN+lE6zmIPffWpOskSnkItJZhADRyONbeHwfCeJW
 /4gaWKYb0gbpqFKUnfbr8KjIuElJ989K3knB8FWjyi3GT1y2CG225yjqbXPYs5J4QBMbfRiOkb
 Vwo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 04:27:19 -0800
IronPort-SDR: x2gpvCpWvwxcBRy+F7xQUZ+Xo5ca0elTHyC6KK8k0QPi4a8uKq8jWkmYGF2wzmcTP5WwkivvGH
 CpuvgG8Qvd0HccH738HVWVvv5VaQJ2TG4Wg+XA9uDTRo+eVJBy401tD2vkA1xgSd5jRq8hd5iL
 FGp46nsO3QVo5AEsj1xTBG+q+Nr+LJUH5J2d8yr20Am8dga1Ales7yMEkE3gi/WPOFBNTmW71R
 dqJg1ISFvOPixRUfafVtNR5+YeXRAqDZAsBmt/UqCGfk1NCP/Lx8xgJhdT9mo8ZR7e4IYVNmTn
 4Cg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 05:15:14 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Nrrrx2Q7wz1RvTp
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 05:15:13 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1673356512; x=1675948513; bh=R2Z83dzCeZHKddXeuT
        Umcn0ovi37DfKGzvD49wy2LNI=; b=VX2Kvw4AbdRR1YuzyfHvgUG8L/5D6rCZ5r
        gvRN4heP8JVI/VSlOxxhR28MzfWxtz9RI6LbsJdGkr5u/i6wdvx6WOBAE2Fi4spG
        zqQ2l6sqKPjV/qn0XWkZ+J5MFBCdeQo4KDJ3z637hIthT+Qu3l2cBm2ZXIpnXwBb
        hO1Eb08xCsoIfnzo6WkoHRHvRV0X6xw4CaZSdP/7qFz6JgYXymR6ANp6Mx1ShNNG
        ZhsGDjAFE/DeATfGDYTPmDEXmQk/wkUsWOKW0Dl9uQwFfG2KgW2tfGw/ymd8ibJG
        blzMeEnDrOcEYAhdl5QWgvr+U3BKHtTIVnxLehs2mX/xmWV0mtPw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AriUG8RTjCeb for <linux-block@vger.kernel.org>;
        Tue, 10 Jan 2023 05:15:12 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Nrrrv6VDdz1RvLy;
        Tue, 10 Jan 2023 05:15:11 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v8 6/6] ata: libata: blacklist FUA support for known buggy drives
Date:   Tue, 10 Jan 2023 22:15:03 +0900
Message-Id: <20230110131503.251712-7-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110131503.251712-1-damien.lemoal@opensource.wdc.com>
References: <20230110131503.251712-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thread [1] reported back in 2012 problems with enabling FUA for 3
different drives. Add these drives to ata_device_blacklist[] to mark
them with the ATA_HORKAGE_NO_FUA flag. To be conservative and avoid
problems on old systems, the model number for the three new entries
are defined as to widely match all drives in the same product line.

[1]: https://lore.kernel.org/lkml/CA+6av4=3Duxu_q5U_46HtpUt=3DFSgbh3pZuAE=
Y54J5_xK=3DMKWq-YQ@mail.gmail.com/

Suggested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/ata/libata-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index ac88376f095a..36c1aca310e9 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4133,6 +4133,9 @@ static const struct ata_blacklist_entry ata_device_=
blacklist [] =3D {
=20
 	/* Buggy FUA */
 	{ "Maxtor",		"BANC1G10",	ATA_HORKAGE_NO_FUA },
+	{ "WDC*WD2500J*",	NULL,		ATA_HORKAGE_NO_FUA },
+	{ "OCZ-VERTEX*",	NULL,		ATA_HORKAGE_NO_FUA },
+	{ "INTEL*SSDSC2CT*",	NULL,		ATA_HORKAGE_NO_FUA },
=20
 	/* End Marker */
 	{ }
--=20
2.39.0

