Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2949EC4743C
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 09:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A0296113B
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 09:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhFWJi7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jun 2021 05:38:59 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53720 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhFWJi6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jun 2021 05:38:58 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E4E4B1FD36;
        Wed, 23 Jun 2021 09:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624441000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=B3yGronjW0nUO0aLALGsc0prv7Le7k4F1EVYjzK66pY=;
        b=p5foeXCvzWTTNBFuGNJQmWDTsHsNx2DHy/Ue561cXlL5IPuMjDFTzlWN1j7fFjg2GZwtWq
        hxDfB0d+lqMm6r2ZLSJxbWHEbkLJlx/5D1iiDf/uzxFIj6Hk84gTT0+R1gHP9ty/OoAxbB
        0hrNov62aLtrMz0S0dQf9j342I/YTyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624441000;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=B3yGronjW0nUO0aLALGsc0prv7Le7k4F1EVYjzK66pY=;
        b=4aF1j7zSB6G910DyACIV5c3x2/J9AiZSMcnu5wPbjBwMm6xunTBkvC7bSgqzQ65ISoCWO+
        blN8WTDZzGTOygAw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 87AD8A3B81;
        Wed, 23 Jun 2021 09:36:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C9B351E14B4; Wed, 23 Jun 2021 11:36:38 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2 v4] block: Fix deadlock when merging requests with BFQ
Date:   Wed, 23 Jun 2021 11:36:32 +0200
Message-Id: <20210623093634.27879-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=676; h=from:subject; bh=rOwuffjf5h0SlNV+SFdGKT8xWFlDcIoa04XVgjw8qLQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBg0wCXz4NBg3y3hQ5iQ/EcRIIVHvwuZ4R9Y5UCQzia 3aHvdx6JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYNMAlwAKCRCcnaoHP2RA2ZquCA CT/HB16tbNjIN6CqK1FNkvimoPZbOFfliTB6+i6QJZIv+A3xV2JuujVD9jHtUn4SAeTMOWoi9zXYFs UDgMxJvqc+aiDgr3MEWJ9Cw9mJmizmxP7LnT4XYg90o3RYzrcUGhPocB52XqmMmc0k552CJg0CQQwe H/hRsSzEAOJI6KdLr/lmAoRCKJty3rXfzDgZWBgtlcN5K1e7ywuoahcsgaLVRddRJ7bNSsBOzMXPX3 v8rACTSj1+N8eS2+apK3+i5itr8RzJFs96iL4a83ryFtENA9dZdn7oSo6kma0j0nA0Uai80ofVnQCe gUaqLhxaK3QSKz5Jj4l1I17V/nzRJ1
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

This patch series fixes a lockdep complaint and a possible deadlock that
can happen when blk_mq_sched_try_insert_merge() merges and frees a request.
Jens, can you please merge the series? It seems to have slipped through last
time when I posted it. Thanks!

Changes since v3:
* Rebased on top of for-next branch in axboe/linux-block.git

Changes since v2:
* Added reviewed-by tags

Changes since v1:
* Remove patch disabling recursing request merging during request insertion
* Modified BFQ to cleanup merged request already in its .merge_requests handler
* Added code to handle multiple requests that need freeing after being merged

								Honza
