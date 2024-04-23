Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE2E101D5
	for <linux-block@vger.kernel.org>; Tue, 23 Apr 2024 15:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885374; cv=none; b=NVsscJxKT8y96XilGXy2ye9nCJUm3bizx3i2G36Khg4NU++MEy8a8/92YI1TMhTBGioPG06SvdCKyC3dMcLQ1vz5C1/drfsnXz3dvWPAxhMPy2AzvEdihisKVUXyy1+QsS1XOgSoREeQnUHb3PlgjM8r/Xg8jlLzLtVnL4uo1j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885374; c=relaxed/simple;
	bh=A5uazX3xHFs7osg6r4FRxUONyFOZtrs9j4HQ1a+xa6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XmzFT2s7nDlPhmmFy2UEqsGyuGsSw9O2TzOhyuAjYNBPeQko2cjcQ4Z43k8dq81RXb/pw6DS3sJgi9YmiDpm1AyJXz6bDIYP0qj+cFnSPR6kiSL80Pd9FpEQ+jRXa2Bh8ozx4PvmWjmeUx9UkLnf0KmhT9oTKv9FjOtx/quwQDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9SeqBaU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9SeqBaU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC80C116B1;
	Tue, 23 Apr 2024 15:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713885374;
	bh=A5uazX3xHFs7osg6r4FRxUONyFOZtrs9j4HQ1a+xa6c=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=A9SeqBaUI7UeuCUSws1HelD9zXBzpRpvHI3sk0qknsslsXjEFk+Di/0DDkeNM2b+W
	 OUaRmdXNeKp1nBatEc9moHdc1UT1BqtTUgkg7+ZDTiUCPPxK8Pbc6u/rcUVwVo4CXL
	 QW0UuqW6l1fyy84XdMMjy5gaZb/+sQ6/1lY9AWHX54V98wOGJ8D+yVT0tJWxmsl+kv
	 NyJ3pVrEiyQ7T09qlIqPHjgp1dm7yC77ur0sDW0Rmg5voUkAkofw9bPLzpFjDbFhGD
	 FOpK7pDBIl3um88gDM9cOdLOAqtYVcfekrWRPhirg4cQCZCzHjnItCSMVwUlC4/UwI
	 WIlqvx+4NCT7Q==
Message-ID: <4530f039-0698-4cc0-94ab-5465d3f0e255@kernel.org>
Date: Wed, 24 Apr 2024 01:16:13 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] block: prevent freeing a zone write plug too early
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20240420075811.1276893-1-dlemoal@kernel.org>
 <20240420075811.1276893-2-dlemoal@kernel.org>
 <715fd037-a8e5-4e62-939e-a446087eed2a@kernel.dk>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <715fd037-a8e5-4e62-939e-a446087eed2a@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/04/24 0:21, Jens Axboe wrote:
> On 4/20/24 1:58 AM, Damien Le Moal wrote:
>> The submission of plugged BIOs is done using a work struct executing the
>> function blk_zone_wplug_bio_work(). This function gets and submits a
>> plugged zone write BIO and is guaranteed to operate on a valid zone
>> write plug (with a reference count higher than 0) on entry as plugged
>> BIOs hold a reference on their zone write plugs. However, once a BIO is
>> submitted with submit_bio_noacct_nocheck(), the BIO may complete before
>> blk_zone_wplug_bio_work(), with the BIO completion trigering a release
>> and freeing of the zone write plug if the BIO is the last write to a
>> zone (making the zone FULL). This potentially can result in the zone
>> write plug being freed while the work is still active.
>>
>> Avoid this by calling flush_work() from disk_free_zone_wplug_rcu().
>>
>> Fixes: dd291d77cc90 ("block: Introduce zone write plugging")
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
>>  block/blk-zoned.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>> index 3befebe6b319..685f0b9159fd 100644
>> --- a/block/blk-zoned.c
>> +++ b/block/blk-zoned.c
>> @@ -526,6 +526,8 @@ static void disk_free_zone_wplug_rcu(struct rcu_head *rcu_head)
>>  	struct blk_zone_wplug *zwplug =
>>  		container_of(rcu_head, struct blk_zone_wplug, rcu_head);
>>  
>> +	flush_work(&zwplug->bio_work);
>> +
>>  	mempool_free(zwplug, zwplug->disk->zone_wplugs_pool);
>>  }
> 
> This is totally backwards. First of all, if you actually had work that
> needed flushing at this point, the kernel would bomb spectacularly.
> Secondly, what's the point of using RCU to protect this, if you're now
> needing to flush work from the RCU callback? That's a clear sign that
> something is very wrong here with your references / RCU usage.. The work
> item should hold a reference to it, trying to paper around it like this
> is not going to work at all.
> 
> Why is the work item racing with RCU freeing?!

The work item is a field of the zone write plug. Zone write plugs have
references to them as long as BIOs are in flight and and the zone is not full.
The zone write plug freeing through rcu is triggered by the last write to a zone
that makes the zone full. But the completion of this last write BIO may happen
right after the work issued the BIO with submit_bio_noacct_nocheck() and before
blk_zone_wplug_bio_work() returns, while the work item is still active.

The actual freeing of the plug happens only after the rcu grace period, and I
was not entirely sure if this is enough to guarantee that the work thread is
finished. But checking how the workqueue code processes the work item by calling
the work function (blk_zone_wplug_bio_work() in this case), there is no issue
because the work item (struct work_struct) is not touched once the work function
is called. So there are no issues/races with freeing the zone write plug. I was
overthinking this. My bad. We can drop this patch. Apologies for the noise.


-- 
Damien Le Moal
Western Digital Research

