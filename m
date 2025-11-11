Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E62359F8B
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869297; cv=none; b=e2RoE4Heqdc7BBUML2NoyXQ68M7wmGkDcWXLJSV8zrHVC1cIPBbLC+/HW1gLwv9xH7n0QeP5bhjqkngKkMCys/IZ+S9KHCY0jOQTR5SFGni0/cYKIF6fhi7mxnxuRnp5N/wxfG8ktmn4NvT2XBxr95TYMQwGWV7JtvB4s5Mm0tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869297; c=relaxed/simple;
	bh=nOjcrcHGqxzAQp5BO2Cm52zJa3SqUoYXtMLRHzvTVtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9K33/WQUQ7N/Q6jUBcLcleL4yvH7WMP6QSrxNWzXynlDZIFTbrJnGZtGArnL13E6839o3VT6/5uSqbMzIxCjDIUqA9t7IDj27IRaeBATdTmTUlqFMWwARgKTwFIgV+4swkiQfv0pcg8QrApFl6thyiJ6GaUo8bVcKsAeHtADr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cR/enPMS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cR/enPMS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA66AC2BC86;
	Tue, 11 Nov 2025 13:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762869296;
	bh=nOjcrcHGqxzAQp5BO2Cm52zJa3SqUoYXtMLRHzvTVtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cR/enPMSVXBmha2JWczFTQ+NgUpPrn5hrDvzKs7WeEs4DEGMZyaZ6CpbfniLOhsqZ
	 dS9PfcGrM+TVsFwml4P3Vo1PU6uja8lBezcuM3o6VcS/DlCSld6ayj0S4bbq3jIKlQ
	 bA/NMPpMA929pCe4RvFEUVGGbnEf+slJEO0OzB2IajM5VEkMpdVQctQFYOuryum0a8
	 i8Dw3OfRFCLf0/H527TT7CZFQ8owejxH7gpQK1D5WlX1ouHI8sagItArFPdOGcVlGo
	 6oIqca/3QQG6bIhDTzOoXhhu1OpDevwu6+ra/GOV7XDyeX6qgv1sZOyxZNhMVG7924
	 KMjwh6bhEnjBg==
Date: Tue, 11 Nov 2025 08:54:53 -0500
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Yu Kuai <yukuai@fnnas.com>, Matthew Wilcox <willy@infradead.org>,
	Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCHv5 1/2] block: accumulate memory segment gaps per bio
Message-ID: <aRNALUnnxzIuyHng@kbusch-mbp>
References: <20251014150456.2219261-1-kbusch@meta.com>
 <20251014150456.2219261-2-kbusch@meta.com>
 <aRK67ahJn15u5OGC@casper.infradead.org>
 <aRLAqyRBY6k4pT2M@kbusch-mbp>
 <20251111071439.GA4240@lst.de>
 <024631dc-3c65-49a8-a97a-f9110fd00e9a@fnnas.com>
 <20251111093903.GB14438@lst.de>
 <c82cd0f1-f56e-445b-8d78-f55a0c3b2b4c@fnnas.com>
 <aRM5UoApKZ9_V7PV@kbusch-mbp>
 <20251111134001.GA708@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111134001.GA708@lst.de>

On Tue, Nov 11, 2025 at 02:40:01PM +0100, Christoph Hellwig wrote:
> On Tue, Nov 11, 2025 at 08:25:38AM -0500, Keith Busch wrote:
> > Ah, so we're merging a discard for a device that doesn't support
> > vectored discard. I think we still want to be able to front/back merge
> > such requests, though.
> 
> Yes, but purely based on bi_sector/bi_size, not based on the payload.

This should do it:

---
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 3ca6fbf8b7870..d3115d7469df0 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -737,6 +737,9 @@ u8 bio_seg_gap(struct request_queue *q, struct bio *prev, struct bio *next,
 {
 	struct bio_vec pb, nb;
 
+	if (!bio_has_data(prev))
+		return 0;
+
 	gaps_bit = min_not_zero(gaps_bit, prev->bi_bvec_gap_bit);
 	gaps_bit = min_not_zero(gaps_bit, next->bi_bvec_gap_bit);
 
--
