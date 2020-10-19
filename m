Return-Path: <SRS0=eZc3=D2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CCEC433DF
	for <linux-block@archiver.kernel.org>; Mon, 19 Oct 2020 19:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F97F2240B
	for <linux-block@archiver.kernel.org>; Mon, 19 Oct 2020 19:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XLnTGFYe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgJSTu2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Oct 2020 15:50:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22070 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728100AbgJSTu1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Oct 2020 15:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603137026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=gurUpVJY92BNatRtGPJGA4twsuCjo97EHFL7kW3iTCQ=;
        b=XLnTGFYerF/s/BWk8RQaN5NFGSPyz+4u9C42+qylp2Fd0ZDvSecOn6J+WAONYWf8Az6dcQ
        lo/F31Qc84MceTqC8qsCQMMUJ4ZWI6D5LDqMkmALTEFOFbv8kx69Ja8cxiH05G7s7bw8gf
        XcINTp0MxzByaC8JRpEcNmN9ssII/bE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-pGMxe2YaPDe8FinQUVsUfQ-1; Mon, 19 Oct 2020 15:50:24 -0400
X-MC-Unique: pGMxe2YaPDe8FinQUVsUfQ-1
Received: by mail-qk1-f200.google.com with SMTP id x5so541195qkn.2
        for <linux-block@vger.kernel.org>; Mon, 19 Oct 2020 12:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gurUpVJY92BNatRtGPJGA4twsuCjo97EHFL7kW3iTCQ=;
        b=SxFL0YtC9FZ4UO1Ld66Vuxmq6mNtzUpFhCkC39uBZ4D4vguJlp5sALYBpEiVAF8rvY
         Xvz0svt/3J2w/tYFwYSg2N0q8PPDzvDCsgGQJSu5MCdtumzQWcu4MFbaCoNIT/C/GRba
         FBV19FwVgo2GYEAxZtMZ81Ro0k7knQ+kb6F2GxNKw5g2EQZ1YYrM4rHpKA1NLSkulmx7
         rmfU3g0RU+Il/laNdr68F6uGvcB5HauSQzC0V0Dk8hp/HC9RYhc45GQPv5ueAMR8ouVp
         licjjLckQYp6IPG/JjGtQz9HhBNEL7c5ndSf7y97fhL1Zpl2q8k/ccCfNgwi5RXYa3fL
         ULRw==
X-Gm-Message-State: AOAM532dwAyvzBNS9Dz62I98RAKhs12d62q6Nd8POkEAogcqs64ByBja
        eQrakR3zT0x3JCop6gsRfqvV1ZbZMrp8pv9EKNCGdUJogHtADKhCuH22lqwvCKT/5/KlqM3jLiH
        jyqTWL1GG9bepHRRB6lODHlQ=
X-Received: by 2002:ac8:705b:: with SMTP id y27mr1114113qtm.192.1603137023763;
        Mon, 19 Oct 2020 12:50:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvDlls0C3FPTa4CLaTFO3RK5ocpNR7SlP5iafd30354sGejOe41Jo8FGhAcBQn8KNGmwvqIQ==
X-Received: by 2002:ac8:705b:: with SMTP id y27mr1114095qtm.192.1603137023534;
        Mon, 19 Oct 2020 12:50:23 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l25sm401073qtf.18.2020.10.19.12.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:50:22 -0700 (PDT)
From:   trix@redhat.com
To:     konrad.wilk@oracle.com, axboe@kernel.dk
Cc:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] block: xen-blkback: remove unneeded break
Date:   Mon, 19 Oct 2020 12:50:16 -0700
Message-Id: <20201019195016.15337-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a goto

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/block/xen-blkback/blkback.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index adfc9352351d..f769fbd1b4c4 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -1269,7 +1269,6 @@ static int dispatch_rw_block_io(struct xen_blkif_ring *ring,
 	default:
 		operation = 0; /* make gcc happy */
 		goto fail_response;
-		break;
 	}
 
 	/* Check that the number of segments is sane. */
-- 
2.18.1

