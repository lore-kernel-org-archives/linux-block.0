Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F299C64E90
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 04:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A69520796
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 04:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CmbRPGUP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgLAEPZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Nov 2020 23:15:25 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:30265 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbgLAEPZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 23:15:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606796124; x=1638332124;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MOTxPr/dXMgLtBMStLftu/Vxq96/Hq6WbEO0PU2Kb70=;
  b=CmbRPGUP4XR/6L8SmMB6SiyWv4Zjk/YIY6bWVEMWn2fPKHZdH5xGO3hF
   x9ahCt4rsJODtgyWAK8KbsHN+r6wioVB3QjMQ3Adsp3mAH6p/jebIDAvb
   62bGgwe+uOxGL/ZFQPDtLb6Nwl1iByP3WRIDzSpI/kfMvotaVU0xP6Tne
   sT6INPRvX9IXyGgrM7cX23+ZHrcUVdP0l7rhHF71a2smwekNsunJVX5dp
   7eadHbdoJAeUJNd+LEPC59aVhC+GOYz4g/0VIsOvqwBUHcZVZtz7172Gd
   0rAttKULTIThup6jsbyK1b1IbixPWqc1C7kSOai3BaRsVeATdoOWZgXBk
   w==;
IronPort-SDR: Gm6PLUJg5F2jz/C8uPX+jQ0LSrjnjfF8JR/IJ5cS51QkAz4hlK0hq2En2fo0Jc4IY8+c4+fawQ
 gfjeYiDTlnj9QFayWhh8I/k/TbEeTAbFCUarxIeETH17Z1r8tWaU85t7jrS4u/G+RO4s1vWaDM
 h81CCcLB6DnMKlsODRCdh+RVAWx2C8eTirlLKzPKkVaaTFw5ceNgmfWYzm44fZofxpCs5mZEmj
 DXJZqlJg9cGcw6N5BSgUIcJAmZs/P227mrijGs3qQPtp5HoZXC4gaPHWrVA2fegk9P6qNogukz
 V5w=
X-IronPort-AV: E=Sophos;i="5.78,383,1599494400"; 
   d="scan'208";a="158346929"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2020 12:14:18 +0800
IronPort-SDR: wkIG09HqcM1e5hiZZGGADtZKP1qo4koLzARDkW9cl2WB6Q5OCOLkXEBPdCw0EtDHxVi917pLoK
 NIn5nPF2n5cG2hjle1BvCZ7jD2nDNRaFg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 19:59:54 -0800
IronPort-SDR: rhBiVjv6fnsLtyA/uGzSf/ajn7O3Zpx7MR7AAs5MEDA/0DdCmclz9R+JFlw/7DX+agZfERC698
 ESF5EDn2lZzA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Nov 2020 20:14:19 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V3 0/9] nvmet: add ZBD backend support
Date:   Mon, 30 Nov 2020 20:14:07 -0800
Message-Id: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

NVMeOF Host is capable of handling the NVMe Protocol based Zoned Block
Devices (ZBD) in the ZNS mode with the passthru backend. There is no
support for a generic block device backend to handle the ZBD devices
which are not NVMe devices.

This adds support to export the ZBD drives (which are not NVMe drives)
to host from the target with NVMeOF using the host side ZNS interface.

The patch series is generated in bottom-top manner where, it first adds
prep patch and ZNS command-specific handlers on the top of genblk and 
updates the data structures, then one by one it wires up the admin cmds
in the order host calls them in namespace initializing sequence. Once
everything is ready, it wires-up the I/O command handlers. See below for 
patch-series overview.

I've tested the ZoneFS testcases with the null_blk memory backed NVMeOF
namespace with nvme-loop transport. The only testcase is failing in #12
on both null blk and NVMeOF ZBD backe by null_blk. 

It uses invalid block device to format zonefs and doesn't do anyting
with the input device, still looking into it.

Regards,
Chaitanya

Changes from V2:-

1.  Move conventional zone bitmap check into 
    nvmet_bdev_validate_zns_zones(). 
