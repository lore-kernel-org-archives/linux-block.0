Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6FC3AB47A
	for <linux-block@vger.kernel.org>; Fri, 31 Jul 2026 16:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785517105; cv=none; b=CbWk9IMMQO5nUlsySLE2Qh5A2Le/P72hbZDEsUfeTuKino4UL0rsK/Pm/ztCwtQv4ZRWMUiX4ettUbDgR/G+ax0YZ1dRiMKJZ+41oWBZAocI/St9tOPH771N7Az58cfGJCE7YQwX6T/TuBteEcCb4L+2IvSDmxvDqxYf67nMBw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785517105; c=relaxed/simple;
	bh=7Wkc5vnPJfK8+T6cj+GxOwF6aP8t3LLmOUCwYz0pevc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eJ6ywt5LQddsv6DbL9zYscSuBYI4mO/g9VXKeoiaCX1K3r7dl/C2yKi7y0cZFaQN1AmDxh8ZlXg7dm7PKzKDWo1Tkr3JBTkZ5qRyMejbJGFdZIZ1ptQ/Tf4ppI6UP93ubrbnZJ/EjVBk8Aa8ZhAEG+glxuCG1myMsxuckSWkNXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QDupzw9e; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QDupzw9e"
Message-ID: <191efe80-24d1-4aab-8746-21afb4c379bc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785517090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Wkc5vnPJfK8+T6cj+GxOwF6aP8t3LLmOUCwYz0pevc=;
	b=QDupzw9eNh0JVgtVkhnk9fpyAzqrfoSZcykUG5rIYn9PyeUrXBswOnBQUHvPKBV/p2MNUf
	mfRJ1cQlIl9txEmp6iCYbDFObuLFKeBZy0GRG3CtTIljNnrDbkEdkJiywNamh8zB4FrxIM
	8PggOuJ4D54cvOEyYOsxvLigg1zLIWo=
Date: Sat, 1 Aug 2026 00:57:22 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v9 00/10] Fix missing fops.owner in Rust DRM/misc
 abstractions
To: Gary Guo <gary@garyguo.net>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
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
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>
References: <20260723-fix-fops-owner-v9-0-c1c3af7f7bcb@linux.dev>
 <CANiq72m59O-ruHUvUcZC7yCvu0KV0w_m5vMO4e0rxyHdRmihJw@mail.gmail.com>
 <68c43a03-5fa0-42a8-b886-2c756e39515e@linux.dev>
 <DKCWO60T6JPR.1P3AAJAATMXBI@garyguo.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alvin Sun <alvin.sun@linux.dev>
In-Reply-To: <DKCWO60T6JPR.1P3AAJAATMXBI@garyguo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 8/1/26 00:43, Gary Guo wrote:
> On Fri Jul 31, 2026 at 5:34 PM BST, Alvin Sun wrote:
>> Hi Miguel,
>>
>> Thanks for taking a look!
>>
>> On 7/31/26 14:46, Miguel Ojeda wrote:
>>> On Thu, Jul 23, 2026 at 4:11 AM Alvin Sun <alvin.sun@linux.dev> wrote:
>>>> base-commit: b7e5ac83cb16f7ffd11dc23736f84276602100ed
>>> Was this old tag used for some reason?
>> That was an oversight on my part - I forgot to rebase onto the latest
>> tag before sending v9. The series is now based on v7.2-rc4.
>>
>>>> prerequisite-change-id: 20260519-miscdev-use-format-9ab7e83b1c11:v3
>>>> prerequisite-patch-id: 405b334ff0d48ad350014f05a2321bdbaa025400
>>>> prerequisite-patch-id: 604b631c81d5423f4ebb2e12ba2d22e9ce371bfc
>>>> prerequisite-patch-id: cb550d94cefe01920e0d3ced2b2bcbecd76f3907
>>>> prerequisite-patch-id: 3bc830839742591460cb86d9472c04f4686dc600
>>>> prerequisite-patch-id: 571058244bc8c7088638d2e3225713011246c7e9
>>>> prerequisite-patch-id: 347c5a3c6dbef9832bfce8419fc23e6e08ba477f
>>>> prerequisite-patch-id: 3e202d988b56b88446f7535e90d3f00cf5f15701
>>> Are all these actually needed? Some seem unrelated (some were already
>>> applied too).
>> The prerequisites were just some import formatting changes that the
>> series depended on at the time. After rebasing onto v7.2-rc4, I was
>> able to drop all of them - the rebase was clean with no conflicts.
>>
>> I'll send v10 shortly.
> If the patch applies cleanly then there's a no need to send a new version.

Sounds good. I'll hold off on v10 then. Thanks!

Best regards,
Alvin

>
> Best,
> Gary
>
>> Best regards,
>> Alvin
>>
>>> The only one that seems needed has Andreas' Acked-by, so
>>> I guess it is fine.
>>>
>>> (By the way, I will use this second message to take this chance to
>>> move the modules maintainers in the To: in case it helps, since I
>>> didn't do it in my previous message)
>>>
>>> Thanks!
>>>
>>> Cheers,
>>> Miguel
>
