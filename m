Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4EAECAAD8
	for <linux-block@archiver.kernel.org>; Mon, 19 Sep 2022 02:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiISC31 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Sep 2022 22:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiISC30 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Sep 2022 22:29:26 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905DF14D32
        for <linux-block@vger.kernel.org>; Sun, 18 Sep 2022 19:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663554563; x=1695090563;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/XQCOl2utWd+jgu7MOnsQpjrFt9x3X8RjCgm+Nj8d4U=;
  b=qxur7IV+EzFOjX2dbsPWtuj42+VvXAW0lQksnzq/FXC5UHKGYSV7/z2R
   anndOigU3fh4gwOqHMswJAWbVDFmWZjecfGxzh1/NLJhBzIlnIG7/OuT1
   sT4Y+DRYB+7bVhKLLyU5McynMtHJjF6hzntggSkM2hbz+Uh3d7VAGCA3g
   PKgN4BxuFK7MdHDzo3jxQKVLv6v5bMXowebz5pQIgxrVpviFr27PIum+e
   oQaA97oApm1Ceku0ThX51mKLHlLt2E3/x0Ly9YKdkNKgxL0/rLycR1H5f
   Uxlv4A+9v6/kuq6t3cSGGNTLqmu/qc8FqGe8ESRlyYFbuiSNWxlaXavDJ
   w==;
X-IronPort-AV: E=Sophos;i="5.93,325,1654531200"; 
   d="scan'208";a="211668178"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Sep 2022 10:29:22 +0800
IronPort-SDR: yfXrnNKDDlx7nPZXfqmKqqV24jQ5Ou2t+HBc3Ws5MqKi0h1yPxKnm9y9yJGndd+3XQwdDMU8+f
 5aZyOl87w0ncreGbax2mTfjcHmBJMLhxpDq1yB/3cHe2NhtYX63wOShuRKAN9yALA14dbNhPKy
 1lrxTN3OAwHgMqH6JwyR3cFGpLqyQ4HJAtljHEEpQyhfUXWNM6EXJlib9YRseb10OXwZQOWHIv
 ZbC3BK31evczhLY/81YzM/4irWQP/OkLy5SMz6f8M1Ix/5fk/5wBjmHZ0D0yeRNHHZgCdrjQJ2
 o1vD034ElMm+0jZ037f8u5Ob
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2022 18:44:01 -0700
IronPort-SDR: +nK950VWFHWs3PTWOFIAVSrr8na9MuXRZv0DIaIHIiwHHqyjw4LBliQX49CXCKFYrDp7op0geK
 aP4RgXp9acv16CQzb/mKoVKzh/P/zKCQizQis3guxzczvgSnb+KS83YKDxoQ09Gp3PBjUoLUdu
 +Z/42Kr0oSyVvCfdSw0Pb7zIWALC0V1F0koCz2I//emxuKPVDQgwrfZiY4f5CB7VoyKdwRlQZo
 8kBxtAxH+hVnPpWGUP1tCYYLS0XMsQOaWHdrpDZwN65Y+KQMnrh/7mWROjLmnK1z2QTeaHAGAQ
 7bA=
WDCIronportException: Internal
Received: from unknown (HELO oryx.wdc.com) ([10.225.167.110])
  by uls-op-cesaip01.wdc.com with ESMTP; 18 Sep 2022 19:29:23 -0700
From:   Dmitry Fomichev <dmitry.fomichev@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Stefan Hajnoczi <stefanha@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>
Cc:     linux-block@vger.kernel.org, virtio-dev@lists.oasis-open.org,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: [PATCH 0/3] virtio-blk: support zoned block devices
Date:   Sun, 18 Sep 2022 22:29:18 -0400
Message-Id: <20220919022921.946344-1-dmitry.fomichev@wdc.com>
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

Dmitry Fomichev (3):
  virtio-blk: use a helper to handle request queuing errors
  virtio-blk: add a placeholder for secure erase config
  virtio-blk: add support for zoned block devices

 drivers/block/virtio_blk.c      | 410 +++++++++++++++++++++++++++++---
 include/uapi/linux/virtio_blk.h | 109 +++++++++
 2 files changed, 488 insertions(+), 31 deletions(-)

-- 
2.34.1

