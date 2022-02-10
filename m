Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64446C433EF
	for <linux-block@archiver.kernel.org>; Thu, 10 Feb 2022 22:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345031AbiBJWiw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Feb 2022 17:38:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345026AbiBJWiv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Feb 2022 17:38:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2932D2664
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 14:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644532731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=QSJblWqLgyZmlZxEVd+22+iLGNHpkwCdE5Y4iGn/nKk=;
        b=B75ltYWfx6YwdcMKvPiBLipoM4wJYMkJ9i9xcRjzBaUOtes2kh9BwRgFgpImH4tU/8Q9jV
        hdrFrD19U4zQ3f8UiJcirIPjhrprwB4hOwOi4biDLRTgb7GTe8eTtvNyok3DnZBvzflU/J
        mLoeQ2ASwPjAPC9bfj30PYT7sIThxY8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-155--OMCaOwqPy29gx78bCWKuw-1; Thu, 10 Feb 2022 17:38:50 -0500
X-MC-Unique: -OMCaOwqPy29gx78bCWKuw-1
Received: by mail-qt1-f197.google.com with SMTP id d25-20020ac84e39000000b002d1cf849207so5513244qtw.19
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 14:38:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QSJblWqLgyZmlZxEVd+22+iLGNHpkwCdE5Y4iGn/nKk=;
        b=rUBhUKdsCRcnt9kzfDGGqrEuPqo5gHQFR8Th3ofC2zFQZdtfFMYPuGLOXEUhOmVV+R
         IW7Lwi/nV4f9v5sWXrsriiiXyltgoWLmyyjHXfHEftFmjE+/tAVAPKFFgETC+p9JfjSy
         HkVXjKa+PMue1E0nM7VMei8/L6M1r0SXcEoMBakePJLPbZUNTTUrM9+z1lQywCAuoWTr
         NVEHWR1m/ov/kzKxVYx66pEb2GfqGnEbjjU1O+QxoHyZRGjMZJSSigA1p4/EnrepfuEm
         4dKsb7Q6aVOkg3Pe7w+QKft9snOC8G0+xQovVn+6O+H1OC5PBSHSCY1zB+3TCgwO3Z6k
         grwg==
X-Gm-Message-State: AOAM531ovQV2Z2rxYZGuFIrOmZJln+iexgnsTGWTvX2sWcLoSsyuTK66
        QYRIfp0hr5MZPP3WHfsEEC79mYPx2PzSgrVfKIhTrNwzxx07iH8wI0KmAEf3oYk0xXb7Wydbcac
        TkLWibT5cEHRkTqSGqJGacQ==
X-Received: by 2002:a05:622a:411:: with SMTP id n17mr6496115qtx.466.1644532729490;
        Thu, 10 Feb 2022 14:38:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzT+PtvXuOy9fF5SaJVeCa3zFUy2819JDuwEm2PCy3GAfUwDOgDHA08+EaJap4V4vdpA0o8KQ==
X-Received: by 2002:a05:622a:411:: with SMTP id n17mr6496110qtx.466.1644532729298;
        Thu, 10 Feb 2022 14:38:49 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id j11sm11447294qtx.67.2022.02.10.14.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 14:38:48 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 11/14] dm crypt: use dm_submit_bio_remap
Date:   Thu, 10 Feb 2022 17:38:29 -0500
Message-Id: <20220210223832.99412-12-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220210223832.99412-1-snitzer@redhat.com>
References: <20220210223832.99412-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm-crypt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index a5006cb6ee8a..9ea197de08c2 100644
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
-- 
2.15.0

