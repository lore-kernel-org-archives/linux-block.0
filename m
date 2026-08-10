Received: from mta1.migadu.com (out-97.mta1.migadu.com [95.215.58.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DA635C695
	for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 09:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786355034; cv=none; b=X671U1DOGTMiu5vVR7xk0ITgLraY+W11/vVVvyUDDRTseqmzlAKAmh4eExie8VRfGp6JbP5/HH+9pc8J3lTc/lGOA8lwWTznkWdKG1tc5QJLOEqD/RDl4lFCCOsU1xynvfJ2iNR/10O+4psCrv59lSz5DxDunEh5IgnrKFvmZ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786355034; c=relaxed/simple;
	bh=oM0nShtvENJ/IoYuzI4EAurH6RtVncCAM7zuaIO1J30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b9RDgnX3DQTXvpLBGQMrdrXPzRMXEkelZZm5Ki+sxxrXMvfGCU79Tr0JLYGmv+2gPbTClC4/yYeWF7AAWZElkoWlkrxmAc3dlG6AZ/K9qQsfqKlUiaAsGi6ez81fKvQMfa85kstMVP+DZLCgXU9HSKI/DEDuU0VapBqkOBVvYoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MYaqsu/H; arc=none smtp.client-ip=95.215.58.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MYaqsu/H"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=oM0nShtvENJ/IoYuzI4EAurH6RtVncCAM7zuaIO1J30=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786355031; v=1; x=1786959831;
 b=MYaqsu/H3U0KVOKCCen3mzHz8hT/6YK+6UUVA4iT+gKdsbqa82CVA1DmRqRUUAHtCHKNyJ+j
 56MOpFxJDVwapfWReUKuZFWyj9gJ0cGKpPTPhJ0r0D1/7XpOepj5S6zYhh+/Al/BVQFi6xlcekx
 9rCNgfYRtxes5DL7YleMLhzU=
X-Envelope-To: linux-block@vger.kernel.org
Received: from [10.0.11.3] (2a11:3:200::10a9)
	by mta10.migadu.com with ESMTPS id fe8757a2b2912904;
	Mon, 10 Aug 2026 09:43:51 +0000
X-Migadu-Scanner: mta10.migadu.com
Authentication-Results: mta10.migadu.com;
	none
Message-ID: <a99bc12d-0103-4780-94b0-ecc82e4e0b95@linux.dev>
Date: Mon, 10 Aug 2026 17:43:28 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] rust: use vertical import style and remove
 redundant imports
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
 rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
References: <20260521-miscdev-use-format-v3-0-56240ca70d0c@linux.dev>
 <CANiq72k3cjgHiimYqGfuQjPy+A3oOUEoMxUJCS-FgBm25D4MLA@mail.gmail.com>
From: Alvin Sun <alvin.sun@linux.dev>
In-Reply-To: <CANiq72k3cjgHiimYqGfuQjPy+A3oOUEoMxUJCS-FgBm25D4MLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/26/26 01:51, Miguel Ojeda wrote:
> On Thu, May 21, 2026 at 8:57 AM Alvin Sun <alvin.sun@linux.dev> wrote:
>> Adopt the vertical import style and drop redundant imports already
>> re-exported via `kernel::prelude`.
> I can take this if block and misc Ack. The changes are straightforward anyway.

Hi Miguel,

I would like to follow up on the remaining patches from this series:

   rust: block: mq: use vertical import style
   rust: block: mq: remove redundant imports and format
   rust: block: rnull: use vertical import style
   rust: doctest: use vertical import style

As far as I can tell, these have not been merged yet. Andreas already
acked the block parts [1][2][3] and David Gow acked the doctest change
[4]. Is there anything else needed from my side before they can be
picked up, such as a rebase onto a newer base?

[1] 
https://lore.kernel.org/rust-for-linux/87v7bgf8f3.fsf@t14s.mail-host-address-is-not-set/
[2] 
https://lore.kernel.org/rust-for-linux/87se6kf8af.fsf@t14s.mail-host-address-is-not-set/
[3] 
https://lore.kernel.org/rust-for-linux/87pl1of7ve.fsf@t14s.mail-host-address-is-not-set/
[4] 
https://lore.kernel.org/rust-for-linux/5748f9ca-e684-42a0-9297-e587b178a47c@davidgow.net/

Best regards,
Alvin

>
> Thanks!
>
> Cheers,
> Miguel
