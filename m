Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AC0C433FE
	for <linux-block@archiver.kernel.org>; Fri, 11 Feb 2022 21:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbiBKVlc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Feb 2022 16:41:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345121AbiBKVlb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 16:41:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 775E5CC3
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 13:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644615687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=zCLaNAewIh7QkuP3rRG3MbVBEGym23cj6pMb7L3QmRw=;
        b=a26APAYz2mYmzAz3DwtdyypZwtf+WMEzjKDDE/BQhczBLvQ/3CBjiALIHwSvpj1To/Do9q
        V02Gjp0tN4JQr2S42nZx9T0q4myRkGl8tVjxlBTuiDsrDh1lXlunab6GRB+sAD0eFcaLk0
        lA3MNt+uti5GdKeUOizXhbUvhttsAAY=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-505-Tm37Y0l7PxaJ701yA7IY3A-1; Fri, 11 Feb 2022 16:41:26 -0500
X-MC-Unique: Tm37Y0l7PxaJ701yA7IY3A-1
Received: by mail-oi1-f198.google.com with SMTP id bp18-20020a056808239200b002ced7afbfd2so2865132oib.19
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 13:41:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zCLaNAewIh7QkuP3rRG3MbVBEGym23cj6pMb7L3QmRw=;
        b=BIKup70U/ROfCups+ibrmUI0YQkT4ShGcwNvHjZw9KoTOB9xhry1ECNGIvuv54XRiT
         SFnpow6JQXduJjkEa2AQHLM3ExeAdDBn7cK6WPMBM0K9lfTCv3NQMsXJGyVuKy8M3C2N
         vC4DVrrqd7TQHaKxwjMCb22zJZtv+J6p+WJI0gh8iHjraKInFLnSVEcNRVsdH240Uf2I
         hRKy7ooug1lz5fD7TuM+58wA2AOdPkTIJrg2J70MhnkJYZqud+TQkWnpfmB3HRq/tp5S
         xtwcAJ6XTswI156RcetkAxhzs6AlG+U0k+i2pZpgPgGJKIjM2e/nenp2Stxe9eCRjBDW
         GO1g==
X-Gm-Message-State: AOAM530hj6TGWALui9wB5hhxWuqoKRzJpPxyDe8XVPgRqcjPRdoJoHNR
        pI4+xEPNyBCrYv3InXDeH1nM5ZnQNz0fqNBg+jLrUDX417bJ7J8Vd4kRACoxvIfFeRc+BhsUiHs
        pmMIQ7ie1V5ij50tgYP7Y5A==
X-Received: by 2002:a9d:58c8:: with SMTP id s8mr1306855oth.294.1644615685120;
        Fri, 11 Feb 2022 13:41:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyzn92w1zkt3XkDgBb0WATQwhT0Cg5dpyyOjGhJ9x8FW+WtRk+rD9rUvvy7aLTh3q+qoANrxw==
X-Received: by 2002:a9d:58c8:: with SMTP id s8mr1306850oth.294.1644615684909;
        Fri, 11 Feb 2022 13:41:24 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id n4sm9481217otq.63.2022.02.11.13.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 13:41:24 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v2 12/14] dm crypt: use dm_submit_bio_remap
Date:   Fri, 11 Feb 2022 16:40:55 -0500
Message-Id: <20220211214057.40612-13-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220211214057.40612-1-snitzer@redhat.com>
References: <20220211214057.40612-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm-crypt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index a5006cb6ee8a..337517cb4e90 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1855,7 +1855,7 @@ static int kcryptd_io_read(struct dm_crypt_io *io, gfp_t gfp)
 		return 1;
 	}
 
-	submit_bio_noacct(clone);
+	dm_submit_bio_remap(io->base_bio, clone);
 	return 0;
 }
 
@@ -1881,7 +1881,7 @@ static void kcryptd_io_write(struct dm_crypt_io *io)
 {
 	struct bio *clone = io->ctx.bio_out;
 
-	submit_bio_noacct(clone);
+	dm_submit_bio_remap(io->base_bio, clone);
 }
 
 #define crypt_io_from_node(node) rb_entry((node), struct dm_crypt_io, rb_node)
@@ -1960,7 +1960,7 @@ static void kcryptd_crypt_write_io_submit(struct dm_crypt_io *io, int async)
 
 	if ((likely(!async) && test_bit(DM_CRYPT_NO_OFFLOAD, &cc->flags)) ||
 	    test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags)) {
-		submit_bio_noacct(clone);
+		dm_submit_bio_remap(io->base_bio, clone);
 		return;
 	}
 
@@ -3363,6 +3363,7 @@ static int crypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 
 	ti->num_flush_bios = 1;
 	ti->limit_swap_bios = true;
+	ti->accounts_remapped_io = true;
 
 	dm_audit_log_ctr(DM_MSG_PREFIX, ti, 1);
 	return 0;
@@ -3626,7 +3627,7 @@ static void crypt_io_hints(struct dm_target *ti, struct queue_limits *limits)
 
 static struct target_type crypt_target = {
 	.name   = "crypt",
-	.version = {1, 23, 0},
+	.version = {1, 24, 0},
 	.module = THIS_MODULE,
 	.ctr    = crypt_ctr,
 	.dtr    = crypt_dtr,
-- 
2.15.0

