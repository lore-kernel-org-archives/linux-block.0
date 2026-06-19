Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9561637882E
	for <linux-block@vger.kernel.org>; Fri, 19 Jun 2026 12:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781871582; cv=none; b=aY2WDEu6xMgpLF4Sc4hR7FfqU/VkRRPR9IC1Yzej3MOz8gjvpvH1kzBhxvf0yWxAdThp1R4G+krBg2av1DU+t1FVispLW3g0bhhnGvB8cqaHwlweSDRwuZgUW0Bv+jbLEVsDQWd0VzXAr7jy3w2zlugOaA3mYvN7TgcLaPuqkkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781871582; c=relaxed/simple;
	bh=u5oHfTDMt/v7XpoF4dX5yoiYwC8VFQCbSzdaa7YyrbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ttcge/KN5WFzEkzC8MraGhCaJVlnqLGuLuVQnxotfVCWVAn1Ibw/cLpFc8KPaFvMcytrxrO9AlNzIYpDVUfSw2IWmqfa+XU3glizcGguSODyTUiY1aFtO2Kr7mipEVJOo4A8APNoCObhzPYwp/Nq6pTDEIGROFNp6cw03MKWngE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 65JCJSZG004846;
	Fri, 19 Jun 2026 21:19:29 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 65JCJScE004843
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 19 Jun 2026 21:19:28 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <4d405942-9932-48b0-bdc0-9744d48fe699@I-love.SAKURA.ne.jp>
Date: Fri, 19 Jun 2026 21:19:26 +0900
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
 <9ebc39a8-6025-40e3-a378-ba26bf8d73ae@I-love.SAKURA.ne.jp>
 <87a4sqg8qh.fsf@t14s.mail-host-address-is-not-set>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <87a4sqg8qh.fsf@t14s.mail-host-address-is-not-set>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav405.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/06/19 18:49, Andreas Hindborg wrote:
>> My understanding is that we don't have infrastructure for lock class keys
>> that can be applied to
>>
>>   +struct gendisk_lkclass {
>>   +	struct lock_class_key bio_lkclass;
>>   +	struct lock_class_key open_mutex_lkclass;
>>   +};
>>
>>   -	static struct lock_class_key __key;
>>   +	static struct gendisk_lkclass __key;
>>
>> change. Alternative approach is welcomed if you have one.
> 
> Sorry, I did not pay enough attention. I would suggest this approach:

I'm OK with your module-specific lockdep class approach

> @@ -164,14 +127,21 @@ pub fn build<T: Operations>(
>              lim.features = bindings::BLK_FEAT_ROTATIONAL;
>          }
>  
> -        // SAFETY: `tagset.raw_tag_set()` points to a valid and initialized tag set
> +        let keys = KBox::pin_init(
> +            Opaque::ffi_init(|ptr: *mut bindings::gendisk_lkclass| {
> +                // SAFETY: `ptr` is valid for writes
> +                unsafe { bindings::lockdep_register_key(&raw mut (*ptr).bio_lkclass) };
> +                // SAFETY: `ptr` is valid for writes
> +                unsafe { bindings::lockdep_register_key(&raw mut (*ptr).open_mutex_lkclass) };
> +            }),
> +            GFP_KERNEL,
> +        )?;
> +
> +        // SAFETY:
> +        // - `tagset.raw_tag_set()` points to a valid and initialized tag set.
> +        // - We keep `keys` alive for the lifetime of the returned gendisk.
>          let gendisk = from_err_ptr(unsafe {
> -            bindings::__blk_mq_alloc_disk(
> -                tagset.raw_tag_set(),
> -                &mut lim,
> -                data,
> -                lkclass.as_ptr(),
> -            )
> +            bindings::__blk_mq_alloc_disk(tagset.raw_tag_set(), &mut lim, data, keys.get())
>          })?;
>  
>          const TABLE: bindings::block_device_operations = bindings::block_device_operations {

if we can assume that there is (up to) only one

  let mut disk = gen_disk::GenDiskBuilder::new().capacity_sectors(4096).build(fmt!("myblk"), tagset, ())?;

call for each rust module.

By the way, are you aware that rust-enabled linux-next build is recently failing
( https://syzkaller.appspot.com/bug?extid=1f14a35d0c73d31555e4 ) ?

