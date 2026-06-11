Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA09349CFE
	for <linux-block@vger.kernel.org>; Thu, 11 Jun 2026 04:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781153005; cv=none; b=edPPVZ65qg2+J1l6lVFKZuS9sfP3oUhJtxuemTYQPapN5aTK4IvRB6x5NfdXHmfRnb53SUoO9++MUThyvZH3il60TjU9BmafTiD0VAsWejlf+H4A0Bz3c6VaB0KDsEXAbJ9W4kqcfyaHWAyA5+XRFU7QwxGn7bt6EzrOZ/ItArc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781153005; c=relaxed/simple;
	bh=V05i8sWLPIV7+ekrRfpT+axkw+kf4lhxNWhkbffL4mQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bXiv7qfaUjjEad2Sd/cvk+r2LGdlw0EEAjHEL+mT54WnxzJb+pxIKe2PV3W7eQdKPEWpyTj7AYw+WctTtUUwfxtuXEKVSjt+IjhVM+4wkO+k+yL/OmyUlGGBrL14vfUrEBcNES+netQ8GmKmGkDWl1coU5/4IXuY7EfeUWbnbX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hp8pOFHp; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hp8pOFHp"
Message-ID: <9b98e860-11df-44bf-9a95-3046d2c274a6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781152991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=amFobG45FitZxSTZMk37sKmrzp6+HTwygF2QRCMVESA=;
	b=Hp8pOFHpWz66c6aS666mzKdGRUOg5trj2OOXjIC2FT49beQLeiNdwbdvku6y74Ze+FUPE+
	E8RFdhLaOrZjL9dY7cSSbpn242HXv3fuPOtrI0a7ePuPhOCMW89fa+R0t1DoJD4yyOztEo
	oTw51U8wnDSUmm+mYfNoclmpLJbmbns=
Date: Thu, 11 Jun 2026 12:42:02 +0800
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
 <ail4AvzqAOXNaU6N@ashevche-desk.local>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kaitao Cheng <kaitao.cheng@linux.dev>
In-Reply-To: <ail4AvzqAOXNaU6N@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2026/6/10 22:43, Andy Shevchenko 写道:
> On Wed, Jun 10, 2026 at 02:14:06PM +0800, Kaitao Cheng wrote:
>> 在 2026/6/9 18:33, Christian König 写道:
>>> On 6/9/26 08:13, Kaitao Cheng wrote:
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
> 
> Ah, I think the distinct macro families is that what we want.
> But the hiding of the parameter can be done inside list_for_each_*_safe().
> You can do a treewide change with coccinelle.
> 
> Sorry if I didn't get the whole idea from your previous contributions.
> 
> Note, even cases that would need a temporary cursor may be switched to
> new list_for_each_*_safe(), see how PCI macros for iterating over resources
> are implemented (include/linux/pci.h).

Thanks for your suggestions. I've written a demo based on your feedback.
Could you please review it and share your thoughts on this approach?


diff --git a/include/linux/list.h b/include/linux/list.h
index 9df84a56a789..306554ab1841 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -7,6 +7,7 @@
 #include <linux/stddef.h>
 #include <linux/poison.h>
 #include <linux/const.h>
+#include <linux/args.h>

 #include <asm/barrier.h>

@@ -911,20 +912,34 @@ static inline size_t list_count_nodes(struct list_head *head)
        for (; !list_entry_is_head(pos, head, member);                  \
             pos = list_prev_entry(pos, member))

+#define __list_for_each_entry_safe_internal(pos, next, head, member)   \
+       for (typeof(pos) next = list_next_entry(pos =                   \
+               list_first_entry(head, typeof(*pos), member), member);  \
+            !list_entry_is_head(pos, head, member);                    \
+            pos = next, next = list_next_entry(next, member))
+
+#define __list_for_each_entry_safe2(pos, head, member)                 \
+       __list_for_each_entry_safe_internal(pos, __UNIQUE_ID(next), head, member)
+
+#define __list_for_each_entry_safe3(pos, next, head, member)           \
+       for (pos = list_first_entry(head, typeof(*pos), member),        \
+               next = list_next_entry(pos, member);                    \
+            !list_entry_is_head(pos, head, member);                    \
+            pos = next, next = list_next_entry(next, member))
+
 /**
  * list_for_each_entry_safe - iterate over list of given type safe against removal of list entry
  * @pos:       the type * to use as a loop cursor.
- * @n:         another type * to use as temporary storage
- * @head:      the head for your list.
- * @member:    the name of the list_head within the struct.
+ * @...:       either (head, member) or (next, head, member)
+ *     @next:  another type * to use as optional temporary storage. The temporary
+ *             cursor is internal unless explicitly supplied by the caller.
+ *     @head:  the head for your list.
+ *     @member:the name of the list_head within the struct.
  *
  */
-#define list_for_each_entry_safe(pos, n, head, member)                 \
-       for (pos = list_first_entry(head, typeof(*pos), member),        \
-               n = list_next_entry(pos, member);                       \
-            !list_entry_is_head(pos, head, member);                    \
-            pos = n, n = list_next_entry(n, member))
+#define list_for_each_entry_safe(pos, ...)                             \
+       CONCATENATE(__list_for_each_entry_safe, COUNT_ARGS(__VA_ARGS__))\
+               (pos, __VA_ARGS__)

 /**
  * list_for_each_entry_safe_continue - continue list iteration safe against removal

>> With the updated list_for_each_entry() implementation, that extra cursor
>> can be kept inside the iterator itself.  Callers that only want to walk
>> the list, including callers that delete or consume the current entry, no
>> longer need to carry an otherwise-unused temporary variable just to make
>> the macro work.
>>
>>>> The final patch changes include/linux/list.h to keep a private cursor in
>>>> the common entry iterators while preserving the public macro interface.
>>>> The safe variants remain available when callers need the temporary
>>>> cursor explicitly or have stronger mutation requirements.
> 
> 

-- 
Thanks
Kaitao Cheng

