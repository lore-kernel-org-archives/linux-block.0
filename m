Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CEB20330
	for <linux-block@vger.kernel.org>; Mon, 16 Jun 2025 06:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750056206; cv=none; b=RuXXKJiOCYABU+XhyZSlK5oIcB/bLe37s6mo25GBzvq8Yd2uJVK6HVR40N9/dXqMge8sxZhbP9APrzHdtf6+KfeMeYJIeAMdRnq1LgLksEBMLibCJ29/SkO0XZm6cLv067GlRqiCUCe+F2B6zLDQh2mEJPufy6WZdTZnr8C1QFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750056206; c=relaxed/simple;
	bh=i8eZ5db7jwLf3O2OU4sJwtCvyGnyULzOXR46Z6sekOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DBEbvo2/HI7mZzlD0TH/wQdwxFlLbP2cKq9+ucbggi8mzGoe8vNH8BzU9o2HQhBzBgCPUemmEQULFIjmGlSYcqGpda8np2h06yD3Uw4+sSt8aZ1RgfxTmZbuJlbCPQEUpqlealfg40ZpZKMzQKzOKI5qLRvtFqN5809kbZwdXb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ea2GD93o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ea2GD93o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCCDC4CEEA;
	Mon, 16 Jun 2025 06:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750056206;
	bh=i8eZ5db7jwLf3O2OU4sJwtCvyGnyULzOXR46Z6sekOg=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ea2GD93oQhfMVYrQqOBlhv16244neKYQsZ5tMJvqX4kKmN7Cu7dUxD6fMUJhdufGQ
	 D6iPWyjHsx48zcXJTnZtaOuAupGhsUInQzo5yhmnnqm1VvfdYVdNCTlG4CRmnC594E
	 cqI9WHBK0swPEqvw05iJgLssF6bWQUi3GLFIR31MO+9vGN6c2gR8zP7Jfsu3b4/v7V
	 /IMHMQlqFoRNYu9BprdLtUt5hKiobkNmnPPokSQm0OcNOaWzE7XUQh2KXtb7FXIkw4
	 ROJrXWpn78imzqt/xuKQU0bgd/DbXvwHEWBCs7p96qNzE59E20ZLC/a1mrnde4DxT+
	 Rkj2ZwzBNG2uA==
Message-ID: <2105172c-5540-40d0-9573-15001b745648@kernel.org>
Date: Mon, 16 Jun 2025 08:43:22 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH 2/9] block: add scatterlist-less DMA mapping helpers
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Leon Romanovsky <leon@kernel.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, Logan Gunthorpe
 <logang@deltatee.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-3-hch@lst.de>
 <dab07466-a1fe-4fba-b3a8-60da853a48be@kernel.org>
 <20250616050247.GA860@lst.de>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250616050247.GA860@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16/06/2025 07.02, Christoph Hellwig wrote:
> On Wed, Jun 11, 2025 at 03:43:07PM +0200, Daniel Gomez wrote:
>>> +struct blk_dma_iter {
>>> +	/* Output address range for this iteration */
>>> +	dma_addr_t			addr;
>>> +	u32				len;
>>> +
>>> +	/* Status code. Only valid when blk_rq_dma_map_iter_* returned false */
>>> +	blk_status_t			status;
>>
>> This comment does not match with blk_rq_dma_map_iter_start(). It returns false
>> and status is BLK_STS_INVAL.
> 
> I went over you comment a few times and still don't understand it.

The way I read the comment is that status is only valid when
blk_rq_dma_map_iter_* returns false.

But blk_rq_dma_map_iter_start() can return false and an invalid status (in the
default switch case).

Assuming the comment is the right thing, I'd expect a valid status for that
case:

--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -179,7 +179,6 @@ bool blk_rq_dma_map_iter_start(struct request *req, struct device *dma_dev,
                        req->cmd_flags &= ~REQ_P2PDMA;
                        break;
                default:
-                       iter->status = BLK_STS_INVAL;
                        return false;
                }
        }
