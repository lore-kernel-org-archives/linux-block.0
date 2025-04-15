Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43C5EEA9
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 01:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744681235; cv=none; b=bNuGsJ4cvzC2dXXXmn0j5xMqGe5goDJp0cDFrZZ0RHQZy3ZpKuCWK/pQnubHYONiM6iORa/wkL94TPLzrw2NLr0sc8nWcwfFQfjZwaN6IoUFqVGbMEJtzIo3XodAk25s8uAFBEMYQ2FQGPQNHBK3izbcFd4fQ8cIWzTZJKP6Vu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744681235; c=relaxed/simple;
	bh=waTqZlG5RUrdk/kyX1B3JrEAaqCI6o8Wzn0Eb0H8FxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFnHfsaJWzaQn6S2qjw5ioVluUg25dShZ0Tg3T0F8+aUgKCGLM02lI+BQjBkaOfoLssjvBkzVyoR7VCWhbHuDo31lL1Mx3HEFYxnJmgBNCSMPVP1yP05Eq4o/6IbfVXceIZoqygjFumypDwh1A8NfNqUFkGppu0hfCxlgtUdVQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JKIjm79w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JKIjm79w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744681230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BzJIIGO4h1ov0FNztGZbtQ8RL/hoNax/EvxMwQw1rZA=;
	b=JKIjm79wOR2eC48dnCxbWGYxE8ykAly3vuJRhgRwHNvVOiTIYt3bW9PdF0ddeN/w3L8pYW
	/publv+/xIND17TGDkRQMdzGaOiUT9O6BulQfP+scKN/p5qlOGj4CEF+C3NmeRSP1/ZBBF
	f7VFgfd09oLLqcztfOjANO+kmtD4b/g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-MPbOv-2yNCiT8WkrDukkkw-1; Mon,
 14 Apr 2025 21:40:23 -0400
X-MC-Unique: MPbOv-2yNCiT8WkrDukkkw-1
X-Mimecast-MFC-AGG-ID: MPbOv-2yNCiT8WkrDukkkw_1744681221
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EDCDD1956089;
	Tue, 15 Apr 2025 01:40:20 +0000 (UTC)
Received: from fedora (unknown [10.72.116.40])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 68D041808867;
	Tue, 15 Apr 2025 01:40:17 +0000 (UTC)
Date: Tue, 15 Apr 2025 09:40:12 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH 2/9] ublk: properly serialize all FETCH_REQs
Message-ID: <Z_24_D-uadrycz7i@fedora>
References: <20250414112554.3025113-1-ming.lei@redhat.com>
 <20250414112554.3025113-3-ming.lei@redhat.com>
 <Z/1o946/z43QETPr@dev-ushankar.dev.purestorage.com>
 <dc912318-f649-46bd-8d7b-e5d18b3c45b5@kernel.dk>
 <Z/11q+J0rW6rAJI9@dev-ushankar.dev.purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z/11q+J0rW6rAJI9@dev-ushankar.dev.purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Apr 14, 2025 at 02:52:59PM -0600, Uday Shankar wrote:
> On Mon, Apr 14, 2025 at 02:39:33PM -0600, Jens Axboe wrote:
> > On 4/14/25 1:58 PM, Uday Shankar wrote:
> > > +static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
> > > +		      struct ublk_queue *ubq, struct ublk_io *io,
> > > +		      const struct ublksrv_io_cmd *ub_cmd,
> > > +		      unsigned int issue_flags)
> > > +{
> > > +	int ret = 0;
> > > +
> > > +	if (issue_flags & IO_URING_F_NONBLOCK)
> > > +		return -EAGAIN;
> > > +
> > > +	mutex_lock(&ub->mutex);
> > 
> > This looks like overkill, if we can trylock the mutex that should surely
> > be fine? And I would imagine succeed most of the time, hence making the
> > inline/fastpath fine with F_NONBLOCK?
> 
> Yeah, makes sense. How about this?
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index cdb1543fa4a9..bf4a88cb1413 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1832,8 +1832,8 @@ static void ublk_nosrv_work(struct work_struct *work)
>  
>  /* device can only be started after all IOs are ready */
>  static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
> +	__must_hold(&ub->mutex)
>  {
> -	mutex_lock(&ub->mutex);
>  	ubq->nr_io_ready++;
>  	if (ublk_queue_ready(ubq)) {
>  		ubq->ubq_daemon = current;
> @@ -1845,7 +1845,6 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
>  	}
>  	if (ub->nr_queues_ready == ub->dev_info.nr_hw_queues)
>  		complete_all(&ub->completion);
> -	mutex_unlock(&ub->mutex);
>  }
>  
>  static void ublk_handle_need_get_data(struct ublk_device *ub, int q_id,
> @@ -1929,6 +1928,55 @@ static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
>  	return io_buffer_unregister_bvec(cmd, index, issue_flags);
>  }
>  
> +static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
> +		      struct ublk_queue *ubq, struct ublk_io *io,
> +		      const struct ublksrv_io_cmd *ub_cmd,
> +		      unsigned int issue_flags)
> +{
> +	int ret = 0;
> +
> +	if (!mutex_trylock(&ub->mutex)) {
> +		if (issue_flags & IO_URING_F_NONBLOCK)
> +			return -EAGAIN;
> +		else
> +			mutex_lock(&ub->mutex);

Thinking of further, looks ub->mutex has been fat enough, here we can
use ub->lock(spin lock) to serialize the setup, then trylock & -EAGAIN
can be avoided.

It is fine to replace the mutex in ublk_mark_io_ready() with spinlock
actually.



Thanks,
Ming

