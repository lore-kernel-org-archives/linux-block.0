Return-Path: <SRS0=VMX8=US=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFECC43613
	for <linux-block@archiver.kernel.org>; Wed, 19 Jun 2019 22:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC51F2085A
	for <linux-block@archiver.kernel.org>; Wed, 19 Jun 2019 22:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JWce4OK/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfFSWB4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jun 2019 18:01:56 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:3312 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfFSWB4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jun 2019 18:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560981715; x=1592517715;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Witfux9AEOFpGPq9az6zLswozeglqKmO2j7WsPNzdkg=;
  b=JWce4OK/AmWkjCgFBi89gTAJ+26NddaPDQwC4kae9eGGVzdJsxe4jPWa
   8PlX3AW9yMA+BjWJGHHX4vRNp5RdbSquKzXPZbaWZp5ayw0HV+/TdorU/
   NX5Dl7I3+LSC/qg/J+TTLIOs8+iVUP1cQMh/FMxXpOAucK+3rMnLer4rH
   H602UlvpnT0YZjYi5CvlTa+61MboYLWanY30/d04WE2+1bHXn5HF1vIvV
   YHOpMLJnjvONi0p/ZuSGJMTH8K2yozOzAAA+l9tVt4kalLRqjs6rkfCn6
   3Ke0Gdu5/p1svoxDMrW2Omn/Sukb4U9yOQ3ON/adxXuvnSq7NIXKmO93r
   A==;
X-IronPort-AV: E=Sophos;i="5.63,394,1557158400"; 
   d="scan'208";a="112236310"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2019 06:01:55 +0800
IronPort-SDR: c2N8vXoQgewLnf+zZhftT3IsZX/XoIQam/MjA0IpxgE/o5epOSxGrBQS+kXRcr0lnVPNIQkEor
 3toGF90OjeffAyQ+pN2UgXmxlmmunI401K5SzQgy9IfABMQHeVHLhT2GjW9ortMC/HLRGDcGoe
 R2kGsYm74xnyxFH8xOW5ZQBOIeG8jk2UGY4w+Pc3c1j/VddswPZ6PEC56f0pUxs22SEK/lnrMZ
 R7AgGUNU46BnKqJaqX1kCpSb2gfPdJq8KWv76PX/8rsUH56yf4noWBUP9jgFV6ni5PE6jO1XDs
 LnkZevuwrBeze9jTw7spHjKK
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 19 Jun 2019 15:01:22 -0700
IronPort-SDR: Ag4bfNJHdPoCw/3zyqgG59tm/4h7IFTbdwAKJvJe0LP8rPiIiOPljgY99skHVi2oPOH0czRu/n
 sLzJu8pHCO6jdTvsuXWnx4JG/O8bMV5gajm9clTnFyJlWOCqkapAoQLPvSBeGWiT+QVO+/+iRS
 O3W8I2Tk1yfzh7TQuDVPrNU3yuexd2VOY+KnlLoLthBJ0Y8J3tUJSV00r6yk/+Sr1w/lNAjoIS
 9TBx7C369At8CXlL9BZlj4t2NKN3iGZQSe3U0AQL0If377tmLLFtLczkj3+6UEnSA/DDM95Pxj
 aV0=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Jun 2019 15:01:55 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 0/3] block: small fix and code cleanup for blk-mq-debugfs.c 
Date:   Wed, 19 Jun 2019 15:01:47 -0700
Message-Id: <20190619220150.6271-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This is a small code clenaup patch-series which also has a fix for
using right format-specifier for blk-mq-debugfs.c.

Please consider this for 5.3.

Regards,
Chaitanya

Chaitanya Kulkarni (3):
  block: get rid of redundant else
  block: use right format specifier for op
  block: code cleanup queue_poll_stat_show()

 block/blk-mq-debugfs.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

-- 
2.19.1

