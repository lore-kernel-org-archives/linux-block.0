Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F2914F6C;
	Wed, 29 Jan 2025 06:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738130830; cv=none; b=rAsj0+Nw8MxlBvk1+/htEtQI3/6LbBqnRc36NX/MaKT+Gj0/43BBexWHGqkcq9/3Ky4Wf5qdTrvf9HLdeUx9x2Bzijz1CCilcphvpUmSmVs0GDYuhjkFwdAebrGGaCkIx1VpNU3FUzea0HOBIKp0u8CFE3rORPZATcIl1J+cmUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738130830; c=relaxed/simple;
	bh=WmZ8Cf7hx1BCGY2wCKipgjd/j42Viv5BD8p05M2Lupk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzRccCLUbncQ3FpKPAdk84zlC32DrxA+FkacEmqxOlAsQSflaxVqV45kKaskxS0s6H3PX28Sy5HQQGgRABwillrb/a7md2AZMBFs9JjQFvhK9w7nrb47EYWD+RAgB3M0lqmYYV/0spPKT3YzUiJYBPanctS59rJz83doebBjIFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2B51D68D13; Wed, 29 Jan 2025 07:07:05 +0100 (CET)
Date: Wed, 29 Jan 2025 07:07:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <ming.lei@redhat.com>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] blk-mq: fix wait condition for tagset wait
 completed check
Message-ID: <20250129060704.GC29266@lst.de>
References: <20250128-nvme-misc-fixes-v1-0-40c586581171@kernel.org> <20250128-nvme-misc-fixes-v1-3-40c586581171@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128-nvme-misc-fixes-v1-3-40c586581171@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 28, 2025 at 05:34:48PM +0100, Daniel Wagner wrote:
> blk_mq_tagset_count_completed_reqs returns the number of completed
> requests. The only user of this function is
> blk_mq_tagset_wait_completed_request which wants to know how many
> request are not yet completed. Thus return the number of in flight
> requests and terminate the wait loop when there is no inflight request.

This looks sensible, but you should probably send it directly to
Jens instead of tagging it onto a nvme series.

The code could also really use a comment on what we're counting and why.

