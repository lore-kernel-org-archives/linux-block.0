Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BA320694F
	for <linux-block@vger.kernel.org>; Wed, 16 Oct 2024 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729077005; cv=none; b=hD9s/a1EjyPOYelBXRqPvanSU4mIEHDVBAwxAAQ73WKz56m8lQCjSnO4C3SNAbZPUy/r37bvTBgyPkqkCiuK/RC5h1DB0AZMYNPuy/AuPVOsJw3M0YeRhOMawWzoiKCQMjGu3vVzeFrGmsjPiTQ36P4jHpENcofyNqEVjMD+RA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729077005; c=relaxed/simple;
	bh=JOvznjdwsLSo4/sL3eqKP6ezcffmjM+8OknSWm6ouUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPrdJDR/MtrIN6y7DGbIGWi7XI5P73krRW7zVfetJIgTew1zTsWyhZGKB79D/awmLZ4eyTpSd5NX0cpjHg1DAigRV+db6kqUWLTuuJdEdXhkOeoky6aQygpQZWu5ycvAnzH8avAWX/Lv/lMhoZFwZBYwlyK3enaCNz+V3gEM7Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SQ99fPX1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQ99fPX1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729077003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yY8czTw0atJ2kY+lxbeGshgj4CTRoWHqolYYWlHXoJU=;
	b=SQ99fPX1lVugWCLdnJV2sOxYc+4lsC8TB9IgcYYdhafievkoYd2jZhRaXrUaQ3zuxoFVMy
	KTfiEFlFNos8Kt3r1kK8CKaJTUuV9wOSl4ojuqyBkw1V2Ik0vBmTN5qyDVJ6D3qPdSxmIZ
	ubO68ez4sD7VNQBB21XAYmXUQx/59lo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-hSgBnnVmNJSOJtcZoopS8w-1; Wed,
 16 Oct 2024 07:10:00 -0400
X-MC-Unique: hSgBnnVmNJSOJtcZoopS8w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 806C919560BD;
	Wed, 16 Oct 2024 11:09:58 +0000 (UTC)
Received: from fedora (unknown [10.72.116.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 70BED3000198;
	Wed, 16 Oct 2024 11:09:53 +0000 (UTC)
Date: Wed, 16 Oct 2024 19:09:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	YangYang <yang.yang@vivo.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: also mark disk-owned queues as dying in
 __blk_mark_disk_dead
Message-ID: <Zw-e_CtNKeLJ3q1a@fedora>
References: <20241009113831.557606-1-hch@lst.de>
 <20241009113831.557606-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009113831.557606-2-hch@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Oct 09, 2024 at 01:38:20PM +0200, Christoph Hellwig wrote:
> When del_gendisk shuts down access to a gendisk, it could lead to a
> deadlock with sd or, which try to submit passthrough SCSI commands from
> their ->release method under open_mutex.  The submission can be blocked
> in blk_enter_queue while del_gendisk can't get to actually telling them
> top stop and wake them up.
> 
> As the disk is going away there is no real point in sending these
> commands, but we have no really good way to distinguish between the
> cases.  For now mark even standalone (aka SCSI queues) as dying in
> del_gendisk to avoid this deadlock, but the real fix will be to split
> freeing a disk from freezing a queue for not disk associated requests.
> 
> Reported-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  block/genhd.c          | 16 ++++++++++++++--
>  include/linux/blkdev.h |  1 +
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 1c05dd4c6980b5..7026569fa8a0be 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -589,8 +589,16 @@ static void __blk_mark_disk_dead(struct gendisk *disk)
>  	if (test_and_set_bit(GD_DEAD, &disk->state))
>  		return;
>  
> -	if (test_bit(GD_OWNS_QUEUE, &disk->state))
> -		blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue);
> +	/*
> +	 * Also mark the disk dead if it is not owned by the gendisk.  This
> +	 * means we can't allow /dev/sg passthrough or SCSI internal commands
> +	 * while unbinding a ULP.  That is more than just a bit ugly, but until
> +	 * we untangle q_usage_counter into one owned by the disk and one owned
> +	 * by the queue this is as good as it gets.  The flag will be cleared
> +	 * at the end of del_gendisk if it wasn't set before.
> +	 */
> +	if (!test_and_set_bit(QUEUE_FLAG_DYING, &disk->queue->queue_flags))
> +		set_bit(QUEUE_FLAG_RESURRECT, &disk->queue->queue_flags);

Setting QUEUE_FLAG_DYING may fail passthrough request for
!GD_OWNS_QUEUE, I guess this may cause SCSI regression.

blk_queue_enter() need to wait until RESURRECT & DYING are cleared
instead of returning failure.


Thanks, 
Ming

