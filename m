Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239335695;
	Tue, 11 Aug 2026 19:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786476658; cv=none; b=jUJvQAVhlQb7MueY06+luTVlJeOHxPIsXbWXtJB85Bf9MkXCcMv3z/O+L9Bi+CBLRgEH97z6aHH67hdJrq2PCkpbsJw6AjzggkGYblAhhV4sbEMSW66fG0F/s6Aucg24sdmb9tRt0YTL2xMrl/+FKMmqCopEEE2i6k7AEQEUFRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786476658; c=relaxed/simple;
	bh=WDOqWiEKAtNBmweZRdRJ3rozLQujznEScZppuT1QDgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=druanCxWuhW49rRjjrjIIIQ9Fz+G4Kq5BgPqmCzt26AUyNEZ7IBX6ajBEuFKnJT3wiii9NN2qI56ox4WfKsL1f7TU6or8JGBAlz24ub4QYu3urap8RuH5mgT2IOWk92Pw9+9I/+Ke2Nd9YsQh9ORIgRPYO2xmEcLI1Bd3MhqYhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YV6JG+WX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YV6JG+WX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D6C1F000E9;
	Tue, 11 Aug 2026 19:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786476656;
	bh=ppaGrFDS/Cy0UamQGdFz0z/IJh45MV37F9M66+nhl3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YV6JG+WX3r/IjhJAang6vp6b7f1+8gIIErN6LoJsfQQmDITFRFUhPktYm/8yppPfr
	 hRsCLkUs+SPGEsE3GLRlV0pd7TQuNWhHjIxZrbD9Rb7Z/EpRLQFcTwyOnXmSQeTmQi
	 ClxEj8C9RjZShX4785kZvI5WncwV2bRvFKN3fdKIUWrQ1ARSbCzAd7bi3VHAlVZjNX
	 zWhJEW/FYCy1IWVrcQEjwktqyEYaPI2HEm6ZADH45VOn6WJprRv3D9ZUft+pJm1+gj
	 ni9vPtH8AH76Pjnt+m4VETXLAq7KcADzXsIZZwVN0k598zBEN7tWelJA9UpYpGsSOi
	 g39wcqnfU1xlw==
Date: Tue, 11 Aug 2026 13:30:54 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chao Shi <coshi036@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Weidong Zhu <weizhu@fiu.edu>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] nvme: refuse an unsolicited format change on a
 namespace that is in use
Message-ID: <ant4bioGLl4B35n_@kbusch-mbp>
References: <20260811192111.2058140-1-coshi036@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811192111.2058140-1-coshi036@gmail.com>

On Tue, Aug 11, 2026 at 03:21:11PM -0400, Chao Shi wrote:
> @@ -2436,6 +2454,28 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
>  		goto out;
>  	}
>  
> +	/*
> +	 * Changing the LBA format or the metadata size reinterprets everything
> +	 * the host has already cached, queued or handed to the integrity code
> +	 * for this namespace, and freezing the queue does not cover any of it:
> +	 * page cache contents, bios batched on a plug and the deferred
> +	 * integrity verify work all outlive the freeze.  If such a change
> +	 * arrives unsolicited while the namespace is in use, refuse it and let
> +	 * the caller take the namespace offline rather than adopt a geometry
> +	 * that describes something else than what the host is holding.
> +	 */
> +	if (nvme_ns_openers(ns) &&
> +	    !test_bit(NVME_CTRL_SELF_RESCAN, &ns->ctrl->flags) &&
> +	    (ns->head->lba_shift != id->lbaf[lbaf].ds ||
> +	     ns->head->ms != le16_to_cpu(id->lbaf[lbaf].ms))) {
> +		dev_err(ns->ctrl->device,
> +			"unsolicited format change on in-use nsid %u (lba_shift %u -> %u, ms %u -> %u)\n",
> +			info->nsid, ns->head->lba_shift, id->lbaf[lbaf].ds,
> +			ns->head->ms, le16_to_cpu(id->lbaf[lbaf].ms));
> +		ret = NVME_SC_INVALID_NS | NVME_STATUS_DNR;
> +		goto out;
> +	}

Refusing to acknowledge the new format doesn't mean you get to continue
using the old format. You're going to corrupt memory and data this way.
