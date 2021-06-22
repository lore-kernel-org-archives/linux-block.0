Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36496C48BDF
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 16:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1107D61107
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 16:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhFVQMo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 12:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhFVQMn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 12:12:43 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9879CC061574;
        Tue, 22 Jun 2021 09:10:26 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id t19-20020a17090ae513b029016f66a73701so2011813pjy.3;
        Tue, 22 Jun 2021 09:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i+pKtokUfHb9UEDL49Cs/ADaX0vnVkh3TA5MqGHAFU0=;
        b=dSOqXku68l3KNrDrATiu7AmcidU75ZovkEJ+m1Oaj7CVzeF8GVlh+HUpKBitX9YXiV
         UCBZ0eNURtnp3raaEammg6fMZsgUPdRDWOp8swppEbWB3zTeil4gjTWBCF1s1uCbEDhs
         upF+1O2kCw2iG9jwzdaempVXjIoYxWBJ1vQmBk8sKy7NCuUyMjZraSPmWVqgzDdodmY6
         aQWdhJo3YArme+oAWXcrnV2GT9qlMow9MZeAtWRjQtlqnauQiOTCx6Ithz4vVV0eXVp4
         DP2kVa9NEHCkiLWK2EfPr2XSwpSDNxepvjFDfuXqDCZBJ3zWVNTHMt2FhLKqsSB7AYjX
         dVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i+pKtokUfHb9UEDL49Cs/ADaX0vnVkh3TA5MqGHAFU0=;
        b=FMun6Evh7wRd/kdgJnp9sGdDyOWQjK0Z3lsKjRrjSV1geq2F3nhJkXyPQ7WyBheX+U
         cQ3qu7KVoL3W07uqmvbN2MM/ok8sy1up2ip0PBUZMNwniQ1lYT/TZj2GaZAv4Xst//Py
         mbSV0Aedtx4CtOpMauTBgIY0vYB4wzRhU/+b2k782/o8QQBTbvs/OOATHR2DUSQA0iqC
         6TEu2aH7vF86ZB3S7Wza1lQZE3x3XwtfCR2GRtHN47S5/rZ4FVTtoiEiM/EpuncmlMxF
         l/hYk2oYpCBgk4aTvQdQpDOunFnGXd4AfqhvyDQvEbg2JiHUmV0n29SWUbLWKH3O7awl
         IkUw==
X-Gm-Message-State: AOAM532wN2FVGZzvsh/h3+mw4Wwv4zhPSWn0FIWlGnV/X9eai0S8qGdf
        zVGKt6W7WI0BsA8WRHcVm5Q=
X-Google-Smtp-Source: ABdhPJy//gOo6kHUp4EzVtkFahzZ82HvTWE90I5viKpK0fG/qiqurwFIJnos1XfOMWRc+b/89ySp+w==
X-Received: by 2002:a17:90b:1bc4:: with SMTP id oa4mr4724360pjb.18.1624378226122;
        Tue, 22 Jun 2021 09:10:26 -0700 (PDT)
Received: from fedora.. ([2405:201:6008:6d7c:6bfd:dac8:eafe:7bde])
        by smtp.googlemail.com with ESMTPSA id ml5sm2780135pjb.3.2021.06.22.09.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 09:10:25 -0700 (PDT)
From:   Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
To:     axboe@kernel.dk
Cc:     Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+cf89d662483d6a1a0790@syzkaller.appspotmail.com
Subject: [PATCH] loop: fix setting arbitrarily large block size
Date:   Tue, 22 Jun 2021 21:40:19 +0530
Message-Id: <20210622161019.130090-1-chouhan.shreyansh630@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

loop_validate_block_size took an unsigned short argument. Passing an
argument with size greater than the size of unsigned short would cause
an overflow and could potentially render the upper bound check on the
block size useless, allowing to set an arbitrarily large block size.

Reproted-by: syzbot+cf89d662483d6a1a0790@syzkaller.appspotmail.com
Signed-off-by: Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 9a758cf66507..635baff0dd66 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -236,7 +236,7 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
  * @bsize: size to validate
  */
 static int
-loop_validate_block_size(unsigned short bsize)
+loop_validate_block_size(unsigned long bsize)
 {
 	if (bsize < 512 || bsize > PAGE_SIZE || !is_power_of_2(bsize))
 		return -EINVAL;
-- 
2.31.1

