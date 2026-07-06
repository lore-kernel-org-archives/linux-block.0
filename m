Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E58C3F4834;
	Mon,  6 Jul 2026 06:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783320363; cv=none; b=BlzLzU/otww6TmNZ+ILY1+JUDAvvvVQyixeSL5eMOvultYR84DvBSob9cE55DmIbnWdVQ914DUk/a+UZZKhdTj57f+0cPegCslzNDEqCitNEbgRrsE1jVsRnYWP2HVR8u1FgMetr6QSoUsE0lNqVirJU6PiHM3UqBPD50CVoenw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783320363; c=relaxed/simple;
	bh=OC+vDGhtn+Wq2xL2Syf5viqRKOwuyUc9jj8EkZPRHro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oj9NfsR+D0sb+oIDJrh9HAcUqDB9OmfNQS99c8L+eAJThX76X+Lw8tct2cPxtRFk+/hHfr08S39WBeCQt19eAVUcDp3ipVAzwNdE0Q0UwYcLVqvJkZRPamSayleC9IkaOtw6rWlAjcO0/w648xV4cXoJqYGNKBeaDAf6FMdFGIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AF04068B05; Mon,  6 Jul 2026 08:45:47 +0200 (CEST)
Date: Mon, 6 Jul 2026 08:45:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-aio@kvack.org, linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] block: split out a new blk_plug.h helper
Message-ID: <20260706064547.GA25268@lst.de>
References: <20260706041125.642097-1-hch@lst.de> <8583b332-0d24-4f6f-8831-69e3aad936fd@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8583b332-0d24-4f6f-8831-69e3aad936fd@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 06, 2026 at 08:38:12AM +0200, Johannes Thumshirn wrote:
> On 7/6/26 6:11 AM, Christoph Hellwig wrote:
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 9213a5716f95..20cb8ed7d987 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -7,6 +7,7 @@
>>     #include <linux/types.h>
>>   #include <linux/blk_types.h>
>> +#include <linux/blk_plug.h>
>>   #include <linux/device.h>
>>   #include <linux/list.h>
>>   #include <linux/llist.h>
>>
> I know it's a lot of cross subsystem churn, but wouldn't it be cleaner to 
> not include blk_plug.h in blkdev.h, but patch the update the consumers? A 
> quick grep shows 68 files that would need updating and some you already  
> have updated.

Right now blkdev.h needs the rq_list from it.  So we'd need to move
that to linux/types.h or something first, which feels a bit iffy.

And no, including blk_types.h in blk_plug.h is not a solution,
as that is still touched far too often.
