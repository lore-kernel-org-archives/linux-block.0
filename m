Return-Path: <SRS0=aY0t=SU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAC1C282DD
	for <linux-block@archiver.kernel.org>; Thu, 18 Apr 2019 09:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99656214DA
	for <linux-block@archiver.kernel.org>; Thu, 18 Apr 2019 09:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388052AbfDRJ3d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:29:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56894 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387971AbfDRJ3d (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Apr 2019 05:29:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 729A14DB12;
        Thu, 18 Apr 2019 09:29:33 +0000 (UTC)
Received: from ming.t460p (ovpn-8-35.pek2.redhat.com [10.72.8.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C19B5D6A9;
        Thu, 18 Apr 2019 09:29:24 +0000 (UTC)
Date:   Thu, 18 Apr 2019 17:29:19 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, stefanha@redhat.com,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2] block: bio_map_user_iov should not be limited to
 BIO_MAX_PAGES
Message-ID: <20190418092918.GB15834@ming.t460p>
References: <20190417115207.30202-1-pbonzini@redhat.com>
 <20190418021903.GB9520@ming.t460p>
 <1950505c-c1ff-3a99-bf4d-319ae1be381b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1950505c-c1ff-3a99-bf4d-319ae1be381b@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 18 Apr 2019 09:29:33 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 18, 2019 at 10:42:21AM +0200, Paolo Bonzini wrote:
> On 18/04/19 04:19, Ming Lei wrote:
> > Hi Paolo,
> > 
> > On Wed, Apr 17, 2019 at 01:52:07PM +0200, Paolo Bonzini wrote:
> >> Because bio_kmalloc uses inline iovecs, the limit on the number of entries
> >> is not BIO_MAX_PAGES but rather UIO_MAXIOV, which indeed is already checked
> >> in bio_kmalloc.  This could cause SG_IO requests to be truncated and the HBA
> >> to report a DMA overrun.
> > 
> > BIO_MAX_PAGES only limits the single bio's max vector number, if one bio
> > can't hold all user space request, new bio will be allocated and appended
> > to the passthrough request if queue limits aren't reached.
> 
> Stupid question: where?  I don't see any place starting at
> blk_rq_map_user_iov (and then __blk_rq_map_user_iov->bio_map_user_iov)
> that would allocate a second bio.  The only bio_kmalloc in that path is
> the one I'm patching.

Each bio is created inside __blk_rq_map_user_iov() which is run inside
a loop, and the created bio is added to request via blk_rq_append_bio(),
see the following code:

blk_rq_map_user_iov
	__blk_rq_map_user_iov
		blk_rq_append_bio

blk_rq_map_user_iov():
		...
        do {
                ret =__blk_rq_map_user_iov(rq, map_data, &i, gfp_mask, copy);
                if (ret)
                        goto unmap_rq;
                if (!bio)
                        bio = rq->bio;
        } while (iov_iter_count(&i));
		...

Thanks,
Ming
