Received: from mta0.migadu.com (out-45.mta0.migadu.com [91.218.175.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C5940963A
	for <linux-block@vger.kernel.org>; Wed, 12 Aug 2026 09:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786528632; cv=none; b=PPsnWevNrvO81+iZhhvI1DuOy7XQJi0YPFZEDbtZmxQ8ProwwVDuzbUPWKmHpbh5p4hyrVbUEWBzsNxQhRPxGlL8eYKJo9FmUvjFuiZAlhZyoPXUDyt2wUvb/1GJPwDKXRzgu6R2qyL6uaWqzbBZTNR0IDnKQ6Ve+0UEp8ahGKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786528632; c=relaxed/simple;
	bh=epysKEXP915hKNN8FzIRPC1AalhP3uljl1ePcTT+vbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqTlyoc43r57cgjIKN++LTq9I9Yc0J4igVF+tkY2UxLp6T7Hr+6wG6LXza2t6h8J4F1JWbcEEs0PrDMB/oysWiXwwT/rHYwsjb5TvW32XvhGj6F8gUUgyF8MiVNcb6BN/R9vi9bkpieijPW6QyZfjG5cWXhb77GsTPrdIKeKZKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a1XbOrgy; arc=none smtp.client-ip=91.218.175.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a1XbOrgy"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=epysKEXP915hKNN8FzIRPC1AalhP3uljl1ePcTT+vbE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786528627; v=1; x=1787133427;
 b=a1XbOrgyEgfkGIGuJmR8FuFN1TsUyvezqRi1l5J0fczaALT5HlLFxBJSxdlmdFWQiZlQTFph
 zn6w60rzAKGv91jydOe+PLmY5QjdhGkvCZPHKiamP+3ebCQDTGHS5CHB0HO5ihRUhllnn8x3OHC
 geE2Mqq3U/jofmky5gqwivsg=
X-Envelope-To: linux-block@vger.kernel.org
Received: from [IPV6:2a02:6b6f:e75b:1900:855:edd6:ce7b:4965] (2a02:6b6f:e75b:1900:855:edd6:ce7b:4965)
	by smtp.migadu.com with ESMTPS id a507ceac46470965;
	Wed, 12 Aug 2026 09:57:07 +0000
X-Migadu-Scanner: mta11.migadu.com
Authentication-Results: mta11.migadu.com;
	none
Message-ID: <e32cff4b-81a1-4846-ae97-6b7ee67b4b1d@linux.dev>
Date: Wed, 12 Aug 2026 10:56:58 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] block: skip blkcg walk in blk_cgroup_congested() when
 nothing throttled
To: Tejun Heo <tj@kernel.org>
Cc: axboe@kernel.dk, cgroups@vger.kernel.org, josef@toxicpanda.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 shakeel.butt@linux.dev, hannes@cmpxchg.org, riel@surriel.com,
 kernel-team@meta.com
References: <20260806183742.946953-1-usama.arif@linux.dev>
 <20260806183742.946953-4-usama.arif@linux.dev>
 <anoe61mtiBJL3ofn@slm.duckdns.org>
Content-Language: en-US
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <anoe61mtiBJL3ofn@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/08/2026 19:56, Tejun Heo wrote:
> Hello,
> 
> On Thu, Aug 06, 2026 at 11:37:20AM -0700, Usama Arif wrote:
>> @@ -53,6 +53,9 @@ EXPORT_SYMBOL_GPL(blkcg_root);
>>  struct cgroup_subsys_state * const blkcg_root_css = &blkcg_root.css;
>>  EXPORT_SYMBOL_GPL(blkcg_root_css);
>>  
>> +/* number of blkcgs with a non-zero congestion_count */
>> +atomic_t blkcg_congested_blkcgs __read_mostly = ATOMIC_INIT(0);
> 
> Maybe name it to clarify that this is a count. nr_ or _cnt or whatever.
> 
>> @@ -1350,6 +1353,16 @@ static void blkcg_css_free(struct cgroup_subsys_state *css)
>>  	struct blkcg *blkcg = css_to_blkcg(css);
>>  	int i;
>>  
>> +	/*
>> +	 * Every blkg holds a reference on this css and drops any delay it
>> +	 * still has from pd_free_fn(), so this is expected to be zero.  Should
>> +	 * a policy ever leave one behind, drop it here rather than let it pin
>> +	 * blkcg_congested_blkcgs and disable the fast path for the rest of the
>> +	 * boot.  Nothing can race with us at this point.
>> +	 */
>> +	if (atomic_xchg(&blkcg->congestion_count, 0) > 0)
>> +		atomic_dec(&blkcg_congested_blkcgs);
> 
> Maybe put WARN_ON_ONCE() on it?
> 
>> +static inline void blkcg_dec_congestion_count(struct blkcg *blkcg)
>> +{
>> +	if (atomic_dec_return(&blkcg->congestion_count) == 0)
>> +		atomic_dec(&blkcg_congested_blkcgs);
> 
> atomic_dec_and_test() is minutely more efficient.
> 
> Thanks.
> 

Thanks! Ack on all 3. I will wait a day incase there are more comments
and send a new revision tomorrow with all 3 addressed.

