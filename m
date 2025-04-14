Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64FC19048A
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 20:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744661744; cv=none; b=Q4fKVdCJa7qp4DnNNl2o1hi54ccwFElXu4zIGHHH9KxDBJEXxG+habSds2vtSnqXQFejIMl5xq7Tu4Til5HoHd1JljrQ/JJt5g0u4g4xSeakjjgBFzSz5i1SXjr3b4tx8DQYr8cBaLoxcq9rCW3Uu+pPfLVISwWY5E1/YLUt9qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744661744; c=relaxed/simple;
	bh=a2F4vc06fsjIcru1iOWjb+iwMav7aeAYvIbvz1kYQ+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=to1KxyJPZf4X057PSvEY3ChgEf5cuGfS/1aPyRDfDyqvY7IMROvXQ9Lp8Phlf1dijjsqP+qUd0Yb4JUFgP6pa31LyBub1A1VB/98MKMwkLe92jCWF229PTPPvjTmeNN/v4nfOpdXEPIlIulz7zSoLZjA/mnsKJmp0y9oh431k+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bwjXSALN; arc=none smtp.client-ip=209.85.215.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bwjXSALN"
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-af52a624283so3910558a12.0
        for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 13:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744661741; x=1745266541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=chiCyp04MTsy4Zct58Un0vP6wwp7I2DaVM8OGEIK198=;
        b=bwjXSALNQ1MALo7Sj4WXVcs5nWtxnjPxyFrAETypVhOGPFlcNHaSLJVptjS8Cs4dOC
         RyUKG9pYIEt4YCqtVchikb0QXN4g4k6Ba/oEX3kXQThV7+svm01JuRleS7KeCUprSMe7
         vKD1yOjXc9v9cqbQpES3VY3EyKcKVBio9HTlM4onXDygi7pQH5K7FNHfVcR8DR20oLIZ
         Fq+3cQsfCqPWR2CP4e08vMmdmggRrkqqfgJr+L7ARm8VDQG8VLKiCkEdLMStdzpjcp3r
         SKtEfNxcyM0/beFYxv3Z7k3xyI6qfrSVSpRTs74iWUPjHBE6V7F+Bzn8rKQr5MpITJj8
         8gsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744661741; x=1745266541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chiCyp04MTsy4Zct58Un0vP6wwp7I2DaVM8OGEIK198=;
        b=U86zJHSbgVTWT5c3YNiLd5aX5T3WQ/JRSe3co/99DpbO4k0IXyFnQ18cx6zNrv95tr
         JIASn9s5JQN4cJzVeX5PH8Tz5bIRryi1xgjtSr6hc4ZVvTu5eAouzzsGDLW6jIUpHfLa
         0qlmDZVizDqp2vwkvmtEdp7YFKYdlWfDqD0sfYVop50YULumE3YdAujgqfmdC3EfYyeO
         nkATMgsQth/WY0hQsE9K94uDf+dogWZwWEHzSU2jZFwvkq1O+V4+MAXXJDwhKCVl2ZYZ
         MsPvxSoue/ompKYzyOrCQAm71mMr2SLtexAcrsamRwvMZc45+8+3VxzZ1ao2A1+fBAre
         dAXg==
X-Forwarded-Encrypted: i=1; AJvYcCX+PUxHuTsL06PV0yW0odJgMuctkl66Z33WMYn1PHhlIHw/8qfjfjeiLAcwYsuiwEVukySFRgzHXngeKw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2I3OgcCNsuadcmSvWhBd45Rm1IAMLi8gyjLdonTHULF6pN03r
	LxCnT4szcEVDvrlDxzm5Tk5ygPsC1au3JzxlXbPb1xkdhobIM8ugRedznqDKhUVSoMnEs005P11
	C4e0ok+gwBPmzvz+v7kEbknMF+cBnmBQFvL8VyL+EehmJ9st6
X-Gm-Gg: ASbGncvJeyTf4qU+yo2tM98O+a5PMKjCmxkt1MC+Yifkp87mqFt2r+K0oZ6dJAskZ5l
	oNcyQID1ilv2jN2vs3CuIDJLvpsaUTF2hL66YeyyGRJPHK+7JeqMd974asn2T9Xt9HLQyx+IRPu
	Fu6nDcy7UVuJV00/tk5j0RC7GSMrIDUhTIYuusnnJl6Ym/o0hewBEQw7pRvSzSt1dCbw/k+XCcW
	qEoZvc8uSP1Te5lsxd7+vBIJc3tbQCZyeZrYK3RKr42BoPwErqgYYpdXZEIghTO0qeGqiuJ5/GX
	XnAZ+vW7laoY23XM7LVXrRDKKlWVmBE=
