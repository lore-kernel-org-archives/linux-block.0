Return-Path: <SRS0=mQXl=Z7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EC5C43603
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 19:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624402077B
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 19:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BPe1bK9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfLITnj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Dec 2019 14:43:39 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:7685 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfLITnj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Dec 2019 14:43:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575920618; x=1607456618;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=btD2JRZhVDkxSHuvs58naEsL/hzccbUCmnMRHNEsydY=;
  b=BPe1bK9eR5pDXLan+nGUnUoTRVpbHW9Rnu974cz3PTe2lrVJTStSyaeG
   6pZ/cxKSpZZY0wkOcUS3b6jKWFGVALebEJ+sFw/aueDIUrKtYnseDo6bm
   cSp5PgOR6gACvFAcF9SzEL2rhqxo38VB+bAa8JPUqOs068gfhdSINmZse
   s=;
IronPort-SDR: LWb51GX+9fpQvb/S+Gumgfr5Hv6hVjPPlu5WQ4w5c4OnFTkUArSEPtKULLgbgEscFCGd9SzGr9
 QaTjsTV+T5BQ==
X-IronPort-AV: E=Sophos;i="5.69,296,1571702400"; 
   d="scan'208";a="7798298"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 09 Dec 2019 19:43:35 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com (Postfix) with ESMTPS id 6D939A1764;
        Mon,  9 Dec 2019 19:43:34 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 19:43:33 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.179) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 19:43:29 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <sjpark@amazon.com>
CC:     <axboe@kernel.dk>, <konrad.wilk@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pdurrant@amazon.com>, <roger.pau@citrix.com>,
        <sj38.park@gmail.com>, <xen-devel@lists.xenproject.org>
Subject: [PATCH v4 0/2] xenbus/backend: Add a memory pressure handler callback
Date:   Mon, 9 Dec 2019 20:43:03 +0100
Message-ID: <20191209194305.20828-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.179]
X-ClientProxiedBy: EX13D30UWC003.ant.amazon.com (10.43.162.122) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Granting pages consumes backend system memory.  In systems configured
with insufficient spare memory for those pages, it can cause a memory
pressure situation.  However, finding the optimal amount of the spare
memory is challenging for large systems having dynamic resource
utilization patterns.  Also, such a static configuration might lacks a
flexibility.

To mitigate such problems, this patchset adds a memory reclaim callback
to 'xenbus_driver' (patch 1) and use it to mitigate the problem in
'xen-blkback' (patch 2).

Base Version
------------

This patch is based on v5.4.  A complete tree is also available at my
public git repo:
https://github.com/sjp38/linux/tree/blkback_squeezing_v4


Patch History
-------------

Changes from v3 (https://lore.kernel.org/xen-devel/20191209085839.21215-1-sjpark@amazon.com/)
 - Add general callback in xen_driver and use it (suggested by Juergen
   Gross)

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

SeongJae Park (2):
  xenbus/backend: Add memory pressure handler callback
  xen/blkback: Squeeze page pools if a memory pressure is detected

 drivers/block/xen-blkback/blkback.c       | 23 +++++++++++++++--
 drivers/block/xen-blkback/common.h        |  1 +
 drivers/block/xen-blkback/xenbus.c        |  3 ++-
 drivers/xen/xenbus/xenbus_probe_backend.c | 31 +++++++++++++++++++++++
 include/xen/xenbus.h                      |  1 +
 5 files changed, 56 insertions(+), 3 deletions(-)

-- 
2.17.1

