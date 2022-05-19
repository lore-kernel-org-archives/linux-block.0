Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF34AC433FE
	for <linux-block@archiver.kernel.org>; Thu, 19 May 2022 10:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbiESKwr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 May 2022 06:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236888AbiESKwn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 May 2022 06:52:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6ABAEE2D
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 03:52:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 56BAA219AD;
        Thu, 19 May 2022 10:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652957558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AcYU44NRF+VRVNxo1CHlAkQziojCs0+/JS9pbMcerqE=;
        b=2VZINmBMRTbNPda0ZzIVn6/bO/8NMYyHkzrz7LeFFqcf/+YXJTT4FaNY0wHJhE7g54nmrb
        4F01eq9anzmA0suFFcCuqmMf9vIwM8D7wFP0iqHf0i0ynZcwiVYcCQ98xQgOnt6sWIzfMl
        w451hmMCiP+kJF0HVeMbBXaZFByadDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652957558;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AcYU44NRF+VRVNxo1CHlAkQziojCs0+/JS9pbMcerqE=;
        b=qRe1jrvZcJhk+M8ArHIj9x/YzLaM+jGbzgwsv2HZa9P/tx6WfjsYa4o3qUnVyR08T+2lgL
        Z7hUKRWZ/ScvQPBg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4C4F12C143;
        Thu, 19 May 2022 10:52:38 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 836ACA0633; Thu, 19 May 2022 12:52:35 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 3/4] bfq: Remove superfluous conversion from RQ_BIC()
Date:   Thu, 19 May 2022 12:52:31 +0200
Message-Id: <20220519105235.31397-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220519104621.15456-1-jack@suse.cz>
References: <20220519104621.15456-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=893; h=from:subject; bh=RSV/+NRnH3Zfn+UVJqgtLy0C3J+V8YNDKHFHlL9H7h8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBihiFuZG608ClQI9xPIDfrCKiu7hQBOjzrQnGpJnsc S+zgaDyJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYoYhbgAKCRCcnaoHP2RA2QfUB/ 9LqxvLo/WrXuQG/lYPKKfo0h5ZcSEFQU6moGF831upmO0GEO7Fctk3Wfo+e86x4hHEnCrJ+7xoCITN pccg59Vs4YvjWNsvPJp4AfuGnERdZ8t27RjriOySTaMrzRf2pnM9sA9AeZvBpEMVKrx0s2iYQBLMa6 MW9K3WAhOqlrX9wtTUZDDkZrG53YgvP8exOrfeDAparkoMnwmqDe0qgIB+MiqsS4A9wiDUGVz5Hs64 tSJgOdUFAhl9LsAn+97cyZs1AkCsuPB23xEAWqS0KNBOiccdxKssBoj+EJ1cLCFDyjpNYjO76ksWYZ 1/hIANDzYQqsgUAZpgfa5FUVY6dQ3L
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We store struct bfq_io_cq pointer in rq->elv.priv[0] in bfq_init_rq().
Thus a call to icq_to_bic() in RQ_BIC() is wrong. Luckily it does no
harm currently because struct io_iq is the first one in struct
bfq_io_cq.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 1cc242c90fb6..904fe56495ce 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -374,7 +374,7 @@ static const unsigned long bfq_activation_stable_merging = 600;
  */
 static const unsigned long bfq_late_stable_merging = 600;
 
-#define RQ_BIC(rq)		icq_to_bic((rq)->elv.priv[0])
+#define RQ_BIC(rq)		((struct bfq_io_cq *)((rq)->elv.priv[0]))
 #define RQ_BFQQ(rq)		((rq)->elv.priv[1])
 
 struct bfq_queue *bic_to_bfqq(struct bfq_io_cq *bic, bool is_sync)
-- 
2.35.3

