Return-Path: <SRS0=uz0K=DY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE03C433DF
	for <linux-block@archiver.kernel.org>; Sat, 17 Oct 2020 07:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BDDD2068E
	for <linux-block@archiver.kernel.org>; Sat, 17 Oct 2020 07:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRyAxexz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391502AbgJQHhu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 17 Oct 2020 03:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390880AbgJQHhu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 17 Oct 2020 03:37:50 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FADC061755;
        Sat, 17 Oct 2020 00:37:50 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a17so2577048pju.1;
        Sat, 17 Oct 2020 00:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=V7WTw4kQ5sRpBkhDX+SWEg0pWl+mUzy6Zy/Hpg45vAU=;
        b=BRyAxexzDzzzMw90bVD+Z+pge6fXwE2rberWdEfLDpgLwS1B/X2D0J/LESkoyZXDR+
         YEX+R5tyYbmirDWhIR41z3HsZUzfP/bybG0s9aekel9iUkNgWKyLge0RszpfVhOpRNxD
         CLBew4qcavwez8YtqabBR14x7FNxlSo9CjhYB/vxOJzPYy5DnNCKuDoxh4Jl5DH7Luyp
         Fyf+zzjNWIRgTDKZccMpqQsw/9jszwYUwkOmfzILb8A+cGJKTdImNphyKeJxo7UFCivW
         L3bTVo4+kCVPa2Y/5uJcbqv+T0+p+tLzatD1faaSESKxd6PyGv8so38qPaJK5r1PnlUb
         Vq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V7WTw4kQ5sRpBkhDX+SWEg0pWl+mUzy6Zy/Hpg45vAU=;
        b=dOm7hKfR/+uqoXtNqB7q4YBBlNFgkMR4ydWq71HASO7RIfk6p+gpJfkFxgDK3geiQM
         f8FNrZ1E+Ip6cxvq71l1tmNz30A2w+X2Lnug/QM3xrDvaWw3F6Z5aZa7r6gRrwooMzuT
         YDUqeHBOCFw/CpKqpffntVjtDeDc7wn1fx45gNxUGSvR8t+4M7BIkTSVSBFifn32yBEO
         u0zwCk0XdiHR/N4a5VqWF/0qs55g42KMb6hYVleGkGjrv0N3eYsnusNkWMkd+4spZMkr
         5geqbLwNcMZbtlY9r6HEgTV5J0c5eoCG6KmOnyTGmhpHuWsTB33xx1VXljCn/4yoMigE
         G1pg==
X-Gm-Message-State: AOAM533F928F7RR6iXUfwe6A8VW221Xabq/wbcTwIt5DEda4FwDCQPMx
        lcFaN3rvjJmu1dD+zk6rOnY=
X-Google-Smtp-Source: ABdhPJz1yDCnaAkjxMzBSI/408KpVtWPUAHlzCEZvFya28EWo8I7aw/XRgxmRLP75R6W60S0O75D6A==
X-Received: by 2002:a17:90a:6282:: with SMTP id d2mr8099887pjj.86.1602920269684;
        Sat, 17 Oct 2020 00:37:49 -0700 (PDT)
Received: from localhost.localdomain.localdomain (li885-200.members.linode.com. [45.56.83.200])
        by smtp.gmail.com with ESMTPSA id z185sm4815539pfz.32.2020.10.17.00.37.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Oct 2020 00:37:49 -0700 (PDT)
From:   Jeff Xie <chongguiguzi@gmail.com>
X-Google-Original-From: Jeff Xie <huan.xie@suse.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        chongguiguzi@gmail.com, huan.xie@suse.com
Subject: [PATCH] block: use helper function bio_copy_dev to __bio_clone_fast
Date:   Sat, 17 Oct 2020 15:37:26 +0800
Message-Id: <1602920246-25131-1-git-send-email-huan.xie@suse.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We have introduced helper function bio_copy_dev. Just use it.

Signed-off-by: Jeff Xie <huan.xie@suse.com>
---
 block/bio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 640d0fb..9fce7df 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -679,8 +679,6 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
 	 * most users will be overriding ->bi_disk with a new target,
 	 * so we don't set nor calculate new physical/hw segment counts here
 	 */
-	bio->bi_disk = bio_src->bi_disk;
-	bio->bi_partno = bio_src->bi_partno;
 	bio_set_flag(bio, BIO_CLONED);
 	if (bio_flagged(bio_src, BIO_THROTTLED))
 		bio_set_flag(bio, BIO_THROTTLED);
@@ -690,7 +688,7 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
 	bio->bi_iter = bio_src->bi_iter;
 	bio->bi_io_vec = bio_src->bi_io_vec;
 
-	bio_clone_blkg_association(bio, bio_src);
+	bio_copy_dev(bio, bio_src);
 	blkcg_bio_issue_init(bio);
 }
 EXPORT_SYMBOL(__bio_clone_fast);
-- 
1.8.3.1

