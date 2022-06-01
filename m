Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC29C43334
	for <linux-block@archiver.kernel.org>; Wed,  1 Jun 2022 21:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiFAVSr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jun 2022 17:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbiFAVSp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 17:18:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3BCF46EC57
        for <linux-block@vger.kernel.org>; Wed,  1 Jun 2022 14:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654118320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=seAyGrXVhGHy02fnfQMGyuhJnciw9mNYlFqWhJVOexM=;
        b=Uks3lRGKm3GOGmPE1QyEWV2JadbAYwiZf59RRL/dKXFqnt1UfkV3JIcyWR8k6MZOHnOxPU
        IbYkyQphD7lGo7NSfXFoJBqNNRgE+i/fEpZqs7OtZFRJVIvQeQ1ccrggQKfdSjuhLj3kKW
        eqp0PX8xNocZERlRizWiqif6nwzTpZk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-tE27wxA5NQiVQqmP-8w7Rg-1; Wed, 01 Jun 2022 17:18:37 -0400
X-MC-Unique: tE27wxA5NQiVQqmP-8w7Rg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1371185A7B2;
        Wed,  1 Jun 2022 21:18:36 +0000 (UTC)
Received: from llong.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 71C4C40CF8EB;
        Wed,  1 Jun 2022 21:18:36 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v3 0/2] blk-cgroup: Optimize blkcg_rstat_flush()
Date:   Wed,  1 Jun 2022 17:18:22 -0400
Message-Id: <20220601211824.89626-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a follow-up of [1]. There is no change in patch 1. Patch 2 has
the following changes:
 - Update comments in patch 2.
 - Put rcu_read_lock/unlock() in blkcg_rstat_flush().
 - Use READ_ONCE/WRITE_ONCE() to access lnode->next to reduce data
   races.
 - Get a blkg reference when putting into the lockless list and put it
   back when removed.

[1] https://lore.kernel.org/lkml/20220601165324.60892-1-longman@redhat.com/

Waiman Long (2):
  blk-cgroup: Correctly free percpu iostat_cpu in blkg on error exit
  blk-cgroup: Optimize blkcg_rstat_flush()

 block/blk-cgroup.c | 92 ++++++++++++++++++++++++++++++++++++++++++----
 block/blk-cgroup.h |  9 +++++
 2 files changed, 93 insertions(+), 8 deletions(-)

-- 
2.31.1

