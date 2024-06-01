Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623D91CF8A;
	Sat,  1 Jun 2024 07:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717227534; cv=none; b=NvtovlEGb/H/cmFURW4M7Y8EYlcMhqdXYaBa2qUOEJ8c0anYbfEb2ZBOXUtdO3z04hORDm0b9UuAscUCVHcxciUiAZfoqc3ZgqnTrqjH+nLRLd6/afrSl8xAR08hrw43/ob65ezYUDWWIwiu23hultFg6agIpn/b/11FEaLjK+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717227534; c=relaxed/simple;
	bh=81GRBH+lrxTIuODs8rxSwMPg/JEXNRN4/+g+I2BhgT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiGZdkP9MAHWlM6oFoYcDzUUif5Iy45PvPfmZTVS92ONHz5pJ45B3xMvMUdKc/HHNnsTBSVHyjaq0Cd+Yfo4+mRVwsBa87Q9sBgEU24l43XNcTGwUrXvmpV9qXrsQZAtdBJkih/IbIZrEzuBX4ZSerx9hrY+qge+xf9GKQY1Kh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mF0GPro4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mF0GPro4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Dka3jXUuZ9zCnAwMZuC7qBUE/eEypZOCr5R+gu3ZecQ=; b=mF0GPro4ofayNBAJAWk2bfKjcC
	hFR+MvGLfZQK1U6dpvztoDhhR2NC2JYaVi8SbFQgzBomtvZol40/heJelh78o4FWYMR89fyFoZD/O
	OeLgem+cSb+hM7xzLMeQvlWJFtoJDWc0CFyEzR0QhDX2sSJxcsitP6gz3Swp8+Z9KNjozgHYdDc+8
	2tyvzy1Z5XmzUY/I1VqFg7GyiV/Jm7xMcwFkGj0zhq/vZh7vJ/Zzhcu3Qkj1HUr7SfjEdCFvu2OLF
	BB5SKCv+vCHbcz+s6vVlJmyLOu8NG3zgdl3D4iTJTWHqVKUHghP0wHF3/mJWbNfXaNM/7yL0mOz1g
	WOS2Kpmg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDJKD-0000000CAbt-0kbJ;
	Sat, 01 Jun 2024 07:38:49 +0000
Date: Sat, 1 Jun 2024 00:38:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: hexue <xue01.he@samsung.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Avoid polling configuration errors
Message-ID: <ZlrQCaR6xEaghWdQ@infradead.org>
References: <CGME20240531091021epcas5p48fdbd6302bec7a91ff66272c600b0dab@epcas5p4.samsung.com>
 <20240531091015.2636025-1-xue01.he@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531091015.2636025-1-xue01.he@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, May 31, 2024 at 05:10:15PM +0800, hexue wrote:
> Here's a misconfigured if application is doing polled IO
> for devices that don't have a poll queue, the process will
> continue to do syscall between user space and kernel space,
> as in normal poll IO, CPU utilization will be 100%. IO actually
> arrives through interruption.
> 
> This patch returns a signal that does not support the operation
> when the underlying device does not have a poll queue, avoiding
> performance and CPU simultaneous loss.

This feels like the wrong place to check for this.

As we've dropped synchronous polling we now only support
thead based polling, right now only through io_uring.

So we need to ensure REQ_POLLED doesn't even get set for any
other I/O.

