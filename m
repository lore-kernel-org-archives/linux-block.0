Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B0DC433FE
	for <linux-block@archiver.kernel.org>; Fri, 11 Feb 2022 21:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243561AbiBKVlT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Feb 2022 16:41:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353774AbiBKVlR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 16:41:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2CC9C6E
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 13:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644615675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=8TzXai5XoIS8MdPbsH2K1r9uRN0R+imGzFYy55uIM5k=;
        b=h68FHaQDMqRWHOUxLaO/QYnUvOUuoxUDg6ODlYKXxFRKa2iR2VHy3YW7hrsQg8HwpBK9iL
        fYlPcnDMI+ukOhSYZXBuJg/++7exwNdbo9NgbEh6j3RssLe8Qs+6EjAbjZn8g57cfe4KL5
        8WgGfmt/u1WU1hprtjD0ZPNh+eGYzZ8=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-345-Ggw2CMuyMLuP9aXNnodEYg-1; Fri, 11 Feb 2022 16:41:14 -0500
X-MC-Unique: Ggw2CMuyMLuP9aXNnodEYg-1
Received: by mail-oo1-f71.google.com with SMTP id t16-20020a4ae9b0000000b0031877e91c80so2775737ood.13
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 13:41:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8TzXai5XoIS8MdPbsH2K1r9uRN0R+imGzFYy55uIM5k=;
        b=d5x1krwzfiBDLG1iFJ9GoIPqN8yTwFx/I1NSMVrvj5gaW6gElH4OcZlMMeDIC6+oSN
         ivYVl9HVklPRZLzQ7fjszEFbhIErgSBv0blEv2sT9oshsDOhyrvheRR8cIMgHycVhbUm
         h5AieDPMZ9YMaMvcjKxfts6ZuPuwzFlHMs08DxoZMCyKWXxoOCFRNWsfqggSW7/Z+bzL
         VpcFY+kJEuVOIU2+tlvALOs3AOed12Z7Akfp80BoPaw2IwY9sWBoM97TrFJBPhXVIwRG
         NsB+RlLfpZmEWoI8fVq8UyU4+Nea6gMwdNt67miDJ3bLLdZjb9l3mrE47QZzNUltvZJ6
         jDtQ==
X-Gm-Message-State: AOAM531gOobBz83U5i4nJPmToxAVGF2dIZi4k/HrNfm9pbr2htfwgrMk
        6cd6FKpwUt6AzJKpSclR/B8wJVnkMEpxR/b9/llyEURrK5hKoHF0fEuReHtnbLsoLbI2CJB0ADv
        rlTYEY8kh5PbMbNebUoC2og==
X-Received: by 2002:a05:6870:2b0b:: with SMTP id ld11mr762367oab.208.1644615672566;
        Fri, 11 Feb 2022 13:41:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxuvVk1tr6R6mjs2QBFnD7weYNLfWqReEpv/lo9zB9fvtwYyowwbNBaoeAkADickixXuBf1Aw==
X-Received: by 2002:a05:6870:2b0b:: with SMTP id ld11mr762363oab.208.1644615672407;
        Fri, 11 Feb 2022 13:41:12 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id 100sm9697215oth.75.2022.02.11.13.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 13:41:12 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v2 05/14] dm: remove impossible BUG_ON in __send_empty_flush
Date:   Fri, 11 Feb 2022 16:40:48 -0500
Message-Id: <20220211214057.40612-6-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220211214057.40612-1-snitzer@redhat.com>
References: <20220211214057.40612-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The flush_bio in question was just initialized to be empty, so there
is no way bio_has_data() will return true.  So remove stale BUG_ON().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 8f2288a3b35b..bd07ccadbf01 100644
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

