Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBFF17799F
	for <linux-block@vger.kernel.org>; Mon,  6 Jan 2025 03:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736134324; cv=none; b=MGrGlXFNkb4n5DSuVYVmGd5dRleywiweCd3CHBdN96yLAQby+QBi4nHd79KhXy/IyTDT6j4ST0FZO4dUwZexMXRby6Nmc2qydgZVLASSy/1Hod0XcQqUGspOTFNK8pbOAS809FDdUa9Gc6I/ntCDAI3i3ruh7LTdfQhPrV2kDiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736134324; c=relaxed/simple;
	bh=9MJ0wURY77/qeXCTxvVjqe9VGB2y46cdneWDkp2vif8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CARIjfaP5UaOUlBjNlK0U9I/52YJP+yO05/rDoNHPS6D2JM7p6sNOT5ZZOLNLStrp2PylEBaqUfXyxMzfQ5VUx6fJDst7Xm4yz3t1AOF9OcUNaxQ+eRqkPhAvDVsZgDVZkS7hAutbNGZFedKcEFTwZSPG515iIF186OURYj8+NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G9SiMht5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G9SiMht5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736134319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wP7jolLUYxTGQVKFJKvtxIhzzFzEDzKghI1l/9u+ocU=;
	b=G9SiMht5ZJKXsVD5OXHoVCpPLxQOe3neS+EzD+i9Vk0glL5KiWcSd2da7KasgGNqihauwG
	7O9uzhJcBVa6n/hMSSsqPh1CLZIBd5HULMlIJDPoUtSqKlG4mRbSkadY1Jy20edpVgK0Ga
	Q62Wt+wDbHsF0ok/PLJBnkzfxNp/Cf0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-KcX282JuPk29GhOFRtX-TA-1; Sun,
 05 Jan 2025 22:31:57 -0500
X-MC-Unique: KcX282JuPk29GhOFRtX-TA-1
X-Mimecast-MFC-AGG-ID: KcX282JuPk29GhOFRtX-TA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 002351956053;
	Mon,  6 Jan 2025 03:31:55 +0000 (UTC)
Received: from fedora (unknown [10.72.116.65])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 630951956056;
	Mon,  6 Jan 2025 03:31:48 +0000 (UTC)
Date: Mon, 6 Jan 2025 11:31:43 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH 1/3] block: Fix sysfs queue freeze and limits lock order
Message-ID: <Z3tOn4C5i096owJc@fedora>
References: <20250104132522.247376-1-dlemoal@kernel.org>
 <20250104132522.247376-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250104132522.247376-2-dlemoal@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Sat, Jan 04, 2025 at 10:25:20PM +0900, Damien Le Moal wrote:
> queue_attr_store() always freezes a device queue before calling the
> attribute store operation. For attributes that control queue limits, the
> store operation will also lock the queue limits with a call to
> queue_limits_start_update(). However, some drivers (e.g. SCSI sd) may
> need to issue commands to a device to obtain limit values from the
> hardware with the queue limits locked. This creates a potential ABBA
> deadlock situation if a user attempts to modify a limit (thus freezing
> the device queue) while the device driver starts a revalidation of the
> device queue limits.
> 
> Avoid such deadlock by introducing the ->store_limit() operation in
> struct queue_sysfs_entry and use this operation for all attributes that
> modify the device queue limits through the QUEUE_RW_LIMIT_ENTRY() macro
> definition. queue_attr_store() is modified to call the ->store_limit()
> operation (if it is defined) without the device queue frozen. The device
> queue freeze for attributes defining the ->stor_limit() operation is
> moved to after the operation completes and is done only around the call
> to queue_limits_commit_update().
> 
> Cc: stable@vger.kernel.org # v6.9+
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  block/blk-sysfs.c | 123 ++++++++++++++++++++++++----------------------
>  1 file changed, 64 insertions(+), 59 deletions(-)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 767598e719ab..4fc0020c73a5 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -24,6 +24,8 @@ struct queue_sysfs_entry {
>  	struct attribute attr;
>  	ssize_t (*show)(struct gendisk *disk, char *page);
>  	ssize_t (*store)(struct gendisk *disk, const char *page, size_t count);
> +	ssize_t (*store_limit)(struct gendisk *disk, struct queue_limits *lim,
> +			       const char *page, size_t count);

As I mentioned in another thread, freezing queue may not be needed in
->store(), so let's discuss and confirm if it is needed here first.

https://lore.kernel.org/linux-block/Z3tHozKiUqWr7gjO@fedora/

Also even though freeze is needed, I'd suggest to move freeze in each
.store() callback for simplifying & avoiding regression.


Thanks,
Ming

