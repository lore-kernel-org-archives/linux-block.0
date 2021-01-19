Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04770C433DB
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 14:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3D9F2168B
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 14:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389820AbhASOjG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Jan 2021 09:39:06 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:36726 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387681AbhASJkZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jan 2021 04:40:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611049682; x=1642585682;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DFafch5BTaog8MQDiYUaO8Q6JsamXvW/VPMczSTt2iQ=;
  b=PcPGFAknhZq0lhMeRqpsi7jXRtL45zHjCgaXs+SCVhoqp3wUikqfYVUW
   fUTOmPml+Q/U06JxA7ZXLHsX9hYCkw7nglfWqyTKtlqqDPzX1Ye6paX0T
   JpY2eaXKE9J10HQ1aAhLAZT7EA62OjoGyYaY93VPHUPUxeguvaCKcXR7C
   t50fn2OmjrVJX/rLvvcIvh75nCbeMhcHbLVXQIlv55xnrSx1Yz21QLCMi
   mub7WfmPHpmwiHKt5GCQoDLIdx4kv+s+gM8ewiCP5RpAngzMzzFVI+xhE
   t9s13BywKUJEVD8DUq9IKAEs/PIuHH0rbRxzFwPT4vQFUFZOzIL+2xsFO
   w==;
IronPort-SDR: yQ09paun5v1GU2+28KtvvcM9bblDGOXpR8qSYtd8wR1bxuzeW/XpOdcXsEbUll6rS8Rr6mtPj8
 ckf9HqbHAoB6RJIp+oVXpVlLkhor7zaGH9oWMssecnidqcvx/uBuSENK3quW1IOehEbkmCyVEH
 2rVOnZhIPXiP3dErOx6shKSFSbe8PTudLSrMiYIGLSTj0SeVKWUT2QdrPmcIwwuoOKXKwdpur9
 bkj+11YYLGe7OKCzPVmG0tbNdF6q/1YlQTt9QnQcKYOe7IPKbFJOeWFPpUEVrCSNvRhqipk9G+
 /zo=
X-IronPort-AV: E=Sophos;i="5.79,358,1602518400"; 
   d="scan'208";a="261745160"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 17:45:48 +0800
IronPort-SDR: E5URkgUhRgNZQh6+MwvYsEIcetSDawXILp0fQIIYWVWUlier1VeDR03Tnyx/dsyCocVwSrfFoK
 EV87Zub1Ts+hEw3dLxmwbJJVeP3UPipbce8exCStqa8op/v6ecXoHgZV7KRdiK5vxtNneP6FGF
 aeJqDZhVybN2G06mER8Q8cQhPweIMvmuBsFWD2tkvTEjADEYEh4s0l6Bcvs6tbfp2JMhC4Tc8y
 rWnX8IQ2aTQiKTPz+CXO58l2qimIBw5Zq11szHPODB6tLK1Z1j0uU5Ws1BLgzeYSmlNFziVAsG
 G/vhjVyNYyowMY4KZzkuGMRV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 01:23:33 -0800
IronPort-SDR: o4Hf+aZCHvSX0GzWzoS0hfGnXNBr48tptqtVx+E0Lf/u7HhzeZa1oYQCWYhIwroMRk6EFXBHBn
 lwN+Ya+KfWeHkrnSugyRGF2f1KWUm+YNOz329z/x4liJdU5KcFTV4JjWzVgd0kUmBnRPKqLq5v
 PbCQml1VCU/va/K5H+RoKPD5Q4sdfztMpexVsVBOsxMYXk32epCSSi7JaXZ6jSNAzTBgtmwUoO
 SZO8VQqXrE0GW15KhrHXoJbsvYDT5egWa3iIQQQez+anHEgNq42X9Q5E4yeVCTRCOX1To382FV
 vIU=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Jan 2021 01:38:55 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH v2 0/2] block: add zone write granularity limit
Date:   Tue, 19 Jan 2021 18:38:53 +0900
Message-Id: <20210119093855.1633232-1-damien.lemoal@wdc.com>
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

Changes form v1:
* Fixed typo is patch 2

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

