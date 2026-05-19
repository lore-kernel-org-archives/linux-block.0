Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7FB3A543E;
	Tue, 19 May 2026 06:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779173590; cv=none; b=eqFZ7crDpAFY4ImZBn71rY1IV7w9J3CR2N+16K02HixYTpl+6AARSYoXiAkdVwAFxF6xV9Hf26zOPXc+QGcZvCZwLphqLF9Lw9CGDXTiTI78zKvmyD51AXm++eOuhGe3+sBY6URNffJ7wU1irmRuca6MH3GpTVKzBK6zWSKqaQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779173590; c=relaxed/simple;
	bh=iBMnfOpZMlMikubAUJOkcEpNqP5FwUUy48scPBDbKJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPyo1h4W5hV9lIKwwCT/cztUjz8YtWXAHiemnPgbQC/r2bPpc4XwosJ5rhYaxG4AiS5fIJ2IqqQyIXyS/mESYN5Z741Bip4OWkYsjvp2aEnpkCWZBBiLWXIFbCcbdK6D08Wa6fedBrjmxidE4N1ZYOipJm/2PkQfNpHcXV8GjGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EE7C668CFE; Tue, 19 May 2026 08:53:03 +0200 (CEST)
Date: Tue, 19 May 2026 08:53:03 +0200
From: "hch@lst.de" <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: "Achkinazi, Igor" <Igor.Achkinazi@dell.com>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] nvme-multipath: set BIO_REMAPPED on bios remapped to
 per-path namespace disks
Message-ID: <20260519065303.GA7918@lst.de>
References: <MW5PR19MB548483D1FAE4F322E4C97352FD032@MW5PR19MB5484.namprd19.prod.outlook.com> <agtnJb5a5uIqH-65@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agtnJb5a5uIqH-65@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 18, 2026 at 01:23:17PM -0600, Keith Busch wrote:
> On Mon, May 18, 2026 at 02:52:56PM +0000, Achkinazi, Igor wrote:
> > @@ -511,6 +511,13 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
> >         ns = nvme_find_path(head);
> >         if (likely(ns)) {
> >                 bio_set_dev(bio, ns->disk->part0);
> > +               /*
> > +                * Mark the bio as remapped to the per-path namespace disk so
> > +                * that bio_check_eod() is skipped on resubmission (e.g. from
> > +                * bio splitting in blk_mq_submit_bio).  The EOD check already
> > +                * passed on the multipath head disk.
> > +                */
> > +               bio_set_flag(bio, BIO_REMAPPED);
> 
> Any reason nvme multipath can't call submit_bio_noacct_nocheck()
> directly instead? If it's safe to skip the eod check here, then it
> looks safe to skip everything else too.

We really shouldn't expose that, and it doesn't quite to the
right checks here.

But I think the proper fix is to stop using bio_set_dev entirely.
We do not want to associate the bio with a new blkg as those are
basically not going to exist for the underlying devices.  I'm also
not sure we want to allow another round of BPF throttling either.
