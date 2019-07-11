Return-Path: <SRS0=DuRR=VI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE69C71142
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 17:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F8820645
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 17:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iJy59FjX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbfGKRxj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jul 2019 13:53:39 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:27765 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbfGKRxj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jul 2019 13:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562867618; x=1594403618;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6vQ691f7q41TvFt1IlLfdkkb5Y53Aqd0IO3IaVtUy4M=;
  b=iJy59FjXHVCydrSUFMwgifugos24jyCP63l26pOfmelnxEoQWrlSOSji
   XImsRwEofG0qim7NH7zP7TQ4GthnTSczEbt3aWnOqSVRStnaFT1OXpxP5
   dV5MEx5Rcf9dKzSrlU8Yug2TXga/rUlzXPdpJgHRb9LuGjBnyKKH9pSKu
   BUJz09/zHp9Gbp2GQi5vYUE5Te0rXqibcAjg5ZUgMWJVLY1rsAn08g+Ae
   iKJhfkOxyGcAglu1+hwMiCPayNZRYt9U/8DW+FyIv1C0dNx6uh20CLWHi
   QudSP3CT9NEbBOVFxdMDDXvoWGv8xDmmqI0uolKpZBS8M4k2B+NAJ5+5N
   w==;
IronPort-SDR: P063qf+e+h3VqU3LqTN1u+T1MGyqTrXqg4F1dUoz4eLLmkK5czBRTcFzEuMuAQe8+3OtJ+D2V2
 JG8Cqe+EUHs0or3QDLEVcJAQOcdarTse8pwvuy2Y7YX5IIneiVHZZPAh8GZRgQFxKWfuAZ/kfA
 jTjpxv/NvWyQ8y3/XfR1VM+aAXeLRZtpvw9FITBTe13rQMefT2Im/hxOZ6lTPggzUo3Hfqp1Rn
 3cu4jbMwL4Vy6MgK1OPk/NjP1k/HVYCjQ96l2HQB7HgdXGMei7V4Yn8DZ211rRKcifVSjhle+v
 29M=
X-IronPort-AV: E=Sophos;i="5.63,479,1557158400"; 
   d="scan'208";a="219228459"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jul 2019 01:53:37 +0800
IronPort-SDR: BtvyOLLZ3+Sxn/DJpTxMrrprnIFDwOcw6oj7XNl+3lfoguzZ3KgbkmWHctiTSZfjDOXaDJX7zg
 g+MHAOuDXGBrhPJNgljbcq7SrWG7d4nCOtEBSzatUn66PNxgKDdzGXvsmXqfoiwdmzUy674qTm
 He164Cq6DVTR4LuoiryP5ZngaJoOtoNb5DDaogV004rXgiKyHJcb0a6Pmcvxyci3b1zjfASoRh
 9nCwohBMxojzWqA+gqjg7JDB5IMMotHmbqaM+X+u9QhqDRNZMnwGRfcvpa91oPIA2r0h2Bhn+y
 TksCn9lTxrK1LCSlIRxuRDKx
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 11 Jul 2019 10:52:21 -0700
IronPort-SDR: yn4OAd7WnG7UyCettKWANc6zDWvFdAVvEF8YDK1wRmTAE48yLF8PFZDTsgknhr0OkRFDGgeF+g
 pQFHVC6A3WyBOjbGETLVroiKbIdbPBg5RnCApEFL8z4ACMe91BVrc/B9oFGUTs63K7y+uDTOzN
 M4Rwx2H/tHzBZEMS7bH5kcPv94oGr0eKlGHfzo0fEyc/R3A8Y5Vi+0AHlq8PeiZcQzbt3OMkMU
 ljEWEbBCotPgYX6zhiKuAvcYiqQzpx0jLdxEsvGeWvaV70WYqiemK+ozaebdJruA9FqxsRzvI1
 n68=
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Jul 2019 10:53:37 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 0/8] null_blk: add missing write-zeroes and discard support
Date:   Thu, 11 Jul 2019 10:53:20 -0700
Message-Id: <20190711175328.16430-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This patch series focusses on adding the support for:-                                                                   
1. Memory backed REQ_OP_WRITE_ZEROES through configfs.
2. Non Memory backed REQ_OP_DISCARD through module parameter.
3. Non Memory backed REQ_OP_WRITE_ZEROES through module parameter.

