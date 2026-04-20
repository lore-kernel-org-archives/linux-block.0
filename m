Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92FE1DF256;
	Mon, 20 Apr 2026 02:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776653547; cv=none; b=k0egUBbRveEB/oXcEu9KUHCDgBc07ExHZX/Y3cbjBUNiZDOlNu9BDL6NnnrixNJRPyV3t3nLQ+WaymVK153Z3MYn+uY9byCl1w+qJxZE7ZHeFJLpzAzUIorlSC7o3HyeXP5KCGwXT4yv4tnN6tUIVGnmYRJgJ5btOH9W1OkefH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776653547; c=relaxed/simple;
	bh=/6UN8C/UXvxDOrHXifdAQZlfYOXknoihB++HUFwMKng=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dsmm/9LCF2JPSSxva3KazRhRqRdUYq4/FCEvRQwb7OJrIzxHPPMQZKr4mezkW3qoU1tdbb27k/FhokURXudqkQAvF8rdARxJqJdySUdiGu/4RpPkiSwe3KFLD4Xm3YeFGTLx3vHiwx2E1GCRFTMjxpiW/TLBFlmhmEruJnG15j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=EE/KdQWY; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="EE/KdQWY"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=pSkADprham3IfWnGZmeVtnz2GCNjnW9T5Kyx6Lvi8/E=;
	b=EE/KdQWYGK+GrA9xlm69kMW4y5/8xh/cEGM01x2urv5YJ3UxHT9UKJv5CSDQ3hNCSVxQisaMj
	AFYuql0BKK0/vHv9/Yn+Bs6HXjtDEAGhD1KMwc4EZlnvUA6aKHaDRhson1DWaTqM8DRHJuoK0lG
	w5IC6WRnddc1NGN7OblkDkc=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fzVGt0Nd7zKm4w;
	Mon, 20 Apr 2026 10:45:58 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 2D0224056E;
	Mon, 20 Apr 2026 10:52:21 +0800 (CST)
Received: from kwepemn100013.china.huawei.com (7.202.194.116) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Apr 2026 10:52:21 +0800
Received: from localhost (10.50.85.155) by kwepemn100013.china.huawei.com
 (7.202.194.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 20 Apr
 2026 10:52:20 +0800
Date: Mon, 20 Apr 2026 10:46:21 +0800
From: Long Li <leo.lilong@huawei.com>
To: <leo.lilong@huaweicloud.com>, <josef@toxicpanda.com>, <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <lonuxli.64@gmail.com>
Subject: Re: [PATCH 0/4] nbd: replace socks pointer array with xarray to
 eliminate queue freeze
Message-ID: <aeWTfZ5G5lXT9lZo@localhost.localdomain>
References: <20260327091223.4147956-1-leo.lilong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260327091223.4147956-1-leo.lilong@huaweicloud.com>
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemn100013.china.huawei.com (7.202.194.116)

On Fri, Mar 27, 2026 at 05:12:19PM +0800, leo.lilong@huaweicloud.com wrote:
> From: Long Li <leo.lilong@huawei.com>
> 
> Hi,
> 
> Commit b98e762e3d ("nbd: freeze the queue while we're adding
> connections") introduced blk_mq_freeze_queue() in the add-socket path
> to prevent use-after-free when krealloc() relocates the config->socks
> array while I/O is in flight. However, freezing the queue on every
> connection setup introduces significant latency when establishing a
> large number of connections.
> 
> This series eliminates the queue freeze by replacing the
> krealloc-based struct nbd_sock **socks array with a struct xarray.
> The xarray provides RCU-safe pointer publishing: each nbd_sock is
> fully initialized before being stored via xa_store(), and concurrent
> readers access individual entries through xa_load() without ever
> holding a reference to the array itself. This removes the possibility
> of UAF on array reallocation, making the queue freeze unnecessary.
> 
> The following test was performed with 256 connections on a local
> nbd-server:
> 
>   nbd-server -M 256 -C /etc/nbd-server/config
>   time nbd-client 127.0.0.1 10809 /dev/nbd0 -N myexport -C 256
> 
>   Before:  real 4.510s  user 0.004s  sys 0.038s
>   After:   real 0.263s  user 0.009s  sys 0.032s
> 
> Connection setup time is reduced by ~94%.
> 
> Long Li (4):
>   nbd: simplify find_fallback() by removing redundant logic
>   nbd: replace socks pointer array with xarray
>   nbd: remove redundant num_connections boundary checks
>   nbd: remove queue freeze in nbd_add_socket
> 
>  drivers/block/nbd.c | 201 +++++++++++++++++++++++---------------------
>  1 file changed, 106 insertions(+), 95 deletions(-)
> 
> -- 
> 2.39.2
> 

Friendly ping ...
