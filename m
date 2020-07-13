Return-Path: <SRS0=ze0F=AY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DD6C433E1
	for <linux-block@archiver.kernel.org>; Mon, 13 Jul 2020 12:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B56B82072D
	for <linux-block@archiver.kernel.org>; Mon, 13 Jul 2020 12:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbgGMMfR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Jul 2020 08:35:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:33078 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbgGMMfR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Jul 2020 08:35:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C1124AC91;
        Mon, 13 Jul 2020 12:35:17 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     Coly Li <colyli@suse.de>
Subject: [PATCH 0/2] two generic block layer fixes for 5.9 
Date:   Mon, 13 Jul 2020 20:35:09 +0800
Message-Id: <20200713123511.19441-1-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

These two patches are posted for a while, and have reviewed by several
other developers. Could you please to take them for Linux v5.9 ?

Thanks in advance.

Coly Li
---

Coly Li (2):
  block: change REQ_OP_ZONE_RESET and REQ_OP_ZONE_RESET_ALL to be odd
    numbers
  block: improve discard bio alignment in __blkdev_issue_discard()

 block/blk-lib.c           | 25 +++++++++++++++++++++++--
 block/blk.h               | 14 ++++++++++++++
 include/linux/blk_types.h |  8 ++++----
 3 files changed, 41 insertions(+), 6 deletions(-)

-- 
2.26.2

