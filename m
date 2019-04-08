Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADB5C282DE
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 06:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F7720883
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 06:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FEWHy2gC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbfDHGax (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 02:30:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40738 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfDHGax (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 02:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Y7HX0fcSNlyfeg+lICWpdQMd1qEpkYtgrg2o7rXdC9Q=; b=FEWHy2gCHhkssXEGWv3kPEiyB
        T4rMl4mcGvbP3o1ENlkupjDp8l8of8xF5SPV3QvV4ibM1fNlcCCb5UqwGt8a2oyNhjek08FlnYq8N
        qSsUSN+rV508rinozjWAtiQOJAWmNjlaT98x6o6llS9SMrUpYkYPQLeYE6JjiXkCGgUfqV9iiYr/l
        VBCoEWlLJ3zn90MJKkLaJmyLeZb0lpdCYeDel1s4Yy/Dxg3GTk1g/MwPCHm3gxO+SkhNySFWs5rYz
        YMTSRN5xRXZa+0Z2dRDXhUgDqaZBR46poWuZjNqWADFkFDhF+tiC+F0vDQ8J3eCr11NW7qoZ7thix
        dYx4UiNtA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDNnw-0007ey-Lg; Mon, 08 Apr 2019 06:30:52 +0000
Date:   Sun, 7 Apr 2019 23:30:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alex Lyakas <alex@zadara.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: preserve BIO_REFFED flag in bio_reset()
Message-ID: <20190408063052.GA9257@infradead.org>
References: <1554555800-14392-1-git-send-email-alex@zadara.com>
 <ae3ac0dc-92ef-36f9-ff0d-ef41e6deacb1@kernel.dk>
 <20190407075651.GA23397@infradead.org>
 <CAOcd+r3djpt1=ewD+QA0KsJ5woFb2G6T_9TAUCha=MtR8TyDww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOcd+r3djpt1=ewD+QA0KsJ5woFb2G6T_9TAUCha=MtR8TyDww@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Apr 07, 2019 at 05:35:45PM +0300, Alex Lyakas wrote:
> Hi Christoph,
> 
> I understand and agree with your concern.
> 
> Looking at the code, bi_flags is 16-bits wide, and only top 3 bits are
> preserved by bio_reset(). These bits are used to indicate a bvec pool.
> So we don't have any free bits to move the BIO_REFFED to. Unless we
> make bi_flags wider.

I think we just need to move BIO_REFFED around.  Something like the
untested patch below should do the job, although blk_types.h could
use some additional cleanup in this area..

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index be418275763c..017a450dc8e0 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -224,13 +224,13 @@ enum {
 	BIO_NULL_MAPPED,	/* contains invalid user pages */
 	BIO_QUIET,		/* Make BIO Quiet */
 	BIO_CHAIN,		/* chained bio, ->bi_remaining in effect */
-	BIO_REFFED,		/* bio has elevated ->bi_cnt */
 	BIO_THROTTLED,		/* This bio has already been subjected to
 				 * throttling rules. Don't do it again. */
 	BIO_TRACE_COMPLETION,	/* bio_endio() should trace the final completion
 				 * of this bio. */
 	BIO_QUEUE_ENTERED,	/* can use blk_queue_enter_live() */
 	BIO_TRACKED,		/* set if bio goes through the rq_qos path */
+	BIO_REFFED,		/* bio has elevated ->bi_cnt */
 	BIO_FLAG_LAST
 };
 
@@ -257,9 +257,9 @@ enum {
 
 /*
  * Flags starting here get preserved by bio_reset() - this includes
- * only BVEC_POOL_IDX()
+ * BVEC_POOL_IDX()
  */
-#define BIO_RESET_BITS	BVEC_POOL_OFFSET
+#define BIO_RESET_BITS BIO_REFFED
 
 typedef __u32 __bitwise blk_mq_req_flags_t;
 
