Return-Path: <SRS0=kXjy=ZV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAA6C432C0
	for <linux-block@archiver.kernel.org>; Fri, 29 Nov 2019 13:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1E821736
	for <linux-block@archiver.kernel.org>; Fri, 29 Nov 2019 13:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dT9eGUJg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfK2Nn0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Nov 2019 08:43:26 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:26126 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfK2Nn0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Nov 2019 08:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575035007; x=1606571007;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gGsSfx1myZMKWjLhcQmL/KhY8dJbxitTdWSORveJf/4=;
  b=dT9eGUJgCoT24RFtw/nJDqzqWDC/mO6doUIKoG+HLdRls0waukBUOrCK
   p/lCGsP/GThabldL79PNGSikY9HbD3Y/Dx02lPzLNQlCvW3RzqCD0g+Sn
   +M0bWhLkydzleDYy7D43Bua1NVeLi/bcMYYvo7uihNfj76UG1leN033Tx
   w=;
IronPort-SDR: 9Z4VXqgUgl6ztGBfkyLWPSoDU8urendnEIqu7YDAXMvEkMG1OwI9fNzcf6m5u/cyRx7ldqWX8S
 Dak3Kl206Eig==
X-IronPort-AV: E=Sophos;i="5.69,257,1571702400"; 
   d="scan'208";a="2174009"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 29 Nov 2019 13:43:15 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (Postfix) with ESMTPS id 5235CA1F19;
        Fri, 29 Nov 2019 13:43:12 +0000 (UTC)
Received: from EX13D32EUC001.ant.amazon.com (10.43.164.159) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 29 Nov 2019 13:43:12 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D32EUC001.ant.amazon.com (10.43.164.159) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 29 Nov 2019 13:43:10 +0000
Received: from u2f063a87eabd5f.cbg10.amazon.com (10.125.106.135) by
 mail-relay.amazon.com (10.43.62.226) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Fri, 29 Nov 2019 13:43:10 +0000
From:   Paul Durrant <pdurrant@amazon.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>
CC:     Paul Durrant <pdurrant@amazon.com>
Subject: [PATCH v2 0/2] allow xen-blkback to be cleanly unloaded
Date:   Fri, 29 Nov 2019 13:43:04 +0000
Message-ID: <20191129134306.2738-1-pdurrant@amazon.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Paul Durrant (2):
  xen/xenbus: reference count registered modules
  block/xen-blkback: allow module to be cleanly unloaded

 drivers/block/xen-blkback/blkback.c |  8 ++++++++
 drivers/block/xen-blkback/common.h  |  3 +++
 drivers/block/xen-blkback/xenbus.c  | 11 +++++++++++
 drivers/xen/xenbus/xenbus_probe.c   |  8 +++++++-
 4 files changed, 29 insertions(+), 1 deletion(-)

-- 
2.20.1

