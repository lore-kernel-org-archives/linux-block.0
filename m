Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0927A30D3EA;
	Mon,  6 Jul 2026 07:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783321521; cv=none; b=cSjOWWRxu+W5X6gXftUjeD1bw+YFLIwWPxtTgyyWBow/fn4Fp0kdb2fxaq/fZxQJXuyUc68w0jiPU7QC5gSoWld9aBR1sbkZxHv72mIQZVXKlOnULAuvlyLeVnOBAABxEwWEo6RFd6U4uOkRYQIehtSeizawTZJjGIkI2ihAFCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783321521; c=relaxed/simple;
	bh=ifp4jrTbWm892emhrD2Jct5nLbBFcW3SW8Hx2KR8+QU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kx5e57ZjRyMiW0EQuDvVbnmzRIXO3hotpcgrShD5kS0ciBi4MGRymyarfGjexXVzogdfTSB/d7Wp+CalvCjV+F2jb8Dqi6c/otVvA721vuubkPXqE6LotPivtxi3joUl25d+2JR6Ao032eCoVlOWKsRwMYzSkbou3aqI3cVIbQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feFpZYt/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feFpZYt/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF3F1F000E9;
	Mon,  6 Jul 2026 07:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783321501;
	bh=pNbrr+7vMT7d+YXsU70gpKCnA0Dr+Mk7HOfp5wCYwZo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=feFpZYt/26Zu6oQDe8KTR4CsOLq8nbovv5veYlAR8oXbRmknryTnI6dTL06QDz2Km
	 4L6h0rGzbcCThuUWIGOgQuketk1b7E8jST5IYWRijP63cHmE20eeT4UbQlbzNyLqaa
	 UeKQac7FEP1jMX+JvUdMlhMBLPaObSXgf5poOROmGxLqeMlOSSHhgzWda0QALdh4Vc
	 xpRJmLCShiOArPmQULLXXNc9bieFXDIpHt691bECXrwOGqFrYZjo5NMrYOFggIxP6P
	 CTaO1Os/viUA2cwscR359cgFmNjbTJ8RMwPqMzDgUzcDaX5qV3cRc1QgSLwdoUew8/
	 94dRKMzW9DAAg==
Message-ID: <f389a101-2af1-4b18-a74b-031e6c1899bd@kernel.org>
Date: Mon, 6 Jul 2026 16:04:48 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: split out a new blk_plug.h helper
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-aio@kvack.org, linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-mm@kvack.org
References: <20260706041125.642097-1-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260706041125.642097-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/6/26 1:11 PM, Christoph Hellwig wrote:
> blkdev.h gets included in various places outside the block layer just
> for struct blk_plug and related plugging functions.
> 
> Split blk_plug into a separate helper to reduce the amount of code
> that needs to get rebuilt when blkdev.h changes and to slightly
> reduce compile times.
> 
> In io_uring this requires pulling in a few other headers explicitly that
> previously were implicitly included through blkdev.h.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

A couple of nits below (not entirely sure if they make sense).
But otherwise looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> diff --git a/include/linux/blk_plug.h b/include/linux/blk_plug.h
> new file mode 100644
> index 000000000000..2ac1265662ad
> --- /dev/null
> +++ b/include/linux/blk_plug.h
> @@ -0,0 +1,95 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_BLK_PLUG_H
> +#define _LINUX_BLK_PLUG_H
> +
> +#include <linux/sched.h>

struct blk_plug_cb has a list_head. So maybe also add

#include <linux/types.h>

?

> +
> +struct blk_plug_cb;

Maybe add "struct request;" here too ?

> +typedef void (*blk_plug_cb_fn)(struct blk_plug_cb *cb, bool from_schedule);
> +
> +struct rq_list {
> +	struct request *head;
> +	struct request *tail;
> +};


-- 
Damien Le Moal
Western Digital Research
