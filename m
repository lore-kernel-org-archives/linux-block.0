Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5468C28FA
	for <linux-block@vger.kernel.org>; Sat,  2 Mar 2024 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709388479; cv=none; b=fun3/dWL3hdzHcOwMzvCD8+KFs2MIVxhzclfRyytFvlwIJA5rZ1JPr1i+00PZHLVzLxqQxq75oqzZCcj6AxrQuq2hTM4VmYnCXru+sa37ta5senn/sgAKr8CNN4iCiMDf6WCwfERnPqf+znNzuQsB2qyi67jizlylGM+jm0sPNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709388479; c=relaxed/simple;
	bh=MGablcSSNcxjaclW3i+UnCXFU+W0agGhnh9DZ+5O1FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMIgJDKPTMzka3qRik9NxDz+Iq4UuqhTB0QuDk9HUvJ2yqFLErdIc0f/CeHd+O0V4oW2HxYdDNkdgRxpF5/1aI0iYlH4Zl975D2NuQ+uOlIPv9X/GSe/WSUSxFSqi4prJSCcERlfoXXf9sEnKeGueFmtNxKGzDyZDgv81vpdLAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6361F67373; Sat,  2 Mar 2024 15:07:55 +0100 (CET)
Date: Sat, 2 Mar 2024 15:07:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/3] block: Rename disk_set_zoned()
Message-ID: <20240302140755.GB1319@lst.de>
References: <20240301192639.410183-1-dlemoal@kernel.org> <20240301192639.410183-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301192639.410183-3-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Mar 02, 2024 at 04:26:38AM +0900, Damien Le Moal wrote:
> The disk_set_zoned() function operates on the zoned request queue limit
> of a block device and does not change anything to the gendisk of the
> device. To reflect this behavior and to be consistent with other request
> queue limit setting functions, rename disk_set_zoned() to
> blk_queue_zoned().

Can we just hold this off a bit?  I have the big nvme queue limits series
that removes the zns usage, and early next merge window scsi will be
converted as well and this function will go away entirely.

