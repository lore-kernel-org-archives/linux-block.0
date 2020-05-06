Return-Path: <SRS0=ToMJ=6U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9F2C28CBC
	for <linux-block@archiver.kernel.org>; Wed,  6 May 2020 13:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0881206D5
	for <linux-block@archiver.kernel.org>; Wed,  6 May 2020 13:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgEFNjk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 May 2020 09:39:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:52164 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728081AbgEFNjk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 May 2020 09:39:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D803CAE8C;
        Wed,  6 May 2020 13:39:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A7BC81E12FB; Wed,  6 May 2020 15:39:38 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/3] Fix blkparse and iowatcher for kernels >= 4.14
Date:   Wed,  6 May 2020 15:39:30 +0200
Message-Id: <20200506133933.4773-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I was investigating a performance issue with BFQ IO scheduler and I was
pondering why I'm not seeing informational messages from BFQ. After quite
some debugging I have found out that commit 35fe6d763229 "block: use
standard blktrace API to output cgroup info for debug notes" broke standard
blktrace API - namely the informational messages logged by bfq_log_bfqq()
are no longer displayed by blkparse(8) tool. This is because these messages
have now __BLK_TA_CGROUP bit set and that breaks flags checking in
blkparse(1) and iowatcher(1). This series fixes both tools to be able to
cope with events with __BLK_TA_CGROUP flag set.

								Honza
