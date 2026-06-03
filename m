Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB9D4779B8;
	Wed,  3 Jun 2026 12:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780488578; cv=none; b=lyMBnj0OMOIY37vQXf42AS8R3FoIwlmcT33tItK8YK4fmdIgP3kDbRTMkRhWpn77ByicT+Y0/CTNEcoIlGavcBhF1zaIpnFdiRKS2YvrdGII/ql+MfKq6avam/8Ad68PLShsNQ2+R9adbUO5l7BNdARgFr1/pXIGmu9jx/LnLT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780488578; c=relaxed/simple;
	bh=JOQQUijPMSZPB7pcysKXlCgO5RHVRXdD3fcSLzagZX4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sWoYzIzxGFjAuam0Fp/REL/K9ZjOm8Vcps1TmOb8AWO+T5LNlejyfpCj1pnGt8cr7tiKMU6WDKzq+uXXIOo5BOHLhOPOMO0iEAecABEY3pO4gpRrTkNNYzaGSeGX6yz+Fbsqihum6sgVE6o692RCF4xRraLyolBJPUwSWy0gID4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hudv1vT9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hudv1vT9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D5A1F00898;
	Wed,  3 Jun 2026 12:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780488577;
	bh=TnuFx4Ou3kejucSUC1CjBWPb8/IIbrdEZSaYmxrJMXo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Hudv1vT9OqicBhA3XISYHEipfy8FQmRWxTfPZ9jZFgY5EZqvVMG7+hOsfzAa3geFa
	 llZzLC4aGEBsxE7wPLpES/rpe4l+Lvet3VGeR70wmk8OEtNmysRisJWr1RUDG5RrYv
	 GnMsOAfkyO3iw3VDKraNRk+WZBCO/M37aifHQ1m6kN39ri4CjFq8z+p/6+hF7Po8uU
	 ZkdM2MFPrUIR6HirYHTHvFjdX6Ds5SzmNiaBync+kWfhuIUYVUZZE6mYzT/9LPPsco
	 2lUlL33vAbUpXWxc/3YQoZK3Mk8KVMRN8SfYkEU7350ymoSSnac+eVkgLPGu9Aimwo
	 mol4W5y7LyXIQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Jens Axboe <axboe@kernel.dk>, Miguel
 Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6?=
 =?utf-8?Q?rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Trevor Gross
 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, Frederic Weisbecker <frederic@kernel.org>,
 Lyude Paul <lyude@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, John Stultz
 <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 14/79] block: rnull: add submit queue count config option
In-Reply-To: <abfeIpz8HP_Pr5Yv@google.com>
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
 <20260216-rnull-v6-19-rc5-send-v1-14-de9a7af4b469@kernel.org>
 <abfeIpz8HP_Pr5Yv@google.com>
Date: Wed, 03 Jun 2026 14:00:00 +0200
Message-ID: <87jysfkf5r.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alice Ryhl <aliceryhl@google.com> writes:

> On Mon, Feb 16, 2026 at 12:35:01AM +0100, Andreas Hindborg wrote:
>> Allow user space to control the number of submission queues when creating
>> null block devices.
>> 
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>>  drivers/block/rnull/configfs.rs | 56 +++++++++++++++++++++++++++++++++--------
>>  drivers/block/rnull/rnull.rs    | 56 +++++++++++++++++++++++++++--------------
>>  2 files changed, 83 insertions(+), 29 deletions(-)
>> 
>> diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
>> index b5dc30c5d3e20..fd3cbf7aa012e 100644
>> --- a/drivers/block/rnull/configfs.rs
>> +++ b/drivers/block/rnull/configfs.rs
>> @@ -59,7 +59,10 @@ impl AttributeOperations<0> for Config {
>>  
>>      fn show(_this: &Config, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
>>          let mut writer = kernel::str::Formatter::new(page);
>> -        writer.write_str("blocksize,size,rotational,irqmode,completion_nsec,memory_backed\n")?;
>> +        writer.write_str(
>> +            "blocksize,size,rotational,irqmode,completion_nsec,memory_backed\
>> +             submit_queues\n",
>> +        )?;
>
> Missing comma? If so, this may indicate missing test coverage :)

Indeed :o


Best regards,
Andreas Hindborg


