Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A27C433F5
	for <linux-block@archiver.kernel.org>; Wed, 23 Mar 2022 06:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbiCWGs2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Mar 2022 02:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiCWGs1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Mar 2022 02:48:27 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD4370CF0
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 23:46:58 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 043A868B05; Wed, 23 Mar 2022 07:46:55 +0100 (CET)
Date:   Wed, 23 Mar 2022 07:46:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        ming.lei@redhat.com, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/3] block: allow BIOSET_PERCPU_CACHE use from
 bio_alloc_clone
Message-ID: <20220323064654.GB24874@lst.de>
References: <20220322194927.42778-1-snitzer@kernel.org> <20220322194927.42778-2-snitzer@kernel.org> <20220322195414.GA8650@lst.de> <Yjouh9C7MaVrTnLh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yjouh9C7MaVrTnLh@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 22, 2022 at 04:16:07PM -0400, Mike Snitzer wrote:
> I did initially think it worthwhile to push the use of
> bio_alloc_percpu_cache() down to bio_alloc_bioset() rather than
> bio_alloc_clone() -- but I started slower with more targetted change
> for DM's needs.

Note that the nvme io_uring passthrough patches also want a non-kiocb
cached alloc version.  That code isn't quite ready yet but shows we'll
need something there as well.

> And yeah, since there isn't a REQ_ flag equivalent for IOCB_ALLOC_CACHE
> (other than just allowing all REQ_POLLED access) there isn't a
> meaningful way to limit access to the bioset's percpu cache.
> 
> Curious: how do bio_alloc_kiocb() callers know when it appropriate to
> set IOCB_ALLOC_CACHE or not?  Seems io_uring is only one and it
> unilaterally does:
> kiocb->ki_flags |= IOCB_HIPRI | IOCB_ALLOC_CACHE;

Yes, an uring deals with making sure they are freed in the same place.

> So like IOCB_HIPRI maps to REQ_POLL, should IOCB_ALLOC_CACHE map to
> REQ_ALLOC_CACHE? Or better name?

The name sounds good fine, and I just it would be best done by
lifting BIO_PERCPU_CACHE to the REQ_ namespace and ensure it is
cleared by the bio allocator if the percpu cache isn't actually
used.
