Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2AD38237B;
	Fri, 19 Jun 2026 13:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781875019; cv=none; b=i/kl9lZRvNbqQgdmvIC8ksxuhVOgNSqkylEhbtzPbbb0V20/KAQMpK9T90vWK9GlfnNmfMY3tpeVaNHRoKCl2NURBxLoviEglX71OzGHjMjO4TxHRHX58KgxqDn6nAeXmof7/Knw4s9cN8IDN7jf7BnktKCNB8MoG2x6R64bRL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781875019; c=relaxed/simple;
	bh=RjCLqBbxx6VPLtveYkLrOZByZCsJgyh3Y91PSugqGdA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=igUpUs7zBdyCLUXeb/NZZQ+UxlsnQmMGgAkPf9KZmUyX3YzTDDWfTi6rxfBK8dIa1S0zYHelcNhBHMkrwfGJT+QtBwb5K+Snnwmt9gLfci3pSTL4J0zHwCikJCfDZuu5q8hLBxrxjp291cVnEsBi5jlpW5SKZJuXNQofUmjj4F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRSeQFlt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRSeQFlt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712341F000E9;
	Fri, 19 Jun 2026 13:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781875018;
	bh=HC0gbJXKctgyT5B82ZRUw7sMjAjhY1VXzWkHbrwryVk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=SRSeQFltrK5Xnu65FczNle+7HDjzhr3p9tJWkMGH/gvUyb9qeWXFleW+jbcWw917f
	 rYn1rRbzPIdJwQ9lM9a+cDdCYbDNIO9ofHx39KAV1GuQ1NYYT2+IkPYtyaRTePf5fm
	 ka7MyvHKUquAuyaqTGYmCQuvIaevx/udsN+RFv+vosp3cBSgW76yLun5gUMz2xqEb2
	 V9IvPEmEWqy2nUkTzmCJgYvc4DQCbzANz9AZDLRTg+j3LVq5t3tWAbpMcvLNNXWKpI
	 03Zvkb0wQKbn+5phoZa8ce09vVXAiq1a/aphggNal7rADJKPqbhnCdqICUyB7omLa9
	 7tklcoocEm7gw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Christoph Hellwig
 <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>, Jens Axboe
 <axboe@kernel.dk>
Cc: linux-block <linux-block@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Ming Lei <tom.leiming@gmail.com>, Damien Le
 Moal <dlemoal@kernel.org>, Qu Wenruo <wqu@suse.com>, Hillf Danton
 <hdanton@sina.com>, Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH v3] block: assign caller-specific lockdep class to
 disk->open_mutex
In-Reply-To: <87y0gaekyb.fsf@t14s.mail-host-address-is-not-set>
References: <147ed056-03d9-4214-b925-0f10fc00cf27@I-love.SAKURA.ne.jp>
 <4cf7ecc7-932c-4589-9d0f-3e025e83e27c@acm.org>
 <20260601071113.GB7468@lst.de>
 <420f723a-8168-4f56-b84a-2a36ecd87fea@I-love.SAKURA.ne.jp>
 <226152a3-1e4c-4eec-9a17-1d40426a7b18@I-love.SAKURA.ne.jp>
 <87wlwdifrv.fsf@kernel.org>
 <9ebc39a8-6025-40e3-a378-ba26bf8d73ae@I-love.SAKURA.ne.jp>
 <87a4sqg8qh.fsf@t14s.mail-host-address-is-not-set>
 <V4cTJ0R2z3aTgmFRzs8OYYzrGPIMcKT9CDZn4JxKj5yx7La9eeBtk7w9nNFeSl75fCz1hatUYAE0QmfMDcRjig==@protonmail.internalid>
 <4d405942-9932-48b0-bdc0-9744d48fe699@I-love.SAKURA.ne.jp>
 <87y0gaekyb.fsf@t14s.mail-host-address-is-not-set>
Date: Fri, 19 Jun 2026 15:16:49 +0200
Message-ID: <87v7beekla.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andreas Hindborg <a.hindborg@kernel.org> writes:

> "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp> writes:
>
>> On 2026/06/19 18:49, Andreas Hindborg wrote:
>>>> My understanding is that we don't have infrastructure for lock class keys
>>>> that can be applied to
>>>>
>>>>   +struct gendisk_lkclass {
>>>>   +	struct lock_class_key bio_lkclass;
>>>>   +	struct lock_class_key open_mutex_lkclass;
>>>>   +};
>>>>
>>>>   -	static struct lock_class_key __key;
>>>>   +	static struct gendisk_lkclass __key;
>>>>
>>>> change. Alternative approach is welcomed if you have one.
>>>
>>> Sorry, I did not pay enough attention. I would suggest this approach:
>>
>> I'm OK with your module-specific lockdep class approach
>>
>>> @@ -164,14 +127,21 @@ pub fn build<T: Operations>(
>>>              lim.features = bindings::BLK_FEAT_ROTATIONAL;
>>>          }
>>>
>>> -        // SAFETY: `tagset.raw_tag_set()` points to a valid and initialized tag set
>>> +        let keys = KBox::pin_init(
>>> +            Opaque::ffi_init(|ptr: *mut bindings::gendisk_lkclass| {
>>> +                // SAFETY: `ptr` is valid for writes
>>> +                unsafe { bindings::lockdep_register_key(&raw mut (*ptr).bio_lkclass) };
>>> +                // SAFETY: `ptr` is valid for writes
>>> +                unsafe { bindings::lockdep_register_key(&raw mut (*ptr).open_mutex_lkclass) };
>>> +            }),
>>> +            GFP_KERNEL,
>>> +        )?;
>>> +
>>> +        // SAFETY:
>>> +        // - `tagset.raw_tag_set()` points to a valid and initialized tag set.
>>> +        // - We keep `keys` alive for the lifetime of the returned gendisk.
>>>          let gendisk = from_err_ptr(unsafe {
>>> -            bindings::__blk_mq_alloc_disk(
>>> -                tagset.raw_tag_set(),
>>> -                &mut lim,
>>> -                data,
>>> -                lkclass.as_ptr(),
>>> -            )
>>> +            bindings::__blk_mq_alloc_disk(tagset.raw_tag_set(), &mut lim, data, keys.get())
>>>          })?;
>>>
>>>          const TABLE: bindings::block_device_operations = bindings::block_device_operations {
>>
>> if we can assume that there is (up to) only one
>>
>>   let mut disk = gen_disk::GenDiskBuilder::new().capacity_sectors(4096).build(fmt!("myblk"), tagset, ())?;
>>
>> call for each rust module.
>
> With the approach I suggest here, we get a new set of keys for each
> invocation of `GenDiskBuilder::build`. No statics involved, keys are
> allocated dynamically.
>
> The current code makes one key for to be shared by _all_ callers, which
> is probably a bad idea.
>
>>
>> By the way, are you aware that rust-enabled linux-next build is recently failing
>> ( https://syzkaller.appspot.com/bug?extid=1f14a35d0c73d31555e4 ) ?
>
> I was not aware, thanks for pointing that out. I actually did build
> linux-next for both June 16 and June 18 and I did not see any issue. It
> looks like a tooling problem to me. I'll see if I can figure out what it
> is.

I think this is [1]. We saw it for lkp when they used bindgen 0.72.0
with clang 22 I think. Probably syzkaller needs to bump bindgen version
to 0.72.2.

Cc: Miguel Ojeda <ojeda@kernel.org>

Not sure who to Cc on syzkaller side.

Best regards,
Andreas Hindborg


[1] https://github.com/rust-lang/rust-bindgen/issues/3264

