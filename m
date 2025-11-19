Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242F636E55D
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568657; cv=none; b=jBXHjwn5uN0EsKBFKy/85feUa5EM0OmLKsI2vLcvMfVABH0swbc3E5bVAHz/0Ghq1U8nWdNHhfyLANpCSX2yfbHGMPjJ4FyaNLoPHcHB2G4d68yE9ZQWYO945mjX5gXQKiqjQEVUmgUHHaW3gaZ5J7hyGFzZawJDXt3IbCtUhd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568657; c=relaxed/simple;
	bh=mpEqQATjyzm6JcStmaJB/8x6GExCbWLtyPieD7xK6TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNDlXFQ6DkXShzRx+FUfWvADRb1HvKN+FQa9eDUjUMjQBQQyOm/OusIstEJlwX19Yg2+7Eb9pzIB4B4dvxEuSXQL0cuJ1NCksj2atqsvJ8c4XcHMgivKE4Sa7bKAJUmYF7IMzY0ADgnw8CylykjcRBCBl0jPUnU/JkRiCIW8s8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrE3+e9B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrE3+e9B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77199C4CEF5;
	Wed, 19 Nov 2025 16:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763568656;
	bh=mpEqQATjyzm6JcStmaJB/8x6GExCbWLtyPieD7xK6TE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lrE3+e9BSmU6CvTk1EdqxBbtk9osmojeqOB7oiXrSeRfxZDIASNVA0N0bpsYNVr0L
	 DnkQTRiaTgePCrAx6Rs1246MkHCxtZjEaJukQM9aRBReIfuP7k6BBfafBb73jWjglL
	 sFhjmpxvAwGWuP1TMOl5T3SEaCdyLX+pSaIPDHuJNHogC0sCcfw03M4j9V8U6xQJ2Y
	 r4DZBXjI1WpTah0Prhx+MUHc6nd0iHHS69KjDQaVnFhNRwLg+loMBpkWEZIrje6fWb
	 B4iVVynIietNmasEsOSXFrHPEyup9fwixqqfR0KvxbQ2f46GEXR2+8qYbtK3egRA+P
	 LGCNb01Q344lw==
Date: Wed, 19 Nov 2025 09:10:54 -0700
From: Keith Busch <kbusch@kernel.org>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Keith Busch <kbusch@meta.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	hch <hch@lst.de>
Subject: Re: [PATCH blktests] io_uring user metadata offset test
Message-ID: <aR3sDqWvstDofSs7@kbusch-mbp>
References: <20251107231836.1280881-1-kbusch@meta.com>
 <2gns47qyscyfz6bmcnfjmb5p5zgujpsxpsqwip46aktgfldizn@cqs5h6ugcvsx>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2gns47qyscyfz6bmcnfjmb5p5zgujpsxpsqwip46aktgfldizn@cqs5h6ugcvsx>

On Tue, Nov 11, 2025 at 07:58:30AM +0000, Shinichiro Kawasaki wrote:
> On Nov 07, 2025 / 15:18, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > For devices with metadata, tests various userspace offsets with
> > io_uring capabilities. If the metadata is formatted with ref tag
> > protection information, test various seed offsets as well.
> > 
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> 
> Keith, thanks for this patch. Looks important.
> 
> Just for curiousity, is there any condition to make this test case fail? I ran
> the test case with v6.18-rc5 kernel and QEMU NVME device (mi=8), then it
> passed. Do we need specific hardware to make it fail?
> 
>    If this test case just extends test coverage and no failure is expected at
>    this point, I think it is still useful.

It's not supposed to fail for any format. The test queries the
capabilities of the device and reacts accordingly. This test will send
various alignments and lengths that span page boundaries, and the kernel
will use it directly if the hardware supports that, or bounce it if not.

> This patch added the test case block/043, skipping block/042. You posted the
> patch for block/042 last month [1], and it is not yet settled on the blktests
> master branch. Do you have plan to respin it? If so, I think this block/043 can
> be applied before the block/042 patch get applied. Otherwise, I will try to find
> out my time to improve your block/042 patch and settle.

Yes, I'm working on a respin for 042 right now.
