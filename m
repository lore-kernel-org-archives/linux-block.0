Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665387482
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 03:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747884188; cv=none; b=q6wHJKc/J75WeU2fhFWvpgdKAOyyaK9MGUsO75pgf9VT/YsPiI9t5aimuolsUe8wl/qqVz58tuvSA1w0fefV9tE1PqhHKl+YWquiknJYOmmSaMssBqGeIVg2G5VhLcFrfeTOrKnRmU/973WurPcDsR5tLADU7Vr88IgpneU4QXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747884188; c=relaxed/simple;
	bh=xjiq96K+EGXPUCIFWD0YKWKp6Qr5/yTBd6+lgSgqjY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ia7R6MFsYgl9kXauul4szyugukFYJdjbTs7cGf+j2XT8IMYIo1o45Uh8vMGxa9k673exnLtffbz+yJHBomyDT9LcLRSjmv/rMIEebzimzEz/vntNZmFrUKr2Z9PqaV4aEiX8OWedq8qVO0BUs63fn4+YIqC5VYKtIEG7p613IH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Joilb8Tp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Joilb8Tp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74DB3C4CEE4;
	Thu, 22 May 2025 03:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747884187;
	bh=xjiq96K+EGXPUCIFWD0YKWKp6Qr5/yTBd6+lgSgqjY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Joilb8TpynjwOou9/z3+2xzNJ3pg8tcbL8tjQXi2tKXMQo+h+vOsNItEuYVSKsIsE
	 7NQRhRk7oQl+BGHbjy4JKhImqZOO/yrJvg2upIwlOv0nkx8Vz5BfDB59ijSH2Gu4Fr
	 mV2biU50SLJRsCOH4utfW34ipgDUHXgs21eIFBkYXe5nQ7em5jqU8gnEQzb8TfO9Zt
	 jKKmPHx4JPvYgXbrgAcae9IckF9DPRfvtYr5hQ0WIxn9yP0aTWIQT+RrIDkuFmJcXU
	 b/WDGyeP3JGF2qnKuHhDJJuM/hrm8RdSDye0VLBkmXuzxx7Q5Xlt3IH9fKagQoMUh7
	 yv0+eFRCITuqQ==
Date: Wed, 21 May 2025 21:23:05 -0600
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/5] nvme: add support for copy offload
Message-ID: <aC6Ymfrn1cZablbE@kbusch-mbp>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-4-kbusch@meta.com>
 <CADUfDZqVeaR=15drRFvdrgGyFhyQ=FtscaZycVrQ0pd-PGei=A@mail.gmail.com>
 <CADUfDZqC0kiLTDFv3kXNaDr25rb+6RGG3cW3r=mox2vdihpsow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZqC0kiLTDFv3kXNaDr25rb+6RGG3cW3r=mox2vdihpsow@mail.gmail.com>

On Wed, May 21, 2025 at 05:51:03PM -0700, Caleb Sander Mateos wrote:
> On Wed, May 21, 2025 at 5:47 PM Caleb Sander Mateos
> >
> > alloc_size should be sizeof(*range) * i? Otherwise this exceeds the
> > amount of data used by the Copy command, which not all controllers
> > support (see bit LLDTS of SGLS in the Identify Controller data
> > structure). We have seen the same behavior with Dataset Management
> > (always specifying 4 KB of data), which also passes the maximum size
> > of the allocation to bvec_set_virt().
> 
> I see that was added in commit 530436c45ef2e ("nvme: Discard
> workaround for non-conformant devices"). I would rather wait for
> evidence of non-conformant devices supporting Copy before implementing
> the same spec-noncompliant workaround. It could be a quirk if
> necessary.

Right, that's exactly why I didn't bother allocating tighter to what the
command actually needs. The number of devices that would have needed a
DSM quirk for the full 4k was untenable, so making the quirk behavior
the default was a sane compromise. I suppose Copy is a more enterprisey
feature in comparison, so maybe we can count on devices doing dma
correctly?