While the development of the blktrace extension, this support turned
out  to be useful in the debugging and discovering the various
scenarios when dealing with special REQ_OP_XXX (DISCARD, WRITE_ZEROES).

Also, for block layer in the blktests, we are missing the tests for 
write-zeroes. With this support now we can add tests so developers can
ensure that any change(s) to the I/O path is not breaking the special
REQ_OP_XXX without actually depending on the supporting controller and
the respective driver.

With this support, I sign-up for writing the testcases for the
REQ_OP_WRITE_ZEROES with memory backed null_blk as soon as this series
goes upstream in the blktests.

If anyone is interested please find the testing log at the end.

Regards,
Chaitanya

Chaitanya Kulkarni (8):
  null_blk: add module parameter for REQ_OP_DISCARD
  null_blk: add REQ_OP_WRITE_ZEROES config property
  null_blk: add support for write-zeroes
  null_blk: allow memory-backed write-zeroes-req
  null_blk: code cleaup
  null_blk: allow memory-backed write-zeroes-bio
  null_blk: add support for configfs write_zeroes
  null_blk: adjusts the code with latest changes

 drivers/block/null_blk.h      |   1 +
 drivers/block/null_blk_main.c | 125 +++++++++++++++++++++++++++-------
 2 files changed, 102 insertions(+), 24 deletions(-)

# Test log :-

Simple Test log for changing the block size and enabling the
write-zeroes with null_blk memory backed :-

######################BLKISZ 512#######################
config/nullb/nullb0
├── badblocks
├── blocking
├── blocksize
├── cache_size
├── completion_nsec
├── discard
├── home_node
├── hw_queue_depth
├── index
├── irqmode
├── mbps
├── memory_backed
├── power
├── queue_mode
├── size
├── submit_queues
├── use_per_node_hctx
├── write_zeroes
├── zoned
├── zone_nr_conv
└── zone_size

0 directories, 21 files
ODD:- 
20+0 records in
20+0 records out
10240 bytes (10 kB) copied, 0.00120115 s, 8.5 MB/s
0000000   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0000016
0000512   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0000528
0001024   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0001040
0001536   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0001552
0002048   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0002064
0002560   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0002576
0003072   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0003088
0003584   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0003600
0004096   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0004112
0004608   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0004624
------------------------------------------------------
0000000   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0000016
0000512  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0000528
0001024   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0001040
0001536  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0001552
0002048   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0002064
0002560  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0002576
0003072   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0003088
0003584  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0003600
0004096   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0004112
0004608  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0004624
------------------------------------------------------
EVEN:- 
20+0 records in
20+0 records out
10240 bytes (10 kB) copied, 0.00118618 s, 8.6 MB/s
0000000   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0000016
0000512   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0000528
0001024   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0001040
0001536   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0001552
0002048   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0002064
0002560   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0002576
0003072   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0003088
0003584   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0003600
0004096   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0004112
0004608   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0004624
------------------------------------------------------
0000000  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0000016
0000512   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0000528
0001024  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0001040
0001536   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0001552
0002048  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0002064
0002560   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0002576
0003072  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0003088
0003584   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0003600
0004096  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0004112
0004608   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0004624
------------------------------------------------------




######################BLKISZ 1024#######################
config/nullb/nullb0
├── badblocks
├── blocking
├── blocksize
├── cache_size
├── completion_nsec
├── discard
├── home_node
├── hw_queue_depth
├── index
├── irqmode
├── mbps
├── memory_backed
├── power
├── queue_mode
├── size
├── submit_queues
├── use_per_node_hctx
├── write_zeroes
├── zoned
├── zone_nr_conv
└── zone_size

