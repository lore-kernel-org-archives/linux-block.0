Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC33C4332F
	for <linux-block@archiver.kernel.org>; Thu, 10 Nov 2022 05:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbiKJFj7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Nov 2022 00:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiKJFj5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Nov 2022 00:39:57 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A272A976
        for <linux-block@vger.kernel.org>; Wed,  9 Nov 2022 21:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668058794; x=1699594794;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S6VxSc7VuEXEVSdhHdVtrdBd3Mgj/I+9nvadV99slAg=;
  b=KgVzt5m/LRzAvJXVdMECRmn4L4jSKOymWSql9ds7o+VNhNg1//u69Mez
   9jcLBD95TqWuiw5y/cRClEUDrIMppn0R+/nD7Q88s4Fa9IvcerF+nTJuv
   mcMi/+cAQeMOdJOlMR4rxUEore3kPB6bVdMUge3McCVI+RLni5e9IwVji
   RCU6204tUmwWiMhGSgMH9D1T+sCZRCVuexgHSznZQnnLm3iZxIqMjU1Gf
   8PUkpn5ZzclaWjEKXP9Qd2/fUWK2TrIMpUDaumJbRd8RC9PirtWLxj1hd
   aGpQL0mMNJk9nvQRSTQBECITxtrnl/dFOMLkv6SDuYiYC6J4dFHpxH3pN
   A==;
X-IronPort-AV: E=Sophos;i="5.96,152,1665417600"; 
   d="scan'208";a="320264544"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2022 13:39:54 +0800
IronPort-SDR: Ty87ZKx6mtB3QLuEIMokxytgh6leLxYhFlOy+2gaSks3GSVh7fvAPWZjg7GHKT582wOlPQ4+wh
 qkg+sIQ04BEmGKMveNviDslfRYJomH/x7zC8mtWd8rXp4KbFWbIMflmXB7pcGrOelpY5mDStss
 iBTrSqU93YueNm0AeCm61P4cdXITaB56QRQSMAUJefi8sJ2wMjc6JxyQhQkXJA0Wu68moLzder
 Rdiik7Q1Lw+anpBM4wmGhUZ3nqHTSSScSvKTPTggVT3JgijyCFI1osS0T2uiKr1TS6Z8fHUo3A
 MI4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Nov 2022 20:58:57 -0800
IronPort-SDR: NpDQFaQ4huYOYUhO42GJkkSOzSQSD+lLwnkMyd6j1Y28DiYFiFydWu2AWNqHlLDp4xdFBLrEPr
 RIYSPAZEcsfy2yuEMUsiqitWDQrQFYdMfqkdEURlBPY0iJBM77WJ+Esi+2FTv8uyXVfing0p3Z
 4+jjeULstlkpIrtfzsjX9wCfBMUX6JGBuxAEst/lGZGixOhcqegB51sEUgHQBThM7x3gk74tQA
 bKXH5a7atxg5X7jkTdpFa7QkOC108ZoIZqDdtNDqjgyVWgoFcAGKUlZf625eW6z31iHdJtjau6
 kKk=
WDCIronportException: Internal
Received: from unknown (HELO oryx.wdc.com) ([10.225.167.43])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Nov 2022 21:39:53 -0800
From:   Dmitry Fomichev <dmitry.fomichev@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Stefan Hajnoczi <stefanha@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>
Cc:     virtio-dev@lists.oasis-open.org,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: [PATCH v7 0/2] virtio-blk: support zoned block devices
Date:   Thu, 10 Nov 2022 00:39:50 -0500
Message-Id: <20221110053952.3378990-1-dmitry.fomichev@wdc.com>
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

v6 -> v7:

 - address nits from Damien

 - add Review-by tag from Damien to the prep patch

v5 -> v6:

Address review comments from Damien and Stefan:

 - Correctly calculate the size of the runt zone (i.e. the last zone in
   the LBA range that is smaller than others) using the device capacity

 - In virtblk_parse_zone(), make the write pointer invalid for offline
   and read-only zones

 - In virtblk_parse_zone(), return -EIO if the zone type or condition
   is invalid instead of -EINVAL. In this case, the caller's command
   was valid, it is the output data that has the error, hence -EIO

 - Do minor editorial changes - make some comments more clear, rename a
   label, etc.

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

 drivers/block/virtio_blk.c      | 486 +++++++++++++++++++++++++++++---
 include/uapi/linux/virtio_blk.h | 105 +++++++
 2 files changed, 559 insertions(+), 32 deletions(-)

-- 
2.34.1

