Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974DDC47085
	for <linux-block@archiver.kernel.org>; Mon, 24 May 2021 10:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C6EB61028
	for <linux-block@archiver.kernel.org>; Mon, 24 May 2021 10:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbhEXKGr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 May 2021 06:06:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:43836 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232494AbhEXKGl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 May 2021 06:06:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621850663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=AEA9FbjKUlmrCtCSHfAW6FbjDjJhiccWRjC1Jfn0xW0=;
        b=t2heHzJC7hTQODgw8j6Q5GhZ7AKYSVnFMlRQBa2MkJt1LmFRXg1tHUp1C0iDiq9ICr54oc
        IyAcB8qes0OdUIqdripfw/vARAzZTkuWYiZHaaXj/LXEB6tAD5RYNsNRhZUO+pQSL2Cees
        4u20eLAqxdGt9nN4TEwXmMRrbU9r5wI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621850663;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=AEA9FbjKUlmrCtCSHfAW6FbjDjJhiccWRjC1Jfn0xW0=;
        b=GNY2YlA7eRHGdlCf8Tsku18JBItwWqiY4AiKZesFOtAKPg66SJY/T7Czmaw+0yGlkG9xUO
        7bDTzdFHtVuOfkAQ==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 95A8DAB6D;
        Mon, 24 May 2021 10:04:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 71BAA1F2CA2; Mon, 24 May 2021 12:04:23 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>, Khazhy Kumykov <khazhy@google.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Ming Lei <ming.lei@redhat.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2 v2] block: Fix deadlock when merging requests with BFQ
Date:   Mon, 24 May 2021 12:04:14 +0200
Message-Id: <20210524100416.3578-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

This patch series fixes a lockdep complaint and a possible deadlock that
can happen when blk_mq_sched_try_insert_merge() merges and frees a request.

Changes since v1:
* Remove patch disabling recursing request merging during request insertion
* Modified BFQ to cleanup merged request already in its .merge_requests handler
* Added code to handle multiple requests that need freeing after being merged

								Honza
