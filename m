Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8DBC433F5
	for <linux-block@archiver.kernel.org>; Tue,  4 Oct 2022 15:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiJDPSN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Oct 2022 11:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiJDPSG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Oct 2022 11:18:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C3D5F111
        for <linux-block@vger.kernel.org>; Tue,  4 Oct 2022 08:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664896684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qRmJxlNE0tvN7yeNgrdiLgaoqgJkRykVza0oLJZ3xvE=;
        b=NlqAUBGpRM7HVsBtD9HYBM427JlzKVqXd6ruoGWRvvbyseEpeqT3spFTu/QoqkfpGULBN+
        O/DnJU+mQqxGWhFIBP232z4Y1IORcHtRLYlxyu4XKo1lPcfghGYDY99i5z0/qBwHyMHMwp
        /jW84vIvTGH9FPOKIx4h2aIPwcUWfzY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-teJ95E6qPH25HpALp1eNaA-1; Tue, 04 Oct 2022 11:18:00 -0400
X-MC-Unique: teJ95E6qPH25HpALp1eNaA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 274A02999B37;
        Tue,  4 Oct 2022 15:18:00 +0000 (UTC)
Received: from llong.com (unknown [10.22.10.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 932992166B26;
        Tue,  4 Oct 2022 15:17:59 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v8 0/3] blk-cgroup: Optimize blkcg_rstat_flush()
Date:   Tue,  4 Oct 2022 11:17:45 -0400
Message-Id: <20221004151748.293388-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

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

 v6:
  - Add a missing free_percpu() into blkcg_css_free() in patch 3.
  - Integrating the documentation patch 4 back into patch 3.

 v5:
  - Add a new patch 2 to eliminate the use of intermediate "ret"
    variable in blkcg_css_alloc() to fix compilation warning reported
    by kernel test robot.

This patch series improves blkcg_rstat_flush() performance by eliminating
unnecessary blkg enumeration and flush operations for those blkg's and
blkg_iostat_set's that haven't been updated since the last flush. It
also enhances the llist API to support a sentinel termianted variant
of the lockless list.

Waiman Long (3):
  llist: Allow optional sentinel node terminated lockless list
  blk-cgroup: Return -ENOMEM directly in blkcg_css_alloc() error path
  blk-cgroup: Optimize blkcg_rstat_flush()

 block/blk-cgroup.c    |  87 ++++++++++++++++++++++++++++++------
 block/blk-cgroup.h    |   9 ++++
 include/linux/llist.h | 100 +++++++++++++++++++++++++++++++++---------
 lib/llist.c           |  20 ++++++---
 4 files changed, 177 insertions(+), 39 deletions(-)

-- 
2.31.1

