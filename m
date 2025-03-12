Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB203595E;
	Wed, 12 Mar 2025 05:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741755724; cv=none; b=K8iDY6dPxpScEZBd7eEcezZ9VsZp+oWqKo6iwkZ6nLgzyHusMIPfBcTVIsoTLv5+WxpbqAwrrGawuRPEJTzcYgM836dcxlPnIV7C9obJjq4s19GrN9aflc6JxxLxFdlCX6jxG3Qez6JSo9SVmqcL5Ldt99LT0U/14zevFm2Sukg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741755724; c=relaxed/simple;
	bh=bq8xGoNfIm85Y5PQEZeKLy6enCpMHIQM0jHtMjVf+yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyaJhPgPnoHTJjaeaLNWY8djBXdgplaDnpGnzskwHT6UZBLlhITHXrbtWA6M7nCbx/udmRe9BlLjQ9t/R2GkTl2TBPT72eyxtBOImucskRSGwLgDQcC9lgApuW3zoN3xTIHMOSKHTzsQvgLi29irQjLy4OouqA1FbGzs67AoDiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVn4q/sY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVn4q/sY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5825C4CEE3;
	Wed, 12 Mar 2025 05:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741755723;
	bh=bq8xGoNfIm85Y5PQEZeKLy6enCpMHIQM0jHtMjVf+yw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GVn4q/sYV9ylcQQ31hsGpw0eMpmeanMZUqHnpJoQ0wnxN7zdqdU3uOaohnfM4iIcE
	 8AGQQAW9qhI6tbXyb0gu9rG7UsAx8JhOhPx94EaELtYxwfANWlkUC0Nuxqoz12HmJR
	 Jfv/zgE2n6KR6FC5IFc125rbt95brsVtWKwhSNnxAQVSKhbfPP5qvTzO0y5FDRn+Di
	 38Z2RNFDfeIxg45vLKE1OYqQ5ctzgWSuckmG+z+Yr+ZVL0TKFE7v0IeMcO4vuXaxSa
	 RAV48IEdHBEHxlbYte5dofl38JpMVtQiymzPYFQeJ6Gxgu7DfGfyQtRAXn0MH54V4h
	 mstL2vDpLVJxg==
Date: Tue, 11 Mar 2025 22:02:02 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: kernel test robot <oliver.sang@intel.com>,
	Hannes Reinecke <hare@suse.de>, oe-lkp@lists.linux.dev,
	lkp@intel.com, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	John Garry <john.g.garry@oracle.com>, linux-block@vger.kernel.org,
	ltp@lists.linux.it
Subject: Re: [linux-next:master] [block/bdev]  3c20917120:
 BUG:sleeping_function_called_from_invalid_context_at_mm/util.c
Message-ID: <Z9EVSj5SCsoCd6KA@bombadil.infradead.org>
References: <202503101536.27099c77-lkp@intel.com>
 <20250311-testphasen-behelfen-09b950bbecbf@brauner>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311-testphasen-behelfen-09b950bbecbf@brauner>

On Tue, Mar 11, 2025 at 01:10:43PM +0100, Christian Brauner wrote:
> On Mon, Mar 10, 2025 at 03:43:49PM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_mm/util.c" on:
> > 
> > commit: 3c20917120ce61f2a123ca0810293872f4c6b5a4 ("block/bdev: enable large folio support for large logical block sizes")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> Is this also already fixed by:
> 
> commit a64e5a596067 ("bdev: add back PAGE_SIZE block size validation for sb_set_blocksize()")

Or this patch just posted:

https://lkml.kernel.org/r/20250312050028.1784117-1-mcgrof@kernel.org

  Luis
