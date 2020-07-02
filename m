Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41863C433DF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 06:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06E2D20874
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 06:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSE3x8Uj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbgGBGU7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 02:20:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33206 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725263AbgGBGU7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Jul 2020 02:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593670858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Zgjx2s9gHe5mI93ICC99MayNgJA8yJl+NPVwMMEctI=;
        b=YSE3x8Uj7q3+0agrYIv+q0wbCPU146TpTn1tu6HtOfntlAlvAyAJbbmKyOgHMjNtm+D3Kq
        iVIOYd2GPfi0eDksMMOOaNbGDT6J03n+AuFNF12Emq5UlIkfVBvH0sVbQUbHwbpkHra4+B
        A40o+eDvyOIV9Kizp4aTaoNGZKWMybE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-aWgCUtrvOoeBHrbpx2drTg-1; Thu, 02 Jul 2020 02:20:54 -0400
X-MC-Unique: aWgCUtrvOoeBHrbpx2drTg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44ACDBFC6;
        Thu,  2 Jul 2020 06:20:52 +0000 (UTC)
Received: from T590 (ovpn-12-180.pek2.redhat.com [10.72.12.180])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 825CF5D9CA;
        Thu,  2 Jul 2020 06:20:45 +0000 (UTC)
Date:   Thu, 2 Jul 2020 14:20:41 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, m.szyprowski@samsung.com
Subject: Re: [PATCH V3 3/3] blk-mq: centralise related handling into
 blk_mq_get_driver_tag
Message-ID: <20200702062041.GC2452799@T590>
References: <20200630140357.2251174-1-ming.lei@redhat.com>
 <20200630140357.2251174-4-ming.lei@redhat.com>
 <20200702043721.GA1087@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702043721.GA1087@lca.pw>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 02, 2020 at 12:37:21AM -0400, Qian Cai wrote:
> On Tue, Jun 30, 2020 at 10:03:57PM +0800, Ming Lei wrote:
> > Move .nr_active update and request assignment into blk_mq_get_driver_tag(),
> > all are good to do during getting driver tag.
> > 
> > Meantime blk-flush related code is simplified and flush request needn't
> > to update the request table manually any more.
> > 
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> Reverting this commit on the top of next-20200701 fixed an issue where
> swapping is unable to move progress for hours while it will only take
> 5-min after the reverting.

Hi Qian,

Could you apply the following patch and see if it makes a difference?

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 65e0846fd065..e89ce9ae51fd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1147,7 +1147,8 @@ static bool blk_mq_get_driver_tag(struct request *rq)
 	if (rq->tag == BLK_MQ_NO_TAG && !__blk_mq_get_driver_tag(rq))
 		return false;
 
-	if (hctx->flags & BLK_MQ_F_TAG_SHARED) {
+	if ((hctx->flags & BLK_MQ_F_TAG_SHARED) &&
+			!(rq->rq_flags & RQF_MQ_INFLIGHT)) {
 		rq->rq_flags |= RQF_MQ_INFLIGHT;
 		atomic_inc(&hctx->nr_active);
 	}


Thanks,
Ming

