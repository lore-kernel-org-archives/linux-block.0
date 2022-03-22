Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2A5C433F5
	for <linux-block@archiver.kernel.org>; Tue, 22 Mar 2022 19:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiCVTvD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Mar 2022 15:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbiCVTvC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Mar 2022 15:51:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F3854F9C5
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 12:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647978573;
        h=from:from:sender:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:in-reply-to:in-reply-to:
         references:references; bh=3cVB5xGp5SZscTV0JpNErHCNRhdsu/xqDSO16/65Gk4=;
        b=Ui9vavLsiCeKYQBUF3I1/rKDoky5GoRyjJUDOEvxbzp697T3kM18ibL9Fp+eVDCbdt9T3R
        7gh/GLAuRY/OBj7VgXqxZvoYjcrPieNEWYx6y3OSVP76XxGw4w0Q4tJzNTkERuMSY7Fci4
        PPZjzKwj2nIkhRzwIu+gJiOeUFhTkkw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-173-NVOl6Og2PN2j1OtDa_7NuQ-1; Tue, 22 Mar 2022 15:49:32 -0400
X-MC-Unique: NVOl6Og2PN2j1OtDa_7NuQ-1
Received: by mail-qt1-f198.google.com with SMTP id h11-20020a05622a170b00b002e0769b9018so12373065qtk.14
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 12:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=3cVB5xGp5SZscTV0JpNErHCNRhdsu/xqDSO16/65Gk4=;
        b=2nzp6c7Q0eJOUio0xiTaUBVbnBrOrN3fNWNXIEWn8fZIIytirEwh14hASjx7H/LEXR
         gEwU5+8YhWV2TJHOqa1mmORenk731SPGYnamAsUWDt4gxu/LuY3rJn26KpuQ8mzpHszF
         1oAYM4ItUYSCICtbJXCQ+sl17RvZAWslniKHeprySnRrRy8lzutVhAJoK3DbEorA04fx
         ljkIqNxe/00bLPz8etdOkeVxIatklt1OcB57hWAUG4jgujSCJ68GzucgjmJURmLN0Z63
         AtpscZa7iCRfT+x0MqQeQfmKrLqo5TdYSM7vW8FNOH6zKxNTF3zoOZmt/txEjJot7Ulb
         LJ4g==
X-Gm-Message-State: AOAM530YjUItsuH6596Oi8WCnyPOTCFijw9j30i5iu2EU8gKjoehWRv8
        3B4u4dFsZfsm6wzF7suEMOihUjaQHj5NrARLwKMDsbrqbB7yaaBzFy1SyEkyxMlwluUu61zLwON
        4fhgJ6bYU1CTBlDBCXb3nfA==
X-Received: by 2002:a05:622a:134d:b0:2e2:2802:15ff with SMTP id w13-20020a05622a134d00b002e2280215ffmr2455239qtk.413.1647978571823;
        Tue, 22 Mar 2022 12:49:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwC2IsFjp8HuwBZ0PkPpIAKSGVFZvigvzaUsqvzvIqB26eoTOji40/Opg7gasAyW4DiZ743TQ==
X-Received: by 2002:a05:622a:134d:b0:2e2:2802:15ff with SMTP id w13-20020a05622a134d00b002e2280215ffmr2455228qtk.413.1647978571575;
        Tue, 22 Mar 2022 12:49:31 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id w1-20020ac857c1000000b002e1e899badesm14497446qta.72.2022.03.22.12.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 12:49:31 -0700 (PDT)
Sender: Mike Snitzer <msnitzer@redhat.com>
From:   Mike Snitzer <snitzer@redhat.com>
X-Google-Original-From: Mike Snitzer <snitzer@kernel.org>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH 2/3] dm: enable BIOSET_PERCPU_CACHE for dm_io bioset
Date:   Tue, 22 Mar 2022 15:49:26 -0400
Message-Id: <20220322194927.42778-3-snitzer@kernel.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220322194927.42778-1-snitzer@kernel.org>
References: <20220322194927.42778-1-snitzer@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Also change dm_io_complete() to use bio_clear_polled() so that it
clears both REQ_POLLED and BIO_PERCPU_CACHE if the bio is requeued due
to BLK_STS_DM_REQUEUE.

Only io_uring benefits from using BIOSET_PERCPU_CACHE, it is only safe
to use in non-interrupt context but io_uring's completions are all in
process context.

This change improves DM's hipri bio polling performance by ~7%.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index a2e80c376827..06f3720a190b 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -899,9 +899,9 @@ static void dm_io_complete(struct dm_io *io)
 		/*
 		 * Upper layer won't help us poll split bio, io->orig_bio
 		 * may only reflect a subset of the pre-split original,
-		 * so clear REQ_POLLED in case of requeue
+		 * so clear REQ_POLLED and BIO_PERCPU_CACHE on requeue.
 		 */
-		bio->bi_opf &= ~REQ_POLLED;
+		bio_clear_polled(bio);
 		return;
 	}
 
@@ -3014,7 +3014,7 @@ struct dm_md_mempools *dm_alloc_md_mempools(struct mapped_device *md, enum dm_qu
 		pool_size = max(dm_get_reserved_bio_based_ios(), min_pool_size);
 		front_pad = roundup(per_io_data_size, __alignof__(struct dm_target_io)) + DM_TARGET_IO_BIO_OFFSET;
 		io_front_pad = roundup(per_io_data_size,  __alignof__(struct dm_io)) + DM_IO_BIO_OFFSET;
-		ret = bioset_init(&pools->io_bs, pool_size, io_front_pad, 0);
+		ret = bioset_init(&pools->io_bs, pool_size, io_front_pad, BIOSET_PERCPU_CACHE);
 		if (ret)
 			goto out;
 		if (integrity && bioset_integrity_create(&pools->io_bs, pool_size))
-- 
2.15.0

