Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9D33A1D00
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 22:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772145871; cv=none; b=pWBeUr9GTMXqEIOnj4cugE3FdDhum6ywdMcQYAWzOQWjH+Lye4pxYy+wV/X31VF6KL95UYRed7D5PxCWXN8481xEyKjs9nIpDyGySM9jKZOTK69DpkDQkV3dKl6wbY+nLduMI5p7C2EEIakMXcfJquGknRDLZL/sua4WyXUHcxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772145871; c=relaxed/simple;
	bh=X7ilSYyUPirtPA1rolS2sEGcTMtRZLR54kXVbHhOg80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qP4s1V3c1ufpHbItRFnj8BSbjYtDosi+9SaxI1UsxsNRKCtoDDHrywbMkDVA43yq6hIxFVyWbThQm8a1Sl4c8vR497EdT4ahVM/EQbN5i0Zim9GpP9mMJrk6atY1xOT7YdbvbVt480Dyo6iHa57+vWoh+vCknWtdj41mDYKODyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJdc1p1D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJdc1p1D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB35EC116C6;
	Thu, 26 Feb 2026 22:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772145871;
	bh=X7ilSYyUPirtPA1rolS2sEGcTMtRZLR54kXVbHhOg80=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KJdc1p1DTWsasw3BMtXnfqr7kc+3Yebigd2nqNDWRkI3mgzkTD+KkUz5ai5E+xBu0
	 ddtisdM7JwIRUfSD42GEbSvQdJECxuMMPMQvq7mVZcZJjF6knvKHYyk7ivqrMD0lxv
	 9bLllBje93BXtgT9kEdz2u5zd5ZsvhwgAClAiMSGUUkSJ1bTnLgLp3lPvVe/BtDu9P
	 ZzjBzJEFhitTJ1jmEDGYyao9MFGJWs1whQM1OmjpxVteWdQHshpgWy5RFXzTroOT75
	 0ClGVxVEcc6L4vahnEgx4ftb0NnFsOLTN08aIrsdGmfJ9SXy4wHs3eMKH1Iw+BU05S
	 JAZvGia94Oz5g==
Message-ID: <0d4f4fc7-a038-4c08-9aed-fd563abaa119@kernel.org>
Date: Fri, 27 Feb 2026 07:44:29 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] block: fix zone write plug removal
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20260226041024.2154806-1-dlemoal@kernel.org>
 <20260226041024.2154806-2-dlemoal@kernel.org>
 <aaBwiGGrS5StFlWX@infradead.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <aaBwiGGrS5StFlWX@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/26 01:10, Christoph Hellwig wrote:
> On Thu, Feb 26, 2026 at 01:10:18PM +0900, Damien Le Moal wrote:
>>  		/*
>> -		 * Check that a BIO completion or a zone reset or finish
>> -		 * operation has not already removed the zone write plug from
>> -		 * the hash table and dropped its reference count. In such case,
>> -		 * we need to get a new plug so start over from the beginning.
>> +		 * We already have a zone write plug. If it is flagged as dead,
>> +		 * its initial reference count was already dropped. In
>> +		 * this case, increment the reference count and clear the dead
>> +		 * flag to restore the plug to a state similar to a newly
>> +		 * allocated zone write plug.
> 
> This comment, both in the old and new version describes what happens
> here, but it really fails to explain why.  The plug is scheduled
> for removal if we either filled up the zone or reset it, so any new
> bio coming in would result in an I/O error anyway.  So why do we try
> to resurrect the plug instead of just failing the I/O?

Hmm, yes, I guess we could do that indeed.

This case can happen only if the user starts doing stupid things like issuing a
zone reset and writes from the beginning of the zone without waiting for the
reset first. So yes, I guess we can fail the BIO if it hits a dead zone, since
that necessarily mean that the user did not synchronize something that should be.

I will drop that bit and instead print a rate limited error message signaling
the bad usage.


-- 
Damien Le Moal
Western Digital Research
