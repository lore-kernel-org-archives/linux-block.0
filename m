Return-Path: <SRS0=Ir13=TP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94401C04AB4
	for <linux-block@archiver.kernel.org>; Wed, 15 May 2019 03:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5232084A
	for <linux-block@archiver.kernel.org>; Wed, 15 May 2019 03:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfEODDW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 May 2019 23:03:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43412 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbfEODDW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 May 2019 23:03:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C54D9300181C;
        Wed, 15 May 2019 03:03:21 +0000 (UTC)
Received: from localhost (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 27CEA5D9C0;
        Wed, 15 May 2019 03:03:15 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/3] block: queue exit cleanup
Date:   Wed, 15 May 2019 11:03:07 +0800
Message-Id: <20190515030310.20393-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 15 May 2019 03:03:22 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

For fixing queue lock switching back related issue, commit 498f6650aec8
("block: Fix a race between the cgroup code and request queue initialization")
moves what blk_exit_queue() does into blk_cleanup_queue(). Turns out
it requires to protect generic_make_request_checks with blk_queue_enter,
then we have to hold the queue usage counter before
generic_make_request_checks(). This way makes generic_make_request()
code quite complicated and not easy to maintain.

After killing legacy request IO path, there isn't driver private queue
lock story, then no such issue addressed by 498f6650aec8 any more.

So revert the following commits and clean up related code much. 

	498f6650aec8 block: Fix a race between the cgroup code and request queue initialization
	37f9579f4c31 blk-mq: Avoid that submitting a bio concurrently with device removal triggers a crash
	cd4a4ae4683d block: don't use blocking queue entered for recursive bio submits
	24ecc3585348 block: Ensure that a request queue is dissociated from the cgroup controller

Ming Lei (3):
  block: move blk_exit_queue into __blk_release_queue
  block: don't protect generic_make_request_checks with blk_queue_enter
  block: rename BIO_QUEUE_ENTERED as BIO_SPLITTED

 block/blk-core.c           | 74 ++++----------------------------------
 block/blk-merge.c          | 10 +-----
 block/blk-sysfs.c          | 47 ++++++++++++++++--------
 block/blk.h                |  1 -
 include/linux/blk-cgroup.h |  4 +--
 include/linux/blk_types.h  |  2 +-
 6 files changed, 42 insertions(+), 96 deletions(-)

Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>

-- 
2.20.1

