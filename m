Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A86C10DCE
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 01:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226272073C
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 01:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbgCYBbD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Mar 2020 21:31:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:46620 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727205AbgCYBbD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Mar 2020 21:31:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D9EF7ADDD;
        Wed, 25 Mar 2020 01:31:01 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH 0/1] bcache: 2nd wave patch for Linux v5.7-rc1 
Date:   Wed, 25 Mar 2020 09:30:56 +0800
Message-Id: <20200325013057.114340-1-colyli@suse.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This patch fixes a compiling problem reported by the kernel test
robot. Please take it for the Linux v5.7-rc1 patches.

Thanks.

Coly Li
---

Coly Li (1):
  bcache: remove dupplicated declaration from btree.h

 drivers/md/bcache/btree.h | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

-- 
2.25.0