2.  Don't use report zones call to check the runt zone.
3.  Trim nvmet_zasl() helper.
4.  Fix typo in the nvmet_zns_update_zasl().
5.  Remove the comment and fix the mdts calculation in
    nvmet_execute_identify_cns_cs_ctrl().
6.  Use u64 for bufsize in nvmet_bdev_execute_zone_mgmt_recv().
7.  Remove nvmet_zones_to_desc_size() and fix the nr_zones
    calculation.
8.  Remove the op variable in nvmet_bdev_execute_zone_append().
9.  Fix the nr_zones calculation nvmet_bdev_execute_zone_mgmt_recv().
10. Update cover letter subject.

Changes from V1:-

1.  Remove the nvmet-$(CONFIG_BLK_DEV_ZONED) += zns.o.
2.  Mark helpers inline.
3.  Fix typos in the comments and update the comments.
4.  Get rid of the curly brackets.
5.  Don't allow drives with last smaller zones.
6.  Calculate the zasl as a function of ax_zone_append_sectors,
    bio_max_pages so we don't have to split the bio.
7.  Add global subsys->zasl and update the zasl when new namespace
    is enabled.
8.  Rmove the loop in the nvmet_bdev_execute_zone_mgmt_recv() and
    move functionality in to the report zone callback.
9.  Add goto for default case in nvmet_bdev_execute_zone_mgmt_send().
10. Allocate the zones buffer with zones size instead of bdev nr_zones.

Chaitanya Kulkarni (9):
  block: export __bio_iov_append_get_pages()
	Prep patch needed for implementing Zone Append.
  nvmet: add ZNS support for bdev-ns
	Core Command handlers and various helpers for ZBD backend which
	 will be called by target-core/target-admin etc.
  nvmet: trim down id-desclist to use req->ns
	Cleanup needed to avoid the code repetation for passing extra
	function parameters for ZBD backend handlers.
  nvmet: add NVME_CSI_ZNS in ns-desc for zbdev
	Allows host to identify zoned namesapce.
  nvmet: add cns-cs-ctrl in id-ctrl for ZNS bdev
	Allows host to identify controller with the ZBD-ZNS.
  nvmet: add cns-cs-ns in id-ctrl for ZNS bdev
	Allows host to identify namespace with the ZBD-ZNS.
  nvmet: add zns cmd effects to support zbdev
	Allows host to support the ZNS commands when zoned-blkdev is
	 selected.
  nvmet: add zns bdev config support
	Allows user to override any target namespace attributes for
	 ZBD.
  nvmet: add ZNS based I/O cmds handlers
	Handlers for Zone-Mgmt-Send/Zone-Mgmt-Recv/Zone-Append

 block/bio.c                       |   3 +-
 drivers/nvme/target/Makefile      |   2 +-
 drivers/nvme/target/admin-cmd.c   |  38 ++-
 drivers/nvme/target/io-cmd-bdev.c |  12 +
 drivers/nvme/target/io-cmd-file.c |   2 +-
 drivers/nvme/target/nvmet.h       |  19 ++
 drivers/nvme/target/zns.c         | 426 ++++++++++++++++++++++++++++++
 include/linux/bio.h               |   1 +
 8 files changed, 487 insertions(+), 16 deletions(-)
 create mode 100644 drivers/nvme/target/zns.c

# for i in nvme1n1 nullb1 ; do ./zonefs-tests.sh /dev/$i; done 
Gathering information on /dev/nvme1n1...
zonefs-tests on /dev/nvme1n1:
  4 zones (0 conventional zones, 4 sequential zones)
  524288 512B sectors zone size (256 MiB)
  1 max open zones
