Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDAEFA373D
	for <linux-block@archiver.kernel.org>; Sun, 30 Oct 2022 04:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJ3Efu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 00:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJ3Eft (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 00:35:49 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FD345997
        for <linux-block@vger.kernel.org>; Sat, 29 Oct 2022 21:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667104548; x=1698640548;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JScio7f/OBBoidzqQ894lWBiCLN/yyC4zKi0V8DA59I=;
  b=TVWqv+rKPUXIv9EgOJy/goFYjfyFRRPsj6Btk3S6/DDg0JTdd4hAqU9R
   g3T+jkJfRA2C9iCpIr4GvslDKQkwGNd/BFc+tX41MUFJrJw1Isbz12Tj7
   QxDXYYsHYDU7jLOjBuKGyDCt62qY7ZqPqPs/4qYqhMH6sULc27VSIIXT/
   kaL74DyCVKH3f6QZrkTEvASKd/gzXz1ZGhJiTni3Pcw+GCByAyUKp2SsR
   XikPW+OlnjBmt6gpKL7gyN/1KNTMzgGE7OxRU6o0+hgfA8vZFcVLLKlO/
   S9IKVVtuEcfxLN5Qhuht26SJl2ZY0CCUn3NamNu3BXSrbBiu9dpkCEP6z
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,225,1661788800"; 
   d="scan'208";a="213350175"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2022 12:35:47 +0800
IronPort-SDR: 4aR4b/KszbIA7Oak9TkMcVknSqVCKTSf2A2ZUY+ONaKYwsfZU2kbfY3jxKxzA+WxlaWCkZv3tU
 fbX0P8IsL74RiKByf4FQP1/3da1yN8CxLTzO1B+CWgUePpVGhfNVmu4yMC9mMS9cK6EYGD5Xpw
 N3tKGFdG1tVNg2rB+6eA2ugFjnEiSvYuww8xgTpmA/vsfKeHPVfseR+Lv/OR4nybsUI9G6mTIQ
 ZCxFHXg6vFsiIT6udpBSBRcpPCWidCmtevkbPBMl24IQlv0k6plMRlBwdQHK7K/RNgNdyf/i+W
 JmxHU/TdxHfKe+e2cCtA4bk/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Oct 2022 20:49:21 -0700
IronPort-SDR: p4FwYfk3E9+eJxOEBqvfGt4WzYBIjIdejng8LWrE2t60OIm5qf2w5ILI7WgMzAMuan8Sc5uW84
 hy6nNzetnOjqhnLoeOZz5V0oRhbZdXiAmyksMPZ1OtuaqQDhjeYUa+8rx19egZ89R6lAW8kOFf
 7XesGh4NABE1Ghh2Yv/5x5PmIZcEhAGaeC0v/fuZCxdDiQfc76IU7ddJFrC6SAwEC4Vizyt6kk
 dCZi5WmaSfQBSoX6o69fg52iFjLrVS/2EZEyWWFF5amtdnWki4MnNejVPntYSUFhof4g8anRBA
 2QI=
WDCIronportException: Internal
Received: from unknown (HELO oryx.wdc.com) ([10.225.167.43])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Oct 2022 21:35:46 -0700
From:   Dmitry Fomichev <dmitry.fomichev@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Stefan Hajnoczi <stefanha@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>
Cc:     virtio-dev@lists.oasis-open.org,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: [PATCH v4 0/2] virtio-blk: support zoned block devices
Date:   Sun, 30 Oct 2022 00:35:43 -0400
Message-Id: <20221030043545.974223-1-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In its current form, the virtio protocol for block devices (virtio-blk)
is not aware of zoned block devices (ZBDs) but it allows the driver to
successfully scan a host-managed drive provided by the virtio block
device. As the result, the host-managed drive is recognized by the
virtio driver as a regular, non-zoned drive that will operate
erroneously under the most common write workloads. Host-aware ZBDs are
currently usable, but their performance may not be optimal because the
driver can only see them as non-zoned block devices.

To fix this, the virtio-blk protocol needs to be extended to add the
capabilities to convey the zone characteristics of ZBDs at the device
side to the driver and to provide support for ZBD-specific commands -
Report Zones, four zone operations (Open, Close, Finish and Reset) and
(optionally) Zone Append.

The required virtio-blk protocol extensions are currently under review
at OASIS Technical Committee and the specification patch is linked at

https://github.com/oasis-tcs/virtio-spec/issues/143 .

The QEMU zoned device code that implements these protocol extensions
has been developed by Sam Li, an intern, as a part of Outreachy
community mentorship initiative. The latest version of the QEMU
patchset can be found here:

https://lists.gnu.org/archive/html/qemu-devel/2022-09/msg01469.html

This patch series modifies the virtio block driver code to implement
the above virtio specification extensions. This patch has been tested
to be compatible with the QEMU implementation referred above.

v3 -> v4:

 - Fix the units in max ZA / write granularity check
 - Remove unneeded dev_info message

v2 -> v3:

 - Change the request in-header layout to always make the status byte
   to be the last byte of the in-header. For all requests except Zone
   Append, the in-header consists only of the status byte. For Zone
   Append, an extended in-header is defined that consists of the zone
   append sector followed by the status byte

 - In zone report handler, validate the zone type/condition values
   that are received from the device and convert them from the values
   defined in the virtio_blk ZBD spec extension to the values defined
   in the block layer

 - During ZBD scan, check that max_append_sectors is not smaller than
   the write granularity

 - Fix sparse warnings

v1 -> v2:

 - Rebase to the current head of development. The second patch in the
   previous version is no longer needed as the secure erase support has
   now been added to virtio_blk driver

 - Fix a couple of bugs in zone report code

 - Clean up ZBD probe code

This version DOESN'T include the additional request layout changes that
are being discussed at the OASIS TC. An updated patch series will be
posted to the list when those changes are finalized.

Dmitry Fomichev (2):
  virtio-blk: use a helper to handle request queuing errors
  virtio-blk: add support for zoned block devices

 drivers/block/virtio_blk.c      | 467 +++++++++++++++++++++++++++++---
 include/uapi/linux/virtio_blk.h | 105 +++++++
 2 files changed, 540 insertions(+), 32 deletions(-)

-- 
2.34.1

