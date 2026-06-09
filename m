Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEC734751E;
	Tue,  9 Jun 2026 07:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991008; cv=none; b=cRjB1OJ/xXtjItBR1aRlBL3KtcMT+991DNOx6/e2dw3YX0qmD9C46aee/P0eyeIHIhaCkhwrOgDBzhRh7tOsRjXT75etJSkZ6QozxL6UpUA3absFhfCpXC18RQ9lJjBcN2qcIbuuw6fJhz6skQ+x80fK4/SDOWkThONgbjkXjkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991008; c=relaxed/simple;
	bh=b7Xhfwr8BIMeIpIF1Kl2vLRhU3A2mG576R24QvH6Zo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGi2ByQ1ASaOaKZdWYycEbi2f8+Eoz44Tl5PMZNDXZ/29usaTC99OTAy2zldl7LJrdR73gpA/pCrueNVGIumcq2eHMGpmIElg5pNZTfRvxN1kzBwYT2hw2Pq3gZEq4lRhWqTaoSxWjnts5KEhmpCmr046DVDCuXP65yJ3slg06E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D0A6E68B05; Tue,  9 Jun 2026 09:43:22 +0200 (CEST)
Date: Tue, 9 Jun 2026 09:43:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>,
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH 2/4] block: add a "tag" for block status codes
Message-ID: <20260609074322.GC6877@lst.de>
References: <20260608051416.1205282-1-hch@lst.de> <20260608051416.1205282-3-hch@lst.de> <f4c0895b-4758-4eb1-9c3a-38cda0db50d2@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4c0895b-4758-4eb1-9c3a-38cda0db50d2@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 08, 2026 at 02:55:20PM -0700, Bart Van Assche wrote:
> On 6/7/26 10:14 PM, Christoph Hellwig wrote:
>> +const char *blk_status_to_tag(blk_status_t status)
>> +{
>> +	int idx = (__force int)status;
>> +
>> +	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(blk_errors)))
>> +		return "<null>";
>> +	return blk_errors[idx].tag;
>> +}
>
> Since designated initializers are used to initialize blk_errors[], it's
> probably a good idea to check the value of blk_errors[idx].tag, e.g. as
> follows:
>
> return blk_errors[idx].tag ?: "<null>";

I'd go for the good old and readable if statement, but yes, I can add
extra error checking here.

