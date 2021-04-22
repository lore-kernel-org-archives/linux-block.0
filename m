Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56A9C43460
	for <linux-block@archiver.kernel.org>; Thu, 22 Apr 2021 12:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 805C561139
	for <linux-block@archiver.kernel.org>; Thu, 22 Apr 2021 12:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbhDVMWX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Apr 2021 08:22:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27366 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235232AbhDVMWX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Apr 2021 08:22:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619094108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dwoc9AW0KjZkTnxxRFP/Ifmc39exnvB2ctQKqZJnJTM=;
        b=d6J5aE/kLvxxYEPRTp3qtHLJ5gz17K2rZ/N2TLxtJrkoGCuxDdgfRO/ldgUp+/R+VQ87Eo
        fGvTnYekkHWkYh3W7jU1pad8ddkpM+fJ2MA9UBBbkdga+wlXigBSTS2CPOdwntOwqBPY3o
        XcFz51Op59bZTYhU44D7CaAT2UgTaP8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-Te6RkGroOU2buA6gvDsvig-1; Thu, 22 Apr 2021 08:21:16 -0400
X-MC-Unique: Te6RkGroOU2buA6gvDsvig-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 830F98030CF;
        Thu, 22 Apr 2021 12:21:10 +0000 (UTC)
Received: from localhost (ovpn-13-243.pek2.redhat.com [10.72.13.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CDE67100760B;
        Thu, 22 Apr 2021 12:21:09 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V6 02/12] block: define 'struct bvec_iter' as packed
Date:   Thu, 22 Apr 2021 20:20:28 +0800
Message-Id: <20210422122038.2192933-3-ming.lei@redhat.com>
In-Reply-To: <20210422122038.2192933-1-ming.lei@redhat.com>
References: <20210422122038.2192933-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

'struct bvec_iter' is embedded into 'struct bio', define it as packed
so that we can get one extra 4bytes for other uses without expanding
bio.

'struct bvec_iter' is often allocated on stack, so making it packed
doesn't affect performance. Also I have run io_uring on both
nvme/null_blk, and not observe performance effect in this way.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/bvec.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index ff832e698efb..a0c4f41dfc83 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -43,7 +43,7 @@ struct bvec_iter {
 
 	unsigned int            bi_bvec_done;	/* number of bytes completed in
 						   current bvec */
-};
+} __packed;
 
 struct bvec_iter_all {
 	struct bio_vec	bv;
-- 
2.29.2

