Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C001DA5F
	for <linux-block@vger.kernel.org>; Mon,  9 Jun 2025 15:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749482654; cv=none; b=SlPdraquKirYvoTSDWlvO0gtDiQr2iyXk79XpHsOrwCLUQra6dxvK4KbvBgqjDE0ADeGl+eBmef66uh1wc0gjm5si7ZSK9FZR4Q8uCGfhR1mfdyQy+chFX8PbI95SEZ78cU7Ew0tGfuBHPeu8bHzks4gpxV5cm/vaCqQs6cfn1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749482654; c=relaxed/simple;
	bh=9d9nuPgWbDuYdWcXLpKn18o7nThv9hi/O2xpuvdHIO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+IhGlAorM0YhMaPolPdk/DSOJO+4tC85MGkS6pRF6NwEem4dyy8bD99egrPemtes7u13tzbTE+LnOz90ePTfu0EUmY2Ru8qHBaOV8OIwppmeWBAgsjVRi/6YYoow1SglTClK+4gFo20dTlMTHyy5LjS92aLptRnxPDxCGU74kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kehUJkRF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kehUJkRF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99A6C4CEEB;
	Mon,  9 Jun 2025 15:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749482654;
	bh=9d9nuPgWbDuYdWcXLpKn18o7nThv9hi/O2xpuvdHIO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kehUJkRFfgr9aSbKBSahKsINjIvFNImaabRF+SuqTLDrBqESBJZ9yV2Sk8ntQO9wG
	 9oaNnQeK/dkD2MM413ckX0RkeaLLRkxCVMPCHYd4dFPYkYpve2QOArq7ZGpZsY5Z+e
	 XGez6vQ12OMuHAYYsqwDRBFEmCowotylYnVIU9jaVi8IJUUPljsM67yf3426x2rVXZ
	 oTky2UQAXLY1/c7IZCorKvoGNI4B0Nbm9STkUf9T7vKefyYtvIiigB/owi8hV6Vcsw
	 GYOvh4277mhGp07wYJSIBlzZcoHvv7HgJ/HgPDsyHiSUoTzhQp8xM5ffkeVuqGijFZ
	 ztKucF93MYqww==
Date: Mon, 9 Jun 2025 09:24:12 -0600
From: Keith Busch <kbusch@kernel.org>
To: Anuj gupta <anuj1072538@gmail.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, shinichiro.kawasaki@wdc.com,
	axboe@kernel.dk
Subject: Re: [PATCH blktests] block tests: nvme metadata passthrough
Message-ID: <aEb8nNl73MFNd1Lu@kbusch-mbp>
References: <20250606003015.3203624-1-kbusch@meta.com>
 <CACzX3AtTwR3dWpYw_jwWKTZziz251cb7xobgF2ta5WL6Kr2uBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACzX3AtTwR3dWpYw_jwWKTZziz251cb7xobgF2ta5WL6Kr2uBQ@mail.gmail.com>

On Fri, Jun 06, 2025 at 07:11:20AM +0530, Anuj gupta wrote:
> Minor nit: should use `.nsid = nsid` instead of hardcoded `1`
> 
> > +       /* This should not be mappable for write commands */
> 
> Maybe reword this to:
> /* This buffer is read-only, so using it for write passthrough should fail */
> -- makes the intent clearer.

Err, I actually got this backwards. PROT_READ means we can write to the
disk from that memory, but we can't read from the disk into it.
