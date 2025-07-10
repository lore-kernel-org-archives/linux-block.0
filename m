Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B1F1A285
	for <linux-block@vger.kernel.org>; Thu, 10 Jul 2025 04:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752120779; cv=none; b=mhCnitVMP99HCFDh1hyN35Mh4V7bdpX8HAEtNTawwSc+SM5HvVDrZqzocGkW3vk45Azsx/TNk689fINFKNb0jCmRnsx0vr3LOy1vMgPhj7ftbIMy2e+ctOLRKfPjvBuSbtz91CgE9ssXTUxybHjdFgsiv07sweKoReh2isMSrow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752120779; c=relaxed/simple;
	bh=LCmNGAVv7rBhAaZT/Q6/19ESEhEEUDckTm37f5gaIKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fUdty/WlbKxgUkqR2MjL5Ki2pUMYoAE8cCEnIGU2QIR4sb0mK/rElsi0gO45XEK6QmbrDFVqq3NJLBnL6Yl2qXvvPDERCtE5cs3J9zp08rJaCvhJfWQVJQfEZMo3SMVTChq3ktIuwfYbRqjhDqX8lw+zd9aOCTNm/PTyAGSx8Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdsKrAyc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdsKrAyc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8154DC4CEE3;
	Thu, 10 Jul 2025 04:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752120778;
	bh=LCmNGAVv7rBhAaZT/Q6/19ESEhEEUDckTm37f5gaIKc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XdsKrAyc9/0F+2uZXVPiwvpP+aBVNt3cQ0875klsTdsw1v9RWIGD+Pk0ETOrui0iS
	 0rUM8ZsRKivcd1fdWJ+HunIYeBs0qgXL9eIqEW51yh8LQuTt03nHJOfTBAI8wMrSAZ
	 N5+7ZwUJi/2RTGcTYQ9ZaR4B/RCa+eJ6a6D/XAbHY/lHCBz7JbJReyBjlpT9H9wfKw
	 PuUcaXVzMAFobFpnBhR/cX1nPzKotpjPV1XFpZHZtsMIQdkqXzyKknCin6nlzNe/TV
	 +Gg8boZ44jXybGhczNgM9iLivH1n36RMPWmD4zP28GPARbAHtZrwd8JevAKqIEkA2/
	 m0NuvF4oAg17g==
Message-ID: <6443646a-fb74-44dd-b15d-ea37929e3c79@kernel.org>
Date: Thu, 10 Jul 2025 13:10:41 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] block: add tracepoint for blkdev_zone_mgmt
To: Bart Van Assche <bvanassche@acm.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <20250709114704.70831-1-johannes.thumshirn@wdc.com>
 <20250709114704.70831-5-johannes.thumshirn@wdc.com>
 <ca6a5406-21cc-4faa-8943-b0eb5630d500@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <ca6a5406-21cc-4faa-8943-b0eb5630d500@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/10/25 12:37 AM, Bart Van Assche wrote:
> On 7/9/25 4:47 AM, Johannes Thumshirn wrote:
>> +    TP_printk("%d,%d %s %llu + %llu",
>> +          MAJOR(__entry->dev), MINOR(__entry->dev), __entry->rwbs,
>> +          (unsigned long long)__entry->sector,
>> +          __entry->nr_sectors)
> 
> sector_t is a synonym for u64. u64 is defined as unsigned long in
> include/uapi/asm-generic/int-l64.h and is defined as unsigned long long
> in include/uapi/asm-generic/int-ll64.h. Kernel code always includes
> the int-ll64.h header file. In other words, I think the above cast is
> superfluous for all CPU architectures supported by the Linux kernel.

%llu format will not work on 32-bits arch.

> 
> Thanks,
> 
> Bart.


-- 
Damien Le Moal
Western Digital Research
