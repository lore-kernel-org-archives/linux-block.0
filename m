Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F2BFA373D
	for <linux-block@archiver.kernel.org>; Mon, 31 Oct 2022 01:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiJaBxf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 21:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJaBxe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 21:53:34 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF2195AE
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 18:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667181213; x=1698717213;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X5zEpX6SMAZQugAJoTV81VehZ+el5Q+3olqpJdDoQEM=;
  b=p923N2GHDUl4eAK67WUcFMv7ubaKPImnpVm6hFUgPwUutdOfDsAMHq6j
   zweCKtXaHpPrCvAANtMuExsMYYGMU4rXRiD3+OABKGW0D7Ap9yofOHAOU
   Nl/kGtXazLa8l4xnRuEv6k4N0T9zlbbB/lfMW8OqoOw5NkYUiyskdP0FW
   hs84A/TOjZGG4R9QmU+7xEXBWKjKtl0JomMuU9VdU4mXQJP9rLj9JQ2xC
   8qsFo7ouCpRIWK+CsVKoHxQ3CpVt2Gt3wynoxLj4I1k/dCldtOHO85EDq
   A2oT/0ZW0XKhRUtYWAjQWvXUOV0xb6TUk14YAPnXyxp84Ydugag5Q+nIP
   w==;
X-IronPort-AV: E=Sophos;i="5.95,227,1661788800"; 
   d="scan'208";a="220246014"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2022 09:53:33 +0800
IronPort-SDR: G2Nu/8JpOLFX6bJIj8NcXEnC16AAMTc/4MSaGuboet7lJ2OYTSaMQRVXWK7GOxwHzZhN0GbRIU
 v1SLKI9Oazqvh4gOAx1lalyLF/1uM0Z8YnmdVCdeqRZgoA9x9EvgFNgyeLJDMgVpU9qISSfau6
 SG/fYRl0H4w0Tr8239dTafLN3RMbtEXOYwlnEYDgoB0Qams0syg+zJEhOELKT2b8hafXgweFb8
 26AutXQHksjP5gszxQ7+syoic6YUSTdhrF4sCFoe7RmEjqO15iWsUda4lncm0Euc+DdS3OJK67
 Bk/M0HAGHbP8x+QmU6vQ4YP4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 18:07:06 -0700
IronPort-SDR: 2C9pk5xmD5mts8e5EzVSAkO4+m5dT9mJfnOCeuWBmH5fW41Je7kE6mf54miMMZgBZCg0kEuTQg
 YoU7SOYBNCojjz3j8tKMhd4gYW6BnvUG51Q6HG/FiCqHA+l1vWYtrHxaaZPmRgz7wSQm4mf15y
 BaxA5Wka1W7ufIDA/Op5DNuHxUmD9LURXb3Z28PqAs/VfxAIBRh7H8wmeFrHPciTSea9oSiKRJ
 fMTRtFZaWOjluDd1OmcOgERvDsR+jrrbikpyrcvB1jh4QhUFWzCfeKqF5sUg/xgnQCWDhQd4Im
 WC0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 18:53:33 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N0x586yNxz1RwtC
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 18:53:32 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1667181212;
         x=1669773213; bh=X5zEpX6SMAZQugAJoTV81VehZ+el5Q+3olqpJdDoQEM=; b=
        sTVLSidPt1Z/gAxxlLa4bRTPqZbgdV37A6eSVzTt38taLgNrhdl60ypH9CJxwkrQ
        7NMzLX2izJTDlliBO6XRqWVgG3/JyrKcnegg/54jaitdRvwF+JFIpgQ1maninTSD
        MSiX8OHZGWbPBYielm2Fk7YcsuSoOyauteHZ6xVODMec9kRR0DIn5/8fZA8TOe8y
        bZKDh1Madaame0dr70jiKSEufaaAeRMfO6Az0Gq99SEn6D1IeKEaUTq3OozobpfM
        9VwA/4IvPOvjGGiR1+tXAonGxQSHRFM7kiJK0vegWbcJryB0iltJ+oINHnKTbTa+
        yI7qJgjS0oqRSF+favvPCg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EuioKxy858u2 for <linux-block@vger.kernel.org>;
        Sun, 30 Oct 2022 18:53:32 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N0x573JZfz1RvLy;
        Sun, 30 Oct 2022 18:53:31 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v4 0/7] 
Date:   Mon, 31 Oct 2022 10:53:22 +0900
Message-Id: <20221031015329.141954-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

These patches cleanup and improve libata support for the FUA device
feature. Patch 6 enables FUA support by default for any drive that
reports supporting the feature as well as NCQ.

Changes from v3:
- Added patch 1 to prevent any block device user from issuing a
  REQ_FUA read.
- Changed patch 5 to remove the check for REQ_FUA read and also remove=20
  support for ATA_CMD_WRITE_MULTI_FUA_EXT as this command is obsolete
  in recent ACS specifications.

Changes from v2:
 - Added patch 1 and 2 as preparatory patches
 - Added patch 4 to fix FUA writes handling for the non-ncq case. Note
   that it is possible that the drives blacklisted in patch 5 are
   actually OK since the code back in 2012 had the issue with the wrong
   use of LBA 28 commands for FUA writes.

Changes from v1:
 - Removed Maciej's patch 2. Instead, blacklist drives which are known
   to have a buggy FUA support.

Damien Le Moal (7):
  block: Prevent the use of REQ_FUA with read operations
  ata: libata: Introduce ata_ncq_supported()
  ata: libata: Rename and cleanup ata_rwcmd_protocol()
  ata: libata: cleanup fua support detection
  ata: libata: Fix FUA handling in ata_build_rw_tf()
  ata: libata: blacklist FUA support for known buggy drives
  ata: libata: Enable fua support by default

 .../admin-guide/kernel-parameters.txt         |  3 +
 block/blk-flush.c                             | 12 +++
 drivers/ata/libata-core.c                     | 77 ++++++++++++++-----
 drivers/ata/libata-scsi.c                     | 30 +-------
 include/linux/libata.h                        | 34 +++++---
 5 files changed, 100 insertions(+), 56 deletions(-)

--=20
2.38.1

