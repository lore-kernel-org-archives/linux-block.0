Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D09C433FE
	for <linux-block@archiver.kernel.org>; Sun, 16 Oct 2022 03:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiJPDlb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 15 Oct 2022 23:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJPDla (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Oct 2022 23:41:30 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB293ECC9
        for <linux-block@vger.kernel.org>; Sat, 15 Oct 2022 20:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665891689; x=1697427689;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bVYkXO0Pav8ECsnmWzrLDFSISV+6oh/z+qqBFbGyMOA=;
  b=ML0/+grraWl7j2SxOZ7NYjJnMiItfcJV4GknJV3wf6LL10w3fXEXymMc
   /rVdfRHMnyc1HT8dc7hgIMhCHSEn076ErYN7w4pVpdkhzMzBA8d+Gmpgf
   to8gXvFAaF8LSzUr1KX51y/x07WWXwu8dFveMMibLQU06ZrIyCKRH39Ss
   QAjor0ZQB49VSBxRdgM0txG4J9unHV+Pna1yI8gcSfoTIbENtLFQJTBSl
   IWEIPiVTSEMeWhhEn2fpXRO9s+me+p6VipHJxLgA10l90WulEs8j0Bj0B
   Zry31KjkJw5LgjtXvGELMl1ueijZdNdrgew/KmC6KQf4YhopOljARQwBn
   g==;
X-IronPort-AV: E=Sophos;i="5.95,188,1661788800"; 
   d="scan'208";a="318226163"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Oct 2022 11:41:28 +0800
IronPort-SDR: fhyIe11YnYjYto1+95/rQM1ilJEJ+0eCOvx/DcN4OAb4Xor+EBwHXA/UD0/dseVgM6VvadbKel
 Ioz+HAlraCeGtEhgXcYzaM5r1kFrhJYLhYWKH+DNrVZTQz2uPzAQk18Dk6XgGiZWrj6BczvqGk
 uYZfMr5MR/HrQp4KTe5ge+DnyBAQqJidqkErh0cDpdU719ZKGHg9x7tmjaZneQ2npkwcXAkk51
 vfXZjIY8ApYImYgm8f33QfsNv2fQXWewypDa3XwClQybzCYrhKuu4cEsTrsfVeMvBQnOtHredP
 ywOQ8DGKICNPrfDmEayd3IKW
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2022 20:01:03 -0700
IronPort-SDR: zTokUW7F3S+cxu++6vqXd+qEZQcY8Ft5JP3N+BA6wTZYZ3MvafZVq9ghDzhBrIUmzquTODhg0i
 qWHRKihNJEL9X1tXJJZjBUsgehPyQCYGZcSVd72Bo91LLm9laiEY2+1NXqD57yV18G3MoNltrm
 hv+qn22PumX6L2UznobNkjUofG+9sfflR4C+9cHNcy72F9mEC6wE5K6TJeHoRRrZSo6BjIUqm5
 ZNjzREgDJh6CTPrXwxP3lQYItPxi+chQwZ8xb6Ox9Bbrryd8jymy/1SlN/fhr2X16ZWHyUXnzF
 uuo=
WDCIronportException: Internal
Received: from unknown (HELO oryx.wdc.com) ([10.225.167.24])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Oct 2022 20:41:28 -0700
From:   Dmitry Fomichev <dmitry.fomichev@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Stefan Hajnoczi <stefanha@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>
Cc:     virtio-dev@lists.oasis-open.org,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: [PATCH v2 0/2] virtio-blk: support zoned block devices
Date:   Sat, 15 Oct 2022 23:41:25 -0400
Message-Id: <20221016034127.330942-1-dmitry.fomichev@wdc.com>
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

v1 -> v2:

 - Rebase to the current head of development. The second patch in the
   previous version is no longer needed as the secure erse support has
   now been added to virtio_blk driver

 - Fix a couple of bugs in zone report code

 - Clean up ZBD probe code

This version DOESN'T include the additional request layout changes that
are being discussed at the OASIS TC. An updated patch series will be
posted to the list when those changes are finalized.

Dmitry Fomichev (2):
  virtio-blk: use a helper to handle request queuing errors
  virtio-blk: add support for zoned block devices

 drivers/block/virtio_blk.c      | 406 +++++++++++++++++++++++++++++---
 include/uapi/linux/virtio_blk.h | 105 +++++++++
 2 files changed, 480 insertions(+), 31 deletions(-)

-- 
2.34.1

