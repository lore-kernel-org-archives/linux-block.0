Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B51AC53210
	for <linux-block@archiver.kernel.org>; Tue,  3 Jan 2023 05:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjACFWV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Jan 2023 00:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236765AbjACFVn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Jan 2023 00:21:43 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E51F5A
        for <linux-block@vger.kernel.org>; Mon,  2 Jan 2023 21:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672723169; x=1704259169;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7l1MMIENk2oH2FqNWL1GVw2Zn0YgTZg5M7dujBNkB8M=;
  b=pXZtoH1nj4orzqFTJWklBsBG4IAnQKn55SthzypGfsmR1xmuLR6VbXCo
   RwObKVhW5Umx9DF7/BeBV6T20H/JbgKAyjhWeguk4HAPpAFDwW+zz8eGI
   6jKJBy3IbYbGfbWbh+B70cZpBxyN64r93qhtWRyZshTL6vxwTGMR2Pm5B
   DKFZS9C5PXKN1hF0ULaAzkXNxbjEodfMez2Pp394CRrB3iJLMp7Y6GLhr
   gBfHSLLQ+mqvTsIp9N0dFMZNIlXCL7ggPf/ABz1o5McTQjEYCQabZvhOR
   CvYka8kysABqM+QNYEl/+jqmrCWsNgpCA8+GtILIpT0n/R+EZSYl8uvAw
   g==;
X-IronPort-AV: E=Sophos;i="5.96,295,1665417600"; 
   d="scan'208";a="219794866"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jan 2023 13:19:28 +0800
IronPort-SDR: LcAIq+53zJv5q1+2xaBKvbdEd6DN0dt23XYG8ZoHXyH0AfGUto/expZjX1RX8P5A+p70Hpa1rp
 GLgqweURuurSPOE944d81yP/ggNx0AWlU+JsVfOg1twu1MBPlRtv/9ogpy/tob0m5rY+ulsxS/
 o7aVtaKTaTj66HIN2DHOR/dtELf3JsbIoNEa1rcaaBowY2DflRTmeMszSqTuzep0X4XAuYNzcY
 TGVbsGB4AWzJ5A/bC+2tE1ivpjLIEhs3bzk5Jnagam7/Wq0uP2INEUhZAGiVpZ/Vo1EvZi6xxN
 ssc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jan 2023 20:31:42 -0800
IronPort-SDR: 2ss+ve8NIA/kQYo6FiJDqqiQCejVXdoV4oC9JCxhAUKu6sVOol6KPQU9QtYE9qASPts2umReQy
 pUWXVS7aqvmIK0fOVO87CSxD2ki7h/dWWgP9P36nXH4VlZp2ZE95F2E8HWz44YtkEDyGNXQcy5
 clKu5AHO7BtKGbSIceHfwcwqUhHOTe2Z8vzms2PjzI5fdf4XVLVWZJvYaBoOSboEkopuSrq8HQ
 34YkhafTuTwSrshqefvihcXeuoWhE33x8u/fL2+BFJEHoUIFdXfHHegzDyqY6cPpZH07b9Vmc1
 nuY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jan 2023 21:19:29 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NmLdC6Z0lz1Rwrq
        for <linux-block@vger.kernel.org>; Mon,  2 Jan 2023 21:19:27 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1672723167;
         x=1675315168; bh=7l1MMIENk2oH2FqNWL1GVw2Zn0YgTZg5M7dujBNkB8M=; b=
        nOafh1+vc2DsudU4VTflh1Tnzd6RVWn46r79oILpdWAjOP9mC7Q2J6nJ019vVp1o
        KH3SNPa4QWIDZw8+CkwtDnKzAq1FSje/U0Lw0zfp/t6tnNMRbmBPTh1xFBqiZF24
        CfGtY3S5m1XcJC05AS7Jn+o+ghwqYtI51IjzL+c1k3tBHYW27LqoUsSh4t2abKJE
        Sau6aXoVkw0A1T/WWqeRlxdNc7EDGv4dZkinh6BrTbhxA8t71jH5l6i8G7zIyWET
        5do/s8GCV6eZWmtbI+T5H+jXrQqWNaQ0e6lR+B55NgRxFDPh5bCgm24Lizo7kMlN
        2908CQBhnsrY/eXJery+2Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cREnswzJzTAW for <linux-block@vger.kernel.org>;
        Mon,  2 Jan 2023 21:19:27 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NmLdB0YXMz1RvLy;
        Mon,  2 Jan 2023 21:19:25 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v7 0/7] Improve libata support for FUA
Date:   Tue,  3 Jan 2023 14:19:17 +0900
Message-Id: <20230103051924.233796-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

These patches cleanup and improve libata support for ATA devices
supporting the FUA feature.

The first patch modifies the block layer to prevent the use of REQ_FUA
with read requests. This is necessary as the block layer code expect
REQ_FUA to be used with write requests (the flush machinery cannot
enforce access to the media for FUA read commands) and FUA is not
supported with ATA devices when NCQ is not enabled (device queue depth
set to 1).

Patch 2 and 3 are libata cleanup preparatory patches. Patch 4 cleans up
the detection for FUA support. Patch 5 fixes building a taskfile for FUA
write requests. Patch 6 prevents the use of FUA with known bad drives.

Finally, patch 7 enables FUA support by default in libata for devices
supporting this features.

Changes from v6:
 - Modified patch 1 to include checks for REQ_OP_ZONE_APPEND
 - Addressed comments from Niklas (patch 2 -> return false, patch 3 ->
   commit message typo, patch 7 -> more verbose commit message)

Changes from v5:
 - Removed WARN for FUA reads in patch 5.
 - Added reviewed-by tags.

Changes from v4:
 - Changed patch 1 to the one suggested by Christoph.
 - Added Hannes review tag.

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

Christoph Hellwig (1):
  block: add a sanity check for non-write flush/fua bios

Damien Le Moal (6):
  ata: libata: Introduce ata_ncq_supported()
  ata: libata: Rename and cleanup ata_rwcmd_protocol()
  ata: libata: cleanup fua support detection
  ata: libata: Fix FUA handling in ata_build_rw_tf()
  ata: libata: blacklist FUA support for known buggy drives
  ata: libata: Enable fua support by default

 .../admin-guide/kernel-parameters.txt         |  3 +
 block/blk-core.c                              | 14 ++--
 drivers/ata/libata-core.c                     | 73 ++++++++++++++-----
 drivers/ata/libata-scsi.c                     | 30 +-------
 include/linux/libata.h                        | 36 ++++++---
 5 files changed, 94 insertions(+), 62 deletions(-)

--=20
2.39.0

