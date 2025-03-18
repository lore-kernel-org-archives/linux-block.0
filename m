Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B2A35959
	for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 01:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742260050; cv=none; b=iem/7fOUJImPb22GrxI3DnPx/X9ge0di+7ZjKq019IQGv0yBHzacaC9tow9WjYCSrN6LEe7Z7BLkn1pYmAtYdfM7Kq+3gldUxaYkya9I+UcBA7JNzOoGfs2YQspxg8JnLjf4irt0lSbzE6A33lCzbk6ZWGu1zkT959qQ6f8LP9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742260050; c=relaxed/simple;
	bh=b7P9Fd7J8Oq7imp6BOMg1r8JixErTV6ac/gxVbdenUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxR2UY9tMs+eqDYgIjyyjYLiO1HjplpAk8NfLStvvsdry/jLaErCFlTo7cwcDb5wVR0dzh2NGxMywe42xIuVDyg0rZuaKCeDJuyLacuSCRqsoSHmv4e/I5Ar6cQJlUI6Vk0A9JGXQh+HcrNRmF6zHMni44ZyK9/i+Hgt2sYmPF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RLW/gSl4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLW/gSl4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742260046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tkm0XG0V9d/xGYmAi0Xr+GJvPBP3zXwUpMAb+ttTy2g=;
	b=RLW/gSl4JbiTcYwiRakyV03xjGPx+L7IXBEzWMlT/Ew+ziDurPn5d8iuiNCXMvLGIIXiLX
	o6BQcD6wElyPCkN7QxpYh4NivEK8TpfqY9hMvq/ui/uSQxBKInX4oI1ZePKsZOssttjssA
	AKlcZJ47RKUQrbcoMWrHj9gevqN7C8I=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-jsNAR5zhP5iiOhXEphYBaw-1; Mon,
 17 Mar 2025 21:07:23 -0400
X-MC-Unique: jsNAR5zhP5iiOhXEphYBaw-1
X-Mimecast-MFC-AGG-ID: jsNAR5zhP5iiOhXEphYBaw_1742260042
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F34611955DCC;
	Tue, 18 Mar 2025 01:07:21 +0000 (UTC)
Received: from fedora (unknown [10.72.120.14])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B326A180174E;
	Tue, 18 Mar 2025 01:07:16 +0000 (UTC)
Date: Tue, 18 Mar 2025 09:07:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: =?utf-8?B?6IOh54Sc?= <huk23@m.fudan.edu.cn>
Cc: linux-block <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	=?utf-8?B?6KaD5L2z5Z+6?= <jjtan24@m.fudan.edu.cn>
Subject: Re: [PATCH] loop: move vfs_fsync() out of loop_update_dio()
Message-ID: <Z9jHP7lFB5jVZELN@fedora>
References: <20250113120644.811886-1-ming.lei@redhat.com>
 <tencent_569A521D2FECE6C55D795124@qq.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_569A521D2FECE6C55D795124@qq.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Mar 17, 2025 at 04:52:16PM +0800, 胡焜 wrote:
> > drivers/block/loop.c | 12 ++++++------
> > 1 file changed, 6 insertions(+), 6 deletions(-)
> 
> > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > index 1ec7417c7f00..be7e20064427 100644
> > --- a/drivers/block/loop.c
> > +++ b/drivers/block/loop.c
> > @@ -205,8 +205,6 @@ static bool lo_can_use_dio(struct loop_device *lo)
> > */
> >  static inline void loop_update_dio(struct loop_device *lo)
> >  {
> > - bool dio_in_use = lo->lo_flags & LO_FLAGS_DIRECT_IO;
> > -
> >   lockdep_assert_held(&lo->lo_mutex);
> >   WARN_ON_ONCE(lo->lo_state == Lo_bound &&
> >        lo->lo_queue->mq_freeze_depth == 0);
> > @@ -215,10 +213,6 @@ static inline void loop_update_dio(struct loop_device *lo)
> >   lo->lo_flags |= LO_FLAGS_DIRECT_IO;
> >   if ((lo->lo_flags & LO_FLAGS_DIRECT_IO) && !lo_can_use_dio(lo))
> >   lo->lo_flags &= ~LO_FLAGS_DIRECT_IO;
> > -
> > - /* flush dirty pages before starting to issue direct I/O */
> > - if ((lo->lo_flags & LO_FLAGS_DIRECT_IO) && !dio_in_use)
> > - vfs_fsync(lo->lo_backing_file, 0);
> >  }
> >  
> >  /**
> > @@ -621,6 +615,9 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
> >   if (get_loop_size(lo, file) != get_loop_size(lo, old_file))
> >  goto out_err;
>  
> > + /* may work in dio, so flush page cache for avoiding race */
> > + vfs_fsync(file, 0);
> > +
> >   /* and ... switch */
> >   disk_force_media_change(lo->lo_disk);
> >   blk_mq_freeze_queue(lo->lo_queue);
> > @@ -1098,6 +1095,9 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
> >   if (error)
> >   goto out_unlock;
>  
> > + /* may work in dio, so flush page cache for avoiding race */
> > + vfs_fsync(file, 0);
> > +
> >   loop_update_dio(lo);
> >   loop_sysfs_init(lo);
> >  
> > --
> > 2.44.0
> 
> 
> Hello Ming,
> 
> I would like to double check that this fix doesn't seem to have been merged into the main thread, will this version still be merged into mainline kernel tree?

The V2 has been sent out after updating comment, please verify if it fixes your issue:

https://lore.kernel.org/linux-block/20250318010318.3861682-1-ming.lei@redhat.com/

If yes, feel free to provide one tested-by for moving on.


Thanks, 
Ming

