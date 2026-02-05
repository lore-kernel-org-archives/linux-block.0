Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BE9413249
	for <linux-block@vger.kernel.org>; Thu,  5 Feb 2026 15:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770306859; cv=none; b=CfABNxnFwDeBooynDcsqgdkkixCCzwaqCDJ25HZ0tzUmwTKPSbjLOSvhXV3OYLGvD7G4FZ+/b5nChRxBQ5tNMhu8s3ZmbnBEj0WRXLOEahnfXqvLHkR5C2MDYKHoac9QgsOoOW6dE7Hlf5HdOQGn+4mZngafqlr6hht7DqlauHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770306859; c=relaxed/simple;
	bh=meA/eQMCek5VLdG83C2daqCnNVz00sYX3PBQYi+wVEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZbGiWEinJmPAh/LuZjaSqMvQhfJK4WIrl6ekFxfSy4jhpZrsQ/OhG80XMCm7j42ZsocVD4EO4Q+UsdLq4VQxXQ5RbAqbR7y0Yjg4PXCkkgNu8USX9+fAlWMHVBpbxJ6gMzk6IOFl7oZ+iNQi+ZmteCWulOdjwELOGO/HH4B3mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4teAPfA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4teAPfA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E10C4CEF7;
	Thu,  5 Feb 2026 15:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770306859;
	bh=meA/eQMCek5VLdG83C2daqCnNVz00sYX3PBQYi+wVEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D4teAPfAKZhIAJK5QFgSTSzDuEQGgVxC9eMUIqX25GPMe6Q3ez2yFapfab10vQh+O
	 QHyzcfmcwEh2N3ig2FaDvfg/SbloC+a6OER0cRvhK5vaf9i+YYMsVTqiL39cvaRRoU
	 6upfkpoEMcnm9VIvDQcOrhgyu0l/3z6glX8XZC3G+wFeoialq2PqZp+CRsHy//D/b1
	 BVfcVdcoDHp6DjJhYsc9xyvgkjUSeiC+7scv5wCu0hPM3YKdwRRKErZdEMSTtmlEG5
	 VnFMKlRikjH7TbNfxFvg32o9gSGwPQDurse233Piudmqe+k7SeioNzYDpMSP7rCexI
	 HYRthmSJ8MORg==
Date: Thu, 5 Feb 2026 08:54:17 -0700
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, linux-block@vger.kernel.org
Subject: Re: [GIT PULL] nvme fixes for 6.19, final
Message-ID: <aYS9KeAYcTh9GIaJ@kbusch-mbp>
References: <aYS5ZlwruxpNCdTL@kbusch-mbp>
 <d114450b-2405-4ed0-bcda-03e08f48ba1d@kernel.dk>
 <ded8f99f-2d4a-48fc-9cff-02aa317a1c25@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ded8f99f-2d4a-48fc-9cff-02aa317a1c25@kernel.dk>

On Thu, Feb 05, 2026 at 08:49:35AM -0700, Jens Axboe wrote:
> On 2/5/26 8:47 AM, Jens Axboe wrote:
> > On 2/5/26 8:38 AM, Keith Busch wrote:
> >> Hi Jens,
> >>
> >> Some late fixes for nvme that should go in this release. One for a pci
> >> regression that causes a kernel panic during certain dma conditions. The
> >> other fixes a vulnerability in the tcp target.
> >>
> >> The following changes since commit 4da7c5c3ec34d839bba6e035c3d05c447a2f9d4f:
> >>
> >>   bcache: fix I/O accounting leak in detached_dev_do_request (2026-01-28 19:06:55 -0700)
> >>
> >> are available in the Git repository at:
> >>
> >>   git://git.infradead.org/nvme.git tags/nvme-6.19-2026-02-05
> >>
> >> for you to fetch changes up to 52a0a98549344ca20ad81a4176d68d28e3c05a5c:
> >>
> >>   nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec (2026-02-05 07:29:10 -0800)
> >>
> >> ----------------------------------------------------------------
> >> nvme fixes for Linux 6.19
> >>
> >>  - Fix NULL pointer access setting up dma mappings (Keith)
> >>  - Fix invalid memory access from malformed TCP PDU (YunJe)
> >>
> >> ----------------------------------------------------------------
> >> Keith Busch (1):
> >>       nvme-pci: handle changing device dma map requirements
> > 
> > After this one, iod in nvme_pci_prp_iter_next() is now unused, which
> > will trigger a compiler warning...
> 
> Actually this is only true in the 7.0 based branches. Should be fine
> for 6.19, I'll add a commit for the 7.0 merge.

Yeah, I initially applied this to 7.0 with it removed, but we decided
this was a nasty and easy to hit bug that 6.19 is better of having fixed
on release. I had to leave the 'iod' in for the 6.19 port, so looks like
we'll have a merge conflict for the next cycle.
