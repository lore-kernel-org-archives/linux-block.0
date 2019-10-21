Return-Path: <SRS0=zBYI=YO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D18CA9EAB
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 03:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736EC21897
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 03:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="o6Rfuj/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfJUDkG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 20 Oct 2019 23:40:06 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24472 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfJUDkG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Oct 2019 23:40:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1571629206; x=1603165206;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WJEGpd+ywZaD46TzXGOA/TeCfi7lQNbKZqAysZjGAAc=;
  b=o6Rfuj/S4P0+npNSXQ3mR/ZDudwXpEk8F53FGjJFiqtl1UKm4a0lnX10
   jxfFeYMIw8CBgoAkP35oqlpgwBcvoxUM8Sbdijr1+KYdtse4QuBVrvKu3
   0wELnvjCccZOLsH/+yhshbiDaII+3TvLelWyI5tEEpcMjonssIQKdmXjO
   rnUDaE7tozEeVUB+vVQG1+CNXLHGfXhjFKB8Muxw1o6/3DFHszGJK4tdf
   2HCK9TY3GKZ3BTMf00WFYYw7dDunch7wVoVKgDLC/SnsHpx53gv8YG9KZ
   pMXilwtns6qM60gP7EvcgIjrDHicVnv+RP4xQ/Cq3gxAJ/aPHzVuU+Kf2
   A==;
IronPort-SDR: cBxXHbkINcpdfjzg98IYJxX6guUATdegriUXv95hxWObqpRfcFJMzqjnsb1xnmQCt5YuczOLa2
 UzaP54SbMNNPdu8UQfvVNla7vGS2J0/gr21cHHeH6VwMCqdo4TmcFl2srJcxZLky5VkOSsdnsJ
 6DMdz5Hp8IW4KcwjJArKeMSAieIhTksqo4VFp/NwpIv3aEaT+9m9+zruyQDW78Cu9IjblakpR1
 XeQY9ozMdbhV2vcqIxnac0fON183MkXSB4LcuQWUeVLru5bosjEogArMm9yQPX4UlFtj1nUBx7
 iU4=
X-IronPort-AV: E=Sophos;i="5.67,322,1566835200"; 
   d="scan'208";a="122530387"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2019 11:40:06 +0800
IronPort-SDR: f5Za42IYVpteEc5NtNVcuiPu902LcQEzaJpJUuLPaSitLsV6Gi12lYbocmUuIUeBNYT3Oi59YQ
 dD/WWay7FTLM2j9ImlpIctj1txVELLiq5BaYILbH6XECgogBgNBkHv92vrK2Ldm9EeK9iu0Id/
 47YyUvBH6UTX3PLZC/IyJbJOVyDYzoRIJeA1QGe7Jotkh4vFbQfuTX9aIpCgXsaHipByNX8MSI
 H5syh092VYdE6egXDCqUGwtvQgkWo1OIy9Yz9jvo1dFFHo3SKWnIQ7sxsCWsbnbzcV46b3tl2N
 mhWE/nxj+LBSlIHAxPehEo9J
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2019 20:35:46 -0700
IronPort-SDR: EkYjvAzY0e43/0OUx2fAj15cX+vIhJs6cTL8yMDaY3WJqgYyghyPvh+mgN1GGAjRYy0b2GNq5Q
 xFxoaUAUXrg/iERWdA6IUSARg4u1RVxL+z0s1bHP6RAba251BSdoKjYk4mI9gt3joQ6wp4Dxmx
 UZRjPtSnln1R0i7gTW+Gu8+vK4x069o1hPsyi+Z6jxR2hzNMuThUqBeVfUVC6r25GCLNu832aV
 v9zm6gZvcCXFB1eGXyuD7pP1IxJzc4UB/OZYlltu3bgc0Tcl1S20jz9OKkZ352A3oGr9/GkII/
 Oss=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Oct 2019 20:40:05 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 0/2 v2] Small cleanups
Date:   Mon, 21 Oct 2019 12:40:02 +0900
Message-Id: <20191021034004.11063-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is series is a couple of cleanup patches. The first one cleans up
the helper function nvme_block_nr() using SECTOR_SHIFT instead of the
hard coded value 9 and clarifies the helper role by renaming it to
nvme_sect_to_lba(). The second patch introduces the nvme_lba_to_sect()
helper to convert a device logical block number into a 512B sector
value.

Please consider this series for kernel 5.5.

Damien Le Moal (2):
  nvme: Cleanup and rename nvme_block_nr()
  nvme: Introduce nvme_lba_to_sect()

 drivers/nvme/host/core.c | 20 ++++++++++----------
 drivers/nvme/host/nvme.h | 15 +++++++++++++--
 2 files changed, 23 insertions(+), 12 deletions(-)

Changes from v1:
* Renamed the helpers to a clearer function name.

-- 
2.21.0

