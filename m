Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16F6341ABB
	for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784907468; cv=none; b=IYFwKoVMnLCdYSff9fZky36HKVX+BAJWPb77+zSsYOxZ/5+YFX+/aEuj3wi1tovZke5qxSyhvF99+o9Ri0wiGhN67gpARvYrQKUQSSN8EYyiR1amMrCEX8+OpjaG/FMkdy0o/3IGyFA4BNeqxajaOcpnbLo3ZLJqx7yfx8O8e2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784907468; c=relaxed/simple;
	bh=XE31aGfrArLtdjMCSXTnuYMW7/AMKGu7pGhUNUg2mN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+KbUeIvjsfUOQSSmcVHZX7E6lva+BterFtB5lmGtgb/pJ85q2hAoqkLsAcJjf01TR1r3uP47Bz5Xo/mivjKYS6ieysx0p+bxpm3ppX3sZjPjwAwkMib80MyWysAs0hCE5uD++RJd/cPeVdWkKvqhZAhhUMWzi310P0f+tKXVng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNbaiDIi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNbaiDIi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336681F000E9;
	Fri, 24 Jul 2026 15:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784907466;
	bh=tApCYbmoflSbwJ8GmSfc8QLLcqki2mDSjkVeHAarplM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JNbaiDIi333V78oi5T3v1qagu/o0ogNtXK2A346gGm8rCuTtqGqS0/adXrUGG7FC6
	 P1Vx7UvITCDG1zyIPsL7yJzTMsA3gyYB+qzYcBEetJXuJm1IfnIGu2HxiVNtroWkTE
	 ZDDQJGoHSHt3upME6l/iSE25/2ba1jPHj0Rvej0uFx9DGTS7oHIUso3jLnfTpY4eFo
	 zrdRDpx6uQpdw1yX+//V/L2x50rsJ59nlBAI39izr/Z0I76oir1VuNDRKZf4C1P0/T
	 zG5ZsQVC7LH/afX+laVNSZmBHr9qMDiLNtXprOe1P5cx4CtGGKxHf/sAEWD25EcVNH
	 TWgdihgU0mi5Q==
Date: Fri, 24 Jul 2026 09:37:42 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.garry@linux.dev>
Cc: John Garry <john.g.garry@oracle.com>, Christoph Hellwig <hch@lst.de>,
	sagi@grimberg.me, axboe@fb.com, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH RFC] nvme-multipath: fix diskstats for partitions
Message-ID: <amOGxr3rxvDflHLv@kbusch-mbp>
References: <20260721114553.1657841-1-john.g.garry@oracle.com>
 <20260724050152.GA3680@lst.de>
 <987782a9-e12a-4098-b438-a54a5765c2ae@oracle.com>
 <amNegPEvRX99EvPN@kbusch-mbp>
 <f76e9466-4b66-4a32-a491-728e24d34052@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f76e9466-4b66-4a32-a491-728e24d34052@linux.dev>

On Fri, Jul 24, 2026 at 04:29:08PM +0100, John Garry wrote:
> On 7/24/26 13:45, Keith Busch wrote:
> > Can we just thread through partitions for the bio's block_device instead
> > of assuming part0? I know the hidden path devices skip partition
> > scanning, but maybe if we let it happen, then those will have the same
> > partition setup as the head gendisk. Then we can go right to the
> > disk->part_tbl for what we provide to bio_set_dev() for both submission
> > and failover, and everything should work out from there.
> 
> I guess that we would just scan through the per-path gendisk->part_tbl and
> match somehow to lookup the partition. Maybe vs start address of
> bio->bi_bdev. Or is there a simpler (and quicker) way?
> 

This is the idea, assuming we can get the partition tables of the head
and path disks to be aligned:

---
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -543,7 +543,10 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
        srcu_idx = srcu_read_lock(&head->srcu);
        ns = nvme_find_path(head);
        if (likely(ns)) {
-               bio_set_dev(bio, ns->disk->part0);
+               struct block_device *bdev;
+
+               bdev = xa_load(&ns->disk->part_tbl, bdev_partno(bio->bi_bdev));
+               bio_set_dev(bio, bdev);
                /*
                 * Use BIO_REMAPPED to skip bio_check_eod() when this bio
                 * enters submit_bio_noacct() for the per-path device. The EOD
--
