Return-Path: <SRS0=7FI7=SR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EB3C10F0E
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 15:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01CE20818
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 15:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfDOPME (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:12:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56484 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727456AbfDOPME (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Apr 2019 11:12:04 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 116D581F0F;
        Mon, 15 Apr 2019 15:11:57 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A56460F9B;
        Mon, 15 Apr 2019 15:11:48 +0000 (UTC)
Date:   Mon, 15 Apr 2019 11:11:46 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     "Yan, Zheng" <zyan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel@vger.kernel.org
Subject: Re: [PATCH v1 15/15] ceph: use put_user_pages() instead of
 ceph_put_page_vector()
Message-ID: <20190415151146.GA3436@redhat.com>
References: <20190411210834.4105-1-jglisse@redhat.com>
 <20190411210834.4105-16-jglisse@redhat.com>
 <df4da184-fe8b-c189-43e5-fac58adb3ed9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df4da184-fe8b-c189-43e5-fac58adb3ed9@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 15 Apr 2019 15:12:03 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 15, 2019 at 03:46:59PM +0800, Yan, Zheng wrote:
> On 4/12/19 5:08 AM, jglisse@redhat.com wrote:
> > From: Jérôme Glisse <jglisse@redhat.com>
> > 
> > When page reference were taken through GUP (get_user_page*()) we need
> > to drop them with put_user_pages().
> > 
> > Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: linux-block@vger.kernel.org
> > Cc: linux-mm@kvack.org
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Johannes Thumshirn <jthumshirn@suse.de>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Jens Axboe <axboe@kernel.dk>
> > Cc: Ming Lei <ming.lei@redhat.com>
> > Cc: Dave Chinner <david@fromorbit.com>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Yan Zheng <zyan@redhat.com>
> > Cc: Sage Weil <sage@redhat.com>
> > Cc: Ilya Dryomov <idryomov@gmail.com>
> > Cc: ceph-devel@vger.kernel.org
> > ---
> >   fs/ceph/file.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > index 6c5b85f01721..5842ad3a4218 100644
> > --- a/fs/ceph/file.c
> > +++ b/fs/ceph/file.c
> > @@ -667,7 +667,8 @@ static ssize_t ceph_sync_read(struct kiocb *iocb, struct iov_iter *to,
> >   			} else {
> >   				iov_iter_advance(to, 0);
> >   			}
> > -			ceph_put_page_vector(pages, num_pages, false);
> > +			/* iov_iter_get_pages_alloc() did call GUP */
> > +			put_user_pages(pages, num_pages);
> 
> pages in pipe were not from get_user_pages(). Am I missing anything?

Oh my mistake i miss-read iov_iter_is_pipe() and iov_iter_get_pages_alloc()
missed the special case for pipe before iterate_all_kinds() Thanks for
catching that.

Cheers,
Jérôme
