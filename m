Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D51613B590
	for <linux-block@vger.kernel.org>; Thu,  9 May 2024 12:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715259542; cv=none; b=fAuQ00O7bJ81Vpq3W3QZdKW9rrEVi7b991mjp4bscVcLfs3sJ/ok4pwmPvBspaT732uxGQeoWUiT24mFbqUvGI8mHbkKrhDBaaQ4+SKYz+U/tlbqesNf3ILplodrjxDZE3SpnuLlBdFURpfuJPnZBFEJiAlhzWBc5UVSwaYKBEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715259542; c=relaxed/simple;
	bh=mIooRyGilQKiiAZbSNY09gQqaPZVuzmLc9AJYwBC2g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6a+oAhuH7Wsv2QvLI13KeaupkXLvlRyQSszxUtroo5Fi1TzgcjxLesc0Y+Th4yDV+b6lbnyInDh2hIFWpjTGqq7q9zrIdPJNvOmLim2H5g3x4UwXMytOCEayWM0iwPVPnIiz+JCCsEhNU4B5mlX5eoQnHD8hUkb3np2N8jw/RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 08A1768BFE; Thu,  9 May 2024 14:58:57 +0200 (CEST)
Date: Thu, 9 May 2024 14:58:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] block: work around sparse in queue_limits_commit_update
Message-ID: <20240509125856.GB12191@lst.de>
References: <20240405085018.243260-1-hch@lst.de> <65a7c6b1-ad4e-4b27-b8b1-44d94a66bf7a@oracle.com> <20240405143856.GA6008@lst.de> <343cc769-b318-4c2d-b08a-0bc752f41f78@oracle.com> <20240405171330.GA16914@lst.de> <293dbd7b-9955-48f4-9eb4-87db1ec9335a@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <293dbd7b-9955-48f4-9eb4-87db1ec9335a@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 09, 2024 at 10:49:29AM +0100, John Garry wrote:
> On 05/04/2024 18:13, Christoph Hellwig wrote:
>> On Fri, Apr 05, 2024 at 05:43:24PM +0100, John Garry wrote:
>>> This actually looks like a kernel issue - that being that the mutex API is
>>> not annotated for lock checking.
>>
>> Oh.  Yeah, that would explain the weird behavior.
>>
>>> I would need to investigate further for any progress in adding that lock
>>> checking to the mutex API, but it did not look promising from that
>>> patchset. For now I suppose you can either:
>>> a. remove current annotation.
>>
>> I can send a patch for that.
>>
>
> A reminder on this one.
>
> I can send a patch if you like.

Yes, please.

Sorry, I expected you to just do that.
