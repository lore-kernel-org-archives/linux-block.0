Return-Path: <SRS0=mx3V=TD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7960C43219
	for <linux-block@archiver.kernel.org>; Fri,  3 May 2019 07:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B50FD2075C
	for <linux-block@archiver.kernel.org>; Fri,  3 May 2019 07:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfECHU2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 May 2019 03:20:28 -0400
Received: from verein.lst.de ([213.95.11.211]:35703 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfECHU2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 May 2019 03:20:28 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 88EAA68B02; Fri,  3 May 2019 09:20:10 +0200 (CEST)
Date:   Fri, 3 May 2019 09:20:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/8] block: use bio_release_pages in bio_unmap_user
Message-ID: <20190503072010.GA9866@lst.de>
References: <20190502233332.28720-1-hch@lst.de> <20190502233332.28720-3-hch@lst.de> <778d8485-9066-ae3f-68e2-8f2b3fe94ccf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <778d8485-9066-ae3f-68e2-8f2b3fe94ccf@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 03, 2019 at 09:50:08AM +0300, Nikolay Borisov wrote:
> > @@ -1474,7 +1456,9 @@ static void __bio_unmap_user(struct bio *bio)
> >   */
> >  void bio_unmap_user(struct bio *bio)
> >  {
> > -	__bio_unmap_user(bio);
> > +	bio_set_pages_dirty(bio);
> 
> Doesn't this need to be :
> 
> if (bio_data_dir(bio) == READ)
>   bio_set_pages_dirty()

Yes, indeed.
