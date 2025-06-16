Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB6B285C91
	for <linux-block@vger.kernel.org>; Mon, 16 Jun 2025 12:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750078339; cv=none; b=UYDAUjsyBKG18B+1uo2rN3acy98tl9Rpwe4BcPu5SFBlpCE8BNq3/L8wkq+LC8gH/2mgd1WYCj/y3pLe2bpM5wXzL1uljaAreiWwf4uzZ+1qSTUhm2rmQNYsK8+VdkK2kwCuiMrnbMJRAhdbQzDZs4djcpe1Isn0gLRfhhZcDRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750078339; c=relaxed/simple;
	bh=lLluGiDj3IspTt0wBlfDTiSMeTHl4JxzJK1kL5J5Ad4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DagWt33hh0JWstwZeRTHfkIR4KzfyOC6VYNYtsYAgfcW/HWelplrrc4XEOw1947LibB0O4AkcrIDb3BW4tx3XB4N+ld4QZ6txjRGD7XiHYsZbDwU5ojMJ/T+qEMjWQUm5D/yJHFmS6wkJ2wPYsIHYNa/QD0cHamL7WKauaiF1EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hf69rWp0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hf69rWp0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBC1C4CEEA;
	Mon, 16 Jun 2025 12:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750078338;
	bh=lLluGiDj3IspTt0wBlfDTiSMeTHl4JxzJK1kL5J5Ad4=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Hf69rWp0DWw+PRlmlHKCpDWH8GViZHh1RoN3phpFiuApY3BgzmEiuwzNdFsw6eY+P
	 uInQ5YxaUbd50Cn3AywFyulrUastqRXP2KmUbzsYZ8j2HkfKMgl1qxNCI6Dkk24/QC
	 ODU9StPhCY1KDKVFOERclA4NAyotiWPCQiN2NFPY01llmbiEDZgZ8uQRga+sp+QPnS
	 wi7iIeakhTIFncHg4Hz+ltXqoRJdsffwM4taQB2noBkZ6N/UEVkcbZ1hrSKwR+lbfh
	 xxcKUPTCjKUXafzwWy5LtI6rHP7ABBmuWUBJPlfvIy/lSVzTW0JtRr7H3DBKSxBVUJ
	 aZjyRSr7Lr75w==
Message-ID: <2c210c03-9213-4c62-aa4f-2803b6d0ef0a@kernel.org>
Date: Mon, 16 Jun 2025 14:52:15 +0200
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
 <2105172c-5540-40d0-9573-15001b745648@kernel.org>
 <20250616113141.GA21749@lst.de>
 <4973015e-ecb2-4bd9-ac26-05927fa8fbd4@kernel.org>
 <20250616124205.GA27570@lst.de>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250616124205.GA27570@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16/06/2025 14.42, Christoph Hellwig wrote:
> On Mon, Jun 16, 2025 at 02:37:43PM +0200, Daniel Gomez wrote:
>> 	
>> 2. In the if/switch case default case (line 181-183):
>> 	It sets the status to invalid and *iter_start() returns false:
>> 	
>> 		default:
>> 			iter->status = BLK_STS_INVAL;
>> 			return false;
>>
>>
>> Removing the invalid assignment "makes it" valid (because of the
>> initialization)
> 
> Huhhh?  How do you make a field access valid by dropping an assignment?
> 

It should be valid already. But if the initialized value at line 160 can be
changed through the previous code then, this should suffice:

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 37f8fba077e6..7d5ebe1a3f49 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -179,7 +179,7 @@ bool blk_rq_dma_map_iter_start(struct request *req, struct device *dma_dev,
                        req->cmd_flags &= ~REQ_P2PDMA;
                        break;
                default:
-                       iter->status = BLK_STS_INVAL;
+                       iter->status = BLK_STS_OK;
                        return false;
                }
        }
