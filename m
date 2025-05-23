Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD281C173F;
	Fri, 23 May 2025 08:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747988455; cv=none; b=ri+HWutD8+PrLjVBOCcNQ6Tt3xlUqj3MiXHMMNPBYKY+aem5BG6uvvpSTxuiJ4o54s3EtvC4BHI+F/a06oohgn3JIEWm56H60MEW1/ygIl0sb2M0iY0R+Skx6Zi0yPqbsJoZpSukaSlnJZKCnw5ruH4PKv9+rDXbC4mmlV7Pwfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747988455; c=relaxed/simple;
	bh=cMxlmCaeykMGtYdfvTRwKptzEyk0a2TNaWtbeOBa380=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYdwSDM4VSaeeuYm6gJQyZgI0Pp2HXXxFOcIKeWDkqxzLv5WDi0R3jVoMVh6L2aU7L+e0GRtslX2ufFha7LK60KRJK6PaspE0889HwKO4fdZA1oKU1HwbQhfhlo6NFHmOResJ3weRXtYRQzZ5AGdG3z635cuPARqTzPUL2HGY/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7F23668B05; Fri, 23 May 2025 10:20:48 +0200 (CEST)
Date: Fri, 23 May 2025 10:20:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Yu Kuai <yukuai1@huaweicloud.com>, Ming Lei <ming.lei@redhat.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] block: Fix a deadlock related freezing zoned storage
 devices
Message-ID: <20250523082048.GA15587@lst.de>
References: <20250522171405.3239141-1-bvanassche@acm.org> <b1ea4120-e16a-47c8-b10c-ff6c9d5feb69@kernel.dk> <3cd139d0-5fe0-4ce1-b7a7-36da4fad6eff@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cd139d0-5fe0-4ce1-b7a7-36da4fad6eff@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, May 23, 2025 at 10:10:30AM +0200, Damien Le Moal wrote:
> > This is pretty ugly, and I honestly absolutely hate how there's quite a
> > bit of zoned_whatever sprinkling throughout the core code. What's the
> > reason for not unplugging here, unaligned writes? Because you should
> > presumable have the exact same issues on non-zoned devices if they have
> > IO stuck in a plug (and doesn't get unplugged) while someone is waiting
> > on a freeze.
> > 
> > A somewhat similar case was solved for IOPOLL and queue entering. That
> > would be another thing to look at. Maybe a live enter could work if the
> > plug itself pins it?
> 
> What about this patch, completely untested...

This still looks extremely backwards as it messed up common core
code for something that it shouldn't.  I'd still love to see an
actual reproducer ahead of me, but I think the problem is that
blk_zone_wplug_bio_work calls into the still fairly high-level
submit_bio_noacct_nocheck for bios that already went through
the submit_bio machinery.

Something like this completely untested patch:

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 8f15d1aa6eb8..6841af8a989c 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1306,16 +1306,18 @@ static void blk_zone_wplug_bio_work(struct work_struct *work)
 	spin_unlock_irqrestore(&zwplug->lock, flags);
 
 	bdev = bio->bi_bdev;
-	submit_bio_noacct_nocheck(bio);
-
 	/*
 	 * blk-mq devices will reuse the extra reference on the request queue
 	 * usage counter we took when the BIO was plugged, but the submission
 	 * path for BIO-based devices will not do that. So drop this extra
 	 * reference here.
 	 */
-	if (bdev_test_flag(bdev, BD_HAS_SUBMIT_BIO))
+	if (bdev_test_flag(bdev, BD_HAS_SUBMIT_BIO)) {
+		bdev->bd_disk->fops->submit_bio(bio);
 		blk_queue_exit(bdev->bd_disk->queue);
+	} else {
+		blk_mq_submit_bio(bio);
+	}
 
 put_zwplug:
 	/* Drop the reference we took in disk_zone_wplug_schedule_bio_work(). */
