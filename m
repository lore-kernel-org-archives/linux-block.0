Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF59D44BC8E;
	Fri, 22 May 2026 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459884; cv=none; b=Obj1fOCy9SUVGQY9Iu5quOQbnDt23fZdDU2E6MDujZcChuC3x8XFBTcVypxF81z9IXthANWLXgGX2St3/+ciXVvoZGqKlpbhat9zYVg+ZwrMxC1fscXMzWqA9en0fdz27y622iTC7l9005AdFUw6tvqZbC2payXu84IDlNFn+hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459884; c=relaxed/simple;
	bh=kOs0WeeU0vK37cftBvd9VdOjhLmMpzYFgvCOili39fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAGs4hMMm6UdxiMKvDlDRw7nw68gM1HBs6KDy018nGzBwEQCMpioGhX5ahdvK7uUIyg4abWMr04Lrv1dO8jCN/q8DTZATS26tRUbk+YwpHHXEQhJBc2QZgRQfCCGhtIDnr40ms8ugGg/ILGs9kID62+bwc66e48Sc+R83tyje1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIWX0QRi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIWX0QRi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0C91F000E9;
	Fri, 22 May 2026 14:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779459883;
	bh=ixVrd5gknFDvPxB2WaVss+uYQDPFOFaGCE4a0HV+7QM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EIWX0QRiwOL/Flqf5S4cGk71k5qKmg6s+El+yjedon2rp0USE2ohhs9xGJIoOTgyr
	 yKpjI5lZHFPJY2yFtcpVBam2+C2aD769dqwCvLqLcjYzgAB9Sq1Vyhii8GcHKgf8nc
	 DaM1Lv3d8wbimXubiGE+a8pYNx15ylDKn2XXztMgMUkgPT5atJ9jkntE6itPFEmOt4
	 G8bWhP7uS1M2H7dcKPFvNZlDZJotE6x78bC/FPWE2thNuEASGdEfG12ieOdadca4op
	 +RAAn4k5MQAzFMy8uPF+Keat1Jzd+1PKsBDfa6h+8nVJllnlBUlK6lFZsD+d2KOJrV
	 hbP5cOSNZ9ZRQ==
Date: Fri, 22 May 2026 08:24:41 -0600
From: Keith Busch <kbusch@kernel.org>
To: Tang Yizhou <yizhou.tang@shopee.com>
Cc: axboe@kernel.dk, hch@lst.de, yukuai@fnnas.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Hwang <leon.huangfu@shopee.com>
Subject: Re: [PATCH v5] block: propagate in_flight to whole disk on partition
 I/O
Message-ID: <ahBnKR-IunwxVDzg@kbusch-mbp>
References: <20260522141638.298530-1-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522141638.298530-1-yizhou.tang@shopee.com>

On Fri, May 22, 2026 at 10:16:38PM +0800, Tang Yizhou wrote:
> @@ -1073,7 +1073,7 @@ void bdev_end_io_acct(struct block_device *bdev, enum req_op op,
>  	part_stat_inc(bdev, ios[sgrp]);
>  	part_stat_add(bdev, sectors[sgrp], sectors);
>  	part_stat_add(bdev, nsecs[sgrp], jiffies_to_nsecs(duration));
> -	part_stat_local_dec(bdev, in_flight[op_is_write(op)]);
> +	bdev_inc_in_flight(bdev, op);

This one should be bdev_dec_in_flight().
