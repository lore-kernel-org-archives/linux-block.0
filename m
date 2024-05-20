Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8EB5579A
	for <linux-block@vger.kernel.org>; Mon, 20 May 2024 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716220189; cv=none; b=BN7gaajaj1DO/R+vS0cOYF8FY47JHjBxs7OIUxHGDdse93pEr+xP+CWP4sfIZkTocRpQHKPS6kFzLDTP51bW0oK5H37r+1JwQGfauh24pRpcsp01KQWl4SlUDBlkwBWi2uNyDF3+uni9KGXA/RZlF/NP+nEGMZY0wrb8XHDPUDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716220189; c=relaxed/simple;
	bh=IzVMSSo/trQ8frvLy+4ppmguGh8+eIwcSPyAQgPqk60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9bJkNPBCnW0n0ykOwf8dvtlbD9UeDNNVPkBEemKIzYB8dEt415JBhPTKGWc36saTbdeBslxNyfVXDnCRBnR3r3wPJSInSK8x0hQb5cKuOA/k6UzQs1sU00MgArVXDPeGawLmmQIPzNj+bH8yhqL/7sg14Tv37vjaTkivWtf9ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 96C5E68AFE; Mon, 20 May 2024 17:49:43 +0200 (CEST)
Date: Mon, 20 May 2024 17:49:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	martin.petersen@oracle.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v2] block: unmap and free user mapped integrity via
 submitter
Message-ID: <20240520154943.GA1327@lst.de>
References: <CGME20240513084939epcas5p4530be8e7fc62b8d4db694d6b5bca3a19@epcas5p4.samsung.com> <20240513084222.8577-1-anuj20.g@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513084222.8577-1-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index 2e3e8e04961e..8b528e12136f 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -144,16 +144,38 @@ void bio_integrity_free(struct bio *bio)
>  	struct bio_integrity_payload *bip = bio_integrity(bio);
>  	struct bio_set *bs = bio->bi_pool;
>  
> +	if (bip->bip_flags & BIP_INTEGRITY_USER)
> +		return;
>  	if (bip->bip_flags & BIP_BLOCK_INTEGRITY)
>  		kfree(bvec_virt(bip->bip_vec));
> -	else if (bip->bip_flags & BIP_INTEGRITY_USER)
> -		bio_integrity_unmap_user(bip);
>  
>  	__bio_integrity_free(bs, bip);
>  	bio->bi_integrity = NULL;
>  	bio->bi_opf &= ~REQ_INTEGRITY;

This looks correct.  I wish we could go one step further (maybe
in a separate patch/series) to also move freeing the bio integrity
data to the callers.  In fact I wonder if there is any point in
doing this early separate free vs just doing it as part of the
final bio put.  With that we could also entirely remove the
BIP_INTEGRITY_USER flag.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
