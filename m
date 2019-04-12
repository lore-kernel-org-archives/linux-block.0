Return-Path: <SRS0=iV0P=SO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB16BC10F13
	for <linux-block@archiver.kernel.org>; Fri, 12 Apr 2019 00:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E0E2184B
	for <linux-block@archiver.kernel.org>; Fri, 12 Apr 2019 00:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfDLAIy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 20:08:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38022 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726732AbfDLAIy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 20:08:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BA22B19D2BD;
        Fri, 12 Apr 2019 00:08:53 +0000 (UTC)
Received: from redhat.com (ovpn-120-97.rdu2.redhat.com [10.10.120.97])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EE7C5D9C8;
        Fri, 12 Apr 2019 00:08:48 +0000 (UTC)
Date:   Thu, 11 Apr 2019 20:08:46 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Ernesto A =?iso-8859-1?Q?=2E_Fern=E1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>, Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH v1 12/15] fs/direct-io: keep track of wether a page is
 coming from GUP or not
Message-ID: <20190412000846.GB13369@redhat.com>
References: <20190411210834.4105-1-jglisse@redhat.com>
 <20190411210834.4105-13-jglisse@redhat.com>
 <20190411231443.GD1695@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190411231443.GD1695@dread.disaster.area>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 12 Apr 2019 00:08:54 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 12, 2019 at 09:14:43AM +1000, Dave Chinner wrote:
> On Thu, Apr 11, 2019 at 05:08:31PM -0400, jglisse@redhat.com wrote:
> > From: Jérôme Glisse <jglisse@redhat.com>
> > 
> > We want to keep track of how we got a reference on page when doing DIO,
> > ie wether the page was reference through GUP (get_user_page*) or not.
> > For that this patch rework the way page reference is taken and handed
> > over between DIO code and BIO. Instead of taking a reference for page
> > that have been successfuly added to a BIO we just steal the reference
> > we have when we lookup the page (either through GUP or for ZERO_PAGE).
> > 
> > So this patch keep track of wether the reference has been stolen by the
> > BIO or not. This avoids a bunch of get_page()/put_page() so this limit
> > the number of atomic operations.
> 
> Is the asme set of changes appropriate for the fs/iomap.c direct IO
> path (i.e. XFS)?

Yes and it is part of this patchset AFAICT iomap use bio_iov_iter_get_pages()
which is updated to pass down wether page are coming from GUP or not. The
bio you get out of that is then release through iomap_dio_bio_end_io() which
calls bvec_put_page() which will use put_user_page() for GUPed page.

I may have miss a case and review are welcome.

Note that while the convertion is happening put_user_page is exactly the same
as put_page() in fact the implementation just call put_page() with nothing
else.

The tricky part is making sure that before we diverge with a put_user_page()
that does something else that put_page() we will need to be sure that we did
not left a path that do GUP but does call put_page() and not put_user_page().
We have some plan to catch that in debug build.

In any case i believe we will be very careful when the times come to change
put_user_page() to something different.

Cheers,
Jérôme
