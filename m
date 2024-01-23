Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EC87E6;
	Tue, 23 Jan 2024 04:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705984758; cv=none; b=q2SOz77P+kNs7qeDApUwNhGtSS7DTyLvjQkgvhuHoKlPoQvLXuuJzXU9MD1KBdv/pFaqRr3RHIx1uLOYRa+3hqepRFsk1iCONOhaHdVpr/WFsjLm2WFrCKx08kaPOuKq2Ad4Vfa7HEZN5mHt4NTP/9fT2TdX7XkwSIhDkr9mnKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705984758; c=relaxed/simple;
	bh=ENhGdnTXi5oZTFrpBO4asSbiZwsBH4Q1o3HBHTCIVUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JXXUKDgrQFWT6bWJjoq4LCOUxrS/jpVIoYs2KTXvROI8MKDmVrch0os1fhJYi3xIZMIlmNaP9lZKHd4DJwgjocHwsELl8UPcQre5YWKIhrkBGsEVWUTEPdL0igiYMtshrDOHxBrV27oOqko3GCw2irtMJHMZL3g67utIFSVhcTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TeRUfrxC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeRUfrxC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0BDC433C7;
	Tue, 23 Jan 2024 04:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705984757;
	bh=ENhGdnTXi5oZTFrpBO4asSbiZwsBH4Q1o3HBHTCIVUA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TeRUfrxCFyCGOw4oNFTmLA/mdXvJT0bJ1pWXonOksXzRA2uW/dsFBfRH6OgDCZfei
	 /BvQy8TH4p34274weuYtS/xikv2JDQd72kijKqJdGZIrtfkhTykfzUMnpTTq6pQziv
	 ByWqicuoZRqvv8XA4b06y0toIEOyMr+kigyJvxQhdbfeCRZqw/33Zl2K+sFHvPmHZy
	 d7Sj0KC0pXbsRyLaCyNWsqnTiugzD3rwxI1hUmmbayX/CIMoYqTx2m8+oA6LGMAx8C
	 +H35N6q7cmkiqWQ0PWe66HKaa7UU4pIyEuJI2EUjKwPe2wcs55zPakccJ4SAD9FHrw
	 L1D6AntGZPqEg==
Message-ID: <65f1df6b-3a44-4636-898e-0c2f2a637d85@kernel.org>
Date: Tue, 23 Jan 2024 13:39:14 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] block: move max_{open,active}_zones to struct
 queue_limits
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 virtualization@lists.linux.dev
References: <20240122173645.1686078-1-hch@lst.de>
 <20240122173645.1686078-2-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240122173645.1686078-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/24 02:36, Christoph Hellwig wrote:
> The maximum number of open and active zones is a limit on the queue
> and should be places there so that we can including it in the upcoming
> queue limits batch update API.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

