Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB6C30CDBB
	for <linux-block@vger.kernel.org>; Wed, 27 Aug 2025 08:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756281882; cv=none; b=TpI0aXGc+lasqpNXBNmoTEiFON8YC8PnWK+e8rs/Lg5GWKvdt0FJ2NvHA6qi4qmX1akNzzdOsx+yXiJU5oRwK7MT+eljsLqhtSh+i+YPOZBadrDZKbZouHSqLZyknqrsOYJoOvUOBMe91fxtfWlfmESVK++T3nTDVbv5pLAB3Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756281882; c=relaxed/simple;
	bh=vgFManMZ+ujjaFMxdJuQ62U5VT4QRb5qu+BmnGFP7hQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EteZ8NB3yGJbp/Lrv+IbaNzghKijOy3ixEkcw6dfOqOXQkVWUr/jZ7I4qFXNGxBzMOX10GI7SVCIUF3iK0m5pFDODTjfg0BJ2JXTAllFwkzK7nWy41BSaeUCbDBdDPq2Z4X4fe6P+4JNbZvKfAH0AYPpvxA8N830hnLiGowAmNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIPVVReG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIPVVReG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE6FC4CEEB;
	Wed, 27 Aug 2025 08:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756281881;
	bh=vgFManMZ+ujjaFMxdJuQ62U5VT4QRb5qu+BmnGFP7hQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kIPVVReGfkY7/SPTX3gaA2aIVgt4ToiQ5TlHsEIyJshNJZxBfofRY5RVMQE/kqMQR
	 gARSDDgudQ4WPk3CSYfytmKO9ShOVSHJwnChD0LS5qkqOpYc5vaMl0l4KCZGJhjr1b
	 sIcfrLvvaG4BdpWXiWg+ZAOl9FYUtuTdSs1DpbVKspvGpw66zUStXnZ7Gqd7GIzrSU
	 BQbvTM8YwK5zqDPQXvfDRfzzd04BLlVzGgMR/xnQjHvqhjejx6gZoAFDlAHPDcEo0r
	 5r7M4uI1wOcFPWYqcf2u1RGthcL9IwaIUQlDKll8Hsw/YjdK2uSuCdnKWq1u5HP+al
	 bYT0TTxMHAo4g==
Message-ID: <39ac5089-794c-4e50-a090-6dabf4a60575@kernel.org>
Date: Wed, 27 Aug 2025 17:01:49 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: Increase BLK_DEF_MAX_SECTORS_CAP
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20250618060045.37593-1-dlemoal@kernel.org>
 <175078375641.82625.9467584315092336312.b4-ty@kernel.dk>
 <20250827070705.4iWhHGPE@linutronix.de> <20250827073836.GA25169@lst.de>
 <20250827075221.6hTi-i7m@linutronix.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250827075221.6hTi-i7m@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/27/25 4:52 PM, Sebastian Andrzej Siewior wrote:
> On 2025-08-27 09:38:36 [+0200], Christoph Hellwig wrote:
>>> Did I forget to update firmware somewhere or is this "normal" and this
>>> device requires a quirk?
>>
>> Looks like it needs a quirk.  
> 
> Just wanted to make sure I did not forget to update firmware somewhere…
> It should be easy to fix this one the firmware's side (in case someone
> capable is reading this).
> 
>>                               Note that if the above commit triggered
>> this for you, you could also reproduce it before by say doing a large
>> direct I/O read.
> 
> On a kernel without that commit in question? Booting Debian's current
> v6.12 and
> |  dd if=vmlinux.o of=/dev/null bs=1G count=1 iflag=direct

Don't read a file. Read the disk directly. So please use "if=/dev/sdX".
Also, there is no way that a 1GiB I/O will be done as a single large command.
That is not going to happen.

With 345c5091ffec reverted, what does:

cat /sys/block/sdX/queue/max_sectors_kb
cat /sys/block/sdX/queue/max_hw_sectors_kb

say ?

Likely, the first one is "1280". So before running dd, you need to do:

echo 4096 > /sys/block/sdX/queue/max_sectors_kb

and then

dd if=/dev/sdX of=/dev/null bs=4M count=1 iflag=direct

And you will likely trigger the issue, even with 345c5091ffec reverted.
The issue is likely caused by a FW bug handling large commands.
Please try.



> 
> works like a charm. According to strace it does
> | openat(AT_FDCWD, "vmlinux.o", O_RDONLY|O_DIRECT) = 3
> | dup2(3, 0)                              = 0
> | lseek(0, 0, SEEK_CUR)                   = 0
> | read(0, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\1\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 1073741824) = 841980992
> 
> so it should be what you asked for. Asked for 1G, got ~800M.
> 
> Sebastian


-- 
Damien Le Moal
Western Digital Research
