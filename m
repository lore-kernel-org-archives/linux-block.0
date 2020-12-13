Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0869C0018C
	for <linux-block@archiver.kernel.org>; Sun, 13 Dec 2020 05:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACE1C2312F
	for <linux-block@archiver.kernel.org>; Sun, 13 Dec 2020 05:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbgLMFvZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Dec 2020 00:51:25 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:4942 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730373AbgLMFvY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Dec 2020 00:51:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607838684; x=1639374684;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Hd/h89kkFCTMloMN8HitQ9iLDV9MVx8UC7BBr2rCOjA=;
  b=juuyl8ZDmugkD5tvOP33MsbuPHTVZByLy/gKFG6ziymGmVD7PSHuqPPF
   6uG3ekcRrfYDZBwA35mt/NZgsTtxq8IYx8Sl3ApjNK0RETXiZcfKwjbjj
   JutOXohcLCPGlHuHDr0h18r4fjG33PmwtG/tcucarFaXUWH7NUwOuoTBK
   O0aFba9DgEd0JHJuujgBhtEcieGrFQLGPo/icDioCU1GLIbEePd3PZtpi
   5qCi3N57F6n1Ve5qJoyj4oWz6pp2DwTQ65P0w/aiNXvZgplD4rT0N6j2Y
   X5H3qo9IlUng7bOGbTOoZRTgKNZ46ZcVpDvm14l5eCz7BceDNeM7HY1pK
   Q==;
IronPort-SDR: ukAlrd09BJ9p/1l9FLTwPd2SGiF5wpwC8bFR2qVwWsZZav9iz9XhSE/LpliPDD/DIXK2gBUMpx
 40kxgEg+gV8IUmCXaHUimTF3t6Hfh3nOC69hd6XtUTWM3SRsyQBQSUeNyMiQrOoKBXFtXKrPL2
 MSQ/q7NrC3Qdps105dsvhr9/4GZ8uLl/ykyGBuPVZNE78PvZdmgzc2XXJoMOrkVtiQHxtbzqrP
 sBbf3etDsRphGBZp9b6vfa3LxHhUCZdZfIti3M+yGvK14Sn5TlFVKpMafCbSh5C1AUq4TlC3uC
 eHQ=
X-IronPort-AV: E=Sophos;i="5.78,415,1599494400"; 
   d="scan'208";a="265203437"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2020 13:50:18 +0800
IronPort-SDR: FMTBJxSINZdfLwEmrdkUHYhurczOzqcLL/SHkBRpB6TnP9eX1DpWsuEyeQST7PbCHDjuXybujL
 W2bI/vRC2izpKNJy9qTHFRkP8CQHxUhO426+JZWVBAfULuc1yjITHxI+cvMg+UcZ7NqQAaNGb7
 9FiD1aB/+jrjHIktpsnW01xOKx4swuWcroiF+nqP8pY36ivxFOCW83pHAX9vwVBzMBXQz/8Une
 lHslTkFnPFElzAKfY77yPSUbS5EBEFX4YigoPnDhB7y/YRA7REqTlYdnvR/+EfkP2geYrCMTe5
 CssPoUxDEFGP348LQoTrB4t9
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2020 21:35:40 -0800
IronPort-SDR: qOleVCQmsTR7p5hjXXegqIB0RSbODPPX/WyMnzoj92JF+BQh9pTj5OCXxyhAkiQF4zr/qgsUOV
 oA5zvOWdb9F2k4kVjN4rjBauklhUjRuw7rCPYXquVG7U6F8WIatex2zAr+vEvZDgt+JyOMfOhe
 bRddwr2ZWqW6wnzSIXQtVJij/YFTs489lvwd4djlv9bFsnIzBDk/4Ss8xoGcDSDkn/6IjEXp3P
 xRjAAU0sgh9oJl6Gcod1VZgx8CamlVfEoI3IbXSrT7HuFwcoRsLIuTGASuvNwdH+dVpbcMP0G2
 T3s=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Dec 2020 21:50:18 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V6 0/6] nvmet: add ZBD backend support
Date:   Sat, 12 Dec 2020 21:50:11 -0800
Message-Id: <20201213055017.7141-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

NVMeOF Host is capable of handling the NVMe Protocol based Zoned Block
Devices (ZBD) in the Zoned Namespaces (ZNS) mode with the passthru
backend. There is no support for a generic block device backend to
handle the ZBD devices which are not NVMe protocol compliant.

