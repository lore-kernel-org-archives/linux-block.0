Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF291D9A76
	for <linux-block@vger.kernel.org>; Mon, 16 Dec 2024 20:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734382463; cv=none; b=ky2Exw6cz0+XNvVG+t67Yzo9/497mvRlDhGFlnMnj7/GFsj9G0kaDODaWhMKsjZoolUrEMp6yFl6JJc4EPKFpNqg5TXHLd1pV7oi9OE1cK/3Lix7N87tl6n7VLC98k9Tvgsel0DXuEPyDFf5qg+I9ogf6Gqhc3SH/QABMcLHTRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734382463; c=relaxed/simple;
	bh=UGr3gv7driZPKRHCMvH3nWIVSXSnFvnG/eLjLAMUoY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kRWSDWmxpABOmgzDpFRE/yyKLE7w+YY0i/qHmsIB+OaVQUNH6O+2KGMtpdMdCTFRc94c4+aRKEt2TeDOMgmy92eyKT8OaZSvQYn9OvT11Z3RyYCrIpCIyq9wy6GZxaZlA0QvumL0A3pZl0xTqefavHfNipckxm5HnnDmZAHwwx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EC0vq86X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EC0vq86X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4F9C4CED0;
	Mon, 16 Dec 2024 20:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734382463;
	bh=UGr3gv7driZPKRHCMvH3nWIVSXSnFvnG/eLjLAMUoY4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EC0vq86XysvnkweYSIKFcaIJnavvAjiew1KHOyGYbq5MbvXx2WYiAaXkXOAtaqVnj
	 hR0eVM/IFF/IiQFsBfMT+rRHtiXBJtngdY1CLgEilmMc+ivzR8uw/7Q6bZDTDXITXk
	 ZhaSrwa4uexvkyv67x6uBPeOsb6sdjI7o8z2UoWlPyQgSkASKhmDzDW/Pkle0Nx0SU
	 q31MPE0jWfBMmP0PBMN+IF8bqQg+bJRV7qaC2syjx8BmYmI3FRadznlAe0u8APAVQ2
	 ScVW9k09WJFPyfs22SxXmDuQKX2R2ug4x4e+BCQy16eJNy1JMFCMaAd+LjEXZ3mhxb
	 GmlqYCtTkmjpg==
Message-ID: <3bc4b958-73ea-47d4-9b94-299db1f7ee3e@kernel.org>
Date: Mon, 16 Dec 2024 12:54:22 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zoned storage and BLK_STS_RESOURCE
To: Bart Van Assche <bvanassche@acm.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <e75812ec-9b91-42d0-9ca5-d4bae031e319@acm.org>
 <ed186d84-1652-4446-8da1-df2ed0d21566@kernel.org>
 <ba8caf98-8b09-4494-add8-31381b04cd33@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ba8caf98-8b09-4494-add8-31381b04cd33@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/12/16 12:42, Bart Van Assche wrote:
> 
> On 12/16/24 12:23 PM, Damien Le Moal wrote:
>> On 2024/12/16 11:24, Bart Van Assche wrote:
>>> If 'qd=1' is changed into 'qd=2' in tests/zbd/012 then this test fails
>>> against all kernel versions I tried, including kernel version 6.9. Do
>>> you agree that this test should pass? If you agree with this, do you
>>> agree that the only solution is to postpone error handling of zoned
>>> writes until all pending zoned writes have completed and only to
>>> resubmit failed writes after all pending writes have completed?
>>
>> Well, of course: if one write fails, the target zone write pointer will not
>> advance as it should have, so all writes for the same zone after the failed one
>> will be unaligned and fail. Is that what you are talking about ?
>>
>> With the fixes applied to rc3, the automatic error recovery in the block layer
>> is gone. So it is up to the user (FS, DM or application) to do the right thing.
> 
> Hi Damien,
> 
> For non-zoned storage the BLK_STS_RESOURCE status is not reported to the
> I/O submitter (filesystem). The BLK_STS_RESOURCE status causes the block
> layer to retry a request. For zoned storage if the block driver reports
> the BLK_STS_RESOURCE status and if QD > 1 then the submitter
> (filesystem) has to retry the I/O. Isn't that inconsistent? Solving this
> inconsistency is one reason why I would like to postpone handling of
> zoned write errors until all pending I/O has either completed or failed.

As I said, if one write does not work, whatever the reason, all other writes
behind it for the same zone will also not work. So yes, handling of errors in
the end needs to be done after all writes come back to the issuer. Nothing new
here. I do not see the issue. And I am not sure where you want to go with this.

> Another reason is that this behavior change is an essential step towards
> supporting write pipelining. If multiple zoned writes are outstanding,
> and the block driver postpones execution of any of these writes (unit
> attention, BLK_STS_RESOURCE, ...) then any zoned writes must only be
> resubmitted after all pending zoned writes have either completed or failed.

Yes. But I am still confused. Where is the problem ?

> 
> Thanks,
> 
> Bart.


-- 
Damien Le Moal
Western Digital Research
