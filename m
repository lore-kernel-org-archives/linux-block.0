Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6743C3526B
	for <linux-block@archiver.kernel.org>; Fri, 18 Dec 2020 21:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D21F23B7B
	for <linux-block@archiver.kernel.org>; Fri, 18 Dec 2020 21:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgLRVpC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Dec 2020 16:45:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:52720 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbgLRVpB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Dec 2020 16:45:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1EAEFAD0B;
        Fri, 18 Dec 2020 21:44:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B2B541E132E; Fri, 18 Dec 2020 22:44:19 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>, hare@suse.de,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2 RFC] blk-mq: Improve performance of non-mq IO schedulers with multiple HW queues
Date:   Fri, 18 Dec 2020 22:44:10 +0100
Message-Id: <20201218214412.1543-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello!

This patch series aims to fix a regression we've noticed on our test grid when
support for multiple HW queues in megaraid_sas driver was added during the 5.10
cycle (103fbf8e4020 scsi: megaraid_sas: Added support for shared host tagset
for cpuhotplug). The commit was reverted in the end for other reasons but I
believe the fundamental problem still exists for any other similar setup. The
problem manifests when the storage card supports multiple hardware queues
however storage behind it is slow (single rotating disk in our case) and so
using IO scheduler such as BFQ is desirable. See the second patch for details.

FWIW I'm not 100% sold on this approach, in particular I'm not sure it cannot
cause some issues in higher-end setups but I want expect mq-deadline or BFQ
to be used there. Anyway that's why I'm sending this as an RFC.

								Honza
