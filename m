Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2543E33F58B
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 08:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079595; cv=none; b=hdkZRSd8M5WVYlktgLOMTk6k4r1uWwoj4l5dPRFVqT2AaWXaJqPmDIAMin6Q1J44pvaLIS92REr9qYC7Rl3p66rbQZgMibgKQkW8/zAQMBCoHfSa27qhYuAzSqVj1zdAHtauW0NQtHQUYElnAZeUvNsNqOf9h+WQULtGFE5og3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079595; c=relaxed/simple;
	bh=Jyc91vyJ7ndQgFlz+YZrGZa32ZyUmsV/OWq4Besj+oQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O/fvzbVc9x5gOG4g9msQV+7cFlARD9Gly6W1xN9P32XblCxcYkMfgpFQkLAbRWINtIIwbC4O/Lu9eV9CDD1nCU7AnLoPu/Oi/kbiCAenbQY21/5i9amTt1dhonCXI1u4IMefH2+iyF4/0NxUqt047CuhIRvNzlnUd27Xu0q5o9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b+KKxMDO; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b+KKxMDO"
Message-ID: <2399841f-d834-4652-8285-4a15c7d9a9b9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781079581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vgeT73qC1JMBtqJB2TUIr+4bit/wHx6kJFn5Pav/2f4=;
	b=b+KKxMDOPPD9issjhumw6+KGbYM7wMtezvy5jEnscI0CZYz2NKMOHn33g1ku+yIj4Y2DTn
	+Yag6Z6BDFL2Y2GchMx0dVC5s3t6GNYZv4TV2TeNkysaubM7HMus5UBFldLUBxBN8KRyYZ
	t05b5xvQnStTsnzUuvWsLluFbGiay9I=
Date: Wed, 10 Jun 2026 16:18:28 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 00/14] list: Prepare entry iterators to cache cursor
 state
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Davidlohr Bueso <dave@stgolabs.net>, "Paul E . McKenney"
 <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Huang Rui <ray.huang@amd.com>,
 Eddie James <eajames@linux.ibm.com>, Mark Brown <broonie@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Laxman Dewangan <ldewangan@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, Waiman Long <longman@redhat.com>,
 drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
 linux1394-devel@lists.sourceforge.net, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, linux-spi@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Christian Brauner
 <brauner@kernel.org>, David Howells <dhowells@redhat.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Kaito Cheng <chengkaitao@kylinos.cn>, Muchun Song <muchun.song@linux.dev>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Jens Axboe <axboe@kernel.dk>, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
References: <20260609061347.93688-1-kaitao.cheng@linux.dev>
 <bd0b7393-8ccb-4d67-8bfc-18c68347122c@amd.com>
 <5152089a-2808-4fe9-b633-b03018105dd2@linux.dev>
 <6b2efdee-95b0-4306-a682-0d0466497ddb@amd.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kaitao Cheng <kaitao.cheng@linux.dev>
In-Reply-To: <6b2efdee-95b0-4306-a682-0d0466497ddb@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2026/6/10 16:07, Christian König 写道:
> On 6/10/26 08:14, Kaitao Cheng wrote:
>> 在 2026/6/9 18:33, Christian König 写道:
>>> On 6/9/26 08:13, Kaitao Cheng wrote:
>>>> From: Kaito Cheng <chengkaitao@kylinos.cn>
>>>>
>>>> This series prepares for, and then updates, the list_for_each_entry()
>>>> family so the common entry iterators cache their next or previous cursor
>>>> before the loop body runs.
>>>
>>> Why in the world would we want to do that?
>>>
>>> The safe and non-safe variants have very distinct use cases and that is completely intentional.
>>>
>>> What we could improve maybe is the documentation, from my experience an astonishing large amount of people have misconceptions about the safe variants.
>>>
>>>> The first 13 patches open-code loops that intentionally depend on the
>>>> old "derive the next entry from the current cursor at the end of the
>>>> iteration" behaviour.  These loops append work to the list being walked,
>>>> restart traversal after dropping a lock, skip an entry consumed by the
>>>> current iteration, or otherwise adjust the cursor in the loop body.
>>>
>>> Well I have to clearly reject the changes for subsystems/components I'm maintaining, that just looks horrible to me and I clearly don't see a good reason for that.
>>
>> Hi Christian and Andy Shevchenko,
>>
>> Thanks for taking a look. I would like to clarify the point you raised.
>>
>> The reason I started looking at this is the original motivation behind
>> the _safe() variants.  They exist because some users need to remove, move
>> or otherwise consume the current entry while walking the list.  In that
>> case the next cursor has to be preserved before the loop body can modify
>> the current entry.
>>
>> The unfortunate part is that this could not be expressed with the
>> existing list_for_each_entry() interface without changing its calling
>> convention.  The _safe() variants had to grow an extra argument for the
>> temporary cursor, and that is why we ended up with a separate family of
>> macros.
>>
>> But conceptually, the distinction does not have to be exposed as two
>> different iterator families forever.  The difference is an implementation
>> detail: whether the iterator keeps the next/previous cursor before the
>> body runs.  This series makes the common list_for_each_entry() iterators
>> do that internally, so the safe and non-safe forms can effectively be
>> folded together, or at least the need for a separate public _safe()
>> interface becomes much weaker.
>>
>> There is also a usability issue with the current _safe() interface.  The
>> caller is forced to define a temporary cursor outside the macro and pass
>> it in, even though almost all users never use that cursor directly.  It is
>> just boilerplate required by the macro implementation.  I find that
>> redundant and awkward: the temporary cursor is an internal detail of the
>> iteration, but every caller has to spell it out.
>>
>> With the updated list_for_each_entry() implementation, that extra cursor
>> can be kept inside the iterator itself.  Callers that only want to walk
>> the list, including callers that delete or consume the current entry, no
>> longer need to carry an otherwise-unused temporary variable just to make
>> the macro work.
> 
> Well the distinction between list_for_each_entry() and list_for_each_entry_safe() is *not* there because you need an extra variable to hold the next pointer, but because just 'iterating the list' and 'iterating the list while you modify it' are two distinct use cases.
> 
> Apart from the technical implications this also has some documentation value for the code using it.
> 
> What we could consider with C99 at hand is to have _safe() variants who uses a local hidden variable to hold the next element.
> 
> Or maybe come up with a better name instead of _safe() because people seem to misunderstand that quite often.
> 
> But mangling the two use cases together just because it is now technical possible is among the worst ideas I've ever heard.
> 

Should we revert to v1, or keep list_for_each_entry() and
list_for_each_entry_safe() as they are, close this thread, and make no
changes?

Link to v1:
https://lore.kernel.org/all/20260529082149.76764-1-kaitao.cheng@linux.dev/

Or do you have any better suggestions?

-- 
Thanks
Kaitao Cheng

