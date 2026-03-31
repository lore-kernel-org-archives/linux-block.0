Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA5B382F19
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 10:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774951310; cv=none; b=WVtVaeHteEr+PY/kSnhbaASG3kJTGdIA8+kpmJX+TlnfFTbnzwZAnVfTv8+CCWPh2GTVzXK/M4+FfB2YSwVgdkyJf71HfCs63S0JyFi2VLqV2LnFLKjJeFn7E7XoqAC9QkKsrqGY56zVMqxHb/aqTsaGqNs8fi0yVFhufneGJJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774951310; c=relaxed/simple;
	bh=c5j4J73Q6EyUhugd6rOfr7B/9GwNFIShw4YMz9kZcwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ck+Cx3jcaHqYwffk/IpPg/9xVKuhlKXTbeNgKrg6si0VzIbaw32jWN/Nd0KqcAmpawaKFedyh4n5qVjTsQQzndyN9x2UFSwgJT0mD7EnCDWiXMJS/+niUV8UQEAbsOKab9aIiWtJFIbLOhkws/WNlLP5K7chS+eY3kHjMk3CnTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rD9Q5Yl9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rD9Q5Yl9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E84C2BCB2;
	Tue, 31 Mar 2026 10:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774951310;
	bh=c5j4J73Q6EyUhugd6rOfr7B/9GwNFIShw4YMz9kZcwg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rD9Q5Yl9y9/5wiEGkif/WaLxGjDcdvcF6on3krg+1pMKB9Ix58dncIDJ7dJXtRbKR
	 u/ehW3yqTsn6E4hUtXIpzzEyvy69h6A26dRkQE0Til2FYRfLtoLJWPZIxgroPKqRmx
	 F1eYFzMr5lu08KKfoQVjvtLGc1w9vpfCflCvbK8letJBfxgurudfPmKd6eoG9XC7CL
	 L/j44VWacY/OOuBblzTp+gT543he9XjDVYPOPPmF+ivm8OVZxPz5ZhAAm7Pjcki4Wm
	 MS2YD5FkU//aPMi2E4v/wOo1EtFZLNB89SqHFcVhTT4nanoRp/o7tngbQvhDNAzXJC
	 xBRndHT1h1aRQ==
Message-ID: <723851a5-5219-4310-a311-1107ece2550e@kernel.org>
Date: Tue, 31 Mar 2026 19:01:48 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: fix zones_cond memory leak in
 blk_revalidate_disk_zones()
To: Jackie Liu <liu.yun@linux.dev>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20260331084731.45283-1-liu.yun@linux.dev>
 <2e91b857-4edd-4a8a-a75c-d1569fc6f1e3@kernel.org>
 <db3b585abda63bd1a959c457aaf95572652ebeb5@linux.dev>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <db3b585abda63bd1a959c457aaf95572652ebeb5@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/31/26 18:47, Jackie Liu wrote:
>> This does not look correct: on success case, this will free the array despite
>> that array being set already. So rather than this, I think it is better to
>> change disk_revalidate_zone_resources() to free the array it allocated in the
>> case of an error. That will be a lot cleaner than this.
> 
> Thanks for the review.
> 
> Actually, the free_zones_cond label is only reachable on error paths
> (ret <= 0). On the success path (ret > 0), the function returns
> directly via "return disk_update_zone_resources(disk, &args)" and never
> reaches this label. So the logic should be correct.

Ah, yes, indeed.

> 
> That said, I agree that having disk_revalidate_zone_resources() free
> the array itself on error is cleaner and easier to follow. I'll send
> a v2 with that approach.

Sounds good. Thanks.

> 


-- 
Damien Le Moal
Western Digital Research
