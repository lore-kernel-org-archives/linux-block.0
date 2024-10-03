Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A828E19C57F
	for <linux-block@vger.kernel.org>; Thu,  3 Oct 2024 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727962992; cv=none; b=BU+seR1QYUydRhVsAKh5CpzMIZ5+/Skl9+L0fotRK4jJNMlMAim5qabQH8CMh0rIC3hpiRw+9u6lZn6NuV8xZwAQntlRxgd1cDQd4NwZrc3G9RZNHLJ8EtIG8zmCPFNCfjGpyrH1Jv8UNpTcwXJ17VaIit/zEPUmglf+9A1t1gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727962992; c=relaxed/simple;
	bh=kYffSCMAA9WnqhpffigpImNRCmiFPClqVwPzGkPtD1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKza2T6uWrJFvvBkYS9gB6nxPBAR5KxFwHbTJpU5CxaqSAZrZ+EvgsdhUjPXidFdn5oXE2L+8BL89LQdVc71u0+jGi7VkPen4JL+5pqL2eCr2Sptgv2jH4ERru00rcVqs7nipwdU1Q0T2Ry4s9xfJBsD26TbjWSqYHl6b0uqjMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FQT6oJ2f; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FQT6oJ2f"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1KrY8UKqcVoR9megoowx8n9KYVTSnuQpRQYktfEuiUI=; b=FQT6oJ2f0HSPbqfE28OcJDCIF7
	7niKnFxWqYnOVAhtjLAZ7tbk8JDtvkYmP+MhDjBBN/okcHE9dAs7FanPLxNvARySnku5CZvsBL4/i
	rS/1PKmWQ1aBE9pEuJvCG0qThSXfXnCPBZp/4YaKUg+9bC89+J+ZIMeqQ0HiE6T1ww8y9+cJL9Nsj
	JMlk1p1w1BQtgaMtaUemhiRdZ0zXUUajuHk387KDx797jxgtgRKu5fUbkhpi7IPCgT7yX6A/AGzfD
	ZhxSRqBBCA+eSG08IkK7KULNGqQP2nH4xYTnvoN1zQJxCAamiqh2hweD9AJYYBgc+XJKXweP3k1+K
	P3/I5dCQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swM6o-00000009FRE-0NLv;
	Thu, 03 Oct 2024 13:43:10 +0000
Date: Thu, 3 Oct 2024 06:43:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: block: del_gendisk() vs blk_queue_enter() race condition
Message-ID: <Zv6fbloZRg2xQ1Jf@infradead.org>
References: <20241003085610.GK11458@google.com>
 <Zv6d1Iy18wKvliLm@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv6d1Iy18wKvliLm@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 03, 2024 at 06:36:20AM -0700, Christoph Hellwig wrote:
> On Thu, Oct 03, 2024 at 05:56:10PM +0900, Sergey Senozhatsky wrote:
> > blk_queue_enter() sleeps forever, under ->open_mutex, there is no
> > way for it to be woken up and to detect blk_queue_dying().  del_gendisk()
> > sleeps forever because it attempts to grab ->open_mutex before it calls
> > __blk_mark_disk_dead(), which would mark the queue QUEUE_FLAG_DYING and
> > wake up ->mq_freeze_wq (which is blk_queue_enter() in this case).
> > 
> > I wonder how to fix it.  My current "patch" is to set QUEUE_FLAG_DYING
> > and "kick" ->mq_freeze_wq early on in del_gendisk(), before it attempts
> > to grab ->open_mutex for the first time.
> 
> We split blk_queue_enter further to distinguish between file system
> requests and passthrough ones.
> 
> The file system request should be using bio_queue_enter, which only
> checks GD_DEAD, instead of QUEUE_FLAG_DYING.  Passthrough requests like
> the cdrom door lock are using blk_queue_enter that checks QUEUE_FLAG_DYING
> which only gets set in blk_mq_destroy_queue.
> 
> So AFAICS your trace should not happen with the current kernel, but
> probably could happen with older stable version unless I'm missing
> something.  What kernel version did you see this on?

.. actually, we still clear QUEUE_FLAG_DYING early.  Something like
the pathc below (plus proper comments) should sort it out:

diff --git a/block/genhd.c b/block/genhd.c
index 1c05dd4c6980b5..9a1e18fbb136cf 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -589,9 +589,6 @@ static void __blk_mark_disk_dead(struct gendisk *disk)
 	if (test_and_set_bit(GD_DEAD, &disk->state))
 		return;
 
-	if (test_bit(GD_OWNS_QUEUE, &disk->state))
-		blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue);
-
 	/*
 	 * Stop buffered writers from dirtying pages that can't be written out.
 	 */
@@ -673,6 +670,9 @@ void del_gendisk(struct gendisk *disk)
 		drop_partition(part);
 	mutex_unlock(&disk->open_mutex);
 
+	if (test_bit(GD_OWNS_QUEUE, &disk->state))
+		blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue);
+
 	if (!(disk->flags & GENHD_FL_HIDDEN)) {
 		sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
 
