Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6A7BA2D
	for <linux-block@vger.kernel.org>; Thu, 13 Feb 2025 06:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739428343; cv=none; b=ivwKqifxFxS83PfZ4SCq2aOnRCxu98Io4Zh9pnvsiG/+VhhDC8gw0ktN1ASAgQcabbSR07+tHrhV70ksJGNkEBxilKb5/Iyr8lFiN5hVlZR/Hnry82HvsyFuFazhGVM1AGmLh0iRBAqbgjbS1BZLuSFFfKMwqB0JoLN0g5KlNyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739428343; c=relaxed/simple;
	bh=nKPGgvVNhxfO5axLdwlN9GjZwPpJp4iX0Pz0zp0jqYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXysdG36l3efAOZfg+C+nteZ8u6138nyVEiUDKr5sxr7Ilni87j60udKpvQTRfUlYdMmdYkV7YXvHZR5Y/LhyVjvBETrl1Dywpxk7Nuq1Pvxr6m/3hXsVfjEJ7FV6Xrs5B1i1xhotCgdPxpiimF17ZNW5JI3KmiJs53Cgs/J8Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3F0D267373; Thu, 13 Feb 2025 07:32:15 +0100 (CET)
Date: Thu, 13 Feb 2025 07:32:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Cheyenne Wills <cheyenne.wills@gmail.com>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: BUG: NULL pointer dereferenced within __blk_rq_map_sg
Message-ID: <20250213063214.GA20171@lst.de>
References: <CAHpsFVeew-p9xB9DB52Pk_6mXfFxJbT8p14h5+YRTKabEfU3BQ@mail.gmail.com> <Z6s-3LndN-Gt5sZB@fedora> <Z6tss9YS98AEIwQy@fedora> <CAHpsFVcMnSJgJbGrqiBDmYkHyneJdby4DMkOKQKAuicA0kgJQA@mail.gmail.com> <Z61LEUdHI2Hx3bue@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z61LEUdHI2Hx3bue@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Feb 13, 2025 at 09:29:53AM +0800, Ming Lei wrote:
> Yeah, turns out oops is triggered in initializing req_iterator for
> discard req, and the following patch should be enough:

How do we end up in blk_rq_map_sg for a discard request here?
dma-mapping doesn't make sense for a non-special pyaload discard
as used by xxen-blkfront, and xen-blkfront also only calls
blk_rq_map_sg from blkif_queue_rw_req and not blkif_queue_discard_req.

