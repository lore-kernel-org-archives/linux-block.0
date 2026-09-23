Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ECC355803;
	Wed, 23 Sep 2026 05:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790141236; cv=none; b=RrPL0TxNK6r4/Bns7CNnrOovJp80Useq6DKB53A7jP8VSNWa6fnYJPKjCugf057NWK6JaGDK+wJBhuWBYqDcBdblNK9lXJeT4XRn1RXw2XAtRTRVPwD6YGHchz+Lyp59bH0mCDzdUDOJ71vSVmDLsqEZxkNmj94uOSV9jOTvptI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790141236; c=relaxed/simple;
	bh=yeEIvn75QojI/rFG2mRqGQUiO8p8HGQDNGrlafn86aU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=js21Iwg4lGLVSCMrHpRkzzySP+m9SJx1RPdr5GMdD5xRRQl0kF5oHCELKAoXnt/8QQv2pWIF0WNgY1Spc4oDI0XQrItW5csOtSg9g9/6fGpI+ldNubJ4pDZwaQ3RlKqXqNhhcSpGNcR+t5Klc5zHQKoJynYblL5ULne4ygdQm/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 68N5QCMw081243;
	Wed, 23 Sep 2026 14:26:12 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 68N5QBkU081239
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 23 Sep 2026 14:26:11 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d83d3f4e-759c-4218-adfc-82eecdc5b84b@I-love.SAKURA.ne.jp>
Date: Wed, 23 Sep 2026 14:26:11 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] block: Add run_todo() operation
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        linux-block <linux-block@vger.kernel.org>
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
References: <e615fb71-f386-4029-8ceb-22e375ad9e94@I-love.SAKURA.ne.jp>
 <afbf50a0-d409-45a3-8e95-99c04ca0e302@acm.org>
 <24ef93b9-7385-4dda-8912-f7c78f9705d1@I-love.SAKURA.ne.jp>
 <ac1d3825-8a10-42e1-9eaa-f2ba51216660@acm.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <ac1d3825-8a10-42e1-9eaa-f2ba51216660@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav114.rs.sakura.ne.jp

On 2026/09/23 3:09, Bart Van Assche wrote:
> On 9/21/26 10:08 PM, Tetsuo Handa wrote:
>> I think post_release() is misleading because post_release() is also called
>> when disk->fops->open() in blkdev_get_whole() failed (and therefore
>> bdev->bd_disk->fops->release() in blkdev_put_whole() from blkdev_get_whole()
>> was not called).
> 
> Has it been considered to call the new callback only if fops->release()
> has been invoked? Here is an (untested) example of how this could be
> implemented:

Yes, I have considered that approach. I didn't implement that change because
it is a needless bloat. But if you are OK with that approach, we can go with
your approach.

The v5 patchset passed sashiko's review. Can we apply the v5 ?

https://sashiko.dev/#/log/178321
https://sashiko.dev/#/log/178322