0 directories, 21 files
ODD:- 
20+0 records in
20+0 records out
20480 bytes (20 kB) copied, 0.00134839 s, 15.2 MB/s
0000000   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0000016
0001024   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0001040
0002048   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0002064
0003072   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0003088
0004096   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0004112
0005120   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0005136
0006144   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0006160
0007168   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0007184
0008192   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0008208
0009216   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0009232
------------------------------------------------------
0000000   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0000016
0001024  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0001040
0002048   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0002064
0003072  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0003088
0004096   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0004112
0005120  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0005136
0006144   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0006160
0007168  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0007184
0008192   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0008208
0009216  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0009232
------------------------------------------------------
EVEN:- 
20+0 records in
20+0 records out
20480 bytes (20 kB) copied, 0.0012485 s, 16.4 MB/s
0000000   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0000016
0001024   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0001040
0002048   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0002064
0003072   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0003088
0004096   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0004112
0005120   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0005136
0006144   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0006160
0007168   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0007184
0008192   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0008208
0009216   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0009232
------------------------------------------------------
0000000  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0000016
0001024   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0001040
0002048  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0002064
0003072   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0003088
0004096  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0004112
0005120   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0005136
0006144  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0006160
0007168   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0007184
0008192  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0008208
0009216   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0009232
------------------------------------------------------




######################BLKISZ 2048#######################
config/nullb/nullb0
├── badblocks
├── blocking
├── blocksize
├── cache_size
├── completion_nsec
├── discard
├── home_node
├── hw_queue_depth
├── index
├── irqmode
├── mbps
├── memory_backed
├── power
├── queue_mode
├── size
├── submit_queues
├── use_per_node_hctx
├── write_zeroes
├── zoned
├── zone_nr_conv
└── zone_size

0 directories, 21 files
ODD:- 
20+0 records in
20+0 records out
40960 bytes (41 kB) copied, 0.00161901 s, 25.3 MB/s
0000000   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0000016
0002048   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0002064
0004096   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0004112
0006144   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0006160
0008192   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0008208
0010240   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0010256
0012288   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0012304
0014336   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0014352
0016384   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0016400
0018432   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0018448
------------------------------------------------------
0000000   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0000016
0002048  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0002064
0004096   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0004112
0006144  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0006160
0008192   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0008208
0010240  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0010256
0012288   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0012304
0014336  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0014352
0016384   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0016400
0018432  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0018448
------------------------------------------------------
EVEN:- 
20+0 records in
20+0 records out
40960 bytes (41 kB) copied, 0.00180328 s, 22.7 MB/s
0000000   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0000016
0002048   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0002064
0004096   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0004112
0006144   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0006160
0008192   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0008208
0010240   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0010256
0012288   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0012304
0014336   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0014352
0016384   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0016400
0018432   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0018448
------------------------------------------------------
0000000  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0000016
0002048   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0002064
0004096  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0004112
0006144   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0006160
0008192  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0008208
0010240   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0010256
0012288  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0012304
0014336   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0014352
0016384  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0016400
0018432   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0018448
------------------------------------------------------




######################BLKISZ 4096#######################
config/nullb/nullb0
├── badblocks
├── blocking
├── blocksize
├── cache_size
├── completion_nsec
├── discard
├── home_node
├── hw_queue_depth
├── index
├── irqmode
├── mbps
├── memory_backed
├── power
├── queue_mode
├── size
├── submit_queues
├── use_per_node_hctx
├── write_zeroes
├── zoned
├── zone_nr_conv
└── zone_size

0 directories, 21 files
ODD:- 
16+1 records in
16+1 records out
65537 bytes (66 kB) copied, 0.00140571 s, 46.6 MB/s
0000000   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0000016
0004096   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0004112
0008192   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0008208
0012288   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0012304
0016384   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0016400
0020480   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0020496
0024576   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0024592
0028672   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0028688
0032768   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0032784
0036864   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0036880
------------------------------------------------------
0000000   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0000016
0004096  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0004112
0008192   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0008208
0012288  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0012304
0016384   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0016400
0020480  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0020496
0024576   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0024592
0028672  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0028688
0032768   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0032784
0036864  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0036880
------------------------------------------------------
EVEN:- 
16+1 records in
16+1 records out
65537 bytes (66 kB) copied, 0.00123278 s, 53.2 MB/s
0000000   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0000016
0004096   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0004112
0008192   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0008208
0012288   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0012304
0016384   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0016400
0020480   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0020496
0024576   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0024592
0028672   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0028688
0032768   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0032784
0036864   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0036880
------------------------------------------------------
0000000  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0000016
0004096   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0004112
0008192  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0008208
0012288   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0012304
0016384  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0016400
0020480   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0020496
0024576  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0024592
0028672   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0028688
0032768  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0032784
0036864   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0036880
------------------------------------------------------
-- 
2.17.0
