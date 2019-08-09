Return-Path: <SRS0=j1eM=WF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEA9C31E40
	for <linux-block@archiver.kernel.org>; Fri,  9 Aug 2019 06:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458F7208C3
	for <linux-block@archiver.kernel.org>; Fri,  9 Aug 2019 06:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbfHIGI6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Aug 2019 02:08:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:57820 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725850AbfHIGI6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 9 Aug 2019 02:08:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 10B90AF00;
        Fri,  9 Aug 2019 06:08:57 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH 0/1] bcache fixes for Linux v5.3-rc4
Date:   Fri,  9 Aug 2019 14:08:28 +0800
Message-Id: <20190809060829.73489-1-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

I have a bug report that is frequent happens in product environment,
the problem was introduced in Linux v5.2, we should have the fix in
in Linux v5.3.

Thanks in advance for taking this.

Coly Li 
---

Coly Li (1):
  bcache: Revert "bcache: use sysfs_match_string() instead of
    __sysfs_match_string()"

 drivers/md/bcache/sysfs.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

-- 
2.16.4

