Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E6E2DA768;
	Wed, 15 Apr 2026 15:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776268334; cv=none; b=Wik39r9lxHX2sv5dfhnTNqtKeiHybJ2AxaM9BUmcNTZZZhW1DMArNEmCLE3nMSgJ7MqqoNHjrLi2HKgNLkC30+vEVaqs+rftQpgF23YLueEKDAC06zNxZdEeZfQ8eA6XlGLMUCATcD905v5oMd4PLui9S0F906PBLCAF0u1goMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776268334; c=relaxed/simple;
	bh=bWtCdlLbngQbKoiwMS3GSNvEBDPDGiO0UkdCZVXcoeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnoCkgG4yO+5p+vpJL7C5Q+LeG5aUYbHNkkY3aeu/sH+Bnsxu62zpL8jEjaSd+0j92efkP0Jbs0bOauBZ8lsRS0x0lHDAH55nydtduBfUzP6cYteJrzjdXGuZCuWZxTIbm3TNN46BDUzLLnXp6gqTD0V7ie8BQIumT0L/A6e11A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/8ceDg8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/8ceDg8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD459C19424;
	Wed, 15 Apr 2026 15:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776268334;
	bh=bWtCdlLbngQbKoiwMS3GSNvEBDPDGiO0UkdCZVXcoeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n/8ceDg8sOwzuBGLDgXehGD5knABzdp2iX5meMOGSelwwxVnrwoqDhSnCaOjONSoE
	 CxL3PcKQaoe5d1CFQ10sFKflAcuQWuT43YofD1eQJWQ2SM63O9WgWDidE2wsTLA5Fp
	 RQ1cz0gz+zjIDaruBDPnyGV20KDpfQ3MpD7sxLsXiFDZcZLmfEyZUeLDmPrh+LP6a5
	 f1Cd6exJ3NImZ6hiBaveNraLJETehWRPeR+jjejsDmXExjuX+LY9kMmHGDdE6L9JfG
	 KceTLWvzLmC2pjhVdjd8HclrLo745oiyljUvD31z9uGd55Mteh+uCwClP4021kcKeY
	 imsfy7pZgLLGA==
Date: Wed, 15 Apr 2026 09:52:12 -0600
From: Keith Busch <kbusch@kernel.org>
To: =?iso-8859-1?Q?Tom=E1s?= Trnka <trnka@scm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev, linux-block@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] Spurious raid1 device failure triggered
 by qemu direct IO on 6.18+
Message-ID: <ad-0LIubzaT8M2_O@kbusch-mbp>
References: <2982107.4sosBPzcNG@electra>
 <ad-sprBWPA20iola@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad-sprBWPA20iola@kbusch-mbp>

On Wed, Apr 15, 2026 at 09:20:06AM -0600, Keith Busch wrote:
> On Wed, Apr 15, 2026 at 02:18:59PM +0200, Tomás Trnka wrote:
> > Since 6.18, booting a VM that is backed by a raid1 LVM LV makes that LV 
> > immediately eject one of the devices. This is apparently because of a direct 
> > IO read by QEMU failing. I have bisected the issue to the following commit and 
> > confirmed that reverting that commit (plus dependencies 
> > 9eab1d4e0d15b633adc170c458c51e8be3b1c553 and 
> > b475272f03ca5d0c437c8f899ff229b21010ec83) on top of 6.19.11 fixes the issue.
> > 
> > commit 5ff3f74e145adc79b49668adb8de276446acf6be
> > Author: Keith Busch <kbusch@kernel.org>
> > Date:   Wed Aug 27 07:12:54 2025 -0700
> > 
> >     block: simplify direct io validity check
> >     
> >     The block layer checks all the segments for validity later, so no need
> >     for an early check. Just reduce it to a simple position and total length
> >     check, and defer the more invasive segment checks to the block layer.
> >     
> >     Signed-off-by: Keith Busch <kbusch@kernel.org>
> >     Reviewed-by: Hannes Reinecke <hare@suse.de>
> >     Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> >     Reviewed-by: Christoph Hellwig <hch@lst.de>
> >     Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > 
> > The issue looks like this:
> > 
> > md/raid1:mdX: dm-17: rescheduling sector 0
> > md/raid1:mdX: redirecting sector 0 to other mirror: dm-17
> > (snipped 9 repeats of the preceding two lines)
> > md/raid1:mdX: dm-17: Raid device exceeded read_error threshold [cur 21:max 20]
> > md/raid1:mdX: dm-17: Failing raid device
> > md/raid1:mdX: Disk failure on dm-17, disabling device.
> > md/raid1:mdX: Operation continuing on 1 devices.
> > 
> > There's absolutely nothing wrong with the HW, the issue persists even when I 
> > move the mirrors to a different pair of PVs (SAS HDD vs SATA SSD).
> 
> Thanks for the notice and the logs. Sounds likek something is getting
> sent to the block layer that can't form a viable IO. The commit you
> identified should have still error'ed though, just much earlier in the
> call stack.
> 
> Anyway, I'll take a look if there's something I missed handling with the
> stacking setup you're describing.

I think the block layer is working as designed. The problem you're
seeing is likely related to how QEMU probes direct-io limits instead of
doing proper stat/statx type checks. During its probing, it tries
various sizes and offsets, and some of these is invalid. The kernel code
previously still returned the EINVAL error, but it was before entering
the dm raid layer, and qemu reacted by changing its assumptions.

The new kernel code eventually returns the same error, but on the other
side of dm raid stack, and unfortunately dm raid treats this as a device
failure rather than a user error as intended.

Suggest the stacking layers shouldn't consider BLK_STS_INVAL to be a
device error or retryable.

---
diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
index c33099925f230..cf1c25f290f36 100644
--- a/drivers/md/raid1-10.c
+++ b/drivers/md/raid1-10.c
@@ -293,8 +293,16 @@ static inline bool raid1_should_read_first(struct mddev *mddev,
  * bio with REQ_RAHEAD or REQ_NOWAIT can fail at anytime, before such IO is
  * submitted to the underlying disks, hence don't record badblocks or retry
  * in this case.
+ *
+ * BLK_STS_INVAL means the request itself is malformed (e.g. unaligned
+ * buffers that violate DMA constraints).  Retrying on another mirror will
+ * fail the same way, and counting it against the device is wrong.
  */
 static inline bool raid1_should_handle_error(struct bio *bio)
 {
-	return !(bio->bi_opf & (REQ_RAHEAD | REQ_NOWAIT));
+	if (bio->bi_opf & (REQ_RAHEAD | REQ_NOWAIT))
+		return false;
+	if (bio->bi_status == BLK_STS_INVAL)
+		return false;
+	return true;
 }
--
