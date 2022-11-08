Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F784C43217
	for <linux-block@archiver.kernel.org>; Tue,  8 Nov 2022 04:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbiKHEHY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Nov 2022 23:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbiKHEHX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Nov 2022 23:07:23 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC40FD88
        for <linux-block@vger.kernel.org>; Mon,  7 Nov 2022 20:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667880441; x=1699416441;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1R8dar92hT840ngUqhG6Zc2KHPoZV/Rc8i6ofSWNqVw=;
  b=GJRb7pJRKd7B/WtYmatsGGl5fvIW//DqEKwJdgPITyGJI+jpUx1KvP3B
   mZcWEtXGwdfjiyjAc3neJGMQaDEaWgpQuto9LFS0MOVWKF80mdWiSrI75
   gpZFQQ1XO0+1hnZSBhFFTis144+CKAD7c41EQkKLJIZy6tQ7o4HLtAVhc
   r7CIqXaddO/Mb2++N8X3hwSbBlmLJE3rh7V2V5MDxG/GPe+y6xoL2VbXX
   f2OrtcSTYz6de+B9FlbLhRKN+NSXgYqCrkzDDhUMsplmZi6Za3DYn5gAZ
   LfEwHTs6m/jkadTc5MGchiHEbX1x69wuVcRS1VU2KpUw8Sry5VRHdwzjS
   w==;
X-IronPort-AV: E=Sophos;i="5.96,145,1665417600"; 
   d="scan'208";a="327825121"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2022 12:07:21 +0800
IronPort-SDR: OeIE+hmT0TWZqFXx/tQCUJMPxP8wG8chsDVuhLfqsARZcT6hXIqm+E+jECKHY5gHctmNydgqlI
 f9ytHGqiNu7tlbn4Hn4bF04Boc2zLNfj37n/Btg6ffJDWJymFAWISbuhtuRL6tmVCYkN1nyqZz
 pseNwUb2ynVNJ5LNJmKdkOZfEbx+nE2DMj0VaMI6vuAzcu+U/fZdxhz8FhRhLMXitzVIn2CoR8
 m4x7eE10C7Qajafn8qcxOnZAUEmPTbmWMfOdtIn+Q5MbEl9eF4hVjUCNzF1k4EWu0UBebTICnQ
 UUY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 19:20:43 -0800
IronPort-SDR: Lv9nzOngWFbAlnCBllbS+uQ4taLnibbTQMwEs+hxsXNQMEZqUjvA7zw5TcHz5MgLjYiMeAahIp
 6xMwmHLI/1bkKfWO/Kz4OURDXHr+gR8v6nB4beqlzCFybmoEvD5c1BvEv/P+R8tiqUDspnwEiz
 WHhNQbKMOMBcNzb308UBZ4/yrmUcBbBto4Sihobk0cIs+l3l+HIQGU8WyJpePZGmafrAPibqLK
 q87QqchZwBFAzyMiSGv0HPSRbzhi6ihfNiHwRGjPFCs0yOr9ezdfppa+TF43HHgl1JRwHSvB+J
 seo=
WDCIronportException: Internal
Received: from unknown (HELO oryx.wdc.com) ([10.225.167.43])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Nov 2022 20:07:20 -0800
From:   Dmitry Fomichev <dmitry.fomichev@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Stefan Hajnoczi <stefanha@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>
Cc:     virtio-dev@lists.oasis-open.org,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: [PATCH v5 0/2] virtio-blk: support zoned block devices
Date:   Mon,  7 Nov 2022 23:07:16 -0500
Message-Id: <20221108040718.2785649-1-dmitry.fomichev@wdc.com>
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
community mentorship initiative. The latest versions of the QEMU
patch series can be found here:

https://lists.gnu.org/archive/html/qemu-devel/2022-10/msg05195.html
https://lists.gnu.org/archive/html/qemu-devel/2022-10/msg05205.html
https://lists.gnu.org/archive/html/qemu-devel/2022-10/msg05896.html

This patch series modifies the virtio block driver code to implement
the above virtio specification extensions. This patch has been tested
to be compatible with the QEMU implementation referred above.

v4 -> v5:

Address review comments from Stefan:

 - Take vdev_mutex in virtblk_report_zones() to prevent a potential
   race with virtblk_remove()

 - Check the current zoned model in virtblk_revalidate_zones() and
   reset the request queue zoned model to NONE if the reported model
   is not VIRTIO_BLK_Z_HM

 - Add the comment in virtblk_parse_zone() explaining why sanity
   checks are not needed in that function

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

 drivers/block/virtio_blk.c      | 488 +++++++++++++++++++++++++++++---
 include/uapi/linux/virtio_blk.h | 105 +++++++
 2 files changed, 561 insertions(+), 32 deletions(-)

-- 
2.34.1

