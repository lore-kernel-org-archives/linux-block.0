Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094892D0625;
	Wed,  3 Jun 2026 12:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780490630; cv=none; b=AxZc7lkiPv31ks+tg3Alw+DU9bHj/NCZhJGZbF5bQNm5UEQfbyBENdreFXFEfNmNIz/U2WVrvIBRakxcbXeJG0gJcRzRDDQuSbJmxrUizocJkLFymkAqas3w7dG077jMPKg8/eW85Dj8m9VzsshtC21sa0tx0WfwhQJ6Wz1qbC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780490630; c=relaxed/simple;
	bh=IIYVr6RbvXUvthp/OaFtZj+uB5wY/D8z731UtHRH2Ww=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZlB0pRX96trdKxwuMz+qUlKUKXa2aZhvG6LrwoG9FbDcpliLAHDXkLOWXLAXhfiHIAPD0hgmm8qhGaNbiDApQCKh0yC5jfeGrlUQlVIlMXLcv6MjH7kcS5pPRqYxsGvKmEhdFoLvkRraTTlnIizRpN+B1EO5zGGj6d8OX7xXKK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMr2uM+H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMr2uM+H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571ED1F00893;
	Wed,  3 Jun 2026 12:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780490628;
	bh=hSlKPq/EwdliQicBG142n4MIcXe9Hvj+qJ5zrzWkG8w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=dMr2uM+HMXmTM8LDb3J+bX3sfxt4mX1Xkqpn7J8iBGmN+/7xnPHt2aDWxBnSpSTpp
	 +D8heQVrPl+rEhsni0T568ZZvyGIQeapGfjTlhY6O3s+9e1tIxi9w53o/v0ic5rjKH
	 uNNTcVOAVPfiP9krvWIXGhsFrhISzcWvijeqPpHPv1yu3VKvGeNreGNQqo/7n+/jF4
	 Q0m71pq+Mozsv2jHy0gGQEVI2p1H+/dAQiAhDg2d2gpH1KqdULYU5r60t6lhTsDvCU
	 lPbQ11nd76hapbeuTcRhHvRWNsW/cXbPR1P9+x/dYyHTIQILVOGRXOOBtvAchPV3gt
	 8o9sBOG9jsE/w==
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
Subject: Re: [PATCH 26/79] block: rnull: add badblocks support
In-Reply-To: <abfxSTL2qTMtpnY7@google.com>
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
 <20260216-rnull-v6-19-rc5-send-v1-26-de9a7af4b469@kernel.org>
 <abfxSTL2qTMtpnY7@google.com>
Date: Wed, 03 Jun 2026 14:43:39 +0200
Message-ID: <87ecinkd50.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alice Ryhl <aliceryhl@google.com> writes:

> On Mon, Feb 16, 2026 at 12:35:13AM +0100, Andreas Hindborg wrote:
>> Add badblocks support to the rnull driver with a configfs interface for
>> managing bad sectors.
>> 
>> - Configfs attribute for adding/removing bad blocks via "+start-end" and
>>   "-start-end" syntax.
>> - Request handling that checks for bad blocks and returns IO errors.
>> - Updated request completion to handle error status properly.
>> 
>> The badblocks functionality is disabled by default and is enabled when
>> first bad block is added.
>> 
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>
>> +    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
>> +        // This attribute can be set while device is powered.
>> +
>> +        for line in core::str::from_utf8(page)?.lines() {
>> +            let mut chars = line.chars();
>> +            match chars.next() {
>> +                Some(sign @ '+' | sign @ '-') => {
>> +                    if let Some((start, end)) = chars.as_str().split_once('-') {
>> +                        let start: u64 = start.parse().map_err(|_| EINVAL)?;
>> +                        let end: u64 = end.parse().map_err(|_| EINVAL)?;
>> +
>> +                        if start > end {
>> +                            return Err(EINVAL);
>> +                        }
>> +
>> +                        this.data.lock().bad_blocks.enable();
>> +
>> +                        if sign == '+' {
>> +                            this.data.lock().bad_blocks.set_bad(start..=end, true)?;
>> +                        } else {
>> +                            this.data.lock().bad_blocks.set_good(start..=end)?;
>
> Taking lock twice: TOCTOU.

I fixed all of these, thanks for reporting.

>
>> @@ -118,6 +125,7 @@ fn make_group(
>>                      home_node: bindings::NUMA_NO_NODE,
>>                      discard: false,
>>                      no_sched: false,
>> +                    bad_blocks: Arc::pin_init(BadBlocks::new(false), GFP_KERNEL)?,
>>                  }),
>>              }),
>>              core::iter::empty(),
>
> [..]
>
>> @@ -155,6 +160,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
>>                      home_node: *module_parameters::home_node.value(),
>>                      discard: *module_parameters::discard.value() != 0,
>>                      no_sched: *module_parameters::no_sched.value() != 0,
>> +                    bad_blocks: Arc::pin_init(BadBlocks::new(false), GFP_KERNEL)?,
>
> It seems weird to construct this Arc in two places. Is it shared or not?

In the case where the device is created via configfs, the `BadBlocks`
instance is shared. When the device is constructed via module
parameters, the `BadBlocks` instance is not shared. In this case it is
actually not used, as there is no way to enable the code path. But we
need to provide an instance anyway.

I did not want to use an Option, because I did not want the checks on
access.


Best regards,
Andreas Hindborg



