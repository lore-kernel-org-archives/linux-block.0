Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3053138553C;
	Wed, 25 Mar 2026 21:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774474193; cv=none; b=ZafyRgDukum5iFN2wHsRHig/Ip7Vx8HtU4tgjFI/G8b9+HWBs6EVm/HCIFOcBG8xftCch/tSqb7kcd7ndDL6JBNvvlTQW094tCXNyxh+h3k7unSfx0Tb/Mk8GJxI7FIuG0Buztp6i0VMFL90oTcdz/CH/WnYNk1V51FFgX14sgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774474193; c=relaxed/simple;
	bh=BYUqf4WQw6IJsNm9lyVY1feqRun33qdwx02NVZPDtQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mBh2NP9D1/CY7gmj/U41KmNq3rHV756UbmZ9WbYLYpXWsyC/8LSFNYJDB33hWbjO6JWj2gzvP8rthZkeaWB3suDIzu/M01iWdHdj9wveeD+FJOvh6+sCRcrPQ8euL+pM+u+MMME6Cf9vyUNX3Ws6moaj+Pe74SEJDxOulU003Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7K4KVXS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7K4KVXS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26284C4CEF7;
	Wed, 25 Mar 2026 21:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774474192;
	bh=BYUqf4WQw6IJsNm9lyVY1feqRun33qdwx02NVZPDtQs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E7K4KVXSRbE86MfSScMWZdI5vyjUoohtdYvNK0jw4TQMDOh5Ri0kykymD2N2nT7M8
	 j0TvrN3ET9FctdZYcBGZpuUIHZ+wX+JPTgPEOLFU2LvrizfeLb0nJXPM75Jud58u8D
	 z4rLG17XjJzHUC5iUgO1rEm/5y1W8ZAXwLCYHyvnfkXBUXdQ+7TRityA3rHD00AvIq
	 nHHd51flq55HkrUc1cb2cHqftTrkdPtWWDjrfxzpT3eBJLREitJJyNCnleA4wCh1cL
	 8NYp6nDo0tg1n6a/56+RlHGRW0RJMD3qtZJJnerdzpT+dqpLRmZx5P3WCr+mzeSs7D
	 wrYlbkNpJptvg==
Message-ID: <a65dee68-6b8b-44ae-9296-7fde63322083@kernel.org>
Date: Wed, 25 Mar 2026 17:29:51 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] iov: Bypass usercopy hardening for kernel iterators
To: Kees Cook <kees@kernel.org>
Cc: viro@zeniv.linux.org.uk, gustavoars@kernel.org,
 linux-hardening@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20260303162932.22910-1-cel@kernel.org>
 <202603251421.20D29E29@keescook>
From: Chuck Lever <cel@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <202603251421.20D29E29@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/25/26 5:27 PM, Kees Cook wrote:
> On Tue, Mar 03, 2026 at 11:29:32AM -0500, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> Profiling NFSD under an iozone workload showed that hardened
>> usercopy checks consume roughly 1.3% of CPU in the TCP receive
>> path. The runtime check in check_object_size() validates that
>> copy buffers reside in expected slab regions, which is
>> meaningful when data crosses the user/kernel boundary but adds
>> no value when both source and destination are kernel addresses.
>>
>> Split check_copy_size() so that copy_to_iter() can bypass the
>> runtime check_object_size() call for kernel-only iterators
>> (ITER_BVEC, ITER_KVEC). Existing callers of check_copy_size()
>> are unaffected; user-backed iterators still receive the full
>> usercopy validation.
>>
>> This benefits all kernel consumers of copy_to_iter(), including
>> the TCP receive path used by the NFS client and server,
>> NVMe-TCP, and any other subsystem that uses ITER_BVEC or
>> ITER_KVEC receive buffers.
> 
> So, I'm not a big fan of this just because the whole point is to catch
> unexpected conditions, but there is a reasonable point to be made that
> this case shouldn't be covered by kernel/kernel copies.
> 
>>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  include/linux/ucopysize.h | 10 +++++++++-
>>  include/linux/uio.h       |  9 +++++++--
>>  2 files changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/ucopysize.h b/include/linux/ucopysize.h
>> index 41c2d9720466..b3eacb4869a8 100644
>> --- a/include/linux/ucopysize.h
>> +++ b/include/linux/ucopysize.h
>> @@ -42,7 +42,7 @@ static inline void copy_overflow(int size, unsigned long count)
>>  }
>>  
>>  static __always_inline __must_check bool
>> -check_copy_size(const void *addr, size_t bytes, bool is_source)
>> +check_copy_size_nosec(const void *addr, size_t bytes, bool is_source)
> 
> "nosec" is kind of ambiguous. Since this is doing the compile-time
> checks, how about naming this __compiletime_check_copy_size() or so?

No problem.


>>  {
>>  	int sz = __builtin_object_size(addr, 0);
>>  	if (unlikely(sz >= 0 && sz < bytes)) {
>> @@ -56,6 +56,14 @@ check_copy_size(const void *addr, size_t bytes, bool is_source)
>>  	}
>>  	if (WARN_ON_ONCE(bytes > INT_MAX))
>>  		return false;
>> +	return true;
>> +}
>> +
>> +static __always_inline __must_check bool
>> +check_copy_size(const void *addr, size_t bytes, bool is_source)
>> +{
>> +	if (!check_copy_size_nosec(addr, bytes, is_source))
>> +		return false;
>>  	check_object_size(addr, bytes, is_source);
>>  	return true;
>>  }
>> diff --git a/include/linux/uio.h b/include/linux/uio.h
>> index a9bc5b3067e3..f860529abfbe 100644
>> --- a/include/linux/uio.h
>> +++ b/include/linux/uio.h
>> @@ -216,8 +216,13 @@ size_t copy_page_to_iter_nofault(struct page *page, unsigned offset,
>>  static __always_inline __must_check
>>  size_t copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
>>  {
>> -	if (check_copy_size(addr, bytes, true))
>> -		return _copy_to_iter(addr, bytes, i);
>> +	if (user_backed_iter(i)) {
>> +		if (check_copy_size(addr, bytes, true))
>> +			return _copy_to_iter(addr, bytes, i);
>> +	} else {
>> +		if (check_copy_size_nosec(addr, bytes, true))
>> +			return _copy_to_iter(addr, bytes, i);
>> +	}
>>  	return 0;
>>  }
> 
> This seems reasonable with the renaming, though I might come back some
> day and ask that this get a boot param or something (we have a big
> hammer boot param for usercopy checking already, but I like this more
> focused check).
> 

Thanks for having a look. An additional question is whether the
"copy from" direction needs similar treatment. Performance analysis
found "copy to" was an issue for my particular workload (NFSD) but
it's plausible that "copy from" should be handled similarly.

-- 
Chuck Lever
