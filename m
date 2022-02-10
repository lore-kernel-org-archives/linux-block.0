Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC40EC433FE
	for <linux-block@archiver.kernel.org>; Thu, 10 Feb 2022 22:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345012AbiBJWij (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Feb 2022 17:38:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238352AbiBJWij (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Feb 2022 17:38:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A37E92664
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 14:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644532718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=gASqrtvOszXul4kd0cd64/f9seYYh7m9E4wnSmr4aF8=;
        b=WWDbVzTFf03vSHz9eFdBbUtQJEm4iUXd/HnNl78QJXZLHciPBeDk5O0pYKhFB9hzM44P8f
        cc9l8EmHKHD3b/QBhGNBBtCg+7MCoUPHMLb2EmrJKtyvz6ZEFqF7l4Shd1DrChVJw/0P5w
        mMjPoliec/OeLmQY96H+c/oOCBuDSPI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-XIfGEU_9N-6Fy6cx7umvDA-1; Thu, 10 Feb 2022 17:38:37 -0500
X-MC-Unique: XIfGEU_9N-6Fy6cx7umvDA-1
Received: by mail-qv1-f71.google.com with SMTP id du13-20020a05621409ad00b0042c2949e2c1so4990692qvb.19
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 14:38:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gASqrtvOszXul4kd0cd64/f9seYYh7m9E4wnSmr4aF8=;
        b=q17LQf8obUKQebXVmcgNyv4QhIxZldKbFbqDXeZeVd2898yvF06+54x8fq4CzaLL3V
         uR1oeXEOyHQoYzuJjjiVxVe5pY5INgTkSFep+3P550Jv/7fNuAh5/n1aif2x6I3yedp5
         mZTb2uX7cLki1b2ML0J2/CEIVhAH8iiVNf+mRO7uVfwWOhDUsFGqwl1xOtpmHXhBn+7/
         ikNOoq4j1UM5taMCJ80KGGNFv7YfyKPd3sJ20Rlg6E8N12PoEqzLo8q1zwVf2fdxCLag
         n9qTGgR/Wgf63VV/OtW6bpQfPmH9FYRTSUCnclZDEgo9AMxyFn5RLO8Ueqg7EOMcv4iV
         twxg==
X-Gm-Message-State: AOAM530Rzw7EL8bmMyF59EWuyqTCrPj8D7dBrDmJJcJ5nDa5p7cTIx0R
        WwQDq7byc8sslEwEwexBuZ08EfM6Eu/MH6HwDXFxXZbpOz+iroBtQHC4uGOe2XDx+opKq2Xzqyb
        PIpodQ5qYLL5j5wbyqK1z7Q==
X-Received: by 2002:a05:6214:262a:: with SMTP id gv10mr6836043qvb.98.1644532717061;
        Thu, 10 Feb 2022 14:38:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzshop5rhMcKKQyyYkS5tpUkVizfBc4b1Us/DFjfwBMEjhEWnkmSha5lLdwwyHGYJ/E/eeeTw==
X-Received: by 2002:a05:6214:262a:: with SMTP id gv10mr6836035qvb.98.1644532716895;
        Thu, 10 Feb 2022 14:38:36 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id y15sm10527083qko.133.2022.02.10.14.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 14:38:36 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 02/14] dm: fold __clone_and_map_data_bio into __split_and_process_bio
Date:   Thu, 10 Feb 2022 17:38:20 -0500
Message-Id: <20220210223832.99412-3-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220210223832.99412-1-snitzer@redhat.com>
References: <20220210223832.99412-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fold __clone_and_map_data_bio into its only caller.

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

