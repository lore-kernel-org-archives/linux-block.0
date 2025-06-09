Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638FB1F19A
	for <linux-block@vger.kernel.org>; Mon,  9 Jun 2025 04:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749441635; cv=none; b=modiYR0oAXkCzMntrL8jCVtAnw5NaPO+cjqzM7A95yYXaYaO2ysigDopg4N+Awb+x2XAW62rd/3NW8ilV4xGq8jYKFQ8tqq/LRABdksD4iRSBXmGd7Y3VkyjK0HlZvbwbvdsd2RnUEv87oBvyoGmzEZ750eKTqG9GXSRzVgbQos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749441635; c=relaxed/simple;
	bh=uc60Q85eHJWMuMjeeDugJatmZhqHLyLVKoHAywaZ9Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyr/4NOoo9v+DtDc+f8oI9qp37JFsi6n7VHMAovu8547SxlJfeqapOvlPN5KFcebwbmZanVDmBCIXhvIwBo+KcFJ70H6o/9gtSCwlKdkcqXBXYLF9QDBVRZMwx9ldJtLqTm86E26WDy8pHjW+iwFi+Og9ZpUnl9nPpRCXx58U6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 52B4468AFE; Mon,  9 Jun 2025 05:55:15 +0200 (CEST)
Date: Mon, 9 Jun 2025 05:55:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yu Kuai <yukuai1@huaweicloud.com>, Ming Lei <ming.lei@redhat.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH 1/2] block: Make __submit_bio_noacct() preserve the bio
 submission order
Message-ID: <20250609035515.GA26025@lst.de>
References: <20250520135624.GA8472@lst.de> <d28b6138-7618-4092-8e05-66be2625ecd9@acm.org> <20250521055319.GA3109@lst.de> <24b5163c-1fc2-47a6-9dc7-2ba85d1b1f97@acm.org> <b130e8f0-aaf1-47c4-b35d-a0e5c8e85474@kernel.org> <4c66936f-673a-4ee6-a6aa-84c29a5cd620@acm.org> <e782f4f7-0215-4a6a-a5b5-65198680d9e6@kernel.org> <907cf988-372c-4535-a4a8-f68011b277a3@acm.org> <20250526052434.GA11639@lst.de> <a8a714c7-de3d-4cc9-8c23-38b8dc06f5bb@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8a714c7-de3d-4cc9-8c23-38b8dc06f5bb@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Jun 08, 2025 at 03:07:30PM -0700, Bart Van Assche wrote:
> On 5/25/25 10:24 PM, Christoph Hellwig wrote:
>> Umm, Bart I really expected better from you.  You're ducking around
>> providing a reproducer for over a week and waste multiple peoples
>> time to tell us the only reproducer is your out of tree thingy
>> reject upstream before?  That's not really how Linux developement
>> works.
>
> A reproducer for the blktests framework is available below. It took me
> more time than I had expected to come up with a reproducer because I was
> initially looking in the wrong direction (device mapper). As one can
> see, the reproducer below does not involve any device mapper driver.
>
> Do you plan to work on a fix or do you perhaps expect me to do this?

The problem here is that blk_crypto_fallback_split_bio_if_needed does
sneaky splits behind the back of the main splitting code.

The fix is to include the limit imposed by it in __bio_split_to_limits
as well if the crypto fallback is used.

If you have time to fix this that would be great.  Otherwise I can
give it a spin, but it's public holiday and travel season here, so
my availability is a bit limited.

