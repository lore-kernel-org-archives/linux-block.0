Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA701C4332D
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 15:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 872D923B46
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 15:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbhANPsg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jan 2021 10:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729517AbhANPsg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jan 2021 10:48:36 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E47FC06179C
        for <linux-block@vger.kernel.org>; Thu, 14 Jan 2021 07:47:42 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id bg11so3437828plb.16
        for <linux-block@vger.kernel.org>; Thu, 14 Jan 2021 07:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=/1PpEbZ5u6Fy77mPqfkLa/nkoU52/tGMEHsbdtWepW4=;
        b=K1hogn8H0AcWLbJ1RB0i9mk+1WZxhfVKnMp1bl0mzoSc3owq6JLTq4RswfCdqIijZ7
         JOzl88lRYNXKHVEqn4ckkcT00dOCrFa1oaYNf6+uk5mksiFgViBomI+LuT7trMVxIKL3
         lA678wJO8a0w1YSBmHzgp35CrsaWRmz6iMZi/86cpDalD7nwnhvoGZa1RXWpkXylT0p8
         W8jajLGIfymIxuhZGGvlyB1V/J7d8pb1EchKb+Sgioprp+tRoh1SoBzMGGCYc+ln3yGx
         C0Ld5Xjh/k9F/QNGfldfQiivtqAjGp3Rkr/xLdXihH7H0MAa2Oa5GnvdC7RFwVZyt+Wh
         yeVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/1PpEbZ5u6Fy77mPqfkLa/nkoU52/tGMEHsbdtWepW4=;
        b=lEjQa6WJ0u5fClpGTbQSYXQGrLOkn3AxBMK0xnUDb7QMt7U8u+qTOFwotOc9o1l9c+
         G6devld9E49oPJK1k7NXySW7zbV0QdJTevWQaBfep95JbzIzVYymNZEX3Dix2TRaf15D
         7TLv3F/Z5sl+MFdRp/Qcs1cUhvRFfuw4ClXDzKHfJZJts1SjcgUIKueFJ0G/jZ8xu89p
         wuslecDntM8uU1zdCeEyBgeo81BdmerrEXY+6HcinkenSeYTM69SknzUc5oynQYELmML
         wrI1/iQjyQCXCbNwhhIVgCGIYHhKQ0CM8TdhkuHTJw4bosX7/5pt8HBKsxT24/8MVIJg
         ACZQ==
X-Gm-Message-State: AOAM531FtMa/RcmrqkD1USDBDg4I5tu11kE/MbrWt4M721tfAbpSr1hs
        lyfOANRg4rxSLedtXXbc3pob1s/B1W/LXrEWcRjuOE+KBfI+Ult05IQnnnMV/b7R/blE7nqlcrT
        kf/M8847Mn/Zz+zMa1VnihOjI4gzZFVUaWvKMpRaXHTdhdgDrPjia4+wBRaRnNdVsXaTN
X-Google-Smtp-Source: ABdhPJxvZfMl2YEge75XAxbNvz3zndXJD7I49Liu1RV4ESXrtxeeROuRAuEe7qcF1uQihpPtTzG7Lg/KyvY=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a17:90b:ec2:: with SMTP id
 gz2mr5519727pjb.143.1610639261504; Thu, 14 Jan 2021 07:47:41 -0800 (PST)
Date:   Thu, 14 Jan 2021 15:47:22 +0000
In-Reply-To: <20210114154723.2495814-1-satyat@google.com>
Message-Id: <20210114154723.2495814-7-satyat@google.com>
Mime-Version: 1.0
References: <20210114154723.2495814-1-satyat@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 6/7] block: add WARN() in bio_split() for sector alignment
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The number of sectors passed to bio_split() should be aligned to
blk_crypto_bio_sectors_alignment(). All callers have been updated to ensure
this, so add a WARN() if the number of sectors is not aligned.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/bio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bio.c b/block/bio.c
index 1f2cc1fbe283..c5f577ee6b8d 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1472,6 +1472,7 @@ struct bio *bio_split(struct bio *bio, int sectors,
 
 	BUG_ON(sectors <= 0);
 	BUG_ON(sectors >= bio_sectors(bio));
+	WARN_ON(!IS_ALIGNED(sectors, blk_crypto_bio_sectors_alignment(bio)));
 
 	/* Zone append commands cannot be split */
 	if (WARN_ON_ONCE(bio_op(bio) == REQ_OP_ZONE_APPEND))
-- 
2.30.0.284.gd98b1dd5eaa7-goog

