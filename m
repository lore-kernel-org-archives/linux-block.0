Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC113ACA77;
	Fri, 11 Sep 2026 22:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789166144; cv=none; b=sY6PrDx3mLwR+XUZ7xIviawe/ZfnBtlMwZ5dFFCcioyel1zjhrz+hzskcZAiCZzncSQ9zKIPzJK2IEV0oq4pdT9hL98OVcrqsT7BJhNJBmL3Az3jTm361odSByGJQAC9Ie0/jj3Xs/HCdjQT1xlvsx8qihRkkwwTRL45PRDBKDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789166144; c=relaxed/simple;
	bh=iON6JqDKoV5z6Ryxg15bQqCmflWnG/lLCDcNus3zJwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tks7HrzqcL30jyznH1oeiC474CYKhDw3bYa92FWb9h58fvPyBtot4goreP5mmKFFCkWfrNmXsbna4dOPgEdJ2Blje02WvzCWb1Td0ZYTVvl9wvCH9evr502eOrt/BezQ3OSrax3pOtIO/0ZybO6+jgxLQYhBtxl280cWNnjQiAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 68BMYsoC047504;
	Sat, 12 Sep 2026 07:34:54 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 68BMYsNP047499
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 12 Sep 2026 07:34:54 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f00a7749-c59a-4c96-bc41-b34c80a40aef@I-love.SAKURA.ne.jp>
Date: Sat, 12 Sep 2026 07:34:53 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: Add post_release() operation
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
 <3fceb17e-35f5-4275-bfa5-f1a018c732c9@acm.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <3fceb17e-35f5-4275-bfa5-f1a018c732c9@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav214.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/09/12 4:54, Bart Van Assche wrote:
> On 9/9/26 3:48 AM, Tetsuo Handa wrote:
>>       int (*alternative_gpt_sector)(struct gendisk *disk, sector_t *sector);
>> +    /*
>> +     * Called after disk->open_mutex is released in the bdev_release() path.
>> +     * Used by loop devices that need to perform synchronization without
>> +     * holding disk->open_mutex. This operation has to be idempotent.
>> +     */
>> +    void (*post_release)(struct gendisk *disk);
> 
> Instead of referring to bdev_release(), which is not in the public API,
> the above comment should mention that .post_release() is called after .release().

Such change is not accurate. The .release() is also called if something went wrong after
the .open() succeeded. The reason I emphasis bdev_release() is that the .post_release()
is not called if something went wrong after the .open() succeeded.

> The above comment should also mention that .post_release()
> implementations may sleep.

Such change is fine.

> 
> Additionally, why is .post_release() added at the end instead of just
> under .release()?

Because I consider the .post_release() is categorized to

	/*
	 * Special callback for probing GPT entry at a given sector.
	 * Needed by Android devices, used by GPT scanner and MMC blk
	 * driver.
	 */
	int (*alternative_gpt_sector)(struct gendisk *disk, sector_t *sector);

hook.

> 
> Otherwise this patch looks good to me.
