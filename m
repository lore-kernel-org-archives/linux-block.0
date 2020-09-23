Return-Path: <SRS0=LQCZ=DA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2187CC4363D
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 06:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEDEC21D43
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 06:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VX4KjO5x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgIWGTJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Sep 2020 02:19:09 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:29590 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgIWGTI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Sep 2020 02:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1600841948; x=1632377948;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Hhec5BYj6RypLE3xumu+lmtnfCoV4fVGGtCtUQZxGR8=;
  b=VX4KjO5xJieye25DVIy7qsz2paeLPPUy/yRG+QSA32dXGQPIXYS5IAd4
   oCiZMqZy4I//cwPwQCoWGcP/0tRYEWXyLgz8CUzE7vTAzONY1Tlqe/U28
   ub7XMvGJvwFUgDRTA6EEeNgGGT+/fEW45kDs0Kqr9aPrUPfrd8Xjedi3/
   I=;
X-IronPort-AV: E=Sophos;i="5.77,293,1596499200"; 
   d="scan'208";a="57152334"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-baacba05.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 23 Sep 2020 06:19:06 +0000
Received: from EX13D31EUA004.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-baacba05.us-west-2.amazon.com (Postfix) with ESMTPS id 1BB94A1C8B;
        Wed, 23 Sep 2020 06:19:03 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.162.85) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 23 Sep 2020 06:18:57 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <konrad.wilk@oracle.com>, <roger.pau@citrix.com>, <jgross@suse.com>
CC:     SeongJae Park <sjpark@amazon.de>, <axboe@kernel.dk>,
        <aliguori@amazon.com>, <amit@kernel.org>, <mheyne@amazon.de>,
        <pdurrant@amazon.co.uk>, <linux-block@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/3] xen-blk(back|front): Let users disable persistent grants
Date:   Wed, 23 Sep 2020 08:18:38 +0200
Message-ID: <20200923061841.20531-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.162.85]
X-ClientProxiedBy: EX13D10UWB001.ant.amazon.com (10.43.161.111) To
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

    $ git clone git://github.com/sjp38/linux -b pgrants_disable_v4

The web is also available:
https://github.com/sjp38/linux/tree/pgrants_disable_v4

Patch History
=============

Changes from v3
(https://lore.kernel.org/xen-devel/20200922141549.26154-2-sjpark@amazon.com/)
- Remove unnecessary ternary operation (Jürgen Groß)
- Add 'Reviewed-by: Juergen Gross <jgross@suse.com>' and
  'Acked-by: Roger Pau Monné <roger.pau@citrix.com>'

Changes from v2
(https://lore.kernel.org/linux-block/20200922105209.5284-1-sjpark@amazon.com/)
- Avoid a race condition (Roger Pau Monné)

Because the option value is written twice, there could be a race if the
user change the value meanwhile.  This version fixes the problem by
reading the value once when each (front|back)end is created.

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

