Return-Path: <SRS0=JObX=3C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B07BC33CA8
	for <linux-block@archiver.kernel.org>; Mon, 13 Jan 2020 09:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D222075B
	for <linux-block@archiver.kernel.org>; Mon, 13 Jan 2020 09:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Jkmp4Ubf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgAMJuV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Jan 2020 04:50:21 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:7301 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgAMJuV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Jan 2020 04:50:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1578909020; x=1610445020;
  h=from:to:cc:subject:date:message-id:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=PX1ZrZhA4CFfySGOi+tectq1AtVISPobj3q9mu2po2A=;
  b=Jkmp4Ubfn4RWKqT1+45vPVd296IKOSShWLxagHEoflHm9yXpRVwkdzQP
   0pWu0WonTsnlJOmOHWvSGdDwUUHy+Lrj4e75lI5o/0TOFH5cP+/hUImxZ
   FwhdTtAGCrhodnLVVaTB7AdbVPMXctAEZVjZP7YuGUjkiP6l960d8k/tY
   k=;
IronPort-SDR: SVAJwSqTvIC1cetRulnIw53zATgp+qtYMK4EOT5etiQow4u9t9ZNP8jyw4WBe0jb4aiDkBN7PC
 R+Cf6N16IMRA==
X-IronPort-AV: E=Sophos;i="5.69,428,1571702400"; 
   d="scan'208";a="12077553"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 13 Jan 2020 09:50:19 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id DFF64A2B27;
        Mon, 13 Jan 2020 09:50:16 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 13 Jan 2020 09:50:16 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.92) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 13 Jan 2020 09:50:11 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     <jgross@suse.com>, <axboe@kernel.dk>, <konrad.wilk@oracle.com>,
        <roger.pau@citrix.com>, <linux-block@vger.kernel.org>,
        <pdurrant@amazon.com>, <linux-kernel@vger.kernel.org>,
        <sj38.park@gmail.com>, <xen-devel@lists.xenproject.org>
Subject: Re: [Xen-devel] [PATCH v13 0/5] xenbus/backend: Add memory pressure handler callback
Date:   Mon, 13 Jan 2020 10:49:52 +0100
Message-ID: <20200113094952.30727-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <20191218183718.31719-1-sjpark@amazon.com> (raw)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.160.92]
X-ClientProxiedBy: EX13D27UWA001.ant.amazon.com (10.43.160.19) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Every patch of this patchset got at least one 'Reviewed-by' or 'Acked-by' from
appropriate maintainers by last Wednesday, and after that, got no comment yet.
May I ask some more comments?


Thanks,
SeongJae Park

On Wed, 18 Dec 2019 19:37:13 +0100 SeongJae Park <sjpark@amazon.com> wrote:

