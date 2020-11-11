Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704A1C388F9
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 13:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C9542074B
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 13:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FpsYyETH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgKKNAx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 08:00:53 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32526 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgKKNAw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 08:00:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605099652; x=1636635652;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ts7cpotG77MN9HRU1xKtYRXq+93SoPNt4fRAP9PzDfI=;
  b=FpsYyETHQAyiGDoYpcFeRIY5qTBb9P8xs2i+NKQHvaNH2rRGSqbYtp/H
   tTdGdvr3tF9PmWItHCRLHys1qwWKF06iAoQ125NmiiF39Sr+sw5824BUz
   w9feELCNxJMkOwJuc3qK1aZcVjeyo+GZO4XtmwZTy4EiTMZp5C2KUYmrY
   r49NirZ9UXQem2qMZBAt4K5CtVKkxE8ydHjR6MF17hZAdmeFipKD5BN43
   2iTapEOU5dNhk0B4dGoc4HouwmvbGs7rcfQFfRlSCzAkC4Vc5Bka6o3rB
   lW1/EtYM4KKcSqiDeiGFSiRbpg+51VLcq1iX4w3zGWOl3Z74uDN9aEUOP
   A==;
IronPort-SDR: HUyNRmlcrIpsZ+nTL/G37oK2aaKTbND1W89C6FnIGm6EerocrJJQeSniamf68c6bYWz+9AfHMy
 9URYBeu3tmrwKsCYSA/Wapn+V0VIZe8n1yhdZrlSEBADy+Hyrd0AtPk32h57bcsMw2R4FoNKt2
 pexkzDHdBZUXdGBDnBwuMpWtSXyfOeUXjZ6MEhNr3MvVJ6SaeV1b2zcfrNhLltFyjvau4mR3SV
 mRgqWMzNptVSpLsmTA/a4IYez/BjRofR0038GLrHf9i5WXn9CMnF7z1geKhiVBUpKfeJ6OfxeU
 Vzc=
X-IronPort-AV: E=Sophos;i="5.77,469,1596470400"; 
   d="scan'208";a="152283533"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2020 21:00:52 +0800
IronPort-SDR: VqpwKLMa/xy9cDyyWUxOHAtg1tHq6/CjNnC7s90c76+l2sCq2X0vXlVDyesI6Pl/zwC0lQ/gT8
 legzEUmBZgDyjz66BJxb/0DiUBy6TFH7NuKiqN26Nq06Zr0McQrEDuxl/CvlBb052X87zReMAF
 hcmu4rbyopWen4pafwOLUaXC1a9zS4l/VbigI4KDqQHg9Am/z+QDYbgu/cUfPJaKr+I+uehKkV
 owRi1Ujj2EI7Ir3RwvJ+YI9QgEWkkyJii8hhIirL3FFTOmWcZ1yCWOZCgrHgQQDneqxnE1d/So
 kYlo7pTysny7bOm/RuhCnbKW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 04:45:34 -0800
IronPort-SDR: eKvWX7WICWhXLeMQD1ykuzSDcJC/LLMY4dKVJjpGfNkWYg5QcLOkzp70RwKDv806bXreayZdQe
 N41DQfnMsk7jR85J7Aiw1xKrQbuPOiQEsUGjExSuYzSVNA4YjpUz4SszaV1oKyCEVgBsFk3tUn
 /FBZalpuGi5SK9xVkXmzyVFKy26ZygdPfCh1ynOjN3di7CrTYIwZBVGsCLG3ouEyX6wRqNe0dG
 MWZt2GdsboEpMae3/zvBghWxrK8nv664osX3jYbC9FHGs7IpaWEwKulKEo+FZflPzKlhTEfrOz
 RjA=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Nov 2020 05:00:52 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 0/9] null_blk fixes, improvements and cleanup
Date:   Wed, 11 Nov 2020 22:00:40 +0900
Message-Id: <20201111130049.967902-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens,

This series provides fixes and improvements for null_blk.

The first two patches are bug fixes which likely should go into 5.10.
The first patch fixes a problem with zone initialization when the
device capacity is not a multiple of the zone size and the second
patch fixes zone append handling.

The following patches are improvements and cleanups:
* Patch 3 makes sure that the device max_sectors limit is aligned to the
  block size.
* Patch 4 improves zone locking overall, and especially the memory
  backing disabled case by introducing a spinlock array to implement a
  per zone lock in place of a global lock. With this patch, write
  performance remains mostly unchanged, but read performance with a
  multi-queue setup more than double from 1.3 MIOPS to 3.3 MIOPS (4K
  random reads to zones with fio zonemode=zbd).
* Patch 5 improves implicit zone close
* Patch 6 and 7 cleanup discard handling code and use that code to free
  the memory backing a zone that is being reset.
* Patch 8 adds the max_sectors configuration option to allow changing
  the max_sectors/max_hw_sectors of the device.
* Finally, patch 9 moves nullblk into its own directory under
  drivers/block/null_blk/

Comments are as always welcome.

Changes from v2:
* Make patch 3 a generic blk-settings fix
* Reworked patch 4 zone locking as suggested by Christoph
* Small change in patch 6 as suggested by Christoph

Changes from v1:
* Added patch 2, 3 and 8.
* Fix the last patch as suggested by Bart (file names under
  driver/block/null_blk/)
* Reworded patch 1 commit message to more correctly describe the
  problem.

Damien Le Moal (9):
  null_blk: Fix zone size initialization
  null_blk: Fail zone append to conventional zones
  block: Align max_hw_sectors to logical blocksize
  null_blk: improve zone locking
  null_blk: Improve implicit zone close
  null_blk: cleanup discard handling
  null_blk: discard zones on reset
  null_blk: Allow controlling max_hw_sectors limit
  null_blk: Move driver into its own directory

 block/blk-settings.c                          |  23 +-
 drivers/block/Kconfig                         |   8 +-
 drivers/block/Makefile                        |   7 +-
 drivers/block/null_blk/Kconfig                |  12 +
 drivers/block/null_blk/Makefile               |  11 +
 .../{null_blk_main.c => null_blk/main.c}      |  63 ++--
 drivers/block/{ => null_blk}/null_blk.h       |  32 +-
 .../{null_blk_trace.c => null_blk/trace.c}    |   2 +-
 .../{null_blk_trace.h => null_blk/trace.h}    |   2 +-
 .../{null_blk_zoned.c => null_blk/zoned.c}    | 341 +++++++++++-------
 10 files changed, 325 insertions(+), 176 deletions(-)
 create mode 100644 drivers/block/null_blk/Kconfig
 create mode 100644 drivers/block/null_blk/Makefile
 rename drivers/block/{null_blk_main.c => null_blk/main.c} (97%)
 rename drivers/block/{ => null_blk}/null_blk.h (83%)
 rename drivers/block/{null_blk_trace.c => null_blk/trace.c} (93%)
 rename drivers/block/{null_blk_trace.h => null_blk/trace.h} (97%)
 rename drivers/block/{null_blk_zoned.c => null_blk/zoned.c} (67%)

-- 
2.26.2

