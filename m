Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB6812E5D
	for <linux-block@vger.kernel.org>; Wed,  3 Jul 2024 04:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719982001; cv=none; b=sxRswFbY5+DkFSKIl6WgwA+tiPpnPvB1b1JbDgc2gwyNwvVp41XA92nXG3j1hPWd8rsGblCMo9jqjZK8malNmTrydTn1/TJWrl4/Kju9PYrisKmQPqmi4E1REuJt5vOC4tJEc/gmhI4lkFS2BDFsoWJX9jYB3imjn4rNhoxaRzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719982001; c=relaxed/simple;
	bh=lG7Bk3F7bM31WAamCrerOwT5WtLmVFA1qKg2lCxmbZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVbuTglUQIoTZ/G+woLKnHuIdmRMrfBCcIuZilLsV45/tEmRu+iTA2lnFQx0DRdXg3g4yH1FVuHz7M44W7c7fJH7a1sjItLcf3PPWiwCjsJYtE3uFYZS0RKLjctiYxjktcjLBAEAZaefBmZ+LhJQOS95NrPgjcixyaxj0V8hYWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 27D6B227A87; Wed,  3 Jul 2024 06:46:36 +0200 (CEST)
Date: Wed, 3 Jul 2024 06:46:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Anuj Gupta <anuj20.g@samsung.com>, axboe@kernel.dk, hch@lst.de,
	martin.petersen@oracle.com, joshi.k@samsung.com,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] block: reuse original bio_vec array for integrity
 during clone
Message-ID: <20240703044635.GA24498@lst.de>
References: <CGME20240702101517epcas5p3f651d9307bab6ece4d3e450ed61deb82@epcas5p3.samsung.com> <20240702100753.2168-1-anuj20.g@samsung.com> <CAFj5m9LcpCbdy4Vim3R+=KOnyM_AwevGM1ye5NSY4HRt1XS06Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFj5m9LcpCbdy4Vim3R+=KOnyM_AwevGM1ye5NSY4HRt1XS06Q@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jul 03, 2024 at 11:08:49AM +0800, Ming Lei wrote:
> > -       bip = bio_integrity_alloc(bio, gfp_mask, bip_src->bip_vcnt);
> > +       bip = bio_integrity_alloc(bio, gfp_mask, 0);
> >         if (IS_ERR(bip))
> >                 return PTR_ERR(bip);
> >
> > -       memcpy(bip->bip_vec, bip_src->bip_vec,
> > -              bip_src->bip_vcnt * sizeof(struct bio_vec));
> > -
> > -       bip->bip_vcnt = bip_src->bip_vcnt;
> > +       bip->bip_vec = bip_src->bip_vec;
> >         bip->bip_iter = bip_src->bip_iter;
> >         bip->bip_flags = bip_src->bip_flags & ~BIP_BLOCK_INTEGRITY;
> 
> I am curious how the patch avoids double free? Given nothing changes
> in bip free code path and source bip_vec is associated with this bip.

bvec_free only frees the bvec array if nr_vecs is > BIO_INLINE_VECS.
bio_integrity_clone now passes 0 as nr_vecs to bio_integrity_alloc
so it won't ever free the bvec array.  This matches what we are
doing for the data bvec array in the bio.
