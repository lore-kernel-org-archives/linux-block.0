Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7A92D6E64
	for <linux-block@vger.kernel.org>; Thu, 13 Aug 2026 02:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786588489; cv=none; b=qAH0uWdW6iN0t3pPVhgsCvIHLf3e1No1VDAYmAM1rgMd1tv10qIkkj7umhD7VHHrMhfoQ5/prNCDlPoEor7Ao1KmE4grRCBA/9i2Q0c6vU2WjPk6k3ncJ6vtSQRypa/6ucY42jYNs0JfGEBvvPciOuDVKqGilYiIWFQ1eIct8Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786588489; c=relaxed/simple;
	bh=lQl//uh362QkzejSniaHIAQoH+QO/NGy/mkbTTPLVj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o+KDdrqnyMZeNubEJkAmlu5oMSx/5MsoNO6J77z24KCDs+xMsPTXPpL2hxNrJPT2iuXLB8YmWukZSv5i3iz82sf4zCWD5Ka1vYKhBpW+HfBSbPpGe7uJzlb0j4YRtBwhGmXan8uRNxuk0p0k+dbn31fW7M50Ck1FcGHzr1NZyvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZXn3hSm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZXn3hSm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595361F000E9;
	Thu, 13 Aug 2026 02:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786588488;
	bh=AwA18GtWo4xEQ726PsjyearzYLRWEcRw8jrS6xgz2G4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DZXn3hSmdcd9IojcvlCXgSFR+MqFTchWoI9RgeyDTA6SSkUtm3u5c0jgyG2FB7n2n
	 fUzGT0jejPCZ22K6Xu71yJgvplBsFCQtjzwtsKCjZLAw480PCbZMC4m/SuUxyAjSRO
	 r2JKf0EggVp7jGoNp0uxoLBevCbYn56HkntoZtfQPqjlI5oU/uJgxgSzQ+ft5j9OO4
	 jnUJtzkJFXAbgyF9p/ya+XTsmLG9K4ikyUEvtsRtns01UZnIkMwayI48V2Bblx96w0
	 JgGsK1ZYJdjXh8iWTsJLqqTqhLHTGSPa6ws9oubyK0uxRj+5ViCjGvF946iFsADiQA
	 u3F9AcYOt8LLg==
Message-ID: <7f366501-869f-42e4-8933-0ef9be592914@kernel.org>
Date: Thu, 13 Aug 2026 11:34:45 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/13] block: drop all zone write plugs on capacity
 changes
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260811105852.1245357-1-dlemoal@kernel.org>
 <20260811105852.1245357-8-dlemoal@kernel.org>
 <102655a3-bdd6-4d6e-a86f-2d850af7eb09@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <102655a3-bdd6-4d6e-a86f-2d850af7eb09@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/08/12 21:15, Johannes Thumshirn wrote:
> On 8/11/26 12:58 PM, Damien Le Moal wrote:
>> the gendisk hash table by marking them as dead, thus avoiding also to
>> leave zone write plugs for zones that are beyond the new device capacity
> 
> This reads wrong. Are you sure avoiding is the correct grammar form here?

Yes. But the "to leave" is wrong. This should be "thus also avoiding leaving
zone write plugs for zones that are beyond the new device capacity in the disk
hash table."

> 
> Anyways
> 
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 


-- 
Damien Le Moal
Western Digital Research
