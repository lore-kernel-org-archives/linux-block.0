Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25171244196;
	Tue, 20 May 2025 13:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749428; cv=none; b=tPNrxFNmWSR9OjRNIt6H0ZOvVboGRS01K7FvRhXtnB+KSRnvtmjPoRmej/TSRy1BIWXt1LfTfhOhQSmz6KuR+CX1Q+kPLz96bhDNCB1MiJNly8lTX2l9AEY0CWm5rdNMALsO2Glst8BTjU8cuPSdRnpCdK5O+kEobPz3vuOCdoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749428; c=relaxed/simple;
	bh=pdjJ/NxUbJ5hDP9KspHPLRBvYNYqLh1hPHqIzp/jJb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJ/iVCCEXDsNSGkkD75+PZmyghDjIhjXC/1yKOtkHllFvyDkJZWZvb5yjA+AceqoruAJ8TzXSW2aw+F5I9tNGv1NmSL8w7mB4VHR1yyWcdsDhHxhmxSKFVIy209EKHAlf15pQ2PxUPIdBeD2yiwO2kckZsHDrQLHYnf2V6FiHng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4DE3C68D17; Tue, 20 May 2025 15:57:03 +0200 (CEST)
Date: Tue, 20 May 2025 15:57:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Yu Kuai <yukuai1@huaweicloud.com>, Ming Lei <ming.lei@redhat.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] block: Fix a deadlock related freezing zoned
 storage devices
Message-ID: <20250520135702.GB8472@lst.de>
References: <20250514202937.2058598-1-bvanassche@acm.org> <20250514202937.2058598-3-bvanassche@acm.org> <20250516045124.GB12964@lst.de> <77b43f78-916d-4b28-85dc-3ed5c36abfed@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77b43f78-916d-4b28-85dc-3ed5c36abfed@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 19, 2025 at 03:22:42PM -0700, Bart Van Assche wrote:
> Hmm ... my understanding is that BIO_ZONE_WRITE_PLUGGING, if set, must
> remain set until the bio has completed. Here is an example of code in
> the bio completion path that tests this flag:

True.  Well, we'll need some other flag that to tell lower levels to
ignore the flag because it is owned by the higher level.

