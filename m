Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4BAC31E49
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BFA20B7C
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KpmAvCMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732457AbfFMPFQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:05:16 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:51275 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732456AbfFMOQg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 10:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560435415; x=1591971415;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2IrC1BtGXngFof1hqLZYq5xUyLgWadU1uxzxHHLzaew=;
  b=KpmAvCMaoYv7+P7J24gM8ZTTMMIdrgIP3UzQbB3ErW6R854j6ozTuHLl
   MvyMy+B5jgdkffRsgsKs45xtaAlDnF7n/x9rsZa6Fm2lwg4Bx1p7PAbvm
   l3X5tMuY8G5JmEIXxwHTRhiowZUkwKoYn5on2+z/vJRUf8ByWqzMiFodD
   ypXocLV7Vo80DdUeVWmmfyC7EDyxv6FP7Wq6goSBh70Ts7VydlUGhxxuQ
   UxYUasSH9I2GfKru1elk/WR3Q9knMiyYMYDdcGEg/iEpkcknMCD/yHP+k
   dUk7y85plBp8gG8kh9cbaPcdeyTkD/79YrbZerh4IsV3J79KW8cgrFLat
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,369,1557158400"; 
   d="scan'208";a="210177613"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2019 22:16:55 +0800
IronPort-SDR: +u70w5VAmyTEYGudG9u7e4sXNhIfDNV8jOc7Pn6Mm/vfE4q+Ofy50S3VwSJdMPRlkECA3O2jf4
 64kf5lTzvxi4TdZIXzaGjGOAv9+4mwLIm0qr3ZSLo15oFVzHrwC8AQi8gVrfEzJFgo6wmQ5h41
 XYDsxhVfInaldY3m226mlSJORyX7g2lAa7zCSOzi0JUZxqY/ANg65cu6xXxOke2kH9J/0zKH6+
 nXs2U8Ac14YfxrdoFhEBtV9u/qCYmif9gRloG2NLgjJeKWmgoQKHggBSVpDqV5dB2OLe81khPa
 +RMHo3moCp+pJPdxDK7cNgkb
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 13 Jun 2019 07:16:19 -0700
IronPort-SDR: wKxkHhS5/sT3VrU3EFJp8tXP5izgATSON2KdUWoHfqss7XTYJaNXLahM6hjWtmAxOL4qaDGmI3
 2Ph8/dEqbSvyqQJAlKScEuHYHJUyfuFN6KNGmjXUzi8jl80nBTpB+20BIbMQOydXRwyYB2X2kI
 CKx+fNTVs7eZerQyfBGxTQFbeytd865W2rsOnh/3uJymfanRkGqqOKjshPPnPxo4zHp/373OTd
 dUDO4mnYRsfxKok4JvJAe+dJcApcKmgXjW/1+beJyWrXGUy7Rx7f1tntaqeDAsyMIhzKQbQ3XC
 Fzw=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 13 Jun 2019 07:16:35 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, hare@suse.com, bvanassche@acm.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 0/2] block: improve print_req_error
Date:   Thu, 13 Jun 2019 07:16:27 -0700
Message-Id: <20190613141629.2893-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This patch-series is based on the initial patch posted by 
Christoph Hellwig <hch@lst.de>. I've added one more patch to improve
print message.

While debugging the driver and block layer this print message is very
handy.

Please consider this for 5.3.

Following is the sample error message with forced REQ_OP_WRITE,
REQ_OP_WRITE_ZEROES and REQ_OP_DISCARD failure from modified null_blk
for testing :-

 blk_update_request: I/O error, dev nullb0, sector 0 op 0x9:(WRITE_ZEROES) flags 0x400800 phys_seg 0 prio class 0
 blk_update_request: I/O error, dev nullb0, sector 0 op 0x3:(DISCARD) flags 0x800 phys_seg 1 prio class 0
 blk_update_request: I/O error, dev nullb0, sector 0 op 0x1:(WRITE) flags 0x800 phys_seg 1 prio class 0

I've fixed all the review comments except the one for which we want to
use the newly added function in the include/trace/events/f2fs.h as f2fs
code is highly coupled with the tracing structures. I'll make a separate
patch for that change as needed.

Thanks,
-Chaitanya

Changes from V1:-
1. Get rid of the function switch case and use the passtern similar to
   block/blk-mq-debuffs.c(Bart).

Chaitanya Kulkarni (1):
  block: add more debug data to print_req_err

Christoph Hellwig (1):
  block: improve print_req_error

 block/blk-core.c | 45 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 7 deletions(-)

-- 
2.19.1

