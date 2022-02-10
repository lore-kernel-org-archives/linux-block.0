Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE89EC433EF
	for <linux-block@archiver.kernel.org>; Thu, 10 Feb 2022 22:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345024AbiBJWin (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Feb 2022 17:38:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345014AbiBJWim (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Feb 2022 17:38:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2FFA267F
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 14:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644532721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=N1ZtWuQD/2MiqgkrjoL8yazkFH5KXeFDL5OjLo4UsiQ=;
        b=FrP/i5qqnH1DFSHSYlOSOsbfjdi2GhPsN7Cxw/bE7fNaLeP/KpI3LBBpEAYGz/re9yOr1U
        b+5SmRWL/bpHzn7niyCnc0rscvjbRDOIhoaHsfcaL/yh3jExkDY8zaM1qushN4ljxAACDv
        two9SkOWVag/pMBZr3DgsigvkF7AvAA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-vl5mJ_c2OFOBoeAlKIvQSw-1; Thu, 10 Feb 2022 17:38:40 -0500
X-MC-Unique: vl5mJ_c2OFOBoeAlKIvQSw-1
Received: by mail-qv1-f70.google.com with SMTP id du13-20020a05621409ad00b0042c2949e2c1so4990773qvb.19
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 14:38:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N1ZtWuQD/2MiqgkrjoL8yazkFH5KXeFDL5OjLo4UsiQ=;
        b=tDR/402hd/4MIfdMbVh5qsKrcvNvfRSrpwV88M1QgRk/Ja8PFbY6P8boG+HbtVUedI
         Sroo+PSVGMl27ITg623fFOY/uB/nyxlwLlCa++IsPJ+wk/QHj/DRsR5eQ8cthqlHH0pS
         JVhuRxSWWj+Py/Ii+vOfxXLKFh4HM43tPqmXcDWP8HeJuhBdMVkR0CV4e7+2STNNaFwA
         axQk5Ps3A1hb0J6mMf1Eujhx3UqM/zutcA761EP3iGCw2Bkf0UPJTgux2/DfIhi429ks
         QzKFD8FYywokvdogK9dAraAE2UZ5ZEKFgifVFokCtKgSIUaOi0olw7jNAj41Pj73SsSB
         rUuQ==
X-Gm-Message-State: AOAM5319VkcAnG64z2NIrDVNzR492NiVbbHEMZvob4k95eHaXXkzm5Yo
        jDKbX2AQO+JcD26RN+SlbtpmF61DlkDnHmgFxGKspUbGd6ilHkNhtMb52geS2NWRQa3IW4t99EV
        jGxIZnJewGSu6aEOm2J9QHQ==
X-Received: by 2002:ac8:7771:: with SMTP id h17mr6568557qtu.454.1644532719569;
        Thu, 10 Feb 2022 14:38:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxVQD4DjXjI2TI6RHlCNfSHCzJOeMiWv0AytqCY43O5jsmCNUHGzFo0EsTCPdXZui5wk8R+dw==
X-Received: by 2002:ac8:7771:: with SMTP id h17mr6568552qtu.454.1644532719407;
        Thu, 10 Feb 2022 14:38:39 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id h11sm2556932qkp.89.2022.02.10.14.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 14:38:39 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 04/14] dm: reduce code duplication in __map_bio
Date:   Thu, 10 Feb 2022 17:38:22 -0500
Message-Id: <20220210223832.99412-5-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220210223832.99412-1-snitzer@redhat.com>
References: <20220210223832.99412-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Error path code (for handling DM_MAPIO_REQUEUE and DM_MAPIO_KILL) is
effectively identical.

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 56734aae718d..cc014e56252e 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1161,20 +1161,14 @@ static void __map_bio(struct bio *clone)
 		submit_bio_noacct(clone);
 		break;
 	case DM_MAPIO_KILL:
-		if (unlikely(swap_bios_limit(ti, clone))) {
-			struct mapped_device *md = io->md;
-			up(&md->swap_bios_semaphore);
-		}
-		free_tio(clone);
-		dm_io_dec_pending(io, BLK_STS_IOERR);
-		break;
 	case DM_MAPIO_REQUEUE:
-		if (unlikely(swap_bios_limit(ti, clone))) {
-			struct mapped_device *md = io->md;
-			up(&md->swap_bios_semaphore);
-		}
+		if (unlikely(swap_bios_limit(ti, clone)))
+			up(&io->md->swap_bios_semaphore);
 		free_tio(clone);
-		dm_io_dec_pending(io, BLK_STS_DM_REQUEUE);
+		if (r == DM_MAPIO_KILL)
+			dm_io_dec_pending(io, BLK_STS_IOERR);
+		else
+			dm_io_dec_pending(io, BLK_STS_DM_REQUEUE);
 		break;
 	default:
 		DMWARN("unimplemented target map return value: %d", r);
-- 
2.15.0

