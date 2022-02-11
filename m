Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E75BC433F5
	for <linux-block@archiver.kernel.org>; Fri, 11 Feb 2022 21:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353761AbiBKVlf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Feb 2022 16:41:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353777AbiBKVlf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 16:41:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E564C6D
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 13:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644615691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=NzdOPJXGvWlTS8MF/XpfxdYLMQV7NltmT4t/BtAgnos=;
        b=BSXYUUqZliQy5Gqv0W4SgZin7EXBbMPJmL4SGwAnhU3gzUTwX6JBC9x3aweU6dzIzZY7/E
        UDdPe3BtDwEKuoQmlObKpDnJvf0PNQXA6SFzbXlZOH20yjlh3/t+0mEGtPYHZc+bmFXAct
        Hp3wsz1mCAcZ5VWTXTovEs0XzyWBARU=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-Yi0wH8rDO-uGBsObKhH1nw-1; Fri, 11 Feb 2022 16:41:30 -0500
X-MC-Unique: Yi0wH8rDO-uGBsObKhH1nw-1
Received: by mail-oo1-f70.google.com with SMTP id c124-20020a4a4f82000000b002fb4087a29fso6304447oob.20
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 13:41:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NzdOPJXGvWlTS8MF/XpfxdYLMQV7NltmT4t/BtAgnos=;
        b=bmeW1//KEWZBqyhrrzbul+ABGJHyL/orYd4rbtErWwuLaJr2sQrlWUgAe5qobzynms
         M0/tda1dgY5vS9lh8PEfMWhxqr60bdZBTnk0xrM9VgI3fa9MmbuTZ4TrDz7iINTbt8rI
         uiOLZzH/8j/Rvap7GEtUU7vxhSmRZs8eUQYWwQd0DhQ++1rpN9muAf9zvyli0YLARU4Q
         EqIjv113r5TNurZ7zfN+ufQvMX+x+n+Yy9Aeur3qJw456odlQ4rOTpNm+D5Q3/MgLKoG
         oLABpQQRNHSQL5eozOUZL5T9i58MiZW5k1nEBnUrupFm9b88t/gRTV9UIOsV9hiqeydS
         omUg==
X-Gm-Message-State: AOAM532nvyNHzg9GH4/qPhxW8U6+qFYby79CCJFLVDpRwi7xD9E2UfYR
        DE6/fyyD1/lFvrK8PzHGYx8pbV494ZuT+QsHeYAqxoMd+KEXmiJWxRV/DoURqoXkAuobr7e68Y5
        C5ttYm+6n3o0yE6uktb/k0w==
X-Received: by 2002:a05:6808:13d6:: with SMTP id d22mr1174118oiw.184.1644615689069;
        Fri, 11 Feb 2022 13:41:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzjvjfCjbkgODKupEk2FfXco+AHWfmEFNUHW5C40tZr+sBFx1L6qwEAK968vKCKNbAHr0iUvg==
X-Received: by 2002:a05:6808:13d6:: with SMTP id d22mr1174103oiw.184.1644615688566;
        Fri, 11 Feb 2022 13:41:28 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id o144sm10188855ooo.25.2022.02.11.13.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 13:41:28 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v2 14/14] dm: move duplicate code in callers of alloc_tio into alloc_tio
Date:   Fri, 11 Feb 2022 16:40:57 -0500
Message-Id: <20220211214057.40612-15-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220211214057.40612-1-snitzer@redhat.com>
References: <20220211214057.40612-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 2461df65e2fe..20c7b1b4d1f7 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -546,13 +546,16 @@ static struct bio *alloc_tio(struct clone_info *ci, struct dm_target *ti,
 		unsigned target_bio_nr, unsigned *len, gfp_t gfp_mask)
 {
 	struct dm_target_io *tio;
+	struct bio *clone;
 
 	if (!ci->io->tio.io) {
 		/* the dm_target_io embedded in ci->io is available */
 		tio = &ci->io->tio;
+		/* alloc_io() already initialized embedded clone */
+		clone = &tio->clone;
 	} else {
-		struct bio *clone = bio_alloc_clone(ci->bio->bi_bdev, ci->bio,
-						    gfp_mask, &ci->io->md->bs);
+		clone = bio_alloc_clone(ci->bio->bi_bdev, ci->bio,
+					gfp_mask, &ci->io->md->bs);
 		if (!clone)
 			return NULL;
 
@@ -567,7 +570,13 @@ static struct bio *alloc_tio(struct clone_info *ci, struct dm_target *ti,
 	tio->len_ptr = len;
 	tio->old_sector = 0;
 
-	return &tio->clone;
+	if (len) {
+		clone->bi_iter.bi_size = to_bytes(*len);
+		if (bio_integrity(clone))
+			bio_integrity_trim(clone);
+	}
+
+	return clone;
 }
 
 static void free_tio(struct bio *clone)
@@ -1258,17 +1267,12 @@ static void __send_duplicate_bios(struct clone_info *ci, struct dm_target *ti,
 		break;
 	case 1:
 		clone = alloc_tio(ci, ti, 0, len, GFP_NOIO);
-		if (len)
-			clone->bi_iter.bi_size = to_bytes(*len);
 		__map_bio(clone);
 		break;
 	default:
 		alloc_multiple_bios(&blist, ci, ti, num_bios, len);
-		while ((clone = bio_list_pop(&blist))) {
-			if (len)
-				clone->bi_iter.bi_size = to_bytes(*len);
+		while ((clone = bio_list_pop(&blist)))
 			__map_bio(clone);
-		}
 		break;
 	}
 }
@@ -1382,12 +1386,7 @@ static int __split_and_process_bio(struct clone_info *ci)
 		return r;
 
 	len = min_t(sector_t, max_io_len(ti, ci->sector), ci->sector_count);
-
 	clone = alloc_tio(ci, ti, 0, &len, GFP_NOIO);
-	clone->bi_iter.bi_size = to_bytes(len);
-	if (bio_integrity(clone))
-		bio_integrity_trim(clone);
-
 	__map_bio(clone);
 
 	ci->sector += len;
-- 
2.15.0

