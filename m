Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414DD3CF58;
	Fri, 28 Mar 2025 04:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743135692; cv=none; b=awbQlfPWCN2XAE7LCllL2WYdLzXkvCWhuSYM60f7kEijAUP/VpLTW1rX2obCf0CQ9R2eu7F8N7qsLweH8aStDoUd0VTk2y6m/yFHQJqGWIk7HVg4lvjwYnCycCeajYNNOklXo6pMq6bWdrfPNuWFFslQbRqv+9/BOLPoO2KMp6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743135692; c=relaxed/simple;
	bh=EkZr+InM+IE+kVx2qsfh4jplm5ZGyo/xPOkhd09hklc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/Goo6O8rIUsHwJ439JJRbMls26RqUBo4xux0ic6OPs2MqXnF1MKHA5yERTr2zWXU0Pl9O7ZK71tLxpP7dbAqkXP5vtoKMYfsqOSR6BVQhNTpr+PbMdkJpx6eip29DgEeuKnnRPgJEsdgJgzJZncMq0MRk3nidHaEIlqIgkDAo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0GeXZzY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0GeXZzY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB44C4CEE4;
	Fri, 28 Mar 2025 04:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743135690;
	bh=EkZr+InM+IE+kVx2qsfh4jplm5ZGyo/xPOkhd09hklc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t0GeXZzYKN4pot90kVRCo8FSkgmYZFvOjZ60Zuyy6iByYStTWb7psQOlbk/wCHJg+
	 AcceYumfrBCUDVPOuU3bLcJ1z0UAeSSDfl1MxByNAzLaiJ2bQURoGk/jIM3WzG7VyL
	 HV6BpgRfWJK8hQ58Qm9sqm4R9j79X/eQfQNXmCBpMvHSpL/8/PPDb9kcvLCX7ikNWC
	 nC4/ykbJdl3mogEPpX4Hq03d6gL0QCdmtcZZCB6fAD1jR/UiBNEnmevAGCwTd09qvq
	 rceggSr4u732Mk/KggVDiMnsrTYPYNPao4ISic0fCXJrfPJyRmtFb9WJnkKyrLNKIv
	 vRgJc2/a04frg==
Date: Thu, 27 Mar 2025 21:21:28 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Jan Kara <jack@suse.cz>, Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Oliver Sang <oliver.sang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
	Christian Brauner <brauner@kernel.org>,
	Hannes Reinecke <hare@suse.de>, oe-lkp@lists.linux.dev,
	lkp@intel.com, John Garry <john.g.garry@oracle.com>,
	linux-block@vger.kernel.org, ltp@lists.linux.it,
	Pankaj Raghav <p.raghav@samsung.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	David Bueso <dave@stgolabs.net>
Subject: Re: [linux-next:master] [block/bdev]  3c20917120:
 BUG:sleeping_function_called_from_invalid_context_at_mm/util.c
Message-ID: <Z-YjyBF-M9ciJC7X@bombadil.infradead.org>
References: <Z9oy3i3n_HKFu1M1@casper.infradead.org>
 <Z9r27eUk993BNWTX@bombadil.infradead.org>
 <Z9sYGccL4TocoITf@bombadil.infradead.org>
 <Z9sZ5_lJzTwGShQT@casper.infradead.org>
 <Z9wF57eEBR-42K9a@bombadil.infradead.org>
 <20250322231440.GA1894930@cmpxchg.org>
 <Z99dk_ZMNRFgaaH8@bombadil.infradead.org>
 <Z9-zL3pRpCHm5a0w@bombadil.infradead.org>
 <Z+JSwb8BT0tZrSrx@xsang-OptiPlex-9020>
 <Z-X_FiXDTSvRSksp@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-X_FiXDTSvRSksp@bombadil.infradead.org>

