Return-Path: <SRS0=923v=WB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EFDC433FF
	for <linux-block@archiver.kernel.org>; Mon,  5 Aug 2019 22:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60FFC2147A
	for <linux-block@archiver.kernel.org>; Mon,  5 Aug 2019 22:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729921AbfHEWFt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Aug 2019 18:05:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:9872 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbfHEWFt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 5 Aug 2019 18:05:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 15:05:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="349235770"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga005.jf.intel.com with ESMTP; 05 Aug 2019 15:05:48 -0700
Date:   Mon, 5 Aug 2019 15:05:48 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     john.hubbard@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] fs/io_uring.c: convert put_page() to put_user_page*()
Message-ID: <20190805220547.GB23416@iweiny-DESK2.sc.intel.com>
References: <20190805023206.8831-1-jhubbard@nvidia.com>
 <20190805220441.GA23416@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805220441.GA23416@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 05, 2019 at 03:04:42PM -0700, 'Ira Weiny' wrote:
> On Sun, Aug 04, 2019 at 07:32:06PM -0700, john.hubbard@gmail.com wrote:
> > From: John Hubbard <jhubbard@nvidia.com>
> > 
> > For pages that were retained via get_user_pages*(), release those pages
> > via the new put_user_page*() routines, instead of via put_page() or
> > release_pages().
> > 
> > This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
> > ("mm: introduce put_user_page*(), placeholder versions").
> > 
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Jens Axboe <axboe@kernel.dk>
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: linux-block@vger.kernel.org
> > Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

<sigh>

I meant to say I wrote the same patch ...  For this one...

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> 
> > ---
> >  fs/io_uring.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/io_uring.c b/fs/io_uring.c
> > index d542f1cf4428..8a1de5ab9c6d 100644
> > --- a/fs/io_uring.c
> > +++ b/fs/io_uring.c
> > @@ -2815,7 +2815,7 @@ static int io_sqe_buffer_unregister(struct io_ring_ctx *ctx)
> >  		struct io_mapped_ubuf *imu = &ctx->user_bufs[i];
> >  
> >  		for (j = 0; j < imu->nr_bvecs; j++)
> > -			put_page(imu->bvec[j].bv_page);
> > +			put_user_page(imu->bvec[j].bv_page);
> >  
> >  		if (ctx->account_mem)
> >  			io_unaccount_mem(ctx->user, imu->nr_bvecs);
> > @@ -2959,10 +2959,8 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
> >  			 * if we did partial map, or found file backed vmas,
> >  			 * release any pages we did get
> >  			 */
> > -			if (pret > 0) {
> > -				for (j = 0; j < pret; j++)
> > -					put_page(pages[j]);
> > -			}
> > +			if (pret > 0)
> > +				put_user_pages(pages, pret);
> >  			if (ctx->account_mem)
> >  				io_unaccount_mem(ctx->user, nr_pages);
> >  			kvfree(imu->bvec);
> > -- 
> > 2.22.0
> > 
