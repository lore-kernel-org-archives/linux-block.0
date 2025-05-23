Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B399714AA9
	for <linux-block@vger.kernel.org>; Fri, 23 May 2025 12:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748004536; cv=none; b=UxGj8lRZwZk+Fvt/QLqzMsbAv1HIthcQj4jJv1akxUdMe4MrjN458q4Ald3Wns+0Bsd1yfi+auOsTuypTiAUZ+hYSAqAyJwDffnwcIVITfbo1ZAxRYILhivszJsNKPcBbkgurSc/xJ2A9byoFRrlbsuCo+/X3VetcP36d0eDjfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748004536; c=relaxed/simple;
	bh=fineL6bbK4SlZgBpfZPEcTZG3k/maKnzFeFrQu9TVRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BlRm7jOFvYhqMiZgEOjnU1+S3pc9cYTc9Xjr4Iiew+7IdBuoFDjhxrvE1IiTId7CdSrbCmUB8/pYVhYay84q2zcOdmGirfX9B4F68RgehgOQH6toqVnfe2rAGz7nVPvT0QJ93glAjfmpqOVyuzKRnkWOS0zTMw1kSHx21ITGsUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RrI+7Fvo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RrI+7Fvo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=hyf5JRLKqIav9cUOYory0W+34rSaiywHM8eIA3xqmmA=; b=RrI+7Fvo5Fzkyq5IJzFJVMU3od
	dN5S58HpUx7rwYQswps5P92EsmgXbKscSahqCpqO9HNTg8zY3Ah6y5KeOdnPH9CHx3EmqFg+NmO8M
	3v7AmCTE8WC6R+35qWgtPMyCD+SRxkNXgdDZF4+HE0Jh+yfoQVBHMK6bLjqCF3+5xT2x5qvQX1FCJ
	MoTF+ecbZi6T9qOtuSoSumT0zZ770Bl08RZ3zhd4fdP2ixM1WaI6blPTQm0NDBrbYg7nQbbQH91Dx
	Hj/drxnOrcMpsgxOh6XvAUtmhv1U977OymkClAXA3qNmyiylQWxcOoAtW+872y6hipiSj/g7TVweR
	CdleSw2g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIRpW-00000003qmw-0c09;
	Fri, 23 May 2025 12:48:54 +0000
Date: Fri, 23 May 2025 05:48:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/5] nvme: add support for copy offload
Message-ID: <aDButoJC0WHWxSoP@infradead.org>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-4-kbusch@meta.com>
 <CADUfDZqVeaR=15drRFvdrgGyFhyQ=FtscaZycVrQ0pd-PGei=A@mail.gmail.com>
 <CADUfDZqC0kiLTDFv3kXNaDr25rb+6RGG3cW3r=mox2vdihpsow@mail.gmail.com>
 <aC6Ymfrn1cZablbE@kbusch-mbp>
 <CADUfDZr8DJUPhLvVFK9OPSv015VDSBGNv7z_rrioHFAqOALUOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZr8DJUPhLvVFK9OPSv015VDSBGNv7z_rrioHFAqOALUOg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 21, 2025 at 08:41:40PM -0700, Caleb Sander Mateos wrote:
> On Wed, May 21, 2025 at 8:23 PM Keith Busch <kbusch@kernel.org> wrote:
> >
> > On Wed, May 21, 2025 at 05:51:03PM -0700, Caleb Sander Mateos wrote:
> > > On Wed, May 21, 2025 at 5:47 PM Caleb Sander Mateos
> > > >
> > > > alloc_size should be sizeof(*range) * i? Otherwise this exceeds the
> > > > amount of data used by the Copy command, which not all controllers
> > > > support (see bit LLDTS of SGLS in the Identify Controller data
> > > > structure). We have seen the same behavior with Dataset Management
> > > > (always specifying 4 KB of data), which also passes the maximum size
> > > > of the allocation to bvec_set_virt().
> > >
> > > I see that was added in commit 530436c45ef2e ("nvme: Discard
> > > workaround for non-conformant devices"). I would rather wait for
> > > evidence of non-conformant devices supporting Copy before implementing
> > > the same spec-noncompliant workaround. It could be a quirk if
> > > necessary.
> >
> > Right, that's exactly why I didn't bother allocating tighter to what the
> > command actually needs. The number of devices that would have needed a
> > DSM quirk for the full 4k was untenable, so making the quirk behavior
> > the default was a sane compromise. I suppose Copy is a more enterprisey
> > feature in comparison, so maybe we can count on devices doing dma
> > correctly?
> 
> For the record, that change broke Linux hosts sending DSM commands to
> our NVMe controller, which was validating that the SGL length exactly
> matches the number of data bytes implied by the command.

Next time please send a bug report and/or fix ASAP when you see
such changes.

