Return-Path: <SRS0=bR5W=TJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4C0C04AB1
	for <linux-block@archiver.kernel.org>; Thu,  9 May 2019 16:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0517B20656
	for <linux-block@archiver.kernel.org>; Thu,  9 May 2019 16:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfEIQyL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 May 2019 12:54:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37666 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfEIQyL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 May 2019 12:54:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1EEA0307D844;
        Thu,  9 May 2019 16:54:11 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ECB0453C28;
        Thu,  9 May 2019 16:54:10 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id x49GsA0c019321;
        Thu, 9 May 2019 12:54:10 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id x49Gs9iZ019317;
        Thu, 9 May 2019 12:54:10 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Thu, 9 May 2019 12:54:09 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Jens Axboe <axboe@kernel.dk>
cc:     linux-block@vger.kernel.org
Subject: [PATCH] brd: add cond_resched to brd_free_pages
Message-ID: <alpine.LRH.2.02.1905091252300.19234@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 09 May 2019 16:54:11 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The loop that frees all the pages can take unbounded amount of time, so
add cond_resched() to it.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/block/brd.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-4.19.41/drivers/block/brd.c
===================================================================
--- linux-4.19.41.orig/drivers/block/brd.c	2019-01-22 12:26:42.000000000 +0100
+++ linux-4.19.41/drivers/block/brd.c	2019-05-09 17:09:11.000000000 +0200
@@ -157,6 +157,8 @@ static void brd_free_pages(struct brd_de
 
 		pos++;
 
+		cond_resched();
+
 		/*
 		 * This assumes radix_tree_gang_lookup always returns as
 		 * many pages as possible. If the radix-tree code changes,
