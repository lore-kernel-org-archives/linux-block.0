Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DCAC433FE
	for <linux-block@archiver.kernel.org>; Fri,  4 Nov 2022 18:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbiKDSWM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Nov 2022 14:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiKDSWD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Nov 2022 14:22:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F6F1117D
        for <linux-block@vger.kernel.org>; Fri,  4 Nov 2022 11:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667586061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mwGJiTiSAfN6PRbmiMouEvgWpKw4XbL4CZuerrQ/8Q0=;
        b=c4O4d2bYvfBAoCfCITgCo8eCoPYPnbkUHKNn2gggvnwgHd4+r3zvpLO+gAhb0yDjZFsRni
        OUXFCCbluGBM0yv5shqb0tyiBAUfFv2X7wSAAnFzHSv6Pw2UNA4eE4I5mkk5+JW8WEPVlB
        RRtf5v8gvg8EKutf3z6vc+NQncReM2g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-cI6xdKNwNXayL6aN7p5wlQ-1; Fri, 04 Nov 2022 14:20:57 -0400
X-MC-Unique: cI6xdKNwNXayL6aN7p5wlQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 867B61C05196;
        Fri,  4 Nov 2022 18:20:56 +0000 (UTC)
Received: from llong.com (unknown [10.22.34.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB927C15BA5;
        Fri,  4 Nov 2022 18:20:55 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v9 0/3] blk-cgroup: Optimize blkcg_rstat_flush()
Date:   Fri,  4 Nov 2022 14:20:47 -0400
Message-Id: <20221104182050.342908-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

 v9:
  - Remove patch "llist: Allow optional sentinel node terminated lockless
    list" for now. This will be done as a follow-up patch.
  - Add a new lqueued field to blkg_iostat_set to store the status of
    whether lnode is in a lockless list.
  - Add a new patch 3 to speed up the freeing of blkcg by flushing out
    the rstat lockless lists at blkcg offline time.

 v8:
  - Update the llist patch to make existing llist functions and macros
    work for both NULL and sentinel terminated lockless list as much
    as possible and leave only the initialization and removal functions
    to have a sentinel terminated llist variants.

 v7:
  - Drop patch 1 ("blk-cgroup: Correctly free percpu iostat_cpu in blkg
    on error exit") as it is found to be unnecessary.
  - Add a new llist patch to provide a lockless list variant terminated
    by a sentinel node.
  - Modified patch 3 to use the new sllist API and move percpu_ref_put()
    later in the blkcg_rstat_flush() loop to prevent potential
    use-after-free problem.


This patch series improves blkcg_rstat_flush() performance by eliminating
unnecessary blkg enumeration and flush operations for those blkg's and
blkg_iostat_set's that haven't been updated since the last flush.

Waiman Long (3):
  blk-cgroup: Return -ENOMEM directly in blkcg_css_alloc() error path
  blk-cgroup: Optimize blkcg_rstat_flush()
  blk-cgroup: Flush stats at blkgs destruction path

 block/blk-cgroup.c     | 103 +++++++++++++++++++++++++++++++++++------
 block/blk-cgroup.h     |  10 ++++
 include/linux/cgroup.h |   1 +
 kernel/cgroup/rstat.c  |  20 ++++++++
 4 files changed, 119 insertions(+), 15 deletions(-)

-- 
2.31.1

