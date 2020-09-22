Return-Path: <SRS0=ZsbB=C7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E58C2D0E2
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 10:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EB3423A1B
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 10:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gPa/2lH6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgIVKwf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Sep 2020 06:52:35 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:5742 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIVKwf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Sep 2020 06:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1600771955; x=1632307955;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aiJBVDikZ4ujUlt8UYpyM0mSMq9hUSVyyV0F7i7fx80=;
  b=gPa/2lH6P8YCaDBoOSzIK31GA0bISa1x0KpUxN/ixMiY2L/YN4BCIYrc
   3RvIHbiNZVapKfU/4qFv3+jbZOzdLad9Cxaiwg1HScOlk6zBzBg78vNSl
   7D433NeK/6hysew3aUOcnfOAwd10oGQQQGfk65RmEaZcDNa4GjUWrBqgv
   k=;
X-IronPort-AV: E=Sophos;i="5.77,290,1596499200"; 
   d="scan'208";a="55547558"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 22 Sep 2020 10:52:34 +0000
Received: from EX13D31EUA004.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com (Postfix) with ESMTPS id CB54FA05DE;
        Tue, 22 Sep 2020 10:52:31 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.162.35) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 22 Sep 2020 10:52:26 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <konrad.wilk@oracle.com>, <roger.pau@citrix.com>, <jgross@suse.com>
CC:     SeongJae Park <sjpark@amazon.de>, <axboe@kernel.dk>,
        <aliguori@amazon.com>, <amit@kernel.org>, <mheyne@amazon.de>,
        <pdurrant@amazon.co.uk>, <linux-block@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/3] xen-blk(back|front): Let users disable persistent grants
Date:   Tue, 22 Sep 2020 12:52:06 +0200
Message-ID: <20200922105209.5284-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.162.35]
X-ClientProxiedBy: EX13D14UWB003.ant.amazon.com (10.43.161.162) To
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

    $ git clone git://github.com/sjp38/linux -b pgrants_disable_v2

The web is also available:
https://github.com/sjp38/linux/tree/pgrants_disable_v2

Patch History
=============

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

 .../ABI/testing/sysfs-driver-xen-blkback      |  9 ++++++
 .../ABI/testing/sysfs-driver-xen-blkfront     | 11 +++++++-
 drivers/block/xen-blkback/xenbus.c            | 28 ++++++++++++++-----
 drivers/block/xen-blkfront.c                  | 28 +++++++++++++------
 4 files changed, 60 insertions(+), 16 deletions(-)

-- 
2.17.1

