Return-Path: <SRS0=wMiD=WR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3742C3A59E
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 06:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07FB22D6D
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 06:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fjjsvyp5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfHUGMD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 02:12:03 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:46795 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfHUGMC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 02:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566367922; x=1597903922;
  h=from:to:cc:subject:date:message-id;
  bh=HQ234ZTqwBbZWKR3OpDGx9SSY09PzclKhtZHgmVz3/Y=;
  b=fjjsvyp5H024UyO1krk7mWxRDmESIFCydV6rNpSYfJ9e++1UA9sF4d9Y
   ciGUjFmgUyliOzQUA1GLsL9uusZFM/I3IRUdeZSqTYTKhHDMsuwTAY27o
   AGaR12YJPKkjMn79ysfwHcudMgWPH+KGhXRkSzwPy8QoiI5DnD6Dwuez0
   4HxvFaTAjvKvycjz8a7gsQJ2KK+TDTTmwOuWYSEUiRqbV24qN5s7RBOM1
   GJJlXK4cwD3aiOjLzGgqllMd0WJmLJlZOsjHLw4cXMAXg3nlM/QrWKQrJ
   7SGJ4anFy+52kBRN/ZwIhj4sKouAcMqGecMGXg74XvxhiTqR/CE4eCZDD
   A==;
IronPort-SDR: XdwFxE4X0dtt3FMfrfNAUEoYbpPxRtg4WV7S4gOuOchtcHKqjzlVMGy8Ll1CObwSv/hQPd92jQ
 cDu1XIgqLGLbkauNZVwrKtSWFP76AEfo4ceUBDtLF1OMV27Z4qFsprBFLNR89UFICntvyFL06I
 2INv9IBqa6og8DZkQODzsXcXJYRDzepwGVnyFEc8YhK7zDGVV4+YS99JClGyQwrtTrGMrAFlVf
 RGoKWWLt7+ZObb22HJ86F9U02ojNXjorw0NBqmOk2PN9EzpO0H6hJ/zEua1C+bEFOHUA0YHYE3
 acA=
X-IronPort-AV: E=Sophos;i="5.64,411,1559491200"; 
   d="scan'208";a="222880634"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2019 14:12:01 +0800
IronPort-SDR: fdyBt+JXIhPG0CFWkemOCzKcguNRAK/kCDDZUQMRBdxP29JPqL7w2zjL3kdSkgeBPwhIWu6SoK
 WZP1Tn9xoYxj3CsJtm0FcSBMmftg5AD9NixDvUSt3MpxtV/jHnD+Ad8URKVEvPEcIC4F+iJid/
 JxVOpqtUredwhxxITJBMY8r9i8dsfk++4Mkg2oszOQ4Q8QiyQPUrVWkYv+L+qpy0x69fDhd+QA
 s/2aqpAdqdrYa7Ntjyj2nmb6191KSeTnDEBY2p+lfCAaa4o7kXhGNtKMBGffHdtrURWuLLI44q
 UKz1+ZXpF9b/+xhkWoUDf+6y
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 23:09:22 -0700
IronPort-SDR: dmeZ0vyILOeZoHueTqrGz6gav5i6/c/2WlZFGhpNvVBF0lLJ7zJuzV7VU6kV+viKNmcFbL6iH3
 4/QI/F0pxBR/XhmKYbsFMZV4u0hUGGk8BfF6aiQ2LruBlMgkA8CdFCXg2prkuKquQdCdJEerxx
 fAUTpi6nB5Ha+YG/3B1IVGuKebLiyEhTWYEFr/iotOc7u+0s+6Ys4q8fJ4XO/pILstf5LJ/Dij
 ONshQqI9zByCDi17MHB6/WqO9fIK7mI6Vb+AQDUKM5XHtpKmXnOEZNJFzIjIHYxzo7PU23DP91
 x9s=
WDCIronportException: Internal
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Aug 2019 23:12:01 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 0/3] block: set ioprio value
Date:   Tue, 20 Aug 2019 23:11:53 -0700
Message-Id: <20190821061156.3127-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

While experimenting with the ionice, I came across the scenario where
I cannot see the bio/request priority field being set when using
blkdiscard for REQ_OP_DISCARD, REQ_OP_WRITE_ZEROES and other operations
like REQ_OP_WRITE_SAME, REQ_OP_ZONE_RESET, and flush.

This is a small patch-series which sets the ioprio value at various
places for the zone-reset, flush, write-zeroes and discard operations.
This patch series uses get_current_ioprio() so that bio associated
with the respective operation can inherit the value from current
process.

In order to test this, I've modified the null_blk and enabled the 
write_zeroes through module param. Following are the results.

Without these patches:-  

# modprobe null_blk gb=5 nr_devices=1 write_zeroes=1
# for prio in `seq 0 3`; do ionice -c ${prio} blkdiscard -z -o 0 -l 4096 /dev/nullb0; done
# dmesg  -c 
[  402.958458] null_handle_cmd REQ_OP_WRITE_ZEROES priority class 0
[  402.966024] null_handle_cmd REQ_OP_WRITE_ZEROES priority class 0
[  402.973960] null_handle_cmd REQ_OP_WRITE_ZEROES priority class 0
[  402.981373] null_handle_cmd REQ_OP_WRITE_ZEROES priority class 0
# 

With these patches:-

# modprobe null_blk gb=5 nr_devices=1 write_zeroes=1
# for prio in `seq 0 3`; do ionice -c ${prio} blkdiscard -z -o 0 -l 4096 /dev/nullb0; done 
# dmesg  -c 
[ 1426.091772] null_handle_cmd REQ_OP_WRITE_ZEROES priority class 0
[ 1426.100177] null_handle_cmd REQ_OP_WRITE_ZEROES priority class 1
[ 1426.108035] null_handle_cmd REQ_OP_WRITE_ZEROES priority class 2
[ 1426.115768] null_handle_cmd REQ_OP_WRITE_ZEROES priority class 3
# 

With the block trace extension support is being worked on [1] which has
the ability to report the I/O priority, now we can track the correct
priority values with this patch-series.

Regards,
Chaitanya

[1] https://www.spinics.net/lists/linux-btrace/msg00880.html

* Changes from V1:-
1. Adjust the code for new changes from linux-block/for-next.  

Chaitanya Kulkarni (3):
  block: set ioprio for zone-reset bio
  block: set ioprio for flush bio
  block: set ioprio for discard, write-zeroes etc

 block/blk-flush.c | 1 +
 block/blk-lib.c   | 4 ++++
 block/blk-zoned.c | 2 ++
 3 files changed, 7 insertions(+)

-- 
2.17.0

