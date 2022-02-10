Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F452C433F5
	for <linux-block@archiver.kernel.org>; Thu, 10 Feb 2022 22:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345028AbiBJWir (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Feb 2022 17:38:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345022AbiBJWir (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Feb 2022 17:38:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C32702664
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 14:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644532727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=DEABWOQAG5wChjoRVdmD9+4tJqi002FLqoS+HHDd0E8=;
        b=Vr/VJqaOg1oqHZSK/mtUuA68HaMDLweWwMBzA8GswOzCrtrmGS+t+PS4Fl/LNLqDmHZKIl
        TEpMIPRa9ak4MGxjTn1sN479OSLupGcNjrMJtpHgnx09EgltwJKp33+xXNmJoDR1liXsH/
        U118mib5CXtprjZy9c/W3CaN26CdsUs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-74-wOoIMIQVOMWZymbz9910XQ-1; Thu, 10 Feb 2022 17:38:44 -0500
X-MC-Unique: wOoIMIQVOMWZymbz9910XQ-1
Received: by mail-qk1-f197.google.com with SMTP id p23-20020a05620a15f700b00506d8ec3749so4592689qkm.4
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 14:38:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DEABWOQAG5wChjoRVdmD9+4tJqi002FLqoS+HHDd0E8=;
        b=dgXSl/7zni+ly+eB2bmUUIgGfDlaPUsB3TNXFtDRPJKi4R8eC59xuB4Lnudlj9dcRh
         Bscb8P0YhnGPjS/eOQ310Ie5ZIqJhrIAHnydkqEB/dwao3Ym9CSKgTEThaXf9L28nfEi
         fxysQs0I8UOg6D4913JPILPHJykkFeMbkdEzRuiSIZihcszeqvCsNPJ8EaZIgDtAAPqs
         qPKjj2Ro/mg0NwzESV8WjB+NUnRByLMJDcsUX9jspDmIDAoG10r3Wjik/434/6sv7oHx
         TKeg9KAt4Zk3p4AQrhLreR7aFwl+xms1WfXtUSX+WJ+8YRI5TfXRNqNhEk+YMxkq/kM7
         50dw==
X-Gm-Message-State: AOAM532u4fk+tWzBJ/ZAf+4ftpXTUFfdaL94Hq9rKoWLqubql9T1jdUk
        25eWI8aYKsnmTWhVlqkbkMxQ9XOrr2YUg2cRbEs3HQC89EbHotGQXGo3G/md4eV/cNO9FStIMGL
        Xoy6BMK2QFAMXRiFFPP8Jcw==
X-Received: by 2002:a05:620a:2954:: with SMTP id n20mr4949256qkp.644.1644532723815;
        Thu, 10 Feb 2022 14:38:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwB/jwDj6FI1/7jk/S/HO15AQAsoYUPunogWnQegdbM0VkAmgE3KfBpXMwIwDBuvLYdBmPAtw==
X-Received: by 2002:a05:620a:2954:: with SMTP id n20mr4949253qkp.644.1644532723624;
        Thu, 10 Feb 2022 14:38:43 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id n7sm11816185qta.78.2022.02.10.14.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 14:38:43 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 07/14] dm: remove code only needed before submit_bio recursion
Date:   Thu, 10 Feb 2022 17:38:25 -0500
Message-Id: <20220210223832.99412-8-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220210223832.99412-1-snitzer@redhat.com>
References: <20220210223832.99412-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 8615cb65bd63 ("dm: remove useless loop in
__split_and_process_bio") showcased that we no longer loop.

Remove the bio_advance() in __split_and_process_bio() that was only
needed when looping was possible.

Similarly there is no need to advance the bio, using ci->sector
cursor, in __send_duplicate_bios().

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index f091bbf8a8dc..5950d518e544 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1176,12 +1176,6 @@ static void __map_bio(struct bio *clone)
 	}
 }
 
-static void bio_setup_sector(struct bio *bio, sector_t sector, unsigned len)
-{
-	bio->bi_iter.bi_sector = sector;
-	bio->bi_iter.bi_size = to_bytes(len);
-}
-
 static void alloc_multiple_bios(struct bio_list *blist, struct clone_info *ci,
 				struct dm_target *ti, unsigned num_bios,
 				unsigned *len)
@@ -1224,14 +1218,14 @@ static void __send_duplicate_bios(struct clone_info *ci, struct dm_target *ti,
 	case 1:
 		clone = alloc_tio(ci, ti, 0, len, GFP_NOIO);
 		if (len)
-			bio_setup_sector(clone, ci->sector, *len);
+			clone->bi_iter.bi_size = to_bytes(*len);
 		__map_bio(clone);
 		break;
 	default:
 		alloc_multiple_bios(&blist, ci, ti, num_bios, len);
 		while ((clone = bio_list_pop(&blist))) {
 			if (len)
-				bio_setup_sector(clone, ci->sector, *len);
+				clone->bi_iter.bi_size = to_bytes(*len);
 			__map_bio(clone);
 		}
 		break;
@@ -1350,7 +1344,6 @@ static int __split_and_process_bio(struct clone_info *ci)
 	len = min_t(sector_t, max_io_len(ti, ci->sector), ci->sector_count);
 
 	clone = alloc_tio(ci, ti, 0, &len, GFP_NOIO);
-	bio_advance(clone, to_bytes(ci->sector - clone->bi_iter.bi_sector));
 	clone->bi_iter.bi_size = to_bytes(len);
 	if (bio_integrity(clone))
 		bio_integrity_trim(clone);
-- 
2.15.0

