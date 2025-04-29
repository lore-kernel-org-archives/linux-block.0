Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6DA214A9E
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 21:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745961459; cv=none; b=RSlgI+THYsWg9GKE765roW38LkoVitFEYWBI5jPTHt1pbE9TsoeEUF08MChhp3wZDtJf0dacnAN+utHbJ/5lqlbiwyjHg53YxrqNCKwieX7fpg7pcaotEpdau0TCoeM5wqQW7rjjHuFQqMMtawu9L21wdJRNXL3Q86D81rDFWS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745961459; c=relaxed/simple;
	bh=ILyIraECtaz9moYPMp4r0hYSNQ987m8GrztYryJuwbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7XXBb0fif3xAdsDLu/N1P1LPGoJ7C75hvRZhuuDawhFEAPvxCsXZH7bBHzE9kCcjGYUiebvNwXmsI5D+KbcjoVihEU3DUJTY6Gkgohefyj7CS6aIct2x05ELdF3Q7D5HLL1tEyS5AyMkPfCp3ILKGMTiDZ7+heU/cRNEk+bGlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dnhqm6NA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dnhqm6NA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8768EC4CEE3;
	Tue, 29 Apr 2025 21:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745961458;
	bh=ILyIraECtaz9moYPMp4r0hYSNQ987m8GrztYryJuwbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dnhqm6NA0Lv/pMFLvgnebr5Wlei31wY7iwH0uBp81dwR4tE28Sw4YTstL5NpAhZTr
	 uU3Or0hTZ3TD1skNrFAGpzrCX9dol6yT9wWWzW2WZjE4MKiwV+AP66hEHPO5exGECf
	 0Ont5X04CBEb0z38TNsHrNI1SOkqNK1Ts4bV2HDvG0PldHGp1eOWHdFB8f058m0lbF
	 nNceHxCQPaCsVhhOSiEPJt3aWMQnSJwpz+h2Zuo7IPVi0MnSqsuVjiWdiO40cXW3/+
	 5LzmTc0FQv99V+dwg6Lwd22uh0gBo5qL4HC88RaOBXV/OfvB6sTGZFixzDSrZc0a83
	 n71bqGVudH2Ew==
Date: Tue, 29 Apr 2025 14:17:36 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 4/5] brd: split I/O at page boundaries
Message-ID: <aBFB8JDESV1V4epi@kbusch-mbp>
References: <20250428141014.2360063-1-hch@lst.de>
 <20250428141014.2360063-5-hch@lst.de>
 <aA_Dyp97AIAqJ70G@kbusch-mbp.dhcp.thefacebook.com>
 <221bce43-83b7-b5ac-c6d2-ded23158dd06@huaweicloud.com>
 <20250429121529.GB12411@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250429121529.GB12411@lst.de>

On Tue, Apr 29, 2025 at 02:15:29PM +0200, Christoph Hellwig wrote:
> On Tue, Apr 29, 2025 at 09:38:28AM +0800, Yu Kuai wrote:
> > Hi,
> >
> > 在 2025/04/29 2:07, Keith Busch 写道:
> >> On Mon, Apr 28, 2025 at 07:09:50AM -0700, Christoph Hellwig wrote:
> >>> A lot of complexity in brd stems from the fact that it tries to handle
> >>> I/O spanning two backing pages.  Instead limit the size of a single
> >>> bvec iteration so that it never crosses a page boundary and remove all
> >>> the now unneeded code.
> >>
> >> Doesn't bio_for_each_segment() already limit bvecs on page boundaries?
> >> You'd need to use bio_for_each_bvec() to get multi-page bvecs.
> >
> > I think it only limit bvecs on page boundaries on the issue side, not
> > disk side.
> >
> > For example, if user issue an IO (2k + 4k), will bio_for_each_segment()
> > split this IO into (2k + 2k) and (4k + 2k), I do not test yet, but I
> > think the answer is no.
> 
> Exactly.  I got this wrong with zram, where it only triggers with larger
> than 4k page sizes, and I got this wrong here on my first attempt as
> well.  Fortunately testing found it quickly.  I thought the comment and
> commit message document the issue well enough, but I'm open to better
> wording.

Ah, it just clicked for me that you're talking about the pages returned
from brd_lookup_page (the "backing pages", as you said), not the bio's
pages. Sorry about that.
