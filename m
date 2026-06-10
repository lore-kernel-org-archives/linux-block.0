Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E5F3563EB
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 19:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121290; cv=none; b=UA2rsnzr3QNcujoFvXuf8oeK/I0GU/Jxn1EY8y1LZTgQCnq9fqYz5QNKgTVEQvnHrxX3DI7OIY9gNCTXDqoWfu+WnYctyFhl/jqQAz3Ye8RKXn3L2qeAvm026hzOwJgWUT4gLiMlIWru3o2F2XZCM8xj6D9OyotFlwmD01+oGkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121290; c=relaxed/simple;
	bh=ZLQlbMlNWWMOL+pbXYbNwnPQOXUFgj4Juhhdfb//iZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3t/KzVZa3Y6VNQS/Fr/1oamdkq9Y0jDGWJfH+dCZNcmCiXM1ZkS8rbD6c2FCHx7An3sPO1At/buzYXlUDAMv0oI56rP5Hasdr29C47VG1NRyPSELO/+vC7bUq+KdWrtBroPDhNQy6gFsbLAzB+0I0L/AxVGLZ0DutWPxC3rlDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzelIzNr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzelIzNr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0B11F00893;
	Wed, 10 Jun 2026 19:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781121289;
	bh=w9pezl6Fn494fef7L7oyG0k9PTr16tSH7Tc9lA3CHIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nzelIzNrs+It34yCnCnl1qJES09Ue+21Fr/EHViInPtB3yOpn7yFkU2lo1Vk1x/aT
	 jbf5AmEkOvpWx4roNpo0HOZpiNBMRzZhBvIijSJFulETYD7DBqBpW++xlWozyrTTox
	 2pR7sPm1zNC1hoU/roaVmoXYP4hCl+CZXHh1+TGmtQB2Hs8S4JZdv3v7mEv80jZ2+x
	 G+F/0I79aTbW27ffRE5tpKx+F0PBNrz1cXTZx8lWoCe9zxenmrCztoOaDxUSTBjLll
	 ya4tFoRunzPBW94EX/P15NKnelgDI/4DyC2mhuDxNbmbqtkDjCxnLWx3+9HBB+N3Ju
	 Rs2ogEl/bCEVA==
Date: Wed, 10 Jun 2026 13:54:48 -0600
From: Keith Busch <kbusch@kernel.org>
To: Carlos Maiolino <cem@kernel.org>
Cc: brauner@kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] iomap: enforce DIO alignment check in iomap]
Message-ID: <ainBCDneRqNvmMT_@kbusch-mbp>
References: <aimCIEpCwUUyoORf@nidhogg.toxiclabs.cc>
 <aimErft1NoW-4Map@kbusch-mbp>
 <aimGzU_UY3jV-ece@nidhogg.toxiclabs.cc>
 <aimbdmqC10uXrZuo@kbusch-mbp>
 <aimn3kipMHdRmTTe@nidhogg.toxiclabs.cc>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aimn3kipMHdRmTTe@nidhogg.toxiclabs.cc>

On Wed, Jun 10, 2026 at 08:19:53PM +0200, Carlos Maiolino wrote:
> On Wed, Jun 10, 2026 at 11:14:30AM -0600, Keith Busch wrote:
> > 
> > It does require that someone calls the bio split-to-limits routine,
> > which I had taken for granted as a given, but I realize that some
> > drivers don't do that. What block device are you using for your test?
> 
> In the PPC machine, it's a virtual scsi vdasd device from one of the
> virtual nodes
> 
> NAME HCTL       TYPE VENDOR   MODEL  REV SERIAL                             TRAN
> sda  0:0:1:0    disk AIX      VDASD 0001 000a508a00007a0000000175dcba35ac.5
> 
> ibmvfc                262144  0
> ibmvscsi              196608  2
> 
> For my x86 machine (remind I reduce the buffer size to 512 on x86), it's
> a commodity sata samsung SSD:

Okay, these are under blk-mq so always call __bio_split_to_limits.
However, I see there's an optimization to skip the checks we're
depending on if bio_may_need_split doesn't think it needs to be split,
which is a problem for your observation. I don't think the current
expecations can allow us to take this optimization anymore when page
offsets are used.

This should fix it:

---
diff --git a/block/blk.h b/block/blk.h
index 1a2d9101bba04..3731f3c5ed140 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -404,7 +404,7 @@ static inline bool bio_may_need_split(struct bio *bio,
 	bv = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
 	if (bio->bi_iter.bi_size > bv->bv_len - bio->bi_iter.bi_bvec_done)
 		return true;
-	return bv->bv_len + bv->bv_offset > lim->max_fast_segment_size;
+	return bv.bv_offset || bv->bv_len > lim->max_fast_segment_size;
 }
 
 /**
--
