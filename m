Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC844422541
	for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 16:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786982703; cv=none; b=RoO2gqs4pWgADViICHXGKnaKHSyilcGe8cGZbcWAFybEHBC4Tdhlmb7EbP3ciPovSXt7ZgiP6ciDf+JJ1jvrqfHXweTCeMad6uLHKS37Qc81573q96P7bW+v/+DcTDj/w5UXxytPwjU4qmEU2wXheRNQogNnRB2UkDTeDPE3tI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786982703; c=relaxed/simple;
	bh=ajd7nMNCVXUqb1LbNm3NwwKHRSv2eqsuJ6GFB9hZzoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRWUmKC53Gl1w/83Z7CXJOCGV2q7o/H+N0/4LJdp19jK/j41UFTNsg/ljK7s0030V8+GGOgLKJlpTAUbzCcDh3h7Q+h5cNpHkqWfXC4COifnM71vsW1Cex7JcryouDUuYJFC7Lbxctl452Ref5aEW7D/ilg8MC+nSbvcB78c1Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fO4irgHh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fO4irgHh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205DB1F000E9;
	Mon, 17 Aug 2026 16:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786982702;
	bh=T+q5TB4tDNkFjf/LcS6YHnZ52RrH5YFtDiWHGm00d14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fO4irgHhKgHFCBCh6x65nsczOsr6laBg9lud+1B+zLZkjow0OmudZHwCrE9OaOb0l
	 05Qh9R1xIKSIJdG3xEGJclt1WyohuVKR0VzRE+b8HXa6/+KBbGmRs81ntRkgT9kkEl
	 sF5CDMHKP5RsXbE4uGhrehK4haXpJvAcdzxnIGDX/CFdyL/QgTcF0QlzUTdYoTy3ZG
	 wbX7CSzUU0p+RKuIpSeyA+ECDtHoroN3EYu25jYzzqJLoWn4hOF57d93kvwhexxKk6
	 6g7ozAGEpDjC+uT/B8mBD2dyExANGQH+OpQ0kdRo/x0Kliibc90YHMearU5M3x//w/
	 Ib6HOI02Vqcsg==
Date: Mon, 17 Aug 2026 10:05:00 -0600
From: Keith Busch <kbusch@kernel.org>
To: Eric Auger <eauger@redhat.com>
Cc: Keith Busch <kbusch@meta.com>, hch@lst.de,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	axboe@kernel.dk, Jeff Moyer <jmoyer@redhat.com>,
	Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: [PATCHv5 1/2] block: accumulate memory segment gaps per bio
Message-ID: <aoMxLBmKfFo_-i1u@kbusch-mbp>
References: <20251014150456.2219261-1-kbusch@meta.com>
 <20251014150456.2219261-2-kbusch@meta.com>
 <1805eed3-90ec-4f62-9d71-e3f898a464ad@redhat.com>
 <aoMi6y2qsnRVembg@kbusch-mbp>
 <0023a895-7b04-44cd-a90f-c9d587a49519@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0023a895-7b04-44cd-a90f-c9d587a49519@redhat.com>

On Mon, Aug 17, 2026 at 05:12:39PM +0200, Eric Auger wrote:
> Please let me know if you want me to trace some stuff specifically.

Can you test the same setup with this included?

---
diff --git a/block/bio.c b/block/bio.c
index 4074a0496b93f..c343788e1f96e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -859,6 +859,7 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
 	bio->bi_ioprio = bio_src->bi_ioprio;
 	bio->bi_write_hint = bio_src->bi_write_hint;
 	bio->bi_write_stream = bio_src->bi_write_stream;
+	bio->bi_bvec_gap_bit = bio_src->bi_bvec_gap_bit;
 	bio->bi_iter = bio_src->bi_iter;
 
 	if (bio->bi_bdev) {
@@ -1969,6 +1970,7 @@ struct bio *bio_split(struct bio *bio, int sectors,
 		bio_integrity_trim(split);
 
 	bio_advance(bio, split->bi_iter.bi_size);
+	bio->bi_bvec_gap_bit = 0;
 
 	if (bio_flagged(bio, BIO_TRACE_COMPLETION))
 		bio_set_flag(split, BIO_TRACE_COMPLETION);
--
