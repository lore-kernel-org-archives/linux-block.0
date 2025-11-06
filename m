Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8927030F7F1
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 11:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762430026; cv=none; b=XdBGxbOUNHX4a4qqpTX6ZIXop4qoWCLrtef9RZyfqR2hvLtqnA+J7sRDqZhR/GsPDiqQh7MqUQaf7TaeFrik0wEXS1NuXt8Kfh1bhjJ9gtqCWLeR/8dyKh/161uiN/IB098NktQ8YcWkJONj7+k9sizbHSMidbkEYH0jlEc+a7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762430026; c=relaxed/simple;
	bh=WXHw+atwif7O1sbD3mEp/y5fFTnJY2Gm49JEo7GVmEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AV+8YMt8a/4htI/Y827D9tAEzEeRcSDtMAE5r+HaHSJmbY0cT8vtcGGq81Sr5m0arPBkLoiVbTXDmYaUIcaU33wrYVH38P6FzjhPUdeCSkM3SYFRDQlBZRyU1xpU1oCY5iONJgS2HSakEEbd7QyCFyxkFnHxIsDa6rrBtztlRZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E7C38227A87; Thu,  6 Nov 2025 12:53:41 +0100 (CET)
Date: Thu, 6 Nov 2025 12:53:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
	dlemoal@kernel.org, hans.holmberg@wdc.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 3/4] null_blk: single kmap per bio segment
Message-ID: <20251106115341.GC2002@lst.de>
References: <20251106015447.1372926-1-kbusch@meta.com> <20251106015447.1372926-4-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106015447.1372926-4-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 05, 2025 at 05:54:46PM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Rather than kmap the the request bio segment for each sector, do
> the mapping just once.

This looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Although I'd still prefer to pass the bvec down as far as possible..

