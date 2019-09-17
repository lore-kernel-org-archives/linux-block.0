Return-Path: <SRS0=pu/s=XM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83060C4CECD
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 12:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627F9218AC
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 12:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfIQMJP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Sep 2019 08:09:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47210 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727126AbfIQMJP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 08:09:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8B88B307D90E;
        Tue, 17 Sep 2019 12:09:15 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.70.39.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E3385D9D5;
        Tue, 17 Sep 2019 12:09:13 +0000 (UTC)
From:   xiubli@redhat.com
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     mchristi@redhat.com, hch@infradead.org,
        linux-block@vger.kernel.org, Xiubo Li <xiubli@redhat.com>
Subject: [PATCH v3 0/2] blk-mq: Avoid memory reclaim when allocating
Date:   Tue, 17 Sep 2019 17:39:08 +0530
Message-Id: <20190917120910.24842-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 17 Sep 2019 12:09:15 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

Changed in V2:
- Addressed the comment from Ming Lei, thanks.

Changed in V3:
- Switch to memalloc_noio_save/restore from Christoph's comment, thanks.

Xiubo Li (2):
  blk-mq: Avoid memory reclaim when allocating request map
  blk-mq: use BLK_MQ_GFP_FLAGS and memalloc_noio_save/restore instead

 block/blk-mq-tag.c |  5 +++--
 block/blk-mq-tag.h |  5 ++++-
 block/blk-mq.c     | 45 +++++++++++++++++++++++++++++++++------------
 3 files changed, 40 insertions(+), 15 deletions(-)

-- 
2.21.0

