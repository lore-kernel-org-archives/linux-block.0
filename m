Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639CDC433F5
	for <linux-block@archiver.kernel.org>; Fri, 18 Mar 2022 13:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236427AbiCRNDj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Mar 2022 09:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbiCRNDi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Mar 2022 09:03:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A10C92D63BC
        for <linux-block@vger.kernel.org>; Fri, 18 Mar 2022 06:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647608538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=M2+NNcZL8J4C1xqGEpV9XrGWcUFrJAcvj2mh1jxbhVw=;
        b=REYC7Xv8PdMH3A2xW9jjmyIn2ohkmWeEynQmT826G4yNGIYn3ejSgt4UIVFp0fL8Plen/Y
        pZuFW3zUaAvimh1tGjEYIJoRv0qLsQ2OOzMPIMHCW/VNsFYG2qUl5C2Fl2B0pYWWan++h3
        MR8bmvD8SBouHybx4kikXC2XuulMdyY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-744dErndP1OO4mRuSfxSWQ-1; Fri, 18 Mar 2022 09:02:15 -0400
X-MC-Unique: 744dErndP1OO4mRuSfxSWQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F363C185A7BA;
        Fri, 18 Mar 2022 13:02:14 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F81443F040;
        Fri, 18 Mar 2022 13:02:13 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Yu Kuai <yukuai3@huawei.com>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH for-5.18 0/3] block: throttle related fixes
Date:   Fri, 18 Mar 2022 21:01:41 +0800
Message-Id: <20220318130144.1066064-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

The 1st and 2nd patches fix use-after-free on request queue and
throttle data.

The 3rd patch speeds up throttling after disk is deleted, so long
wait time is avoided.


Ming Lei (2):
  block: avoid use-after-free on throttle data
  block: let blkcg_gq grab request queue's refcnt

Yu Kuai (1):
  block: cancel all throttled bios in del_gendisk()

 block/blk-cgroup.c   |  5 +++++
 block/blk-throttle.c | 48 ++++++++++++++++++++++++++++++++++++++++++--
 block/blk-throttle.h |  3 +++
 block/genhd.c        |  3 +++
 4 files changed, 57 insertions(+), 2 deletions(-)

-- 
2.31.1

