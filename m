Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC43C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 00:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F33F21920
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 00:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="GfsS2YJC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393638AbfBNARy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 19:17:54 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:47642 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfBNARJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 19:17:09 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id 6FD6BAA274;
        Thu, 14 Feb 2019 01:17:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1550103426; i=@fjfi.cvut.cz;
        bh=nh5BvuROgH138HfFZ0O9KjzSpFfM22JsrR5RGPXeSLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=GfsS2YJC52dQgCuCl5WbmJNlzVvjqoxEPylgjwBgnZJUyf7dQ7MW9n0SXNoY2yUHb
         xlLMZy6qr/+1SQuTdbiEFVVvs5Uh8BbadIi2xQSyqEOSm06sH596H48EWryheZpOfn
         w/Gi6i5sQFf6LIOdHT0hIjbV6WX4YLco6/MjxH/w=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id 3Z8xL7XRNRQq; Thu, 14 Feb 2019 01:16:56 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id 9B723AA28C;
        Thu, 14 Feb 2019 01:16:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz 9B723AA28C
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 71A516004E; Thu, 14 Feb 2019 01:16:56 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        David Kozub <zub@linux.fjfi.cvut.cz>
Subject: [PATCH 09/16] block: sed-opal: print failed function address
Date:   Thu, 14 Feb 2019 01:16:01 +0100
Message-Id: <1550103368-4605-10-git-send-email-zub@linux.fjfi.cvut.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1550103368-4605-1-git-send-email-zub@linux.fjfi.cvut.cz>
References: <1550103368-4605-1-git-send-email-zub@linux.fjfi.cvut.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>

Add function address (and if available its symbol) to the message if a
step function fails.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jon Derrick <jonathan.derrick@intel.com
---
 block/sed-opal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 5cb8034b53c8..1f246200b574 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -394,8 +394,8 @@ static int next(struct opal_dev *dev)
 
 		error = step->fn(dev, step->data);
 		if (error) {
-			pr_debug("Error on step function: %d with error %d: %s\n",
-				 state, error,
+			pr_debug("Step %d (%pS) failed with error %d: %s\n",
+				 state, step->fn, error,
 				 opal_error_to_human(error));
 
 			/* For each OPAL command we do a discovery0 then we
-- 
2.20.1

