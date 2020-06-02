Return-Path: <SRS0=F1yh=7P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD047C433DF
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 01:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9788E206A4
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 01:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TpjMgCNG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbgFBBcO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jun 2020 21:32:14 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:23290 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgFBBcN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jun 2020 21:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591061534; x=1622597534;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LWsqNXFDSN5dGSzD3ksSp1lXfh886WMlaQKqNwnVeDA=;
  b=TpjMgCNGsQN5eBkzdlgnunYZ8flEMmJFmAGZTlsL3NYsuE97GRUtqPGe
   02z8Sg7lk5tYyus7NMAaZrlcoaWujohB45LAly8XGMC26wAUV889fAp7F
   XEBToZIcpO6b9EMuwYhMzTZ/YiK8jq3qZcQ5Hw3BolvSHJZZiPU/f7FVw
   oFjHXGEn65Fgnd3nZkPchZ1FG7Eu47trmR7YDykG66O/oJQw6kG80C+1I
   33KnuO0duip0uApPbb9vXvfic+5t4hbZ3Kr60nOXPv7sN20cCNrmfDvd0
   HwlLD4Ebw1NnDJgjzwIiurkS36sbOel6/eJnr02jzX5s5ZqVf61jCPa/L
   g==;
IronPort-SDR: +kweIYVj964Bpep2MYMqmqLzVUgY9REMjKZzQP3bvY2K+7QfsyJIdnHqQe91fL/p3VE6VXWmhm
 rV2JDzwqJgM5d6yTSPQZaLZIkm1gmBcARWB1oETlfQCk2C69GtVP67wZqCTunElgvy4/yHi3vt
 vLpY6qsDyEaPvGIJxbTKDxSUOkXTbBf3qO1YA4GTvnBSoN9KDI2xsaXGeYsnhjlzGAi5ka3DAI
 YW72rSaOnzA3sqH5/da/vXCTuR2Zy0U9jyqEkK1IutD0lmn24YGuWi56blD+fawvOE6/hUh4Jp
 4gs=
X-IronPort-AV: E=Sophos;i="5.73,462,1583164800"; 
   d="scan'208";a="143316948"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2020 09:32:14 +0800
IronPort-SDR: sPsZJm31w6wFBp/1SsNIEvc/CazkD/twQyMXFLlo6ExKauwCbqWcfWJhLYWJr2tIBE+K7uxHVW
 fDrQn8DeSX0C1ZML17A1p+WMzjhmhel/s=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 18:21:54 -0700
IronPort-SDR: B3di77VUgRNksdDSabw+yFu1V2mih4CIR4y/s/bIBXeiD+GTwzE9rWm+Nvp2Vhguak+qT1Ynsx
 /tNQt9QwyQSw==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 01 Jun 2020 18:32:13 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 0/4] blktrace: fix sparse warnings
Date:   Mon,  1 Jun 2020 18:32:04 -0700
Message-Id: <20200602013208.4325-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This is a small patch-series which fixes various sparse warnings.

Regards,
Chaitanya

Chaitanya Kulkarni (4):
  blktrace: use rcu calls to access q->blk_trace
  blktrace: use errno instead of bi_status
  blktrace: fix endianness in get_pdu_int()
  blktrace: fix endianness for blk_log_remap()

 kernel/trace/blktrace.c | 48 +++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

-- 
2.22.1

