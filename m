Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914A81E5207
	for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 02:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771901566; cv=none; b=fGcP1ybCF6h/9zTNtlYQILRxXTgNj7mNXKV4uJ4Llo6bWwyVxi/RskqDGCWS4c8Y/jwpLfVgJhXqtRjsMq7A2Jwxh1SMhOffF7t5ORCqJ/QpnV4/d7IbjEWsfeosp8LrNhBrrUmJGBB5GVzBJBqvjqDLUa35st2CApJFufNNykg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771901566; c=relaxed/simple;
	bh=3VktXjNf2jnSOMozTACR5pbXiZ35Li9JPlEzyJTqka0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SW9PSQG5Rsv3FTtQg7LiaD5osqL+W4yOaljaFCXb8zKDjTQbsqQjB3usuEYN6gk1cNkP+HubEHut5+AfKbDNDpMvCP9mbVgtcHNXQm+Ngj0T2ct6eedRxbSeX4v1Tf9hCz5uvflbnMcXu/IKLugtfCBrg6kCY0W/BmO09BYaHVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DksMoPFT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DksMoPFT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771901564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KvdK4bKlV9p8CtqWIClX1h0DPFMJUXzNU1SYA1FO1bk=;
	b=DksMoPFTLFU0MDZcEIzQTMuVlJdopLxuf5S0TW4dlLogHatVHeyfS+uCEOb/gjZZWzViSn
	SpxqMkZV4rLWyMCLGNbOkWLvFVExfkcvH2ZqhdcV6pfKaFWW9BdGbA04EFAnxajc2FdhZz
	P04F4GmOFsceotb1MvbMfR8XFNL9U2c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-VLMHYQwwMwi9CxWQW8Ft8g-1; Mon,
 23 Feb 2026 21:52:41 -0500
X-MC-Unique: VLMHYQwwMwi9CxWQW8Ft8g-1
X-Mimecast-MFC-AGG-ID: VLMHYQwwMwi9CxWQW8Ft8g_1771901560
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E5E321800473;
	Tue, 24 Feb 2026 02:52:39 +0000 (UTC)
Received: from fedora (unknown [10.72.116.18])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC1241800348;
	Tue, 24 Feb 2026 02:52:34 +0000 (UTC)
Date: Tue, 24 Feb 2026 10:52:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: ming.lei@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [Regression] mm:slab/sheaves: severe performance regression in
 cross-CPU slab allocation
Message-ID: <aZ0SbIqaIkwoW2mB@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hello Vlastimil and MM guys,

