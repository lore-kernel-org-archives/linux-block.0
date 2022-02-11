Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D8AC433EF
	for <linux-block@archiver.kernel.org>; Fri, 11 Feb 2022 21:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345121AbiBKVle (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Feb 2022 16:41:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353761AbiBKVld (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 16:41:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C721C6A
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 13:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644615689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=tpMNyPQ6L7rwPA4GSYE86kruce/OO/n8Rw3lkBYRqxc=;
        b=R/qe0UTSadAPV/fZgcbYVa63+lxlJXUWa9tgjGXpTs0auSAwG067Thn0f1nDIDiITMooFN
        aUIs3Hi9UwTgE6J5BRXSRAvXPYHCqc3Haryk9gFKnmE1TLjRcCpd5lWJcs9oYmHWQkipVx
        1VDCVSCYFq6MGndDrjT2Z5hKQ6ohl0w=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-t65F8qpvPFWJY16wSIMq5w-1; Fri, 11 Feb 2022 16:41:28 -0500
X-MC-Unique: t65F8qpvPFWJY16wSIMq5w-1
Received: by mail-ot1-f71.google.com with SMTP id e110-20020a9d01f7000000b0059ecb99d288so6032775ote.12
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 13:41:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tpMNyPQ6L7rwPA4GSYE86kruce/OO/n8Rw3lkBYRqxc=;
        b=xwqTH2Sw8mbMo6zqGoaACHwa+NXU960cTK4JoPO247iPY/lG4jTT8ZGu4lSu5GVoso
         lwVDz99kehvYh6+vQiC4KvaYmQzBUKFLKhCMPbq8BunNiolRUqI0DPPshbiXa09eeEEW
         ep0ddN0L4yQCdGnxGInsw2pZcwsJnPj2aZSNFgTXX7zl4+u3CbArD32Ux2RNAMUpoetP
         EbiJq9ZGIl3xkjZwmGCZF6l5+APcw/OuIVe+L10dLsKbxKQD/fK8Pa/5m0BFeuXqeUez
         BttpHaUKqTAshC8RDUQvsspZX5EukOHeEO1rxEKalnA+zhMydx+uqasFO5lZc7onzK6k
         AIjA==
X-Gm-Message-State: AOAM530vz+knHkp+gZSJPk7WVOU1u+ovWwB9y15mDclEGWy8g0cjftRf
        s5BDxVWwqkNk6gy35ahJ0sNgEb76qx1JLn/c1RQDaHnKZP4GMrZB5XhRdDiUf9PYP4kfLGqay3+
        NAHQw+tNOUTkBiEAJqeFaqg==
X-Received: by 2002:a9d:d4c:: with SMTP id 70mr1309172oti.45.1644615687245;
        Fri, 11 Feb 2022 13:41:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzf5gLazt1jBAQ7XMES2H7/5Hj/cMuqHfTH9oJBaRY1iZVevTkFbiJNV2fzrRS7uVQpcASPzQ==
X-Received: by 2002:a9d:d4c:: with SMTP id 70mr1309164oti.45.1644615686831;
        Fri, 11 Feb 2022 13:41:26 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id p11sm10506598oiv.17.2022.02.11.13.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 13:41:26 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v2 13/14] dm delay: use dm_submit_bio_remap
Date:   Fri, 11 Feb 2022 16:40:56 -0500
Message-Id: <20220211214057.40612-14-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220211214057.40612-1-snitzer@redhat.com>
References: <20220211214057.40612-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm-delay.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-delay.c b/drivers/md/dm-delay.c
index 59e51d285b0e..9a51bf51a859 100644
--- a/drivers/md/dm-delay.c
+++ b/drivers/md/dm-delay.c
@@ -72,7 +72,7 @@ static void flush_bios(struct bio *bio)
 	while (bio) {
 		n = bio->bi_next;
 		bio->bi_next = NULL;
-		submit_bio_noacct(bio);
+		dm_submit_bio_remap(bio, NULL);
 		bio = n;
 	}
 }
@@ -232,6 +232,7 @@ static int delay_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 
 	ti->num_flush_bios = 1;
 	ti->num_discard_bios = 1;
+	ti->accounts_remapped_io = true;
 	ti->per_io_data_size = sizeof(struct dm_delay_info);
 	return 0;
 
@@ -355,7 +356,7 @@ static int delay_iterate_devices(struct dm_target *ti,
 
 static struct target_type delay_target = {
 	.name	     = "delay",
-	.version     = {1, 2, 1},
+	.version     = {1, 3, 0},
 	.features    = DM_TARGET_PASSES_INTEGRITY,
 	.module      = THIS_MODULE,
 	.ctr	     = delay_ctr,
-- 
2.15.0

