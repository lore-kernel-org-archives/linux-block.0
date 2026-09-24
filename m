Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FBA3002CF;
	Thu, 24 Sep 2026 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257696; cv=none; b=PobIhCJbm7wRWIs+5XDEIgEQshbKzn9ZaKga7Rejs2s+KbJb0n8Ycu/majAjR1ZO05QNP1LFLgn7ryiSzmgWF1N2Ymb6tjGNN9jCvA20Z1rVv3EZsScSRYrscQXc6PjY4T5i7baCY7QstHHLKa61YhrZ6uxugKDdOgRnSEw1q0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257696; c=relaxed/simple;
	bh=5kC7JDWIoM/3unS9E6JWjLJ5UFkpfFnUOWZ2Nua6BoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K4mw8myLJ7iglYpbpBmnCLbCugsPA5CfuliRS2P3xBCkHifIAKF1xv2iKqpKCoWLyZkaU+wez8tWaWZ3oI3qdg29oM9HUF3hEJgKFUyCxneJbjWRTcOweDlAaf9iYSTx2VtobnuCPS1XZMi9pMr60kijkWxJncP+EK3CCB6iXUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 68ODkcNH017868;
	Thu, 24 Sep 2026 22:46:38 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 68ODkcBo017863
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 24 Sep 2026 22:46:38 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7d369be0-13c4-4d5a-a90b-516660508117@I-love.SAKURA.ne.jp>
Date: Thu, 24 Sep 2026 22:46:34 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] block: Add post_release() operation
To: Gary Guo <gary@garyguo.net>, Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>, linux-block <linux-block@vger.kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Foster
 <bfoster@redhat.com>,
        Damien Le Moal <dlemoal@kernel.org>, Hillf Danton <hdanton@sina.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Ming Lei <tom.leiming@gmail.com>, Qu Wenruo <wqu@suse.com>,
        Tao Cui <cui.tao@linux.dev>, kernel test robot <lkp@intel.com>,
        rust-for-linux@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nilay Shroff <nilay@linux.ibm.com>
References: <69960302-1535-441a-be4e-d652766d65c2@I-love.SAKURA.ne.jp>
 <DLMWXEJS130L.2WSB0G2YD3LY7@garyguo.net>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <DLMWXEJS130L.2WSB0G2YD3LY7@garyguo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav413.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/09/24 3:38, Gary Guo wrote:
>> diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
>> index fc97dd873974..2ff77ef49781 100644
>> --- a/rust/kernel/block/mq/gen_disk.rs
>> +++ b/rust/kernel/block/mq/gen_disk.rs
>> @@ -129,6 +129,7 @@ pub fn build<T: Operations>(
>>              submit_bio: None,
>>              open: None,
>>              release: None,
>> +            post_release: None,
>>              ioctl: None,
>>              compat_ioctl: None,
>>              check_events: None,
> 
> Ideally we'd use
> 
>     ..pin_init::zeroed()
> 
> At the end of the struct expression to zero out all other fields instead of
> manually zeroing each single field.
> 
> This is pre-existing issue though, so leaving as is is also fine.

You can submit a patch, as I'm not familiar with Rust. I see no problem
as long as we don't hit build failures due to racing with your patch and
this patch.
