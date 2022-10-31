Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BCCFA3740
	for <linux-block@archiver.kernel.org>; Mon, 31 Oct 2022 02:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiJaC1J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 22:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJaC1H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 22:27:07 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B794EB1DE
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 19:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667183224; x=1698719224;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sJYwO2YFLt4950BGsnhd04xfiHD38rnFysO3T/X3rW4=;
  b=K7n3RWewdxtqEBb+zLrpp2+Pze+xUxYziDpIgCm9pkMZPCJVnediAwTg
   BUddRsp+kPV6+DeK2nYd7Pw+24Gy7AZCvgsOlW0gbb7ADjGM9Mtry81Xy
   sVEH1g0PB2669SaObniU7Xx+9awNpNOHDR4Lt05XlWQLgjmdLFGggGD2+
   qPnLQ9cPvs+Cw5qCVSftXj8dxIMZTt8xuoo7/kgFyCyqiKa7GxbbLzhPR
   5oJzERKRmjotDRgRKdatqyoBGMHE6gG2a1q4Tniq+48jU7vDed36trn1r
   vnRf5SzXIL+EhKyVk4ThWcNc9okTV59JqeB8ew8YYRZK6muC5jGKkegzm
   g==;
X-IronPort-AV: E=Sophos;i="5.95,227,1661788800"; 
   d="scan'208";a="327200442"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2022 10:27:04 +0800
IronPort-SDR: Zt++L+3PTY6JmRf7gECKJcCcGIJ5bAwuiWiZ/sqq9oaP7NaU00AGGNjw5NZOVg84lvTTGMbesK
 lBXS5x7OE94AANl/UNZsxJGMK+NzoYYWsRxv0WTvZQObKLUJdy05hiIDE71qKTOZW3XatbZfOb
 6xfLglv3pdMBDUTiafQ2DOx468aB4Dn65I0ntD7qUJSCYuxvm6UB9WkeNGuWHO+sL7YnVHlRoV
 XotUr6GvLkFeuYbwoA4WRuuJMztBAmsfMw8eCUXC2L/bXm3dtpg2S97kVx/N3neskza4iBtZPH
 v5mrdj3mQ8ILN5hI3aICCOvC
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 18:40:37 -0700
IronPort-SDR: cNzraxA1pIeb4YCBtS2WxWnUOfXvetN3cP6/slxWCaMqL4dkgjL8LMmW/U4Awvu1OJU1jfPb8E
 EDFR+dHbUl4fcjA9nSxzxBCw5fRgbvHywWgEsKwKSF4eHnroXmML/KQnoUnX8Haew0N1mnItRR
 THsqp2aZ5lizPlMijfcynJzH2oREuei3sF0cIdwpdYhLMInQFnXBlc43kkHRPmQaXfa1Pb1/tZ
 ynT30UgiMzl66SX5iJkwBtp1fsi8PdMBAImHoTDdoPOf7zg1fL4WSkSUUXDnZTIIW89ZbuIszG
 MqE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 19:27:04 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N0xqq1hbxz1RvTp
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 19:27:03 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1667183222; x=1669775223; bh=sJYwO2YFLt4950BGsn
        hd04xfiHD38rnFysO3T/X3rW4=; b=ufswJzzYBW5aWp7nOfZSv9NQRiNgxTeui4
        xd/jCvtSJrbGs9Vy6wBI6FPjeCxJ0jACiYDrSavsfGxvPIP++sLr5rpblMKB/mdP
        l0Hl+S9ZU/IfwC6UPzmqPUQ9UKBzPbh/+DlHcWW4tUcv7IBa9YVVEVRhWrkr5UOu
        +DmlTsb93qRPKVJZLtBtNMi7SzvofAee6XQCYKNd3EOXJDeAM0PS+pp9Nv0Na+jK
        uN2MsoBC1v6quNd03Ago1YUw3CYzyt/kwHhhmlUWQI5i+kWjMGWqBzfxo60rzn8/
        mEaAT/JLOxXBDOoTB5+olDuKZ3zvdp+np2ONVthr79fdSJbC34+g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ORFQFmcrjMfB for <linux-block@vger.kernel.org>;
        Sun, 30 Oct 2022 19:27:02 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N0xqn1DPgz1RvTr;
        Sun, 30 Oct 2022 19:27:01 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v4 6/7] ata: libata: blacklist FUA support for known buggy drives
Date:   Mon, 31 Oct 2022 11:26:41 +0900
Message-Id: <20221031022642.352794-7-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221031022642.352794-1-damien.lemoal@opensource.wdc.com>
References: <20221031022642.352794-1-damien.lemoal@opensource.wdc.com>
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
---
 drivers/ata/libata-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 83bea8591b08..29042665c550 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4137,6 +4137,9 @@ static const struct ata_blacklist_entry ata_device_=
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
2.38.1

