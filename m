Return-Path: <SRS0=q4M6=7R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2524C433DF
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 07:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0F8F2075B
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 07:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cQS9n0RN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgFDHNe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Jun 2020 03:13:34 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:16987 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgFDHNe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Jun 2020 03:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591254813; x=1622790813;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SpdlIFVjWoO2WvkLwT3J+V5nzb/enwHxwpGE0yZt+IE=;
  b=cQS9n0RNC1ZyDV5C6SHxP5OjYFNSoianO/luo8PFLDDyjTrCLjQoL4VG
   ncsoBJ1jDZ2sr/SXhqOqWRpT2peCIi59jKOBvkAOgmNo5zNyxkkSmRXyM
   d5gULJqpbGAk+4bNG8pDSlUiJIGG4ldRFyZ0/q1sPorni5DyB2qWGhzbN
   2+Ks//VXDyaetFOM4rZeBnuwGSqXCGm5mpQo2Sv2BHy2StrmHBuideSC/
   CsMsSzmmnDFPSRhf1hEoOGq3IZaAmP0MavK2yNC6GQ8lWCQoW78sh6KqC
   uBmqvCb9KJqXO8RQJfKqQl1ilMiZFKOdWOo+Qmq36d4Kg9gXfzTfP4okR
   w==;
IronPort-SDR: cPKqMBcDGeEZMj9nfzF1z/OJi7w7oQ+MKBGukd5UosW3Loke7S9a7RneGBgnQIum5RdQ/0OVvH
 i+435XALzs2nSPlp9asgJFic+PPgXZU0/tyuE2QfjaT40gyUzilv8NU+dOYZdPoesSHAFacIpe
 w/QLlmmMaIzU3TDdmjsd/JhBtmwrzs91IP9lvP3f0qogQHwIZffAfp42HAorG6ND+vMFTJp7qR
 PaQ0yGAQGhQkm50MS5lp9EWWmIL0WettMsw1n/E0YOGeL1WhdJYfIP5gN8I+pfMCpQbDzm4HvA
 zxA=
X-IronPort-AV: E=Sophos;i="5.73,471,1583164800"; 
   d="scan'208";a="143505796"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jun 2020 15:13:33 +0800
IronPort-SDR: KlpB2Dhou2rqPaG46OcVcght7Xqn9gP4TWqqY9LjqLY2Aobh3taY23/iZA84TqyfDaRc7gscUt
 4zZOKp/PPyoJIILhg/Jcde1KCYp76xNdg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2020 00:02:37 -0700
IronPort-SDR: TOZ7hde2pokcIiwbuYfCO7HwPGiP5bKlPPARiK3iS8U0RN2iKcytUn26F+SvRstAwshnV4Cgsp
 TG+Xfwk8qhIQ==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Jun 2020 00:13:33 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 0/4] blktrace: fix sparse warnings
Date:   Thu,  4 Jun 2020 00:13:27 -0700
Message-Id: <20200604071330.5086-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This is a small patch-series which fixes various sparse warnings.

Regards,
Chaitanya

* Changes from V1:-

1. Get rid of the first patch since Jan already posted similar
   patch.

Chaitanya Kulkarni (3):
  blktrace: use errno instead of bi_status
  blktrace: fix endianness in get_pdu_int()
  blktrace: fix endianness for blk_log_remap()

 kernel/trace/blktrace.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

-- 
2.22.1

