Return-Path: <SRS0=9mBv=RD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D217EC43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 13:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B642171F
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 13:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VWfYDKmq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbfB1N6e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:58:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47668 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730687AbfB1N6d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Feb 2019 08:58:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kk3zcRYw4DrxXhrr9NyswOiJSMUBwZEJ7TYl+ie73MQ=; b=VWfYDKmqbaoT5F2kj+f3Cmzx2
        7btjeJfMPX8Z0ZhkmsQ9qcxaFlv6SszbDl4UbtZTbP/ybNoL7Tl/fozsIrqhHNHwzbtRMOMvlWH8B
        jJQAAC7K+GfX3p3zKy6uNOdk7dEB10mVp4mUTPeO+B7hJSrgGSKDgDd1Mep0V/eiOIXeIJYvwj4/n
        Sxd6qBwCsAysDbb3GJwWP/ZF8C3n3FkSbmrc10UkqRwesxjSDMqFZU3TPOC/Z6Md+tTGuN9jmhOyI
        5jNvaIAc32TkEVWLp7CVWvpdg4hP8iXgDGmH2QSp2rFGJos0x40PMrqNC5FGTmZXRFBRKBR0CzkUP
        8G7qmXxKw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gzMCm-00063P-4o; Thu, 28 Feb 2019 13:58:32 +0000
Date:   Thu, 28 Feb 2019 05:58:32 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: advance by bvec's length for bio_for_each_bvec
Message-ID: <20190228135832.GA3182@infradead.org>
References: <20190228032421.23161-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228032421.23161-1-ming.lei@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 28, 2019 at 11:24:21AM +0800, Ming Lei wrote:
> bio_for_each_bvec is used in fast path of bio splitting and sg mapping,
> and what we want to do is to iterate over multi-page bvecs, instead of pages.
> However, bvec_iter_advance() is invisble for this requirement, and
> always advance by page size.
> 
> This way isn't efficient for multipage bvec iterator, also bvec_iter_len()
> isn't as fast as mp_bvec_iter_len().
> 
> So advance by multi-page bvec's length instead of page size for bio_for_each_bvec().
> 
> More than 1% IOPS improvement can be observed in io_uring test on null_blk.

We've been there before, and I still insist that there is not good
reason ever to clamp the iteration to page size in bvec_iter_advance.
Callers that iterate over it already do that in the callers.

So here is a resurretion and rebase of my patch from back then to
just do the right thing:

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 2c32e3e151a0..cf06c0647c4f 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -112,14 +112,15 @@ static inline bool bvec_iter_advance(const struct bio_vec *bv,
 	}
 
 	while (bytes) {
-		unsigned iter_len = bvec_iter_len(bv, *iter);
-		unsigned len = min(bytes, iter_len);
+		const struct bio_vec *cur = bv + iter->bi_idx;
+		unsigned len = min3(bytes, iter->bi_size,
+				    cur->bv_len - iter->bi_bvec_done);
 
 		bytes -= len;
 		iter->bi_size -= len;
 		iter->bi_bvec_done += len;
 
-		if (iter->bi_bvec_done == __bvec_iter_bvec(bv, *iter)->bv_len) {
+		if (iter->bi_bvec_done == cur->bv_len) {
 			iter->bi_bvec_done = 0;
 			iter->bi_idx++;
 		}
