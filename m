Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD3F486BA9;
	Thu, 17 Sep 2026 22:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789683569; cv=none; b=DlV0ckSz0geLdU/uEJhzAQvEXFLNa4wMQPBQ+0D/pgr9fY6pIpbSVOTQRKgn+fOws8ZH0G15LWvfd7RAkS3trFGQIl1Jrgbag3MetIhs5WBLaJA8vCYHsAZLkM8wuNgE+6kVNJ8h25gEvasAIfXmbXZYxPuwIJ6Tu+42DCVYkQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789683569; c=relaxed/simple;
	bh=iLBVu2IeYh6SVWPvL2AniNJEg7ZKDyXWP+dVeEuhFH4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KaIpwb1sbxTvpWKwQfHwFL9ucnrWeNMaMNShJmsaCBxKtHQfCelH2DQ/68tPuMvYI2CQlvRQzm6F9dQwJf1mRZl6YLySS5qJoewXkKV2fOBig2GIAjRXL6OGmJJwvCnwEIG6xu0uwgc4xRSlN4Tnm5x0XW1w55b94WRBonjrlC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 68HMIbPc001054;
	Fri, 18 Sep 2026 07:18:37 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 68HMIaLM001051
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 18 Sep 2026 07:18:36 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e2eca9dc-09ca-4f7b-9fca-9ad6ce72c9b9@I-love.SAKURA.ne.jp>
Date: Fri, 18 Sep 2026 07:18:36 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] loop: Perform __loop_clr_fd() after disk->open_mutex
 is dropped.
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Foster
 <bfoster@redhat.com>,
        Damien Le Moal <dlemoal@kernel.org>, Hillf Danton <hdanton@sina.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Ming Lei <tom.leiming@gmail.com>, Qu Wenruo <wqu@suse.com>,
        Tao Cui <cui.tao@linux.dev>, kernel test robot <lkp@intel.com>,
        linux-block <linux-block@vger.kernel.org>,
        rust-for-linux@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Nilay Shroff <nilay@linux.ibm.com>
References: <60bf7af2-b84e-4056-9195-a26ad51ada46@I-love.SAKURA.ne.jp>
 <9f1273a7-6dfe-46bb-966f-fe08876f4375@I-love.SAKURA.ne.jp>
 <3883b05e-0a34-43f7-b2a9-a46d2b0c5ffc@acm.org>
 <08b0057a-280d-4e55-8e94-e510ec1a371f@I-love.SAKURA.ne.jp>
 <d89aa722-2d13-4733-b5c1-f0194bf4b342@acm.org>
 <15037162-0e54-4722-ac7e-c9a863a8a2f7@I-love.SAKURA.ne.jp>
 <b700652d-ed63-444a-b879-ec2725affaa7@acm.org>
 <6fdefda9-c7e4-4368-8d9a-280043b4051e@I-love.SAKURA.ne.jp>
 <e8fd7e8c-4a14-49d6-8bce-16fd44d864b9@acm.org>
 <2dd38a68-4ceb-48d5-953d-7ea2c7122418@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <2dd38a68-4ceb-48d5-953d-7ea2c7122418@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav311.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/09/16 7:38, Tetsuo Handa wrote:
>> Userspace applications and tests (such as mount/umount, losetup, systemd, and xfstests) expect that:
>> 1. Teardown of a loop device with LO_FLAGS_AUTOCLEAR completes
>>    synchronously during the final close() (in lo_release()), releasing
>>    the backing file references (fput()).
> 
> App1 is achieving it via the combination of lo_release() and lo_post_release().
> 
>> 2. Calling open() immediately after close() succeeds (allowing the loop
>>    device to be immediately reallocated, reopened, or configured in
>>    Lo_unbound state).
> 
> App1 is achieving it via the combination of lo_release() and lo_post_release().
> 
> So, what is wrong?

Since you are mimicking my patch, you agreed that there is no problem with my patch, don't you?
Then, why not respond to my patch with Acked-by or Reviewed-by line?