X-Google-Smtp-Source: AGHT+IGOgYRQ/5ogTCGX+T+whPeUtWY/7I/fulKyRWwMZl3Ikeb+PTxhHQXVtFiABibZV9r3qjwLJafsrSho
X-Received: by 2002:a17:90b:3cd0:b0:2fa:603e:905c with SMTP id 98e67ed59e1d1-3084f2fbd02mr951382a91.2.1744661740721;
        Mon, 14 Apr 2025 13:15:40 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-306def5df2dsm883901a91.0.2025.04.14.13.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 13:15:40 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E57EB3401C3;
	Mon, 14 Apr 2025 14:15:39 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id A1905E402BD; Mon, 14 Apr 2025 14:15:39 -0600 (MDT)
Date: Mon, 14 Apr 2025 14:15:39 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH 4/9] ublk: rely on ->canceling for dealing with
 ublk_nosrv_dev_should_queue_io
Message-ID: <Z/1s63BGwt3rySq0@dev-ushankar.dev.purestorage.com>
References: <20250414112554.3025113-1-ming.lei@redhat.com>
 <20250414112554.3025113-5-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414112554.3025113-5-ming.lei@redhat.com>

On Mon, Apr 14, 2025 at 07:25:45PM +0800, Ming Lei wrote:
> Now ublk deals with ublk_nosrv_dev_should_queue_io() by keeping request
> queue as quiesced. This way is fragile because queue quiesce crosses syscalls
> or process contexts.
> 
> Switch to rely on ubq->canceling for dealing with ublk_nosrv_dev_should_queue_io(),
> because it has been used for this purpose during io_uring context exiting, and it
> can be reused before recovering too.
> 
> Meantime we have to move reset of ubq->canceling from ublk_ctrl_end_recovery() to
> ublk_ctrl_end_recovery(), when IO handling can be recovered completely.

First one here should be ublk_ctrl_start_recovery or ublk_queue_reinit

> 
> Then blk_mq_quiesce_queue() and blk_mq_unquiesce_queue() are always used
> in same context.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 7e2c4084c243..e0213222e3cf 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1734,13 +1734,19 @@ static void ublk_wait_tagset_rqs_idle(struct ublk_device *ub)
>  
>  static void __ublk_quiesce_dev(struct ublk_device *ub)
>  {
> +	int i;
> +
>  	pr_devel("%s: quiesce ub: dev_id %d state %s\n",
>  			__func__, ub->dev_info.dev_id,
>  			ub->dev_info.state == UBLK_S_DEV_LIVE ?
>  			"LIVE" : "QUIESCED");
>  	blk_mq_quiesce_queue(ub->ub_disk->queue);
> +	/* mark every queue as canceling */
> +	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
> +		ublk_get_queue(ub, i)->canceling = true;
>  	ublk_wait_tagset_rqs_idle(ub);
>  	ub->dev_info.state = UBLK_S_DEV_QUIESCED;
> +	blk_mq_unquiesce_queue(ub->ub_disk->queue);

So the queue is not actually quiesced when we are in UBLK_S_DEV_QUIESCED
anymore, and we rely on __ublk_abort_rq to requeue I/O submitted in this
QUIESCED state. This requeued I/O will immediately resubmit, right?
Isn't this a waste of CPU?

>  }
>  
>  static void ublk_force_abort_dev(struct ublk_device *ub)
> @@ -2950,7 +2956,6 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
>  	/* We have to reset it to NULL, otherwise ub won't accept new FETCH_REQ */
>  	ubq->ubq_daemon = NULL;
>  	ubq->timeout = false;
> -	ubq->canceling = false;
>  
>  	for (i = 0; i < ubq->q_depth; i++) {
>  		struct ublk_io *io = &ubq->ios[i];
> @@ -3037,20 +3042,18 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
>  	pr_devel("%s: new ublksrv_pid %d, dev id %d\n",
>  			__func__, ublksrv_pid, header->dev_id);
>  
> -	if (ublk_nosrv_dev_should_queue_io(ub)) {
> -		ub->dev_info.state = UBLK_S_DEV_LIVE;
> -		blk_mq_unquiesce_queue(ub->ub_disk->queue);
> -		pr_devel("%s: queue unquiesced, dev id %d.\n",
> -				__func__, header->dev_id);
> -		blk_mq_kick_requeue_list(ub->ub_disk->queue);
> -	} else {
> -		blk_mq_quiesce_queue(ub->ub_disk->queue);
> -		ub->dev_info.state = UBLK_S_DEV_LIVE;
> -		for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
> -			ublk_get_queue(ub, i)->fail_io = false;
> -		}
> -		blk_mq_unquiesce_queue(ub->ub_disk->queue);
> +	blk_mq_quiesce_queue(ub->ub_disk->queue);
> +	ub->dev_info.state = UBLK_S_DEV_LIVE;
> +	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
> +		struct ublk_queue *ubq = ublk_get_queue(ub, i);
> +
> +		ubq->canceling = false;
> +		ubq->fail_io = false;
>  	}
> +	blk_mq_unquiesce_queue(ub->ub_disk->queue);
> +	pr_devel("%s: queue unquiesced, dev id %d.\n",
> +			__func__, header->dev_id);
> +	blk_mq_kick_requeue_list(ub->ub_disk->queue);
>  
>  	ret = 0;
>   out_unlock:
> -- 
> 2.47.0
> 
