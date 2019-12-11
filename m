Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCFFC2D0C6
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 15:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41097208C3
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 15:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SznFw/xu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387957AbfLKPaG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:30:06 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:61065 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387678AbfLKPaF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 10:30:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1576078206; x=1607614206;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I98AkRNnVsqEIMz+PpHt6g7o9OQDRo5l2g1aJ7GfB9Q=;
  b=SznFw/xuHRbVMsimRs6KWC0/wmrVE3eWHpGWdj/CrlRl9hlIcUTh7usk
   eDFhqFyPuFG5xUBx+JLoBdtvUK+Dn8VguQ7V5/DnQpanyAXGPlHWLR/aN
   pGuBmHbC5vkcOVx3s1D+Pq7l+FNQn+fP4UWno7qjVJvQVld+Hoz1UjrIK
   Q=;
IronPort-SDR: IbA0eeW8YkrsZbxF5SNM+6aBwOIGfC6wXuDx2Q/Ksp4NoI47rdXO4mMdPlemRy6g0GNUzFZKi4
 X9weZ9SP2b5g==
X-IronPort-AV: E=Sophos;i="5.69,301,1571702400"; 
   d="scan'208";a="8046823"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-119b4f96.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 11 Dec 2019 15:30:03 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-119b4f96.us-west-2.amazon.com (Postfix) with ESMTPS id 1055B1A21C8;
        Wed, 11 Dec 2019 15:30:02 +0000 (UTC)
Received: from EX13D32EUC001.ant.amazon.com (10.43.164.159) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Dec 2019 15:30:01 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D32EUC001.ant.amazon.com (10.43.164.159) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Dec 2019 15:29:59 +0000
Received: from u2f063a87eabd5f.cbg10.amazon.com (10.125.106.135) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Wed, 11 Dec 2019 15:29:57 +0000
From:   Paul Durrant <pdurrant@amazon.com>
To:     <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Paul Durrant <pdurrant@amazon.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>
Subject: [PATCH v3 0/4] xen-blkback: support live update
Date:   Wed, 11 Dec 2019 15:29:52 +0000
Message-ID: <20191211152956.5168-1-pdurrant@amazon.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Patch #1 is clean-up for an apparent mis-feature.

Paul Durrant (4):
  xenbus: move xenbus_dev_shutdown() into frontend code...
  xenbus: limit when state is forced to closed
  xen/interface: re-define FRONT/BACK_RING_ATTACH()
  xen-blkback: support dynamic unbind/bind

 drivers/block/xen-blkback/xenbus.c         | 56 +++++++++++++++-------
 drivers/xen/xenbus/xenbus.h                |  2 -
 drivers/xen/xenbus/xenbus_probe.c          | 35 ++++----------
 drivers/xen/xenbus/xenbus_probe_backend.c  |  1 -
 drivers/xen/xenbus/xenbus_probe_frontend.c | 24 +++++++++-
 include/xen/interface/io/ring.h            | 29 ++++-------
 include/xen/xenbus.h                       |  1 +
 7 files changed, 81 insertions(+), 67 deletions(-)
---
v3:
 - Only patch #4 modified

Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Juergen Gross <jgross@suse.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: "Roger Pau Monné" <roger.pau@citrix.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
-- 
2.20.1

