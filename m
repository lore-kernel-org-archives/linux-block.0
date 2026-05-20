Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE1032B9A8
	for <linux-block@vger.kernel.org>; Wed, 20 May 2026 03:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779246419; cv=none; b=lvn8OUVSm3vUsLeCgW2LFfvF8w398mF/P4Ix+6vVkCqvTa1dxiOdgkHsys4J686LgvvBUIT9Z10qb/KxrCUbA1Biw2JSIjEgiMm26st7lXDgxlRdfS4G4i1xCxQKEazdPHOehV7nhFcCs1YTHWuZO+je2p/BLRd8Py4vUBv/pMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779246419; c=relaxed/simple;
	bh=09n8hah+N4ZBTDdK9+URDQ5v1kM6v5jDI7553ZxU6P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKJY4uiuQm/YdcmmtQe4JqvM7zeL936a72DlgMCKSlxVMmAatYqqed05fuZs01wNcDEce5rolTRWWoM5tYmwRiQ7AASmfx7/6O3bTHjndfqvp1sUfFMAv4mt0dTv5hF6BJR8OS/4NaOwe+3SGc/oI2cRKJNBhe21DV/2U3UAHCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAfbCiCm; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAfbCiCm"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7dcd17e19b6so2399973a34.1
        for <linux-block@vger.kernel.org>; Tue, 19 May 2026 20:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779246417; x=1779851217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iCJ1DD7tVweiKbLtyjjzWQ55vZMs9gLi6ogTzUVf/4k=;
        b=LAfbCiCmrDkF9DdbIlR9GMt9BOaUFVHalVzl7r5Kqmcs7fgL5BCOQTR1/QJSqZQAJS
         tOuFtYtInOX+ZIO1yox2CPq4xEGbNIi6aUkkhyNw53sj1XivBXc6ab6N3BNCov3/FlDk
         WQ9tspmBQUd6R/WP+5XOaku/8oebq880s1K9CphpNBe6XROrYEUTWIIgW+kv1H6EpLqA
         Y0DOR1Lo2eCQiTqnM4DU8T+RPF+PheW7W7QbE5HoM4xsAOs4hkJ3AupOobkkmnCY+NgW
         8V2xk02DOiXSl2W0etrxgGLxNnwsW00ytBdWp5+9I5O+Lsjj2ofpfSVgG3FA8DrDdR9n
         +r3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779246417; x=1779851217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iCJ1DD7tVweiKbLtyjjzWQ55vZMs9gLi6ogTzUVf/4k=;
        b=Teeow1Wz27f5h3+CK5epDqS0+PCMa76Wl16txFE39GgyO5+gbZVZ+dylAN2DIIp+oE
         scC5pQnQC9ZXIJs06RvoCYgtpo/YbYrMzkP9Umx/uN+5WmMrUXZqVMeTJbvq9TcVJ3tg
         E5SERzkVYrogQHMQolhC0JebxXQI/Jr6hXQSxV/MnUN7VTzjp4NUErEk/u/9u+RV5mtg
         Se4j8ADfr8MLEYkVFsU2i7b5xiqI9DC/3YuIKG46/RLPfjyu3nmNyM1toIvy07ob1ZcZ
         ubUIzAuk1cfv92+PVpgP/dM13tqLRNKJCVrZqkfhlORTrKFi8btDRttnCVVNdcRiSdIY
         TDag==
X-Forwarded-Encrypted: i=1; AFNElJ8YiLaeAgpMzQKODzjkJEDQaykUPEKznlJiGXS+DbN/idiv+j27PhiFDsa+1gP0cBCYswekapF4U5JJiw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy377JHSl9PuWyfN2/phOFkWWtbrM61F//OQ0FPU+iThml5SBLe
	nqsgVqqHRiFLyMANg7OHgV+4r5GN0+ZNz9jGINpVo8qdQG15s4fATOeN
