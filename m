Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEABC433EF
	for <linux-block@archiver.kernel.org>; Fri, 11 Feb 2022 21:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353776AbiBKVlR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Feb 2022 16:41:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345121AbiBKVlP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 16:41:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08033C65
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 13:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644615673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=mv03BNY+xdulNavhI7whyVhl6SEZfhNGRgDBWAdqIBo=;
        b=AkEdjAMjdtn1NyNqtfI56fUR0ZbC9XPQzXWLSMBvYoHpi2XCxRWkgkxVK7DT1yCLMBtnz9
        64khVPOk5o/2NLdEpICQHyXtWs0AN+6mUtkaJtct0w+FHpKdcLLsO77K78LrOhBHgMae27
        thOBRiRH5baK/lPQbIryG5+2mpiv9nI=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-601-HRDWcqn6OX2wvvykJU2SJw-1; Fri, 11 Feb 2022 16:41:11 -0500
X-MC-Unique: HRDWcqn6OX2wvvykJU2SJw-1
Received: by mail-ot1-f72.google.com with SMTP id l1-20020a9d7341000000b0059c2046f9edso6072696otk.3
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 13:41:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mv03BNY+xdulNavhI7whyVhl6SEZfhNGRgDBWAdqIBo=;
        b=u7qvPY7g2C+7O6HkeUBIkWsi+TbpTDd4vHVo/P1Ze0Br5tGhgNMxRZyCnbJxneshEU
         mhaT9IbMywZdDTCgpvH/CywFc0ZinMa52yHnUxjz6p7xd/6UQpsVMqg8DXb62YX4EBN2
         V72/6x/6rlEnzkDar2s8r0t1RHhgTt2xvJIIqpoMKmsbZRax6LGHbk+aIfMJwY25sAM5
         gWUusnFmFGRzRrYj5DqAmVpCSaznZvzKx/FVOWUjRO99XOYnO8PyHOsRpkZUy7xUI7ah
         UX0fDBI1haQ90cyfU4Ak4kllvyjo8LOXncb1+BKeI7y5t8mb+Zx5RtFrpTA7VJZ4AQpg
         x49A==
X-Gm-Message-State: AOAM530h1971GMCXpJPBcI3KPqr0M98wXa9Js3mSbGmyXdncbeTBdVAB
        Cts3P07wC8iuINJ0njPCtDbDM6K1vuRAk7jK5A2udIQdfzjkS3qPngSm1H6AYxulckDnJexnb8m
        9OTRMl8K6WAEvtg48yovfWQ==
X-Received: by 2002:a05:6830:448e:: with SMTP id r14mr1299843otv.102.1644615671076;
        Fri, 11 Feb 2022 13:41:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx6SaEVfuBnc3P3ZkrUt/Pa1m5PKMHPu72Tk0s5Ge6mbotnvK/0AprRlTrDn7upIV5AdGhz6w==
X-Received: by 2002:a05:6830:448e:: with SMTP id r14mr1299835otv.102.1644615670766;
        Fri, 11 Feb 2022 13:41:10 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id 21sm9610956otj.71.2022.02.11.13.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 13:41:10 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v2 04/14] dm: reduce code duplication in __map_bio
Date:   Fri, 11 Feb 2022 16:40:47 -0500
Message-Id: <20220211214057.40612-5-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220211214057.40612-1-snitzer@redhat.com>
References: <20220211214057.40612-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Error path code (for handling DM_MAPIO_REQUEUE and DM_MAPIO_KILL) is
effectively identical.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 60a047de620f..8f2288a3b35b 100644
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

