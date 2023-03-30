Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C35C6FD1D
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 21:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjC3Vt6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 17:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjC3Vt6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 17:49:58 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5142EE077
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 14:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680212996; x=1711748996;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0jtswxN3hsSDceTOf2N4b3K2UzfnilWL9rHq7cPJCic=;
  b=NL8y+Y+vU0dp8Z7C3iThmRLTHQapBL8BydnLyKU15ubNk4SI2Kutsl+O
   51R5Ve6AQQEbgjgIPChzPh0/4gw6aXHPGFUUO9vAlKUWVlvWzWCAj7NWx
   pTG1qR3P/S+uSb4DfSx188Uz32Zx5xg42r+PZkWkjCkVg0HXd0qfmKycX
   UKojzEwsXbSAT/MYykSgb8A2Svx5cMXI/SAaL13dsoPNXn9Ly8250D7ow
   OCVp9ZdIN9YiUzUZOlkgTEIejf3yDCHhYVAjTeIK/9X3wxbDKBAr8+DHs
   sRHu5bSwpVkhhU397O739mRg+P8nr3NUI69okl1BTxwLZhNOG/IZqgzvy
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,306,1673884800"; 
   d="scan'208";a="331371071"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2023 05:49:55 +0800
IronPort-SDR: KUodTOieg7vfOKP1bEPa6x/MFtPDBVydeGNYedXzF1jv32+aiwscM0uGPOti3JduGHp+WKZnlQ
 0pMIFTtsgJmOS19dtCvBMcoQWdD1ujvZutD+49rvl4ZDIzP8ZXRaiwy6CnRV1C+G6yLuWcdhVI
 W3hZY+7KLkxA/yHuJSdbds5NLtSRofN3NpxATnH3+t6xqRx2WjP8NF0hPsiUgNpQm6GlbOOLJo
 JJLqsM9CdArVgY4C5ICLkwHXRifPdWP7igPAhYxEirCnFyOe24Zryc/W5Zb58p73R75T9RYOsO
 pQs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 14:06:03 -0700
IronPort-SDR: 2c5NTS0AOs6wAOfyUADIPyFRkL7KPrDNHQMSh1BoOOoBcL7WAn+zk+sn2/b7QrHt9uaQkiQaPq
 jYfc5+nj4lVYZoItwDjJ/mC6ZR94CNGh/m102WqdxeUSwvfNZLanHET3qrN3VJcQbRab6qI3Tl
 hV+EjPG8g9qEsIwB+GLTPS+j/J9MffZz0jIePc5wM46nCp3mxLUGQjpoJPNVOksy6t/hQFd/kW
 wXCgRPXH8hz3uQ+axq5oR2uMRUzNl+VpwK5QMvqs7koy/6mICMSEAp6NqxA75YRL7wka1kCIbE
 +gE=
WDCIronportException: Internal
Received: from unknown (HELO oryx.wdc.com) ([10.225.167.80])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 Mar 2023 14:49:54 -0700
From:   Dmitry Fomichev <dmitry.fomichev@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Stefan Hajnoczi <stefanha@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>
Cc:     virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: [PATCH v2 0/2] virtio-blk: fix a few problems in ZBD-related code
Date:   Thu, 30 Mar 2023 17:49:51 -0400
Message-Id: <20230330214953.1088216-1-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This two-part series contains code fixes that are related to the
recently added support for zoned block devices in virtio-blk
driver.

The original ZBD patchset that was merged to the kernel -next was not
the latest and greatest version. The first patch of this series is
essentially a diff between the current code and the final revision of
the original patchset.

The second patch fixes a problem that is observed when a host-managed
zoned device is virtualized via virtio-blk and the driver kernel is
configured without ZBD support (CONFIG_BLK_DEV_ZONED not set). In this
case, the driver must not allow the device scan to succeed in order to
avoid erroneous device operation that may cause data loss. The
second patch adds this currently missing functionality.

v1 -> v2:

 - address nits from Damien
 - add Review-by tags from Stefan and Damien

Dmitry Fomichev (2):
  virtio-blk: migrate to the latest patchset version
  virtio-blk: fix ZBD probe in kernels without ZBD support

 drivers/block/virtio_blk.c      | 269 ++++++++++++++++++++------------
 include/uapi/linux/virtio_blk.h |  18 +--
 2 files changed, 182 insertions(+), 105 deletions(-)

-- 
2.34.1

