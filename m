Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE641BC08F;
	Tue, 13 Jan 2026 07:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768289055; cv=none; b=upgi1ajenc8utxgtZQKxepAxwqp6CV2L5XSOho7wvEQO0U9Qt9DaH5ndc/eye8E9FoyCmtK9CchtqeKB8DO/UuFtszf4kc6e8J5lwWtgD29vn9Bta7qnuMmanMWueJ5E/TB7OWYVNHp/R+Yeytd6riP9Wg2yjIOKO0rTk8AGQ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768289055; c=relaxed/simple;
	bh=qJlSVSZIA/vsqZj27L0xVgR++YJ1Ii2BRw2zRW2TCw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIP3DXvOFBR+b3t982QeLSFhbRFLPVZtidu+sNUaSIL1ZRctQcahKMPibtv1wY/8zVn07hZGj6y56GkI4R3qjCuhdBmjk+vwOkxbLcJyxqpRJ0dp2ozPQHpz9pyH6QAB2uygIFCcMuICXSyxBBEacBTi+jTkyvPzV4/B2g6HKls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7B3B267373; Tue, 13 Jan 2026 08:24:09 +0100 (CET)
Date: Tue, 13 Jan 2026 08:24:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, nitheshshetty@gmail.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme: blk_rq_dma_map_iter_next is no longer using
 iova state
Message-ID: <20260113072408.GA26776@lst.de>
References: <20260112135736.1982406-1-nj.shetty@samsung.com> <CGME20260112140208epcas5p4c3ef0209b01be379c836f705a10efa7d@epcas5p4.samsung.com> <20260112135736.1982406-2-nj.shetty@samsung.com> <5b07dbce-2644-4079-a768-9167cbe3e25a@kernel.org> <20260112142822.tk34ei4evgypw3qv@green245.gost>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260112142822.tk34ei4evgypw3qv@green245.gost>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 12, 2026 at 07:58:22PM +0530, Nitesh Shetty wrote:
>> Hu... Why is this not squashed with the previous patch ? If only patch 1 is
>> applied, this will not compile, right ?
>>
> I couldn’t decide whether to use the layering convention or a unified patch,
> so I chose one patch per layer.
> Agreed, independently this doesn't compile, merging make sense.
> I will resend.

Rule number one is: don't break compilation after each step.
Everything else is secondary.

Also I'm only seeing patch 2 anyway, and not patch 1.

