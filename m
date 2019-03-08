Return-Path: <SRS0=/NKK=RL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169BFC43381
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 08:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54432087C
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 08:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfCHISY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 03:18:24 -0500
Received: from verein.lst.de ([213.95.11.211]:52357 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfCHISY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Mar 2019 03:18:24 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B556668D0D; Fri,  8 Mar 2019 09:18:19 +0100 (CET)
Date:   Fri, 8 Mar 2019 09:18:19 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, Ming Lei <tom.leiming@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "open list:AIO" <linux-aio@kvack.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-api@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Moyer <jmoyer@redhat.com>, Avi Kivity <avi@scylladb.com>,
        jannh@google.com, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 11/19] block: implement bio helper to add iter bvec
 pages to bio
Message-ID: <20190308081819.GA12948@lst.de>
References: <20190211190049.7888-13-axboe@kernel.dk> <20190220225856.GB28313@ming.t460p> <b143e8c3-33d5-5f09-c441-98b3bf326d81@kernel.dk> <20190226034613.GA676@sol.localdomain> <aa1184bb-b482-0637-21e4-1ddb0e7aea90@kernel.dk> <1652577e-787b-638e-625d-c200fb144a9d@kernel.dk> <CACVXFVNOFA8_p+hVvaCffWAQ7+dgn++0b4Wn3naJzyNZN=CoFg@mail.gmail.com> <09820845-07cb-5153-e1c5-59ed185db26f@kernel.dk> <20190227015336.GD16802@ming.t460p> <e4dace7b-6a6f-2606-9a7e-8ae3c97c26b0@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4dace7b-6a6f-2606-9a7e-8ae3c97c26b0@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 26, 2019 at 06:57:16PM -0700, Jens Axboe wrote:
> Speaking of this, I took a quick look at why we've now regressed a lot
> on IOPS perf with the multipage work. It looks like it's all related to
> the (much) fatter setup around iteration, which is related to this very
> topic too.

> Basically setup of things like bio_for_each_bvec() and indexing through
> nth_page() is MUCH slower than before.

I haven't quite figure out what the point of nth_page is.  If we
physically merge the page structures should also be consecuite
in memory in general.  The only case where this could theoretically
not be the case is with CONFIG_DISCONTIGMEM, but in that case we should
check this once in biovec_phys_mergeable, and only for that case.

Does this patch make a difference for you on x86?

--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -53,7 +53,7 @@ struct bvec_iter_all {
 
 static inline struct page *bvec_nth_page(struct page *page, int idx)
 {
-	return idx == 0 ? page : nth_page(page, idx);
+	return page + idx;
 }
 
 /*
