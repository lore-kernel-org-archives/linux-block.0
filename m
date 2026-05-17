Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C30302753
	for <linux-block@vger.kernel.org>; Sun, 17 May 2026 22:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779057751; cv=none; b=meAY3s7PPZBJFk9N9YFNCTXKS8fgpIgKtCj97dkot5G1x1L4viZ8wPOkphBk37M+Wk7FFii6s/a0WNjkeN3k3lhLuQW0YuqD7m6u5k+EmSTK373bnqoKShjqViLmqcQ3Kdo31A9fOZgW7P3ogSs+c1Ws4ui8fLcRPbhmR+MYjDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779057751; c=relaxed/simple;
	bh=3iOivSf6w1GmUE9wsNkmfi5xiRA8ejFL0Xb42zY2nfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGgxS0COpbpoRlTjyyMzsfEPpvysTd7qEk93n08gnqoZTdEMvayOnXL1cGXVROTXJ71gr3yST39JM2ImK+bGb4gPqvo2Te6xO68j0/P7k7awJcgW+lp+dVWlFnzw+oiY6eqQsYtkXPLcjNbiEo7Kso29pH8jU6lt0542w1VGRRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4nLtLw4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4nLtLw4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA689C2BCB0;
	Sun, 17 May 2026 22:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779057751;
	bh=3iOivSf6w1GmUE9wsNkmfi5xiRA8ejFL0Xb42zY2nfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N4nLtLw4vQcxwBuVpycw5KkOxK3AfSqdDYXBV3gvBhoYxboHzaMxd2uxB8Umy6eK6
	 whLwQeUwdfLLgkdMdxAHstiRIiFoS7Cz5QYLgRf8vlhvuv9hp5zfX95SJKADvW0DDZ
	 YTN+JTbPaQLZuVQk9buQYZDRB7lDtMP13HINGzXOg2WVFcDk28jreKA6OJgGg5/qyQ
	 s4lKeT7ghd9GkdVYzETj2lFPqzzIX9kl03auDN4EhuC7fp0XL9Nl+96l4m4fpNWXKg
	 9eCeO6C0xpX+o8YNkl33S7mG3jEMrAaYcgLYhTBOYwa6ozrYcrodLfr/2I0TUvKN76
	 0U89uJNgQ6+hQ==
Date: Sun, 17 May 2026 16:42:29 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chao S <coshi036@gmail.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
	sagi@grimberg.me, axboe@kernel.dk, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH RFC 1/2] nvme: downgrade WARN in nvme_setup_rw to pr_debug
Message-ID: <agpEVUYhyqBxBypz@kbusch-mbp>
References: <20260427003457.1264511-1-coshi036@gmail.com>
 <afzWCpJSqvjnTgpF@kbusch-mbp>
 <CACd_6n29MeACfWpqK5jaSPOVK+q5yop+eeuO_Wk0M0E5Wr7ujw@mail.gmail.com>
 <ago7kyBnaWKU7l3E@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ago7kyBnaWKU7l3E@kbusch-mbp>

On Sun, May 17, 2026 at 04:05:07PM -0600, Keith Busch wrote:
> On Sat, May 16, 2026 at 11:53:54PM -0400, Chao S wrote:
> > On Thu, May 07, 2026 at 07:12:26PM +0100, Keith Busch wrote:
> > > [...] how that was defeated [...]
> > 
> > Hi Keith,
> > 
> > Not the freeze.  The WARN does not depend on q->limits, but on
> > ns->head->ms (read live at dispatch, set inside the freeze window) and
> > on REQ_INTEGRITY, never set for EXT_LBAS-non-PI.  capacity==0 only
> > gates submission (bio_check_eod()), not dispatch: a writeback bio that
> > passed bio_check_eod() under the old capacity sits on the task plug
> > holding no q_usage_counter ref, so it does not block the freeze;
> > blk_finish_plug() flushes it after the update committed head->ms != 0
> > (dmesg: the capacity-change line prints before the WARN).
> > 
> > So it is reachable -- the host-unaware geometry change you described,
> > unrelated to your block fix.  The deeper fencing gap is the separate
> > TP-level issue; v2 does not attempt it, it only stops a
> > device-reachable, already-safely-rejected dispatch from being a WARN
> > (a panic under panic_on_warn).
> 
> I think tHe WARN is serving it's intendeded purpose: the block layer
> shouldn't have submitted this request. You can't do generic read/write
> with extended metadatate as the DMA is going to corrupt memory with
> respect to what the block layer expects.
> 
> This driver is depending on the capacity constraint to prevent this
> scenario, so I think The "end-of-device" check needs to happen within
> the entered queue context. If there's a scenario that escapes that
> check, then I think that's what needs fixing, not the driver.

Does this fix it? I don't necessarily like having yet another check in
the hotpath, but should be exactly the check that drivers expected to be
done, so should be cache hot in the normal case.

---
diff --git a/block/blk-core.c b/block/blk-core.c
index 17450058ea6d8..4b5fb32a7d6f8 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -553,7 +553,7 @@ ALLOW_ERROR_INJECTION(should_fail_bio, ERRNO);
  * This may well happen - the kernel calls bread() without checking the size of
  * the device, e.g., when mounting a file system.
  */
-static inline int bio_check_eod(struct bio *bio)
+int bio_check_eod(struct bio *bio)
 {
 	sector_t maxsector = bdev_nr_sectors(bio->bi_bdev);
 	unsigned int nr_sectors = bio_sectors(bio);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4c5c16cce4f8f..b75117ec5c988 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3186,6 +3186,11 @@ void blk_mq_submit_bio(struct bio *bio)
 		goto queue_exit;
 	}
 
+	if (unlikely(bio_check_eod(bio))) {
+		bio_io_error(bio);
+		goto queue_exit;
+	}
+
 	if ((bio->bi_opf & REQ_POLLED) && !blk_mq_can_poll(q)) {
 		bio->bi_status = BLK_STS_NOTSUPP;
 		bio_endio(bio);
diff --git a/block/blk.h b/block/blk.h
index b998a7761faf3..84515bb75485d 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -54,6 +54,7 @@ bool blk_queue_start_drain(struct request_queue *q);
 bool __blk_freeze_queue_start(struct request_queue *q,
 			      struct task_struct *owner);
 int __bio_queue_enter(struct request_queue *q, struct bio *bio);
+int bio_check_eod(struct bio *bio);
 void submit_bio_noacct_nocheck(struct bio *bio, bool split);
 int bio_submit_or_kill(struct bio *bio, unsigned int flags);
 
-- 
