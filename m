Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634B97DA6D
	for <linux-block@vger.kernel.org>; Wed, 18 Jun 2025 05:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750223482; cv=none; b=FaYkzxrWG3HjN8ruRnjPoPP/om17L6tpaCMcwBLxYvVI+Gds4Zo9bdNuMzNLo+6ab0BOXGDe/95RuWHz44Z6fyw8nytIkCaZY8QNdROXSY8OzeH6YMey4L8S1lp1e/hHYwCR4U6TkY6lPO/XGpPn2TCokJ8ZZ5EEkMZpy0qavNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750223482; c=relaxed/simple;
	bh=m1vrQHbjhVWKdhWyeUocfEzuVoRyPnOaZTV0CkY5kJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SvR7GlvWEYni58PJV4YTnIA7knKOTXIMNgfSUaxRw6PM5Aa6DavC7JWMeSH05hmAxChUGVE5La2269eL6Nd5R8mxJ3SxETB0HEPkWLgN5k+viiqe4z3JpVy0NdK1qRTh/Q7Q/bYFZx8pgQ5JskFaEgFy1mbvOxdWRDDpEQeY7V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWlFtOGu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWlFtOGu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60443C4CEE7;
	Wed, 18 Jun 2025 05:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750223482;
	bh=m1vrQHbjhVWKdhWyeUocfEzuVoRyPnOaZTV0CkY5kJU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RWlFtOGuzzMsZSlZ/gOYRbINrNsemYfP5QR8+PNubAPGQlhEt2utvCERFfYLnkyYs
	 +nQ+b79osIPqJNmbdlzWkQ3/Bjo8yQYRz3UOd0VYqrErB30L6Uq/yZxNGbmnB2TI+S
	 1XHjBG6HElVhlMQ6YgBTNn9MkWv3j1FzVjMFsBRRMOSlq3CnSkQODR5e6JRJLUxb6o
	 D18yUZmVO9NJoZn+F7smxRsSR1Nv0WVAIDJ3TJc8Gp9f7p8DwhPDUtM8qbCqYaktw3
	 OXOzNbKPJlKa7/CrYaXunyHsFDx8zy4zdB1DksYqx92xtirVyVsZK+JgulzkZ78hTC
	 /ZvOTugUIpHeQ==
Message-ID: <d23b7e4d-3678-4b04-9427-778557275979@kernel.org>
Date: Wed, 18 Jun 2025 14:11:20 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Increase BLK_DEF_MAX_SECTORS_CAP
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20250617063430.668899-1-dlemoal@kernel.org>
 <20250618045927.GA28260@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250618045927.GA28260@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/18/25 13:59, Christoph Hellwig wrote:
> On Tue, Jun 17, 2025 at 03:34:30PM +0900, Damien Le Moal wrote:
>> Since many block devices can benefit from a larger value of
>> BLK_DEF_MAX_SECTORS_CAP, and in particular HDDs, increase this value to
>> be 4MiB, or 8192 sectors.
>>
>> Suggested-by: Martin K . Petersen <martin.petersen@oracle.com>
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
>>  include/linux/blkdev.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 85aab8bc96e7..7c35b2462048 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -1238,7 +1238,7 @@ enum blk_default_limits {
>>   * Not to be confused with the max_hw_sector limit that is entirely
>>   * controlled by the driver, usually based on hardware limits.
>>   */
>> -#define BLK_DEF_MAX_SECTORS_CAP	2560u
>> +#define BLK_DEF_MAX_SECTORS_CAP	8192u
> 
> While we're at nitpicking, maybe define this as
> 
> 	(SZ_4M >> SECTOR_SHIFT)
> 
> to make it a bit more readable?

Sure thing.

> 
> Otherwise this looks good, the odd number was always rather weird.
> 
> 


-- 
Damien Le Moal
Western Digital Research
