Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81FFC4167B
	for <linux-block@archiver.kernel.org>; Thu,  8 Dec 2022 22:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiLHWEX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Dec 2022 17:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiLHWD6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Dec 2022 17:03:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485B280A24
        for <linux-block@vger.kernel.org>; Thu,  8 Dec 2022 14:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670536917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=l3gdci1jA2BCwxv28dvvVRPMpXIO7QcJKVqY3sRM16E=;
        b=Q1066CIWzlYmcW3VKBr40mwrmMDQHAQGAsIZXva3ejHMy+gIkwBpsA8Chact6yuAjlNDSi
        bKPDk66vYuItIogdyP2Obdk+DtPDdLQ+W5eCtNSlszCyIv3OIz7gjvzgSBdnB5aavO7UoB
        tN8mh1uxWRe4iyPzktCFZljS0ewddHo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-326-281gZTHDPUaL81KC8QLc0w-1; Thu, 08 Dec 2022 17:01:52 -0500
X-MC-Unique: 281gZTHDPUaL81KC8QLc0w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7D7A185A78B;
        Thu,  8 Dec 2022 22:01:50 +0000 (UTC)
Received: from llong.com (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2331342222;
        Thu,  8 Dec 2022 22:01:50 +0000 (UTC)
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
Subject: [PATCH-block 0/3] blk-cgroup: Fix potential UAF & miscellaneous cleanup
Date:   Thu,  8 Dec 2022 17:01:38 -0500
Message-Id: <20221208220141.2625775-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

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
 kernel/cgroup/rstat.c  | 20 ++++++++++++++++++++
 mm/backing-dev.c       |  8 ++++++--
 4 files changed, 53 insertions(+), 2 deletions(-)

-- 
2.31.1

