Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754172107;
	Tue, 23 Jan 2024 05:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705986433; cv=none; b=WWmkEymJkWfEbrRnk8Lu7/WxfYNLHY8L9Ul88lw3ri9gNNrpXW6Dn6JSMxqCENGHPPteQOhwL/qF7wMZuEJggumsFzfEmYJ/krwMQkhiegd6p9OCCg1cBET1tY6/Jedab77cZofWq7Z3VBb1+66EN7VnVjRxWaHCvuCQb3LIRSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705986433; c=relaxed/simple;
	bh=pP73/t4EQeLWbOVO+IMYjVn0jX0lOCnSILJMj+j+sUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T9ChOlwpo0zqVIAyAMsI8NAKw19h2VE6nvcX0BSESO38RaJma77vXB4QYlVVEFa7qNWH4YWOHvqpgI0jddFN9MgO8O4vQS3Ldi3oo1nl3FRgExXk0AbrB8yH9bzH/8+vokJijXz0xot68Mtg32oF0mFQbeXcUBQzGJJdMz+wuW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azAf600c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azAf600c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850CCC43390;
	Tue, 23 Jan 2024 05:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705986433;
	bh=pP73/t4EQeLWbOVO+IMYjVn0jX0lOCnSILJMj+j+sUI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=azAf600cCndJ1ldkIpfi9L/CwKa1f/qYxVkMLOb2GTvmHseQ0pND7OdDBad/D17Ne
	 qPfjZA+eyHu6uLA3lHNGVMVmJ1DEE4AGQvGj5+ej3G68QTvfNdqblKilyJjaPZX7XQ
	 gRnRsKho/UL0N/lt8+Y8p3q6rj49uZji08uBx92kzNLcecR6ikeuLg0K4nTBv+zn/f
	 0G0Zfh3gCiwv7Gne0GXDJuY/QWIpkFcK4IprajCsIGd0Dkyqg+14wg1PKF+XFSQbkA
	 WAB3LaBwKjCHDOcCG+OapsB1Qo5psfL1DZwsNhSKuXOTivosKNCpNx42veJyTVcbbt
	 nMOoq8hBfqpfQ==
Message-ID: <d3e5c919-0040-4284-96a3-df39f1aed819@kernel.org>
Date: Tue, 23 Jan 2024 14:07:10 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] block: use queue_limits_commit_update in
 queue_max_sectors_store
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
 <20240122173645.1686078-5-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240122173645.1686078-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/24 02:36, Christoph Hellwig wrote:
> Convert queue_max_sectors_store to use queue_limits_commit_update to
> check and updated the max_sectors limit and freeze the queue before

s/updated/update

> doing so to ensure we don't have request in flight while changing

s/request/requests

> the limits.
> 
> Note that this removes the previously held queue_lock that doesn't
> protect against any other read or writer.

s/read/reader

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Other than these typos, looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

