Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059388472
	for <linux-block@vger.kernel.org>; Mon, 28 Oct 2024 09:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730107232; cv=none; b=LZk7bEhkxV1Iab4x3wDu+RIMs39BQa6dQeXovYFzjbye6k5H4cRNnWZa+jS9qWfw+Uoi4PrKNXHR9g5txY/ybWBpJWn5YU/e1H5W8gHJIgKZpcOFuXhKPw2bZ+EtTAzXXOpCB9/uhvIJVtwHdSHKn4S5oWQABCe7MyHjyjwsH34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730107232; c=relaxed/simple;
	bh=JRYb/71MJJpHgk6sXcg2oFVZj8mOjqrxnGk/vDt2IOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/vINWmRtooIkY+6+m32aIeRyOgNaT3MEYLO66aQfBbjhXOvwup7umaeqNYxDR9cNOvTGwf6T3awxFNlpZUjctJmGfTgPqDqXZJvrvFOICa7hey//44IZQHr/7xNlyMwR1uXt1gbkTMBrF7eJo/ai8Lt1TCLmzCv9jsNS9gu23g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2738068BEB; Mon, 28 Oct 2024 10:20:28 +0100 (CET)
Date: Mon, 28 Oct 2024 10:20:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	ushankar@purestorage.com, xizhang@purestorage.com,
	joshi.k@samsung.com, anuj20.g@samsung.com,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] block: fix queue limits checks in blk_rq_map_user_bvec
 for real
Message-ID: <20241028092027.GA29592@lst.de>
References: <20241025115818.54976-1-hch@lst.de> <3ba278c0-041e-4b07-91c5-c7bdf4bff8a8@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ba278c0-041e-4b07-91c5-c7bdf4bff8a8@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Oct 25, 2024 at 09:43:04PM +0100, John Garry wrote:
> On 25/10/2024 12:58, Christoph Hellwig wrote:
>>   +	/* check that the data layout matches the hardware restrictions */
>> +	ret = bio_split_rw_at(bio, lim, &nsegs, lim->max_hw_sectors);
>
> eh, but doesn't bio_split_rw_at() accept bytes (and not a value in sectors) 
> for max size?

Yes.  Thanks for the careful review, I've sent out a new version.

(and this really helped me finding a bug I had been debugging in
another user of this helper :))
