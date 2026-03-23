Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C592836A0
	for <linux-block@vger.kernel.org>; Mon, 23 Mar 2026 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285930; cv=none; b=iCDEfUnuQjvYXQuAhAg0Oijblx5oyBEKuYgNFHmoGkSydJHSlsir4NRCoAHqC5G0buflSWKLydbPfMY8Pi6w1IUGGTJCLP0271/ldvEeV1e3Xv90L2U2fXlBp1gCCvcqAzlYtuahedn0V6S8hPH9J9GTnVcQAtDJWAVjvTn0c0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285930; c=relaxed/simple;
	bh=+WFQGBWAvq0cahwVJ+WO4+6n8lsUR5Sp6T6wG7S8/WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfDPV8wXTGuBzz0FjQXwSOEYBAJ/jPrAQ+KstPPdpxHM6Qalwms7HipqPDWljfVFHoMOTrp3zVZf+0mql5YQYdevBC+F9dGTt566tFk6Fh8P1ggVO/EHW1m1Ht1ZsxUaHZI91utzIK30vQXjaqs0INTdMcw2rHM9VAaUQymwgZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZHiA51B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZHiA51B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00AFCC4CEF7;
	Mon, 23 Mar 2026 17:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774285930;
	bh=+WFQGBWAvq0cahwVJ+WO4+6n8lsUR5Sp6T6wG7S8/WA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AZHiA51Bi68dRjr+QThIMrGNCiiLWMPm0B38zomTlJ5rtQOKCkE1JlDtbZ6hIQ7OU
	 scE7DX0Gq4WubItTyiCRyobLweTVB/Ja+dV2xHhJHxvOKdodT5soqa6G5GSzvxgIP9
	 Pz3zVV064glaYwgKDNP0kP1ZjKd5plmoHrXTXd++ViL+xlEFwZFYlJa1hJldzPzwO9
	 EYMUpfrlfOOW6FSswZR4hZywPzzOVzmaVkSlTf3dbWncyPNunIerIm/V4hp6pkc1SY
	 4NoZ7a9mYnacfTXcoy12U2GuTRNMPpFZ3QQoc7SmlbE7Q8+0yVOMYfrwkPjuVTqLYk
	 0lHwTVRwqFYSg==
Date: Mon, 23 Mar 2026 11:12:08 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-nvme@lists-infradead.org, linux-block@vger.kernel.org,
	Keith Busch <kbusch@meta.com>, hch@lst.de,
	martin.petersen@oracle.com, csander@purestorage.com
Subject: Re: [PATCHv8 0/2] block for-7.1/integrity rebase for mem alignment
Message-ID: <acF0aJa-GXGYPqS0@kbusch-mbp>
References: <20260313144701.1221652-1-kbusch@meta.com>
 <177349768999.37164.10048861817413145882.b4-ty@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177349768999.37164.10048861817413145882.b4-ty@kernel.dk>

On Sat, Mar 14, 2026 at 08:14:49AM -0600, Jens Axboe wrote:
> On Fri, 13 Mar 2026 07:46:59 -0700, Keith Busch wrote:
> > This is the rebased version of the flexible t10 alignment feature on top
> > of block's for-7.1/block-integrity branch to apply atop Christoph's
> > fs-integrity:
> > 
> >   https://lore.kernel.org/linux-block/20260223132021.292832-1-hch@lst.de/
> > 
> > The only change from the previous version is to incorporate the function
> > name changes and verify's status code return type that were introduced
> > in the file system integrity support patch set.
> > 
> > [...]
> 
> Applied, thanks!

Did you forget to 'git push' this branch?
