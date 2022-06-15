Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4349C43334
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 16:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354872AbiFOQTN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 12:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353677AbiFOQSP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 12:18:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536A149B4A
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 09:16:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8B6AC1F96C;
        Wed, 15 Jun 2022 16:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655309778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zdHGHI4Ev58b/pl0dNaAGHgKtCtHQQd4DQ4+opUALT0=;
        b=ZKIFAaa9x20cf8eb21YT708pM1jiWkTdZoKbW208/bLgFz9Rk04mC5+/UpxuazpxSCS5a6
        oYID15OgKRn1jG2d6V9+2jI5vuYEE63pIi/28G5RaI2s1Dtl7YSxeV1SIn7DMkRaccRLPV
        E3VCBTalsIm1M9Oy9dJYovuTFMqp3Q0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655309778;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zdHGHI4Ev58b/pl0dNaAGHgKtCtHQQd4DQ4+opUALT0=;
        b=p/R3wstH9a+z6T8c68t4eyyEFpUouQiOHJorvtFFst78o4zMl4lv2imxOzKyrku0ALIJ8j
        ZvTEvKjvNwBBraAA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2C18F2C142;
        Wed, 15 Jun 2022 16:16:17 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C7876A058D; Wed, 15 Jun 2022 18:16:16 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 1/8] block: Fix handling of tasks without ioprio in ioprio_get(2)
Date:   Wed, 15 Jun 2022 18:16:04 +0200
Message-Id: <20220615161616.5055-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220615160437.5478-1-jack@suse.cz>
References: <20220615160437.5478-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1501; h=from:subject; bh=9KD3aySqtPBkLpNodH9xvh4U02ybJw2mmf5dcbjI88g=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBiqgXEYfqwMx2mXUc/W3d23Pk3TGBQcOIl9EQiNkKN 4Wc0ZKaJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYqoFxAAKCRCcnaoHP2RA2fk7B/ 9UkES+O6bz4btxCgvDAETpvsgq2JS3VKJHuxfz1765SK1gCrblXh1UCs6PTj+BpWT3UjTr/GXIUZZV N95np4nenzfb0ZHuzG69LmTCv1HAI+vrdW3I8WjOuRvieiRKKzfZj2JhKkNrau1qjPkoL9GzxXCYFo jXMVZsZIXfhP9D+eRxgPNaoetVNx7x/zWxbcCY0bmF37L39l7Vq0zk4cGaLNZNBspRRozahNT/R07q 9J0Nr5Ped8c3oZo7tPLZnlH/eeVQW/9kBE+tCqLb6DXxTfGSgxjR3MWZ4LJG2xMjCadMsY2OCGJlIw 8J93rHVTwKO4HyG1lmG/Fgmmy6+sjp
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ioprio_get(2) can be asked to return the best IO priority from several
tasks (IOPRIO_WHO_PGRP, IOPRIO_WHO_USER). Currently the call treats
tasks without set IO priority as having priority
IOPRIO_CLASS_BE/IOPRIO_BE_NORM however this does not really reflect the
IO priority the task will get (which depends on task's nice value) and
with the following fix it will not even match returned IO priority for a
single task.

Fix IO priority comparison to treat unset IO priority as the lowest
possible one. This way we will return IOPRIO_CLASS_NONE priority only if
none of the considered tasks has explicitely set IO priority, otherwise
we return the highest set IO priority. This changes userspace visible
behavior but this way the caller really gets back the highest set IO
priority without contaminating the result with
IOPRIO_CLASS_BE/IOPRIO_BE_NORM from tasks which have IO priority unset.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/ioprio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/ioprio.c b/block/ioprio.c
index 2fe068fcaad5..62890391fc80 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -157,10 +157,9 @@ static int get_task_ioprio(struct task_struct *p)
 int ioprio_best(unsigned short aprio, unsigned short bprio)
 {
 	if (!ioprio_valid(aprio))
-		aprio = IOPRIO_DEFAULT;
+		return bprio;
 	if (!ioprio_valid(bprio))
-		bprio = IOPRIO_DEFAULT;
-
+		return aprio;
 	return min(aprio, bprio);
 }
 
-- 
2.35.3

