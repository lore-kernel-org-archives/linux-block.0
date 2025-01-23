Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4361BC3F
	for <linux-block@vger.kernel.org>; Thu, 23 Jan 2025 03:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737602887; cv=none; b=J3AWMu8bx5v5zpw7v/97Ri2Ifnxj2ZsNZFTsomMJO3+QXDjgknt7JwFIWkLoOlqnQodnpWl1m9jTQ5ATRnH1E9cG+NyZ5wFmjbxcAKnDDWuUH19nP6xM4Kk1lWPSEZ7H/ne38f+gwvWtdKdeTg3mGrwmvXrUExzUfeVUgLZnYdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737602887; c=relaxed/simple;
	bh=5GycTph+pc6rdeS9MsAZUMYeIZ6Fcbw/kp5uTKJLn4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GDYm2eIG/n6qKhzG9kxCeoKXcSQlOkpyBs/fFACiKkmEckSkIeus6PLSnwd53hql+jk8U+dB+ADw4TjfaAl5i1kRVHCNLBv9/z4aDCYM3NZ6ZzegfiPjsHdqRMY/Tjne5k5yUfcnj9Lp3FVI6VUU+m8ivhvXIlb+2+L2NSS3f2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOsn1Qb2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOsn1Qb2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7048C4CED2;
	Thu, 23 Jan 2025 03:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737602887;
	bh=5GycTph+pc6rdeS9MsAZUMYeIZ6Fcbw/kp5uTKJLn4I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cOsn1Qb2nSaYIcUnwFMvfsFLsPoBR5qqqzrQR31X+CgQzYq4uVUNMeR1UtEjD50Hv
	 uAN75ESZ+7dZcWc0os8R55JaBHWi6mKuYqJ2RwlZt/c2zNA5/YB8BJpZHu2ib9MFVf
	 VMwLsBzFEH/Li7GHpKjDGzOY6bUwwSfxxijZGVG2Mc3lE5ATtuM990+9ne19lrfb/2
	 ILSUAknSr2S8bijZzH+ZjZI0Ctf2Llso4dO8I1mRPX/qNy+HEFtmbVRNW/sWm2uYLZ
	 QY/tGSj1plkV0+RZ+kzwAjxzb1Sd1lkcEYlk7CQ61WtRCzCbM7uQNCHrVegH4X27gj
	 kIcGWx52oz4Ig==
Message-ID: <d4c3c03c-14b5-43f3-bb0b-3415c4f174f8@kernel.org>
Date: Thu, 23 Jan 2025 12:28:03 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3 3/5] null_blk: fix zone resource management
 for badblocks
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>
References: <20250115042910.1149966-1-shinichiro.kawasaki@wdc.com>
 <20250115042910.1149966-4-shinichiro.kawasaki@wdc.com>
 <22e5c5a8-ad31-4a0f-a64e-33b34075a97d@kernel.org>
 <ltwae3kgwvmx37pro45rwenlmescfbcpt6zd6r3fx5o6z5fweq@6cx6tfnw2aw2>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <ltwae3kgwvmx37pro45rwenlmescfbcpt6zd6r3fx5o6z5fweq@6cx6tfnw2aw2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/20/25 5:33 PM, Shinichiro Kawasaki wrote:
> On Jan 18, 2025 / 08:00, Damien Le Moal wrote:
>> On 1/15/25 1:29 PM, Shin'ichiro Kawasaki wrote:
>>> When the badblocks parameter is set for zoned null_blk, zone resource
>>> management does not work correctly. This issue arises because
>>> null_zone_write() modifies the zone resource status and then call
>>> null_process_cmd(), which handles the badblocks parameter. When
>>> badblocks cause IO failures and no IO happens, the zone resource status
>>> should not change. However, it has already changed.
>>
>> And that is correct in general. E.g. if an SMR HDD encounters a bad block while
>> executing a write command, the bad block may endup failing the write command but
>> the write operation was already started, meaning that the zone was at least
>> implicitly open first to start writing. So doing zone management first and then
>> handling the bad blocks (eventually failing the write operation) is the correct
>> order to do things.
>>
>> I commented on the previous version that partially advancing the wp for a write
>> that is failed due to a bad block was incorrect because zone resource management
>> needed to be done. But it seems I was mistaken since you are saying here that
>> zone management is already done before handling bad blocks. So I do not think we
>> need this change. Or is it me who is completely confused ?
> 
> Based on your comment on the previous version, I checked the code and found
> the call chain was as follows:
> 
> null_process_zoned_cmd()
>  null_zone_write()
>   do zone resource management: zone resource management is done here,
>                                assuming writes always succeed
>   null_process_cmd()
>    null_handle_badblocks() ... v2 3rd patch added wp move for partial writes
> 
> So, the zone resource management was done before applying the v2 patch series.
> 
> However, the zone resource management did not care the write failure by
> badblocks. It assumed that as if the writes fully succeed always. When badblocks
> causes write failure for zoned null_blk, it leaves wrong zone resource status.

Not always. If the write that is being failed by null_handle_badblocks() makes
(or keeop) the zone open, that it is still correct. The zone condition is fine
as long as the zone does not become full. What is wrong though is that we will
also increment the zone write pointer before running null_handle_badblocks(), so
if the write is failed by that function, we endup with an incorrect write
pointer. But the zone condittion is not necessarily wrong. As commented before,
a real device will always open a zone before accessing the media. So an empty or
closed zone will always become open even if the write operation fails on the
first sector of the write.

> I would say, this patch does not respond to your comment for the previous
> version. It addresses the problem I found when I thought about your comment.
> 
> With this patch, the function call chain will be as follows:
> 
> null_process_zoned_cmd()
>  null_zone_write()
>   null_handle_badblocks()     ... checks how many sectors to be written
>   do zone resource management ... zone resource management is done reflecting
>                                   the result of null_handle_badblocks() call
>    null_handle_memory_backed()
> 
> The zone resource management part will be skipped when badblocks causes no
> write. The 5th patch in this 3rd series will modify null_handle_badblocks() to
> support partial writes by badblocks, and the zone resource management will be
> done for such partial writes.

Understood. But to be completely correct with the zone condition handling, we
should probably also do the zone resource management even if the write is failed
on its first sector, that is, even if the actual number of sectors to write is 0.


-- 
Damien Le Moal
Western Digital Research
