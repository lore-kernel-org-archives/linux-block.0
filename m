Return-Path: <SRS0=7FI7=SR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF0DC10F0E
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 05:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 375672075B
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 05:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fWkwJfPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbfDOF5J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Apr 2019 01:57:09 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:49150 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfDOF5J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Apr 2019 01:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555307829; x=1586843829;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oJHDNS6ceWQixzdb5q/xWk3c9aKrA/t0IHeqatnBK2U=;
  b=fWkwJfPTwjD6JlXoMwDoBI69NaiiBy2HCInUb9VaJ0pxUVz/+5PlKJWD
   oI2Jgl3b5tn6RylH/ugk8NkFr4o2cB54yGt0FKOfL2++f9RFQaRHauJyt
   f9i5j6KPbIrTwAMaQhmO1jpnZqZ1qhBnErTQDHltFXlVcC/jabQ+DSzaS
   YYsuKflHPo6aMPXbaPRV66NgKVrBcNC46zPLTUiNTKiGWvDeNhwJMgeGN
   NGEYiiDlWbPAFJL3lSkQK2QDtPLnAgXH0cook4MMib8mMK1ovk7/jdNt1
   S7badNOWi7RKSZsbeKbrICWjLx6BRejPw1kphOHdHJdKcwIyXVuHFQErZ
   w==;
X-IronPort-AV: E=Sophos;i="5.60,352,1549900800"; 
   d="scan'208";a="110921520"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2019 13:57:09 +0800
IronPort-SDR: COaF3lCbkR14rv5QWkJ+2psALQYypN7GQQjFFh/rJCdjXHwfJvK2gKVpB/0InxW/fhwn0322FD
 lNAJEWKK0G6QkgK3HTvYgUjK0qi84fpN8kK816X8hga81yuys6Sxi4OJLB3jP22Va4FyEyDJyZ
 VIY8x8euOmSF0m7h+MfmgAxQX8h4kZFY87DUIlRTuKc/yIkKoLywdEMEUa8QWylWHEjywX6DAa
 D2XzjFI6Rsdq5yVWTcdWOIf4+maRhPhQ94igz0n8jMslMvXrUEAYghPhRAx0hEcOHOWtXitlhY
 itSUcYWn+XhjsZzR9zdnbcLw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 14 Apr 2019 22:33:55 -0700
IronPort-SDR: zNz7cuRjlEiF0c0DtwlYOUny/tt/xaOadTcJsdzO/KDLswpDApZgDxCnwjf2j+j7GA9m8tg8XK
 Qpcraldk4pH+cra0gWooXNv1J1D126bXrBgZ5u5dh8t30Vp1Hxn3Tztv382P/GzWXJN/GyjrHy
 ttGPkNILWR8CR50JkEBudmz0aUP1UvGt6QG9uKI0pUyqhRc2m4MxdQfKe3U76BhqjYLuoEWspE
 ocnizsHxERFEKYNwCW2GhbiiaNjxTdqWq6VpXtIH3OFqltAJOcnFJviD2z4KOc73BDE1XbXAPN
 Zl0=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Apr 2019 22:57:08 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 0/2] block: set per bio io-priority in blk-lib
Date:   Sun, 14 Apr 2019 22:57:01 -0700
Message-Id: <20190415055703.5512-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

While experimenting with the ionice I came across the scenario where
I cannot see the bio's priority field been set when use blkdiscard
for REQ_OP_DISCARD and REQ_OP_WRITE_ZEROES.

This is a small patch-series which initializes the bio->bi_ioprio
(iopriority) field under different operations like REQ_OP_DISCARD and
REQ_OP_WRITE_ZEROES. It helps to track the priority when debugging.

In order to test this I've modified the null_blk and enabled the
write_zeroes through module param. Following are the results.

Without this patches :- 

# git log -1 --oneline
4443f8e6ac77 (HEAD -> master, origin/master, origin/HEAD) Merge tag 'for-linus-20190412' of git://git.kernel.dk/linux-block
# modprobe null_blk gb=5 nr_devices=1 write_zeroes=1
# for prio in `seq 0 3`; do ionice -c ${prio} blkdiscard -z -o 0 -l 4096 /dev/nullb0; done
# dmesg  -c 
[  402.958458] null_handle_cmd 1220 REQ_OP_WRITE_ZEROES priority class 0
[  402.966024] null_handle_cmd 1220 REQ_OP_WRITE_ZEROES priority class 0
[  402.973960] null_handle_cmd 1220 REQ_OP_WRITE_ZEROES priority class 0
[  402.981373] null_handle_cmd 1220 REQ_OP_WRITE_ZEROES priority class 0
# 

After thiese patches :-

# git log --oneline -2 
7a54a31cad5c (HEAD -> master) block: add task priority to init bio iopriority
149603fbd421 block: adjust code for get_task_ioprio()
# modprobe null_blk gb=5 nr_devices=1 write_zeroes=1
# for prio in `seq 0 3`; do ionice -c ${prio} blkdiscard -z -o 0 -l 4096 /dev/nullb0; done 
# dmesg  -c 
[ 1426.091772] null_handle_cmd 1220 REQ_OP_WRITE_ZEROES priority class 0
[ 1426.100177] null_handle_cmd 1220 REQ_OP_WRITE_ZEROES priority class 1
[ 1426.108035] null_handle_cmd 1220 REQ_OP_WRITE_ZEROES priority class 2
[ 1426.115768] null_handle_cmd 1220 REQ_OP_WRITE_ZEROES priority class 3
# 

Regards,
Chaitanya

Chaitanya Kulkarni (2):
  block: adjust code for get_task_ioprio()
  block: add task priority to init bio iopriority

 block/blk-lib.c        |  6 ++++++
 block/ioprio.c         | 20 ++++++++++++++++----
 include/linux/ioprio.h |  2 ++
 3 files changed, 24 insertions(+), 4 deletions(-)

-- 
2.19.1

