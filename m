Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E0525B1C7
	for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 20:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771964864; cv=none; b=KjH6XsmwY3OC5kMybanwEm+PQTPmMJvjSOoTx70ttLBgcEQ13QqKUD5MDubVXulnaWBIwoYn/Lsi2oL0GNnMbFlgphSonhHslP/CAM4aZfA3jKCwa8/MDcVEWLPjMzwKYi4FSLjlcFHXn0ZzURyd569RwEwD4w/srUYO4UqOogU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771964864; c=relaxed/simple;
	bh=3sPPdeo23AEB39A4+NBUGFE1yoYIX6tQrRtbi/jK9AI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dVVm2cJAy51hIkicBM0oCaM7BxdI76UKURvULbVez383f9liRuRhUU03uwCboVb4HRE2zMM8qu2ObsQasn8/nhbxANeWwmX5NHb+ngXJm5QOYSs5tBO2oIHe9sAiAN8ssimEKgLEpdidnKrGPUOUTvJdWWqnUXhjWu/bqqdiiwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QdF5JmcU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=75l70SI6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QdF5JmcU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=75l70SI6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QdF5JmcU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="75l70SI6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QdF5JmcU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="75l70SI6"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F28D15BD46;
	Tue, 24 Feb 2026 20:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771964861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OOVN9jEJNG7Mu5+kNp6k/MarnsSgkp1B4MAgqDJQnJ8=;
	b=QdF5JmcUywI6HU7zFokoNIDQjCsB+1OwTPucjKQFk/BZSdXPofHgdFS5rAyOWm/p8W2hJA
	FaJynrYMipbSNsw/YCXU/YuPNUOZx2mSASkLd33AESFQ5U/L5Y9D1p9/B187nPMjoj5HTZ
	2ebz/EIO1pjnlLVrJW8HBxM/2+hUODE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771964861;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OOVN9jEJNG7Mu5+kNp6k/MarnsSgkp1B4MAgqDJQnJ8=;
	b=75l70SI6C5oE+J0ydi240x4Sxub2GMjdw/ByHj7pI9QFRaA5L9CxDZhnF+Zj9uswAGGaMV
	ynI7VFhcPiaKsNBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QdF5JmcU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=75l70SI6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771964861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OOVN9jEJNG7Mu5+kNp6k/MarnsSgkp1B4MAgqDJQnJ8=;
	b=QdF5JmcUywI6HU7zFokoNIDQjCsB+1OwTPucjKQFk/BZSdXPofHgdFS5rAyOWm/p8W2hJA
	FaJynrYMipbSNsw/YCXU/YuPNUOZx2mSASkLd33AESFQ5U/L5Y9D1p9/B187nPMjoj5HTZ
	2ebz/EIO1pjnlLVrJW8HBxM/2+hUODE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771964861;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OOVN9jEJNG7Mu5+kNp6k/MarnsSgkp1B4MAgqDJQnJ8=;
	b=75l70SI6C5oE+J0ydi240x4Sxub2GMjdw/ByHj7pI9QFRaA5L9CxDZhnF+Zj9uswAGGaMV
	ynI7VFhcPiaKsNBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA1C73EA68;
	Tue, 24 Feb 2026 20:27:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o9XjMLwJnmkNRAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 24 Feb 2026 20:27:40 +0000
Message-ID: <5cf75a95-4bb9-48e5-af94-ef8ec02dcd4d@suse.cz>
Date: Tue, 24 Feb 2026 21:27:40 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Regression] mm:slab/sheaves: severe performance regression in
 cross-CPU slab allocation
To: Ming Lei <ming.lei@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, Harry Yoo <harry.yoo@oracle.com>,
 Hao Li <hao.li@linux.dev>, Christoph Hellwig <hch@infradead.org>
