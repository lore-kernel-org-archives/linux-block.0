Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80D5C4332F
	for <linux-block@archiver.kernel.org>; Thu, 10 Feb 2022 22:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345033AbiBJWiy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Feb 2022 17:38:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345032AbiBJWiy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Feb 2022 17:38:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFA932664
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 14:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644532733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=+Mnt9RTq0AtjFUsH7/0mhHCJN7nnx7AZj3Cr8laEsbg=;
        b=VbKD4yuqpCse32BCJBrCdxkvn0Mfc00NSIUVKB74wfMk2Ugee/AKsFOvR87t0ccvwEeQtu
        BmoJBteVT2QrWthOOPbzZTqQ9Hma0DRX1pWU3/MzUCybvvK1AJ1qICM+stLYqv6iYRklwK
        yYcaGca0twul6hDHgENreNxViLTrvyU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-349IyoPtNkSJ2j6Sw6h0cQ-1; Thu, 10 Feb 2022 17:38:52 -0500
X-MC-Unique: 349IyoPtNkSJ2j6Sw6h0cQ-1
Received: by mail-qk1-f200.google.com with SMTP id b18-20020a05620a089200b004e0e2f73f35so4533859qka.19
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 14:38:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+Mnt9RTq0AtjFUsH7/0mhHCJN7nnx7AZj3Cr8laEsbg=;
        b=Mc/54WlLLQKHLOfvVvhY42J4A+Db0fMitZRXa+brlCtpOZhuVZ8YdPUUWfkiizUT2R
         LeOm6Qbx962cNFY1IJuRNuNNHhn+xBp6gVvt1bs9cAWPX1OvND29DaS9vIiYuW+dcKxS
         +070d0RqOI1NCqEBbTGXwWBPcJcbqxiqcNkf67cKJhqnNW6j9RaAbgfrwbJLs9FgZPBW
         xNEwBv6kmvaEjzNfICc6OI6fNZy5NlPQpqHsGB0ienNHulPl6Xi0IEBcpXGvQZ4EggLq
         a/TUNQm6Wl/bfEIlRiIgz5NEPvahrWEDRGOcoPOm44EuDObOTatKmLxAjHtama+CbvPv
         xFVA==
X-Gm-Message-State: AOAM533V/6gHqdLb9dUOADJotb6zxWaP7pUcwb2RyNPdWkumGMKkhbZ9
        AlHN05lz9/2rS3MqFx17K+yf9KsNwPZoJv5OAqGvH72veEXYsJ8BE6WUxB9vGS48bt5mfs0NPIP
        xfp/Ee8Vx/5h4V04Abqff7Q==
X-Received: by 2002:a05:6214:2306:: with SMTP id gc6mr6868145qvb.63.1644532731983;
        Thu, 10 Feb 2022 14:38:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyamo0E431a2/YSMBqGadwIEB+1DQaLXFNobXLpuclNidyN4EcKw4raCDde0o/OY6oGwrdnag==
X-Received: by 2002:a05:6214:2306:: with SMTP id gc6mr6868140qvb.63.1644532731828;
        Thu, 10 Feb 2022 14:38:51 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id r3sm10312080qkm.56.2022.02.10.14.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 14:38:51 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 13/14] dm: improve correctness and efficiency of bio-based IO accounting
Date:   Thu, 10 Feb 2022 17:38:31 -0500
Message-Id: <20220210223832.99412-14-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220210223832.99412-1-snitzer@redhat.com>
References: <20220210223832.99412-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Don't use jiffies as a glorified bool because jiffies can/will
rollover to 0.

Also use xchg(), instead of spin_lock_irq{save,restore} and
smp_load_acquire/smp_store_release, to avoid performance impact of
disabling and enabling interrupts.

