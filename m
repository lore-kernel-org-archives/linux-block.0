Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFBCC6FD1D
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 02:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjC1Ca4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 22:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjC1Caz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 22:30:55 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01F626B6
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 19:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679970627; x=1711506627;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NZtcWNsburRZC8IZqplWt8BGaXXN2Rk1N0UpCveBSUA=;
  b=Yjro/2vzc/ikbZGi2ThvfcEMikBbUoKw4TI3mAHQQIiSzjcZJHmE6Ldq
   7zxGcseZtyPhSjksLGg7NIzh8KKRzWsSl42ByWhsG3gJ2hyrR3z/BUpqN
   tobsRYAMFiTIv/l67bJtZs5YH7asGBXdRCpLsFAO0X59CgEF5Z58MLrfs
   uzM3iui24bNsEfTqNnHv7wiXTnjIHl4/B+ClAW63VvKx9Uw7o388vszFo
   0WyBbP5qLDsHdAjDsSCrw30lpLMAGU2spfzRpcYw6inx3EzTbKsWay9c6
   GkpIqZUeGlHUWllgpkyPfgQ0NYhe61c9WOZFw3PGHfqoKQvGxBRCzyYE9
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,295,1673884800"; 
   d="scan'208";a="226460229"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2023 10:29:32 +0800
IronPort-SDR: tQJAqlq/QPAO2X+2xIGkBfRvqZ608mMUyO4gOXijwwWkv+6Oss2K1iuJKNNkonWI3SdNGBLuyV
 MkHgp2NT6Ny/zgiNWBSHbMc+B4Co8YKelQeQjxXauZKR0+QELJQFE5GIe3ZWn4ONeTm2sUn/w0
 Vye+i7uS9WT6sWQvSvTMSDfZW4ybPuRq7B+00fEngJMU/d/BfuUG38oSFADY7EBxeu/NKaaFUQ
 Tb52ZesxQ+h/wcO2EjPdS3DJ6NXzytLAAXcaQFi4Jzda0i1lJrxyUgklZU15+nJCPKHzUVVGyN
 GP0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Mar 2023 18:45:43 -0700
IronPort-SDR: gdiKj1A7cHqqjia4MjqjvtsIhfWj27XdYBOV4aWrKa7/EvJIiZ6FW1NSrrL4AzH3MxGXeIMBjd
 hVwkPKL/QHR2yNKXmp8UlN0gdZ2rSc796eCeWVPQHMnEqO3f+PGGUF3aUMPqr2wypv1g9XhgYJ
 GcWWQYEPpYb8FdlVJEQTgRJYUiYCSQ53LBMcas7yahoTNPcsIbtw2sbDYr0aFoMgh8ttoJ8Ggj
 hlSooQDwkZu6HDwvkVf7tmXf/zo2jy4xPye1MelyVTHsYVbojLSAzsTPvmlxrvHr54a7oZGgZE
 GOw=
WDCIronportException: Internal
Received: from unknown (HELO oryx.wdc.com) ([10.225.167.80])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Mar 2023 19:29:29 -0700
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
Subject: [PATCH 0/2] virtio-blk: fix a few problems in ZBD-related code
Date:   Mon, 27 Mar 2023 22:29:26 -0400
Message-Id: <20230328022928.1003996-1-dmitry.fomichev@wdc.com>
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

Dmitry Fomichev (2):
  virtio-blk: migrate to the latest patchset version
  virtio-blk: fix ZBD probe in kernels without ZBD support

 drivers/block/virtio_blk.c      | 268 ++++++++++++++++++++------------
 include/uapi/linux/virtio_blk.h |  18 +--
 2 files changed, 181 insertions(+), 105 deletions(-)

-- 
2.34.1

