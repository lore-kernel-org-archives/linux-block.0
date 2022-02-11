Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C64CC4332F
	for <linux-block@archiver.kernel.org>; Fri, 11 Feb 2022 21:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353760AbiBKVlT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Feb 2022 16:41:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345121AbiBKVlT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 16:41:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F457C6A
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 13:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644615676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=2nmpafQ891zGruDm7dwh6CvU71ZYy/KSzMouVi0m1L4=;
        b=JRrCrjdHknyc7cJ0D6KBX5R4VWam10bDZGogvd0tOiosXCscklKzP1sNPVojON/THHvJqr
        6e8LlPgo10ZpEJOoIV24ZVRQf7yw4Ay4tuF5K8/lp/7QzInFd/3ZSBL05op4+3mloK/2t0
        p18iVKeQT1GgIBQcxpIEkyPhAElszAo=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-567-hhEfdB5SPWKubq-NlBqW1A-1; Fri, 11 Feb 2022 16:41:15 -0500
X-MC-Unique: hhEfdB5SPWKubq-NlBqW1A-1
Received: by mail-oo1-f71.google.com with SMTP id y20-20020a4acb94000000b003185ebeeffdso3619221ooq.15
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 13:41:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2nmpafQ891zGruDm7dwh6CvU71ZYy/KSzMouVi0m1L4=;
        b=nBdomT99tjaBvaiK9TxA3qwWAQcn+p+FiYeUE3xTylz8LkU4Ovh/ulubcmctdcaFO5
         Ya0+uPm4tGROQpJod8h1m9/y8yh4KHEPM547rOL/7QdaTTA3JzqTnHttLkonGy1MuVOo
         JBY4yP5de/qlf4p5RwJ+xzYMQ6wIF7l/dbbiL49sv/kXR/AiscOEs0lOH/3dd2+UWGQQ
         UUZVt3NUdxhJlxzQgtadCL45R0upq5x2bL6W5yb2A6wrCt4fECR/a95MBZcbHwHgAH8d
         RF1l3MokDwvirtmKFWCPfoyMNqoYhpwBG3nDkwUhiddkPhbEnISn0cWznzOg3Q8mwiOo
         AFtg==
X-Gm-Message-State: AOAM532duwKcpCQ+IeXKgOivc5ch3/B1IYCxJrcqpBeOo8QEFF9Atv41
        t4Qe3SV5nXX/taWZysPVNHc63J2Ae5CAiVEHRpEEIUcg6eY624/jtghzF0/mxRa48Le1S9Qucwj
        L3iinLm79XtXIbFVjEvlvDg==
X-Received: by 2002:a05:6808:21aa:: with SMTP id be42mr1202431oib.181.1644615674264;
        Fri, 11 Feb 2022 13:41:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzPfXPPLsFfj5jCNwhbMCjHAtWwuF5IJFLhrkJvKUleXUnCO1B4gxuNTOXX8lKI2/HhrYfUdA==
X-Received: by 2002:a05:6808:21aa:: with SMTP id be42mr1202427oib.181.1644615674109;
        Fri, 11 Feb 2022 13:41:14 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id b20sm9518934otq.20.2022.02.11.13.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 13:41:13 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v2 06/14] dm: remove unused mapped_device argument from free_tio
Date:   Fri, 11 Feb 2022 16:40:49 -0500
Message-Id: <20220211214057.40612-7-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220211214057.40612-1-snitzer@redhat.com>
References: <20220211214057.40612-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index bd07ccadbf01..137e578785f6 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -539,7 +539,7 @@ static struct dm_io *alloc_io(struct mapped_device *md, struct bio *bio)
 	return io;
 }
 
-static void free_io(struct mapped_device *md, struct dm_io *io)
+static void free_io(struct dm_io *io)
 {
 	bio_put(&io->tio.clone);
 }
@@ -825,7 +825,7 @@ void dm_io_dec_pending(struct dm_io *io, blk_status_t error)
 		io_error = io->status;
 		start_time = io->start_time;
 		stats_aux = io->stats_aux;
-		free_io(md, io);
+		free_io(io);
 		end_io_acct(md, bio, start_time, &stats_aux);
 
 		if (io_error == BLK_STS_DM_REQUEUE)
-- 
2.15.0

