Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCBED529
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 01:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749604129; cv=none; b=KO634PBpT9Sz/7m2ySFO83MhvrWQMzkOR6khOqmbdRjQC9SyLT6+XKwo+0QSWXS+jjJBh/3C03QTUiVwOfR874c69+IHjo/EtErUr0Ck+ebLWnhDTxjoIX8ZLlbhFrbvIEj8WVAIxS5fTuTUkEFlAu4s1HG4lrcneyUZYIyEPfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749604129; c=relaxed/simple;
	bh=5AYpLs8x6n1sz4rVH8oSc8pinClPeZfKNgbq6HfKCUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0rMehkcjAP4NW7muWDeutFBSQzLyfDfh5KXF+cdw2Cbriliaemx6iIPS8bbLr7OJm9GF/j8zJDhdnlKRWf72WfTJQbul7iT42kgLDIOH5XsCOx2rYHQ/0rWKJmGB1rmfve8vdE4o12/cF2ja/ghMFWOQ/chVl8+PF1jGNTiXBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQZ6ZWQr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQZ6ZWQr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692A0C4CEED;
	Wed, 11 Jun 2025 01:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749604128;
	bh=5AYpLs8x6n1sz4rVH8oSc8pinClPeZfKNgbq6HfKCUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aQZ6ZWQr6cLixF42udvJGyxSGDh+GAWxlRkDG6/yJ45bv5VezP/EzAzZRaFOIpDry
	 9ajIwf09p9tadfR7tWDS9xxJvy96/2uyda2hLVJ4U19esTpvVjSxc5Jo4mGs7iGkPV
	 +OLoNxtGiNllalyWgKK0A0BQW9kRX8CzRyJz2cALQ4x7fnbE6cwCCULCN8LmPERGU7
	 JwxItvxu7jHCIybw1qi52E7Xkv/3Zzs7PXSbikpWj+esGj9NWUq5MoGdvowWKDt6VZ
	 9qJrOEZd/2wx+EbIMuu3m780epwsdgK9IgZSg1Dg//COrjXxj+d6Nqkz6RgcSJ88Pl
	 j+sCEFe1hBkKQ==
Date: Tue, 10 Jun 2025 19:08:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yu Kuai <yukuai1@huaweicloud.com>, Ming Lei <ming.lei@redhat.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH 1/2] block: Make __submit_bio_noacct() preserve the bio
 submission order
Message-ID: <aEjXHiK0EyyDXTZK@kbusch-mbp>
References: <e782f4f7-0215-4a6a-a5b5-65198680d9e6@kernel.org>
 <907cf988-372c-4535-a4a8-f68011b277a3@acm.org>
 <20250526052434.GA11639@lst.de>
 <a8a714c7-de3d-4cc9-8c23-38b8dc06f5bb@acm.org>
 <20250609035515.GA26025@lst.de>
 <83e74dd7-55bb-4e39-b7c6-e2fb952db90b@acm.org>
 <aEi9KxqQr-pWNJHs@kbusch-mbp>
 <c98e6252-c0af-4d25-8995-5b808b0c6da5@kernel.org>
 <aEjVPK9Xdo8P5Um0@kbusch-mbp>
 <4c658f15-7a8d-4add-8638-d8cdfe31f670@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c658f15-7a8d-4add-8638-d8cdfe31f670@kernel.org>

On Wed, Jun 11, 2025 at 10:02:34AM +0900, Damien Le Moal wrote:
> On 6/11/25 10:00 AM, Keith Busch wrote:
> > Ah, thanks for pointing that out! In that case, could we have dm
> > consider the bio "abnormal" when bio_has_crypt_ctx(bio) is true? That
> > way it does the split-to-limits for these, and dm appears to do that
> > action very early before its own split/clone actions on the resulting
> > bio.
> 
> That sounds reasonable to me.

Cool, that's just this atop the previous patch:

---
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 5ab7574c0c76a..d8a43f37a9283 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1632,7 +1632,7 @@ static bool is_abnormal_io(struct bio *bio)
        case REQ_OP_READ:
        case REQ_OP_WRITE:
        case REQ_OP_FLUSH:
-               return false;
+               return bio_has_crypt_ctx(bio);
        case REQ_OP_DISCARD:
        case REQ_OP_SECURE_ERASE:
        case REQ_OP_WRITE_ZEROES:
--
