Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277B720D517;
	Tue, 12 Aug 2025 00:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754959667; cv=none; b=ID46QpiYCSW1pzcAefNi0YApYZ70iPOLEgqzluiHki605thijCeR/jAscZvr0YT9fRaJLbfr/844AXddhJ2Zz4M3IN8juWBRcOr8KxcaqgiMz8F597VZsoMdJT+9nI3n6lkazozvs89F9SCRSZ4F6xTm4bHR1RMABwGgS8hM2qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754959667; c=relaxed/simple;
	bh=MiSIs1rnDHHU/+k/Z0JgED1xlZ7cCjxh1VZ0AZ2BDT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TdrfqUUdvOlMuNbWHiQK08H8apnZ7cbKBc/sFpCJLUt9Dk+aPwwmz9B0wMhBJaovkNczuUEW/HYIfTQfyUxpdfRGUtISmLZnUS3V2kdd4uBtLJ1gjFLqEB8Nuy9VU+OSUTLuL+OsVarr/IrevnFGxGEcqgpgiNnX9AA3OfT+Y3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRIxrjnA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRIxrjnA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91C5C4CEED;
	Tue, 12 Aug 2025 00:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754959666;
	bh=MiSIs1rnDHHU/+k/Z0JgED1xlZ7cCjxh1VZ0AZ2BDT8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uRIxrjnA3BXLDmoa/+xkrvzFkUSvGstXPnHQMBeyCTbbsPm2yOho/HshYUtjiT3nh
	 Rp7qhKMW/N4SboRZxJQy8pMaZJihOn+k8pl0p8hoiBVTRYL/fFzcU1DE1lR0R78FxE
	 8d7FNucqi/vstujZJP2tHn182Wf51rcykaLMck3vrB4kawhydoj/AVOcIIgooT6C3O
	 80mAEoNAW2Lp0j2ka+qYHnITX0w217G6MAlKyUthaqkkNOdD7F32YjK5GyJl5l8hlW
	 fcaBRyBfPRlulaFal+WGHFr1iRueER3xzFnbu4rLx+3Xmx/o7BgPaDjb6XdZ8Dbqcb
	 bllYFPQvP4vkg==
Message-ID: <33b6c9a3-3165-4ce8-9667-afdbaff2c3ae@kernel.org>
Date: Tue, 12 Aug 2025 09:45:02 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] Unexpected OOM instead of reclaiming
 inactive file pages
To: Oleksandr Natalenko <oleksandr@natalenko.name>,
 David Rientjes <rientjes@google.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, John Garry <john.g.garry@oracle.com>,
 Christoph Hellwig <hch@lst.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, linux-mm@kvack.org,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Qi Zheng
 <zhengqi.arch@bytedance.com>, Michal Hocko <mhocko@kernel.org>,
 David Hildenbrand <david@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <5905724.LvFx2qVVIh@natalenko.name>
 <199fb020-19ee-89d1-6373-7cc7f5babab8@google.com>
 <15056829.uLZWGnKmhe@natalenko.name>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <15056829.uLZWGnKmhe@natalenko.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/12/25 5:42 AM, Oleksandr Natalenko wrote:
