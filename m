Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F79C433E0
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 08:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4391423121
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 08:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbhASImT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Jan 2021 03:42:19 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:1399 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730056AbhASImO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jan 2021 03:42:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611045734; x=1642581734;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZyW59Y/4aPsB07dZ8p1MGV7kgeKNiqtm1vyFwfX/XOk=;
  b=O0hQ1oNdqCawkdEV/8bMYSQWfmAumhQqAryN0Kq8My/wgKkMS7Eg5sAV
   /qG5WGYCIgYUMT2D9WokncbIKgPMYxCSfi0DZ6xZn4KWu8I6MM390pPW5
   4c7++9n435FL9fYqig7P1sYrOo3eaeiHX1aKBKije5gY0UVLaB+pIZGie
   LoInpR8MuIvTJ5OHgaOWFTUqwoIm4S8UihXLotPOiySJEzRG521g+u+4D
   j5eE6S2nPA78qQIeYlciFe+GOhlYrDPFPz3CktNma10Q6xlGaBxRV/4NI
   DO8+7K3z1aSxy6B9AbAPTRBJAgHd/PmZLEgQ4tPEU+cTjtf6bIBB63Tww
   A==;
IronPort-SDR: gmXeHHceS5TGc2HlBr52ZsPMdWxZBB29EV6xcIFtC0iJgWzWlJu+/Hl5RFrMqrKWRgamxGnLl5
 jLpQvCec5v0YEYIEeszkcJAwrgvoP3vCwPq7+adnF4rx9T8zwblL9aUxqdBeCDI6XYo2FzmbbW
 06fZC3SZdotPetfRsszxbwKdbQNk8S91Lw2TYnAq4SdGLQYNxjVpDixQ8xeUh934H5UFIUA5ZU
 erGArkLoZ73qx4+gmQTA1cCloooTECvo5MfZtlHORVBwYkOzxMtzR86eTin3+C187ccecWhM0f
 01c=
X-IronPort-AV: E=Sophos;i="5.79,358,1602518400"; 
   d="scan'208";a="268098203"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 16:41:04 +0800
IronPort-SDR: 61LLWfEqS0rSj89UjKrRq+XZ8LecIlT3eKhXVBnuK1vQwQzgUPP0P0R7B7KZbqm9ZgJUanNo44
 b5cdA7ILMm3jHaWQtQXXr3mTi8GjmRK0Kynlx0wf1t1lhA4QbVsZEBCIL8Yz85EKbMgkZZxjHp
 6sF8AQg7FYD5JyavUWE6J9nfUBwW9u4yn8fwA1ELfKZSd/szV2IG6CHYOCvBwh5PJvpKGYiKr0
 NuUX7+/xvsPhqTE3p5yD7QYENdVrF2QEstpCK6eV4NerieADGTII/1+S1Gn8YtnkEk7KK8gQiz
 gFpMPb+H5+XRkoijmNEPYZO9
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 00:25:41 -0800
IronPort-SDR: 9ezhJDvzZRHwwEpKlGuCO6BsTyD7rxCdoK7pZEVgbKe14sAvhSu6RdyrskoxteezD3WGJCMDdc
 YA8tYUATPiQRY4S2+Uow6leaoDbxIvDYyeAoVzD05PL31t+CvogBUT6xAH6mfwyHlPxczk4EhP
 D+fV8aQsN3ByMorepXmHBzlPxCoJ70kO6kMPKyitwL3vO8U6mCNbZlgN7I/XiRX21zJ0Z4iKMP
 6sy7mVc7aVONFL+JcJ3HeEQi/NWHWOm4lp2pSbYizNLV/je3+HBT6g7pEOhKpuATvfCIfT08uq
 t0c=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Jan 2021 00:41:03 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 0/2] block: add zone write granularity limit
Date:   Tue, 19 Jan 2021 17:41:01 +0900
Message-Id: <20210119084103.1631698-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The first patch in this series introduces the zone write granularity
queue limit to indicate the alignment constraint for write operations
into sequential zones of zoned block devices.

The second patch fixes adds the missing documentation for
zone_append_max_bytes to the sysfs block documentation.

Damien Le Moal (2):
  block: introduce zone_write_granularity limit
  block: document zone_append_max_bytes attribute

 Documentation/block/queue-sysfs.rst | 13 +++++++++++++
 block/blk-settings.c                | 28 ++++++++++++++++++++++++++++
 block/blk-sysfs.c                   |  7 +++++++
 drivers/nvme/host/zns.c             |  1 +
 drivers/scsi/sd_zbc.c               | 10 ++++++++++
 include/linux/blkdev.h              |  3 +++
 6 files changed, 62 insertions(+)

-- 
2.29.2

