Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0D9C38A02
	for <linux-block@archiver.kernel.org>; Mon, 31 Oct 2022 02:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJaC0u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 22:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJaC0t (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 22:26:49 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411F75FB7
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 19:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667183209; x=1698719209;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TB8GULlPNsTR3UfxioPMuiub5InCUOUu0M0hMvsFH84=;
  b=VXOUhy/sP7VW3n0ffKv9U7iJFopKC0Vgwz9VXczlK+p8Eo5ec9ogXsjG
   LXQ7IGDUznnJTAuK2++drD6fH8XZTfjHKyxKc4oXe5I4AcWVLwWXrsStk
   E99pisN1+G1qOis6pULSUIq2vm8Nr+ipDWxzeO/zWGYc8JFfmxjMjdTV/
   emPLuNLowFpwPHKCSLae36GI6ktZFi9owMcyPX582CVS8A4esVnVIS7v/
   D8YFyeopKvtT15iNtkot+P6+tgQHhJe+tTXsNYdTNzceabTswfZ1M+5Qo
   lbW0l09w0+rWCqeGcEPI96IzviBAup45AxktuRepRNRgb8kHrTU6Y+l9P
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,227,1661788800"; 
   d="scan'208";a="215446851"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2022 10:26:47 +0800
IronPort-SDR: n36CO9EJgF99FjAQXb3xdMxCd0bbAMk1ZuQPbCyUMZuZ49iRnW2TXiJ6uxKFkv1TIzML8+xNgS
 oHBLzaFUMnnotauo/EVGALQ2BCBFEhszezHtcg0i/AnwKZPHjieNZAoCWGO4lhZbl5RcYERIb1
 01/FRJeXApUEJ82BhM7DN7xuIDfJUhfY/2vX2JAkMSDMz4B7xGOF8iZVj+oYzo9uUQt/iiRGi/
 xLaSQ3/QVWg+U0hqnhNAnzgRlAHvN3G6q7w28VzRP6r+lKyMqdYCs8JV0nBqyVk+gYf0dqphJB
 phdGFzjQS6uau3qhdGlQPz+S
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 18:40:21 -0700
IronPort-SDR: V17byOGGd3Rw1KlVdMNY+tooRXZDczS8gENv2pakOU6ebUE5g6m4E/x3OF88MK2fZ1q09ognBh
 PYG+Fp7eozwP3oBA39rBn2HKsnpnRSxxw/SkoN1AY17lSN7gnrSGh57vYUZIgyvcqIxV8i6gi9
 sr9XxLiMEtO2MTNsgXOM6xOKJxQcyBTrqxwLIo0yDJW9hFFx8eXvNtLOnZASqQL6TpxqDXKbAO
 DNbniCP1GDZ7drcMKJL/NurLDSyUchnEr05qHUKCP9WTyjE2yy9Cf9pRBxkREfLmZzWXblKmvs
 sFc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 19:26:48 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N0xqW28rHz1Rwrq
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 19:26:47 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1667183206;
         x=1669775207; bh=TB8GULlPNsTR3UfxioPMuiub5InCUOUu0M0hMvsFH84=; b=
        lkceJKSFBDC5As838ysdV25Mgvohu3nvAy9U1Ei0Xa9VyqbCgyVzzXeht2Ey/xPB
        OAz90XzF8y+bzIOm2bIaxc4C2vFRC5cnusyHDNgYUE8h3acH4dnVZpd9gdMlIsQq
        6UdRQgBOCHpTo3/qNrmKTcvGXRR38gAO6N7dKr8eu5fzY9SU60OSpXQ0T4/MSfAq
        A532W1ZdYlKU3/n7yr2ZXbpxEv6MaCgaA69VZFeY7+YUeZ5qp/kaAV0y2byh7MNf
        fPDwNIQjasIj7vx5MxpynwPAbfkpXzXnn0Ix3TrZRxbrvg0h1TKQ+bmE/mLP/gGG
        VnNSnC0Z92oN0SaAoFiAHA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BaLiVbQ7vShW for <linux-block@vger.kernel.org>;
        Sun, 30 Oct 2022 19:26:46 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N0xqS2x5Sz1RvLy;
        Sun, 30 Oct 2022 19:26:44 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v4 0/7] Improve libata support for FUA
Date:   Mon, 31 Oct 2022 11:26:35 +0900
Message-Id: <20221031022642.352794-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

(Resending with updated cover letter)

These patches cleanup and improve libata support for the FUA feature of
ATA devices.

The first patch modifies the block layer to prevent the use of REQ_FUA
with read requests. This is necessary as FUA is not supported with ATA
devices when NCQ is not enabled (device queue depth set to 1) and that
unlike for write requests, the flush machinery cannot enforce access to
the media for FUA read commands.

Patch 2 and 3 are libata cleanup preparatory patches. Patch 4 cleans up
the detection for FUA support. Patch 5 fixes building a taskfile for FUA
write requests. Patch 6 prevents the use of FUA with known bad drives.

Finally, patch 7 enables FUA support by default in libata.

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

