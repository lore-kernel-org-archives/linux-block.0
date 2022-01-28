Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EB6C433F5
	for <linux-block@archiver.kernel.org>; Fri, 28 Jan 2022 04:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345959AbiA1ESC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 23:18:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21799 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236875AbiA1ESB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 23:18:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643343481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=1Bf1EUJyPBU3hvoZbXvQhOBhlizP0JEsfYBCXPFM+6E=;
        b=GQwOWeAaHvWDNkPm21HhRPjCbRrp16YIHb59CgMt3zd6VYwxr4x6wcq3rq1WN6a36n8v5F
        gF2VxcEP8c+72nvIRwAozbyp3K9Sg8uxVVTDNiZbWdalORXOpc5CqzywC12n2w0b8B88Oc
        x74VPRRAdkhA+hyXbX1KZhdICyk9obU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-478-vAOjgSBvPB22UCHhqMXVoQ-1; Thu, 27 Jan 2022 23:17:59 -0500
X-MC-Unique: vAOjgSBvPB22UCHhqMXVoQ-1
Received: by mail-qt1-f199.google.com with SMTP id b7-20020ac85bc7000000b002b65aee118bso3702182qtb.13
        for <linux-block@vger.kernel.org>; Thu, 27 Jan 2022 20:17:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1Bf1EUJyPBU3hvoZbXvQhOBhlizP0JEsfYBCXPFM+6E=;
        b=2y48mDSDxRNotL8jsH5hGCSSSTnmrzp7REqPTA+BbPAtGzo5Vs3Qib7Jq+bACpOmDW
         WeHUeDS+yPBU5kTUkFg8SJd6JkYzMjZRl7VFmDhN2uxGB45iTikxQWObOK7AWlQo4A1D
         OWKE2SUlRauk50J/nG6oIzasgR078LuAyw3BtgR/x/khpL6GOLeRH6na+t7suLa9RZQq
         Hmk6DfWMbqdjzS2Ik4hBMy7i4evVuPagP+PuMGUH5c3j/Fjz5egit5m/v3/EgEg7NhbU
         IW/zirJ/h+gSo83tXZFbjdNzz5xKvftvox+mWjy8NeAHtOaNfskalVcGeFWn2EM3cmNe
         cVZQ==
X-Gm-Message-State: AOAM532FrfSKVwwzX9C1BukiZDa5S87UdOMqWmBCpljhH1J71IJfWcuU
        QWJ4VPTNDG1bIvRGcgZICqFSyJvC0UViG2anUKFEcA/JbKKb10kApZwtAT77nP+/bWChuDRc3Fo
        tkRYcdmXJY6SyKrR5mwGiBg==
X-Received: by 2002:a05:622a:1109:: with SMTP id e9mr4938778qty.668.1643343479100;
        Thu, 27 Jan 2022 20:17:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxjblMjZCrb4E1TKOCdtECb10lLL2MgcX9OKfcprTLIoUEorrr6OxHrIKHsSSiLf39WEBf2SQ==
X-Received: by 2002:a05:622a:1109:: with SMTP id e9mr4938772qty.668.1643343478907;
        Thu, 27 Jan 2022 20:17:58 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id u9sm2578258qkp.37.2022.01.27.20.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 20:17:58 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     axboe@kernel.dk
Cc:     hch@lst.de, dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH v3 3/3] dm: properly fix redundant bio-based IO accounting
Date:   Thu, 27 Jan 2022 23:17:53 -0500
Message-Id: <20220128041753.32195-4-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220128041753.32195-1-snitzer@redhat.com>
References: <20220128041753.32195-1-snitzer@redhat.com>
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
+	bio_start_io_acct_time(bio, io->start_time);
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