References: <aZ0SbIqaIkwoW2mB@fedora>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <aZ0SbIqaIkwoW2mB@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: F28D15BD46
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 2/24/26 3:52 AM, Ming Lei wrote:
> Hello Vlastimil and MM guys,
> 
> The SLUB "sheaves" series merged via 815c8e35511d ("Merge branch
> 'slab/for-7.0/sheaves' into slab/for-next") introduces a severe
> performance regression for workloads with persistent cross-CPU
> alloc/free patterns. ublk null target benchmark IOPS drops
> significantly compared to v6.19: from ~36M IOPS to ~13M IOPS (~64%
> drop).
> 
> Bisecting within the sheaves series is blocked by a kernel panic at
> 17c38c88294d ("slab: remove cpu (partial) slabs usage from allocation
> paths"), so the exact first bad commit could not be identified.
> 
> Reproducer
> ==========
> 
> Hardware: NUMA machine with >= 32 CPUs
> Kernel:   v7.0-rc (with slab/for-7.0/sheaves merged)
> 
>     # build kublk selftest
>     make -C tools/testing/selftests/ublk/
> 
>     # create ublk null target device with 16 queues
>     tools/testing/selftests/ublk/kublk add -t null -q 16
> 
>     # run fio/t/io_uring benchmark: 16 jobs, 20 seconds, non-polled
>     taskset -c 0-31 fio/t/io_uring -p0 -n 16 -r 20 /dev/ublkb0
> 
>     # cleanup
>     tools/testing/selftests/ublk/kublk del -n 0
> 
> Good: v6.19 (and 41f1a08645ab, the mainline parent of the slab merge)
> Bad:  815c8e35511d (Merge branch 'slab/for-7.0/sheaves' into slab/for-next)
> 
> perf profile (bad kernel)
> =========================
> 
> ~47% of CPU time is spent in bio allocation hitting the SLUB slow path,
> with massive spinlock contention on the node partial list lock:
> 
> +   47.65%     1.21%  io_uring  [k] bio_alloc_bioset
> -   44.87%     0.45%  io_uring  [k] kmem_cache_alloc_noprof
>    - 44.41% kmem_cache_alloc_noprof
>       - 43.89% ___slab_alloc
>          + 41.16% get_from_any_partial

So this function is not used in the sheaf refill path, but in the
fallback slowpath when alloc_from_pcs() fastpath fails.

>            0.91% get_from_partial_node
>          + 0.87% alloc_from_new_slab
>          + 0.65% allocate_slab
> -   44.70%     0.21%  io_uring  [k] mempool_alloc_noprof
>    - 44.49% mempool_alloc_noprof
>       - 44.43% kmem_cache_alloc_noprof

And I'd guess alloc_from_pcs() fails because in
__pcs_replace_empty_main() we have gfpflags_allow_blocking() false,
because mempool_alloc_noprof() tries the first attempt without
__GFP_DIRECT_RECLAIM. So that will succeed, but we end up relying on the
slowpath all the time and performance will drop.

It made sense to me not to refill sheaves when we can't reclaim, but I
didn't anticipate this interaction with mempools. We could change them
but there might be others using a similar pattern. Maybe it would be for
the best to just drop that heuristic from __pcs_replace_empty_main()
(but carefully as some deadlock avoidance depends on it, we might need
to e.g. replace it with gfpflags_allow_spinning()). I'll send a patch
tomorrow to test this theory, unless someone beats me to it (feel free to).

Until then IMHO we can dismiss the AI explanation and also the
insufficient sheaf capacity theories.

>          - 43.90% ___slab_alloc
>             + 41.18% get_from_any_partial
>               0.90% get_from_partial_node
>             + 0.87% alloc_from_new_slab
>             + 0.65% allocate_slab
> +   41.23%     0.10%  io_uring  [k] get_from_any_partial
> +   40.82%     0.48%  io_uring  [k] __raw_spin_lock_irqsave
> -   40.75%     0.20%  io_uring  [k] get_from_partial_node
>    - 40.56% get_from_partial_node
>       - 38.83% __raw_spin_lock_irqsave
>            38.65% native_queued_spin_lock_slowpath
> 
> Analysis
> ========
> 
> The ublk null target workload exposes a cross-CPU slab allocation
> pattern: bios are allocated on the io_uring submitter CPU during block
> layer submission, but freed on a different CPU — the ublk daemon thread
> that runs the completion via io_uring_cmd_complete_in_task() task work.
> And the completion CPU stays in same LLC or numa node with submission CPU.
> 
> This cross-CPU alloc/free pattern is not unique to ublk. The block
> layer's default rq_affinity=1 setting completes requests on a CPU
> sharing LLC with the submission CPU, which similarly causes bio freeing
> on a different CPU than allocation. The ublk null target simply makes
> this pattern more pronounced and measurable because all overhead is in
> the bio alloc/free path with no actual I/O.
> 
> **The following is from AI, just for reference**
> 
> The result is that the allocating CPU's per-CPU slab caches are
> continuously drained without being replenished by local frees. The bio
> layer's own per-CPU cache (bio_alloc_cache) suffers the same mismatch:
> freed bios go to the completion CPU's cache via bio_put_percpu_cache(),
> leaving the submitter CPUs' caches empty and falling through to
> mempool_alloc() -> kmem_cache_alloc() -> SLUB slow path.
> 
> In v6.19, SLUB handled this with a 3-tier allocation hierarchy:
> 
>   Tier 1: CPU slab freelist         lock-free (cmpxchg)
>   Tier 2: CPU partial slab list     lock-free (per-CPU local_lock)
>   Tier 3: Node partial list         kmem_cache_node->list_lock
> 
> The CPU partial slab list (Tier 2) was the critical buffer. It was
> populated during __slab_free() -> put_cpu_partial() and provided a
> lock-free pool of partial slabs per CPU. Even when the CPU slab was
> exhausted, the CPU partial list could supply more slabs without
> touching any shared lock.
> 
> The sheaves architecture replaces this with a 2-tier hierarchy:
> 
>   Tier 1: Per-CPU sheaf             lock-free (local_lock)
>   Tier 2: Node partial list         kmem_cache_node->list_lock
> 
> The intermediate lock-free tier is gone. When the per-CPU sheaf is
> empty and the spare sheaf is also empty, every refill must go through
> the node partial list, requiring kmem_cache_node->list_lock. With 16
> CPUs simultaneously allocating bios and all hitting empty sheaves, this
> creates a thundering herd on the node list_lock.
> 
> When the local node's partial list is also depleted (objects freed on
> remote nodes accumulate there instead), get_from_any_partial() kicks in
> to search other NUMA nodes, compounding the contention with cross-NUMA
> list_lock acquisition — explaining the 41% in get_from_any_partial ->
> native_queued_spin_lock_slowpath seen in the profile.
> 
> The mitigation in 40fd0acc45d0 ("slub: avoid list_lock contention from
> __refill_objects_any()") uses spin_trylock for cross-NUMA refill, but
> does not address the fundamental architectural issue: the missing
> lock-free intermediate caching tier that the CPU partial list provided.
> 
> Thanks,
> Ming
> 

