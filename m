Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01063C4332F
	for <linux-block@archiver.kernel.org>; Sun, 11 Dec 2022 22:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiLKWXF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 11 Dec 2022 17:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiLKWXD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 11 Dec 2022 17:23:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E7695A7
        for <linux-block@vger.kernel.org>; Sun, 11 Dec 2022 14:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670797276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pSMLLAxVMXnoWPwPea+ElcFQc/uDEfReQyP/onbm6ts=;
        b=Yx8PRi6/WCqBSS+vFv3eG+d+RJgsaiajZtz1pWe3TZwzgumByBh21XouIQ4dWkd9ahNqMz
        3XghyUKqP2wWVWqAapLuiSrLpAct7xqG6E8+a9yi9YlxzJqN14X14oV8AcZaVeZ550mfso
        a09mg/BKFXmPhugHwbZqVYmwxIWk3aw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-cZw5i59hMJqVW7MRZaco6g-1; Sun, 11 Dec 2022 17:21:07 -0500
X-MC-Unique: cZw5i59hMJqVW7MRZaco6g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED062101A52A;
        Sun, 11 Dec 2022 22:21:06 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F8101121331;
        Sun, 11 Dec 2022 22:21:06 +0000 (UTC)
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
Subject: [PATCH-block v2 0/3] blk-cgroup: Fix potential UAF & miscellaneous cleanup
Date:   Sun, 11 Dec 2022 17:20:55 -0500
Message-Id: <20221211222058.2946830-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

 v2:
  - Remove unnecessary rcu_read_{lock|unlock} from
    cgroup_rstat_css_cpu_flush() in patch 3.

It was found that blkcg_destroy_blkgs() may be called with all blkcg
references gone. This may potentially cause user-after-free and so
should be fixed. The last 2 patches are miscellaneous cleanups of
commit 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()").

Waiman Long (3):
  bdi, blk-cgroup: Fix potential UAF of blkcg
  blk-cgroup: Don't flush a blkg if destroyed
  blk-cgroup: Flush stats at blkgs destruction path

 block/blk-cgroup.c     | 26 ++++++++++++++++++++++++++
 include/linux/cgroup.h |  1 +
 kernel/cgroup/rstat.c  | 18 ++++++++++++++++++
 mm/backing-dev.c       |  8 ++++++--
 4 files changed, 51 insertions(+), 2 deletions(-)

-- 
2.31.1

