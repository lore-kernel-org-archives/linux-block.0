Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFE3C433F5
	for <linux-block@archiver.kernel.org>; Thu, 10 Feb 2022 22:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345014AbiBJWin (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Feb 2022 17:38:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345022AbiBJWim (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Feb 2022 17:38:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 700BD2664
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 14:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644532722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=zWCBM8YnYusetp0OPiRYym7xOF2Me0YViFrrQcnA0W4=;
        b=cigcee3WcCGboGunEVl1ZU3TPUyg/vFsNE80ECsrxzXRT0EFKQzCUegkM7PxzObeZOFeFw
        Bq/lCqt8YpGsSUEykKrCpRnPskAqmxYZ1kbHLmKGQG4EMf2VYoncGfSqKE/VsRZ6j8jQsA
        YunX+jHBQ1VPE9cqBg+WJ3MslvxCL8E=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-L4JXrh2OMrSa4We90k7Xuw-1; Thu, 10 Feb 2022 17:38:41 -0500
X-MC-Unique: L4JXrh2OMrSa4We90k7Xuw-1
Received: by mail-qk1-f199.google.com with SMTP id i26-20020a05620a075a00b0047ec29823c0so4579650qki.6
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 14:38:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zWCBM8YnYusetp0OPiRYym7xOF2Me0YViFrrQcnA0W4=;
        b=eXpOPcZ1szAW4UcUSvNC+8PafdF+TTchRaJ4l7/8Tf4ZAak89je8UV7wSrc1PPp/3T
         /b04jrOO1lYAsgY4zbZ0Z8GQgABC7g8TZGbracTQ6pa0ETfj+xcESo98+9ldYDeMGgk2
         Sg6Z6N28Sd+d5RQbGNYf2Xdqovw9Ms2sBHuiAE30gQnNZQ/nQsAoHaqVqbTPolZz0bnn
         nozzoc6nHcpDgWwnB9CIZ3GUVmo3/g0EFG11Q8uMxvwv5J7yWFeXC5G+TJaoH+8L77MG
         xgfMajRPR9z/77TAKMsO1wu0PnTNpcowQt3XU/ufGtd+hnIp24Kb6Fb+8LVoUYhSqKE6
         IIuw==
X-Gm-Message-State: AOAM533xj1uZiWGGRPXyCZIK5IahMns+vF7f8NXE8g/oqFHIfzU+2qv/
        VG9kOEEj9e//kChDUP2t3irVQxO9cRipYiwdn8NGYZp+hlDQ2+tAQFuI0M2tx+D8xCQccv7Y1od
        LENxhf2NLYJLLE/d6S5TZyw==
X-Received: by 2002:a05:620a:8cd:: with SMTP id z13mr4860474qkz.487.1644532721014;
        Thu, 10 Feb 2022 14:38:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRAUZfBBxSBcOHqSs0cu835y/n502phOPI93DcwbFy1t2ge6HipGrPT3511ZI+QNnRn+BDmg==
X-Received: by 2002:a05:620a:8cd:: with SMTP id z13mr4860468qkz.487.1644532720833;
        Thu, 10 Feb 2022 14:38:40 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id w3sm11965918qta.13.2022.02.10.14.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 14:38:40 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 05/14] dm: remove impossible BUG_ON in __send_empty_flush
Date:   Thu, 10 Feb 2022 17:38:23 -0500
Message-Id: <20220210223832.99412-6-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220210223832.99412-1-snitzer@redhat.com>
References: <20220210223832.99412-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The flush_bio in question was just initialized to be empty, so there
is no way bio_has_data() will retrun true.  So remove stale BUG_ON().

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index cc014e56252e..1985fc3f2a95 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1255,7 +1255,6 @@ static int __send_empty_flush(struct clone_info *ci)
 	ci->bio = &flush_bio;
 	ci->sector_count = 0;
 
-	BUG_ON(bio_has_data(ci->bio));
 	while ((ti = dm_table_get_target(ci->map, target_nr++)))
 		__send_duplicate_bios(ci, ti, ti->num_flush_bios, NULL);
 
-- 
2.15.0

