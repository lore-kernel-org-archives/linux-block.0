Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F05DDDAD;
	Fri, 28 Mar 2025 01:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743126298; cv=none; b=pzJES60nmFbxy8WNUzSRaXI335BWmv8pR9DC/9tlaABGylvgsK51CVVyvJBuxxTIbgPFTI9ltSvqnHG9iQRJ0MEuvTN5Iz+pCxQy0F51K6fNcTu6yVChPyYldXkny3KP5uf9RRipDipY6HVYIOYObj6AEfc8PS692EFtosKGzi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743126298; c=relaxed/simple;
	bh=nmX44Vf41ol4npyO99GzzC0pNas8m8Ih6yuWRheOadE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSEm4ovB6nqoQTBPDMpPqFS/yDxsAhR/3MjxQwy9uZKPjRQ98Tq9xGcrsW4f3018qg6xYVEq7gcwzPjoQ5179B6v8Xc2TbPUaR4TQaHifeSeUcq9KjCWuIEwQG7bvOdAU/4vLCrXDFq7oOC9zccm0FoVjQRrkbyoQbQjKF2/h+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aak77eVx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aak77eVx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD72C4CEDD;
	Fri, 28 Mar 2025 01:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743126296;
	bh=nmX44Vf41ol4npyO99GzzC0pNas8m8Ih6yuWRheOadE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aak77eVxgOs5jMI+fjhFIE+Ao8wo47UiPu5Gj+hZto6CkK81IzKyILDwcqP9AirtZ
	 9UysemMxSpd0C19m3nQEnirDtkxmNOYeN0r89WwrGnctr863l379xBLJJpCuYugSDW
	 Un+zBxdUIzi8RFIWw4QuyDRMpd+bVGICq9n5hr2gItcy3f6C2QwkubP5t08yQDDFDV
	 xAJIhc3Jqfi7bT7FKQ6FkUPeV5KHyNuu/5YMevspDCl8I9lzRRRVBLA9N3X1DY2+Ft
	 I4hG40QMjJsr2ceJV2sGODVTN8ldHrgaNdTrbxfqPyQAqPQqA004KVKAcVziEcwmPt
	 jqipjAMDnvEuw==
Date: Thu, 27 Mar 2025 18:44:54 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Oliver Sang <oliver.sang@intel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
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
Message-ID: <Z-X_FiXDTSvRSksp@bombadil.infradead.org>
References: <Z9n_Iu6W40ZNnKwT@bombadil.infradead.org>
 <Z9oy3i3n_HKFu1M1@casper.infradead.org>
 <Z9r27eUk993BNWTX@bombadil.infradead.org>
 <Z9sYGccL4TocoITf@bombadil.infradead.org>
 <Z9sZ5_lJzTwGShQT@casper.infradead.org>
 <Z9wF57eEBR-42K9a@bombadil.infradead.org>
 <20250322231440.GA1894930@cmpxchg.org>
 <Z99dk_ZMNRFgaaH8@bombadil.infradead.org>
 <Z9-zL3pRpCHm5a0w@bombadil.infradead.org>
 <Z+JSwb8BT0tZrSrx@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+JSwb8BT0tZrSrx@xsang-OptiPlex-9020>

On Tue, Mar 25, 2025 at 02:52:49PM +0800, Oliver Sang wrote:
> hi, Luis,
> 
> On Sun, Mar 23, 2025 at 12:07:27AM -0700, Luis Chamberlain wrote:
> > On Sat, Mar 22, 2025 at 06:02:13PM -0700, Luis Chamberlain wrote:
> > > On Sat, Mar 22, 2025 at 07:14:40PM -0400, Johannes Weiner wrote:
> > > > Hey Luis,
> > > > 
> > > > This looks like the same issue the bot reported here:
> > > > 
> > > > https://lore.kernel.org/all/20250321135524.GA1888695@cmpxchg.org/
> > > > 
> > > > There is a fix for it queued in next-20250318 and later. Could you
> > > > please double check with your reproducer against a more recent next?
> > > 
> > > Confirmed, at least it's been 30 minutes and no crashes now where as
> > > before it would crash in 1 minute. I'll let it soak for 2.5 hours in
> > > the hopes I can trigger the warning originally reported by this thread.
> > > 
> > > Even though from code inspection I see how the kernel warning would
> > > trigger I just want to force trigger it on a test, and I can't yet.
> > 
> > Survied 5 hours now. This certainly fixed that crash.
> > 
> > As for the kernel warning, I can't yet reproduce that, so trying to
> > run generic/750 forever and looping
> > ./testcases/kernel/syscalls/close_range/close_range01
> > and yet nothing.
> > 
> > Oliver can you reproduce the kernel warning on next-20250321 ?
> 
> the issue still exists on
> 9388ec571cb1ad (tag: next-20250321, linux-next/master) Add linux-next specific files for 20250321
> 
> but randomly (reproduced 7 times in 12 runs, then ltp.close_range01 also failed.
> on another 5 times, the issue cannot be reproduced then ltp.close_range01 pass)

OK I narrowed down a reproducer to requiring the patch below 


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


And  then just running:

dd if=/dev/zero of=/dev/vde bs=1024M count=1024

For some reason a kernel with the following didn't trigger it so the
above patch is needed


CONFIG_PROVE_LOCKING=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_ACPI_SLEEP=y

It may have to do with my preemtpion settings:

CONFIG_PREEMPT_BUILD=y
CONFIG_ARCH_HAS_PREEMPT_LAZY=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
# CONFIG_PREEMPT_LAZY is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y
CONFIG_PREEMPT_DYNAMIC=y
CONFIG_PREEMPT_RCU=y

And so now to see how we should fix it.

  LUis


