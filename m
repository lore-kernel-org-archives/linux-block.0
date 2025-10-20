Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4882323D7CA
	for <linux-block@vger.kernel.org>; Mon, 20 Oct 2025 21:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760994232; cv=none; b=F1VUwqx8ryNZEDtSI+ZsvXw50RyqFLBFhwrQfPetGeT6ul0rnBrjD1I3HPJgN4PU1suVNyt0TQSeJVvlRGcMURIejFVGZmyAJY4u7wFD8OS+Gc9vhtjKDHJZLy3KtrXfGZun+j8U90xnZQLYJM+2Yjb6fIkRZRjWIwBvuVWOUvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760994232; c=relaxed/simple;
	bh=sSUSHFyCSGkpBG6TypnDwdl2FVVYZVMKlCaaOSG7kUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syawoxHiUcmIuiF1XtF0NjDSJ1FoIKcGSfYgXP6d6I7YwdwhH75W8GLPhGBl/i22yvHv/b5pG7cqxkDabQnSZIlFTSdE9ApGi9uD9mQsq940Ld/QXD9mnw9/xW/nm74u36s7iKXfU+hALJw+mt0MsHh05kS3qIQRErWUBiUTnls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0RhBN1E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0RhBN1E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B91DC113D0;
	Mon, 20 Oct 2025 21:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760994230;
	bh=sSUSHFyCSGkpBG6TypnDwdl2FVVYZVMKlCaaOSG7kUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k0RhBN1EOEeTXP72iqtmrHQ562KA6jlPPKugtv8GrVGDArsiCPh4+7sNDHWTp3kqd
	 TMAXyK2ost+t94isun23We4Ef9u3cM7Ej4axtSSsamghPSpydGYfB3/cAxC93UQ4JD
	 iBijM50ZNyAOOXd70oRig8QlVlb38H+a+jP1e/AJkCvJFwkGC3Bc5B8OmQF+VtURDb
	 7cpeg7KjvlQKW1yUIwgE7SJNiob1Uq1jpANrrtCKxAthR+e90C9/yjBU4/V6a0pESH
	 sROfWSCQCEvuoxS3FqBx7ba8CcqCcVmRX8AdUtoWxwkl7bHBmF4SZrN53Uxpv64138
	 pnmzGZ1kAsj0w==
Date: Mon, 20 Oct 2025 15:03:48 -0600
From: Keith Busch <kbusch@kernel.org>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Keith Busch <kbusch@meta.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] create a test for direct io offsets
Message-ID: <aPajtDhrfncyZHPq@kbusch-mbp>
References: <20251014205420.941424-1-kbusch@meta.com>
 <bihyeax4gcwr3ayy64bkdaccnjuyv6gp5fz6wxgnmwuhjy6be5@rxakhphw5445>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bihyeax4gcwr3ayy64bkdaccnjuyv6gp5fz6wxgnmwuhjy6be5@rxakhphw5445>

On Mon, Oct 20, 2025 at 12:40:07PM +0000, Shinichiro Kawasaki wrote:
> > +static void test_full_size_aligned()
> > +{
> > +	int ret;
> > +
> > +	memset(in_buf, 0, buf_size);
> > +	ret = pwrite(test_fd, out_buf, buf_size, 0);
> 
> As I noted before, when I tried with QEMU SAS drive, the buf_size is large
> (192MiB) and pwrite returned the value smaller than that (128MiB). This
> caused the compare() failure below. How about to check the return values
> from pwrite() and pread(), and pass it to compare()?

Oh, short writes are not expected. I should check that the actual
written matched the requested total. I wonder why it's bailing out part
way through, though.

> > +        if (ret < 0) {
> > +		if (should_fail)
> > +			return;
> > +		err(errno, "%s: failed to write buf", __func__);
> 
> When I ran the test with QEMU SATA drive, it failed here. The drive
> had virt_boundary=1. I'm not sure if it means test side bug or kernel side bug.

Hm, I tested QEMU's AHCI and that seems okay. Is that what you're using
to attach the "SATA" drive? I'd like to recreate this and figure out
what's going on here.

If this test says virt_boundary is 1 for your device, that should mean
there is no virtual bounday to consider; this test should succeed with
those reported queue limits.
