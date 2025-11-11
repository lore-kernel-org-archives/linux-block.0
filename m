Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6533261B77
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762867541; cv=none; b=JjWov+OqaoWzGhrWs/pG1HWpWCt+QqlSBB69/Ej17QEeMSlNRZL/QwpyXKclvBzl/z7buMcs/yncR44eOsSNhhP4lBS/Q+fLmWq1+sZQvixeHwybLrK5m7GpLCMxIizXKQ9yIbAo5p7zFGmQb3qIVskqxKVNRJg6kN4GVw0XezU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762867541; c=relaxed/simple;
	bh=pCCfLAd+jgtFe99TpuN79KMHvJQ3KhJwNnbu3i0DEQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcw800L2MxNC4LZxPLEAqUCTDFNl2ACWxf/dZGguDL+6uXyt3aIYYuEBxD2Rv9uUI8frN2SXYl3btIrPqjSPDft+l0SzSYj1ql/JPBpQICbajfTGVdWyHAhhjES51w7ZX3/BO4PBVTMa3ALKEpZ52MBF19kNzW2e4ddkpkKa8nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XStIr7KE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XStIr7KE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932E9C19421;
	Tue, 11 Nov 2025 13:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762867541;
	bh=pCCfLAd+jgtFe99TpuN79KMHvJQ3KhJwNnbu3i0DEQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XStIr7KEPP6lsJ/X20MeRdxMRZBEFVNwaZARKWvlQtCOPoPRKLcHrH6NLQAV2v07/
	 4fIfceZuxnn9B2sL5dPnf9GWrmoIbf9rjVTjd+F3AVK0FQYrNDTx2ugHx8JHTSiY3+
	 fsBywk1tIHHffVtoK/ex4cnbbmPCIhBj9t4tMfbX/63moCK0nWyXRjFcf+yqJOLxXJ
	 DGVcSrDdb0JR2GbynBsTPDpI6Ft9Hx7wl9njOZdkAj23oa3gmr6t+Y9+JS/kpjmz8w
	 hyqygSpSxf0etucQWAouS/+hu7YqPAEj1unljxkuWEOGDf49pWiVUbGXQgyhMNLaPo
	 1z/ntfJjdDPeQ==
Date: Tue, 11 Nov 2025 08:25:38 -0500
From: Keith Busch <kbusch@kernel.org>
To: Yu Kuai <yukuai@fnnas.com>
Cc: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>,
	Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCHv5 1/2] block: accumulate memory segment gaps per bio
Message-ID: <aRM5UoApKZ9_V7PV@kbusch-mbp>
References: <20251014150456.2219261-1-kbusch@meta.com>
 <20251014150456.2219261-2-kbusch@meta.com>
 <aRK67ahJn15u5OGC@casper.infradead.org>
 <aRLAqyRBY6k4pT2M@kbusch-mbp>
 <20251111071439.GA4240@lst.de>
 <024631dc-3c65-49a8-a97a-f9110fd00e9a@fnnas.com>
 <20251111093903.GB14438@lst.de>
 <c82cd0f1-f56e-445b-8d78-f55a0c3b2b4c@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c82cd0f1-f56e-445b-8d78-f55a0c3b2b4c@fnnas.com>

On Tue, Nov 11, 2025 at 06:14:24PM +0800, Yu Kuai wrote:
> >
> At least from blk_try_merge(), blk_discard_mergable() do return false,
> however, following checking passed and we end up to the back merge patch.
> 
> blk_try_merge
>   if (blk_discard_mergable())
>     // false due to max_discard_segments is 1
>   else if (...)
>    return ELEVATOR_BACK_MERGE
> 
> Perhaps are you suggesting to change this to:
> 
>   enum elv_merge blk_try_merge(struct request *rq, struct bio *bio)
>   {
> -       if (blk_discard_mergable(rq))
> -               return ELEVATOR_DISCARD_MERGE;
> -       else if (blk_rq_pos(rq) + blk_rq_sectors(rq) == bio->bi_iter.bi_sector)
> +       if (req_op(rq) == REQ_OP_DISCARD) {
> +               if (blk_discard_mergable((rq)))
> +                       return ELEVATOR_DISCARD_MERGE;
> +               return ELEVATOR_NO_MERGE;
> +       }
> +
> +       if (blk_rq_pos(rq) + blk_rq_sectors(rq) == bio->bi_iter.bi_sector)
>                  return ELEVATOR_BACK_MERGE;
> -       else if (blk_rq_pos(rq) - bio_sectors(bio) == bio->bi_iter.bi_sector)
> +       if (blk_rq_pos(rq) - bio_sectors(bio) == bio->bi_iter.bi_sector)
>                  return ELEVATOR_FRONT_MERGE;
>          return ELEVATOR_NO_MERGE;
>   }
> 
> And the same for other callers for blk_discard_mergable().

Ah, so we're merging a discard for a device that doesn't support
vectored discard. I think we still want to be able to front/back merge
such requests, though.
