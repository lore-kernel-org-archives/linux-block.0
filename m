Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9FCC4708C
	for <linux-block@archiver.kernel.org>; Fri, 28 May 2021 12:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D7F4613C9
	for <linux-block@archiver.kernel.org>; Fri, 28 May 2021 12:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbhE1Mc1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 May 2021 08:32:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:54882 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234917AbhE1McY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 May 2021 08:32:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622205049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=3UJX0KpA4OkwtvKnaa3GAG3A9L/2x9WFg4citekKOFU=;
        b=ZIMQTIsT6ipVN+pqxgKhCKDA9otL3l2euG5ltKWkXdaR7JZX1espnbrnAlci/1UdTHtMYx
        4oyn0PUEWfSqyUxw+3reoE0KZBhFXWMTxNupifHDYxtV3otG4PLtGgF+7Qis4wdoJJHGex
        jH6Xqd78rLfzb+J1QgsHfy2UNXv0Bmk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622205049;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=3UJX0KpA4OkwtvKnaa3GAG3A9L/2x9WFg4citekKOFU=;
        b=Lhvu5zcLL0VAZmgWrf8pLRlgnEalykxMNZbv9+pLO+eOcVQdg9puzwDFrh+lvL3g5jIL1X
        kkeDwVlRRZs0RFDw==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0CFAAAAFD;
        Fri, 28 May 2021 12:30:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CCE421E0D30; Fri, 28 May 2021 14:30:48 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>, Khazhy Kumykov <khazhy@google.com>,
        Ming Lei <ming.lei@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2 v3] block: Fix deadlock when merging requests with BFQ
Date:   Fri, 28 May 2021 14:30:39 +0200
Message-Id: <20210528123041.29914-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=531; h=from:subject; bh=or2Ny5+4i7zm2y/Sf9Rgfq2RQecYDGyMj95EyuyonAw=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBgsOIH+g0X0O+QTn/fdGpaOmQCHeFOuuYV3eNoFHaN /wtJMCaJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYLDiBwAKCRCcnaoHP2RA2cXxB/ wOrin5w16nUCwZhmUudQ/6wgxpX7laQ3xi1CfKNr15j1ukWDFhZ+bxiTd25H9HE4YeLNofVBa6Pfaa EaAImK6xNB2igwxUnQsAQjFxcLFuu134IO/EkElLmZ3GmRJf1cjT38MUpBdE1XLTGb8nlOiA+G6gol vM7PBrnmPEAG+DXfnj+BTUW1P9HSmFdlFE9bkHo9/iOI+5w/tRuMMd9MQl9lrAzDzDaOVc8z1JO/0A UZNjsEVtsKUW5c3y9y05JfV0qCYKM0x/GLAMyV/8AVlfsH4OvjtkSRADHZjHUA85HaAbalmktOmFkx HBeVymGWRtlHDSAhUGtNSQ5TMVI9Sx
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

This patch series fixes a lockdep complaint and a possible deadlock that
can happen when blk_mq_sched_try_insert_merge() merges and frees a request.
Jens, can you please merge the series? Thanks!

Changed since v2:
* Added reviewed-by tags

Changes since v1:
* Remove patch disabling recursing request merging during request insertion
* Modified BFQ to cleanup merged request already in its .merge_requests handler
* Added code to handle multiple requests that need freeing after being merged

								Honza