This adds support to export the ZBDs (which are not NVMe drives) to host
the from target via NVMeOF using the host side ZNS interface.

The patch series is generated in bottom-top manner where, it first adds
prep patch and ZNS command-specific handlers on the top of genblk and 
updates the data structures, then one by one it wires up the admin cmds
in the order host calls them in namespace initializing sequence. Once
everything is ready, it wires-up the I/O command handlers. See below for
patch-series overview.

All the testcases are passing for the ZoneFS where ZBD exported with
NVMeOF backed by null_blk ZBD and null_blk ZBD without NVMeOF. Adding
test result below.

Note: This patch-series is based on the earlier posted patch series :-

[PATCH 0/4] nvmet: admin-cmd related cleanups and a fix

http://lists.infradead.org/pipermail/linux-nvme/2020-December/021501.html

Regards,
Chaitanya

Changes from V5:-

1.  Use bio->bi_iter.bi_sector for result of the REQ_OP_ZONE_APPEND
    command.
2.  Add endianness to the helper nvmet_sect_to_lba().
3.  Make bufsize u32 in zone mgmt recv command handler.
4.  Add __GFP_ZERO for report zone data buffer to return clean buffer.

Changes from V4:-

1.  Don't use bio_iov_iter_get_pages() instead add a patch to export
    bio_add_hw_page() and call it directly for zone append.
2.  Add inline vector optimization for append bio.
3.  Update the commit logs for the patches.
4.  Remove ZNS related identify data structures, use individual members.
5.  Add a comment for macro NVMET_MPSMIN_SHIFT.
6.  Remove nvmet_bdev() helper.
7.  Move the command set identifier code into common code.
8.  Use IS_ENABLED() and move helpers fomr zns.c into common code.
9.  Add a patch to support Command Set identifiers.
10. Open code nvmet_bdev_validate_zns_zones().
11. Remove the per namespace min zasl calculation and don't allow
    namespaces with zasl value > the first ns zasl value.
12. Move the stubs into the header file.
13. Add lba to/from sector conversion helpers and update the
    io-cmd-bdev.c to avoid the code duplication.
14. Add everything into one patch for zns command handlers and 
    respective calls from the target code.
15. Remove the trim ns-desclist admin callback patch from this series.
16. Add bio get and put helpers patches to reduce the duplicate code in
    generic bdev, passthru, and generic zns backend.

Changes from V3:-

1.  Get rid of the bio_max_zasl check.
2.  Remove extra lines.
4.  Remove the block layer api export patch.
5.  Remove the bvec check in the bio_iov_iter_get_pages() for
    REQ_OP_ZONE_APPEND so that we can reuse the code.

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

Chaitanya Kulkarni (6):
  block: export bio_add_hw_pages()
  nvmet: add lba to sect conversion helpers
  nvmet: add NVM command set identifier support
  nvmet: add ZBD over ZNS backend support
  nvmet: add bio get helper for different backends
  nvmet: add bio put helper for different backends

 block/bio.c                       |   1 +
 block/blk.h                       |   4 -
 drivers/nvme/target/Makefile      |   1 +
 drivers/nvme/target/admin-cmd.c   |  59 +++--
 drivers/nvme/target/core.c        |  14 +-
 drivers/nvme/target/io-cmd-bdev.c |  51 +++--
 drivers/nvme/target/nvmet.h       |  71 ++++++
 drivers/nvme/target/passthru.c    |  11 +-
 drivers/nvme/target/zns.c         | 350 ++++++++++++++++++++++++++++++
 include/linux/blkdev.h            |   4 +
 10 files changed, 518 insertions(+), 48 deletions(-)
 create mode 100644 drivers/nvme/target/zns.c

# ./zonefs-tests.sh /dev/nvme1n1 
Gathering information on /dev/nvme1n1...
zonefs-tests on /dev/nvme1n1:
  16 zones (0 conventional zones, 16 sequential zones)
  131072 512B sectors zone size (64 MiB)
  1 max open zones
Running tests
  Test 0010:  mkzonefs (options)                                   ... PASS
  Test 0011:  mkzonefs (force format)                              ... PASS
  Test 0012:  mkzonefs (invalid device)                            ... PASS
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

46 / 46 tests passed

-- 
2.22.1

