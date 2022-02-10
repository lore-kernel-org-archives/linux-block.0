Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436A6C433FE
	for <linux-block@archiver.kernel.org>; Thu, 10 Feb 2022 22:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345030AbiBJWix (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Feb 2022 17:38:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345032AbiBJWiw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Feb 2022 17:38:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62BEC2664
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 14:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644532732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=CRfDTYNpxGAOLZDzgeFhYGqT+avXL5fj+x7+6gQLvzM=;
        b=VPy9sfQBKJGIAaT7m/Mhn1n6s4m93/9ka6AIkjgYHRcbI8bxketT05uhGJm0yjI2+hyFMG
        Pw1l2B8Za5WC2rSq2469sJjgnm/OsrD+BZ9gRoKBFDHqFwqx384GeJRI8EgfXknAWb8oBt
        UPf7RqIxQ6hAxLVNffDtR7Dv+l1scgM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-PYCwf096NJ6ySnd8exE2qw-1; Thu, 10 Feb 2022 17:38:51 -0500
X-MC-Unique: PYCwf096NJ6ySnd8exE2qw-1
Received: by mail-qv1-f71.google.com with SMTP id ge15-20020a05621427cf00b00421df9f8f23so4991218qvb.17
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 14:38:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CRfDTYNpxGAOLZDzgeFhYGqT+avXL5fj+x7+6gQLvzM=;
        b=bswW8RoeP+H7YzEePxXtGNDiCt0uEuYerwnUD+t04uTdeTZqrpwCpouvXlpg8Q1qIa
         9rN4m7vD9JlqjXipGH2ait4MeTyYO1rIuhZ7j8/YunXS0nytSOd/bPebiuHtpZu6qf9w
         jNmKrBMdnhz4K77yL6H7ocO4iCnUxlXgdJBKRKBlQA4YO2w+Np1EFEnv/cL/aImL6Kpk
         T6vJvP2fZE0GXjspqxwnoOAoaw0eOV4dzj8m3lpHk9dEPxHMDzme0hAikTsFq6F+0VCn
         jIBES5BrCLahgVlpbNx/wPptIWpOf8LnHdE5v63GRAW+K9DVK2JfCCKcE5Bl2A1GA2C1
         fn4Q==
X-Gm-Message-State: AOAM5336GepJGYxpTQWgzpl+9y289PrCU9io17MAe8SUusl2VsdwXMaI
        pHlkOzsFfri95kcD3cXwk9+mEmLz+4H8JUQ99Vdjew7otIIa5ZBFrq03cM5nkX8l3hYyOLFZ54S
        dXZi2muYw2iIHMnjc7JaVOg==
X-Received: by 2002:a37:a607:: with SMTP id p7mr5034685qke.763.1644532730799;
        Thu, 10 Feb 2022 14:38:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyxEVIGFiZwGx+fh0BLy5zq1Vh8eVtyQH52OipWCoMyOw9uzoENBF0MFCF33ybEO88rYgtWaw==
X-Received: by 2002:a37:a607:: with SMTP id p7mr5034680qke.763.1644532730613;
        Thu, 10 Feb 2022 14:38:50 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id bj24sm10469903qkb.115.2022.02.10.14.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 14:38:50 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 12/14] dm delay: dm_submit_bio_remap
Date:   Thu, 10 Feb 2022 17:38:30 -0500
Message-Id: <20220210223832.99412-13-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220210223832.99412-1-snitzer@redhat.com>
References: <20220210223832.99412-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm-delay.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-delay.c b/drivers/md/dm-delay.c
index 59e51d285b0e..8235927a3912 100644
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
 
-- 
2.15.0

