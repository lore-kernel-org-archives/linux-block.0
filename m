Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54432153BE8
	for <linux-block@vger.kernel.org>; Wed, 30 Jul 2025 15:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753888703; cv=none; b=VarAeBzaylmZHJ6cpEL72WOktmTHdtVcJ0naEo25KEy0F2JOZ+DUuQv2QBq1Qe0MFjdw7CuZTbRyhwmZYYYJRojiqfLr9A79QxKbxxQbJ01ntje0F/RIX7QKiisslcviuqcdCCO2brBWsQ/SNIFCr9EO3F4XdoRw0TJJpIi8/SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753888703; c=relaxed/simple;
	bh=l2wqk+JqKB6dJ/mOYQb4Q66E1oBu3VoufoALfGPdEXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oov3v9+TAoMOMpIcfSwFLgEMfhx5oa48YJ50UtqJ31sHfnT0vLdYIPXY+Gd9x1bE7OYnpnd6aHa+1SfqSBltSRlP5uFgmmCFwvH6dQgOQvOKadLbKTi1jVxsBcoiejZhn9FqAU5LV+BuqS8ck0RJDDlwpdwnFzsDTSv+C87ZCUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uf2dVkaQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uf2dVkaQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60639C4CEE3;
	Wed, 30 Jul 2025 15:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753888702;
	bh=l2wqk+JqKB6dJ/mOYQb4Q66E1oBu3VoufoALfGPdEXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uf2dVkaQ0z378V9516yzKPY5lW1aYWiiWWDLBtj20oz9MCF5yj6vEc7bLVuKaV4Nr
	 mBUzMkWUOVZSWkK8JN5UyAXWVvFJPDW3kOOGV02Z88u1dl6mFv66BhMqOOM0+V2cbl
	 A25bhCfgCM9AbCn74upfhHSmApnmwTDRG9lt6vjW8K35+23IOLm4k13xREnGbDJU6O
	 piPlBy2laCbY9u2VJGcorzf1/Zvrk4nXkh1Yb522NeWuseYYWUjAXRyANXrLtpuzbF
	 7Xy3AanJxmVygaJDwCs2zf6kmNdQ0xWHj+qxIWPG2p0Lh5u7FaVz0H9uo8OmjEBV4W
	 CvhRhAQ7/N7gQ==
Date: Wed, 30 Jul 2025 09:18:20 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk,
	leonro@nvidia.com
Subject: Re: [PATCHv3 1/7] blk-mq: introduce blk_map_iter
Message-ID: <aIo3vLnxQFWCD_pv@kbusch-mbp>
References: <20250729143442.2586575-1-kbusch@meta.com>
 <CGME20250729143610epcas5p114f07bbd8e9c27280e6ebd67b1afd47f@epcas5p1.samsung.com>
 <20250729143442.2586575-2-kbusch@meta.com>
 <09c06697-dd77-47bb-85c5-fd64e75c7968@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09c06697-dd77-47bb-85c5-fd64e75c7968@samsung.com>

On Wed, Jul 30, 2025 at 01:48:42PM +0530, Kanchan Joshi wrote:
> On 7/29/2025 8:04 PM, Keith Busch wrote:
> > @@ -39,12 +33,11 @@ static bool blk_map_iter_next(struct request *req, struct req_iterator *iter,
> >   	 * one could be merged into it.  This typically happens when moving to
> >   	 * the next bio, but some callers also don't pack bvecs tight.
> >   	 */
> > -	while (!iter->iter.bi_size || !iter->iter.bi_bvec_done) {
> > +	while (!iter->iter.bi_size ||
> > +	       (!iter->iter.bi_bvec_done && iter->bio->bi_next)) {
> >   		struct bio_vec next;
> >   
> >   		if (!iter->iter.bi_size) {
> > -			if (!iter->bio->bi_next)
> > -				break;
> >   			iter->bio = iter->bio->bi_next;
> >   			iter->iter = iter->bio->bi_iter;
> 
> This can crash here if we come inside the loop because 
> iter->iter.bi_size is 0
> and if this is the last bio i.e., iter->bio->bi_next is NULL?

Nah, I changed the while loop condition to ensure bio->bi_next isn't
NULL if the current bi_size is 0. But I don't recall why I moved the
condition check to there in the first place either.
