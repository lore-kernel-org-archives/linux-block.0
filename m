Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548BBC4332F
	for <linux-block@archiver.kernel.org>; Thu, 15 Dec 2022 03:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiLODc6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Dec 2022 22:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiLODcz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Dec 2022 22:32:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB36BCA1
        for <linux-block@vger.kernel.org>; Wed, 14 Dec 2022 19:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671075125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=veCyvm43EvJLg9G9hhu4AmM7THRxqVqHEQtr8ufuCSo=;
        b=ctbeBavTtkZXT21HzlShUfLfO+/VFoA0SVuJkgIUSSRMqfgYXuH7zOEB5c1DInoEClAQ6e
        PP8pqgM8rVJyIVyAApd7GCy9lA1hwdiPw/EvxCs0plgydG7PSbElGpnbFgTYrxbSKbNDQB
        n1viFzhYKY3q5dD60SAwTZ1tHArnr5Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-496-tg69kkZDM-O1mkTEYK98qg-1; Wed, 14 Dec 2022 22:31:45 -0500
X-MC-Unique: tg69kkZDM-O1mkTEYK98qg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99C9F185A78B;
        Thu, 15 Dec 2022 03:31:44 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA9B240ED76E;
        Thu, 15 Dec 2022 03:31:43 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v4 0/2] blk-cgroup: Fix potential UAF & flush rstat at blkgs destruction path
Date:   Wed, 14 Dec 2022 22:31:30 -0500
Message-Id: <20221215033132.230023-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

 v4:
  - Update comment and commit logs for both patches.

 v3:
  - Drop v2 patch 2 as it may not be needed.
  - Replace css_tryget() with percpu_ref_is_zero() in patch 1 as
    suggested by Tejun.
  - Expand comment on patch 2 to elaborate the reason for this patch.

 v2:
  - Remove unnecessary rcu_read_{lock|unlock} from
    cgroup_rstat_css_cpu_flush() in patch 3.

It was found that blkcg_destroy_blkgs() may be called with all blkcg
references gone. This may potentially cause user-after-free and so should
be fixed. The second patch flushes rstat when calling blkcg_destroy_blkgs().

Waiman Long (2):
  bdi, blk-cgroup: Fix potential UAF of blkcg
  blk-cgroup: Flush stats at blkgs destruction path

 block/blk-cgroup.c     | 23 +++++++++++++++++++++++
 include/linux/cgroup.h |  1 +
 kernel/cgroup/rstat.c  | 18 ++++++++++++++++++
 mm/backing-dev.c       |  8 ++++++--
 4 files changed, 48 insertions(+), 2 deletions(-)

-- 
2.31.1

