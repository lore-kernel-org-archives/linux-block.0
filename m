Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CC0C43334
	for <linux-block@archiver.kernel.org>; Thu,  2 Jun 2022 13:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbiFBNf6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jun 2022 09:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235383AbiFBNf4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jun 2022 09:35:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A3036EB34
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 06:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654176955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RM/VM/BkJCFXBDQbLQtl/dczfhsVjGbr9q7yL7pUo/s=;
        b=QA/3Iap+GlzPb876wRGr6EHw9SD6QlDq2FIwoJOtwx65w8Wu4ysUkDMqBy59qpAvE9NPnP
        wY/xmq3PH2ZbCWSwIV04kstp3mLomGRFiXzHBYYDmv2l7pSWwhWqMuW5Lec3v8fAZ61Sbh
        Gs2l5xoJtxZZCciMoHigM+zLk1Y6v7U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-QpfwInDINwOXB57FDsZcwA-1; Thu, 02 Jun 2022 09:35:52 -0400
X-MC-Unique: QpfwInDINwOXB57FDsZcwA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D160B811E81;
        Thu,  2 Jun 2022 13:35:51 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6AF3C2166B2C;
        Thu,  2 Jun 2022 13:35:51 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v5 0/3] blk-cgroup: Optimize blkcg_rstat_flush()
Date:   Thu,  2 Jun 2022 09:35:40 -0400
Message-Id: <20220602133543.128088-1-longman@redhat.com>
In-Reply-To: <20220601211824.89626-1-longman@redhat.com>
References: <20220601211824.89626-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

 v5:
  - Add a new patch 2 to eliminate the use of intermediate "ret"
    variable in blkcg_css_alloc() to fix compilation warning reported
    by kernel test robot.

 v4:
  - Update comment and eliminate "inline" keywords as suggested by TJ.

 v3:
  - Update comments in patch 2.
  - Put rcu_read_lock/unlock() in blkcg_rstat_flush().
  - Use READ_ONCE/WRITE_ONCE() to access lnode->next to reduce data
    races.
  - Get a blkg reference when putting into the lockless list and put it
    back when removed.
 
This patch series improves blkcg_rstat_flush() performance by eliminating
unnecessary blkg enumeration and flush operations for those blkg's and
blkg_iostat_set's that haven't been updated since the last flush.

Waiman Long (3):
  blk-cgroup: Correctly free percpu iostat_cpu in blkg on error exit
  blk-cgroup: Return -ENOMEM directly in blkcg_css_alloc() error path
  blk-cgroup: Optimize blkcg_rstat_flush()

 block/blk-cgroup.c | 103 ++++++++++++++++++++++++++++++++++++++-------
 block/blk-cgroup.h |   9 ++++
 2 files changed, 96 insertions(+), 16 deletions(-)

-- 
2.31.1

