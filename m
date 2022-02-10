Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF718C433FE
	for <linux-block@archiver.kernel.org>; Thu, 10 Feb 2022 22:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345025AbiBJWio (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Feb 2022 17:38:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345022AbiBJWio (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Feb 2022 17:38:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F22D82664
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 14:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644532724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=TzXjPgdywpvS4JKTWEPuvG6S5tjQ0HqbosRT6X11Ckc=;
        b=bfCoOBquYIQUJyMZUlzTi5hQT+tOxYEa+ePqIz/x8TACjGpsjRne7EHM/yeraxPMeBZ1rI
        VsSmFJ+DvLJU44U+h1JCfEZ3soba3yAD4nMJvdAEHxY5LV+NhA0ZI+W3QRq15iF5bjd0aq
        BFDgBNi6OKUcVF4Z8SAiTxkOFCZYgtA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-458-DSzhdcofMkKWGvNh4ULfAg-1; Thu, 10 Feb 2022 17:38:43 -0500
X-MC-Unique: DSzhdcofMkKWGvNh4ULfAg-1
Received: by mail-qk1-f198.google.com with SMTP id z205-20020a3765d6000000b0047db3b020dfso4521445qkb.22
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 14:38:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TzXjPgdywpvS4JKTWEPuvG6S5tjQ0HqbosRT6X11Ckc=;
        b=yDa3waKWseD9XjwztGQSTLUAMVU+DNEWtp7SO+YHMNnC5U2GXaLHDJyTGF5fZZDC4D
         8eCo9G0OD/vrvtsvqhD4tSkCeM3AufAWcHa8eEi/tA16CvV4JktEzaQ65OtoKKifI8+y
         44WyvjGdGqL/g4NQ/pb8J7evY+7tLJu60arnY35Glw/FviF1JgxgQKZOYip0t+7MGrSW
         tygYeenWMQ1Dm6ty960pw4MKH+WxQnGTB79zDRb65VQtwnHR9YTRSX8MTxVJvVr6eAlJ
         uo3lhQJby/9ICB8zKo5Vec6ulSvj5vi8rFnkVuDapMsmLwTXPUtSVG989kOuDe+PG8B/
         hwfw==
X-Gm-Message-State: AOAM531HU3s1MeODq1VoPyqczTNKxdeEVS1QKNBwqfuH9qRT+HD8v7Gh
        VqM1pKiDhAljqXZPmjt0mAXt7nHJ0W9A0++S8HSSU007T3dW5qndUV2is7fP2cSmKi0QXNDgs51
        BGLK/EeTMJ+Ah2XdfMZ2pwQ==
X-Received: by 2002:a05:6214:5084:: with SMTP id kk4mr6496956qvb.87.1644532722332;
        Thu, 10 Feb 2022 14:38:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwdUxlHbTKVegt7q96UOVkLZzblVev6PndTCx99qOFkY4DYSKF6tEc5hRZE8V6mEfZmaLcoVA==
X-Received: by 2002:a05:6214:5084:: with SMTP id kk4mr6496949qvb.87.1644532722175;
        Thu, 10 Feb 2022 14:38:42 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id v14sm10322732qkl.128.2022.02.10.14.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 14:38:41 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 06/14] dm: remove unused mapped_device argument from free_tio
Date:   Thu, 10 Feb 2022 17:38:24 -0500
Message-Id: <20220210223832.99412-7-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220210223832.99412-1-snitzer@redhat.com>
References: <20220210223832.99412-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 1985fc3f2a95..f091bbf8a8dc 100644
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

