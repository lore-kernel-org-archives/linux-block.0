Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC038C6786C
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 11:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC27120892
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 11:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC27120892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbeLNLjg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Dec 2018 06:39:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbeLNLjg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Dec 2018 06:39:36 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 24CF0300297E;
        Fri, 14 Dec 2018 11:39:36 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9893317C6F;
        Fri, 14 Dec 2018 11:39:32 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] block: support debugfs on rq_qos & wbt
Date:   Fri, 14 Dec 2018 19:39:24 +0800
Message-Id: <20181214113926.7451-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 14 Dec 2018 11:39:36 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

The 1st patch provides support debugfs on rq_qos.

The 2nd patch exports blk-wbt's internal states via debugfs.


Ming Lei (2):
  blk-mq-debugfs: support rq_qos
  blk-wbt: export internal state via debugfs

 block/blk-mq-debugfs.c | 54 ++++++++++++++++++++++++++++++
 block/blk-mq-debugfs.h | 17 ++++++++++
 block/blk-rq-qos.c     |  2 ++
 block/blk-rq-qos.h     | 26 +++++++++++++++
 block/blk-wbt.c        | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h |  1 +
 6 files changed, 191 insertions(+)

-- 
2.9.5

