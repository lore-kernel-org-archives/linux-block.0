Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38EC35CBD6
	for <linux-block@vger.kernel.org>; Thu, 11 Jun 2026 12:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781180903; cv=none; b=gZX9bTM9Lr6hYXxp2vC28t0eCAkqTEVyRURLs5HnDR5hevem19GK1Ajquk3HoeT2xQBZZRufSsV5/3+aKd3LqbYZGF+AFTfVc3krAjOHYKVpvCNYdXQVS+3Sl3bPnKxa9Mf+Cz/Ht8BOYwgsNyfTbrb6qT0ICn6ImKh9Cwydca8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781180903; c=relaxed/simple;
	bh=RDiTQ/Lmd64nR5okqaIR9mwmKBXaymSA9H8Ldcbh2Jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZKXlU9X5KZd1BtB8y4epGG5opKrHlxwYgmp1rcvfQjigQcNfxakStoWNjHfv9EKEwKyvM5ywB7EF2ySqXmsHY7f/GwRQ6n/gFL+n3UW1+rFWVb3xmwX/HrD9sI8dwAbiV4IMosFjRAWXPpfAcp4oz1zTu4dhxIxtZXm2MHr3+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rFXXpM7I; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rFXXpM7I"
Message-ID: <27b726c2-9b72-4b44-9d85-9b1aa12851a2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781180888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/UsUeGpou3lVapXWhjq32I6t+zBdHKuqjJl90iVDSiA=;
	b=rFXXpM7IJOrHQFdgRhKujVf5VdxV6jkKNFlDsX25IoXEP9KJZ8Dv8l5c0nKTafwKXUsRZ9
	3BPFb1LLg9n4GliYQt3h1fAcAsjSrL2AfeU8aUx/g3f9LERtMslSnnlcG3/NjMtCHL+fHf
	5Y0xERqt55aedIITIkiJCvpkmeFBkwg=
Date: Thu, 11 Jun 2026 20:27:05 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 00/14] list: Prepare entry iterators to cache cursor
 state
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
 <2399841f-d834-4652-8285-4a15c7d9a9b9@linux.dev>
 <d974a2ea-6102-45ff-bf36-3b25a2404e40@amd.com>
 <ail8iNvPrJnE7p58@ashevche-desk.local>
 <92683537-8404-47fe-a4ba-160e54870f0b@amd.com>
 <aipx1goKIsk40vrF@ashevche-desk.local>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kaitao Cheng <kaitao.cheng@linux.dev>
In-Reply-To: <aipx1goKIsk40vrF@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2026/6/11 16:29, Andy Shevchenko 写道:
> On Thu, Jun 11, 2026 at 10:01:25AM +0200, Christian König wrote:
>> On 6/10/26 17:02, Andy Shevchenko wrote:
>>> On Wed, Jun 10, 2026 at 11:11:34AM +0200, Christian König wrote:
>>>> On 6/10/26 10:18, Kaitao Cheng wrote:
>>>>> 在 2026/6/10 16:07, Christian König 写道:
> 
> ...
> 
>>>>> Should we revert to v1, or keep list_for_each_entry() and
>>>>> list_for_each_entry_safe() as they are, close this thread, and make no
>>>>> changes?
>>>>>
>>>>> Link to v1:
>>>>> https://lore.kernel.org/all/20260529082149.76764-1-kaitao.cheng@linux.dev/
>>>>>
>>>>> Or do you have any better suggestions?
>>>>
>>>> v1 looks perfectly reasonable to me.
>>>
>>> But why not just hiding that once for all (in case they don't use the temporary
>>> iterator)? Easy to automate, robust — everyone is happy?
>>
>> As far as I can see that is an extremely bad idea.
>>
>> The distinction between the use cases of 'iterating the list' and 'iterating
>> the list while you modify it' is completely intentional.

I agree with this point. It is very reasonable for list_for_each_entry()
to be used only for 'iterating the list'. In practice, however, we do not
have an effective way to enforce that rule for users, whereas the distinction
between bool and int can be enforced by the compiler. The 13 patches in the
current series are all real examples where users modify the list while using
list_for_each_entry(). Is a rule that cannot actually be enforced reasonable?
This is just my humble opinion, and I am raising it here only for discussion.

> What I meant is to keep the name, just drop the parameter (make it hidden and
> being defined inside list_for_each_*_safe() cases).

I agree with this approach, but the specific details still need to be settled,
including the issue described in the link below.

https://lore.kernel.org/all/0a333eb8-fc29-4b85-993e-6b726f4c7cf0@linux.dev/

Of course, there is also the suffix-renaming issue raised by Christian.

>> See the bool type can be implemented by int as well, but it is just a
>> different use case.
> 
>>>> You should just include some patches in the same patch set to actually use
>>>> the new macros.
>>>>
>>>> If you modify the files under drivers/dma-buf or drivers/gpu/drm/amd to use
>>>> the new macro I'm happy to review that.
>>>
>>
> 

-- 
Thanks
Kaitao Cheng

