Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1A2C4332F
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 08:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4985261884
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 08:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbhKKIzm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Nov 2021 03:55:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30887 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232679AbhKKIzb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Nov 2021 03:55:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636620760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=utNa8snZf6iYZMOpUmnVENexhSF35fGyJnMyEgjALM0=;
        b=K55q6Aqf//+wFKWDeeJ0uZsAPTsYsF3W/sBfdWVE7x5YUEiduT17aMGnlN16979BALX0lE
        uqUaMgs0k/rkw5/e0jRRxcQyADM6jlI1N0MqfilTP9/TpoZiQNn3P3HglsasKsF9O7kaTL
        cdEC0i+hlymF8gOOit2QGK6tfFjQMCQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-bapMPIpBPUCctOyMq37KUQ-1; Thu, 11 Nov 2021 03:52:37 -0500
X-MC-Unique: bapMPIpBPUCctOyMq37KUQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DE0356FDE;
        Thu, 11 Nov 2021 08:52:17 +0000 (UTC)
Received: from localhost (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6949728584B;
        Thu, 11 Nov 2021 08:52:16 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] blk-mq: fix hang in blk_mq_freeze_queue_wait
Date:   Thu, 11 Nov 2021 16:51:32 +0800
Message-Id: <20211111085134.345235-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

The 1st patch fixes hang in blk_mq_freeze_queue_wait().

The 2nd one renames blk_attempt_bio_merge, so we can avoid duplicated
symbols in block layer. 


Ming Lei (2):
  blk-mq: don't grab ->q_usage_counter in blk_mq_sched_bio_merge
  blk-mq: rename blk_attempt_bio_merge

 block/blk-mq-sched.c |  4 ----
 block/blk-mq.c       | 10 ++++++----
 2 files changed, 6 insertions(+), 8 deletions(-)

-- 
2.31.1

