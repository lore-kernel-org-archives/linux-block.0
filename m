Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA4710E4;
	Fri, 16 May 2025 04:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747370888; cv=none; b=PeQOvHZIkxEkDatFYnyb2h5Alh5xeRU4x+xS7uYVw/GuIWD6kDm09iM7bbJFmfxCa1WB374A8KLezUhFVWc8GJlMLWjiOz+WwtVzlcTOhB19S7D/UBq86WTw6lpMLN2mnI3L7ylufwxlJDeYah/tnSb6ataxRnENaaQtN3wHfsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747370888; c=relaxed/simple;
	bh=db5+y9W9O1XMRw78IbF4CeLjvRbadbhXMXm+aMxAKwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sa077xcnrhhox1IpWkpKPPk1OZ/8jKN6M1TMU1wAD+ZsoVXKzDXEV0y+Fx3Hwe2wVD4muz92iNZ5HNnhoWVW7M67S3r3N+sB1gB1f5DnCQYApKLLNUbZvd2PTnCxI+kPZWrRUgDT/vdwt0Bj1WAW/OZGP+ZDUiIQXvHPsxwpTlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BE12B68AA6; Fri, 16 May 2025 06:47:54 +0200 (CEST)
Date: Fri, 16 May 2025 06:47:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Yu Kuai <yukuai1@huaweicloud.com>, Ming Lei <ming.lei@redhat.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] block: Make __submit_bio_noacct() preserve the bio
 submission order
Message-ID: <20250516044754.GA12964@lst.de>
References: <20250514202937.2058598-1-bvanassche@acm.org> <20250514202937.2058598-2-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514202937.2058598-2-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, May 14, 2025 at 01:29:36PM -0700, Bart Van Assche wrote:
>  		/*
>  		 * Now assemble so we handle the lowest level first.
>  		 */
> +		bio_list_on_stack[0] = bio_list_on_stack[1];
>  		bio_list_merge(&bio_list_on_stack[0], &lower);
>  		bio_list_merge(&bio_list_on_stack[0], &same);
> -		bio_list_merge(&bio_list_on_stack[0], &bio_list_on_stack[1]);

If I read this code correctly, this means that we no keep processing bios
that already were on bio_list_on_stack[0] and the beginning of the loop
in the next iteration(s) instead of finishing off the ones created by
this iteration, which could lead to exhaustion of resources like mempool.

Note that this is a big if - the code is really hard to read, it should
really grow a data structure for the on-stack list that has named members
for both lists instead of the array magic.. :(

I'm still trying to understand your problem given that it wasn't
described much. What I could think it is that bio_split_to_limits through
bio_submit_split first re-submits the remainder bio using
submit_bio_noacct, which the above should place on the same list and then
later the stacking block drivers also submit the bio split off at the
beginning, unlike blk-mq drivers that process it directly.  But given
that this resubmission should be on the lower list above I don't
see how it causes problems.
