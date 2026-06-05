Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B092A477998;
	Fri,  5 Jun 2026 07:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644976; cv=none; b=Oo/egZyEixANSTQwx41VolxEOt1ZWc39I7Z9mrtbNX9Z7eyfPL8tlLMJLfumMEIyJTex7zGPyIRelmoNhZLHpLeVeHJB6SmP1YhiLc6MiXlT3g+SodcQji8O+cjHVL3M/6HCi6CqBKA36xDb2WSGSmKYgX3bjd52JkFSAU1T/K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644976; c=relaxed/simple;
	bh=nMbjHr1vKiDnCsHB4hJLxHFpD2VDpetdGM5Cr504iuU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UcXH4lQbWjaTceL66eIA2pjDgNLEPbv0WKzAbJIdh/i/MEbyJWrbOvJ770j3rIEy/u4si6Aa6ipeKEis/Zd6PMv8VLS99fraeo+0pZT1dr+KOIC0E7pvEn/PfBwR4F99dU2rxjp3e68itC5sYm2CEeicJzW7JXUQ4cU7g5LlIH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoT79SeZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoT79SeZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65231F00893;
	Fri,  5 Jun 2026 07:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780644975;
	bh=HDU5QqmZWp9tQ0ikyjzbohExLSGRNkAWIVys3WP4fBA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=NoT79SeZsTJlrTSxQ0DLrEOEZjHiAZHjA4Tq7NsT3v9f2VDpFenrbSvlpWt/rLBSW
	 0TC18RjVVfoCJkubCViIMqFY5VmRUpZjIveKMIebwweDsp+79UpqIq1JSKH1C1U6AY
	 etF7hejsmqElaTLFp3MfPAgvg1IxzfdTzsfsm30zzmzR6gms0oOG4xbdecvvbZaYV/
	 ph2kH3UySkyDT+514mPrfAg/7sRXGRSrIaxIb+l+DtKnSUfo/k5NP03ui3IXJh/XIh
	 MDGGz2O1PVvjwYeiPPm6F0UML7JQfbps07NPNaNlp8m80pduAPtn2+5HeHTkSxA/dY
	 Q43tVT5vQMHAg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, penguin-kernel@i-love.sakura.ne.jp,
 Kentaro Takeda <takedakn@nttdata.co.jp>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, bvanassche@acm.org,
 dlemoal@kernel.org, hch@lst.de, hdanton@sina.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ojeda@kernel.org, tom.leiming@gmail.com, wqu@suse.com, Boqun Feng
 <boqun@kernel.org>, rust-for-linux@vger.kernel.org, Mark Brown
 <broonie@kernel.org>
Subject: Re: [PATCH v3] block: assign caller-specific lockdep class to
 disk->open_mutex
In-Reply-To: <20260604210704.41751-1-ojeda@kernel.org>
References: <226152a3-1e4c-4eec-9a17-1d40426a7b18@I-love.SAKURA.ne.jp>
 <WX3XCppxtwahZrFW9ODTU5Hu4b12QJFtthvYbPo5SiKqV8hWCyqoEy5W-eVMQ3cnZ2fW3SHofR3WtHsu7-ZHxg==@protonmail.internalid>
 <20260604210704.41751-1-ojeda@kernel.org>
Date: Fri, 05 Jun 2026 09:36:05 +0200
Message-ID: <87zf19igm2.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Miguel Ojeda" <ojeda@kernel.org> writes:

> On Wed, 03 Jun 2026 20:54:05 +0900 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
>>
>> Acknowledgment:
>>   Since I have no experience with Rust, changes needed by Rust block layer
>>   bindings and rnull module are made based on conversation with the Gemini
>>   AI collaborator.
>
> Then please do Cc the right people as `MAINTAINERS` mentions, including
> "BLOCK LAYER DEVICE DRIVER API [RUST]" and "RUST"...
>
> I am quite confused. Why was this added to linux-next?
>
> It doesn't go through block, nor has an Ack or review and breaks
> the `rustdoc` build in linux-next (and thus rust.docs.kernel.org):
>
>     error: unresolved link to `my_gendisk_lkclass`
>       --> rust/kernel/block/mq/gen_disk.rs:42:50
>        |
>     42 | /// This type can only be instantiated via the [`my_gendisk_lkclass!`] macro.
>
> It is also not Clippy-clean -- it doesn't follow our usual conventions
> for safety comments and sections:
>
>     error: unsafe function's docs are missing a `# Safety` section
>       --> rust/kernel/block/mq/gen_disk.rs:59:5
>        |
>     59 |     pub const unsafe fn new_lock_class(ptr: *mut bindings::gendisk_lkclass) -> GenDiskLockClass {
>
>     error: function has unnecessary safety comment
>       --> rust/kernel/block/mq/gen_disk.rs:59:5
>        |
>     58 |     /// SAFETY: `ptr` must point to a valid static `gendisk_lkclass` instance.
>        |         ------- help: consider changing it to a `# Safety` section: `# Safety`
>     59 |     pub const unsafe fn new_lock_class(ptr: *mut bindings::gendisk_lkclass) -> GenDiskLockClass {
>
> Please see:
>
>   https://rust-for-linux.com/contributing#submit-checklist-addendum
>
> In any case, it is also too late in the cycle to be experimenting in
> linux-next.
>
> So what am I missing? What is going on?
>
> (And on top of all that, for some reason I did not receive it even if I
> am apparently in Cc, so I have asked the admins about that.)
>
> Cheers,
> Miguel
>
> Cc: Andreas Hindborg <a.hindborg@kernel.org>
> Cc: Boqun Feng <boqun@kernel.org>
> Cc: rust-for-linux@vger.kernel.org
>
> Cc: Mark Brown <broonie@kernel.org>

Looks like this was pulled through the tomoyo tree:

tomoyo		git://git.code.sf.net/p/tomoyo/tomoyo.git#master

M:	Kentaro Takeda <takedakn@nttdata.co.jp>
M:	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>


Best regards,
Andreas Hindborg


