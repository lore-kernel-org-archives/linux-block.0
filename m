Received: from sg-1-12.ptr.blmpb.com (sg-1-12.ptr.blmpb.com [118.26.132.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18204E55C
	for <linux-block@vger.kernel.org>; Sat, 24 Jan 2026 15:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769267220; cv=none; b=rt7wd3KVNIOmS5Jfq7n7Mxq2/8SwARlD5TbzLmGsC9uqEFTudvLPy13OnmpwDRDbRCZCBXYiRPkVplPjqR0CYKb55lFAatVojlCOwu5CSqOWj4LL2nAIRg+X+77qEE5hK8NOeYbBvYQshVsdOBhIfmA82ucJeklOmYzwY8silYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769267220; c=relaxed/simple;
	bh=xpghcmGob4KO1DSWkzSQAff5nSSHeKEX4XCSxr+9vtU=;
	h=Date:References:In-Reply-To:Mime-Version:From:Subject:Message-Id:
	 To:Cc:Content-Type; b=rLIvcOrfQ9rBq2nB+AlRIwbo1+cOpMLHJ2FyOhqm/7hj+uH7FWqDcgt92qIFO7w06PkyHcGezFdP3v/nfjLeNZka8cHmjdXy/iPMIXUMRHxZqKJiwqS4nPCAO17DI9CFaHppxJXEUFYZDBdQnminPBmS+9f+7VyB1YUbjRksDFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=dqD5m9kM; arc=none smtp.client-ip=118.26.132.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="dqD5m9kM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1769267091;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=mAlKU3fvOentGx2ZwnSTcIq93vrhMZlUvdPWPcYSonI=;
 b=dqD5m9kMIstCjvtPvvH1+ihKXvCQHRcStF8aNdZe9kiuwk5RfkU9PiuC4qYCy0ySRS5x+N
 7fwBwgyCWJ4b476YEazeHhbckUxpvFUFv9cVIPs9fLwmPc3KhR4DPx/v4weL45BFfNoMTA
 MZLBsUciiPuBukc64rTL/lawdcugiAwg18UPtw2s+W+ttZdI88fMDpwLeyuErLr5jlSoIw
 j/QNNpVQnJHvynIDo0cZmfB5TnFv7kUzctFj1VeXZ91d9Ct/CZyJxr+7UoyiBxbBuKkrgL
 2rJ5HKDdJ+KdT5nJYijXkZMFg6xs9OqzzdkLknNauuYG+5ZIRkElbACwMtIL5Q==
Date: Sat, 24 Jan 2026 23:04:48 +0800
References: <20260123182623.3718551-1-yukuai@fnnas.com> <c3d421ba-0151-4a1b-b4f0-6d3ffe4b7d1f@kernel.dk>
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+26974df92+7ca68d+vger.kernel.org+yukuai@fnnas.com>
In-Reply-To: <c3d421ba-0151-4a1b-b4f0-6d3ffe4b7d1f@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from [192.168.1.104] ([39.182.0.137]) by smtp.feishu.cn with ESMTPS; Sat, 24 Jan 2026 23:04:49 +0800
Content-Transfer-Encoding: quoted-printable
From: "Yu Kuai" <yukuai@fnnas.com>
Subject: Re: [PATCH 0/2] md/md-llbimtap: fix two corner case problems
Message-Id: <2a774116-ffa3-4972-a591-52c33383234d@fnnas.com>
Reply-To: yukuai@fnnas.com
To: "Jens Axboe" <axboe@kernel.dk>, <linux-block@vger.kernel.org>, 
	<linux-raid@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <linan122@huawei.com>, <xni@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
X-Original-From: Yu Kuai <yukuai@fnnas.com>

Hi=EF=BC=8C

=E5=9C=A8 2026/1/24 11:38, Jens Axboe =E5=86=99=E9=81=93:
> On 1/23/26 11:26 AM, Yu Kuai wrote:
>> Yu Kuai (2):
>>    md/raid5: fix IO hang with degraded array with llbitmap
>>    md/md-llbitmap: fix percpu_ref not resurrected on suspend timeout
>>
>>   drivers/md/md-llbitmap.c | 4 +++-
>>   drivers/md/raid5.c       | 7 ++++++-
>>   2 files changed, 9 insertions(+), 2 deletions(-)
> Is this just for review, or do you want them picked up off the list
> too?
>
> Both look fine to me, fwiw.

I'll send a pull request soon.

Sorry for the noise, I used the wrong script that is used to send pull
request for this set.

>
--=20
Thansk,
Kuai
