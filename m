Return-Path: <SRS0=NI9l=Y6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952D5C5DF62
	for <linux-block@archiver.kernel.org>; Wed,  6 Nov 2019 10:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611252173E
	for <linux-block@archiver.kernel.org>; Wed,  6 Nov 2019 10:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbfKFKxm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Nov 2019 05:53:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:43840 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729553AbfKFKxm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Nov 2019 05:53:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EFD45AC23;
        Wed,  6 Nov 2019 10:53:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AB5681E4862; Wed,  6 Nov 2019 11:53:40 +0100 (CET)
Date:   Wed, 6 Nov 2019 11:53:40 +0100
From:   Jan Kara <jack@suse.cz>
To:     linux-block@vger.kernel.org
Cc:     mgorman@suse.de, hare@suse.de, Jens Axboe <axboe@kernel.dk>
Subject: elevator= kernel argument for recent kernels
Message-ID: <20191106105340.GE16085@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

with transition to blk-mq, the elevator= kernel argument was removed. I
understand the reasons for its removal but still I think this may come as a
surprise to some users since that argument has been there for ages and
although distributions generally transition to setting appropriate elevator
by udev rules, there are still people that use that argument with older
kernels and there are quite a few advices on the Internet to use it. So
shouldn't we at least warn loudly if someone uses elevator= argument on
kernels that don't support it and redirect people to sysfs? Something like
the attached patch? What do people think?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--rwEMma7ioTxnRzrJ
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-block-Warn-if-elevator-parameter-is-used.patch"

From a012b59ada6ecbc34fe8e690abb74a2fa8a1d8e6 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Wed, 6 Nov 2019 11:48:57 +0100
Subject: [PATCH] block: Warn if elevator= parameter is used

With transition to blk-mq, the elevator= kernel argument was removed as
it makes less and less sense with the current variety of devices.  Since
this may surprise some users and there are advices on the Internet that
still suggest to use it, let's at least warn if the parameter is used.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/elevator.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/block/elevator.c b/block/elevator.c
index 5437059c9261..0b1db9afb586 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -831,3 +831,12 @@ struct request *elv_rb_latter_request(struct request_queue *q,
 	return NULL;
 }
 EXPORT_SYMBOL(elv_rb_latter_request);
+
+static int __init elevator_setup(char *str)
+{
+	pr_warn("Kernel parameter elevator= does not have any effect anymore.\n"
+		"Please use sysfs to set IO scheduler for individual devices.\n");
+	return 1;
+}
+
+__setup("elevator=", elevator_setup);
-- 
2.16.4


--rwEMma7ioTxnRzrJ--
