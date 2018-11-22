Return-Path: <SRS0=CtFQ=OB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECCAC43441
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 19:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1714720866
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 19:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0dARc4HP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1714720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438587AbeKWGe4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Nov 2018 01:34:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:33740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406898AbeKWGe4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Nov 2018 01:34:56 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A20520672;
        Thu, 22 Nov 2018 19:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542916443;
        bh=kJUXg9Rdnas58kIR34FlFWSowoV8kXgkJn9LFnz2FlQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0dARc4HPEVoT8njQojyCABKI5sN67+jEsN2J+TNO+CiicnEpNzzGrKAiwk0QZmk3L
         NYbyW+BQpGAsX3tYIFYEE9LcnhqAXj2zjQFqx4VsdXyI8Wy9N86HWh0zVdfhRtevSP
         uRWjp4O2Pilv7FI7pihy2a4dIc3ogZ78eTTm97pI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.com>, Jean Delvare <jdelvare@suse.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 24/36] block: copy ioprio in __bio_clone_fast() and bounce
Date:   Thu, 22 Nov 2018 14:52:28 -0500
Message-Id: <20181122195240.13123-24-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181122195240.13123-1-sashal@kernel.org>
References: <20181122195240.13123-1-sashal@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Hannes Reinecke <hare@suse.com>

[ Upstream commit ca474b73896bf6e0c1eb8787eb217b0f80221610 ]

We need to copy the io priority, too; otherwise the clone will run
with a different priority than the original one.

Fixes: 43b62ce3ff0a ("block: move bio io prio to a new field")
Signed-off-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jean Delvare <jdelvare@suse.de>

Fixed up subject, and ordered stores.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bio.c    | 1 +
 block/bounce.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 0093bed81c0e..0a95eb3bd5a1 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -605,6 +605,7 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
 	if (bio_flagged(bio_src, BIO_THROTTLED))
 		bio_set_flag(bio, BIO_THROTTLED);
 	bio->bi_opf = bio_src->bi_opf;
+	bio->bi_ioprio = bio_src->bi_ioprio;
 	bio->bi_write_hint = bio_src->bi_write_hint;
 	bio->bi_iter = bio_src->bi_iter;
 	bio->bi_io_vec = bio_src->bi_io_vec;
diff --git a/block/bounce.c b/block/bounce.c
index 418677dcec60..abb50e7e5fab 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -248,6 +248,7 @@ static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask,
 		return NULL;
 	bio->bi_disk		= bio_src->bi_disk;
 	bio->bi_opf		= bio_src->bi_opf;
+	bio->bi_ioprio		= bio_src->bi_ioprio;
 	bio->bi_write_hint	= bio_src->bi_write_hint;
 	bio->bi_iter.bi_sector	= bio_src->bi_iter.bi_sector;
 	bio->bi_iter.bi_size	= bio_src->bi_iter.bi_size;
-- 
2.17.1

