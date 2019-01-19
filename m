Return-Path: <SRS0=VL3J=P3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FBAC61CE8
	for <linux-block@archiver.kernel.org>; Sat, 19 Jan 2019 18:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939BC2087E
	for <linux-block@archiver.kernel.org>; Sat, 19 Jan 2019 18:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkL0pU3t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbfASSFQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 19 Jan 2019 13:05:16 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36785 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbfASSFP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Jan 2019 13:05:15 -0500
Received: by mail-qt1-f195.google.com with SMTP id t13so18823014qtn.3
        for <linux-block@vger.kernel.org>; Sat, 19 Jan 2019 10:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xam2qz/iGZ2SU9NuNxXD/C9OzO4f5Xq2vH+9/0d7tVw=;
        b=UkL0pU3tdzXtytpB3DbrJUcKw/8NxBnYXSpmwtXHHh0R4iL2Mx9RB5RYDYSJeeCRYy
         3PslZyC4PMF716nTYbe1Tn+g6qC0aEBvMXcqw0GK/XkfKtDcY18OzCKMWqh3PwHmhuqS
         TIHekK7rGpTZMec2AAHYutFl2Rz7+CZomjgwujekSWl3WBCiIUmuYEndnKlGoVx3uZrO
         m4GNBXvK39bm8YvGWyRZT7PRtXuO7qndG1/KWaiKyKxfZMI/F3aEPRntgLsAaayDvA5v
         hfNK6yHfFk5IirSOi3sxJRsJNZVfxKs9OHdc/tCx+yeP7FXx86pVPVNzdSAqPdvHZOlC
         jvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Xam2qz/iGZ2SU9NuNxXD/C9OzO4f5Xq2vH+9/0d7tVw=;
        b=EaC91pQ0zmE7ZJG9W2yQVdihx2HXloP4G2dDhC11zoD7G0vPdqHjBMRKKSUDq5r3XZ
         V5HGqQCL1fJisVMGun5UWPBYZK3+UGCLaV5Cp97Vn+khXW/lqwZRQELjLn5wMeXibUe0
         +owrV1qD0z/Oq4PhSimk5nzGUOvXwKpLqiPDOr7BK5I1D3e0J0Sdg6fUpP+Mb+e/HO69
         wHDcP33cv8AFK+We78M9pE5etRU66h+a5OtgU5d5kbLezWuCkZSMK96QsZPabeAbONsy
         CN5NLnd6posUWzCqB3uuPCxElPmBHaGfRZ4EsZaPmfEI0NZS932qT6Z8CV/rn4ly6L3Y
         v/5A==
X-Gm-Message-State: AJcUukfPPX6HEKWzF5SV9FSU5y7zzdMp8oHylkWRX6Ef61kZmQHJHv+j
        TS/6IGNY2q+8INHw3mapwVg=
X-Google-Smtp-Source: ALg8bN7yTv8YKdR7o1QnjRohywutXXp77B/qhQzlxPgyK/2Y/13Afm3nB5navmTvsFkD8HTFqOhXlA==
X-Received: by 2002:aed:3b76:: with SMTP id q51mr20739358qte.229.1547921114718;
        Sat, 19 Jan 2019 10:05:14 -0800 (PST)
Received: from localhost (pool-68-160-176-113.bstnma.fios.verizon.net. [68.160.176.113])
        by smtp.gmail.com with ESMTPSA id o21sm64275035qto.18.2019.01.19.10.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 10:05:13 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     dm-devel@redhat.com
Cc:     NeilBrown <neilb@suse.com>, Ming Lei <ming.lei@redhat.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org
Subject: [PATCH 3/4] dm: fix missing bio_split() pattern code in __split_and_process_bio()
Date:   Sat, 19 Jan 2019 13:05:05 -0500
Message-Id: <20190119180506.1300-4-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190119180506.1300-1-snitzer@redhat.com>
References: <20190119180506.1300-1-snitzer@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the same BIO_QUEUE_ENTERED pattern that was established by commit
cd4a4ae4683dc ("block: don't use blocking queue entered for recursive
bio submits") by setting BIO_QUEUE_ENTERED after bio_split() and before
recursing via generic_make_request().

Also add trace_block_split() because it provides useful context about
bio splits in blktrace.

Depends-on: cd4a4ae4683dc ("block: don't use blocking queue entered for recursive bio submits")
Fixes: 18a25da84354 ("dm: ensure bio submission follows a depth-first tree walk")
Cc: stable@vger.kernel.org # 4.16+
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index fbadda68e23b..6e29c2d99b99 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1654,7 +1654,9 @@ static blk_qc_t __split_and_process_bio(struct mapped_device *md,
 						   sectors[op_stat_group(bio_op(bio))], ci.sector_count);
 				part_stat_unlock();
 
+				bio_set_flag(bio, BIO_QUEUE_ENTERED);
 				bio_chain(b, bio);
+				trace_block_split(md->queue, b, bio->bi_iter.bi_sector);
 				ret = generic_make_request(bio);
 				break;
 			}
-- 
2.15.0

