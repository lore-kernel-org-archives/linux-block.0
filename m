Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFA6C433E6
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 16:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C4CC64F0E
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 16:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbhBXQPh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Feb 2021 11:15:37 -0500
Received: from verein.lst.de ([213.95.11.211]:38400 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235808AbhBXQN3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Feb 2021 11:13:29 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7A65967357; Wed, 24 Feb 2021 17:12:36 +0100 (CET)
Date:   Wed, 24 Feb 2021 17:12:36 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Satya Tangirala <satyat@google.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        John Stultz <john.stultz@linaro.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 4/4] block: memory allocations in bounce_clone_bio must
 not fail
Message-ID: <20210224161236.GA9127@lst.de>
References: <20210224072407.46363-1-hch@lst.de> <20210224072407.46363-5-hch@lst.de> <YDY2WPtSLmvNt0W2@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDY2WPtSLmvNt0W2@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 24, 2021 at 07:19:52PM +0800, Ming Lei wrote:
> >  	if (bio_is_passthrough(bio_src))
> > -		bio = bio_kmalloc(GFP_NOIO, bio_segments(bio_src));
> > +		bio = bio_kmalloc(GFP_NOIO | __GFP_NOFAIL,
> > +				  bio_segments(bio_src));
> 
> bio_kmalloc() still may fail if bio_segments(bio_src) is > UIO_MAXIOV.

Yes, but bio_kmalloc is what is used to allocate the passthrough
requests to start with, so we'd not even make it here.
