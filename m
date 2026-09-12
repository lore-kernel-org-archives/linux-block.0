Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAD19463;
	Sat, 12 Sep 2026 01:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789176209; cv=none; b=OrI5qwj6l0uUgUV31RIa7f74orx5/tyWFGg51O5U6gnQljyP2Ds2stjzm90qRjdJGA+FVh25L3NdRt3h0KMGLDm99r40dyZsPTE2Yasa0LR5QJwQ8oA3B0VozOtCLPSZ3RIBRwaqEFgkVpPv7HAf4yt7h/+H0MEKXupFEa6m9OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789176209; c=relaxed/simple;
	bh=hxhQ/JUXS2JEWqy13Qw8zYJmr+bQK2uGvE6g15bRImA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BH+V8W4AZCY3CyY7gaU0n+0/Qp7d3Y9+nZz0W+J2mtbwr+khCJs91tpYlIuMvsTI+r1+6sMvCpJcxlacQnK8PPK8aFDnspiM0cmR8z9oWEJY5NlLFubWIgI/kJT6mQwWGrM+SBIC8NGa5F2oHBcjROXLo90uR2Y22HKtAvtzUP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 68C1MWZW093538;
	Sat, 12 Sep 2026 10:22:32 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 68C1MWnP093535
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 12 Sep 2026 10:22:32 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <6fdefda9-c7e4-4368-8d9a-280043b4051e@I-love.SAKURA.ne.jp>
Date: Sat, 12 Sep 2026 10:22:31 +0900
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
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <b700652d-ed63-444a-b879-ec2725affaa7@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav213.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/09/12 10:02, Bart Van Assche wrote:
> On 9/11/26 3:18 PM, Tetsuo Handa wrote:
>> On 2026/09/12 5:03, Bart Van Assche wrote:
>>> On 9/10/26 2:44 AM, Tetsuo Handa wrote:
>>>> On 2026/09/10 4:33, Bart Van Assche wrote:
>>>>> __loop_clr_fd() is queued from the lo_post_release() callback and hence
>>>>> may be called concurrently with or after another thread has called
>>>>> bdev_open(). Hence, lo->lo->state should be checked instead of assuming
>>>>> that it equals Lo_rundown.
>>>>
>>>> No, __loop_clr_fd() is queued from the lo_release() callback.
>>>
>>> Yes, it is *queued* from the lo_release() callback function but there is
>>> no guarantee that __loop_clr_fd() has started before bdev_open() is
>>> called again.
>>
>> Since lo->lo_state was set to Lo_rundown by lo_release(), lo_open() will return -ENXIO.
>> What can go wrong if bdev_open() is called again before __loop_clr_fd() starts?
> 
> This breaks LO_FLAGS_AUTOCLEAR, isn't it?

Why do you think so?

  App1                   App2                   system_long_wq
  Calls lo_release().
    Schedules __loop_clr_fd().
                         Calls lo_open() but fails with -ENXIO.
                                                Starts __loop_clr_fd().
  Calls lo_post_release().
    Starts waiting for completion of __loop_clr_fd().
                                                Finishes __loop_clr_fd().
    Finishes waiting for completion of __loop_clr_fd().

  Calls lo_open() again and succeeds.
                         Calls lo_open() again and succeeds.

App1's open() after close() is succeeding.
App2's open() being temporarily failing with -ENXIO should be acceptable.
If App2 wants to avoid repeatedly failing with -ENXIO, App2 should use
ioctl(LOOP_CTL_GET_FREE) before open().
