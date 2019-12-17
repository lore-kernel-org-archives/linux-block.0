Return-Path: <SRS0=G4H8=2H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350EFC43603
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 16:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6F724679
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 16:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bnCH8CLC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfLQQIf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Dec 2019 11:08:35 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:31058 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfLQQIf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Dec 2019 11:08:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1576598913; x=1608134913;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k0I76KDoH+Ci1ztva7Qrivr8vQ9oSswMnJqX6noDdf0=;
  b=bnCH8CLC6cHzIOkJWWrL9F8GQqIt7VJugsVm84TG+oeZbNBbjQZFeDoh
   ap17zB/foSnKYUJlQjHu1+kP0UG7427f24jBwQJg5DxYZB5sBPkDNuDIj
   vlcAZPBk29YdapHUjeL5QxesX1c9MC1PbnkS2M3JDhkKXcRBGPl9dGIEV
   Y=;
IronPort-SDR: Qfa0OSQrrFWYCmyV+k2qrt5bWTKPedxp2SKK8tZsK9VZpq9mHDZnDdKRNjLUEfwgyCCzGs2OOD
 LC8tOGTXcTzA==
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="5642827"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-22cc717f.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 17 Dec 2019 16:08:22 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-22cc717f.us-west-2.amazon.com (Postfix) with ESMTPS id 925E6A25DB;
        Tue, 17 Dec 2019 16:08:19 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 17 Dec 2019 16:08:19 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.179) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 17 Dec 2019 16:08:14 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <jgross@suse.com>, <axboe@kernel.dk>, <konrad.wilk@oracle.com>,
        <roger.pau@citrix.com>
CC:     SeongJae Park <sjpark@amazon.com>, <pdurrant@amazon.com>,
        <sj38.park@gmail.com>, <xen-devel@lists.xenproject.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 0/6] xenbus/backend: Add a memory pressure handler callback
Date:   Tue, 17 Dec 2019 17:07:42 +0100
Message-ID: <20191217160748.693-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.161.179]
X-ClientProxiedBy: EX13d09UWC002.ant.amazon.com (10.43.162.102) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Granting pages consumes backend system memory.  In systems configured
with insufficient spare memory for those pages, it can cause a memory
pressure situation.  However, finding the optimal amount of the spare
memory is challenging for large systems having dynamic resource
utilization patterns.  Also, such a static configuration might lack
flexibility.

To mitigate such problems, this patchset adds a memory reclaim callback
to 'xenbus_driver' (patch 1) and then introduce a lock for race
condition avoidance (patch 2).  Those two patches could be merged into
one patch if necessary.

The third patch applies the callback mechanism to mitigate the problem
in 'xen-blkback' (patch 3), but it lacks use of the race condition
mitigation.  Following change (patch 4) applies the race protection
mechanism to the blkback.  Patch 3 and patch 4 has seperated for only
review convenience.  Highly recommend to merge those into one patch as
patch 3 applied version might confuse bisecting.

The fifth and sixth patches are trivial cleanups; those fix nits we
found during the development of this patchset.

Note that patch 1, 3, 5, 6 are same with previous version.  I made the
changes in this version to different commits (only second and fourth
patches) to make review more comfortable.  Especially, the third and
fourth patches should be merged into one patch, as the third one alone
might make bisecting confuse.  Tthe next version of this patchset will
also merge those.


Base Version
------------

This patch is based on v5.4.  A complete tree is also available at my
public git repo:
https://github.com/sjp38/linux/tree/patches/blkback/buffer_squeeze/v11


Patch History
-------------

