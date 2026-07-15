Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F88F2737E0
	for <linux-block@vger.kernel.org>; Wed, 15 Jul 2026 08:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784103752; cv=none; b=YqGM048pPaKLWy7i5EOVd6CAGejhXyaKSLYx93qSQkDKA54tiZ4Uv6qRMP849/52swuUmOuvl2U+EecK2DUruz0Argg5K2P2fJFL+lW7iwcf/Qmj8MZohBteteQBg4EzWJijUOgL/PbppiosCl1gtFhdNEsUskgS5JACSWiBZes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784103752; c=relaxed/simple;
	bh=CiBeUlz2lXq8xODT2nr+6qVUdQc/cX8oIcCslHORPHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=famULZ2SyM/1qhQZ4CKV0jcV4fwyIYOii/XlDbx41M70vwkg8xuEyKEFCbXSKYPOKInucoPFtmTYvdYs+2Eu3ZfaQLI3Arod3ysFpV6r382d2ay5iZhBNKPg5CkSyjobpBY/ZL0GtjhRbMzbYo9cIB/7GjN0VdjvoQZLcuYYrHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5NuRiFC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5NuRiFC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D5B1F000E9;
	Wed, 15 Jul 2026 08:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784103751;
	bh=T0G63opEaQpVyxRe6nv6VA4EAr9PIlAsWX9okjWfe3w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Q5NuRiFC88f8TyiD09H2fCPeiR1UdcxEZQo4F7VLRC7mDHbLNTqbzdMp5JM3cJ2XG
	 qqjpabB5tEjXCJo3xTBphJoLZCdGjyge+18FuH+nT3RH5kjQtzyL8bBIGXVcfZn5db
	 8/9e0PFdxSFwOrM+zcrZGZWwqtdZdJeVvmHQOqQJbXfhwbKMzAk/E4rSkm0dDfvSP+
	 C55TAH0yDMJto7L2dR+UKD65MF2wL8gt2wYyvp1TVwKKN1I9keHxwNC9aztPQlrUFW
	 Jagd9eg68lFrDql6uLM1xGvCzqDeTSD2x7BR7A8j2zG7fC2O//dSWiQUiZlMN9cWCR
	 p4dMAisYGaeHg==
Message-ID: <38cd2f60-dd5c-40dd-946d-9d2c17db0044@kernel.org>
Date: Wed, 15 Jul 2026 17:22:19 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: remove most blkdev_cmd_discard arguments
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20260715063734.2933511-1-hch@lst.de>
 <20260715063734.2933511-2-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260715063734.2933511-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/26 15:37, Christoph Hellwig wrote:
> All other arguments can be derived from cmd, so do that to simplify the
> calling convention.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
