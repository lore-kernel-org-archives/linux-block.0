Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D4C3CF21D
	for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 08:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783932499; cv=none; b=gkcQnHLVKeiHAPsIWehyh24jeGsVAftoCPVCWsone0dyvQDGFzomRYggSWA8JW1R4XvsUzbtZ8+kcd1pHiIsrK0eGzxcqUMep9nDTDfqlTmhzLTK0THKr/Bemm8CVlICnGqGTz7EW5oj9MHLhxXWOIkBajFV4loZKlVDOay8LLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783932499; c=relaxed/simple;
	bh=BWNH+b+gVTgbSUB8suyA5dE6r5GkLqsKddLzlmNjUZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ASckZ/u/nS7STop4dkGZnmojMJHxDGXnuKNPgDlxZ9eWNE9KijOcBhjWjxOtGKK1ec/gc9RTlxUGBuZVI9V5nVEdStvWg8NFljCKXWcXm9MfPjoaJu0uRiflybUrTrNREDYHOM3rW5wWrs6EY+JstNYoNrbG6K53iJTaSgn9pok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T5/QGkKu; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T5/QGkKu"
Message-ID: <d7c1607f-ea74-442a-9700-7fc4f0c64b76@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783932491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GQlgXP7bj8bfTDjYknZjTJi5ysGxhStqQgrMWEWotTo=;
	b=T5/QGkKux4oRzWiz0v1dlhnIq9/TTeccaPXaIXG1RKQQN1W/8VMTI6h0trrs7uuLyg0x66
	WFpRHrrjbcJ7iVNdp2+/ucPBVn8kOi04fn0ljSUrxkgZ2DYozojIRSrt7Skde9XYDLsZnw
	xfiRE5qPtburcUDvr7r2kc1MzqmqAqc=
Date: Mon, 13 Jul 2026 16:47:13 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v8 10/10] rust: module: update MAINTAINERS to cover
 module.rs
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann
 <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
 Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>,
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>,
 Igor Korotin <igor.korotin@linux.dev>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>,
 Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org,
 linux-modules@vger.kernel.org, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260713-fix-fops-owner-v8-0-2495cfa82d47@linux.dev>
 <20260713-fix-fops-owner-v8-10-2495cfa82d47@linux.dev>
 <alSe6PsvdrSYP_Z0@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alvin Sun <alvin.sun@linux.dev>
In-Reply-To: <alSe6PsvdrSYP_Z0@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/13/26 16:16, Alice Ryhl wrote:
> On Mon, Jul 13, 2026 at 02:45:31PM +0800, Alvin Sun wrote:
>> Module types now live in `rust/kernel/module.rs` alongside
>> `rust/kernel/module_param.rs`. Update the MODULE SUPPORT file pattern
>> from `rust/kernel/module_param.rs` to `rust/kernel/module*.rs` so both
>> files are covered.
>>
>> Cc: Petr Pavlu <petr.pavlu@suse.com>
>> Assisted-by: opencode:glm-5.2
>> Link: https://lore.kernel.org/rust-for-linux/8ea21b29-9baf-4926-a16f-7d21c5a1a1b8@suse.com
>> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
>> ---
>>   MAINTAINERS | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index e035a3be797c4..74733de3e41ee 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -17984,7 +17984,7 @@ F:	include/linux/module*.h
>>   F:	kernel/module/
>>   F:	lib/test_kmod.c
>>   F:	lib/tests/module/
>> -F:	rust/kernel/module_param.rs
>> +F:	rust/kernel/module*.rs
>>   F:	rust/macros/module.rs
>>   F:	scripts/module*
>>   F:	tools/testing/selftests/kmod/
> Is there a reason why this is a separate commit from the commit that
> introduces rust/kernel/module.rs file?

Gary asked the same on v6; `git log` shows MAINTAINERS changes are 
conventionally
standalone commits with a `MAINTAINERS: ` prefix, so I kept it separate. 
Gary agreed [1].

[1]: 
https://lore.kernel.org/rust-for-linux/DJJ26195JBS9.D3DNLZPRJYO4@garyguo.net/

Best regards,
Alvin

>
> Alice
