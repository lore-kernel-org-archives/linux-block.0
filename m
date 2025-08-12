Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFB02DEA7E;
	Tue, 12 Aug 2025 07:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754985239; cv=none; b=b+VkrowRwHxAnt5gPWTV17oIZWKUp+K8j0/vdrd9ua5u/nYalXMIOtnwbHtfTOh40KJySg77JNPfVu5sOe9NEo0jwEDGjcVrRhCuvKA2RoHCl6Fo4080EcOrXjKryAb5vPS6BARiM05PndPDyfUjsiNjPiQeNyhYGlBN9TwkdOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754985239; c=relaxed/simple;
	bh=sw8wLAIZdKxUOMDtddxEFYfkLyHWxf/hNcZfBt9jddc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cJ2PDMOiukMMiREvCC00uR6G7dwvM9VYKim5ywz/jKlqUPHlmBv5hoFB7rkamJMNmLWxOgpzeFgpflZLGnEwILMKJWyhZSupby+1DN7aADANRKQsXtycCxqB5MZJnJndTMDBQVmPe54hW1Wrpu2HocwQSPrVCIIKr3MLkczaj5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jh3uStF3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jh3uStF3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B358C4CEF0;
	Tue, 12 Aug 2025 07:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754985239;
	bh=sw8wLAIZdKxUOMDtddxEFYfkLyHWxf/hNcZfBt9jddc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=jh3uStF3r13oKRFs0sLYrM2446Mi+VB8hpHKE9Zh83l99O+usPogtPFDkMn9Q5GM1
	 ulEPEVxJhe/iJdSxhpCcEs7THsZMAfxFmWt0cASdTay3BP6NgUC5bXq3e2Rj5NUrH3
	 AGUweTGCW+hwhMuQ9gFmRjR9UW5kyJq9d1bhq5qBCtDVf150CeQW15gSD+CjZxwgWg
	 U4heXQ0DgqonUyh78GfP/hhONpJOUWjPBxp1Gl0afR5DNOMx7QCTJT0ecG+2n5k9EB
	 zJS5Y+vwsB//qSKw/W1Zb4OfmVnzGQiXWwtqp5AciGajSdR1iXRJwT6y+ZMP7hxh/Q
	 DEBA8uRrQMeEQ==
Message-ID: <dec5b832-53f1-4274-902c-418f01df9458@kernel.org>
Date: Tue, 12 Aug 2025 15:53:54 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
Subject: Re: [PATCH v3] f2fs: introduce flush_policy sysfs entry
To: Christoph Hellwig <hch@infradead.org>
References: <20250807034838.3829794-1-chao@kernel.org>
 <aJnLXmepVBD4V2QH@infradead.org>
 <c5195d5c-5f71-4057-9522-228b48e4cd90@kernel.org>
 <aJruCTOjcj1nEk-S@infradead.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <aJruCTOjcj1nEk-S@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/25 15:32, Christoph Hellwig wrote:
> On Tue, Aug 12, 2025 at 02:28:46PM +0800, Chao Yu wrote:
>> BTW, I suffered extremely long latency of checkpoint which may block every
>> update operations when testing generic/299 w/ mode=lfs mount option in qemu,
>> then I propose to use PREFLUSH instead of FUA to resolve this issue.
>>
>> "F2FS-fs (vdc): checkpoint was blocked for 24495 ms"
>>
>> I just realize that using cache=directsync option in qemu can avoid FUA hang
>> issue, anyway, let me test more w/ this option.
> 
> Well, for decent qemu performance you always want to use DIRECT I/O.
> directsync is generally not a very good idea as it forces every write
> to be synchronous and will give you very bad performance.

Yeah, I think that may hurt the performance too, at least, I don't see
any obvious change for time cost of generic/299 testcases, but still I
need to run all my testcase to see what will happen. :)

generic/299 115s ...  113s

> 
> What did you use before?  At least for older qemu the default was
> buffered I/O, which can lead to very expensive fua or flush calls.

Previously, I didn't use any cache= option, as manual described, it
should equal to cache=wrteback.

Thanks,

