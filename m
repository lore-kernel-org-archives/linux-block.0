Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9737C433DB
	for <linux-block@archiver.kernel.org>; Thu, 25 Feb 2021 02:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B879264ECB
	for <linux-block@archiver.kernel.org>; Thu, 25 Feb 2021 02:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbhBYCXy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Feb 2021 21:23:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23324 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232033AbhBYCXv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Feb 2021 21:23:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614219744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zHifhPZqSTGsx0tsb0bkLIaDcszosEByZcCVDRqblVw=;
        b=HdXDFGzjagjyGl6dhgbg3r0MTIPw+6zuHrpfwEhCLj7+B3eGxRcAdXmHbmR8SwJr252rJr
        SAvspUg9CXb74GRjheLHccGbAvO0cC+wriuCmf4SRm+bA8fBiz55fCfY9sK9tis9MDctiE
        cr+09GTMs2uKeMgwkZSNhtKRR6q4NcI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-VJErAz_1PIOdYBudwN3n5Q-1; Wed, 24 Feb 2021 21:22:09 -0500
X-MC-Unique: VJErAz_1PIOdYBudwN3n5Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 183981005501;
        Thu, 25 Feb 2021 02:22:08 +0000 (UTC)
Received: from T590 (ovpn-12-164.pek2.redhat.com [10.72.12.164])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A1A9B5D9D3;
        Thu, 25 Feb 2021 02:22:01 +0000 (UTC)
Date:   Thu, 25 Feb 2021 10:21:55 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Satya Tangirala <satyat@google.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        John Stultz <john.stultz@linaro.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 4/4] block: memory allocations in bounce_clone_bio must
 not fail
Message-ID: <YDcJw/5u8FG/0g0E@T590>
References: <20210224072407.46363-1-hch@lst.de>
 <20210224072407.46363-5-hch@lst.de>
 <YDY2WPtSLmvNt0W2@T590>
 <20210224161236.GA9127@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224161236.GA9127@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 24, 2021 at 05:12:36PM +0100, Christoph Hellwig wrote:
> On Wed, Feb 24, 2021 at 07:19:52PM +0800, Ming Lei wrote:
> > >  	if (bio_is_passthrough(bio_src))
> > > -		bio = bio_kmalloc(GFP_NOIO, bio_segments(bio_src));
> > > +		bio = bio_kmalloc(GFP_NOIO | __GFP_NOFAIL,
> > > +				  bio_segments(bio_src));
> > 
> > bio_kmalloc() still may fail if bio_segments(bio_src) is > UIO_MAXIOV.
> 
> Yes, but bio_kmalloc is what is used to allocate the passthrough
> requests to start with, so we'd not even make it here.

The original bio_kmalloc() may start with allowed nr_iovecs , but
later more pages are retrieved from iov_iter and added to the bio,
see bio_map_user_iov(). Then bounce_clone_bio() will see too big
bio_segments(bio_src) to be held in UIO_MAXIOV vecs.

This behavior is similar with blkdev_direct_IO().

-- 
Ming

