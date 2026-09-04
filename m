Received: from mta1.migadu.com (out-42.mta1.migadu.com [95.215.58.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1D830D41F
	for <linux-block@vger.kernel.org>; Fri,  4 Sep 2026 03:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788492263; cv=none; b=Axgtrrk0D/sbZbGDXvhBNiAMBM5GvRDEETw8pa2vxYqD+k5peSUyV6rJFH7561/0kxtARRD15Ud3YeYzFDJwPeJLOqXWlM8Ns1zpnEh9V7XWbsGQDAhOb5tsspOfq+5rZPulSpWQ3VTVghfOTVO0EOa6VWMkvHXXRjZS5AfWfSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788492263; c=relaxed/simple;
	bh=AODDE3qRj81d1tj4XlbGSZLMRB5KcVA6K05GsD7cVN0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TyBtUiSdhJErRRT29qVeaU3m3eKzyWiTpGEWRKG1ESrSQs0hWGXOT4NnaVDJVnmm8LUfXTZcv5Wwavii4mATn/FMSxtEuruUPgpZ+sNqZxgik+OtZWKuBzCYSyeBBWqpzZt2zZYDaivya1J5I1xVQkpb7rB0JFlNK6GkaVlK7Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PeF9O7Yx; arc=none smtp.client-ip=95.215.58.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PeF9O7Yx"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=AODDE3qRj81d1tj4XlbGSZLMRB5KcVA6K05GsD7cVN0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788492259; v=1; x=1789097059;
 b=PeF9O7YxKxuBMEJbRMTgKLPNZyFPQSSVWVxLoODpEwGsIZ9uLSNX0Tpg5eQaajLw+bxB3Kt/
 eTotlZbD64wNI5Qs9vKsmNj1+ZIZ2e3MZyB6J2/JNVMPcxlWKGuw3G3/vQw6F1An7vO04jWnNgH
 GbZOewUNVZ0+pdXwgngcDV5I=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1809903fe04b5f0a;
	Fri, 04 Sep 2026 03:24:09 +0000
X-Mizu-Trace-ID: 1809903fe04b5f0a
X-Migadu-Flow: FLOW_OUT
Message-ID: <6dc39f3e-e62e-4209-aa93-9308d086bed2@linux.dev>
Date: Fri, 4 Sep 2026 11:24:01 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, tj@kernel.org, linux-block@vger.kernel.org,
 josef@toxicpanda.com, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 david.laight.linux@gmail.com, haris.iqbal@linux.dev, cuitao@kylinos.cn,
 Yu Kuai <yukuai@huawei.com>
Subject: Re: [PATCH v5] blk-throttle: fix divide-by-zero on legacy iops limit
 of 0
To: yukuai@fygo.io, axboe@kernel.dk
References: <20260904030607.1193800-1-cui.tao@linux.dev>
 <63b0770e-844a-4249-a64e-85b1e1978fab@fygo.io>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <63b0770e-844a-4249-a64e-85b1e1978fab@fygo.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/9/4 11:12, yu kuai 写道:
> Hi,
> 
> 在 2026/9/4 11:06, Tao Cui 写道:
>> From: Tao Cui <cuitao@kylinos.cn>
>>
>> Writing a multiple of 2^32 (e.g. 4294967296) to a legacy cgroup v1
>> throttle iops file (blkio.throttle.{read,write}_iops_device) silently
>> truncates to 0: tg_set_conf() stores the sscanf-parsed u64 value into
>> an unsigned int field with no clamping. The cgroup v2 path,
>> tg_set_limit(), already clamps the same kind of value with
>> min_t(u64, val, UINT_MAX), but the legacy path never did. Note that
>> the "!v -> U64_MAX" mapping only catches an explicit zero and does not
>> catch a value that truncates to zero.
>>
>> With iops stored as 0, tg_update_has_rules() sets has_rules_iops[] and
>> the next IO reaches tg_within_iops_limit(), which computes
>>
>>      jiffy_wait = max(jiffy_wait, HZ / iops_limit + 1);
>>
>> triggering a divide-by-zero oops.
>>
>> Fix it in tg_set_conf() by clamping the value to UINT_MAX, consistent
>> with tg_set_limit(). This closes the truncation root cause: with 0 no
>> longer reachable as a stored limit, the HZ / iops_limit divide is never
>> hit.
>>
>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>> Reviewed-by: Yu Kuai <yukuai@huawei.com>
> This tag is wrong, please use yukuai@fygo.io.

Sorry, will update right away.

>>
>> ---
>> Changes in v5:
>> - Rebase onto current linux-next head (no code change, context shifted only).
>> - Add the Reviewed-by tag collected on v4.
>> - Link to v4: https://lore.kernel.org/r/20260722102459.253189-1-cui.tao@linux.dev
>>
>> Changes in v4:
>> - Drop the defensive "iops_limit == 0" check in tg_dispatch_iops_time():
>>    with the tg_set_conf() clamp in place, 0 can never be stored as a limit,
>>    so the runtime check only guards an unreachable state. (Yu Kuai)
>> - Drop the Fixes: tag: the unclamped write -- and the iops=0 behavior it
>>    can produce (calculate_io_allowed() returns 0, so no IO is issued) --
>>    long predates the commit that added the HZ / iops_limit divide, so
>>    attributing it there was incorrect. (Yu Kuai)
>>
>> Changes in v3:
>> - Drop the (u64) cast on UINT_MAX: the kernel's type-checked min() accepts
>>    two unsigned types of different width (both >= 4 bytes), so
>>    min(v, UINT_MAX) compiles clean. (David Laight)
>>
>> Changes in v2:
>> - Use a "void *field" local for the config write so the assignment reads
>>    *(u64 *)field / *(unsigned int *)field instead of the
>>    (type *)((void *)tg + of_cft(of)->private) casts.
>> - Use min(v, UINT_MAX) instead of min_t(u64, v, UINT_MAX).
>> ---
>>   block/blk-throttle.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
>> index ffc3b70065d4..97ad7959d006 100644
>> --- a/block/blk-throttle.c
>> +++ b/block/blk-throttle.c
>> @@ -1383,10 +1383,12 @@ static ssize_t tg_set_conf(struct kernfs_open_file *of,
>>   	tg = blkg_to_tg(ctx.blkg);
>>   	tg_update_carryover(tg);
>>   
>> +	void *field = (void *)tg + of_cft(of)->private;
>> +
>>   	if (is_u64)
>> -		*(u64 *)((void *)tg + of_cft(of)->private) = v;
>> +		*(u64 *)field = v;
>>   	else
>> -		*(unsigned int *)((void *)tg + of_cft(of)->private) = v;
>> +		*(unsigned int *)field = min(v, UINT_MAX);
>>   
>>   	tg_conf_updated(tg, false);
>>   	ret = 0;
> 