Changes from v10
(https://lore.kernel.org/xen-devel/20191216124527.30306-1-sjpark@amazon.com/)
 - Fix race condition (reported by SeongJae, suggested by Juergen)

Changes from v9
(https://lore.kernel.org/xen-devel/20191213153546.17425-1-sjpark@amazon.de/)
 - Add 'Reviewed-by' and 'Acked-by' from Roger Pau Monné
 - Update the commit message for overhead test of the 2nd path

Changes from v8
(https://lore.kernel.org/xen-devel/20191213130211.24011-1-sjpark@amazon.de/)
 - Drop 'Reviewed-by: Juergen' from the second patch
   (suggested by Roger Pau Monné)
 - Update contact of the new module param to SeongJae Park
   <sjpark@amazon.de>
   (suggested by Roger Pau Monné)
 - Wordsmith the description of the parameter
   (suggested by Roger Pau Monné)
 - Fix dumb bugs
   (suggested by Roger Pau Monné)
 - Move module param definition to xenbus.c and reduce the number of
   lines for this change
   (suggested by Roger Pau Monné)
 - Add a comment for the new callback, reclaim_memory, as other
   callbacks also have
 - Add another trivial cleanup of xenbus.c file (4th patch)

Changes from v7
(https://lore.kernel.org/xen-devel/20191211181016.14366-1-sjpark@amazon.de/)
 - Update sysfs-driver-xen-blkback for new parameter
   (suggested by Roger Pau Monné)
 - Use per-xen_blkif buffer_squeeze_end instead of global variable
   (suggested by Roger Pau Monné)

Changes from v6
(https://lore.kernel.org/linux-block/20191211042428.5961-1-sjpark@amazon.de/)
 - Remove more unnecessary prefixes (suggested by Roger Pau Monné)
 - Constify a variable (suggested by Roger Pau Monné)
 - Rename 'reclaim' into 'reclaim_memory' (suggested by Roger Pau Monné)
 - More wordsmith of the commit message (suggested by Roger Pau Monné)

Changes from v5
(https://lore.kernel.org/linux-block/20191210080628.5264-1-sjpark@amazon.de/)
 - Wordsmith the commit messages (suggested by Roger Pau Monné)
 - Change the reclaim callback return type (suggested by Roger Pau
   Monné)
 - Change the type of the blkback squeeze duration variable
   (suggested by Roger Pau Monné)
 - Add a patch for removal of unnecessary static variable name prefixes
   (suggested by Roger Pau Monné)
 - Fix checkpatch.pl warnings

Changes from v4
(https://lore.kernel.org/xen-devel/20191209194305.20828-1-sjpark@amazon.com/)
 - Remove domain id parameter from the callback (suggested by Juergen
   Gross)
 - Rename xen-blkback module parameter (suggested by Stefan Nuernburger)

Changes from v3
(https://lore.kernel.org/xen-devel/20191209085839.21215-1-sjpark@amazon.com/)
 - Add general callback in xen_driver and use it (suggested by Juergen
   Gross)

Changes from v2
(https://lore.kernel.org/linux-block/af195033-23d5-38ed-b73b-f6e2e3b34541@amazon.com)
 - Rename the module parameter and variables for brevity
   (aggressive shrinking -> squeezing)

Changes from v1
(https://lore.kernel.org/xen-devel/20191204113419.2298-1-sjpark@amazon.com/)
 - Adjust the description to not use the term, `arbitrarily`
   (suggested by Paul Durrant)
 - Specify time unit of the duration in the parameter description,
   (suggested by Maximilian Heyne)
 - Change default aggressive shrinking duration from 1ms to 10ms
 - Merge two patches into one single patch


SeongJae Park (6):
  xenbus/backend: Add memory pressure handler callback
  xenbus/backend: Protect xenbus callback with lock
  xen/blkback: Squeeze page pools if a memory pressure is detected
  xen/blkback: Protect 'reclaim_memory()' with 'reclaim_lock'
  xen/blkback: Remove unnecessary static variable name prefixes
  xen/blkback: Consistently insert one empty line between functions

 .../ABI/testing/sysfs-driver-xen-blkback      | 10 +++++
 drivers/block/xen-blkback/blkback.c           | 42 +++++++++----------
 drivers/block/xen-blkback/common.h            |  1 +
 drivers/block/xen-blkback/xenbus.c            | 37 +++++++++++++---
 drivers/xen/xenbus/xenbus_probe.c             |  1 +
 drivers/xen/xenbus/xenbus_probe_backend.c     | 38 +++++++++++++++++
 include/xen/xenbus.h                          |  3 ++
 7 files changed, 106 insertions(+), 26 deletions(-)

-- 
2.17.1

