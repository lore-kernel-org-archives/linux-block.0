Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E60C433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 16:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237508AbiFOQTA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 12:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355309AbiFOQSQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 12:18:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA87055378
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 09:16:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 91FCC21C37;
        Wed, 15 Jun 2022 16:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655309778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cKKCMNR572e3ji6tuUccfiNuQr0/7Utivo3oPFSORRs=;
        b=apTlQqRqu7SxwS0SfmBv/hmr+mwdDGLh66mjnzQiceL3+AEKV8eFo2vm++zLDIwMtxOWQk
        efxs3qXr/08q5+0Q7YVgO0LX1x61CEkxTgfhBEtekMOar+APUGHuMUXKUysJyS1HJdUlXw
        u8v6a1FiXedjgiAZDlTMmkSk4RAJFKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655309778;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cKKCMNR572e3ji6tuUccfiNuQr0/7Utivo3oPFSORRs=;
        b=v1K38U2z0q+Vmruuu75QtATBeQVfwBlASqZDOUNn2aRBXMqNf3BMYlVdpnz25LuJ9jSg+z
        +MpUCb6TEUfYr7BQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3D9EF2C146;
        Wed, 15 Jun 2022 16:16:17 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DD273A0638; Wed, 15 Jun 2022 18:16:16 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 4/8] block: Return effective IO priority from get_current_ioprio()
Date:   Wed, 15 Jun 2022 18:16:07 +0200
Message-Id: <20220615161616.5055-4-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220615160437.5478-1-jack@suse.cz>
References: <20220615160437.5478-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1173; h=from:subject; bh=9bNkPVfvA56IJLEMsD6DpNxGU5tqEWJT3J3e95Phzjc=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBiqgXHvbqzTRIJLGRa6GUCcQe1x/QU/2iOdz0YYIxL crH7ylSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYqoFxwAKCRCcnaoHP2RA2QIaB/ 9fDcBRjhXqOltkouU8J66mMijEZBuhyPnp3hyB2Pc9OB560PsxHuS6jz6OR3Tx3QfS3cmPiBAPbAMU OToolwS8GJ8KG5TiuM1XrZX56OMK+iE7cHsDuxXnHaIuIUNX0daosQyQW0YovWTf3RAiMJ6EChY8mL MtEiqgfci/ulS3MPdAYHrMoOw2Q5pXoqpoFmNhm1rkzsY6bzedLupXKecTKfz695VoEjcCYMq37dUe HuNw7eZA+VSFnUOdXmXtIrn1YoKg9Mf+pwvYCdxCBIT7LWPVXogpWoeH23Mdtjk5zEoUrGi5w92Pbo TubPcACadwa1v+pVo0wcYyv+H6V+4X
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

get_current_ioprio() is used to initialize IO priority of various
requests. As such it should be returning the effective IO priority of
the task (i.e., reflecting the fact that unset IO priority should get
set based on task's CPU priority) so that the conversion is concentrated
in one place.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/ioprio.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
index d9dc78a15301..519d51fc8902 100644
--- a/include/linux/ioprio.h
+++ b/include/linux/ioprio.h
@@ -53,10 +53,17 @@ static inline int task_nice_ioclass(struct task_struct *task)
 static inline int get_current_ioprio(void)
 {
 	struct io_context *ioc = current->io_context;
+	int prio;
 
 	if (ioc)
-		return ioc->ioprio;
-	return IOPRIO_DEFAULT;
+		prio = ioc->ioprio;
+	else
+		prio = IOPRIO_DEFAULT;
+
+	if (IOPRIO_PRIO_CLASS(prio) == IOPRIO_CLASS_NONE)
+		prio = IOPRIO_PRIO_VALUE(task_nice_ioclass(current),
+					 task_nice_ioprio(current));
+	return prio;
 }
 
 extern int set_task_ioprio(struct task_struct *task, int ioprio);
-- 
2.35.3

