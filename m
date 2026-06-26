Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E061239567
	for <linux-block@vger.kernel.org>; Fri, 26 Jun 2026 22:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782513771; cv=none; b=Jz1/WAxVH4+rDhHtnJZ4fcAuPj/36dwWgOlOB/XtwWmJUhMRJZyILSOROGZdTErF5NYTE2laFtsIUsuWLeTc7uj9e+QrGTi3RROExjLZ+5VfhCX6F6Le4YF+cDwZKWAG+11P/zUq+BKRW8Vqn5+NM8+1SMlt1hKfnOrxJWWoLB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782513771; c=relaxed/simple;
	bh=21YzJveJSMIadZa28A9RbafC7yWwKJsRqvLY0SrZFOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JymhHoDld0omNl9iyPfJu9173xpw4c6JCTzMLyB6L5trVUSEqUyfuppG2PmCXgMm44omWhIf1GtjSqoNUOSp5OOeahd9z6wH+tVt0xXIq+JGXFTpClEHZeWP7w7kkx0LoTnPBw2esq7vIi0LIP/h17eK3ZAEHOSBoF5atB+XW2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtLJ7ZlZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtLJ7ZlZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E381F000E9;
	Fri, 26 Jun 2026 22:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782513769;
	bh=sZxlfW5JrCS1+va60Zwr8ZHsTIFPBjxo7a8W0J+TsPo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AtLJ7ZlZC7DKfYO0hDejBiR6akEnNLJFo/rfQPvz7sAwWmm7coMoSKf5y0BgKoqkv
	 eD7PLqZblFlDCDjk0d3knMhVD3l7ESGas2eCpKW0W+D0HXcNiEoaXOzrKLa9Fr90RS
	 vBSpxhCQ7gCh8h2zn5dbCYzZUk+EzwB6tBlrkR2PoWG2N1WzPMunIrsxJ1xJf5ozcv
	 58Jr0dPYrNe2BXRU/JT+JjAFPqIC6r3aIzMSuwJYdoUl8c9/rAIipBKPiQRWQDeHdF
	 xnZ1wcV9y0svHS9mQ8AoagOD6cT4Wzas+3KE5lqAsqvmBD+xK+HHf7MA75/w8D8F84
	 F6rBeVajdBWUQ==
Message-ID: <535959f9-b6fc-475e-b5e7-99b0dae839a4@kernel.org>
Date: Sat, 27 Jun 2026 07:42:47 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: avoid potential deadlock on zone revalidation
 failure
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20260625062824.2013244-1-dlemoal@kernel.org>
 <20260625115232.GC18076@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260625115232.GC18076@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/25/26 20:52, Christoph Hellwig wrote:
> On Thu, Jun 25, 2026 at 03:28:24PM +0900, Damien Le Moal wrote:
> 
> [very long lockdep trace]
> 
>> +	/*
>> +	 * We may already have a zone write plug workqueue as this function may
>> +	 * be called after disk_free_zone_resources(), which does not destroy
>> +	 * the workqueue (the zone write plugs workqueue is destroyed at
>> +	 * disk_release() time).
>> +	 */
>> +	if (!disk->zone_wplugs_wq) {
> 
> Can't we just allocate this at add_disk time instead of the magic NULL
> check here to mirror the freeing side?

I checked and this is not simple to do because most drivers (null_blk, zloop,
ublk, virtio_blk, DM and nvme) call blk_revalidate_disk_zones() *before* calling
add_disk(). Which makes sense as we really want to check everything before the
disk is visible to the user. SCSI sd is an exception here.

And I do not see a better way without the addition of something like a new
disk_create_one_resources() that all drivers would need to call.


-- 
Damien Le Moal
Western Digital Research
