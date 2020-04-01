Return-Path: <SRS0=ADX+=5R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3C3C43331
	for <linux-block@archiver.kernel.org>; Wed,  1 Apr 2020 01:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D71C02054F
	for <linux-block@archiver.kernel.org>; Wed,  1 Apr 2020 01:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CHXf60/X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387860AbgDABHb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 21:07:31 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:16250 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387868AbgDABHa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 21:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585703250; x=1617239250;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xh+tAMN99+NZ/2mBC0z2Ta4/4uFPmdJEnKEoU0gXf9o=;
  b=CHXf60/XrcIYTiCU5mn/XtaVoMEJY2XNun7TMG+L/WFOVN6BiGOlh7hG
   nGzzB1WjxrnyAcQB94OAkpiCOAjCa6BI4bEl8DnEwN2ECrycbNzlN2jIz
   6dkDFpBs/8t+1CAWygcv7w0sYYV+4i4hwQX5Py39mLAD/qr/NWyCRCcwm
   s3GmOCuL5225S3hRuUglpL2PaRrya4uCp/V2hp5HWP5bKcQQTbI3QX0Au
   JGRefqDvuRfQYDcJ0hvMl+EPed5FT6LGlK/QYkyTKNWp51N7VetMASH57
   gsbeLYqbmYChLDUF3747ZjQ6bJhwRNF0LtzVUBlc6r01MQ56RX25zy8RM
   Q==;
IronPort-SDR: JpNeBRQKZ3LCAhXO9GD4OhrILdxMZqDsg8A21KzPNfDbim+JyFCOJKkVNrwUjFvPWU73LojWPQ
 tm8RnRKmwrz8g/rOxWnbm1K887ROh8XoomB19ain58kQYk0lwnZA0Zl02mzijzgc/yka83M4Eq
 6TQ/x2N4nmHKYx84MeDIwM8AijaOfu/GuoNPlW5VQupagVa3USBtwZtHyyY3JQZkJ73Xf64i0Y
 AbytYEMVGqfu2zVEsFrPKN+l11LLf4CGHjthjP2mx4JyVacBQjLPbj7QY4HRD6OlTzq9rB+Kvl
 zXo=
X-IronPort-AV: E=Sophos;i="5.72,329,1580745600"; 
   d="scan'208";a="134531018"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Apr 2020 09:07:30 +0800
IronPort-SDR: s/nEWdJZYgf7vUvxRtio5di4Upj/TX3hHQ8FXR0hDpNlrcjogCUteBVrzywWOtffsioOvLW316
 yzllH3UKENffiOZ7c16ql+dhFC3qoZoGqv1AM5OVXkpd0vCUO8ajbomf4Edl3ZJ99Q5tB+xElV
 1m14hJQcoDXI6lBK7/I2x0WRFJkIt4/nod00lWjfDp4wmtqPwJKM9deZPq/gDkLq15KNYzdtsi
 nBbXAzye/jp/hY8AOpSRTL0oaDOk0JxjiHnnNIswkQu7tAFukzGs7Z/QOjNV2TR6Ld6KEmPxsH
 hxo6mIyohkdX8NJhlq9LtJBo
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 17:58:23 -0700
IronPort-SDR: B0Dre2X2HWlpFb2SMYbhNnBBgDbbR2MteGCkvMeYVk+pC0e1+fq6toF6mPYVme9Lpl657NLIBx
 ozU8s3Fe6wqCs/KfN2cKzD6YER3suVrhUXKKDk1ExgwyKlcfCrPDkvwvroK/tjnlFc5tKYurv7
 IY5XKkfknYvivRQ2/2hEx78SacjCOOmevtMESnA+0xNhUTWujsTpIZjx0RZAOWpf38s00KjUfP
 3sFnjOCaBW2wVw0Zrvd6r2WG9huCsrvmLZqbTkKmR+shSisS/vzzmg8kMDlNHrQMtvFYqwGZhB
 qPs=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 31 Mar 2020 18:07:29 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 0/2] null_blk cleanup and fix
Date:   Wed,  1 Apr 2020 10:07:26 +0900
Message-Id: <20200401010728.800937-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens,

The first patch of this series extracts and extends a fix included in
the zone append series to correctly handle writes to null_blk zoned
devices. The fix forces zone type and zone condition checks to be
executed before the generic null_blk bad block and memory backing
options handling. The fix also makes sure that a zone write pointer
position is updated only if these two generic operations are executed
successfully.

The second patch is from Johannes series for REQ_OP_ZONE_APPEND support
to clean up null_blk zoned device initialization. The reviewed tag
from Christoph sent for the patch within Johannes post is included here.

Please consider these patches for inclusion in 5.7.

Changes from v1:
* Reversed patch order
* Addressed Christoph comments on patch 1 (function name, inline, etc)

Damien Le Moal (2):
  block: null_blk: Fix zoned command handling
  null_blk: Cleanup zoned device initialization

 drivers/block/null_blk.h       | 29 ++++++++++------
 drivers/block/null_blk_main.c  | 62 +++++++++++++++++-----------------
 drivers/block/null_blk_zoned.c | 41 ++++++++++++++++------
 3 files changed, 81 insertions(+), 51 deletions(-)

-- 
2.25.1

