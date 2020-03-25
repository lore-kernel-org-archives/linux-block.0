Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FEEC1975A
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 16:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBBAF20774
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 16:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KblLZx5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgCYQdC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 12:33:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40948 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbgCYQdC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 12:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iI2kZCOZdffPIYsZZTBoXRe/J58wOuQpQYgnCS5E0u8=; b=KblLZx5lvHAL3L7FaEMMD5jueW
        t8BfbCjQuM4FQnOR1tqbhS5fyKSO7LX5vH11QPMn++OAzmBpp3LraQC0wQ3oKUNwXB7etyxwfn51X
        IX+LSx8iqmiceyhSTch+mTJS/W2pBPWMnHTQIj9j1x8yp8l9pYY0IsRLT8/VaPU4k9J5rSrV5bpln
        0kGEcnTK7hoiKuqWsJXSNbO9Gb4dsE3fkFbDSeWrJSR5Ckf3n+F7XGj7JssOqhMLGaDYsHAHwbtYT
        n3qqJlClG1h5570HO7oLBPibCQFK7szYi+RITzIql+GgKgA+uMkT+UuvjU7GfHezQ8hN06eafqn55
        JNt0rvsA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH8x5-0000SZ-H8; Wed, 25 Mar 2020 16:32:23 +0000
Date:   Wed, 25 Mar 2020 09:32:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, axboe@kernel.dk,
        bob.liu@oracle.com, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, song@kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, Chaitanya.Kulkarni@wdc.com,
        ming.lei@redhat.com, osandov@fb.com, jthumshirn@suse.de,
        minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        bvanassche@acm.org, dhowells@redhat.com, asml.silence@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/6] block: Introduce REQ_ALLOCATE flag for
 REQ_OP_WRITE_ZEROES
Message-ID: <20200325163223.GA27156@infradead.org>
References: <158157930219.111879.12072477040351921368.stgit@localhost.localdomain>
 <e2b7cbab-d91f-fd7b-de6f-a671caa6f5eb@virtuozzo.com>
 <69c0b8a4-656f-98c4-eb55-2fd1184f5fc9@virtuozzo.com>
 <67d63190-c16f-cd26-6b67-641c8943dc3d@virtuozzo.com>
 <20200319102819.GA26418@infradead.org>
 <yq1tv2k8pjn.fsf@oracle.com>
 <20200325162656.GJ29351@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325162656.GJ29351@magnolia>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 25, 2020 at 09:26:56AM -0700, Darrick J. Wong wrote:
> > That said, I do think that we have traditionally put emphasis on the
> > wrong part of these operations. All we ever talk about wrt. discard and
> > friends is the zeroing aspect. But I actually think that, semantically,
> > the act of allocating and deallocating blocks is more important. And
> > that zeroing is an optional second order effect of those operations. So
> > if we could go back in time and nuke multi-range DSM TRIM/UNMAP, I would
> > like to have REQ_OP_ALLOCATE/REQ_OP_DEALLOCATE with an optional REQ_ZERO
> > flag. I think that would be cleaner. I have a much easier time wrapping
> > my head around "allocate this block and zero it if you can" than "zero
> > this block and do not deallocate it". But maybe that's just me.
> 
> I'd love to transition to that.  My brain is not good at following all
> the inverse logic that NOUNMAP spread everywhere.  I have a difficult
> time following what the blockdev fallocate code does, which is sad since
> hch and I are the primary stuckees^Wmeddlers^Wauthors of that function. :/

I am very much against that for the following reason:

 - the current REQ_OP_DISCARD is purely a hint, and implementations can
   (and do) choose to ignore it
 - REQ_OP_WRITE_ZEROES is an actual data integrity operation with
   everything that entails

Going back to mixing these two will lead to a disaster sooner or later.
