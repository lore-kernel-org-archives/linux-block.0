Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F339C63797
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 13:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbjAJN1h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Jan 2023 08:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbjAJN1O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2023 08:27:14 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1163BB
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 05:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673357234; x=1704893234;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kJDx5m6NLMgHD4UV2WEuI7W1qzKw58WnWCzUakOHpnk=;
  b=g+UJfdxWHyeKbNbcthr5Z0zUsLKHxfFHPnz9vv5Qe+M6z4NsAyCys6Ln
   R+CdUp9LLtdI1ivXV3plBVhKbTq66ksEI8XpAG/vJj8gTtVhD0rlS2cW2
   TZ6/hlCCjOP/e3Df+wmlDjwGUMHFWw8Gyo5YDRIBSVfFJEdXrzTX1XTwe
   TUGjytLaiVaYRQd/X5/D2pcPq3K5Nfiw6zdDVWdmTov1K3w6lDWrzaXMe
   kLrmoqVGCOvALvAq5Mbe5lAFAqiGw/iPE/M8124b/cCbVniJQZvqfT2ic
   z0ufSsGMYKAJRKzP8v0AO786iwreI5NUI8j0zM1fHobgjNn4RYrkGN+sa
   A==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665417600"; 
   d="scan'208";a="220321115"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 21:27:14 +0800
IronPort-SDR: vV72zbgdn5IPwJFyctIV42D+vJ+Ji+i441tT08ruWFg5//yNvIFMh3ADjXiFT2WTPEA4XP7JBl
 ipicqza9x6fcJNJQtB1v5Ry0MbWTX+O6Ichys9xCv8cJEkgSJRPeok5xzyuNKl/Fh2fjzITiWH
 0BtZHQr7e29ncYQphIAMWnjGOVP4CSHNw9u3gVqEP/GpxJ99lHioynrYlI96jO5sIb3xmLPemq
 R4o7Dx8NkuOI3j0qlSBb2rl3WDE27mv6OgOnISr0CYZy3ZNW9prCeOk/E5Uh2d3FpgMqPwK96O
 E/w=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 04:39:19 -0800
IronPort-SDR: jq/ICnjI4R1ZJGTczQ8PnzM2CTe66f+vrSWX/13pzVxHjSdRSrr53k5tVO9fqJvYnV5oh1O7V9
 cvFUpXoZXUl7bfW4hMVhNXZRk0U0mPgHC+FBZjenw2EZL5SsMF71GX8ol6GKLQkxT7n1dCQ3rc
 nzzG6otYOvhyqh/oMuLplh22lxkFwPSo1KQ7itZexhFqkfytd3veTa/tccyaLCcnQhTeBkr+83
 rWC9+14ZTwKVAkuy/ar7IxVYvORVGa8+mz5Bktg1SbEQ9qsv1CRYV8wDmu70KiF8Nlon+JaBL2
 EJ0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 05:27:14 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Nrs6n4tpHz1Rwrq
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 05:27:13 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1673357233;
         x=1675949234; bh=kJDx5m6NLMgHD4UV2WEuI7W1qzKw58WnWCzUakOHpnk=; b=
        AdDDP+RF43BprwMavEQ2mTih25ApxT1PC7armszWqy+lnZGj6m7Z07Nz/cBTWy4U
        elHxFDO9pYx4Sp3yEzWyj6N71pZfW8sNmy098WAcYRmYsiDxAxpbnu4GQMlMrCdy
        ax1saYPWowCmE/SMhsC22eO4hjO4C9mM/eIxVfj5wFJRVY0w7t6EjB8LgsTrqnOn
        BTHl5+ILnDdjhoUdLKrqgTrVLLPFvsveV6W0HCkXql6Rc44gnACw3TGWBQoBlz8z
        1LCr1U2Lmf4ngZcM6jc2T+07YVugCH5KZa2jT5l4dKSaOFd+7V78ALWZJtL/XSnI
        Abiu+U2ar0X82LYysgND+w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id o_hcbYhpLORx for <linux-block@vger.kernel.org>;
        Tue, 10 Jan 2023 05:27:13 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Nrs6m260Zz1RvLy;
        Tue, 10 Jan 2023 05:27:12 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v9 0/6] Improve libata support for FUA
Date:   Tue, 10 Jan 2023 22:27:04 +0900
Message-Id: <20230110132710.252015-1-damien.lemoal@opensource.wdc.com>
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

Changes from v8:
 - Added Niklas Review tag to patch 1 (forgot to do that when I sent
   v8).

Changes from v7:
 - Given that there are concerns about introducing regressions with
   older devices by enabling FUA by default, patch 7 is dropped for now.
   A more restrictive approach enabling FUA by default only for very
   recent drives will be sent later.

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

Damien Le Moal (5):
  ata: libata: Introduce ata_ncq_supported()
  ata: libata: Rename and cleanup ata_rwcmd_protocol()
  ata: libata: cleanup fua support detection
  ata: libata: Fix FUA handling in ata_build_rw_tf()
  ata: libata: blacklist FUA support for known buggy drives

 .../admin-guide/kernel-parameters.txt         |  3 +
 block/blk-core.c                              | 14 ++--
 drivers/ata/libata-core.c                     | 69 ++++++++++++++-----
 drivers/ata/libata-scsi.c                     | 30 +-------
 include/linux/libata.h                        | 36 +++++++---
 5 files changed, 92 insertions(+), 60 deletions(-)

--=20
2.39.0

