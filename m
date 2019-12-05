Return-Path: <SRS0=S578=Z3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B887C43603
	for <linux-block@archiver.kernel.org>; Thu,  5 Dec 2019 15:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB412464F
	for <linux-block@archiver.kernel.org>; Thu,  5 Dec 2019 15:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="IY1MaMtR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbfLEPKB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Dec 2019 10:10:01 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:28947 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729489AbfLEPKB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Dec 2019 10:10:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575558601; x=1607094601;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=RhN83U79KGiug/DqnaKKmeMZRDu4agOCS4+3MlYgIcA=;
  b=IY1MaMtRUY+RdHBM63xh5CnjtuO7HM96sgRrmNsti1MiObj0VGgRZL/6
   e0kdoplp012yegt9tTYH0icpn6vnCiHr3JXSzGJ2yykqoki88/WoWwCdR
   6qscwccNjh8KuBA7FTYu23C+Fyhgh/ReTg3Fl33J30Srzp9EYufI4ObEh
   0=;
IronPort-SDR: YkV7+81dJRbl1HNaiFtPHjNfYTyCwi315t/o+FBhltEeGD9GAPnrnM4iyjJOh2tifi2xsX9Dn/
 Xk9xMukUoMRw==
X-IronPort-AV: E=Sophos;i="5.69,281,1571702400"; 
   d="scan'208";a="7220372"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-98acfc19.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 05 Dec 2019 15:09:59 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-98acfc19.us-east-1.amazon.com (Postfix) with ESMTPS id 7D494A2529;
        Thu,  5 Dec 2019 15:09:56 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Dec 2019 15:09:55 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.171) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Dec 2019 15:09:51 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <axboe@kernel.dk>, <konrad.wilk@oracle.com>, <roger.pau@citrix.com>
CC:     <sjpark@amazon.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sj38.park@gmail.com>
Subject: [PATCH v2 0/1] xen/blkback: Aggressively shrink page pools if a memory pressure is detected
Date:   Thu, 5 Dec 2019 16:09:31 +0100
Message-ID: <20191205150932.3793-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.171]
X-ClientProxiedBy: EX13D12UWA004.ant.amazon.com (10.43.160.168) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Each `blkif` has a free pages pool for the grant mapping.  The size of
the pool starts from zero and be increased on demand while processing
the I/O requests.  If current I/O requests handling is finished or 100
milliseconds has passed since last I/O requests handling, it checks and
shrinks the pool to not exceed the size limit, `max_buffer_pages`.

Therefore, `blkfront` running guests can cause a memory pressure in the
`blkback` running guest by attaching a large number of block devices and
inducing I/O.  System administrators can avoid such problematic
situations by limiting the maximum number of devices each guest can
attach.  However, finding the optimal limit is not so easy.  Improper
set of the limit can result in the memory pressure or a resource
underutilization.  This commit avoids such problematic situations by
shrinking the pools aggressively (further the limit) for a while (users
can set this duration via a module parameter) if a memory pressure is
detected.


Base Version
------------

This patch is based on v5.4.  A complete tree is also available at my
public git repo:
https://github.com/sjp38/linux/tree/blkback_aggressive_shrinking_v2


Patch History
-------------

Changes from v1 (https://lore.kernel.org/xen-devel/20191204113419.2298-1-sjpark@amazon.com/)
 - Adjust the description to not use the term, `arbitrarily` (suggested
   by Paul Durrant)
 - Specify time unit of the duration in the parameter description,
   (suggested by Maximilian Heyne)
 - Change default aggressive shrinking duration from 1ms to 10ms
 - Merged two patches into one single patch


SeongJae Park (1):
  xen/blkback: Aggressively shrink page pools if a memory pressure is
    detected

 drivers/block/xen-blkback/blkback.c | 35 +++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

-- 
2.17.1

