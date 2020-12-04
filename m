Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B79BC19437
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 22:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6987822C7E
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 22:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387474AbgLDWiZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Dec 2020 17:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgLDWiY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Dec 2020 17:38:24 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FC5C061A4F
        for <linux-block@vger.kernel.org>; Fri,  4 Dec 2020 14:37:44 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id q22so7063825qkq.6
        for <linux-block@vger.kernel.org>; Fri, 04 Dec 2020 14:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p5K117AYD5GD1c15NVXEU6O5XZ1i8FYadTHkksQyzQE=;
        b=Oq/AEHxMWKzb5KAM9SYp/rbQ8mUxas4krpbNJ9ARMCFvRW3mWAls1qC6Q3qrFWqb2Z
         uBbmIFA0R68mndNfOwIZKMC6yhEoKKQVSyls2vj6DODNT3enGQ1+G1g+ynF0DZQRYv7c
         YmlWn7O4aXiDjOLPDT5kBi9jqWSbuQJ/nQgoLybuqaV8JwP4neBMBSe/p9EIidyY/MCg
         LmidPoBTDyxaF6ulqeTY6ST9OgI3MFRk3aqbYEI6eHgf8CNdsGg1g5mO/KEuRhQll8H1
         RRubqXy2tn03dt+145duuFLRqxrIgVHcolrbSaW3pzm1h4KuO5nWgAL7qTB27l0LNVSp
         McNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=p5K117AYD5GD1c15NVXEU6O5XZ1i8FYadTHkksQyzQE=;
        b=eDSjdna/E++/5BZqoLWZODRAR4bTW9vNjB6Qm6Iv+VCWYPPd0U8XeHJtQZxMttHV4d
         8kkyGQxHqwNwgVfMWjy0WpHrzLSaw7OLsIKILKHWQq/kgzKPwo0OH1uHTn6i7AYfgu5e
         3MvRf3piWuezwQ1y7DbDcuJvLEkT9kY4sR1k37hr6ZW2I2210lNyF9EwHxlJpa9pcoKo
         qBLAMxhA/u8Np7H9yz915JHvlBkuurijYBqskGoxsoJV34J+Q9pMhH/ZOrTxew3vnXV5
         xlV2A9BidZw4yXjuUIgXdbkfEGQKwo9qJNz2uQRKac7kbrkvGEY+DEXqLXo5VKMsBb/d
         by4g==
X-Gm-Message-State: AOAM531FWDvOnCyjaOTAn1VvUHqJAXdAuaghasAwOO5FXN1eUewKRlBq
        m7JcRrw4Bjthfsio84N+gPo=
X-Google-Smtp-Source: ABdhPJzScZ4fRkmi0dCDQnj8l0wQKmLngV0DHzmdhA3Y8Ebv0S2d79RUTchGM/20QlCukDc3lvI2PA==
X-Received: by 2002:a37:4816:: with SMTP id v22mr11658697qka.42.1607121463767;
        Fri, 04 Dec 2020 14:37:43 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id x24sm5952934qkx.23.2020.12.04.14.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 14:37:43 -0800 (PST)
Sender: Mike Snitzer <snitzer@gmail.com>
Date:   Fri, 4 Dec 2020 17:37:42 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sergei Shtepa <sergei.shtepa@veeam.com>,
        Thomas Gleixner <tglx@linutronix.de>, axboe@kernel.dk,
        vgoyal@redhat.com
Subject: [PATCH] block: fix incorrect branching in blk_max_size_offset()
 [was: Re: [git pull] device mapper fixes for 5.10-rc7]
Message-ID: <20201204223742.GA82260@lobo>
References: <20201204210521.GA3937@redhat.com>
 <160711773655.16738.13830016046956700847.pr-tracker-bot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160711773655.16738.13830016046956700847.pr-tracker-bot@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 04 2020 at  4:35P -0500,
pr-tracker-bot@kernel.org <pr-tracker-bot@kernel.org> wrote:

> The pull request you sent on Fri, 4 Dec 2020 16:05:21 -0500:
> 
> > git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.10/dm-fixes
> 
> has been merged into torvalds/linux.git:
> https://git.kernel.org/torvalds/c/b3298500b23f0b53a8d81e0d5ad98a29db71f4f0
> 
> Thank you!

Hi Linus,

This is _really_ embarrassing; but I screwed up the branching at the top
of blk_max_size_offset(), here is the fix:

From: Mike Snitzer <snitzer@redhat.com>
Date: Fri, 4 Dec 2020 17:21:03 -0500
Subject: [PATCH] block: fix incorrect branching in blk_max_size_offset()

If non-zero 'chunk_sectors' is passed in to blk_max_size_offset() that
override will be incorrectly ignored.

Old blk_max_size_offset() branching, prior to commit 3ee16db390b4,
must be used only if passed 'chunk_sectors' override is zero.

Fixes: 3ee16db390b4 ("dm: fix IO splitting")
Cc: stable@vger.kernel.org # 5.9
Reported-by: John Dorminy <jdorminy@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 include/linux/blkdev.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 24ae504cf77d..033eb5f73b65 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1076,10 +1076,12 @@ static inline unsigned int blk_max_size_offset(struct request_queue *q,
 					       sector_t offset,
 					       unsigned int chunk_sectors)
 {
-	if (!chunk_sectors && q->limits.chunk_sectors)
-		chunk_sectors = q->limits.chunk_sectors;
-	else
-		return q->limits.max_sectors;
+	if (!chunk_sectors) {
+		if (q->limits.chunk_sectors)
+			chunk_sectors = q->limits.chunk_sectors;
+		else
+			return q->limits.max_sectors;
+	}
 
 	if (likely(is_power_of_2(chunk_sectors)))
 		chunk_sectors -= offset & (chunk_sectors - 1);
-- 
2.15.0

