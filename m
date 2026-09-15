Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB372FD7B1;
	Tue, 15 Sep 2026 22:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789511991; cv=none; b=ZWywRlvKHhllzxtHTxZcXIYKHJI0v2ilQ6jdnU4Ya5TrCs1mlGDQAdJMcv1pKb9S6NYtpBr2bmpMiGMVTMq0m6edZUG+liNDO4ciIOWWkhwpMn6JgJ2T5l+aeq6IF4eN+5+9ZVuMPSOqHg+/EKLBad9jfRy0ZcV1zg73d2ov54E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789511991; c=relaxed/simple;
	bh=BytfvsOQXDGpqrDU7apJCC+qNjb/4afOahQqHgZcpQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lKxieleDj85iUUxwyxf7komV5MAwo/uUgXlVE5iHr6p2hBIwtZO5WOO6poN3ZJ3YpDXz7Xl6xK3RqgFbu3rQXoeIWYNGSCgFB2tpAxK6YsEVcQy/GEvEhYQje2zOjWKuo6wvZo0fBlbbnX2Zy2GbHUZCVmR8xrAC3zRR4VQ82Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 68FMciqg048547;
	Wed, 16 Sep 2026 07:38:44 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 68FMci0x048544
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 16 Sep 2026 07:38:44 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <2dd38a68-4ceb-48d5-953d-7ea2c7122418@I-love.SAKURA.ne.jp>
Date: Wed, 16 Sep 2026 07:38:43 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] loop: Perform __loop_clr_fd() after disk->open_mutex
 is dropped.
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Foster
 <bfoster@redhat.com>,
        Damien Le Moal <dlemoal@kernel.org>, Hillf Danton <hdanton@sina.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Ming Lei <tom.leiming@gmail.com>, Qu Wenruo <wqu@suse.com>,
        Tao Cui <cui.tao@linux.dev>, kernel test robot <lkp@intel.com>,
        linux-block <linux-block@vger.kernel.org>,
        rust-for-linux@vger.kernel.org
References: <60bf7af2-b84e-4056-9195-a26ad51ada46@I-love.SAKURA.ne.jp>
 <9f1273a7-6dfe-46bb-966f-fe08876f4375@I-love.SAKURA.ne.jp>
 <3883b05e-0a34-43f7-b2a9-a46d2b0c5ffc@acm.org>
 <08b0057a-280d-4e55-8e94-e510ec1a371f@I-love.SAKURA.ne.jp>
 <d89aa722-2d13-4733-b5c1-f0194bf4b342@acm.org>
 <15037162-0e54-4722-ac7e-c9a863a8a2f7@I-love.SAKURA.ne.jp>
 <b700652d-ed63-444a-b879-ec2725affaa7@acm.org>
 <6fdefda9-c7e4-4368-8d9a-280043b4051e@I-love.SAKURA.ne.jp>
 <e8fd7e8c-4a14-49d6-8bce-16fd44d864b9@acm.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <e8fd7e8c-4a14-49d6-8bce-16fd44d864b9@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav414.rs.sakura.ne.jp

On 2026/09/16 2:36, Bart Van Assche wrote:
> On 9/11/26 6:22 PM, Tetsuo Handa wrote:
>> On 2026/09/12 10:02, Bart Van Assche wrote:
>>> On 9/11/26 3:18 PM, Tetsuo Handa wrote:
>>>> On 2026/09/12 5:03, Bart Van Assche wrote:
>>>>> On 9/10/26 2:44 AM, Tetsuo Handa wrote:
>>>>>> On 2026/09/10 4:33, Bart Van Assche wrote:
>>>>>>> __loop_clr_fd() is queued from the lo_post_release() callback and hence
>>>>>>> may be called concurrently with or after another thread has called
>>>>>>> bdev_open(). Hence, lo->lo->state should be checked instead of assuming
>>>>>>> that it equals Lo_rundown.
>>>>>>
>>>>>> No, __loop_clr_fd() is queued from the lo_release() callback.
>>>>>
>>>>> Yes, it is *queued* from the lo_release() callback function but there is
>>>>> no guarantee that __loop_clr_fd() has started before bdev_open() is
>>>>> called again.
>>>>
>>>> Since lo->lo_state was set to Lo_rundown by lo_release(), lo_open() will return -ENXIO.
>>>> What can go wrong if bdev_open() is called again before __loop_clr_fd() starts?
>>>
>>> This breaks LO_FLAGS_AUTOCLEAR, isn't it?
>>
>> Why do you think so?
>>
>>    App1                   App2                   system_long_wq
>>    Calls lo_release().
>>      Schedules __loop_clr_fd().
>>                           Calls lo_open() but fails with -ENXIO.
>>                                                  Starts __loop_clr_fd().
>>    Calls lo_post_release().
>>      Starts waiting for completion of __loop_clr_fd().
>>                                                  Finishes __loop_clr_fd().
>>      Finishes waiting for completion of __loop_clr_fd().
>>
>>    Calls lo_open() again and succeeds.
>>                           Calls lo_open() again and succeeds.
>>
>> App1's open() after close() is succeeding.
>> App2's open() being temporarily failing with -ENXIO should be acceptable.
>> If App2 wants to avoid repeatedly failing with -ENXIO, App2 should use
>> ioctl(LOOP_CTL_GET_FREE) before open().
> 
> Userspace applications and tests (such as mount/umount, losetup, systemd, and xfstests) expect that:
> 1. Teardown of a loop device with LO_FLAGS_AUTOCLEAR completes
>    synchronously during the final close() (in lo_release()), releasing
>    the backing file references (fput()).

App1 is achieving it via the combination of lo_release() and lo_post_release().

> 2. Calling open() immediately after close() succeeds (allowing the loop
>    device to be immediately reallocated, reopened, or configured in
>    Lo_unbound state).

App1 is achieving it via the combination of lo_release() and lo_post_release().

So, what is wrong?
