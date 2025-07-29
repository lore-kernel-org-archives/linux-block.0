Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D7E289E0B
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 11:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753787149; cv=none; b=J7X6o9YS8pQ/m4+IlwccdjFsd9o1fwhjFNe9pGl6IqZHeK1/YvNzUma0d5VK02bb7JFN051rT1WKGgHPaGIjXzG13N5t5qRnEEb2x1MP4GlUxQCMdGtNv2k9YJiwhttBBQC0dZ0TzCog15yViSMYZjg2jIAwtwofu8Mv7C2LYXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753787149; c=relaxed/simple;
	bh=1Plh5jVOBIySX8LlXCejFVxkaz3n+fSwrXpxXmXxdOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VoOUCvQnJtaYKgeRn45pHpOaJ+7teaWLao9arQImJQzKKZSlp6MnR6NTgx09LTIwLTsJtaWrWROcYLzn91cC9JvY4nlj1Nq6oQYEfB2Bbx3TiRbDmr4ggeQkOvOL+EHh24e78bYVYt78UpTOa9wJJWPV14smSoLSbHf7jJ4tFTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwZm/5Ir; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwZm/5Ir"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9207EC4CEEF;
	Tue, 29 Jul 2025 11:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753787148;
	bh=1Plh5jVOBIySX8LlXCejFVxkaz3n+fSwrXpxXmXxdOU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FwZm/5Ir9x/p+zY9Td9TQ83hrWTNgDkgNZrOQYDuLkFVZpIOV9/NIvMiUU97fyv7t
	 SKEYj3ZODxksOKIIBW8n0RDwR0WzM6JyL5d2Vg/7O+/klxPtHOOj+kra8GYPhoBhsh
	 LoSghIE+qUN8sgWBN86SbfnV2NWt6ZtWgFyWFR+j3qhB3XoA+XCGQiF8eayKVV24LZ
	 MOzOaIZHCIny105sQMmVeE/UHwJo6y4iNoMzRykgxddW6tmz4klxFuvWCPKeXaUqdI
	 UNPar4EeJ+bt51XOcxj0aZ1wNOcjzk6lxBEcqMInXCRtgH1p+QzTlQs8j4uvBupnBK
	 Pagz54NRJbvfA==
Message-ID: <06045a42-a696-4b6b-9047-f6c5f85b6009@kernel.org>
Date: Tue, 29 Jul 2025 20:05:46 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] block: avoid possible overflow for chunk_sectors
 check in blk_stack_limits()
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, martin.petersen@oracle.com, hch@lst.de,
 hare@suse.de, bvanassche@acm.org
References: <20250729091448.1691334-1-john.g.garry@oracle.com>
 <20250729091448.1691334-2-john.g.garry@oracle.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250729091448.1691334-2-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/25 18:14, John Garry wrote:
> In blk_stack_limits(), we check that the t->chunk_sectors value is a
> multiple of the t->physical_block_size value.
> 
> However, by finding the chunk_sectors value in bytes, we may overflow
> the unsigned int which holds chunk_sectors, so change the check to be
> based on sectors.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
