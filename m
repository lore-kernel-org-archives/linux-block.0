Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFD2CA6F;
	Sat, 12 Sep 2026 00:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789173113; cv=none; b=YusTEpXg5Ed9WujvyfGQGvrdwsVujtjKAw5mtWzXQoI6EVIfYK3Qzge5SU9gXxODy/9I8au17KI4ZyrqTBCF3T7n2tcGcHn1rzGgi39I0YS0T0Mu7hLoRshz5WvuobNb/haAkoS/xtk8vmZam+krR8BrV69QfEfoGZHWCB5ivnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789173113; c=relaxed/simple;
	bh=HXNI6UAMrjh9+VLP1v7jAT28x3W4ScCqb3gnwwzFXMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b410PUIdShg8aCdCz5GkMmTLfHAQRbwCvTBOk9z7eNWx0DYogNwIWCwAZUPtwBIurbyGfdLFBto7RtauvTAAGhk/R45/VGRN0HIsq3Bwhai1IYFbzW0upT6Pg0Kus9cC84uaFG1tcFF9mUCnjXJfjawmG5Qg4HrWS7D7TL/G9IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=TCYa9xs5; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="TCYa9xs5"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hhXRB6kgDzlfvq0;
	Sat, 12 Sep 2026 00:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1789173103; x=1791765104; bh=33U5vQimcyFyEVA37rvZUyWR
	rhM9rGpLuC0TPddNhvY=; b=TCYa9xs5Xih6lVMUwwNrSlHM6JIS18cuPnO4VaXh
	0tyi0bVEjRt6RBJKFkkYKoJX/gCWy3f55XhBeO+ybQHbTtE4N2vpMCbNbFm8WnTD
	ScdISD33wsa5L/ukJgkpRjQcO0ijxejP4hIu3gwo0PDyYYwgFe03Xz5Wtjm8gDtQ
	kUoBwVfnX2A1e0rMumoJz65KCE3eUg/WjulAXRPI9Ydxpq3jBECRRwMTu9YXh3L4
	HW2TQKNO8T1ZXdiEN1sppoxFNkAWAUtVJ49AlYXJr7XNZVU5Pc0gsG3v5f7yRNEZ
	9pyxp9tFIv4ZOCOcDKZhKHoqUbE/Gx1pbPO49FHxbqc16g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id KN3l8zysGsJR; Sat, 12 Sep 2026 00:31:43 +0000 (UTC)
Received: from [192.168.51.14] (c-24-6-239-25.hsd1.ca.comcast.net [24.6.239.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hhXQx6WtHzlfvpM;
	Sat, 12 Sep 2026 00:31:37 +0000 (UTC)
Message-ID: <a863d8ea-d72e-48b4-862f-1a7439cb255c@acm.org>
Date: Fri, 11 Sep 2026 17:31:36 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: Add post_release() operation
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, Brian Foster
 <bfoster@redhat.com>, Damien Le Moal <dlemoal@kernel.org>,
 Hillf Danton <hdanton@sina.com>, Markus Elfring <Markus.Elfring@web.de>,
 Ming Lei <tom.leiming@gmail.com>, Qu Wenruo <wqu@suse.com>,
 Tao Cui <cui.tao@linux.dev>, kernel test robot <lkp@intel.com>,
 linux-block <linux-block@vger.kernel.org>, rust-for-linux@vger.kernel.org
References: <60bf7af2-b84e-4056-9195-a26ad51ada46@I-love.SAKURA.ne.jp>
 <3fceb17e-35f5-4275-bfa5-f1a018c732c9@acm.org>
 <f00a7749-c59a-4c96-bc41-b34c80a40aef@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <f00a7749-c59a-4c96-bc41-b34c80a40aef@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/26 3:34 PM, Tetsuo Handa wrote:
> On 2026/09/12 4:54, Bart Van Assche wrote:
>> On 9/9/26 3:48 AM, Tetsuo Handa wrote:
>>>        int (*alternative_gpt_sector)(struct gendisk *disk, sector_t *sector);
>>> +    /*
>>> +     * Called after disk->open_mutex is released in the bdev_release() path.
>>> +     * Used by loop devices that need to perform synchronization without
>>> +     * holding disk->open_mutex. This operation has to be idempotent.
>>> +     */
>>> +    void (*post_release)(struct gendisk *disk);
>>
>> Instead of referring to bdev_release(), which is not in the public API,
>> the above comment should mention that .post_release() is called after .release().
> 
> Such change is not accurate. The .release() is also called if something went wrong after
> the .open() succeeded. The reason I emphasis bdev_release() is that the .post_release()
> is not called if something went wrong after the .open() succeeded.

Please integrate the above text in the comment above .post_release().

>> The above comment should also mention that .post_release()
>> implementations may sleep.
> 
> Such change is fine.
> 
>>
>> Additionally, why is .post_release() added at the end instead of just
>> under .release()?
> 
> Because I consider the .post_release() is categorized to
> 
> 	/*
> 	 * Special callback for probing GPT entry at a given sector.
> 	 * Needed by Android devices, used by GPT scanner and MMC blk
> 	 * driver.
> 	 */
> 	int (*alternative_gpt_sector)(struct gendisk *disk, sector_t *sector);
> 
> hook.

Are you claiming that .post_release() is Android-specific? I don't think
that's correct.

Bart.
