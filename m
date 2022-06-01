Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13BAC433EF
	for <linux-block@archiver.kernel.org>; Wed,  1 Jun 2022 14:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351830AbiFAOvP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jun 2022 10:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbiFAOvO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 10:51:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954C75DD17
        for <linux-block@vger.kernel.org>; Wed,  1 Jun 2022 07:51:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 47BFF1F45B;
        Wed,  1 Jun 2022 14:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654095071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jMZ1PNxpojIsC+YQ5M2rLw+/1l/41aL02AN8DG2/7DY=;
        b=iSYGdl+484iG54H7MiExPQtCb7eJDvhOV5eGR5s9VIZLeJN9WBF5uQOMlFOLFzjIzm4Cjp
        yqybRIsNCQbMbcG4NeZxdFu7IkXUIk79PBV9huCq0iNdq04EpzZbi2sUhl3E6zi1IIhYyw
        Qm9nmb6zc5yx4ptEFqtyELhdvlJvoeg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654095071;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jMZ1PNxpojIsC+YQ5M2rLw+/1l/41aL02AN8DG2/7DY=;
        b=DCx755sjFfzu9eSXvJMIgHs6BoEnzGkx8u+CgVXKo9VH+A+bdZjYtCrnmJ2LdOUb60lJFV
        yDtWQh6SpaGAg1CQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 10B7A2C143;
        Wed,  1 Jun 2022 14:51:11 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BC30AA058D; Wed,  1 Jun 2022 16:51:10 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 1/3] block: Fix handling of tasks without ioprio in ioprio_get(2)
Date:   Wed,  1 Jun 2022 16:51:04 +0200
Message-Id: <20220601145110.18162-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220601132347.13543-1-jack@suse.cz>
References: <20220601132347.13543-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1379; h=from:subject; bh=DrktAva6a1bSdo78uXUizm++kg+STNH7MrZjnF/SJ64=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBil3zY+qO6IH/D5QzAs1m+CKwQiXnsrh3+fBP+wzDS RUrCfmyJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYpd82AAKCRCcnaoHP2RA2Uq9CA CM86kkdGecEe0xpVSNFYXYPu+az7zovviGIyRGTWvVuRvhsnTpUMmZC9SvJyldjjr3XHZlpphc5k3A hiH7xmgB1x1HYEQWyYE4fWAMRV2XrL0jRyFcQDHSnP7rYBwpzZDI2//uJggtTIQcKFHC+e+kDfB6Pi f2QpuPfLa0qI+xKu22UG6rzz2oS8GMNfSeYlyPED0ztQsCK4gY19Q6p/cVBHfHv//LLOeIPbxNY0Nh XcfFC/vK2wBziuZ/QaBjtB2Awzeiw0oH3qbI1EMFATR56fR6keeUXg246WvLFQ1MfQ4jrFVsXkmPBP OfOINL5/bCs2Mf4wqH3V1OYb7BEl9A
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
single task. So fix IO priority comparison to treat unset IO priority as
the lowest possible one. This way we will return IOPRIO_CLASS_NONE
priority only if none of the considered tasks has explicitely set IO
priority, otherwise we return the highest set IO priority. This changes
userspace visible behavior but hopefully the results are clearer and
nothing breaks.

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