On Thu, Mar 27, 2025 at 06:44:56PM -0700, Luis Chamberlain wrote:
> On Tue, Mar 25, 2025 at 02:52:49PM +0800, Oliver Sang wrote:
> > hi, Luis,
> > 
> > On Sun, Mar 23, 2025 at 12:07:27AM -0700, Luis Chamberlain wrote:
> > > On Sat, Mar 22, 2025 at 06:02:13PM -0700, Luis Chamberlain wrote:
> > > > On Sat, Mar 22, 2025 at 07:14:40PM -0400, Johannes Weiner wrote:
> > > > > Hey Luis,
> > > > > 
> > > > > This looks like the same issue the bot reported here:
> > > > > 
> > > > > https://lore.kernel.org/all/20250321135524.GA1888695@cmpxchg.org/
> > > > > 
> > > > > There is a fix for it queued in next-20250318 and later. Could you
> > > > > please double check with your reproducer against a more recent next?
> > > > 
> > > > Confirmed, at least it's been 30 minutes and no crashes now where as
> > > > before it would crash in 1 minute. I'll let it soak for 2.5 hours in
> > > > the hopes I can trigger the warning originally reported by this thread.
> > > > 
> > > > Even though from code inspection I see how the kernel warning would
> > > > trigger I just want to force trigger it on a test, and I can't yet.
> > > 
> > > Survied 5 hours now. This certainly fixed that crash.
> > > 
> > > As for the kernel warning, I can't yet reproduce that, so trying to
> > > run generic/750 forever and looping
> > > ./testcases/kernel/syscalls/close_range/close_range01
> > > and yet nothing.
> > > 
> > > Oliver can you reproduce the kernel warning on next-20250321 ?
> > 
> > the issue still exists on
> > 9388ec571cb1ad (tag: next-20250321, linux-next/master) Add linux-next specific files for 20250321
> > 
> > but randomly (reproduced 7 times in 12 runs, then ltp.close_range01 also failed.
>a> on another 5 times, the issue cannot be reproduced then ltp.close_range01 pass)
> 
> OK I narrowed down a reproducer to requiring the patch below 
> 
> 
> diff --git a/mm/util.c b/mm/util.c
> index 448117da071f..3585bdb8700a 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -735,6 +735,8 @@ int folio_mc_copy(struct folio *dst, struct folio *src)
>  	long nr = folio_nr_pages(src);
>  	long i = 0;
>  
> +	might_sleep();
> +
>  	for (;;) {
>  		if (copy_mc_highpage(folio_page(dst, i), folio_page(src, i)))
>  			return -EHWPOISON;
> 
> 
> And  then just running:
> 
> dd if=/dev/zero of=/dev/vde bs=1024M count=1024
> 
> For some reason a kernel with the following didn't trigger it so the
> above patch is needed
> 
> 
> CONFIG_PROVE_LOCKING=y
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_ACPI_SLEEP=y
> 
> It may have to do with my preemtpion settings:
> 
> CONFIG_PREEMPT_BUILD=y
> CONFIG_ARCH_HAS_PREEMPT_LAZY=y
> # CONFIG_PREEMPT_NONE is not set
> CONFIG_PREEMPT_VOLUNTARY=y
> # CONFIG_PREEMPT is not set
> # CONFIG_PREEMPT_LAZY is not set
> CONFIG_PREEMPT_COUNT=y
> CONFIG_PREEMPTION=y
> CONFIG_PREEMPT_DYNAMIC=y
> CONFIG_PREEMPT_RCU=y
> 
> And so now to see how we should fix it.

Would the extra ref check added via commit 060913999d7a9e50 ("mm:
migrate: support poisoned recover from migrate folio") make the removal
of the spin lock safe now given all the buffers are locked from the
folio? This survives some basic sanity checks on my end with
generic/750 against ext4 and also filling a drive at the same time with
fio. I have a feeling is we are not sure, do we have a reproducer for
the issue reported through ebdf4de5642fb6 ("mm: migrate: fix reference
check race between __find_get_block() and migration")? I suspect the
answer is now. The only other thing I can think of at this tie is to add
the lru_cache_disabled() || cpu_is_isolated(smp_processor_id())) checks
on __find_get_block_slow() as we do in bh_lru_install() but I am not
sure if that suffices for the old races.

Thoughts?

diff --git a/mm/migrate.c b/mm/migrate.c
index 97f0edf0c032..6a5d125ecde9 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -859,12 +859,12 @@ static int __buffer_migrate_folio(struct address_space *mapping,
 			}
 			bh = bh->b_this_page;
 		} while (bh != head);
+		spin_unlock(&mapping->i_private_lock);
 		if (busy) {
 			if (invalidated) {
 				rc = -EAGAIN;
 				goto unlock_buffers;
 			}
-			spin_unlock(&mapping->i_private_lock);
 			invalidate_bh_lrus();
 			invalidated = true;
 			goto recheck_buffers;
@@ -882,8 +882,6 @@ static int __buffer_migrate_folio(struct address_space *mapping,
 	} while (bh != head);
 
 unlock_buffers:
-	if (check_refs)
-		spin_unlock(&mapping->i_private_lock);
 	bh = head;
 	do {
 		unlock_buffer(bh);
diff --git a/mm/util.c b/mm/util.c
index 448117da071f..3585bdb8700a 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -735,6 +735,8 @@ int folio_mc_copy(struct folio *dst, struct folio *src)
 	long nr = folio_nr_pages(src);
 	long i = 0;
 
+	might_sleep();
+
 	for (;;) {
 		if (copy_mc_highpage(folio_page(dst, i), folio_page(src, i)))
 			return -EHWPOISON;
