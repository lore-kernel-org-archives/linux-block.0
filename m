Return-Path: <SRS0=yN0i=YX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E23ECA9EC5
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 19:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E4520717
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 19:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PHfqiSi2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfJ3TxE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Oct 2019 15:53:04 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:25749 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfJ3TxE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Oct 2019 15:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1572465184; x=1604001184;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Va5jOXAJBP1rkKKyfUvPSCnF3pFNNi4CWgupH3MhljE=;
  b=PHfqiSi2tOAbNTQHrrctOCgVJReDsZyNADAwOsLXXNYiWSUJ4kz1/gD8
   gYS6qOxcbWopCwGV3R0TA7V2k2MVt+Zgc37Wo1OZOFi9LFAcsdE5cwuaX
   Xlrh7GUP/YnSyntyeWpW6WRNhIbeo3pocST1R0z/D2tk2hoTyJPhzjZ6h
   4CzTnWxCIZxKu+Pa+e2cUPoXvoC/sARU4ZbBdLd7myaewW+0mwjJUAo6M
   ekoV4t68aFWaDU69pFDvi/CpI86G1H1XYNW4IbhaOv1NFHm81/DeCcRS+
   qZ3Xb3WNigm8RYbjrkxlu/0ikxDzjV5meK3g5HAnKyVUqN0g6895jFH87
   w==;
IronPort-SDR: fbVluX+v4NVCREwNLaPnhDCxueY+D1UXpoPiom+AFYfDI6M8UXaJoW4Y23HCEMw8sGJmugJRga
 j1gu1+n30lpgqAoHn74t5Hwdopl8n5mLiKiAJdssSmbbjiInSFgkCowjDj1tst2vOBM1p7Ng+Y
 UUH0XNzKoqX4ZPbJmUBPFHlCx0mHD10fZn8HD6IsJUatHsa58BmRKUdyjTufCSxuMZZNITzHeX
 w33tQrFA8iKWvUly+J5sK8l64gyxwR+dB/ZsmoPYDFXS5nWHu1GljK+UFGvuRCedYhKBccOqYm
 +V8=
X-IronPort-AV: E=Sophos;i="5.68,248,1569254400"; 
   d="scan'208";a="126145670"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2019 03:53:04 +0800
IronPort-SDR: qC0Z/RrO+0YTIRQ9cRqhvHa7ikJsI4I/U+GwTBi10gDscmPWyLPaqBPMFJVmfwYy2++LvKeW2D
 R9b31DadFRSdIacZ2pfzUPM7EqbtAZWMKB8OzJt2sI7ma2ja/6qGqXOOmriF5t8pfkMJSFK0+b
 nK1hNU8FQV4QHm8eXMC4AnkMTAqDhzhwtNooAzfrYUSF5LeAm56srYmLNgGXZqPzI4Z/sgcFTK
 /AnovEFyl0L4fgzdKyAxoDRdKm6bR6UiHn8795w9jbqpKff2GE6vN/xjZfpj+fWKcLh4HorT4P
 aTka1KSfb4PmY9O5LcVq5MA7
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2019 12:48:26 -0700
IronPort-SDR: FTsDvfV0omZxmIGXKLmqj9dF9xc5inSnD7beIjXkkfN6N46sehqblow+0YnPOb7/XgClKP6pqm
 eQTyGVQBVmhr5fYGs8iNASYJWUq36UeeU8EEX7TjxbxiLQkHlsH5dn2o6m0oysWjWhD0TXyeE4
 h+YmwFgClAJIN1ArQPVsGzynVQR20ZYp938xWlhddG0Vzc6NUWssBTM4mYCabgw05kCWss7twi
 EVje+eIbfRLMivPUxBx777UdTtEb8DnazUu4RlAXAvDTzIaM4ykjsMq1zT8idgN+T30U+GLtcG
 t1s=
WDCIronportException: Internal
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2019 12:53:04 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [blktests PATCH 0/2] nvme: add a new test to check model attr
Date:   Wed, 30 Oct 2019 12:52:56 -0700
Message-Id: <20191030195258.31108-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This is a small patch series which adds a test to verify dynamically
configured subsystem model attribute.

Regards,
Chaitanya

Chaitanya Kulkarni (2):
  nvme: handle model attr in subsys create helper
  nvme: add new test to check model attribute

 tests/nvme/033     | 61 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/033.out |  3 +++
 tests/nvme/rc      |  4 +++
 3 files changed, 68 insertions(+)
 create mode 100755 tests/nvme/033
 create mode 100644 tests/nvme/033.out

-- 
2.22.1

