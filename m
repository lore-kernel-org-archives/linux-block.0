Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF214FA373D
	for <linux-block@archiver.kernel.org>; Mon, 31 Oct 2022 01:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiJaBxy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 21:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiJaBxm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 21:53:42 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B259495AE
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 18:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667181221; x=1698717221;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sJYwO2YFLt4950BGsnhd04xfiHD38rnFysO3T/X3rW4=;
  b=D2Q2Yya7t2wn917xwYoCBchCKmnC8GLz08VoECVCsbFo9UrerzN4KQK9
   v2JGFiCavPR6b7pPQVrycqyVR0m0WLc3o61rZ6s5ehNkZNVTCtQq0T/je
   ui/bhqs8gHYobBM7V7nj+76SD5g96XqfJI82ctcneUpF7xBQT2vxVRRvV
   cj1Pi+SFVeIcHU97twyEcuQA2lj5xlxC0yTCMbQaQ3B3CPAZXmWa11pil
   1Rrgyv7n6S0n7N/JgOCCqgLCqoWsnCMZ9miwPE+E7W7r9hfRp0meHmvAc
   GN3s+zn9gvWM+40zScWmyz8BJ4MklmwDe0ZphAdoztY93UyeCcdN2pMRs
   A==;
X-IronPort-AV: E=Sophos;i="5.95,227,1661788800"; 
   d="scan'208";a="213387074"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2022 09:53:41 +0800
IronPort-SDR: A3I3+C22KJ1jdFtMuJGP1lWzBJ+5lmVorNz9rN/quVZOE5+k2JBc2M0/Eazb3uOKNxE3ICIr+U
 1lbNyA6lPxIzEkBjYbW6j2NTIq6DPG5IZ83UlzYoTIi3tEGjVBDWziOHawzQRGqc9La05kUT2F
 /HukxcRI4vNXSnx9HfsNH2RNxGoROlb9pw6WbSxT5bOaqooIrBmSCr/32XrZcKhFu8rI8Qh+zf
 A2REwPNMIbvWzY1k/HyB0k68T25771p5jkn+bQZvI/Pp3ynAaPN190/GVEvy/8u/k1b1R6BsPl
 3t0JPg3z8xE07EfciEz+0vS1
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 18:12:58 -0700
IronPort-SDR: 6juspIb++yWr9D0IEerOSRqI9kTY5vsmWuwIPDE/gGJ9UInfDk7bmwEaBlxkzJEmpO9Y6GhZW2
 1QInr4F2xyKKq+3epAPpzaTFGMDT344mf3hyz9sf5p/U9lSUee8vwvrKyPzTi1ndZRDjf7SuQf
 sIAstyO9LGf2jSgATnPh1kBRvQaxbYhB5dSBxjyUEs1+pnr17EsWCWCZKO9ey5PBIUpHDHr1su
 eg4a1Y+Ad0P9lVi6Zcohk7hu/BMqOlL+eA2HfN5uevYqgyQBUPXBIh3HhRs2JG7YUbhRYcRW1i
 AsI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 18:53:41 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N0x5J6nmKz1Rwrq
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 18:53:40 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1667181220; x=1669773221; bh=sJYwO2YFLt4950BGsn
        hd04xfiHD38rnFysO3T/X3rW4=; b=TmzQ5K3cRbhLfcayFXFn8IpWk1RaHFo7sF
        PbDqJTWnFco8Qzl+6MARoGylsSVI7lpQgnvo2A1/SswcRKl7iS6NipKcVp9W+b4v
        wwokpEUkF3mJRQF+Qm8SQSBnk/BUFYWyFXPukblboshE8LJMK9cM+LKFuhkg0KbS
        LU+woVIrLeFed4fvlT0VTdY8iOmdGJza3wQH8imUd0cTVRaebRZOEIioLjIKLFmX
        M2QfcPV9ey+3g2US5mPuYn+uH3j3TG8LLTospnSGvkbdxhP/AFHgdVTAxe0y6fXc
        iTtJCrcHUkVlyj7TNp4RjfONVPBSWIyg2PTDDEnXicNR0Iapp4UA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id C3IPrz1NGLw1 for <linux-block@vger.kernel.org>;
        Sun, 30 Oct 2022 18:53:40 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N0x5H2plzz1RvLy;
        Sun, 30 Oct 2022 18:53:39 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v4 6/7] ata: libata: blacklist FUA support for known buggy drives
Date:   Mon, 31 Oct 2022 10:53:28 +0900
Message-Id: <20221031015329.141954-7-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221031015329.141954-1-damien.lemoal@opensource.wdc.com>
References: <20221031015329.141954-1-damien.lemoal@opensource.wdc.com>
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