X-Gm-Gg: Acq92OFVir3N6ZFsXSz2Cs5qPprg+RfY2ajeH+UMuoOoiG3tL5RKQuEWCGV/BMDlgEj
	AaqjsyvwxHrlvf7hZYAb1nl2MaZpHHmyEvDhL7Fbf9BSuc7Rg0ccFriUissKEGO2fxPZDYOZsTA
	DoKZVVtaKRn0XgvFg5qLYEHH/kFVaYStzSpPCkbfEHZvb7LgIAQSl0d0b0QRMv7frVP/fqJBkH2
	50ezmo7074RnX9HCQZkpfZaH+YYe1muzoVznLvz68aXc4WUJRdRcF1eNpfN30DrMWUHiaEPbJy2
	MfMHyQZHPHKOL5G12it54ROejqTA7XmJy+mo4+zJtHDbbCh0P3Vq4/A8Uig93DNykmSO/1dtzFZ
	WCh8OjvGgaG7IO+iZWZ5J9HQTgPBJfSwbVWQ1DW/YEFzK81qfbsZPtObqvUm9P9RfTT1RxlWBlw
	lHQGX/1ILgp1CmifDqflcJPnnnd202hBr8ZbFZ7SU3l/SFOMTOCiP0qVk7APyfSkrcgQutJH4Rj
	/cEC8E9PALDJmzMAwpV
X-Received: by 2002:a05:6830:82d3:b0:7dc:dd58:50b8 with SMTP id 46e09a7af769-7e4f2b89890mr14360672a34.13.1779246416970;
        Tue, 19 May 2026 20:06:56 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55b7cd6c0sm12351755a34.4.2026.05.19.20.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 20:06:56 -0700 (PDT)
Date: Wed, 20 May 2026 11:06:51 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	linux-block <linux-block@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] loop: Fix NULL pointer dereference by synchronizing
 lo_release and loop_queue_rq
Message-ID: <ag0lS_CbKO9R5CV8@fedora>
References: <69e2ca14.a00a0220.1bd0ca.0031.GAE@google.com>
 <e1d824ba-9ac7-4fde-a791-32eeadcd4258@I-love.SAKURA.ne.jp>
 <e33b4060-69d9-4d02-a330-2fbd19249237@I-love.SAKURA.ne.jp>
 <c0047a38-3d02-4ce5-88b0-2b7d0b9b69fa@acm.org>
 <f720dd8b-4aa3-48e4-a1bb-c0b43eb70f19@I-love.SAKURA.ne.jp>
 <af2205e3-205e-4743-a767-8593c2c4747a@I-love.SAKURA.ne.jp>
 <9b2032d6-3f36-4d2b-8128-985c08a4fa37@I-love.SAKURA.ne.jp>
 <20260518174013.4b72dd50a5bcb89daaed1f62@linux-foundation.org>
 <d43125ff-cc66-49b7-b16d-1b2650c68c23@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d43125ff-cc66-49b7-b16d-1b2650c68c23@I-love.SAKURA.ne.jp>

