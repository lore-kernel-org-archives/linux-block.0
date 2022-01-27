Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CCDC433FE
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 22:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbiA0W45 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 17:56:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21565 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229801AbiA0W44 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 17:56:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643324216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=vJ6TnJPKd3jnAAKSRYmEdyBJB9c5u4F9myAf76vl6jE=;
        b=J33ymQjexydbPNM+4OytE1i7B+RyBTbZCFi54KA18Nh1d/eIN3syCoBk8sYpelZTPmXTfD
        tclDovBggLdaSRfQyCDZ1l3VKBcV7PSZbJjxxnu3lEhyOvoCeipJHzdUUHzDhKImJJhPvW
        eRTQkciFwSEy7gY+W7YM/VzhBQFs+Bw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-196-2x-7KD3sOnOFI60Zk27uSw-1; Thu, 27 Jan 2022 17:56:55 -0500
X-MC-Unique: 2x-7KD3sOnOFI60Zk27uSw-1
Received: by mail-qv1-f70.google.com with SMTP id e14-20020a0cf34e000000b0042623ad325aso91198qvm.16
        for <linux-block@vger.kernel.org>; Thu, 27 Jan 2022 14:56:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vJ6TnJPKd3jnAAKSRYmEdyBJB9c5u4F9myAf76vl6jE=;
        b=Oufe10Z/SRzc5vOca1WlnvbvFZ1cwZsKza0+ANPlRe5UsQxF/qQUE43X31bjcmxS2U
         9dZ2szcK5neLdQbi5CxqtYj0T6j3800BXWqDYkd9J6z8sdR2wTlF7WfwTay6AC/QC/UQ
         Nu31ZSob8IbNuq7/GyOnriSwEX+nUJX3fESz+rCiyEdwFREil2Ju+cGsE0KdywSnpBk8
         w+8SzvgaUUGpyWbt8gdiokd6UCGTdONFv1JwLaIrrobJqle9cGN3syX8bLywKWv7DIk2
         HY0dTE/dkmNiQTrKw86f+4jDASx1Cqw6i99Z0cs5q4mcm3c5WnCEQuYimNTMqAifEjU4
         H4rQ==
X-Gm-Message-State: AOAM5301jyRPsRe6DWjrOJFUZAIgAFpHYHPglWFVao7AxPrsAvkp+duG
        M90XqEjJ90lBEiwcBHMU/0f0D3XmELJV7S+JwkXwpN9fVpzyvmnn2aiT4IggkfSyqLZ9YLneNl7
        BpQVpNlTUVK4N5XoPt4oVPw==
X-Received: by 2002:a05:620a:450c:: with SMTP id t12mr4251281qkp.343.1643324214621;
        Thu, 27 Jan 2022 14:56:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0nJBNt2XNTVFChnIRxj7wnHOd+t1Jl5N/kzJqu73nkFplu02EOEvuNXsrUdyeMf2Ql9ud7g==
X-Received: by 2002:a05:620a:450c:: with SMTP id t12mr4251277qkp.343.1643324214446;
        Thu, 27 Jan 2022 14:56:54 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id n17sm1149219qkp.89.2022.01.27.14.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 14:56:54 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     axboe@kernel.dk
Cc:     hch@lst.de, dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH v2 3/3] dm: properly fix redundant bio-based IO accounting
Date:   Thu, 27 Jan 2022 17:56:48 -0500
Message-Id: <20220127225648.28729-4-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220127225648.28729-1-snitzer@redhat.com>
References: <20220127225648.28729-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Record the start_time for a bio but defer the starting block core's IO
accounting until after IO is submitted using bio_start_io_acct_time().

This approach avoids the need to mess around with any of the
individual IO stats in response to a bio_split() that follows bio
submission.

Reported-by: Bud Brown <bubrown@redhat.com>
Cc: stable@vger.kernel.org
Depends-on: f9893e1da2e3 ("block: add bio_start_io_acct_time() to control start_time")
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 9849114b3c08..144436301a57 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -489,7 +489,7 @@ static void start_io_acct(struct dm_io *io)
 	struct mapped_device *md = io->md;
 	struct bio *bio = io->orig_bio;
 
-	io->start_time = bio_start_io_acct(bio);
+	__bio_start_io_acct(bio, io->start_time);
 	if (unlikely(dm_stats_used(&md->stats)))
 		dm_stats_account_io(&md->stats, bio_data_dir(bio),
 				    bio->bi_iter.bi_sector, bio_sectors(bio),
@@ -535,7 +535,7 @@ static struct dm_io *alloc_io(struct mapped_device *md, struct bio *bio)
 	io->md = md;
 	spin_lock_init(&io->endio_lock);
 
-	start_io_acct(io);
+	io->start_time = READ_ONCE(jiffies);
 
 	return io;
 }
@@ -1482,6 +1482,7 @@ static void __split_and_process_bio(struct mapped_device *md,
 			submit_bio_noacct(bio);
 		}
 	}
+	start_io_acct(ci.io);
 
 	/* drop the extra reference count */
 	dm_io_dec_pending(ci.io, errno_to_blk_status(error));
-- 
2.15.0

