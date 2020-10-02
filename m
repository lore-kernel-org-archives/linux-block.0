Return-Path: <SRS0=oVJv=DJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6093C35257
	for <linux-block@archiver.kernel.org>; Fri,  2 Oct 2020 23:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7981C20796
	for <linux-block@archiver.kernel.org>; Fri,  2 Oct 2020 23:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601682820;
	bh=cBnSkCpi7LXzk2fBsRBiParYgg1IwA3sUBf+DzG5p0I=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=f03Bg9NL6camyPHLRGOg/whru3jmVtXM6Nnu73Jgddbbg0gmzf/FqUPvI0NKv6yZL
	 o5dIrGHEVtXpsquUT4tGj1ICXtcKUOQYL1cdDD/r4Ww2aq5fxPHU4ekrWQ/ACChiAs
	 Y8aNj9V8HYREy7+uTmts84oP83fbK6FHKnfYMdNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbgJBXxj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Oct 2020 19:53:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgJBXxj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Oct 2020 19:53:39 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AD09206B6;
        Fri,  2 Oct 2020 23:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601682819;
        bh=cBnSkCpi7LXzk2fBsRBiParYgg1IwA3sUBf+DzG5p0I=;
        h=Date:From:To:Cc:Subject:From;
        b=gnYz1ozvAKeQEHfm11R1/OkRmBYgoHTNvXYOLQZgRq2OBT75Y0Lh/wvJiK3+gLiHl
         /dyG5dF/Tl/xfeGWtDgQKAkWvIWl9VV7EoCkfFFUl6ahZqACbCouEYKOMrlrTknYE9
         MuieRg7J1buMibotFja+ey81bNeFyxLJ8O9Ljuhc=
Date:   Fri, 2 Oct 2020 18:59:28 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] rsxx: Use fallthrough pseudo-keyword
Message-ID: <20201002235928.GA13477@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace /* Fall through. */ comment with the new pseudo-keyword macro
fallthrough[1].

[1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/block/rsxx/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rsxx/core.c b/drivers/block/rsxx/core.c
index 8799e3bab067..63f549889f87 100644
--- a/drivers/block/rsxx/core.c
+++ b/drivers/block/rsxx/core.c
@@ -439,7 +439,7 @@ static void card_state_change(struct rsxx_cardinfo *card,
 	case CARD_STATE_FAULT:
 		dev_crit(CARD_TO_DEV(card),
 			"Hardware Fault reported!\n");
-		/* Fall through. */
+		fallthrough;
 
 	/* Everything else, detach DMA interface if it's attached. */
 	case CARD_STATE_SHUTDOWN:
-- 
2.27.0

