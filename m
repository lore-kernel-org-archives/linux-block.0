Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821E8173;
	Tue, 26 May 2026 23:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779837351; cv=none; b=BNte1ZYatBEaB/m1Q1Vf2+lR16XPWjPCf1wHhTpMJnovDIb0t4tYkkkR32KDCN05JCVLr7joBD4zJLjX1u15OHqZG+emxuJnkF2TOA1t/w3PFErB4UPoKVap0RgLmM02aA/XDCyorqyK3cZx0In7xdLBHxB2BwHorsN0GO/Af0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779837351; c=relaxed/simple;
	bh=Q09bo9R153WDkMsviQ9L9Hnbnv1FSrIFuB/OuA8Dybw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xt2qAt9eLNJ2Vcwo+lDv90CzshZ+0Ui7kOBdFbyt6fKtWoYsgDBiFRj70ECGeRwUySwaX9vCRcSFVuVSnGY2S1kB7zLz2Fpn1+caTDIaQiAwsQuha5JtVwxsBMXvyCLpCw61EQ8rFqXJVlsSLRDycFM19SfsbqVGuaCWid+wajQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTiUg2eW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTiUg2eW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889C51F000E9;
	Tue, 26 May 2026 23:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779837350;
	bh=MCGbQ9PhVibt4D9FhGBq/ohFPhv1Vpv/Vj2vmoVb5Co=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NTiUg2eW3fqQ8rprBKXjx73F6AFiaW09Ogz6/LshOk+1FSyiIwy1JTkkmuZgqddsa
	 cWSs/A+T0ZnWaek8ZzJofggsGG0OWKd/yyB4CvGMCIqL7rSETu2jOcz7hyw8E1583q
	 Yh+JvBtKLF0JDgcW+d+aL4OrytyDy9K7x964blssxNwmJLmCuXVDQi3EHMPgvFHPP5
	 wLxXXzGC6VoioT/PWygYjv9PDmngp47KIczYwZG+FYjDCLx+S0mEbRAOhcotzCO3F+
	 kzMDbCAbll3+YMuXeG6D/die5ika0be1z2wVXClV265YwsxBThqP6BCqDPRhS2NoXi
	 tu87xaI+827Pg==
Message-ID: <90a1581d-9a3c-46db-bc7b-5fd1a9d9c0e1@kernel.org>
Date: Wed, 27 May 2026 08:15:38 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: blk-zoned: fix zwplug refcount leak on write error
 path
To: Haris Iqbal <haris.iqbal@linux.dev>, Wentao Liang <vulab@iscas.ac.cn>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260526141824.2293025-1-vulab@iscas.ac.cn>
 <d8be2a57-c950-46c2-b9d8-120b6e53da91@linux.dev>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <d8be2a57-c950-46c2-b9d8-120b6e53da91@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/27/26 3:54 AM, Haris Iqbal wrote:
> 
> 
> On 5/26/26 16:18, Wentao Liang wrote:
>> blk_zone_wplug_handle_write() increments zwplug->ref via kref_get()
>> when preparing to handle a zone write. On the error path where
>> blk_zone_wplug_handle_write_noalloc() fails, the function returns
>> without calling kref_put() on zwplug->ref, leaking the reference.
>>
>> Add kref_put(&zwplug->ref, ...) on the error path to properly release
>> the reference.
>>
>> Fixes: dd291d77cc90 ("block: Introduce zone write plugging")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
>> ---
>>   block/blk-zoned.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>> index 42ef830054dc..24b899663a48 100644
>> --- a/block/blk-zoned.c
>> +++ b/block/blk-zoned.c
>> @@ -1503,6 +1503,7 @@ static bool blk_zone_wplug_handle_write(struct bio
>> *bio, unsigned int nr_segs)
>>         if (!blk_zone_wplug_prepare_bio(zwplug, bio)) {
>>           spin_unlock_irqrestore(&zwplug->lock, flags);
>> +        disk_put_zone_wplug(zwplug);
> 
> I am not sure if this is needed. The code above adds the
> BIO_ZONE_WRITE_PLUGGING flag to the bio, which means the
> blk_zone_write_plug_bio_endio would be called which should then call
> disk_put_zone_wplug.

Correct. This patch is not correct at all. The write plug reference is dropped
in the BIO completion path.

Wentao,

You clearly did not test this at all because if you had, you would have seen
all the warning splats that your patch triggers.

-- 
Damien Le Moal
Western Digital Research
