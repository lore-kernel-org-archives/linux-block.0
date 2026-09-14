Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F833B42C7;
	Mon, 14 Sep 2026 08:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789373805; cv=none; b=gDB/MhERjagvDb7oSgM1ClbN/AjdXaVgCLeM7IT4isJyFDxiQuWCfZCH4o4iTbwU50I8N4/Ez7O3vVpg1ml3/2zYSwiaaLJNIiGR/PCt3Ix0aqj1xZUDLYMjxLM0u/KuU0wBg+Oy9IbkIK203HueP5/fgGMK6EJdB/PMvxeY/Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789373805; c=relaxed/simple;
	bh=7FGkG0NWc7WQ8UuV1zHV0N1eYzspl/0gM2ZZH+aIzBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HXz1iwP0yMyr0qOth9f+OKe8rglACoRumGpBEVB7d/2dqZ7jab34nIpBhkiQ0k2Uzr+tor7QLF04mWZz+hA5hfMP+3qBksw+BIBsew5y4A5XW81QFQsoxbuDU+I/RPFgIrrz7N4fnJ6uvh4xlZ/1AvjIHv5f71V7JaHEXZTSXmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5VZa+oD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5VZa+oD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D865F1F000FF;
	Mon, 14 Sep 2026 08:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789373804;
	bh=C2ZDgDBTBPtrsfvAlmUEPAUvKktvQtFVn2Ou8+zwXP8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=g5VZa+oD7n0qwA8dkNw1dGt1hYXlL3zXO88zEqM7vtRhR1kV5deBd4b9OCOtJUWQ5
	 +N4pTKxXSl3IIDDDtWLcdaGHzf5YRCL5WIboBhYwWdxa9PoPaVWsgfnBXEDxHkH1eS
	 xzx1SsHXbB59GXTRN3edLFEomnyLmfK6g4SSrm53cjWCgW8FYM8qzJ2gbI3L+AZzxV
	 sjJLSgZNQmwcLieaLRLf5E+z1ii1Fdan/onsPk9Ph40+wV+r+20SjHboG/rT+ju6mz
	 11hHk1V/FKSJB5okOVcsvDJ52P9SN3ow8/R+JIR55Z7MMROrj45/EqEufFgUSEyF1E
	 /Gne3r9EIYRGw==
Message-ID: <294580c0-ad46-4160-b954-360a8a4dacdb@kernel.org>
Date: Mon, 14 Sep 2026 10:16:33 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/26] mm/fbatch: restore mlock+munlock batching,
 without extra ref
Content-Language: en-US
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Ackerley Tng <ackerleytng@google.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Alexandre Ghiti <alex@ghiti.fr>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>,
 Binbin Wu <binbin.wu@linux.intel.com>, Christian Brauner
 <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Christoph Lameter <cl@gentwo.org>, Claudio Imbrenda
 <imbrenda@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 JP Kobryn <jp.kobryn@linux.dev>, Jan Kara <jack@suse.cz>,
 Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
 Kairui Song <ryncsn@gmail.com>, Kiryl Shutsemau <kas@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Leonardo Bras <leobras.c@gmail.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 Mel Gorman <mgorman@techsingularity.net>, Miaohe Lin <linmiaohe@huawei.com>,
 Michal Hocko <mhocko@suse.com>, Minchan Kim <minchan@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Peter Zijlstra <peterz@infradead.org>, Qi Zheng <qi.zheng@linux.dev>,
 Rik van Riel <riel@surriel.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shakeel Butt <shakeel.butt@linux.dev>, Suren Baghdasaryan
 <surenb@google.com>, Yang Shi <yang@os.amperecomputing.com>,
 Yu Zhao <yuzhao@google.com>, Zach O'Keefe <zokeefe@google.com>,
 Zi Yan <ziy@nvidia.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
 <69ba633c-8fd5-1f4b-2e1e-b9b15b8946be@google.com>
 <ce1e07aa-5600-46c1-b35a-d7df09a84521@kernel.org>
 <96fa2371-8a9e-8fcb-08f0-2977320bbbe8@google.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <96fa2371-8a9e-8fcb-08f0-2977320bbbe8@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/13/26 01:46, Hugh Dickins wrote:
> On Thu, 10 Sep 2026, Vlastimil Babka (SUSE) wrote:
>> On 9/9/26 11:59, Hugh Dickins wrote:
>> > Update mlock_folio(), munlock_folio() and their fbatch callouts and
>> > helpers, to do folio_try_get()s at batch processing time, instead of
>> > holding a folio reference all the while in mlock_fbatch: as in folio.c.
>> > 
>> > But more interesting is the use of mod_mlock_count(), using try_cmpxchg()
>> > to update folio->mlock_count safely when possible (now when on lru_add
>> > fbatch as well as when unevictable). While __mlock_folio() is as hard to
>> > think about as before, __munlock_folio() simpler because munlock_folio()
>> > can adjust mlock_count itself without clear_lru() or lruvec lock, and so
>> > do the folio_test_clear_mlocked() immediately for itself (without which
>> > unevictable_pgs_cleared was likely to appear high, when it should be 0
>> > or low to indicate good mlock health).
>> > 
>> > __munlock_folio() is safe for use even when the unreferenced folio has
>> > been freed and reused. It appears that __mlock_folio() could affect a
>> > folio which has been freed and reused, but only if it is reused as an
>> > mlocked folio, in which case its mlock_count is spuriously incremented
>> > (but usually a spurious munlock decrement will follow).  How grave is
>> > this? If unevictable_pgs_cleared remains low, not so bad.
>> > 
>> > I've gone back and forth on whether to move mlock_fbatch and these
>> > functions into mm/folio.c: for now they stay here in mm/mlock.c.
>> > 
>> > Signed-off-by: Hugh Dickins <hughd@google.com>
>> > ---
>> >  mm/mlock.c | 147 +++++++++++++++++++++++++++++++----------------------
>> >  1 file changed, 86 insertions(+), 61 deletions(-)
>> > 
>> > diff --git a/mm/mlock.c b/mm/mlock.c
>> > index 2c690f18031e..1050010bbe0b 100644
>> > --- a/mm/mlock.c
>> > +++ b/mm/mlock.c
>> > @@ -58,6 +58,20 @@ EXPORT_SYMBOL(can_do_mlock);
>> >   * indicate the unevictable state.
>> >   */
>> >  
>> > +static long mod_mlock_count(struct folio *folio, long incdec)
>> > +{
>> > +	long mlock_count = READ_ONCE(folio->mlock_count);
>> > +
>> > +	while (mlock_count & MLOCK_COUNT_0) {
>> > +		if (mlock_count + incdec < MLOCK_COUNT_0)
>> > +			return MLOCK_COUNT_0;
>> > +		if (try_cmpxchg(&folio->mlock_count, &mlock_count,
>> > +				mlock_count + incdec))
>> > +			return mlock_count + incdec;
>> > +	}
>> 
>> This never rereads folio->mlock_count to mlock_count inside the loop, so it
>> can spin forever?
> 
> You give me a nasty moment, have I misunderstood? Isn't it part of the
> try_cmpxchg() contract, that it reads folio->mlock_count into mlock_count
> when it fails? Hence the "&mlock_count" rather than just "mlock_count"?

Indeed, sorry! It would have helped if the contract was spelled out
somewhere. But now I found it only for the atomic_try_cmpxchg() variant.
Guess I'm too used to the slab_update_freelist() wrappers which don't follow
this... but maybe should? Hmm.

>> 
>> (too late here for me to understand the rest today)
> 
> But that I understand very weil: thanks for all that you have managed.
> 
> Hugh

