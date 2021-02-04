Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB033C433E0
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 08:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80CC464F51
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 08:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbhBDIo6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 03:44:58 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:58456 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbhBDIov (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Feb 2021 03:44:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612428291; x=1643964291;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lRG7ozepLLC6bt5QnpdRxt43z1rgVUFPe73F9c/HFFc=;
  b=f2eB6PeGhsppr+7EHPjBxNzBP7giFx7FIAJDD/aGW7E2/H99adeMbpjy
   cSEWxTilQSsLyTgUw9+8L2tXKbhu06ZN5GQXxhiVnVz3OJ111RqDRAQgG
   50QzpVlxv+eVrGGlai/G9wvLv58Pj75PV/mKYq2EotXJMmZB1kVGUXs+v
   250kFFWrAFdWYxBRR28QgRaoMzLvz75vz8ssr1dSTWoa5uQ/ggTLuK2M6
   YoShcWuNKHdpgH03FgGuLLqvvlCoEvuxNjSGseMu6f/rm/RZThXhhSQvX
   43cJssULLEzm0Q7SCsIL8VhUCGtKYCElL7ztFB3IYY7YJmih4C+epI+TC
   A==;
IronPort-SDR: zTBGSI5kHrIZ6qk0p5clesz0iOfeCoob/VHxiYUItEWLWJffWgWTGTDu+4HOkvZNaVFtY4ytYY
 1sozoTKGn/NvCosDfHPbAv9UrtSUey9RZosB7Qs+O1wq5zz/Cdy62W5jJeDgZY9yURTbaCPSpf
 bB1cfgI3gJ1cgM4K7TMZKx+8xP31SSKkqJxMCD2BgpLYR68LXW1cS/TWiSsAiYSYL90wltVCe6
 3nAb9r1BKIo4uCaG+Z03OgxuuX9fcVN3LsmAYBJYr6hHp6Eh/UBwAcBuv0P5bAT4H40Tl4ljrs
 +G0=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="160285576"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 16:43:45 +0800
IronPort-SDR: Ck/TbUIcEx6WQ9VNvDpGl9PKwX//gUwujRHIPsEuW7KjdZTSasOy44qM8ByPhyAhFb/3U6kRqW
 EMoxWXub5GjHw04BkaTDLFCLTgpQR0U9XTbWHf14ZOA5bQM+DgCe/TsHn7NPTzPiDkQUhczce8
 VvTrRj11j1FYF2z8rWhieO6ZGGQwdkCxpu6i59U4ImRfXwIq8Ac1LxhEHVkzZUjFoPAdNWAqjs
 24fWowfgsLH9wdfNxKcxjyuf+p2yEThetXHVdBNP1emuZ/bL1tNO9zHfJI+wnYp0Gj8IkQ00wS
 W9HcNSHILUzjgR9GmWTE/xd8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 00:25:48 -0800
IronPort-SDR: OPfK2fBtBLG3PyOssLmqIfOyCZEDycYYuJTvV8n3tPYdozer1cY4uiW4ffo0ix6xdfxfXuNJX+
 CaGtKgRwP6oI0mYOZ/8Df9SbpqFqkakgZDcrSc2n+ScSGg/lnAuKksirzB9tJei6WHMMQ7wQRA
 HEV6C+8a58duNJhKjCSBF9xu/8ucb/twdfG1p17jC/vm7kDENrBIMY76JNqkcyS/3kIDEpU9qp
 v2X+68sn8NvrOZJFA9BgY2jC2ogYb1pxELh9ngJdcYfYtrh5fwxB8usf5z2RG3EurkHSL6KRgB
 fXM=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 00:43:44 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>
Subject: [RFC PATCH 0/2] block: Remove skd driver
Date:   Thu,  4 Feb 2021 17:43:41 +0900
Message-Id: <20210204084343.207847-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Instead of spending time fixing the skd driver to (at the very least)
fix the call to set_capacity() with IRQ disabled, I am proposing to
simply remove this driver. The STEC S1220 cards are EOL since 2014 and
not supported by the vendor since several years ago. Given that these
SSDs are very slow by today's NVMe standard, I do not think it is
worthwhile to maintain this driver with newer kernel versions. I will
keep addressing any problem that shows up with LTS versions.

The first patch removes the skd driver and the second patch reverts
commit 0fe37724f8e7 ("block: fix bd_size_lock use") as the skd driver
was the one driver that needed this (not so nice) fix.

Please let me know what you think about this.

Damien Le Moal (2):
  block: remove skd driver
  block: revert "block: fix bd_size_lock use"

 MAINTAINERS               |    6 -
 block/genhd.c             |    5 +-
 block/partitions/core.c   |    6 +-
 drivers/block/Kconfig     |   10 -
 drivers/block/Makefile    |    2 -
 drivers/block/skd_main.c  | 3670 -------------------------------------
 drivers/block/skd_s1120.h |  322 ----
 7 files changed, 4 insertions(+), 4017 deletions(-)
 delete mode 100644 drivers/block/skd_main.c
 delete mode 100644 drivers/block/skd_s1120.h

-- 
2.29.2

