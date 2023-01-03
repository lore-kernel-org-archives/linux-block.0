Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1168C54EBE
	for <linux-block@archiver.kernel.org>; Tue,  3 Jan 2023 05:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236714AbjACFW2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Jan 2023 00:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236789AbjACFVs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Jan 2023 00:21:48 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8ABB5
        for <linux-block@vger.kernel.org>; Mon,  2 Jan 2023 21:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672723178; x=1704259178;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=87iRoott3W6CZmf35ZkmB8TszihaBydw9Ue0jkE2IcY=;
  b=mjPgkDUx4O/rCiwg1nanAx6S8/mDvIENM3fYM1TXp3yQCTT0hocKjdVj
   3MN2hYq/PAE2Bp5bdEGUPADZaD/PGyDCmsIhchy3IJkdJh2AgCLKZR45p
   /9kkRZitoura1jJBx9c70Ck3pkj9IILCiG1ISeCk7U4+bYxwVgmg188qk
   KYfMOvh4QXcth2+PAPhD/73s8wByIgGSLtX76AuGYCKl0z4mAQP+G4nyv
   r0dwpmJHhTCWpLpkCKe9p79u0kxjXppdXVlxyOOW3DF/IcVY59lKSQd+u
   jugKvbET70ih2n7wuf6FjyJvDxSSIyf9pr9hHTdydNK80dsq9pVcZenBM
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,295,1665417600"; 
   d="scan'208";a="218126871"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jan 2023 13:19:37 +0800
IronPort-SDR: MyV/DCk/KRkDeb7jVs/hys1e2fxZLRwGjjp3fQTyYVxTOMTjXNzAnnmftmX2Z8bBpKpoyK/DHA
 w7Kq/J7SkSNsduOlv01+rcUyx6KlqZIIklGx4pMIT2PapMCwB4DJAS+6p4gZ32mFKgNse6qTq7
 ifbRC16Bvanub+PEcZC+gXVcgH5ERHBqH+WZ34j/iS/OoLZYkLzJvDbQpHrcFAj2+AQRjNtllF
 hPMbCG2C2o8z2burLm6TuzHdEdI7fexBgIIPbPdNQAC5Vgo+ILvLtdjKWNvTRN9QtwKUGQqMbI
 FLA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jan 2023 20:31:51 -0800
IronPort-SDR: LvWnQoWloFlrJfbkT8wZKeWWMhdmsttvv06ZN4Cg1BojiT4KPp8gqBiyK6eJLeIW0mL6FWhsNG
 9L/8oiJJuH0tjE/NLtavjK/c9itjdose2m6c6D9t2f9WfbKnFtXcJbqRqJ3GsCyWlJ/c6G/6qZ
 zdwHP6g5xXE84TreVjEpQ12uSTjARyS6G7V6cBtbExx0/eSyDwf1TG/oUCBs1GfCCEsNBXqLdN
 yCUwtEXlKSYjvEU3qjYHJ4X/7sooxNb3a1QaNsMQ4HzlquBcQ5LG5tfaPF/5HG5mS2tByUkNsM
 8Xs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jan 2023 21:19:38 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NmLdN6d3xz1RvTr
        for <linux-block@vger.kernel.org>; Mon,  2 Jan 2023 21:19:36 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1672723176; x=1675315177; bh=87iRoott3W6CZmf35Z
        kmB8TszihaBydw9Ue0jkE2IcY=; b=bHbypYkFzqdAk9Or0V5O5a0iwxZCAtLdph
        cd8llhcDeIYSBy+XlCQtk/Q3p+YsHcs4dR1E+W6kGvVLR74Vou+LNjN7YybBnsdC
        JKolBHuuPzn7Pk0akCDsyr3czduyajju+pmmfTi8p0jrOwjrJLjQubNbYzGvxwra
        vRNWwpgdM7xnF5tTC28oP+j+lHpVdPgBvrQLLT6spv/3S5oz94gDsY8b8uEFAo5x
        LuSDpIa41rgfPkPjNYxmYmJsG6dZci82HQH+yCBQTNTR6ckl1pdacj5eP9Qngy+n
        Owr5r0JX7c+nGgwmmve7XoHVwJfuDdIG2tXXkUlDp8lvfhkLvxFA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JawmIb4e1jxW for <linux-block@vger.kernel.org>;
        Mon,  2 Jan 2023 21:19:36 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NmLdM1RqFz1RvLy;
        Mon,  2 Jan 2023 21:19:35 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v7 6/7] ata: libata: blacklist FUA support for known buggy drives
Date:   Tue,  3 Jan 2023 14:19:23 +0900
Message-Id: <20230103051924.233796-7-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103051924.233796-1-damien.lemoal@opensource.wdc.com>
References: <20230103051924.233796-1-damien.lemoal@opensource.wdc.com>
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
index 2b66fe529d81..97ade977b830 100644
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

