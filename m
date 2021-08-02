Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49958C4338F
	for <linux-block@archiver.kernel.org>; Mon,  2 Aug 2021 09:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ABB461050
	for <linux-block@archiver.kernel.org>; Mon,  2 Aug 2021 09:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbhHBJWI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Aug 2021 05:22:08 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:7966 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbhHBJWH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Aug 2021 05:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1627896117; x=1659432117;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dS64B1Hguk03MTVG4eISsUOlnFoS8zjjgXUXTCjAGkQ=;
  b=NlkXd1tm8yXGK0J85rcRD9ZQ6ulX4/5FwdS2KE30VjIEvzzbdjEMr95n
   JWc0fWpNdznQ4ussphSTk5dZrf64iwWTsf/jMfu8z4Kkyx0Fr4FhV1A2t
   0xKS0Ciu1IWTgxRtQO4qTANShOXc5ay8VtCLHDqRaZ3QGZdPxuumlSapM
   layyYvk6iFtupLIrogTXxv5f2tQZFlTeGPbbhFLd9bGo4cZ+ZtZTnhL6U
   wAbnNBWFKl2BVpJNIsUmvBFSJ4kcWOC+coAP0hhM5BE/ktAH+SBpANo+i
   a1Na9+Qeyp7CZQ6bflMTdsyEHnuC/d2PCceDE6NIv2TWmX06e7GnsURZ0
   A==;
X-IronPort-AV: E=Sophos;i="5.84,288,1620662400"; 
   d="scan'208";a="180888878"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2021 17:21:57 +0800
IronPort-SDR: rQtU45S3bm58Y0WVAbUjOmbK5+PMCKIT2ktFxoEVTRYRVYNuVog/48jqzonFiG+lzzPd8aoS15
 CbUckoQhFkdNUGB1kI4qyW4Wb2KDLOCXm3Jyfi5cBqi8ph55Bjn40vtvJPuncldv/DgC4q+qL3
 bH4TmB8JlI+t13YL1fKlY7vgrzc79upFodxrIyGNVwENNDCJOqVRWQiWhUsdWmQbRYB83FD2BI
 T8RL5Ie6LWSWZ4oiWcEJrb1ELcIoyu9Yd87ra3h2uvATe3sietOUAijFgE4pgKhpTHLAgjyugU
 l6lKU0N+Tt8i1DNGzX3yPSAV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 01:57:39 -0700
IronPort-SDR: NAslBYHfWzbL5cVZLuEhkJKZ7sYNqBYAAtFS5r/sJK+a4NYlPJmJC39JclgzyuYqbOUaE/QNF2
 d4mV/ijYD2qSFyqSmZ97yqEsQf1EcU4rRgSVVr+5k8g8ZhnjYJ9F5DMRpVXsGqaXBZxIZ+oL/9
 28b296/xwCBai3U57DU+2wB3Gh///Tqe4HajJ+zJG1dzGikGcHpIdYpMnNSKzDGfwVBtzVTU42
 b7nZlf4K4aNLVht4E8OR4X9U6dE47PLmiNHGlK1EUc6tukptsz+F3kWnu97XvZ+MRAxsQ8r3zQ
 JZQ=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Aug 2021 02:21:57 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 0/3] IO priority fixes and improvements
Date:   Mon,  2 Aug 2021 18:21:54 +0900
Message-Id: <20210802092157.1260445-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series fix problems with IO priority values handling and renames
one macro to clarify the intended usage.

Damien Le Moal (3):
  block: bfq: fix bfq_set_next_ioprio_data()
  block: fix ioprio interface
  block: rename IOPRIO_BE_NR

 block/bfq-iosched.c         |  8 ++++----
 block/bfq-iosched.h         |  4 ++--
 block/bfq-wf2q.c            |  6 +++---
 block/ioprio.c              |  3 +--
 fs/f2fs/sysfs.c             |  2 +-
 include/linux/ioprio.h      |  5 ++---
 include/uapi/linux/ioprio.h | 19 ++++++++++++++-----
 7 files changed, 27 insertions(+), 20 deletions(-)

-- 
2.31.1

