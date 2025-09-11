Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89795178372
	for <linux-block@vger.kernel.org>; Thu, 11 Sep 2025 06:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757571148; cv=none; b=vF4XCqOoUWXIGT7O9eJgqEhcdqoyE0Vwqj8uXgGN44YUfWoNaSu2StEN4cj3WX8b9UPJx2H4NNdBNhiBD4zANSarcYTqUovr0wRgV7slnqH0/ETVpEqpSE9UyRJkzVSmy1lC4goJ9FYEIAquKuRJcyHjd5Ii0yvi0w4kgZ3fH6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757571148; c=relaxed/simple;
	bh=dXqtyW8BFWiCTondyqDUJfxnKegOjgzF+dJhApI/r1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmaTlxporHrZ3ml+rUk+nvRKntULS/coMRFFvlXm9Oqmjg9bZzwrmU1hv44kEmslfoXGRbVg4x4IuEXeC39Wb/5TIDzZEiVIqbHXpC7sfHQB0/6uo2RieXBdHKrm+AVXr7bieGnNg1RdXvvj3wJptbUc2P6a/IUDuab0nv1D+II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2026167373; Thu, 11 Sep 2025 08:12:22 +0200 (CEST)
Date: Thu, 11 Sep 2025 08:12:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: John Garry <john.g.garry@oracle.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 2/2] block: remove the bi_inline_vecs variable sized
 array from struct bio
Message-ID: <20250911061221.GC12964@lst.de>
References: <20250908105653.4079264-1-hch@lst.de> <20250908105653.4079264-3-hch@lst.de> <42becc1c-e842-4eba-a7ad-5b1e60594243@oracle.com> <8257e4d7-cf2e-6913-06fd-f11c2f94f38a@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8257e4d7-cf2e-6913-06fd-f11c2f94f38a@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Sep 09, 2025 at 04:40:33PM +0800, Yu Kuai wrote:
> Hi,
>
> 在 2025/09/09 16:16, John Garry 写道:
>>> diff --git a/drivers/md/bcache/movinggc.c b/drivers/md/bcache/movinggc.c
>>> index 4fc80c6d5b31..73918e55bf04 100644
>>> --- a/drivers/md/bcache/movinggc.c
>>> +++ b/drivers/md/bcache/movinggc.c
>>> @@ -145,9 +145,9 @@ static void read_moving(struct cache_set *c)
>>>               continue;
>>>           }
>>> -        io = kzalloc(struct_size(io, bio.bio.bi_inline_vecs,
>>> -                     DIV_ROUND_UP(KEY_SIZE(&w->key), PAGE_SECTORS)),
>>> -                 GFP_KERNEL);
>>> +        io = kzalloc(sizeof(*io) + sizeof(struct bio_vec) *
>>> +                DIV_ROUND_UP(KEY_SIZE(&w->key), PAGE_SECTORS),
>>> +                GFP_KERNEL);
>>
>> this seems a common pattern, so maybe another helper (which could be used 
>> by bio_kmalloc)? I am not advocating it, but just putting the idea out 
>> there... too many helpers makes it messy IMHO
>
> Not sure how to do this, do you mean a marco to pass in the base
> structure type, nr_vecs and the gfp_mask?

It's not a very common pattern, and should be even less common.
If a driver / file system wants to embed a bio into its own structure
but dynamically allocate the bio_vecs, it can simply use kmalloc_array,
or add a bio_vec VLA to its own structure and use struct_size on that.

