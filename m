Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1C0C43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 11:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5432086A
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 11:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A5432086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbeKPVfS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 16:35:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39818 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727567AbeKPVfR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 16:35:17 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 146069981B;
        Fri, 16 Nov 2018 11:23:22 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 09F95608E0;
        Fri, 16 Nov 2018 11:23:15 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        "jianchao.wang" <jianchao.w.wang@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH V2 0/2] blk-mq: fix kobject lifetime issue
Date:   Fri, 16 Nov 2018 19:23:09 +0800
Message-Id: <20181116112311.4117-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 16 Nov 2018 11:23:22 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

The 1st patch fixes the kobject lifetime issue which is triggerd when
DEBUG_KOBJECT_RELEASE is enabled.

The 2nd patch can be thought as one follow-up cleanup.

V2:
	- allocate 'blk_mq_ctx' inside blk_mq_init_allocated_queue()
	- allocate q->mq_kobj directly 

Ming Lei (2):
  blk-mq: not embed .mq_kobj and ctx->kobj into queue instance
  blk-mq: alloc q->queue_ctx as normal array

 block/blk-mq-sysfs.c   | 51 ++++++++++++++++++++++++-----------------
 block/blk-mq.c         | 61 +++++++++++++++++++++++++++++++++++++++++---------
 block/blk-mq.h         |  4 ++--
 include/linux/blkdev.h |  4 ++--
 4 files changed, 84 insertions(+), 36 deletions(-)

Cc: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
2.9.5