On Tue, May 19, 2026 at 06:27:11PM +0900, Tetsuo Handa wrote:
> On 2026/05/19 9:40, Andrew Morton wrote:
> > AI review asked a couple of questions:
> > 	https://sashiko.dev/#/patchset/9b2032d6-3f36-4d2b-8128-985c08a4fa37@I-love.SAKURA.ne.jp
> 
> To: gemini/gemini-3.1-pro-preview
> 
> Thank you for your valuable feedback. Your point about asynchronous I/O completing after drain_workqueue()
> and potentially causing a UAF at file_inode() from kiocb_end_write() from lo_rw_aio_do_completion() is correct.
> The drain_workqueue() alone does not wait for in-flight AIOs that have already returned -EIOCBQUEUED. However,
> I'm not convinced that use of blk_mq_freeze_queue() inside __loop_clr_fd() where disk->open_mutex was already
> held by bdev_release() is absolutely deadlock-free.
> 
> 1. VFS and Block Layer Lock Contention:
>    __loop_clr_fd() is exclusively invoked from the lo_release() path during the final close of the device.
>    At this stage, the block layer is holding disk->open_mutex. If we call blk_mq_freeze_queue() here, it will
>    synchronously wait for all in-flight AIOs to complete. However, the completion paths of those in-flight AIOs
>    (or subsequent metadata processing in the underlying filesystem) may attempt to acquire resources or execute
>    code paths that depend on the very same device state or open/close status. This creates a circular dependency,
>    leading to an unrecoverable hang.
> 
> 2. Memory Reclaim Deadlock:
>    blk_mq_freeze_queue() blocks until the queue's usage counter drops to zero. If an in-flight AIO requires memory
>    allocation for metadata updates upon completion, and the system is under heavy memory pressure, it can trigger
>    direct memory reclaim. If the reclaim path attempts to sync other buffers or interact with the frozen loop
>    device/queue, a circular deadlock occurs.
> 
> Therefore, I would like to choose SRCU-based synchronization instead of blk_mq_freeze_queue().
> 
> * Locking: We call srcu_read_lock(&loop_io_srcu) only for asynchronous paths (cmd->use_aio) immediately
>   before submitting the I/O to the underlying filesystem in lo_rw_aio().
> 
> * Unlocking: The reader lock is released via srcu_read_unlock() at the very end of the AIO completion handler
>   (lo_rw_aio_do_completion()).
> 
> * Synchronization: We place synchronize_srcu(&loop_io_srcu) immediately after drain_workqueue() in __loop_clr_fd().
> 
> I think that this guarantees that __loop_clr_fd() safely blocks until all pending AIO callbacks are 100% completed,
> fully eliminating the UAF risk and ensuring the safety of the subsequent mapping_set_gfp_mask() and fput(), while
> remaining entirely deadlock-free.
> 
> What do you think about this approach?
> 
>  drivers/block/loop.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 0000913f7efc..7c3961f3cbc9 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -80,6 +80,7 @@ struct loop_cmd {
>  	struct list_head list_entry;
>  	bool use_aio; /* use AIO interface to handle I/O */
>  	atomic_t ref; /* only for aio */
> +	int srcu_idx;
>  	long ret;
>  	struct kiocb iocb;
>  	struct bio_vec *bvec;
> @@ -93,6 +94,7 @@ struct loop_cmd {
>  static DEFINE_IDR(loop_index_idr);
>  static DEFINE_MUTEX(loop_ctl_mutex);
>  static DEFINE_MUTEX(loop_validate_mutex);
> +DEFINE_SRCU(loop_io_srcu);
>  
>  /**
>   * loop_global_lock_killable() - take locks for safe loop_validate_file() test
> @@ -327,6 +329,8 @@ static void lo_rw_aio_do_completion(struct loop_cmd *cmd)
>  		kiocb_end_write(&cmd->iocb);
>  	if (likely(!blk_should_fake_timeout(rq->q)))
>  		blk_mq_complete_request(rq);
> +	if (cmd->use_aio)
> +		srcu_read_unlock(&loop_io_srcu, cmd->srcu_idx);
>  }
>  
>  static void lo_rw_aio_complete(struct kiocb *iocb, long ret)
> @@ -392,6 +396,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
>  	if (cmd->use_aio) {
>  		cmd->iocb.ki_complete = lo_rw_aio_complete;
>  		cmd->iocb.ki_flags = IOCB_DIRECT;
> +		cmd->srcu_idx = srcu_read_lock(&loop_io_srcu);
>  	} else {
>  		cmd->iocb.ki_complete = NULL;
>  		cmd->iocb.ki_flags = 0;
> @@ -1118,6 +1123,22 @@ static void __loop_clr_fd(struct loop_device *lo)
>  	struct file *filp;
>  	gfp_t gfp = lo->old_gfp_mask;
>  
> +	/*
> +	 * Now that loop_queue_rq() sees lo->lo_state != Lo_bound,
> +	 * wait for already started loop_queue_rq() to complete.
> +	 */
> +	synchronize_rcu();
> +	/*
> +	 * Now that no more works are scheduled by loop_queue_rq(),
> +	 * wait for already scheduled works to complete.
> +	 */
> +	drain_workqueue(lo->workqueue);
> +	/*
> +	 * Now that no more AIO requests are scheduled by lo_rw_aio(),
> +	 * wait for already started AIO to complete.
> +	 */
> +	synchronize_srcu(&loop_io_srcu);

The IO after close(loop) should be from writeback. rcu/sruc isn't necessary,
please see the patch posted in another thread:

https://lore.kernel.org/linux-block/agxJdUf1b0JSDAux@fedora/

in which the check on lo->lo_state is moved to loop_handle_cmd(), meantime
drain_workqueue() is added for draining in-flight workers.

Thanks,
Ming
