Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AD52749E6
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 09:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772185220; cv=none; b=fXRApuVUYeczxIYhVaStfY7jnfKoFwtfmiia/F6Scy38AhSvcJxCqh185IEiSAbvXWeq1TZVsa5PjP+B5RPqXw+1/xQ90yXgdmT6NeboDldJUEEbCoXIPpnNDJj7BITwai5vqFLiEzU0mcqM27wcrNHLVQLZc+zoj2T7+i5Wd+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772185220; c=relaxed/simple;
	bh=kBCinyOCOo9FSpAX0+qBXH7QGew3rQSEVhKbg2UxDZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=b5hHQEV5hm2xcashEcETM07got1CdN/jU075UyPko4ikSpZ6aMU2vi+3fDu6KNMwMuOJQUCNixitBQNihDdLtPNUbPxw/uAjz6GE/Koi0hUGjtqOhvd5CANSI3p0ec2ZwIsc7cNk80S58/v3MUTEMR0Ki5iKpbsfKmsE9u3bSMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUjDjoY6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUjDjoY6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEF5C116C6;
	Fri, 27 Feb 2026 09:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772185220;
	bh=kBCinyOCOo9FSpAX0+qBXH7QGew3rQSEVhKbg2UxDZg=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=UUjDjoY61+4Cu3So+5HmZ4T1k80/tLA/rwFZoU2Ier/4g4qRTcLTsLH/b4iMPQoKS
	 CrsFXrwklxOeaRfPhAFxB6B9AM6EueEImWOHqHB220VMRFWIsOyVxU2s/203J9YwhF
	 wemK1yUa4ajWapYpZSRJsGieEOX3RLQbIYAiUkC0//4XiUydLGtUZq8FtqEFk46B/P
	 JOAxDACyAnOm8waiZ8X9DZhULqgEuYXStNECZG3ptfhV7esJdOsGCLoc3hi340mEcn
	 TovtxeFpzLt3FTTXigR7jXvXW/8dhwBgf153KhjkfBAv+9k8Qdot/fXeWy7W9Toxz8
	 nnx9ERbx1V11w==
Message-ID: <29a358b4-02c7-4b82-9b58-f365c518afd9@kernel.org>
Date: Fri, 27 Feb 2026 18:40:18 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] block: fix zone write plug removal
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20260227014951.2327711-1-dlemoal@kernel.org>
 <20260227014951.2327711-2-dlemoal@kernel.org>
 <70f59d85-932a-45e3-840e-a38db192719c@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <70f59d85-932a-45e3-840e-a38db192719c@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/26 18:22, Johannes Thumshirn wrote:
> On 2/27/26 2:55 AM, Damien Le Moal wrote:
>> +static inline void disk_put_zone_wplug(struct blk_zone_wplug *zwplug)
>> +{
>> +	if (refcount_dec_and_test(&zwplug->ref))
>> +		disk_free_zone_wplug(zwplug);
>> +}
> 
> Dumb question, what prevents the refcount from increasing between 
> refcount_dec_and_test() and disk_free_zone_wplug()? 

the get function uses refcount_inc_not_zero(). So you cannot get a plug with a
refcount that has reached 0, ever.

> disk_mark_zone_wplug_dead() is holding the zwplug->lock, so we're safe. 
> disk_get_hashed_zone_wplug() is doing a refcount_inc_not_zero(), so safe 
> as well. disk_zone_wplug_schedule_bio_work() holds the lock, so safe. 
> disk_destroy_zone_wplugs_hash_table() neither holds the lock nor does it 
> do a refcount_inc_not_zero() so potentially unsafe, but it's called 
> after the workqueue got destroyed.
> 
> Can we maybe document why this is safe?
> 
> 


-- 
Damien Le Moal
Western Digital Research
