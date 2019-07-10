Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28665C73C68
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 04:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1D320665
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 04:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UcvyDjfR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfGJECw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jul 2019 00:02:52 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:26719 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfGJECv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jul 2019 00:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562731371; x=1594267371;
  h=from:to:cc:subject:date:message-id;
  bh=HQDkGifMsOy550KH3uxQdCDI+Fv4P11XTs4Xx1b5rmA=;
  b=UcvyDjfRmteseOPAE6Ob492lrDSUghYTqOsM8za3NJrKC6rQmLDC6Nei
   bEvB/JopT1dTa6EguwCgVv58t8d4IOB3I57DLzAEck/mLh/ER5pTmlAoB
   efyHlzSdzq0FGhdXzvV/KuGMHMAqrY63hzmMRi71rts/m9Bs5u+Gcvpnv
   MCd+mBbrkFs8PKysBOQm1Sii+2mykKuxIrTDKx2ryodoG97vmCXg/9ImQ
   +Xd31enioEXxSGu8UUxZ+Ea3Zawjl0uFIx+naDLKpyEA+aLT3OEenahwq
   K72lxWWNkWboFVGPX8eIXDJ+RTi0bIsZOHuaqElUeYZMgNruReacjPbk7
   Q==;
IronPort-SDR: Sm5FpCR+cpE66nuHxkZDue+STxNwv4S9jCu1gYT8zC9VsOOjJ4tM3KJUiU516ncvXkN1e7YYJz
 Q4+HRfm1WUkDKDh3JYY/h6daMNN7Xn9lJIrHRnxp/24lcyzAFp1RPy9PQ7aPSOWGnnN76FFTnJ
 8cLK4XQUaM4NBxDs2u3ITWOwcVG9W5VO5vUDhIvPzcC3xiVIbyhF2O+TeUWzS4c12J9E+yocf6
 wvphdxSdXqnu4ZSbwyaHvqk6kkyUGdxxYOP0jwQ6CtzG/FUeNYUcRDxiPKw0jpLa5A+bM7cpqa
 Et4=
X-IronPort-AV: E=Sophos;i="5.63,473,1557158400"; 
   d="scan'208";a="219037267"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2019 12:02:50 +0800
IronPort-SDR: eZX6A68I/7kv6BFaKz6rNmPq5oa4YvrIIW5avenyWctHkg77ccoevFe1J4teqJlojmMP4Qrhed
 f8crum1hk7AjdUEVJZZS3t+ZAtAsW0E7cq1AQPZbZ+XbaAbl2Rfrg2ubkvJhOD5w1MgYrJyZWI
 ycfp7O4vU70KYC1ft8UmcC16FcxmR5QixFDJkYBzI+xY59hxi3K8VeU3SKdzf+ZhMdpxJDGJry
 X2Eg8Aj7+ML+i+8dSVyidpV7rFba6ruEuvCa01h2m1pxOivCWBfLwJ5hpnOr2z1ZxuG873/UM1
 hzc/rN0AOkOyW6O8+vSlyxSn
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 09 Jul 2019 21:01:37 -0700
IronPort-SDR: 9l2tLyqPmcvVky0ICx7cTRiZfJNr5TvCp3GYUSZdhZQzPnZ4qSEg8YJq2QfAooXZCjq2+TWXPX
 LTi7yb44wefdnwoRe+04+5JzMbvoIUeOty8MWgMCHQQ0gYUlg+Ru0nPs2bq6FInBilSwwugSFy
 Di6AytqA+8F5GAssofLmtcSFra37atmqCLDu4IL7OYLpKduK68G0nI+6b/AYS8OkJZcx1PfvWN
 iP1Je8+lRM6kDrQQeyJYjLCb+DuVmj1f0TG77eDgkku4ooBW6YXQFRTthr1IGBFeb2LsFjzLvv
 zu4=
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Jul 2019 21:02:51 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, axboe@kernel.dk,
        hch@lst.de
Subject: [PATCH 0/3] block: set ioprio value
Date:   Tue,  9 Jul 2019 21:02:21 -0700
Message-Id: <20190710040224.12342-1-chaitanya.kulkarni@wdc.com>
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


Chaitanya Kulkarni (3):
  block: set ioprio for zone-reset bio
  block: set ioprio for flush bio
  block: set ioprio for write-zeroes, discard etc

 block/blk-flush.c | 2 ++
 block/blk-lib.c   | 6 ++++++
 block/blk-zoned.c | 1 +
 3 files changed, 9 insertions(+)

-- 
2.17.0

