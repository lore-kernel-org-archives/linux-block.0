Return-Path: <SRS0=mQXl=Z7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83ECCC43603
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 08:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A40207FD
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 08:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bq9Malpg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfLII7R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Dec 2019 03:59:17 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:16802 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfLII7R (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Dec 2019 03:59:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575881957; x=1607417957;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=LGTA5TBkns2swo7rzErYEaOZnrGxFvudwmigEUBWSbw=;
  b=bq9MalpgtYVPszaKwKWPam2iaN4VtgL2S/AJaNjpRMmgUj6el5XF0dba
   th9oPnA4PyRyeljinM8C3EpJl1RMw8xCTvzvhbmcGpKh9cw473UNKbf1t
   s023OJ5WC5kwzp43bQdSboQooCnQUTIo7Dbi6FGZGp9lDslJv5TItIrGf
   g=;
IronPort-SDR: dJUnx6CEDqktFiRuiiivz/Sg1VkDOSdNj1YmovhDEEj21n8RIw7fJ4f1q0sB0LgpCJeF+6bCPY
 PixdBF2EnBzw==
X-IronPort-AV: E=Sophos;i="5.69,294,1571702400"; 
   d="scan'208";a="7696916"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 09 Dec 2019 08:59:16 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (Postfix) with ESMTPS id E2691A1E75;
        Mon,  9 Dec 2019 08:59:13 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 08:59:12 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.249) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 08:59:08 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <axboe@kernel.dk>, <konrad.wilk@oracle.com>, <roger.pau@citrix.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pdurrant@amazon.com>, <sj38.park@gmail.com>,
        <xen-devel@lists.xenproject.org>, SeongJae Park <sjpark@amazon.com>
Subject: [PATCH v3 0/1] xen/blkback: Squeeze page pools if a memory pressure
Date:   Mon, 9 Dec 2019 09:58:38 +0100
Message-ID: <20191209085839.21215-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.249]
X-ClientProxiedBy: EX13D29UWA001.ant.amazon.com (10.43.160.187) To
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
set of the limit can results in the memory pressure or a resource
underutilization.  This commit avoids such problematic situations by
squeezing the pools (returns every free page in the pool to the system)
for a while (users can set this duration via a module parameter) if a
memory pressure is detected.


Base Version
------------

This patch is based on v5.4.  A complete tree is also available at my
public git repo:
https://github.com/sjp38/linux/tree/blkback_aggressive_shrinking_v3


Patch History
-------------

Changes from v2 (https://lore.kernel.org/linux-block/af195033-23d5-38ed-b73b-f6e2e3b34541@amazon.com)
 - Rename the module parameter and variables for brevity (aggressive
   shrinking -> squeezing)

Changes from v1 (https://lore.kernel.org/xen-devel/20191204113419.2298-1-sjpark@amazon.com/)
 - Adjust the description to not use the term, `arbitrarily` (suggested
   by Paul Durrant)
 - Specify time unit of the duration in the parameter description,
   (suggested by Maximilian Heyne)
 - Change default aggressive shrinking duration from 1ms to 10ms
 - Merge two patches into one single patch

SeongJae Park (1):
  xen/blkback: Squeeze page pools if a memory pressure is detected

 drivers/block/xen-blkback/blkback.c | 35 +++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

-- 
2.17.1

