Return-Path: <SRS0=bR5W=TJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639C9C04AB2
	for <linux-block@archiver.kernel.org>; Thu,  9 May 2019 19:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3893020656
	for <linux-block@archiver.kernel.org>; Thu,  9 May 2019 19:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfEITCe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 May 2019 15:02:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26773 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727632AbfEISuE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 May 2019 14:50:04 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 672B2811AC;
        Thu,  9 May 2019 18:50:04 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F975108130A;
        Thu,  9 May 2019 18:50:04 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id x49Io3rq006346;
        Thu, 9 May 2019 14:50:03 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id x49Io3wM006342;
        Thu, 9 May 2019 14:50:03 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Thu, 9 May 2019 14:50:03 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Jens Axboe <axboe@kernel.dk>
cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH] brd: add cond_resched to brd_free_pages
In-Reply-To: <64c82900-aa9b-9093-82cb-30f179eda803@kernel.dk>
Message-ID: <alpine.LRH.2.02.1905091448260.6131@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1905091252300.19234@file01.intranet.prod.int.rdu2.redhat.com> <64c82900-aa9b-9093-82cb-30f179eda803@kernel.dk>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 09 May 2019 18:50:04 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On Thu, 9 May 2019, Jens Axboe wrote:

> On 5/9/19 10:54 AM, Mikulas Patocka wrote:
> > The loop that frees all the pages can take unbounded amount of time, so
> > add cond_resched() to it.
> 
> Looks fine to me, would be nice with a comment on why the cond_resched()
> is needed though.
> 
> -- 
> Jens Axboe

OK - here I added the comment.

Mikulas



From: Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH] brd: add cond_resched to brd_free_pages

The loop that frees all the pages can take unbounded amount of time, so
add cond_resched() to it.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/block/brd.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-2.6/drivers/block/brd.c
===================================================================
--- linux-2.6.orig/drivers/block/brd.c	2019-05-09 20:46:23.000000000 +0200
+++ linux-2.6/drivers/block/brd.c	2019-05-09 20:47:43.000000000 +0200
@@ -158,6 +158,12 @@ static void brd_free_pages(struct brd_de
 		pos++;
 
 		/*
+		 * It takes 3.4 seconds to remove 80GiB ramdisk.
+		 * So, we need cond_resched to avoid stalling the CPU.
+		 */
+		cond_resched();
+
+		/*
 		 * This assumes radix_tree_gang_lookup always returns as
 		 * many pages as possible. If the radix-tree code changes,
 		 * so will this have to.