Running tests
  Test 0010:  mkzonefs (options)                                   ... PASS
  Test 0011:  mkzonefs (force format)                              ... PASS
 *Test 0012:  mkzonefs (invalid device)                            ... FAIL*
  Test 0013:  mkzonefs (super block zone state)                    ... PASS
  Test 0020:  mount (default)                                      ... PASS
  Test 0021:  mount (invalid device)                               ... PASS
  Test 0022:  mount (check mount directory sub-directories)        ... PASS
  Test 0023:  mount (options)                                      ... PASS
  Test 0030:  Number of files (default)                            ... PASS
  Test 0031:  Number of files (aggr_cnv)                           ... skip
  Test 0032:  Number of files using stat (default)                 ... PASS
  Test 0033:  Number of files using stat (aggr_cnv)                ... PASS
  Test 0034:  Number of blocks using stat (default)                ... PASS
  Test 0035:  Number of blocks using stat (aggr_cnv)               ... PASS
  Test 0040:  Files permissions (default)                          ... PASS
  Test 0041:  Files permissions (aggr_cnv)                         ... skip
  Test 0042:  Files permissions (set value)                        ... PASS
  Test 0043:  Files permissions (set value + aggr_cnv)             ... skip
  Test 0050:  Files owner (default)                                ... PASS
  Test 0051:  Files owner (aggr_cnv)                               ... skip
  Test 0052:  Files owner (set value)                              ... PASS
  Test 0053:  Files owner (set value + aggr_cnv)                   ... skip
  Test 0060:  Files size (default)                                 ... PASS
  Test 0061:  Files size (aggr_cnv)                                ... skip
  Test 0070:  Conventional file truncate                           ... skip
  Test 0071:  Conventional file truncate (aggr_cnv)                ... skip
  Test 0072:  Conventional file unlink                             ... skip
  Test 0073:  Conventional file unlink (aggr_cnv)                  ... skip
  Test 0074:  Conventional file random write                       ... skip
  Test 0075:  Conventional file random write (direct)              ... skip
  Test 0076:  Conventional file random write (aggr_cnv)            ... skip
  Test 0077:  Conventional file random write (aggr_cnv, direct)    ... skip
  Test 0078:  Conventional file mmap read/write                    ... skip
  Test 0079:  Conventional file mmap read/write (aggr_cnv)         ... skip
  Test 0080:  Sequential file truncate                             ... PASS
  Test 0081:  Sequential file unlink                               ... PASS
  Test 0082:  Sequential file buffered write IO                    ... PASS
  Test 0083:  Sequential file overwrite                            ... PASS
  Test 0084:  Sequential file unaligned write (sync IO)            ... PASS
  Test 0085:  Sequential file unaligned write (async IO)           ... PASS
  Test 0086:  Sequential file append (sync)                        ... PASS
  Test 0087:  Sequential file append (async)                       ... PASS
  Test 0088:  Sequential file random read                          ... PASS
  Test 0089:  Sequential file mmap read/write                      ... PASS
  Test 0090:  sequential file 4K synchronous write                 ... PASS
  Test 0091:  Sequential file large synchronous write              ... PASS

45 / 46 tests passed
Gathering information on /dev/nullb1...
zonefs-tests on /dev/nullb1:
  4 zones (0 conventional zones, 4 sequential zones)
  524288 512B sectors zone size (256 MiB)
  0 max open zones
