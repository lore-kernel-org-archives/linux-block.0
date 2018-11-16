Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A16BC43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 03:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20EA22075B
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 03:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20EA22075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbeKPNjS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 08:39:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60314 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbeKPNjS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 08:39:18 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3131330001F0;
        Fri, 16 Nov 2018 03:28:40 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 08678612A6;
        Fri, 16 Nov 2018 03:28:35 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 0/2] blk-mq: fix kobject lifetime issue
Date:   Fri, 16 Nov 2018 11:28:24 +0800
Message-Id: <20181116032826.11901-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 16 Nov 2018 03:28:40 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

The 1st patch fixes the kobject lifetime issue which is triggerd when
DEBUG_KOBJECT_RELEASE is enabled.

The 2nd patch can be thought as one follow-up cleanup.


Ming Lei (2):
  blk-mq: not embed .mq_kobj and ctx->kobj into queue instance
  blk-mq: alloc q->queue_ctx as normal array

 block/blk-mq-sysfs.c   | 59 +++++++++++++++++++++++++++++++++++++++-----------
 block/blk-mq.c         | 19 ++++++++++------
 block/blk-mq.h         |  4 ++--
 include/linux/blkdev.h |  4 ++--
 4 files changed, 62 insertions(+), 24 deletions(-)

Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


-- 
2.9.5

