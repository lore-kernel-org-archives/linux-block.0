Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F9F21A43B;
	Tue, 12 Aug 2025 06:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754980132; cv=none; b=P8TMrUqAzw1TrwnZnFVQmHBWtrXPEZ5626c4vX7U2yS+aXQhxs8kLBZwLslgWXBbTblcFBtKDSredPBYUKBciFOxq2PelVgDSPXpumBCF56cIKGydf5re+LImWVXDz8iCV8VvIFSNYgPLBJYsa0ivGTLJmEhddwsLmUONg+M+fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754980132; c=relaxed/simple;
	bh=La7H9eByYagCohgqxw2G3+7zgFCfw7Yo597djXDnUI8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y7JoT9vNk/Rx4AuGz8YO48IRdBPGIH2naDuakPBFzx8NrGfJcXhQmanHPdQ0KbHCvvdZqlhKY3rKVYBSJ24Vo3QX5izFC6WrGG+cychAiRqlo+5vv6djfY0pK1a3Q230WawV3AfkYe0zg7ISkOFJzsTQo6J5wa3a2sYDhB3a6i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1k9fuZq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1k9fuZq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6BDC4CEF5;
	Tue, 12 Aug 2025 06:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754980131;
	bh=La7H9eByYagCohgqxw2G3+7zgFCfw7Yo597djXDnUI8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=a1k9fuZqk/kOMkIEp11qlXl3Qx+u0W/KFGDziAfY78Q72ClFmLm+POlw50Vfogvg8
	 OhOItv0BpS/V/TYbh8m0oYOUIpkD9iIDYOyZ3/dCbdRg08xd5GnUZkwP+7dwQZKZ4e
	 ZvjubE22oGFfuVufiZx1AYnla3xjP5RTk1fAhNNgx2MyBvtULuXgp3pQ5kP1SKyP/I
	 spePuE4VbfxV41b4eGC2cNvgP+gl8RI1sWVm8e93WjJ2zYXwQV4F6Vl+Df2snQKwPo
	 4q7JXvVCL70drl/JoFl9KiLHO8R+ZnYn/zjESEsscFgi9Bt6w68NPO0ZUlkRoJtURr
	 RwNEAlbN4FNRg==
Message-ID: <c5195d5c-5f71-4057-9522-228b48e4cd90@kernel.org>
Date: Tue, 12 Aug 2025 14:28:46 +0800
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
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <aJnLXmepVBD4V2QH@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/11/25 18:52, Christoph Hellwig wrote:
> On Thu, Aug 07, 2025 at 11:48:38AM +0800, Chao Yu wrote:
>> This patch introduces a new sysfs entry /sys/fs/f2fs/<disk>/flush_policy
>> in order to tune performance of f2fs data flush flow.
>>
>> For example, checkpoint will use REQ_FUA to persist CP metadata, however,
>> some kind device has bad performance on REQ_FUA command, result in that
>> checkpoint being blocked for long time, w/ this sysfs entry, we can give
>> an option to use REQ_PREFLUSH command instead of REQ_FUA during checkpoint,
>> it can help to mitigate long latency of checkpoint.
> 
> That's and odd place to deal with this.  If that's a real issue it
> should be a block layer tweak to disable FUA, potentially with a quirk
> entry in the driver to disable it rather than having to touch a file
> system sysfs attribute.

Okay, it makes sense to control how FUA be handled inside block layer, so
let's drop this patch.

BTW, I suffered extremely long latency of checkpoint which may block every
update operations when testing generic/299 w/ mode=lfs mount option in qemu,
then I propose to use PREFLUSH instead of FUA to resolve this issue.

"F2FS-fs (vdc): checkpoint was blocked for 24495 ms"

I just realize that using cache=directsync option in qemu can avoid FUA hang
issue, anyway, let me test more w/ this option.

Thanks,
