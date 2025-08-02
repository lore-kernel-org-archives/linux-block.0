Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F35128395
	for <linux-block@vger.kernel.org>; Sat,  2 Aug 2025 23:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754178651; cv=none; b=EjMPezkb2Uf1qW7vcW2twbcC13OiezaW+tBFfGC2accTM+1XsPx+Hu6ui0qDqyhw2eZBleX7Xqq6HiNa4PVLihcvDn+j/s+O6SU8H88550VwAlv0+RI3cLsV0mYqxu7JSFH1ctQxxydICSUcx+y7su6Ubt0KZdSMH5O2dUvMxbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754178651; c=relaxed/simple;
	bh=NwkFYrHxLool1VfZWHjMYCRbgx8L8vOcK4CqAgJhE1M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=R4qYa1/gLzhN9NEUm5LUGNMp6BTS1SKDxbrlJPmfsHGpLVQl5paecg8k230YlKXnS3IDtXmUI+ygcERYPXDgzW1sCssUqDuEGyba+udw11Mnm1ILrTDXa8hfgWvgEiyc6idC7FMmBnlbnI1awi5KPBagUtT3OpVEg0b70oMex00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHX229Oy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHX229Oy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED291C4CEEF;
	Sat,  2 Aug 2025 23:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754178650;
	bh=NwkFYrHxLool1VfZWHjMYCRbgx8L8vOcK4CqAgJhE1M=;
	h=Date:From:Reply-To:Subject:To:Cc:References:In-Reply-To:From;
	b=CHX229OyJ9ed3VDr/mv7yd5GGSvxdR//lO4wvocpjhBLMvsW8nByHwpQSqWXC9x0u
	 QTlWnm+BOl6vsBMEuMTVCZCGXx7TLXeakgaArLjmOA05xG2PL5aP1THEWcDMTSbvc4
	 FqjafktbINUeUzsGBQqyGveALKrMM+O4fm44A+j1TMUbq880s3AaF0jPrsYR/mgZQy
	 vUV84RXp7TWFOGvpH7A8jTxSLLxp+nStpztbk7iQeCAy9sV/XmBfipsalFSsonGwNw
	 WZgV3Fb5zkDkIRYQZqX1LuvrCZHFw4qi8jFSrg50tNGqPdUr2orduIISiBaK+0Q0jQ
	 yKnxSim6s19qg==
Message-ID: <5884b30a-8ffc-48a1-b944-675441626fc7@kernel.org>
Date: Sun, 3 Aug 2025 07:50:44 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Yu Kuai <yukuai@kernel.org>
Reply-To: yukuai@kernel.org
Subject: Re: [GIT PULL] md-6.17-20250803
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 inux-raid@vger.kernel.org, song@kernel.org
Cc: yukuai3@huawei.com, yangerkun@huawei.com, yi.zhang@huawei.com,
 johnny.chenyi@huawei.com, xni@redhat.com, heming.zhao@suse.com,
 linan122@huawei.com, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>
References: <20250802172507.7561-1-yukuai@kernel.org>
 <0c680f7d-f656-4e79-8e1e-b6f2e5155a80@kernel.dk>
 <f02514c1-6f29-4029-a80f-f68202a863d0@kernel.dk>
Content-Language: en-US
In-Reply-To: <f02514c1-6f29-4029-a80f-f68202a863d0@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi, Jens

在 2025/8/3 5:42, Jens Axboe 写道:
> On 8/2/25 12:29 PM, Jens Axboe wrote:
>> On 8/2/25 11:25 AM, Yu Kuai wrote:
>>> Hi, Jens
>>>
>>> Please consider pulling following changes on your block-6.17 branch,
>>> this pull request contains:
>>>
>>> - mddev null-ptr-dereference fix, by Erkun
>>> - md-cluster fail to remove the faulty disk regression fix, by Heming
>>> - minor cleanup, by Li Nan
>>> - mdadm lifetime regression fix reported by syzkaller, by Yu Kuai
>>> - experimental feature: introduce new lockless bitmap, by Yu Kuai
>> Why was this sent in so late? You're at least a week later sending in
>> big changes for the merge window, as we're already half way through it.
>> Generally anything big should land in my tree a week before the merge
>> window OPENS, not a week into it.
> I took a closer look, because perhaps you just sent in the pull request
> pretty late. And it's a bit hard to tell because it looks like you
> rebased this code (why?), but at least the lockless bitmap code looks
> like it was finished up inside the merge window. That looks late. The
> rest looks more reasonably timed, just rebased for some reason.
>
> If I'm going to get yelled at by a traveling Linus, there better be a
> good reason for it. In other words, is there a justification for the
> lockless bitmap code being in there?

Apologies for the late submission - this was unintentional. The core changes
were ready before 6.15, but the final llbitmap patch got delayed due to 
review
backlog.

About the last patch:
  - all feedback are addressed 2 weeks ago
  - still waiting formal Reviewed-by tag, not sure why, possibly due to 
this patch
     is huge.

About the rebase, this is because llbitmap set has conflicts with other 
patches
during the period, and I sent a new version and just pick it last night.

I do take a bet sending this pr last night, and hoping llbitmap won't 
delayed to
next merge window again.  However, I fully understand if this misses 6.17,
I'm prepared to defer to 6.18.

Thanks,
Kuai


