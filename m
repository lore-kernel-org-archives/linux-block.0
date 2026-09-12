Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0403339361;
	Sat, 12 Sep 2026 01:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789177462; cv=none; b=ZwAegFNkcUzXkaL0sDW5wQrjUaSykyoZQGuR2aj+Bze0YrVkTZbhH4nIFSSI1fXdBg+jnnh/Teb1gePohotqTCKXoCCGalDpJA8R9wJvN2fjFHWP42skzodpnZPF6OkuAW9HPIcC1y8y1Xa3Yx/dTCZo33b655rn6CGmRDK7Emc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789177462; c=relaxed/simple;
	bh=Ed0ZSyQqT+c5ORdQP5wW1quoXwM0MrGu69HcJtvtmQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bU+SmEPg5P1VhytZEpAVvkBaNzh79CcBrqYABQH6ndvih/dGkp3OxLiP8SdtNm41bCev7zRyXsGPYw9oR8pLPeCMF4IjkEM7KEsN2+0hK7+mqLuw98nUkhA1ImG4pu5Uqk62FMUaY4kyVpp+jtUF9lCyBBzaHMLo2Fev0K14q6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 68C1hdK0098830;
	Sat, 12 Sep 2026 10:43:39 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 68C1hdW7098826
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 12 Sep 2026 10:43:39 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <79a4b554-6863-48de-8d68-3a9f8537ea81@I-love.SAKURA.ne.jp>
Date: Sat, 12 Sep 2026 10:43:38 +0900
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
 <f00a7749-c59a-4c96-bc41-b34c80a40aef@I-love.SAKURA.ne.jp>
 <a863d8ea-d72e-48b4-862f-1a7439cb255c@acm.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <a863d8ea-d72e-48b4-862f-1a7439cb255c@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Anti-Virus-Server: fsav213.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/09/12 9:31, Bart Van Assche wrote:
> On 9/11/26 3:34 PM, Tetsuo Handa wrote:
>> On 2026/09/12 4:54, Bart Van Assche wrote:
>>> On 9/9/26 3:48 AM, Tetsuo Handa wrote:
>>>>        int (*alternative_gpt_sector)(struct gendisk *disk, sector_t *sector);
>>>> +    /*
>>>> +     * Called after disk->open_mutex is released in the bdev_release() path.
>>>> +     * Used by loop devices that need to perform synchronization without
>>>> +     * holding disk->open_mutex. This operation has to be idempotent.
>>>> +     */
>>>> +    void (*post_release)(struct gendisk *disk);
>>>
>>> Instead of referring to bdev_release(), which is not in the public API,
>>> the above comment should mention that .post_release() is called after .release().
>>
>> Such change is not accurate. The .release() is also called if something went wrong after
>> the .open() succeeded. The reason I emphasis bdev_release() is that the .post_release()
>> is not called if something went wrong after the .open() succeeded.
> 
> Please integrate the above text in the comment above .post_release().
> 
Are you OK with below description?

--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1577,6 +1577,14 @@ struct block_device_operations {
 			unsigned int flags);
 	int (*open)(struct gendisk *disk, blk_mode_t mode);
 	void (*release)(struct gendisk *disk);
+	/*
+	 * This operation is called after returned from release() and
+	 * disk->open_mutex was released. But this operation is not called
+	 * after an initialization open() has succeeded but something went
+	 * wrong and an error-unwinding release() was called.
+	 * This operation might sleep and has to be idempotent.
+	 */
+	void (*post_release)(struct gendisk *disk);
 	int (*ioctl)(struct block_device *bdev, blk_mode_t mode,
 			unsigned cmd, unsigned long arg);
 	int (*compat_ioctl)(struct block_device *bdev, blk_mode_t mode,

