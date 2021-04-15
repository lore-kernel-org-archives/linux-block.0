Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E8EC433B4
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 19:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E2A761158
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 19:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbhDOTiK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Apr 2021 15:38:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234764AbhDOTiK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Apr 2021 15:38:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71DFD610EA;
        Thu, 15 Apr 2021 19:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618515466;
        bh=iFxKoIpB8LF2vixHh4l9NHUymegm1KVCMc7hNo9LDNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HxEJhT3wHxtPJRtPkcZLSytTBrMJwU4bz2s6RNyUpCfD4XbwG6z0KJ/hK5uLx+jvQ
         2/iGwdrzwFsJTw2O/xmgNNDnX3jQZuAyUSEI0szSzpJu0rXpUGRymKDuAAer7bVp0o
         RtbpOoAIw8OS7G55NJ+p+9ZYNpKkOxfKsSMJnB4l2Db7DiVB2ZgmcZnSN5om3ZPQWH
         FJatvkXUoBAoTulYHZRjFfd6RAUJIah3xCKpaG+ies41uBodBIEHjoMuTG3o1stWNa
         BE+L5Vz/35Bk2UK4fb5Iy8F9vTnn6Y23qRionnwytOKH9mViPp4yyyRNeFg2ZH+5Fc
         ffoSL99wv7adg==
Date:   Thu, 15 Apr 2021 12:37:44 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Satya Tangirala <satyat@google.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 4/8] block: introduce bio_required_sector_alignment()
Message-ID: <YHiWCCliqPkA2o6h@gmail.com>
References: <20210325212609.492188-1-satyat@google.com>
 <20210325212609.492188-5-satyat@google.com>
 <20210330180653.GB811594@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330180653.GB811594@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 30, 2021 at 07:06:53PM +0100, Christoph Hellwig wrote:
> On Thu, Mar 25, 2021 at 09:26:05PM +0000, Satya Tangirala wrote:
> > +/*
> > + * The required sector alignment for a bio. The number of sectors in any bio
> > + * that's constructed/split must be aligned to this value.
> > + */
> > +static inline unsigned int bio_required_sector_alignment(struct bio *bio)
> > +{
> > +	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
> > +
> > +	return max(queue_logical_block_size(q) >> SECTOR_SHIFT,
> > +		   blk_crypto_bio_sectors_alignment(bio));
> > +}
> 
> It might make more sense to just have a field in the request queue
> for the max alignment so that the fast path just looks at one field.
> Then the various setup time functions would update it to the maximum
> required.

I don't see how that would work here, as the required alignment is a per-bio
thing which depends on whether the bio has an encryption context or not, and (if
it does) also the data_unit_size the submitter of the bio selected.

We could just always assume the worst-case scenario, but that seems
unnecessarily pessimistic?

- Eric
