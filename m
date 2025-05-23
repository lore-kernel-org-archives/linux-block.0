Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8C12DCBF2;
	Fri, 23 May 2025 04:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747974112; cv=none; b=shdEYx5EZx9hf/zSunbRhwIj9wzTBuUv0kOfwjTxTm3uZVyfKvhF2OvC3+aQTkpCoFVH7N/AK0cGlipW4dT3WR1bpJxsjBBiO6nPfzWT5fS1jD7Fo061iwp/5kL+zUZQC5NksEg3YDy34/TKPPpg6acN3CM/lz06C68OuEKp0uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747974112; c=relaxed/simple;
	bh=gfH9VASWiU+xdAzCcVxY4Maje43Wg/KxuK5fI80t3aY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/RqvwoIBRE1dB2FL0g2bl+Oy6NzQMzzmOpZutlLC1/NdDokllA5JmnyotiIl6OqVkVtonKtpiZzHKsH5/hqtph7ma9vZdXQSnu3mwBzm3KjrvGouYi2ioipRPl/M6arY4orbaDquqtziwAoqht3u2gMZrIxdZmnWzeAB9sZZJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4E1D467373; Fri, 23 May 2025 06:21:45 +0200 (CEST)
Date: Fri, 23 May 2025 06:21:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Yu Kuai <yukuai1@huaweicloud.com>, Ming Lei <ming.lei@redhat.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] block: Make __submit_bio_noacct() preserve the bio
 submission order
Message-ID: <20250523042145.GA6344@lst.de>
References: <20250514202937.2058598-1-bvanassche@acm.org> <20250514202937.2058598-2-bvanassche@acm.org> <20250516044754.GA12964@lst.de> <47b24ea0-ef8f-441f-b405-a062b986ce93@acm.org> <20250520135624.GA8472@lst.de> <d28b6138-7618-4092-8e05-66be2625ecd9@acm.org> <20250521055319.GA3109@lst.de> <24b5163c-1fc2-47a6-9dc7-2ba85d1b1f97@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24b5163c-1fc2-47a6-9dc7-2ba85d1b1f97@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, May 21, 2025 at 02:18:12PM -0700, Bart Van Assche wrote:
> The following pull request includes a test that triggers the deadlock
> fixed by patch 2/2 reliably:
>
> https://github.com/osandov/blktests/pull/171

Can you post the pathc please?  I've not found any obvious way
to download a patch from the above website.

