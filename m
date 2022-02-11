Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06963C433FE
	for <linux-block@archiver.kernel.org>; Fri, 11 Feb 2022 21:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353715AbiBKVlN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Feb 2022 16:41:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241155AbiBKVlM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 16:41:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF042C62
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 13:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644615669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=pSQq04wy06PXm26IhLE5PNJWpgzIDfqO8yF6qrhvU94=;
        b=V7Bnws2jM6WeymuQcedNrKWpjINPQ08kLI6UTMIzJaOx+rSJntuYpDdGy7KBDavWe+Ap62
        Gwuo621v6z8jVoeMd0CQ2uLPHei82zK5KQZTytEzrx27koQXCu3RVnFeUGgyrIJuTzImml
        7MyOzim5mw6pIwe27LNb4ZE4Rht/+bs=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-SZGNJOOsNQC9snaouI3Elw-1; Fri, 11 Feb 2022 16:41:08 -0500
X-MC-Unique: SZGNJOOsNQC9snaouI3Elw-1
Received: by mail-ot1-f71.google.com with SMTP id g6-20020a9d6b06000000b005abea86957eso4827232otp.14
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 13:41:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pSQq04wy06PXm26IhLE5PNJWpgzIDfqO8yF6qrhvU94=;
        b=iUuznRbSUs/eHVUF7vf0zf66yegVAi1sEfJpSrl+HT1JwORuUCT4CrDsGcQX5ijAEG
         xQd5MeyGzFin37OT3b2GDcVELC5HBlKOcFEK+Obh8nLXMVDG7eF/q7LoYOK8p0bTiytf
         OFswt17vD2I0ZgV/31b9PAc8Cq167wVHmJw09MOqiZgGvRvELUMJf6NQfkyHqtsti9gA
         5yWvvZvMtbTRV+5euTr8x8a3oPgOJP21mfJWp0f2j+awjW8UYcJXYOarBQd7msG08pTP
         u2evYUEus1icAJPs+mMnCCWUAw89Fs21Y56fSYbh1TWjr7v1AjSPBYlrg0r9gE/9F8sA
         c9Gw==
X-Gm-Message-State: AOAM531fAKZAmUR3IPqJqBMx1011dORDr197IKO3mhm8TdHB98/PR041
        Qu4qRu8QvVBr5N9ZtGGAX72px4TfUogRY6kvScS/Kk7HB0r24GkDMHFclPcmud/uZIO6xPFE3i/
        HoJ8cP/LkKZRr/59YziWliA==
X-Received: by 2002:a9d:6c8b:: with SMTP id c11mr1270686otr.92.1644615667634;
        Fri, 11 Feb 2022 13:41:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzFoas0EWXUNof1qFC7AgnYYs6iZQl7YqF3JcxmfK7cJthcvMpyzcju8Qara2vobaiK5lDdjA==
X-Received: by 2002:a9d:6c8b:: with SMTP id c11mr1270675otr.92.1644615667250;
        Fri, 11 Feb 2022 13:41:07 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id bl6sm10078090oib.38.2022.02.11.13.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 13:41:06 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v2 02/14] dm: fold __clone_and_map_data_bio into __split_and_process_bio
Date:   Fri, 11 Feb 2022 16:40:45 -0500
Message-Id: <20220211214057.40612-3-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220211214057.40612-1-snitzer@redhat.com>
References: <20220211214057.40612-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fold __clone_and_map_data_bio into its only caller.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 2cecb8832936..2f1942b61d48 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1188,25 +1188,6 @@ static void bio_setup_sector(struct bio *bio, sector_t sector, unsigned len)
 	bio->bi_iter.bi_size = to_bytes(len);
 }
 
-/*
- * Creates a bio that consists of range of complete bvecs.
- */
-static int __clone_and_map_data_bio(struct clone_info *ci, struct dm_target *ti,
-				    sector_t sector, unsigned *len)
-{
-	struct bio *bio = ci->bio, *clone;
-
-	clone = alloc_tio(ci, ti, 0, len, GFP_NOIO);
-	bio_advance(clone, to_bytes(sector - clone->bi_iter.bi_sector));
-	clone->bi_iter.bi_size = to_bytes(*len);
-
-	if (bio_integrity(bio))
-		bio_integrity_trim(clone);
-
-	__map_bio(clone);
-	return 0;
-}
-
 static void alloc_multiple_bios(struct bio_list *blist, struct clone_info *ci,
 				struct dm_target *ti, unsigned num_bios,
 				unsigned *len)
@@ -1361,6 +1342,7 @@ static bool __process_abnormal_io(struct clone_info *ci, struct dm_target *ti,
  */
 static int __split_and_process_bio(struct clone_info *ci)
 {
+	struct bio *clone;
 	struct dm_target *ti;
 	unsigned len;
 	int r;
@@ -1374,9 +1356,13 @@ static int __split_and_process_bio(struct clone_info *ci)
 
 	len = min_t(sector_t, max_io_len(ti, ci->sector), ci->sector_count);
 
-	r = __clone_and_map_data_bio(ci, ti, ci->sector, &len);
-	if (r < 0)
-		return r;
+	clone = alloc_tio(ci, ti, 0, &len, GFP_NOIO);
+	bio_advance(clone, to_bytes(ci->sector - clone->bi_iter.bi_sector));
+	clone->bi_iter.bi_size = to_bytes(len);
+	if (bio_integrity(clone))
+		bio_integrity_trim(clone);
+
+	__map_bio(clone);
 
 	ci->sector += len;
 	ci->sector_count -= len;
-- 
2.15.0

