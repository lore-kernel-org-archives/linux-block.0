Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78E8FC0A
	for <linux-block@vger.kernel.org>; Fri,  7 Jun 2024 14:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717768976; cv=none; b=TuKqFLIL9jMQFGf2TsBMShUjbKWoSR5OAfcWunLsvA4utzBC6euVNTjJtZnlVd3qFNlGov3w+5ygfFPI3cJ2cyTCsnRZGJnu1f0BWuVixVCgOF4Igds6tNDOcheRYlfUewHf8F08ulvNMn/KLCY/ZN2SrDZpDpK/pbM9QN5uX0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717768976; c=relaxed/simple;
	bh=8tA4wyXAT2G3tDDNWQiVRLl7HjY+NQtI84cnBHQExps=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rgq55S9Mak9RJQO/RQQRcKO61GWiTC36W7vV2Kct1OTqnlcll5sKdh4YgBJrvalDf7qbJu1N4tJCntLhNQkshmmRG6cA8Rfc0UqZT3741d9psKSTKShNxHaqel8DIheC6xJTkObwDnZAeBl2uKgUdTP5nflBzYMe8+xXjgWvsRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MkMgEPss; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MkMgEPss"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717768973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w2QX6e423Zf7VWbOz8epWMjaNQmuJAw2GsMmG09nLyA=;
	b=MkMgEPssBb1ZGV/v8QB29pWsP8s+z1CE4xJRTzZQKUm+jBe5MnkzufmMMOTimfR50kd0xj
	WFY6zedd941Rw3Vw/el7RUnE38SWlCkBufQwInjRrAZVGYfXd5rUaDaLDWZQPjT9Zb9Rlv
	pxmxe+Lxe/m+wQjgq0K4vwZbTMq1PW8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-P6V6W6KTMwq713TISEg_3g-1; Fri,
 07 Jun 2024 10:02:50 -0400
X-MC-Unique: P6V6W6KTMwq713TISEg_3g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2CA03C025AC;
	Fri,  7 Jun 2024 14:02:49 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DB0923C23;
	Fri,  7 Jun 2024 14:02:49 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id A0C5230C03D6; Fri,  7 Jun 2024 14:02:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 9C9223FB52;
	Fri,  7 Jun 2024 16:02:49 +0200 (CEST)
Date: Fri, 7 Jun 2024 16:02:49 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>
cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
    dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH] block: Optimize disk zone resource cleanup
In-Reply-To: <20240607002126.104227-1-dlemoal@kernel.org>
Message-ID: <d6225ee1-3ed5-7e8a-31b8-1aafdb8a30a7@redhat.com>
References: <20240607002126.104227-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1



On Fri, 7 Jun 2024, Damien Le Moal wrote:

> For zoned block devices using zone write plugging, an rcu_barrier() call
> is needed in disk_free_zone_resources() to synchronize freeing of zone
> write plugs and the destrution of the mempool used to allocate the
> plugs. The barrier call does slow down a little teardown of zoned block
> devices but should not affect teardown of regular block devices or zoned
> block devices that do not use zone write plugging (e.g. zoned DM devices
> that do not require zone append emulation).
> 
> Modify disk_free_zone_resources() to return early if we do not have a
> mempool to start with, that is, if the device does not use zone write
> plugging. This avoids the costly rcu_barrier() and speeds up disk
> teardown.
> 
> Reported-by: Mikulas Patocka <mpatocka@redhat.com>
> Fixes: dd291d77cc90 ("block: Introduce zone write plugging")
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

This works.

Tested-by: Mikulas Patocka <mpatocka@redhat.com>


BTW. when we remove large number of DM devices, the process spends a lot 
of time sleeping with this stacktrace:

__schedule+0x242/0x600
schedule+0x21/0xd0
blk_mq_freeze_queue_wait+0x55/0x90
? __wake_up+0x50/0x50
del_gendisk+0x1fc/0x320
cleanup_mapped_device+0x16c/0x180 [dm_mod]
__dm_destroy+0x145/0x1f0 [dm_mod]
dm_hash_remove_all+0x5c/0x180 [dm_mod]
? dm_hash_remove_all+0x180/0x180 [dm_mod]
remove_all+0x1a/0x30 [dm_mod]
ctl_ioctl+0x1bb/0x500 [dm_mod]
dm_compat_ctl_ioctl+0x7/0x10 [dm_mod]
__x64_compat_sys_ioctl+0x133/0x160
do_syscall_64+0x17c/0x1a0
entry_SYSCALL_64_after_hwframe+0x4b/0x53

Is there some way how to remove this wait?

Mikulas

> ---
>  block/blk-zoned.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 8f89705f5e1c..137842dbb59a 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -1552,6 +1552,9 @@ static void disk_destroy_zone_wplugs_hash_table(struct gendisk *disk)
>  
>  void disk_free_zone_resources(struct gendisk *disk)
>  {
> +	if (!disk->zone_wplugs_pool)
> +		return;
> +
>  	cancel_work_sync(&disk->zone_wplugs_work);
>  
>  	if (disk->zone_wplugs_wq) {
> -- 
> 2.45.2
> 

