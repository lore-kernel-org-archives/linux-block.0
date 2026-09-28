Received: from mail-244121.protonmail.ch (mail-244121.protonmail.ch [109.224.244.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15EE45FFB8;
	Mon, 28 Sep 2026 07:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581623; cv=none; b=THTNExwNtjz2yyPBsf7tGT4xQvvov+fBBXj4SVqtd+JtOJKlzu/l0QMO2/ksBvCruLzHm0RFvwk4r6s8gRhXvqaCZHt1rpSAWJuvvvdK/6JkgpIpvHbvnXLi5cHHjmooxm+AfSjrOwwCjaD2jo5biHpCE/JjKgRAUZPbYDRxOa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581623; c=relaxed/simple;
	bh=3uL0OH7uoI48C0wUPDnpLShG9KGihTHNPp5zyAXkClQ=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=J/1pbWH/ZIuUeuzqzEzszaxwUd41f0nXDtsXeyFj52SauJn9DYtkanaao76gPs/ed95Tcgnxz0EtNTwYm2F9DDWI4i1FFdmq5unseRIgbPT7rLk8s1mzypxEaHksSse/+tu/XU9X68B+UxEi3mnTUGIYcM5HKJefv9L767YGKWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=TjY2uBV5; arc=none smtp.client-ip=109.224.244.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="TjY2uBV5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1790581616; x=1790840816;
	bh=3uL0OH7uoI48C0wUPDnpLShG9KGihTHNPp5zyAXkClQ=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=TjY2uBV5xbxgxCIREXPfLqaoeI8lhtialO/upkdFKbf6yEuUk8hygeRE+K8UVg/id
	 Q6QyYMPC1kxYtm9LUADsGnjfIsIWDQqVS3MTaIKDFkyO5bYLNcYXButkfddWOAApd5
	 87f1qx+GPuOYBzXY8YWC9nSboTTI3qo7QP861eIqciZ8R0QHAqE+qXpHmDsaEvbi6q
	 oKWm6D0oGH0K8kwKwAjbEDCLdm59htzaJ9kt8RSuiTNsG3ZCjZfgr8G8OKTaMOJjnn
	 zt0xiJ8lcOP6qUFgAJE5o/1LQT5WfwFmN/6KpPt7hwpQoxmhYFNDHT7CH7l+eScl6Y
	 bIlccDHlbRzPg==
Date: Mon, 28 Sep 2026 07:46:52 +0000
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, linux-mm@vger.kernel.org
From: clkernel@pm.me
Subject: Re: [syzbot] [block?] INFO: task hung in read_cache_folio (6) (extid 9db0864859224b833108)
Message-ID: <8aba9733-29aa-4103-a2f9-7f047b792ad3@pm.me>
Feedback-ID: 224698563:user:proton
X-Pm-Message-ID: 10f936aa06acafce2e352ff16b6b59257a8dc9b8
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, 03 Jul 2026, syzbot wrote:
> syzbot found the following issue on:
> ...
> folio_wait_bit_common+0x6b8/0xa30 mm/filemap.c:1324
> folio_put_wait_locked mm/filemap.c:1493 [inline]
> do_read_cache_folio+0x23c/0x5a8 mm/filemap.c:4089
> read_cache_folio+0x68/0x88 mm/filemap.c:4139
> read_part_sector+0xcc/0x708 block/partitions/core.c:724

A second observation of the same wait site: on x86-64 servers we see=20
reader threads (a database reader in a busy server workload) parked=20
D-state in folio_wait_bit_common's io_schedule, entered through the same=20
folio_put_wait_locked -> do_read_cache_folio -> read_cache_folio path=20
this report shows. Observed on 7.0.0-30, 7.0.0-31 and 7.2.5, reproduced N=
=3D3.

Three measurements, per repro:

1. the pinned folio's lock is FREE while the waiter sleeps: a fresh read=20
of the exact pinned pages answers in 4-108 ms while the thread stays D=20
in the same wait;
2. each later lock/unlock of that folio wakes the waiter for one ~4KB=20
read: the blocked read's offsets crawl one page per unlock cycle (~one=20
page per 10 s under churn), so the syscall can sit in the same wait for=20
minutes to days;
3. the discriminator: read /proc/<tid>/syscall while the waiter sits=20
inside the wait, then dd the same page range fresh. The dd returns=20
immediately; the waiter does not move.

Root cause (established from source, then observed directly on a local=20
build; measured): folio_wake_bit() wakes the hashed folio waitqueue=20
through __wake_up_locked_key(), i.e. __wake_up_common(...,=20
nr_exclusive=3D1). The walk in kernel/sched/wait.c stops at the first=20
WQ_FLAG_EXCLUSIVE entry it wakes:

if (ret && (flags & WQ_FLAG_EXCLUSIVE) && !--nr_exclusive)
break;

folio_wait_bit_common() queued every waiter with=20
__add_wait_queue_entry_tail(), so a non-exclusive waiter could sit=20
behind an exclusive folio_lock() waiter on the same folio. When the fill=20
completed, folio_end_read()'s wake woke the exclusive waiter and=20
stopped. The shared/DROP waiter behind it was never visited:=20
WQ_FLAG_WOKEN never set, although the wake itself ran. PG_locked was=20
already clear and the folio uptodate (so a fresh read of that page=20
answers through the uptodate fast path, measurement 1), and PG_waiters=20
stayed set, so the sleeper only ran when some later lock/unlock of the=20
same folio address reached the queue (measurement 2: one page per wake,=20
crawling until traffic arrived).

Same mechanism explains this report's hang: the waiters are the DROP=20
ones (folio_put_wait_locked), which drop their folio reference before=20
sleeping and re-lookup only after a wake that arrives late or never.

Observation on a debug build, same queue after folio_wake_bit() returned=20
(a read-only walk counting matching non-exclusive entries left=20
unvisited): 363 events per 10-minute run of readers racing=20
punch/fault/truncate churn under reclaim pressure on an unmodified=20
queue; 1 per run after queueing non-exclusive waiters at the head side=20
only; 0 after the same change at softleaf_entry_wait_on_locked (the=20
other non-exclusive enqueue on this queue).

The fix (mm/filemap.c, attached): queue non-exclusive waiters with=20
__add_wait_queue() (wait.h's own default head-side insert) and keep=20
exclusive folio_lock waiters on __add_wait_queue_entry_tail(). With that=20
order every non-exclusive full-match waiter is visited before any walk=20
break can fire, which restores the "wake all shared waiters, then one=20
exclusive" contract of nr_exclusive=3D1; exclusive waiters keep their FIFO=
=20
tail and their one-at-a-time wake. Same change at both non-exclusive=20
enqueue sites (folio_wait_bit_common and softleaf_entry_wait_on_locked).

One known sibling waits on a follow-up: __folio_lock_async's entry=20
(io_uring buffered reads with ki_waitq) enqueues non-exclusive at the=20
tail. Same class, unreachable from the workloads above.

Reproducer shape: threads pread a file while others block in folio_lock=20
on the same pages (hole punch, truncate, or mmap faults) under reclaim=20
churn. On an unmodified queue the waitqueue walk above counts the=20
skipped waiters within seconds. The harness, traces or configs are yours=20
on request.

The same change cherry-picks clean onto v7.2.6 (mm/filemap.o builds=20
there). Happy to send a [PATCH] for stable@ if the fix is wanted on the=20
7.2.x queue.

---
mm/filemap.c | 16 +++++++++++++---
1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 00fd89cf6f55..383701407843 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1294,8 +1294,18 @@ static inline int folio_wait_bit_common(struct=20
folio *folio, int bit_nr,
*/
spin_lock_irq(&q->lock);
folio_set_waiters(folio);
- if (!folio_trylock_flag(folio, bit_nr, wait))
- __add_wait_queue_entry_tail(q, wait);
+ if (!folio_trylock_flag(folio, bit_nr, wait)) {
+ /*
+ * A non-exclusive (shared/DROP) waiter must queue ahead of
+ * exclusive folio_lock waiters: the nr_exclusive=3D1 wake walk
+ * stops at the first exclusive match, so a non-exclusive
+ * waiter behind one is never visited and never woken.
+ */
+ if (behavior =3D=3D EXCLUSIVE)
+ __add_wait_queue_entry_tail(q, wait);
+ else
+ __add_wait_queue(q, wait);
+ }
spin_unlock_irq(&q->lock);
/*
@@ -1429,7 +1439,7 @@ void softleaf_entry_wait_on_locked(softleaf_t=20
entry, spinlock_t *ptl)
spin_lock_irq(&q->lock);
folio_set_waiters(folio);
if (!folio_trylock_flag(folio, PG_locked, wait))
- __add_wait_queue_entry_tail(q, wait);
+ __add_wait_queue(q, wait);
spin_unlock_irq(&q->lock);
/*

