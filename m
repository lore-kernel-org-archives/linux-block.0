Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39FA1EB196
	for <linux-block@vger.kernel.org>; Tue, 13 May 2025 06:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747118682; cv=none; b=rKvdL1zuxa2d4In3BK1h6gqn1ZMcIFPKXwRPHwtpQ0CYkvFJa9XvB4nSt/b5s8v6hXZh3t09p3fqDIOMMeXOxT7ce4w6Me6tQfFG66Lb0ljgt2Yuic2KbtGX089ybfhZ5WKyxxc7L5Jn97/VwjhFQcFdVEFMmqopZf5MCiYHfLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747118682; c=relaxed/simple;
	bh=H94eGa3+FXw5NEf0LpHYmxGixYK0NX1Do5g2HVRmbS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o55oR0j/2ap92YKFWoWyZ3t5ON+WHbVTXzEEJzBAwu2VuBhVplvWAyu09qsu1QTntXQWBSKMIg14klNmZ8OWTTG8LlCT1eFN16zjuOqwqHnrnUh51xkh6NrzQ5PLWoILyJQEscXAo3kVwCIC7+XwvJnkBV0kgIgCXiShq7PT1hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1CC3D68BEB; Tue, 13 May 2025 08:44:35 +0200 (CEST)
Date: Tue, 13 May 2025 08:44:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] block: Split bios in LBA order
Message-ID: <20250513064434.GA1199@lst.de>
References: <20250512225623.243507-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512225623.243507-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 12, 2025 at 03:56:23PM -0700, Bart Van Assche wrote:
> The block layer submits bio fragments in opposite LBA order. Fix this as
> follows:
> - Introduce a new function bio_split_to_limits_and_submit() that has the
>   same behavior as the existing bio_split_to_limits() function. This
>   involves splitting a bio and submitting the fragment with the highest
>   LBA by calling submit_bio_noacct().
> - Use the new function bio_split_to_limits_and_submit() in all drivers
>   that are fine with submitting split bios in opposite LBA order.

If you have to rename a user visible symbol, please do that in a
preparation patch.

Also how do you determine some drivers are fine with one order while
others are not?

> - Modify blk_mq_submit_bio() and dm_split_and_process_bio() such that
>   bio fragments are submitted in LBA order.

blk_mq_submit_bio calls __bio_split_to_limits, which returns the
bio split off the beginning of the passed in bio by bio_submit_split.
I don't see how that would reorder anything.

