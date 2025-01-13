Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A4C20458F
	for <linux-block@vger.kernel.org>; Mon, 13 Jan 2025 10:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736764871; cv=none; b=jQaJXmZYBCNQruY32KMsxjarKkMAxcerNhlVFhNKtJBRpJzk6EtqztroRp3UMNEM34jA5J8+5LyA0ijAll3Skuvsw6q688NkJa4AQGmoujrJcFFj5JGmO/rXIsSBMSDgpZgjez2uTc8G3wACVa72/nBlyoR1ZxJ1noDt0Btdpgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736764871; c=relaxed/simple;
	bh=QQPjhc7nhyF00rHRQnzj2iydaSYnD8qaOi6NRB33bYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQlPLxfwl3Xi4sqHEXZNfzRKPQd+QHlLU4i77i1Nrl+JIHge9JTt7LPy6ADjnPx255cKZaapA62Vgwq+RBb2CS8Y0mekW2o9+zSiMmQLJO/wU8pf14EfCUyL1Gi17LvqFR0A3dWB9Nj8KERN3+2sJRnKikenGFRcGEa0oOol4NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RyP+hRLF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RyP+hRLF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736764866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vgzvuGjA2m/qZm9Om2/xTpYVs47W+NylI90yxpWD/Ys=;
	b=RyP+hRLFozC1zNV81KA2H61IB5++sYiyKIbe3mTwAX10A1wV4GkG9mtsvHjETqzRjtPXKr
	rlsG7P/KCRNsnCcgUe8BKi8qrxNQrVmox0Qq1U0/NUpakLiLHpYGewo4WEqp9hodMUrFgp
	EgAGhMzFzcaw+RwmHPFmrKsq9YfCxY8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-rhU6A8zuPJONOiQuWdtdew-1; Mon,
 13 Jan 2025 05:41:02 -0500
X-MC-Unique: rhU6A8zuPJONOiQuWdtdew-1
X-Mimecast-MFC-AGG-ID: rhU6A8zuPJONOiQuWdtdew
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 60A6B19560B8;
	Mon, 13 Jan 2025 10:41:01 +0000 (UTC)
Received: from fedora (unknown [10.72.116.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBC961955BE3;
	Mon, 13 Jan 2025 10:40:57 +0000 (UTC)
Date: Mon, 13 Jan 2025 18:40:52 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org
Subject: Re: Blockdev 6.13-rc lockdep splat regressions
Message-ID: <Z4TttHaYvODeiZNN@fedora>
References: <65a8ef7321bf905ab27c383395016fe299f6dfd9.camel@linux.intel.com>
 <Z4EO6YMM__e6nLNr@fedora>
 <7017f6bf8df5bbd8824f9f69e627c3f33b9aa7cd.camel@linux.intel.com>
 <Z4HgDJjMRv4s5phx@fedora>
 <ead7c5ce5138912c1f3179d62370b84a64014a38.camel@linux.intel.com>
 <Z4TcvNCBXcLJV3vs@fedora>
 <197b07435a736825ab40dab8d91db031c7fce37e.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <197b07435a736825ab40dab8d91db031c7fce37e.camel@linux.intel.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Jan 13, 2025 at 10:58:07AM +0100, Thomas Hellström wrote:
> Hi,
> 
> On Mon, 2025-01-13 at 17:28 +0800, Ming Lei wrote:
> > On Sun, Jan 12, 2025 at 12:33:13PM +0100, Thomas Hellström wrote:
> > > On Sat, 2025-01-11 at 11:05 +0800, Ming Lei wrote:
> > > > On Fri, Jan 10, 2025 at 03:36:44PM +0100, Thomas Hellström wrote:
> > > > > On Fri, 2025-01-10 at 20:13 +0800, Ming Lei wrote:
> > > > > > On Fri, Jan 10, 2025 at 11:12:58AM +0100, Thomas Hellström
> > > > > > wrote:
> > > > > > > Ming, Others
> > > > > > > 
> > > 
> > > #2:
> > > [    5.595482]
> > > ======================================================
> > > [    5.596353] WARNING: possible circular locking dependency
> > > detected
> > > [    5.597231] 6.13.0-rc6+ #122 Tainted: G     U            
> > > [    5.598182] ----------------------------------------------------
> > > --
> > > [    5.599149] (udev-worker)/867 is trying to acquire lock:
> > > [    5.600075] ffff9211c02f7948 (&root->kernfs_rwsem){++++}-{4:4},
> > > at:
> > > kernfs_remove+0x31/0x50
> > > [    5.600987] 
> > >                but task is already holding lock:
> > > [    5.603025] ffff9211e86f41a0 (&q->q_usage_counter(io)#3){++++}-
> > > {0:0}, at: blk_mq_freeze_queue+0x12/0x20
> > > [    5.603033] 
> > >                which lock already depends on the new lock.
> > > 
> > > [    5.603034] 
> > >                the existing dependency chain (in reverse order) is:
> > > [    5.603035] 
> > >                -> #2 (&q->q_usage_counter(io)#3){++++}-{0:0}:
> > > [    5.603038]        blk_alloc_queue+0x319/0x350
> > > [    5.603041]        blk_mq_alloc_queue+0x63/0xd0
> > 
> > The above one is solved in for-6.14/block of block tree:
> > 
> > 	block: track queue dying state automatically for modeling
> > queue freeze lockdep
> > 
> > q->q_usage_counter(io) is killed because disk isn't up yet.
> > 
> > If you apply the noio patch against for-6.1/block, the two splats
> > should
> > have disappeared. If not, please post lockdep log.
> 
> That above dependency path is the lockdep priming I suggested, which
> establishes the reclaim -> q->q_usage_counter(io) locking order. 
> A splat without that priming would look slightly different and won't
> occur until memory is actually exhausted. But it *will* occur.
> 
> That's why I suggested using the priming to catch all fs_reclaim-
> >q_usage_counter(io) violations early, perhaps already at system boot,
> and anybody accidently adding a GFP_KERNEL memory allocation under the
> q_usage_counter(io) lock would get a notification as soon as that
> allocation happens.
> 
> The actual deadlock sequence is because kernfs_rwsem is taken under
> q_usage_counter(io): (excerpt from the report [a]). 
> If the priming is removed, the splat doesn't happen until reclaim, and
> will instead look like [b].

Got it, [b] is new warning between 'echo /sys/block/$DEV/queue/scheduler'
and fs reclaim from sysfs inode allocation.

Three global or sub-system locks are involved:

- fs_reclaim

- root->kernfs_rwsem

- q->queue_usage_counter(io)

The problem exists since blk-mq scheduler is introduced, looks one hard
problem because it becomes difficult to avoid their dependency now.

I will think about and see if we can figure out one solution.


Thanks, 
Ming

