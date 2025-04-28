Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F213E293476
	for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 18:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745863630; cv=none; b=URdFyr+4jCKoVj5TWWlqZHJTN/V8+tuu99rPLc9bDIoxtPmpQFfNfjXCHnp9dDa83k5PFYUUpmJgE8Lo1qQIuC0dP5pduYaraUz9p+K40bRIj5WGVfS9NFz8rGfg/V3DSXRDtMDt/dQwO+/AJM1zUN3CJ0wTUUOWyInMMRkpNNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745863630; c=relaxed/simple;
	bh=IDs8EXNRrh0KUNCoagmyuLf3KhXpQHkIUaNod0yGkRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0aka/ZNerqTZKOGE+LuZCHpLcdN2wEv13G5WjSLceAp0J8hv9uk2njGKSUF5FdaUzfZD9L0jwXdGR8n64UxlOqxFQddxo/axbV4F1yq/EvY4++5nOP4TIilw7wDhG9rnbWawfM3g9an7jby4DHp2mRsLYofAOTPy9g+WpEExVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D487YFly; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D487YFly"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05214C4CEE4;
	Mon, 28 Apr 2025 18:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745863629;
	bh=IDs8EXNRrh0KUNCoagmyuLf3KhXpQHkIUaNod0yGkRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D487YFly0NQQ0J37DORdqoB1uDj5izaX6+VEimyUi+D0CbNr0Ozo8t+yjFMO1IrT+
	 DVNwwLM9s7udEFW0T/ST7flj4z3muRQ7cAHlZ3EMq6eTJUYDznpjERfJsyZVzX8+X9
	 DkrJqMv0mpFdNwLC0ju7Ku9C0VOgnH1cUpcqGEVoevcMTfuUMp2gTieh9lXxsvzEhZ
	 XVAkMB8fxKGl07eIm4HoGviuzOtpATSN1VRBtPiencHZCS222p/PpPd0NmsHsygbRF
	 e4kwjnRrJwyMTaz9w07T90irutjU+G43KEIex8qHLVJH5UeW516YRJnMameZJDFN3K
	 ymZT5YUA+7XjA==
Date: Mon, 28 Apr 2025 12:07:06 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Yu Kuai <yukuai1@huaweicloud.com>,
	linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
	Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH 4/5] brd: split I/O at page boundaries
Message-ID: <aA_Dyp97AIAqJ70G@kbusch-mbp.dhcp.thefacebook.com>
References: <20250428141014.2360063-1-hch@lst.de>
 <20250428141014.2360063-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428141014.2360063-5-hch@lst.de>

On Mon, Apr 28, 2025 at 07:09:50AM -0700, Christoph Hellwig wrote:
> A lot of complexity in brd stems from the fact that it tries to handle
> I/O spanning two backing pages.  Instead limit the size of a single
> bvec iteration so that it never crosses a page boundary and remove all
> the now unneeded code.

Doesn't bio_for_each_segment() already limit bvecs on page boundaries?
You'd need to use bio_for_each_bvec() to get multi-page bvecs.
