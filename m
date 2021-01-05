Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60877C433E0
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 12:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18ACD22AB0
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 12:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbhAEMoR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Jan 2021 07:44:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51558 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728012AbhAEMoQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Jan 2021 07:44:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609850570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0mG4DoP55cPdzDLn2Bb+re9iGyhEWkaOEkZHmg15FDw=;
        b=WasmoDb0Sqf94O5rD1fP9Rb/JLyalUR7GQSpJ3QhbwO50N4qt3U+U5FSa1oevNfAl0LBLB
        ZGxhVibCGMH0rj4+I1Q/z4Zq75GbGPq80U8/+l5FIgEho5NniWNrtAt/UutZ0gHX5Aljwy
        UpJAMbTGiIi/qdgtMaCFrDDGszzg9S4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-T7WG-ikLMOOfAzp6c_XPTA-1; Tue, 05 Jan 2021 07:42:48 -0500
X-MC-Unique: T7WG-ikLMOOfAzp6c_XPTA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58D2E107ACFB;
        Tue,  5 Jan 2021 12:42:47 +0000 (UTC)
Received: from localhost (ovpn-12-37.pek2.redhat.com [10.72.12.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C85E19C46;
        Tue,  5 Jan 2021 12:42:42 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 4/6] block: set .bi_max_vecs as actual allocated vector number
Date:   Tue,  5 Jan 2021 20:42:01 +0800
Message-Id: <20210105124203.3726599-5-ming.lei@redhat.com>
In-Reply-To: <20210105124203.3726599-1-ming.lei@redhat.com>
References: <20210105124203.3726599-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bvec_alloc() may allocate more bio vectors than requested, so set
.bi_max_vecs as actual allocated vector number, instead of the requested
number. This way can help fs build bigger bio because new bio often won't
be allocated until the current one becomes full.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index cd3c58ee2458..9857893d550f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -505,12 +505,13 @@ struct bio *bio_alloc_bioset(gfp_t gfp_mask, unsigned int nr_iovecs,
 			goto err_free;
 
 		bio->bi_flags |= idx << BVEC_POOL_OFFSET;
+		bio->bi_max_vecs = bvec_nr_vecs(idx);
 	} else if (nr_iovecs) {
 		bvl = bio->bi_inline_vecs;
+		bio->bi_max_vecs = inline_vecs;
 	}
 
 	bio->bi_pool = bs;
-	bio->bi_max_vecs = nr_iovecs;
 	bio->bi_io_vec = bvl;
 	return bio;
 
-- 
2.28.0