> Granting pages consumes backend system memory.  In systems configured
> with insufficient spare memory for those pages, it can cause a memory
> pressure situation.  However, finding the optimal amount of the spare
> memory is challenging for large systems having dynamic resource
> utilization patterns.  Also, such a static configuration might lack
> flexibility.
> 
> To mitigate such problems, this patchset adds a memory reclaim callback
> to 'xenbus_driver' (patch 1) and then introduce a lock for race
> condition avoidance (patch 2).  After that, patch 3 applies the callback
> mechanism to mitigate the problem in 'xen-blkback'.  The fourth and
> fifth patches are trivial cleanups; those fix nits we found during the
> development of this patchset.
> 
> Note that patches 1, 4, and 5 are not changed since v9.
> 
> 
> Base Version
> ------------
> 
> This patch is based on v5.4.  A complete tree is also available at my
> public git repo:
> https://github.com/sjp38/linux/tree/patches/blkback/buffer_squeeze/v13
> 
> 
> Patch History
> -------------
> 
> Changes from v12
> (https://lore.kernel.org/xen-devel/20191218104232.9606-1-sjpark@amazon.com/)
>  - Do not unnecessarily disable interrupts (suggested by Juergen)
>  - Hold lock from xenbus side (suggested by Juergen)
> 
> Changes from v11
> (https://lore.kernel.org/xen-devel/20191217160748.693-2-sjpark@amazon.com/)
>  - Fix wrong trylock use (reported by Juergen)
>  - Merge patch 3 and 4 (suggested by Juergen)
>  - Update test result
> 
> Changes from v10
> (https://lore.kernel.org/xen-devel/20191216124527.30306-1-sjpark@amazon.com/)
>  - Fix race condition (reported by SeongJae, suggested by Juergen)
> 
> Changes from v9
> (https://lore.kernel.org/xen-devel/20191213153546.17425-1-sjpark@amazon.de/)
>  - Add 'Reviewed-by' and 'Acked-by' from Roger Pau Monné
>  - Update the commit message for overhead test of the 2nd path
> 
> Changes from v8
> (https://lore.kernel.org/xen-devel/20191213130211.24011-1-sjpark@amazon.de/)
>  - Drop 'Reviewed-by: Juergen' from the second patch
>    (suggested by Roger Pau Monné)
>  - Update contact of the new module param to SeongJae Park
>    <sjpark@amazon.de>
>    (suggested by Roger Pau Monné)
>  - Wordsmith the description of the parameter
>    (suggested by Roger Pau Monné)
>  - Fix dumb bugs
>    (suggested by Roger Pau Monné)
>  - Move module param definition to xenbus.c and reduce the number of
>    lines for this change
>    (suggested by Roger Pau Monné)
>  - Add a comment for the new callback, reclaim_memory, as other
>    callbacks also have
>  - Add another trivial cleanup of xenbus.c file (4th patch)
> 
> Changes from v7
> (https://lore.kernel.org/xen-devel/20191211181016.14366-1-sjpark@amazon.de/)
>  - Update sysfs-driver-xen-blkback for new parameter
>    (suggested by Roger Pau Monné)
>  - Use per-xen_blkif buffer_squeeze_end instead of global variable
>    (suggested by Roger Pau Monné)
> 
> Changes from v6
> (https://lore.kernel.org/linux-block/20191211042428.5961-1-sjpark@amazon.de/)
>  - Remove more unnecessary prefixes (suggested by Roger Pau Monné)
>  - Constify a variable (suggested by Roger Pau Monné)
>  - Rename 'reclaim' into 'reclaim_memory' (suggested by Roger Pau Monné)
>  - More wordsmith of the commit message (suggested by Roger Pau Monné)
> 
> Changes from v5
> (https://lore.kernel.org/linux-block/20191210080628.5264-1-sjpark@amazon.de/)
>  - Wordsmith the commit messages (suggested by Roger Pau Monné)
>  - Change the reclaim callback return type (suggested by Roger Pau
>    Monné)
>  - Change the type of the blkback squeeze duration variable
>    (suggested by Roger Pau Monné)
>  - Add a patch for removal of unnecessary static variable name prefixes
>    (suggested by Roger Pau Monné)
>  - Fix checkpatch.pl warnings
> 
> Changes from v4
> (https://lore.kernel.org/xen-devel/20191209194305.20828-1-sjpark@amazon.com/)
>  - Remove domain id parameter from the callback (suggested by Juergen
>    Gross)
>  - Rename xen-blkback module parameter (suggested by Stefan Nuernburger)
> 
> Changes from v3
> (https://lore.kernel.org/xen-devel/20191209085839.21215-1-sjpark@amazon.com/)
>  - Add general callback in xen_driver and use it (suggested by Juergen
>    Gross)
> 
> Changes from v2
> (https://lore.kernel.org/linux-block/af195033-23d5-38ed-b73b-f6e2e3b34541@amazon.com)
>  - Rename the module parameter and variables for brevity
>    (aggressive shrinking -> squeezing)
> 
> Changes from v1
> (https://lore.kernel.org/xen-devel/20191204113419.2298-1-sjpark@amazon.com/)
>  - Adjust the description to not use the term, `arbitrarily`
>    (suggested by Paul Durrant)
>  - Specify time unit of the duration in the parameter description,
>    (suggested by Maximilian Heyne)
>  - Change default aggressive shrinking duration from 1ms to 10ms
>  - Merge two patches into one single patch
> 
> 
> SeongJae Park (5):
>   xenbus/backend: Add memory pressure handler callback
>   xenbus/backend: Protect xenbus callback with lock
>   xen/blkback: Squeeze page pools if a memory pressure is detected
>   xen/blkback: Remove unnecessary static variable name prefixes
>   xen/blkback: Consistently insert one empty line between functions
> 
>  .../ABI/testing/sysfs-driver-xen-blkback      | 10 +++++
>  drivers/block/xen-blkback/blkback.c           | 42 +++++++++----------
>  drivers/block/xen-blkback/common.h            |  1 +
>  drivers/block/xen-blkback/xenbus.c            | 28 ++++++++++---
>  drivers/xen/xenbus/xenbus_probe.c             |  8 +++-
>  drivers/xen/xenbus/xenbus_probe_backend.c     | 38 +++++++++++++++++
>  include/xen/xenbus.h                          |  3 ++
>  7 files changed, 103 insertions(+), 27 deletions(-)
> 
> -- 
> 2.17.1
> 
