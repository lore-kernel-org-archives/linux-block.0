Return-Path: <SRS0=9MH5=U6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470F2C5B578
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 21:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18DBB206E0
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 21:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dB6rT0lX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfGAV5o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:57:44 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:56668 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfGAV5o (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jul 2019 17:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562018265; x=1593554265;
  h=from:to:cc:subject:date:message-id;
  bh=qHPV8j7yPVDlKUtbgMMWa08uXGi3zRdtGJmZ1qQMtyE=;
  b=dB6rT0lXZc/qFF7KRiL/Pad5F3Abnzs7iEFmwr4L+YA308svy/8IsP6a
   zSppRSWQ+5MLU17tbqS6tR8l0/oEX6+aI7rB4+MJFb9uNAxZiQKU3/lyU
   xHl0aknsGIO05pI0OCGnsylvbP30gNFRkXN3JjpazQXV0B6U62aeXOo8X
   ltJQxOzb7DN7KO4jVDrq5QsZNoSRD5HYZNwhlcRTaMGIQtgLVzGkDN+/q
   nIeIgLWTQP4+SJ563fq3F6Dzf0lssbyiqZF4W+edq8yPca7CFLx+G226v
   4G8faTF37Y1+lX/xx+iMadcxhRAdEVD0CbYfkPbuxHp6JOtkcExEV65md
   w==;
X-IronPort-AV: E=Sophos;i="5.63,440,1557158400"; 
   d="scan'208";a="116844001"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2019 05:57:38 +0800
IronPort-SDR: FWpWs/TuueK4hW/xUlwIbdL0a2Tn6wmIZld8FlIOOSE3F4Vbnm+yPsbax3ARaE+ckPcoJSoKXr
 acCb3EBJPPqLrDSeGRDLsNsDeQuCEW8zTlP74fAoPwgrDuN8/Z+9ezwMjBgkFCLOqD7umTJhZy
 hKvpnQvx2YC7k80shZpCuVk1E4WtVYO5uSdf3n7xbZs4gaJoXikrz390oODT1ev3IJ62JcbaV6
 0Oh1yRUqA7qnUcQN5psVmtfEpI7jaqI1db5WB0qGYjcl7VxOa1ymv2jtnoGU8kE2OGs1ZR74Lh
 TXEya+1tJYSOgk1v292jENth
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 01 Jul 2019 14:56:37 -0700
IronPort-SDR: /Z4+8D0k91BrFb6d8BFBl6MJ45BZlRAdYYzdL3oXvd24qnVK1JxjuJLL66M5jJymyeBu275DQU
 uPCeCuiIzMoNHoTpePEuYDjvZiu26feu2qxPrpVtt/pbR3BBQa8nOd1Zg4frqAwpKhOgToJIqZ
 xkFTc1/Quq0dUNI3UiXM/2RiZaqdJE09xnZOHFXtZXylPazWe4N+rLmy3eG8hpz59skFtVuYd2
 CeT6fvjfAhevkU876StxG6OU2ISVQ7qQnbSv3Sn3QJf6D/grcxBkDAHXBjAdkr0UH6yDcRqYMt
 ycs=
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Jul 2019 14:57:37 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-mm@kvack.org, linux-block@vger.kernel.org
Cc:     bvanassche@acm.org, axboe@kernel.dk,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 0/5] block: udpate debug messages with blk_op_str()
Date:   Mon,  1 Jul 2019 14:57:21 -0700
Message-Id: <20190701215726.27601-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This patch-series uses newly introduced blk_op_str() to improve
existing REQ_OP_XXX messages. The first two patches we change the
bio_check_ro() and submit_bio() and make debugging more clear and
get rid of the 1:M mapping of the REQ_OP_XXX to debug string
(such as printing "READ" and "WRITE") with the help of blk_op_str().

Later 3 patches are focused on changing the block_dump in submit_bio(),
so we can log all the operations and update the respective
documentation.

This is needed as we are adding more REQ_OP_XXX with last bit set 
as a part of newly introduced Zone Block Device Zone Open, Zone Close
and Zone Finish operations which are mapped to new REQ_OP_ZONE_OPEN,
REQ_OP_ZONE_CLOSE and REQ_OP_ZONE_FINISH respectively [1].

With this patch-series, we can see the following output with respective
commands which are clear including the special REQ_OP_XXX
(Write-zeroes and Discard) :-

# blkzone reset /dev/nullb0			# Reset all the zones 
# blkdiscard -o 0 -l 4096 /dev/nullb0		# discard 8 sectors 
# blkdiscard -o 0 -l 40960 /dev/nullb0		# disacrd 80 sectors  
# blkdiscard -z -o 0 -l 40960 /dev/nullb0	# write-zero 80 sectors
# dmesg  -c 

<snip>
[ 1161.922707] blkzone(10803): ZONE_RESET block 0 on nullb0 (0 sectors)
[ 1161.922735] blkzone(10803): ZONE_RESET block 524288 on nullb0 (0 sectors)
[ 1161.922750] blkzone(10803): ZONE_RESET block 1048576 on nullb0 (0 sectors)
[ 1161.922762] blkzone(10803): ZONE_RESET block 1572864 on nullb0 (0 sectors)
[ 1186.949689] blkdiscard(10834): DISCARD block 0 on nullb0 (8 sectors)
[ 1195.145731] blkdiscard(10844): DISCARD block 0 on nullb0 (80 sectors)
[ 1212.490633] blkdiscard(10854): WRITE_ZEROES block 0 on nullb0 (80 sectors)
<snip>

Regards,
Chaitanya

To: linux-mm@kvack.org
To; linux-block@ linux-block@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Jenx Axboe <axboe@kernel.dk>

[1] https://www.spinics.net/lists/linux-block/msg41884.html.

Chaitanya Kulkarni (5):
  block: update error message for bio_check_ro()
  block: update error message in submit_bio()
  block: allow block_dump to print all REQ_OP_XXX
  mm: update block_dump comment
  Documentation/laptop: add block_dump documentation

 Documentation/laptops/laptop-mode.txt | 16 ++++++++--------
 block/blk-core.c                      | 27 +++++++++++++--------------
 mm/page-writeback.c                   |  2 +-
 3 files changed, 22 insertions(+), 23 deletions(-)

-- 
2.21.0