Suggested-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm-core.h |  2 +-
 drivers/md/dm.c      | 34 ++++++++++++----------------------
 2 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index 3ecd6f294f53..d3c116866fd7 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -230,7 +230,7 @@ struct dm_io {
 	atomic_t io_count;
 	struct bio *orig_bio;
 	unsigned long start_time;
-	unsigned long io_acct_time;
+	int was_accounted;
 	spinlock_t lock;
 	struct dm_stats_aux stats_aux;
 	/* last member of dm_target_io is 'struct bio' */
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index ad512f40716e..329f0be64523 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -487,17 +487,6 @@ EXPORT_SYMBOL_GPL(dm_start_time_ns_from_clone);
 
 static void __start_io_acct(struct dm_io *io, struct bio *bio)
 {
-	unsigned long flags;
-
-	/* Ensure IO accounting is only ever started once */
-	spin_lock_irqsave(&io->lock, flags);
-	if (smp_load_acquire(&io->io_acct_time)) {
-		spin_unlock_irqrestore(&io->lock, flags);
-		return;
-	}
-	smp_store_release(&io->io_acct_time, jiffies);
-	spin_unlock_irqrestore(&io->lock, flags);
-
 	bio_start_io_acct_time(bio, io->start_time);
 	if (unlikely(dm_stats_used(&io->md->stats)))
 		dm_stats_account_io(&io->md->stats, bio_data_dir(bio),
@@ -507,8 +496,8 @@ static void __start_io_acct(struct dm_io *io, struct bio *bio)
 
 static void start_io_acct(struct dm_io *io, struct bio *bio)
 {
-	/* Only start_io_acct() once for this IO */
-	if (smp_load_acquire(&io->io_acct_time))
+	/* Ensure IO accounting is only ever started once */
+	if (xchg(&io->was_accounted, 1) == 1)
 		return;
 
 	__start_io_acct(io, bio);
@@ -518,8 +507,8 @@ static void clone_and_start_io_acct(struct dm_io *io, struct bio *bio)
 {
 	struct bio io_acct_clone;
 
-	/* Only clone_and_start_io_acct() once for this IO */
-	if (smp_load_acquire(&io->io_acct_time))
+	/* Ensure IO accounting is only ever started once */
+	if (xchg(&io->was_accounted, 1) == 1)
 		return;
 
 	bio_init_clone(io->orig_bio->bi_bdev,
@@ -530,9 +519,6 @@ static void clone_and_start_io_acct(struct dm_io *io, struct bio *bio)
 static void end_io_acct(struct mapped_device *md, struct bio *bio,
 			unsigned long start_time, struct dm_stats_aux *stats_aux)
 {
-	if (!start_time)
-		return;
-
 	bio_end_io_acct(bio, start_time);
 
 	if (unlikely(dm_stats_used(&md->stats)))
@@ -562,7 +548,7 @@ static struct dm_io *alloc_io(struct mapped_device *md, struct bio *bio)
 	spin_lock_init(&io->lock);
 
 	io->start_time = jiffies;
-	io->io_acct_time = 0;
+	io->was_accounted = 0;
 
 	return io;
 }
@@ -819,6 +805,7 @@ void dm_io_dec_pending(struct dm_io *io, blk_status_t error)
 	blk_status_t io_error;
 	struct bio *bio;
 	struct mapped_device *md = io->md;
+	bool was_accounted = false;
 	unsigned long start_time = 0;
 	struct dm_stats_aux stats_aux;
 
@@ -852,11 +839,14 @@ void dm_io_dec_pending(struct dm_io *io, blk_status_t error)
 		}
 
 		io_error = io->status;
-		if (io->io_acct_time)
+		if (io->was_accounted) {
+			was_accounted = true;
 			start_time = io->start_time;
-		stats_aux = io->stats_aux;
+			stats_aux = io->stats_aux;
+		}
 		free_io(io);
-		end_io_acct(md, bio, start_time, &stats_aux);
+		if (was_accounted)
+			end_io_acct(md, bio, start_time, &stats_aux);
 
 		/* nudge anyone waiting on suspend queue */
 		if (unlikely(wq_has_sleeper(&md->wait)))
-- 
2.15.0

