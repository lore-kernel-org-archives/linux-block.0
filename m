Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749D0226541
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 02:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751943421; cv=none; b=LGgj/vRUTa8Q8Aefxr0tfq5lJi2xHsV8lNbs58yJLW4/A/V6PweyN7SAI93RTNOJW+ryvyJLy8pavLViTg0CUBpc8vLOxYC3sisLaaH+cLpbT7vpCVL3mlGRoSvSMibWiKleOP70L37iByk9+QBDThDK7TftlVBP5F/BrV0+d/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751943421; c=relaxed/simple;
	bh=GF2p/3SsYrU7VfaSh41ZXuJEuxpj16pbcMv4p6eATNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1d1FroSyJZVzkNbOgCpIe8p2SR8vXAaVRI+ylzpXqvRKdT8T2JoGT7f/23RCplKT+sEE7sROWcL4m5olWMw5/noGjggJKVJxPLs7//B2T92H2YSwLJAqZN5/U2BMkEzXlyNVZcZ3XY+ocqBU7fOQVd4z/H6dRrSCbhf/kTjaic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kt883RtI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kt883RtI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBA0C4CEF4;
	Tue,  8 Jul 2025 02:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751943421;
	bh=GF2p/3SsYrU7VfaSh41ZXuJEuxpj16pbcMv4p6eATNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kt883RtIgUw94xyrj9dmcHljyXWVvR6rRJFX8JuKZNp6O3TZcQEDlqhrv49T/uA22
	 g+XqVaPLB/pTXszyxEKMGTmLRon4Fu+6w+YlX4nYrViASoVD0TVI3zT+ORrkx46BB1
	 nQ+1L0w9+isZphgaoGrZVDZsjksMJLwTQNS8IgniCJpghqKm4sEKOKCrniNc1mLfis
	 fPHKJizlgXWi/Hj9ziVq1cCh8BfZPcVQnx2Aoq6Zit2nHIqXAo0dlSid/rQ2beTaY9
	 mrlChqz+jkeOGTF1kYCUkVQarOrJswJqIDWK9DlXq1xVg+mY8O3g+Sx7kVxbtl0InP
	 YtnbCDZ7eVDBg==
Date: Mon, 7 Jul 2025 20:56:58 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: What should we do about the nvme atomics mess?
Message-ID: <aGyI-sl68Y0klsJn@kbusch-mbp>
References: <20250707141834.GA30198@lst.de>
 <aGxz6s9oUp2FkbyX@fedora>
 <aGyCH8TOQgVY3AP9@kbusch-mbp>
 <aGyGboLwcn2cXoRo@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGyGboLwcn2cXoRo@fedora>

On Tue, Jul 08, 2025 at 10:46:06AM +0800, Ming Lei wrote:
> On Mon, Jul 07, 2025 at 08:27:43PM -0600, Keith Busch wrote:
> > On Tue, Jul 08, 2025 at 09:27:06AM +0800, Ming Lei wrote:
> > > On Mon, Jul 07, 2025 at 04:18:34PM +0200, Christoph Hellwig wrote:
> > > > Hi all,
> > > > 
> > > > I'm a bit lost on what to do about the sad state of NVMe atomic writes.
> > > > 
> > > > As a short reminder the main issues are:
> > > > 
> > > >  1) there is no flag on a command to request atomic (aka non-torn)
> > > >     behavior, instead writes adhering to the atomicy requirements will
> > > >     never be torn, and writes not adhering them can be torn any time.
> > > >     This differs from SCSI where atomic writes have to be be explicitly
> > > >     requested and fail when they can't be satisfied
> > > >  2) the original way to indicate the main atomicy limit is the AWUPF
> > > >     field, which is in Identify Controller, but specified in logical
> > > >     blocks which only exist at a namespace layer.  This a) lead to
> > > 
> > > If controller-wide AWUPF is a must property, the length has to be aligned
> > > with block size.
> > 
> > What block size? The controller doesn't have one. Block sizes are
> 
> It should be any NS format's block size.

That requires an artificial reduction to a meaningless value.

> > properties of namespaces, not controllers or subsystems. If you have 10
> > namespaces with 10 different block formats, what does AUWPF mean? If the
> > controller must report something, the only rational thing it could
> > declare is reduced to the greatest common denominator, which is out of
> > sync with the true value reported in the appropriately scoped NAUWPF
> > value.
> 
> Yes, please see the words I quoted from NVMe spec, also `6.4 Atomic Operations`
> mentioned: `NAWUPF >= AWUPF`.

The problem is when Namespace X changes its format that then alters
Namesace Y's reported atomic size. That's unacceptable for any
filesystem utilizing this feature.