> Hello.
> 
> On pondělí 11. srpna 2025 18:06:16, středoevropský letní čas David Rientjes wrote:
>> On Mon, 11 Aug 2025, Oleksandr Natalenko wrote:
>>
>>> Hello Damien.
>>>
>>> I'm fairly confident that the following commit
>>>
>>> 459779d04ae8d block: Improve read ahead size for rotational devices
>>>
>>> caused a regression in my test bench.
>>>
>>> I'm running v6.17-rc1 in a small QEMU VM with virtio-scsi disk. It has got 1 GiB of RAM, so I can saturate it easily causing reclaiming mechanism to kick in.
>>>
>>> If MGLRU is enabled:
>>>
>>> $ echo 1000 | sudo tee /sys/kernel/mm/lru_gen/min_ttl_ms
>>>
>>> then, once page cache builds up, an OOM happens without reclaiming inactive file pages: [1]. Note that inactive_file:506952kB, I'd expect these to be reclaimed instead, like how it happens with v6.16.
>>>
>>> If MGLRU is disabled:
>>>
>>> $ echo 0 | sudo tee /sys/kernel/mm/lru_gen/min_ttl_ms
>>>
>>> then OOM doesn't occur, and things seem to work as usual.
>>>
>>> If MGLRU is enabled, and 459779d04ae8d is reverted on top of v6.17-rc1, the OOM doesn't happen either.
>>>
>>> Could you please check this?
>>>
>>
>> This looks to be an MGLRU policy decision rather than a readahead 
>> regression, correct?
>>
>> Mem-Info:
>> active_anon:388 inactive_anon:5382 isolated_anon:0
>>  active_file:9638 inactive_file:126738 isolated_file:0
>>
>> Setting min_ttl_ms to 1000 is preserving the working set and triggering 
>> the oom kill is the only alternative to free memory in that configuration.  
>> The oom kill is being triggered by kswapd for this purpose.
>>
>> So additional readahead would certainly increase that working set.  This 
>> looks working as intended.
> 
> OK, this makes sense indeed, thanks for the explanation. But is inactive_file explosion expected and justified?
> 
> Without revert:
> 
> $ echo 3 | sudo tee /proc/sys/vm/drop_caches; free -m; sudo journalctl -kb >/dev/null; free -m
> 3
>                total        used        free      shared  buff/cache   available
> Mem:             690         179         536           3          57         510
> Swap:           1379          12        1367
> /* OOM happens here */
>                total        used        free      shared  buff/cache   available
> Mem:             690         177          52           3         561         513
> Swap:           1379          17        1362 
> 
> With revert:
> 
> $ echo 3 | sudo tee /proc/sys/vm/drop_caches; free -m; sudo journalctl -kb >/dev/null; free -m
> 3
>                total        used        free      shared  buff/cache   available
> Mem:             690         214         498           4          64         476
> Swap:           1379           0        1379
> /* no OOM */
>                total        used        free      shared  buff/cache   available
> Mem:             690         209         462           4         119         481
> Swap:           1379           0        1379
> 
> The journal folder size is:
> 
> $ sudo du -hs /var/log/journal
> 575M    /var/log/journal
> 
> It looks like this readahead change causes far more data to be read than actually needed?

For your drive as seen by the VM, what is the value of
/sys/block/sdX/queue/optimal_io_size ?

I guess it is "0", as I see on my VM.
So before 459779d04ae8d, the block device read_ahead_kb was 128KB only, and
459779d04ae8d switched it to be 2 times the max_sectors_kb, so 8MB. This change
significantly improves file buffered read performance on HDDs, and HDDs only.

This means that your VM device is probably being reported as a rotational one
(/sys/block/sdX/queue/rotational is 1), which is normal if you attached an
actual HDD. If you are using a qcow2 image for that disk, then having
rotational==1 is questionable...

The other issue is the device driver for the device reporting 0 for the optimal
IO size, which normally happens only for SATA drives. I see the same with
virtio-scsi, which is also questionable given that the maximum IO size with it
is fairly limited. So virtio-scsi may need some tweaking.

The other thing to question, I think, is setting read_ahead_kb using the
optimal_io_size limit (io_opt), which can be *very large*. For most SCSI
devices, it is 16MB, so you will see a read_ahead_kb of 32 MB. But for SCSI
devices, optimal_io_size indicates a *maximum* IO size beyond which performance
may degrade. So using any value lower than this, but still reasonably large,
would be better in general I think. Note that lim->io_opt for RAID arrays
actually indicates the stripe size, so generally a lot smaller than the
component drives io_opt. And this use changes the meaning of that queue limit,
which makes things even more confusing and finding an adequate default harder.

-- 
Damien Le Moal
Western Digital Research