Running tests
  Test 0010:  mkzonefs (options)                                   ... PASS
  Test 0011:  mkzonefs (force format)                              ... PASS
 *Test 0012:  mkzonefs (invalid device)                            ... FAIL*
  Test 0013:  mkzonefs (super block zone state)                    ... PASS
  Test 0020:  mount (default)                                      ... PASS
  Test 0021:  mount (invalid device)                               ... PASS
  Test 0022:  mount (check mount directory sub-directories)        ... PASS
  Test 0023:  mount (options)                                      ... PASS
  Test 0030:  Number of files (default)                            ... PASS
  Test 0031:  Number of files (aggr_cnv)                           ... skip
  Test 0032:  Number of files using stat (default)                 ... PASS
  Test 0033:  Number of files using stat (aggr_cnv)                ... PASS
  Test 0034:  Number of blocks using stat (default)                ... PASS
  Test 0035:  Number of blocks using stat (aggr_cnv)               ... PASS
  Test 0040:  Files permissions (default)                          ... PASS
  Test 0041:  Files permissions (aggr_cnv)                         ... skip
  Test 0042:  Files permissions (set value)                        ... PASS
  Test 0043:  Files permissions (set value + aggr_cnv)             ... skip
  Test 0050:  Files owner (default)                                ... PASS
  Test 0051:  Files owner (aggr_cnv)                               ... skip
  Test 0052:  Files owner (set value)                              ... PASS
  Test 0053:  Files owner (set value + aggr_cnv)                   ... skip
  Test 0060:  Files size (default)                                 ... PASS
  Test 0061:  Files size (aggr_cnv)                                ... skip
  Test 0070:  Conventional file truncate                           ... skip
  Test 0071:  Conventional file truncate (aggr_cnv)                ... skip
  Test 0072:  Conventional file unlink                             ... skip
  Test 0073:  Conventional file unlink (aggr_cnv)                  ... skip
  Test 0074:  Conventional file random write                       ... skip
  Test 0075:  Conventional file random write (direct)              ... skip
  Test 0076:  Conventional file random write (aggr_cnv)            ... skip
  Test 0077:  Conventional file random write (aggr_cnv, direct)    ... skip
  Test 0078:  Conventional file mmap read/write                    ... skip
  Test 0079:  Conventional file mmap read/write (aggr_cnv)         ... skip
  Test 0080:  Sequential file truncate                             ... PASS
  Test 0081:  Sequential file unlink                               ... PASS
  Test 0082:  Sequential file buffered write IO                    ... PASS
  Test 0083:  Sequential file overwrite                            ... PASS
  Test 0084:  Sequential file unaligned write (sync IO)            ... PASS
  Test 0085:  Sequential file unaligned write (async IO)           ... PASS
  Test 0086:  Sequential file append (sync)                        ... PASS
  Test 0087:  Sequential file append (async)                       ... PASS
  Test 0088:  Sequential file random read                          ... PASS
  Test 0089:  Sequential file mmap read/write                      ... PASS
  Test 0090:  sequential file 4K synchronous write                 ... PASS
  Test 0091:  Sequential file large synchronous write              ... PASS

45 / 46 tests passed
# 
# for i in nvme1n1 nullb1 ; do ./zonefs-tests.sh -t 0012 /dev/$i; done 
Gathering information on /dev/nvme1n1...
zonefs-tests on /dev/nvme1n1:
  4 zones (0 conventional zones, 4 sequential zones)
  524288 512B sectors zone size (256 MiB)
  1 max open zones
Running tests
  Test 0012:  mkzonefs (invalid device)                            ... FAIL

0 / 1 tests passed
Gathering information on /dev/nullb1...
zonefs-tests on /dev/nullb1:
  4 zones (0 conventional zones, 4 sequential zones)
  524288 512B sectors zone size (256 MiB)
  0 max open zones
Running tests
  Test 0012:  mkzonefs (invalid device)                            ... FAIL

0 / 1 tests passed
# cat nvme1n1-zonefs-tests.log 
## Test scripts/0012.sh (mkzonefs (invalid device))

/dev/console is not a block device
/dev/nullb4
/dev/nullb4: 524288000 512-byte sectors (250 GiB)
  Host-managed device
  1000 zones of 524288 512-byte sectors (256 MiB)
  0 conventional zones, 1000 sequential zones
  0 read-only zones, 0 offline zones
Format:
  999 usable zones
  Aggregate conventional zones: disabled
  File UID: 0
  File GID: 0
  File access permissions: 640
  FS UUID: 339b07fe-ebbb-4876-be16-5a887384f349
Resetting sequential zones
Writing super block
 --> SUCCESS (should FAIL)
FAILED

# cat nullb1-zonefs-tests.log 
## Test scripts/0012.sh (mkzonefs (invalid device))

/dev/console is not a block device
/dev/nullb5
/dev/nullb5: 524288000 512-byte sectors (250 GiB)
  Host-managed device
  1000 zones of 524288 512-byte sectors (256 MiB)
  0 conventional zones, 1000 sequential zones
  0 read-only zones, 0 offline zones
Format:
  999 usable zones
  Aggregate conventional zones: disabled
  File UID: 0
  File GID: 0
  File access permissions: 640
  FS UUID: 591f1476-47c6-4d81-b0e8-7c82d4c5b657
Resetting sequential zones
Writing super block
 --> SUCCESS (should FAIL)
FAILED

-- 
2.22.1

