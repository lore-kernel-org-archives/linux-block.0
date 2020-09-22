Return-Path: <SRS0=ZsbB=C7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0FAC4363D
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 14:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F4B22395C
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 14:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZMLFvINU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgIVOTT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Sep 2020 10:19:19 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:29546 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgIVOTT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Sep 2020 10:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1600784358; x=1632320358;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OBQsZyJBuiCetLUlZLSO8CKNXhhvxT++kw73YrVj7g0=;
  b=ZMLFvINUchbBnXVz1uNieZXbyHKlYC4jFKfaLbBq8yRvlC0vBvgGgSR/
   ZKwHvblAfKCDb89UvIq4ViU4iFL9SEF1S6BMQiMqs3yW90rnZMXNWFR5H
   Xhp/jL6IPUHYM7OUSLnn8Ft3+Ex/ieN+v7AjD7F00qPbvTmpLwL0nQ7pQ
   k=;
X-IronPort-AV: E=Sophos;i="5.77,291,1596499200"; 
   d="scan'208";a="70117511"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-c300ac87.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 22 Sep 2020 14:16:13 +0000
Received: from EX13D31EUA004.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-c300ac87.us-west-2.amazon.com (Postfix) with ESMTPS id DB8BCA215B;
        Tue, 22 Sep 2020 14:16:12 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.137) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 22 Sep 2020 14:16:06 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <konrad.wilk@oracle.com>, <roger.pau@citrix.com>, <jgross@suse.com>
CC:     SeongJae Park <sjpark@amazon.de>, <axboe@kernel.dk>,
        <aliguori@amazon.com>, <amit@kernel.org>, <mheyne@amazon.de>,
        <pdurrant@amazon.co.uk>, <linux-block@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/3] xen-blk(back|front): Let users disable persistent grants
Date:   Tue, 22 Sep 2020 16:15:46 +0200
Message-ID: <20200922141549.26154-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.160.137]
X-ClientProxiedBy: EX13D12UWC001.ant.amazon.com (10.43.162.78) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Persistent grants feature provides high scalability.  On some small
systems, however, it could incur data copy overheads[1] and thus it is
required to be disabled.  But, there is no option to disable it.  For
the reason, this commit adds module parameters for disabling of the
feature.

[1] https://wiki.xen.org/wiki/Xen_4.3_Block_Protocol_Scalability

Baseline and Complete Git Trees
===============================

The patches are based on the v5.9-rc6.  You can also clone the complete
git tree:

    $ git clone git://github.com/sjp38/linux -b pgrants_disable_v3

The web is also available:
https://github.com/sjp38/linux/tree/pgrants_disable_v3

Patch History
=============

Changes from v2
(https://lore.kernel.org/linux-block/20200922105209.5284-1-sjpark@amazon.com/)
- Avoid race conditions (Roger Pau Monné)

Changes from v1
(https://lore.kernel.org/linux-block/20200922070125.27251-1-sjpark@amazon.com/)
- use 'bool' parameter type (Jürgen Groß)
- Let blkfront can also disable the feature from its side
  (Roger Pau Monné)
- Avoid unnecessary xenbus_printf (Roger Pau Monné)
- Update frontend parameter doc


SeongJae Park (3):
  xen-blkback: add a parameter for disabling of persistent grants
  xen-blkfront: add a parameter for disabling of persistent grants
  xen-blkfront: Apply changed parameter name to the document

 .../ABI/testing/sysfs-driver-xen-blkback      |  9 ++++++++
 .../ABI/testing/sysfs-driver-xen-blkfront     | 11 +++++++++-
 drivers/block/xen-blkback/xenbus.c            | 22 ++++++++++++++-----
 drivers/block/xen-blkfront.c                  | 20 ++++++++++++-----
 4 files changed, 50 insertions(+), 12 deletions(-)

-- 
2.17.1

