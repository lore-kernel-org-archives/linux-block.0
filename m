Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B233F4DE7
	for <linux-block@vger.kernel.org>; Fri,  5 Jun 2026 10:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780654486; cv=none; b=nKGXh8F18i7WOB1n2U/9d+WwksLHyRN00sbiapPc1U7UQtNrdSvzfgToMXCILQvVDuTlN3nOd14pF6n+TunxCts5henTeG3Z4DJzCgEcg2vK4y2iQcH4RRw4cTOrmEj3xbgc89bDVmLcKWwa1/mHtycLbldMn2+VmmBG2sOoypw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780654486; c=relaxed/simple;
	bh=I3aTSz6zOzPc0D/NuL+1VxgMO2FIdbYzRjE+0iwVZiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CAa75DnRZaHRDKCVgLd5a3D8TdyTweSqLfyj0JwPSp51Nxj8Eppln962oshuvbLZpL5GaVj0JXWUMWPVJJ8QB+mYhWZXAte9sno5wL7MrNWba9O2oGIAfsaKegHdh0BAbo0HsENUOZT67hNl71ut9lpXa1oYCnrYN8DU25EdEzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 655AEgdD067352;
	Fri, 5 Jun 2026 19:14:42 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.5] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 655AEfuN067349
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 5 Jun 2026 19:14:41 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <9ebc39a8-6025-40e3-a378-ba26bf8d73ae@I-love.SAKURA.ne.jp>
Date: Fri, 5 Jun 2026 19:14:42 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] block: assign caller-specific lockdep class to
 disk->open_mutex
To: Andreas Hindborg <a.hindborg@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ming Lei <tom.leiming@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
        Qu Wenruo <wqu@suse.com>, Hillf Danton <hdanton@sina.com>,
        Miguel Ojeda <ojeda@kernel.org>
References: <147ed056-03d9-4214-b925-0f10fc00cf27@I-love.SAKURA.ne.jp>
 <4cf7ecc7-932c-4589-9d0f-3e025e83e27c@acm.org> <20260601071113.GB7468@lst.de>
 <420f723a-8168-4f56-b84a-2a36ecd87fea@I-love.SAKURA.ne.jp>
 <226152a3-1e4c-4eec-9a17-1d40426a7b18@I-love.SAKURA.ne.jp>
 <87wlwdifrv.fsf@kernel.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <87wlwdifrv.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav301.rs.sakura.ne.jp

On 2026/06/05 16:54, Andreas Hindborg wrote:
> Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> writes:
> 
>> The block core currently allocates a single monolithic lockdep key for
>> disk->open_mutex across all callers. This single key conflates locking
>> hierarchies between independent block streams. For example, if a stacked
>> driver like loop flushes its internal workqueues inside lo_release() while
>> holding its own open_mutex, lockdep views this as a potential ABBA deadlock
>> against the underlying storage stack, leading to numerous circular
>> dependency splats.
>>
>> To structurally reduce false positives, this patch splits the global
>> monolithic lock class into distinct, per-caller instances during disk
>> allocation. This is done by replacing "struct lock_class_key" with
>> "struct gendisk_lkclass", which contains two instances of
>> "struct lock_class_key" for the legacy "(bio completion)" map and
>> disk->open_mutex respectively.
>>
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> 
> For the Rust part, we have existing infrastructure for lock class keys
> [1]. Please take a look how we generate lock class keys elsewhere [2].

My understanding is that we don't have infrastructure for lock class keys
that can be applied to

  +struct gendisk_lkclass {
  +	struct lock_class_key bio_lkclass;
  +	struct lock_class_key open_mutex_lkclass;
  +};

  -	static struct lock_class_key __key;
  +	static struct gendisk_lkclass __key;

change. Alternative approach is welcomed if you have one.

> 
> Best regards,
> Andreas Hindborg
> 
> [1] https://rust.docs.kernel.org/kernel/sync/struct.LockClassKey.html
> [2] https://github.com/torvalds/linux/blob/ddd664bbff63e09e7a7f9acae9c43605d4cf185f/rust/kernel/sync/lock/mutex.rs#L12
> 

