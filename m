Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A0AC433B4
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 22:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E611613B6
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 22:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhETWfZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 18:35:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:39198 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231466AbhETWfY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 18:35:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8E356ABCD;
        Thu, 20 May 2021 22:34:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 31B521F2C73; Fri, 21 May 2021 00:34:01 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>, Khazhy Kumykov <khazhy@google.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2] block: Fix deadlock when merging requests with BFQ
Date:   Fri, 21 May 2021 00:33:51 +0200
Message-Id: <20210520223353.11561-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

This patch series fixes a lockdep complaint and a possible deadlock that
can happen when blk_mq_sched_try_insert_merge() merges and frees a request.

								Honza
