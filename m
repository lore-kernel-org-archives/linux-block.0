Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A42C43334
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 16:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346087AbiFOQTK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 12:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355278AbiFOQSP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 12:18:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6562346CAE
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 09:16:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8DA3121C26;
        Wed, 15 Jun 2022 16:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655309778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=lwXQl80fjTi5XuvsQsJDbw/RJCC5Zwh52h6Zf6hq/SE=;
        b=KrYXSJurbirJafG4I6EfHBy88jBuDcH7rLs4Xhs1LgqsSzKMDXO/41BH+hgPkQrHbNp/PN
        o8WwjrN2RjpHr/47Z4gx8VaZZIGDLJrzYQvwp38DWgHeiO9GZwxuihEurZ4/NWNDd/OtkM
        R/NqY+O8Zd8+H+rN4RmX0P3oDUd+sog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655309778;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=lwXQl80fjTi5XuvsQsJDbw/RJCC5Zwh52h6Zf6hq/SE=;
        b=FkoXCe+WmH8++QVatBC2vdbInEOJWuhUxrGxWbz7jsadWJh/KZHXWa7TYnX6FCqpF8oIy6
        KnCTDIkmvH1lVEAw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2BCA52C141;
        Wed, 15 Jun 2022 16:16:17 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C1672A062E; Wed, 15 Jun 2022 18:16:16 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/8 v2] block: Fix IO priority mess
Date:   Wed, 15 Jun 2022 18:16:03 +0200
Message-Id: <20220615160437.5478-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1804; h=from:subject:message-id; bh=YRCj12ML/yWF5B/utN7Gj64XNvEtrg8I5GA+PhX55fk=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBiqgW+XU982EGC1IMBWYBJcGQpHipz+Vepkm5ERRNN zo9gfYGJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYqoFvgAKCRCcnaoHP2RA2ZgMCA Ds9vH5KP6SHagbYvXLbqzUJoxmcYwi9tvsBsRgWYsy+gvcqWUT8B6XMDa/SXp2eQLcvGEkv+LJg/J/ YMGX4GLeLLXoXgeY7M5KfUq9RTjUHIzbzJRJITefbK7guqEzpCRfPBOW+wuznwM13BLDra7w39Y/cu ItWd3jah3B14uuwI5d7Xsk9a30WDo9f5l5lzGD6rk5DcKRFgPcFcyuTLZW+la1hNUiEcBnmc/eJKgR e1KUZxUoTtYi01B6ZF6V4zboc+M4xteF2aR5nwQlqK/JuWQ8R4l8In/FvJWXIlLn1WDUbja43FkO0A dGRueLcg/Dl/NA7CLKNjQWEZ/QGT6m
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

This is the second revision of my patches fixing IO priority handling in the
block layer. Recently, I've been looking into 10% regression reported by our
performance measurement infrastructure in reaim benchmark that was bisected
down to 5a9d041ba2f6 ("block: move io_context creation into where it's
needed"). This didn't really make much sense and it took me a while to
understand this but the culprit is actually in even older commit e70344c05995
("block: fix default IO priority handling") and 5a9d041ba2f6 just made the
breakage visible.  Essentially the problem was that after these commits some IO
was queued with IO priority class IOPRIO_CLASS_BE while other IO was queued
with IOPRIO_CLASS_NONE and as a result they could not be merged together
resulting in performance regression. I think what commit e70344c05995 ("block:
fix default IO priority handling") did is actually broken not only because of
this performance regression but because of other reasons as well (see changelog
of patch 3/8 for details). Besides this problem, there are multiple other
inconsistencies in the IO priority handling throughout the block stack we have
identified when discussing this with Damien Le Moal. So this patch set aims at
fixing all these various issues.

Note that there are a few choices I've made I'm not 100% sold on. In particular
the conversion of blk-ioprio from rqos is somewhat disputable since it now
incurs a cost similar to blk-throttle in the bio submission fast path (need to
load bio->bi_blkg->pd[ioprio_policy.plid]).  If people think the removed
boilerplate code is not worth the cost, I can certainly go via the "additional
rqos hook" path.

								Honza
Previous versions:
Link: http://lore.kernel.org/r/20220601132347.13543-1-jack@suse.cz # v1
