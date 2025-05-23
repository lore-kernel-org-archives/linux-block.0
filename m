Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81597E552
	for <linux-block@vger.kernel.org>; Fri, 23 May 2025 12:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748004592; cv=none; b=a3ptVqojG734IOfmGc97VFCZWnmAFX/TWUc2xi60dtbr5fR7BCGPb2b4rUgpmis6rtzxL8fax/tu7JCPD43OzoiQY9V3KvPpEWK5AiOMqyM6s6oFvCHVoaMfSPZpEAx7YuSOs1tqM7CG/kLgTXySOrFRAv7OOAhaYGHNPc3JA1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748004592; c=relaxed/simple;
	bh=2YuwzJslJvE+cExZjNwVePO2ONTICKIW5LkWrmsJd64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obGe/fqlSMVqc4M4PUHGVyJuRGfnwRYfbmMY1A7pe3eIkdMYG5RxTnT81YpAgMOTTZlqWKmuZyWlwVzQg9O5twvE8kdGmMGtu2gKcwzRJgVzJhUJ8PqmD0QC9fYcDgcOKvQILOgHstUqp66vtwYwv7tvI01Z3fW2fhrgySUyLBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PHWCHWmP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PHWCHWmP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fr8JPeShHXPfFDLwMg1ZtfV7+Rknd8f+6FTSiLcXSKM=; b=PHWCHWmPrYk8hCUDunxV+lLXn/
	VcKOO1mFTJdUwxwfbh7tEf85yluWWWqg6oVXd182TwTtGofnbbZbn1iq4/ej5w/tk2mET8eJ7VGGW
	/3ayfNjk+P/V/TPFYCwm/SDUGX3bmKIsRaRdCIS3R7oARYFwEN9UaLILtg8D+e4iYHcLrnyLBxyMO
	bp6DVPcXzFXQuxUsAnQQ52rK+EiIzKdqDQZN446QPhOtCDxXBQcl605tj0sZo86aNQ7b85HtskC+r
	8Alxq8bl2MxtzrP1OvXW3ANWLCiNnudHv3aa2pk6OjWWmFUaHOuJW+0mt3dCrCGAk8T+zbLSPRHaG
	beeAKlFA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIRqQ-00000003qzD-3Edr;
	Fri, 23 May 2025 12:49:50 +0000
Date: Fri, 23 May 2025 05:49:50 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/5] nvme: add support for copy offload
Message-ID: <aDBu7i4T4AZ5nBnI@infradead.org>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-4-kbusch@meta.com>
 <CADUfDZqVeaR=15drRFvdrgGyFhyQ=FtscaZycVrQ0pd-PGei=A@mail.gmail.com>
 <CADUfDZqC0kiLTDFv3kXNaDr25rb+6RGG3cW3r=mox2vdihpsow@mail.gmail.com>
 <aC6Ymfrn1cZablbE@kbusch-mbp>
 <CADUfDZr8DJUPhLvVFK9OPSv015VDSBGNv7z_rrioHFAqOALUOg@mail.gmail.com>
 <aC6oR90OFDSITndh@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aC6oR90OFDSITndh@kbusch-mbp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 21, 2025 at 10:29:59PM -0600, Keith Busch wrote:
> On Wed, May 21, 2025 at 08:41:40PM -0700, Caleb Sander Mateos wrote:
> > For the record, that change broke Linux hosts sending DSM commands to
> > our NVMe controller, which was validating that the SGL length exactly
> > matches the number of data bytes implied by the command. I'm sure
> > we're in the minority of NVMe controller vendors in aggressively
> > validating the NVMe command parameters, but it was unfortunate to
> > discover this change in Linux's behavior.
> 
> This is a fabrics target you're talking about? I assume so because pci
> would use PRP for a 4k payload, which doesn't encode transfer lengths.
> All the offending controllers were pci, so maybe we could have
> constrained the DSM over-allocation to that transport if we knew this
> was causing problems for fabrics.

Or constrain the workaround to PRPs which never encode the actual
length anyway (which probably is the source of the bugs).

The fact that NVMe went with this stupid PRP scheme instead of SGLs
still makes me angry..
