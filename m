Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7CBC54EE9
	for <linux-block@archiver.kernel.org>; Thu,  8 Sep 2022 13:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbiIHNKe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Sep 2022 09:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbiIHNKL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Sep 2022 09:10:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D95415FF1
        for <linux-block@vger.kernel.org>; Thu,  8 Sep 2022 06:09:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 41B88226E9;
        Thu,  8 Sep 2022 13:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662642584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=3XK2g1KYCQSWB32aWM3ILawrLpfSrkuh2E6DAH5ExVU=;
        b=iVVQHdBS3ihVIRWgTKw7iYfT99OrhiSA2sPtVTqqfPXoX9e8WS3MmUQBlAmJGt8vendR8A
        n1HeZpZoXmbvJhU1sjEGd7TAsjv7vZDQbc5HNoaACrIVzzrZUE/W0+laAt9wWy0Bi7bIP8
        NvcIwIpI7aw3F5oxFcR1rIofTUzil0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662642584;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=3XK2g1KYCQSWB32aWM3ILawrLpfSrkuh2E6DAH5ExVU=;
        b=GMiJUn+f+XTGWnDKsP0yjczmsj8Q8DGWZ+Fwzq4TEK6epi1brzysmEqVSdPkH2lPSex4XQ
        XKGCAePlryDUt7Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1C3151322C;
        Thu,  8 Sep 2022 13:09:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /WPYBpjpGWPBNAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 08 Sep 2022 13:09:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8852DA067E; Thu,  8 Sep 2022 15:09:42 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>,
        Keith Busch <kbusch@kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH] sbitmap: Avoid leaving waitqueue in invalid state in __sbq_wake_up()
Date:   Thu,  8 Sep 2022 15:09:37 +0200
Message-Id: <20220908130937.2795-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2109; h=from:subject; bh=R6Lz0vD46CGPRpgDhfIea2NzhVZvYixGW9XGfwcJ6Z4=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjGemJrfmnY8ackOLJjBHgDbG3WADL/SSWkNc+99Hn kieA4W+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYxnpiQAKCRCcnaoHP2RA2ZhHCA Ct3YoY6tON4fmU0uFQToGupobp243JqaPRvz+6kca5N7zLdDLXBpYBHaXtXYuxBsIS2qcJ4SKz+jmJ HaO9qtBzyvdSt9Fs35hgaMP7gx/8UXsiSex6XuYa+sLHkoTJW7DaOV47lBY/JY5MnWc5q60GmbY9uy XuZX+Xi5wtKG4hCO8kvLk0vfoosmZ3jH0e9y9gRJ/EAoXwvcmqBXn4PiP+VpdI+FdOgpFv8r1J+qv8 oNH9j+vblAqtpWwM03c3yTTYkU0x4DoQgbTLLPf/nVlPBIJyByNhA1MaM2b072LbBdZf5P6X4OOZ0h OgIWbrWYgbL3VZMHHDB3I44wrAOwcd
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When __sbq_wake_up() decrements wait_cnt to 0 but races with someone
else waking the waiter on the waitqueue (so the waitqueue becomes
empty), it exits without reseting wait_cnt to wake_batch number. Once
wait_cnt is 0, nobody will ever reset the wait_cnt or wake the new
waiters resulting in possible deadlocks or busyloops. Fix the problem by
making sure we reset wait_cnt even if we didn't wake up anybody in the
end.

Fixes: 040b83fcecfb ("sbitmap: fix possible io hung due to lost wakeup")
Reported-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 lib/sbitmap.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index a39b1a877366..47cd8fb894ba 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -604,6 +604,7 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
 	struct sbq_wait_state *ws;
 	unsigned int wake_batch;
 	int wait_cnt;
+	bool ret;
 
 	ws = sbq_wake_ptr(sbq);
 	if (!ws)
@@ -614,12 +615,23 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
 	 * For concurrent callers of this, callers should call this function
 	 * again to wakeup a new batch on a different 'ws'.
 	 */
-	if (wait_cnt < 0 || !waitqueue_active(&ws->wait))
+	if (wait_cnt < 0)
 		return true;
 
+	/*
+	 * If we decremented queue without waiters, retry to avoid lost
+	 * wakeups.
+	 */
 	if (wait_cnt > 0)
-		return false;
+		return !waitqueue_active(&ws->wait);
 
+	/*
+	 * When wait_cnt == 0, we have to be particularly careful as we are
+	 * responsible to reset wait_cnt regardless whether we've actually
+	 * woken up anybody. But in case we didn't wakeup anybody, we still
+	 * need to retry.
+	 */
+	ret = !waitqueue_active(&ws->wait);
 	wake_batch = READ_ONCE(sbq->wake_batch);
 
 	/*
@@ -648,7 +660,7 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
 	sbq_index_atomic_inc(&sbq->wake_index);
 	atomic_set(&ws->wait_cnt, wake_batch);
 
-	return false;
+	return ret;
 }
 
 void sbitmap_queue_wake_up(struct sbitmap_queue *sbq)
-- 
2.35.3

