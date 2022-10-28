Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD813C38A02
	for <linux-block@archiver.kernel.org>; Fri, 28 Oct 2022 04:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiJ1E2Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Oct 2022 00:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiJ1E2Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Oct 2022 00:28:25 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDDD17FD45
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 21:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666931304; x=1698467304;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m1/Q6AOZejLjFKgDA0ttgklrpuRErUqL4jirnvcJ3Dc=;
  b=i5t7L/d5A3JGtj8t/T54s9t3npv4y6HGAhlUuWjYFdVjmQVK+hCfEuZc
   dl3+oT9YtlSk9SdKxW0O7RA3ELSFRLcYmPDq5b+M7Tva9T14uLSn/xMbj
   m5rDr+PZJ41g1lJm1jdR19KhRf62/T0C5rynFAcPCekxpTS0vJXXygRPS
   8R6DpBNRE5p09eY9l4ZzotlgntnjUORAH9eZdMh0nBERLsTdteSSitFBx
   YYfpXGb8T1wSjQF/Xwa7K3hRCP4uC6620ctFwuTaM5+OyyaxgWJaEVA5P
   VFU2cV7jshlob0n0Tc07qCKEH+HmHjQZ2WH012KTK2tDg96LyMvVMpGPc
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,219,1661788800"; 
   d="scan'208";a="213236256"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2022 12:28:23 +0800
IronPort-SDR: 5i44s/FKYolH01nQzEuyvaa10s7VvmDE9NGwGld+fjDU2lOWJGUaXhgQMMHDNJh4e9IW/TYjzz
 h8w0FxiFBtygQeRY9/BQ5OCbjhaLPhWoiOTwqddx/NYxMHBniHn6vEVwJY3OrNU7oyjijvMBHq
 RvMVb2uPuXdLHoBiL19Glg/6m3Q6MQ+BvmbQ8Ba7LfnRbu/FI56GX/shZz8aLg4CrpyAdnsGOj
 cTA9OhGaRtWgvBuxeMuEEompn1uDhvL/fRw0gh2SKco9jvw4gCLdtZUVP2YNtKM7lAZwUrdPil
 g27t47IZv9pPlao/FD++Ncqh
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Oct 2022 20:42:00 -0700
IronPort-SDR: izdawjAJ+Nxsctm2mL52HJyfNfIi0vF0f/okKchMzdRGPsA7NbFh/ygprq6iM+Jr/iU+nPGiRv
 WtFHam9hrUDtVySR3Th7wfgqGPdnWSwBQPppVdp7bfZyVEVq1SoBuweINGWoHRs1VCBUh9D+Qe
 V8E6csPec+/hveQtFbjF01QDRtWdlpAtdUgMk0mfoCvAegQajYZmb0ZWnVUB80oF8hTbkvl3aR
 0B9oYpnfwLjYFrVo3JMZTyJSmF2spr5Keiu5GmJWtOVDQ5g1gxIZsp85LDiUeNQGAUNgwCu+Ep
 A6s=
WDCIronportException: Internal
Received: from unknown (HELO oryx.wdc.com) ([10.225.167.43])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Oct 2022 21:28:22 -0700
From:   Dmitry Fomichev <dmitry.fomichev@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Stefan Hajnoczi <stefanha@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>
Cc:     virtio-dev@lists.oasis-open.org,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: [PATCH v3 0/2] virtio-blk: support zoned block devices
Date:   Fri, 28 Oct 2022 00:28:19 -0400
Message-Id: <20221028042821.921403-1-dmitry.fomichev@wdc.com>
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

https://lists.gnu.org/archive/html/qemu-devel/2022-10/msg05195.html

This patch series modifies the virtio block driver code to implement
the above virtio specification extensions. This patch has been tested
to be compatible with the QEMU implementation referred above.

v2 -> v3:

 - Change the request in-header layout to always make the status byte
   the last byte of the in-header. For all requests except Zone Append,
   the in-header consists only of the status byte. For Zone Append, an
   extended in-header is defined that consists of the zone append
   sector followed by the status byte

 - In zone report handler, validate the zone type/condition values
   that are received from the device and convert them from the values
   defined in the virtio_blk ZBD spec extension to the values defined
   in the block layer

 - During ZBD scan, check that max_append_sectors value that is
   reported by the device is not smaller than the write granularity

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

 drivers/block/virtio_blk.c      | 470 +++++++++++++++++++++++++++++---
 include/uapi/linux/virtio_blk.h | 105 +++++++
 2 files changed, 543 insertions(+), 32 deletions(-)

-- 
2.34.1

