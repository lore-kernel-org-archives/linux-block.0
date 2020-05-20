Return-Path: <SRS0=ALdW=7C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99E1C433E0
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 23:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADD6120873
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 23:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LYzgmd1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgETXB6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 May 2020 19:01:58 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:7017 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728648AbgETXB5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 May 2020 19:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590015718; x=1621551718;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qXsl8U17vLuhHsBDnCMNr+kA9HO3J7iekws8JmieJ84=;
  b=LYzgmd1GtkJ07ZlpCKDqb5Vpijvp8XqY/SNScgGvhPI1S8hcpAn5HIxD
   DUjryQG7VA4NPH1ktPQsmsVNvZUY9Vm+yMTCkSVWz3Yssel7NUk4Y+fuz
   6z4G4rs20Jag0vgAMjiCPF4unmZk+9RVy+lXfEQhW+qGtrOYEQnRtS7eC
   9NGk8/oFNF7BRvyL4Na5LUhugV/F45yEF2B9HJM1GoPN3ErKZS3U59wH5
   LAGsTLxeBSv5xsLND4kVusFg1ZlO4de9yLLicJbpXCTkR6Rybn161TNA5
   XqdNkflmsCKI1BYtbl/biKuijS0xLfG6tDYbazTck3UbKtnJ0gUyJsiL3
   w==;
IronPort-SDR: niiKJnVcaxMrNeM90mcG+rWOv14Y3J9wyeKUgUA87/nQjWPNI4PezpP/SeLuB/Rb2AWifXyst0
 aczB+xSh2lbdOrKjcbtUn+8oqNQVltu1XHDh6qVi6jq8c5xQTvz272ntV3XlDffXqg6yxcMD2+
 K1wdXCXTTQ8KxO09C7q+peX1h+h0Com2j/ybIMHQCWUaNP3SJgdjuUAqJ/OFJQHkz3IVnPzpsl
 1rj6xXjYMUX8zgaSgNIYTfeRlhyei7RMhNrwV4c0qtgwFA9edXq7ZasHVuEwGTrzhdkssY0Iyw
 Z80=
X-IronPort-AV: E=Sophos;i="5.73,415,1583164800"; 
   d="scan'208";a="142501774"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2020 07:01:58 +0800
IronPort-SDR: 9DE4uPmWG7hH9HtO8Fq7Qrq0JM96dNn9PnqgM1Lqm4vMJgbrp75zGAC/w17C2NvBblG3g/OBRy
 JinF77P1yvyTlTNpUOpHpEaRu+4mOxfrQ=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 15:51:25 -0700
IronPort-SDR: hHj+8ZkRtUNpcmJIpUD3KIVL7syPtTtKrV1dS+1g7ioLLSl6hmYA+s7I3J1ltV8VQE5+o6OzLL
 XEtccPsrsegA==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 May 2020 16:01:57 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 0/2]null_blk: small fixes for zoned mode
Date:   Wed, 20 May 2020 16:01:50 -0700
Message-Id: <20200520230152.36120-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This is a small patch-series which fixes potential oops for zoned mode.
Also, it disables the discard when nullb configured as zoned for
membacked mode.

Regards,
Chaitanya

Chaitanya Kulkarni (2):
  null_blk: return error for invalid zone size
  null_blk: don't allow discard for zoned mode

 drivers/block/null_blk_main.c  | 7 +++++++
 drivers/block/null_blk_zoned.c | 4 ++++
 2 files changed, 11 insertions(+)

-- 
2.22.1