The SLUB "sheaves" series merged via 815c8e35511d ("Merge branch
'slab/for-7.0/sheaves' into slab/for-next") introduces a severe
performance regression for workloads with persistent cross-CPU
alloc/free patterns. ublk null target benchmark IOPS drops
significantly compared to v6.19: from ~36M IOPS to ~13M IOPS (~64%
drop).

Bisecting within the sheaves series is blocked by a kernel panic at
17c38c88294d ("slab: remove cpu (partial) slabs usage from allocation
paths"), so the exact first bad commit could not be identified.

Reproducer
==========

Hardware: NUMA machine with >= 32 CPUs
Kernel:   v7.0-rc (with slab/for-7.0/sheaves merged)

    # build kublk selftest
    make -C tools/testing/selftests/ublk/

    # create ublk null target device with 16 queues
    tools/testing/selftests/ublk/kublk add -t null -q 16

    # run fio/t/io_uring benchmark: 16 jobs, 20 seconds, non-polled
    taskset -c 0-31 fio/t/io_uring -p0 -n 16 -r 20 /dev/ublkb0

    # cleanup
    tools/testing/selftests/ublk/kublk del -n 0

Good: v6.19 (and 41f1a08645ab, the mainline parent of the slab merge)
Bad:  815c8e35511d (Merge branch 'slab/for-7.0/sheaves' into slab/for-next)

perf profile (bad kernel)
=========================

~47% of CPU time is spent in bio allocation hitting the SLUB slow path,
with massive spinlock contention on the node partial list lock:

+   47.65%     1.21%  io_uring  [k] bio_alloc_bioset
-   44.87%     0.45%  io_uring  [k] kmem_cache_alloc_noprof
   - 44.41% kmem_cache_alloc_noprof
      - 43.89% ___slab_alloc
         + 41.16% get_from_any_partial
           0.91% get_from_partial_node
         + 0.87% alloc_from_new_slab
         + 0.65% allocate_slab
-   44.70%     0.21%  io_uring  [k] mempool_alloc_noprof
   - 44.49% mempool_alloc_noprof
      - 44.43% kmem_cache_alloc_noprof
         - 43.90% ___slab_alloc
            + 41.18% get_from_any_partial
              0.90% get_from_partial_node
            + 0.87% alloc_from_new_slab
            + 0.65% allocate_slab
+   41.23%     0.10%  io_uring  [k] get_from_any_partial
+   40.82%     0.48%  io_uring  [k] __raw_spin_lock_irqsave
-   40.75%     0.20%  io_uring  [k] get_from_partial_node
   - 40.56% get_from_partial_node
      - 38.83% __raw_spin_lock_irqsave
           38.65% native_queued_spin_lock_slowpath

Analysis
========

The ublk null target workload exposes a cross-CPU slab allocation
pattern: bios are allocated on the io_uring submitter CPU during block
layer submission, but freed on a different CPU — the ublk daemon thread
that runs the completion via io_uring_cmd_complete_in_task() task work.
And the completion CPU stays in same LLC or numa node with submission CPU.

This cross-CPU alloc/free pattern is not unique to ublk. The block
layer's default rq_affinity=1 setting completes requests on a CPU
sharing LLC with the submission CPU, which similarly causes bio freeing
on a different CPU than allocation. The ublk null target simply makes
this pattern more pronounced and measurable because all overhead is in
the bio alloc/free path with no actual I/O.

**The following is from AI, just for reference**

The result is that the allocating CPU's per-CPU slab caches are
continuously drained without being replenished by local frees. The bio
layer's own per-CPU cache (bio_alloc_cache) suffers the same mismatch:
freed bios go to the completion CPU's cache via bio_put_percpu_cache(),
leaving the submitter CPUs' caches empty and falling through to
mempool_alloc() -> kmem_cache_alloc() -> SLUB slow path.

In v6.19, SLUB handled this with a 3-tier allocation hierarchy:

  Tier 1: CPU slab freelist         lock-free (cmpxchg)
  Tier 2: CPU partial slab list     lock-free (per-CPU local_lock)
  Tier 3: Node partial list         kmem_cache_node->list_lock

The CPU partial slab list (Tier 2) was the critical buffer. It was
populated during __slab_free() -> put_cpu_partial() and provided a
lock-free pool of partial slabs per CPU. Even when the CPU slab was
exhausted, the CPU partial list could supply more slabs without
touching any shared lock.

The sheaves architecture replaces this with a 2-tier hierarchy:

  Tier 1: Per-CPU sheaf             lock-free (local_lock)
  Tier 2: Node partial list         kmem_cache_node->list_lock

The intermediate lock-free tier is gone. When the per-CPU sheaf is
empty and the spare sheaf is also empty, every refill must go through
the node partial list, requiring kmem_cache_node->list_lock. With 16
CPUs simultaneously allocating bios and all hitting empty sheaves, this
creates a thundering herd on the node list_lock.

When the local node's partial list is also depleted (objects freed on
remote nodes accumulate there instead), get_from_any_partial() kicks in
to search other NUMA nodes, compounding the contention with cross-NUMA
list_lock acquisition — explaining the 41% in get_from_any_partial ->
native_queued_spin_lock_slowpath seen in the profile.

The mitigation in 40fd0acc45d0 ("slub: avoid list_lock contention from
__refill_objects_any()") uses spin_trylock for cross-NUMA refill, but
does not address the fundamental architectural issue: the missing
lock-free intermediate caching tier that the CPU partial list provided.

Thanks,
Ming

