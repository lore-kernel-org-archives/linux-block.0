Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BC2C433DB
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 10:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B827923370
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 10:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbhAMKKT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Jan 2021 05:10:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:44658 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbhAMKKT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jan 2021 05:10:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EEFC0AC8F;
        Wed, 13 Jan 2021 10:09:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B1C1E1E083F; Wed, 13 Jan 2021 11:09:37 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 0/3 v2] bfq: Two fixes and a cleanup for sequential readers
Date:   Wed, 13 Jan 2021 11:09:24 +0100
Message-ID: <20200605140837.5394-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org
Message-ID: <20210113100924.CZSMAjQyCkAE593D0FchnVa_CzqCXTy0_o4InylsIwQ@z>

Hello,

this patch series contains one tiny cleanup and two relatively simple fixes
for BFQ I've uncovered when analyzing behavior of four parallel sequential
readers on one machine. The fio jobfile is like:

[global]
direct=0
ioengine=sync
invalidate=1
size=16g
rw=read
bs=4k

[reader]
numjobs=4
directory=/mnt

The first patch fixes a problem due to which the four bfq queues were getting
merged without a reason. The third patch fixes a problem where we were unfairly
raising bfq queue think time (leading to clearing of short_ttime and subsequent
reduction in throughput).

Jens, since Paolo has acked all the patches, can you please merge them?

								Honza
