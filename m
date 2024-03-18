Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC98424B28
	for <linux-block@vger.kernel.org>; Mon, 18 Mar 2024 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710749431; cv=none; b=C2Pkou+gbAuJaG4CD38oREACA7ZniA7rtvt/gR7H5woG5LkL7CvuKa1614LuDe8b0sLnRaPv/Di01g1gzqI52JHiHciASn4xS8w+kfX2mdOtDD2COq5umoXLO5RWMa0cgli0P9uyufjruG/ZWxKJGbDDHNulrIWFJjllkCR2hCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710749431; c=relaxed/simple;
	bh=i+vEu6RYGsOi2KVCg1LTAAS1DxtBbf32r7gkl+OuJLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DW5Kfr5fV/WGKYDoXJrZ05KUU3oiNeI3mEigGsqL1znyCupfZR2Y3ZXYwDjTrRxplgEZEbO793f5WAOVx3QIRaFv6c4mflRJCk+ut3Fh35dTSZ5pSNUcMmutvxq+aNseFQ5Nn9Vz7BQPpL4eufpkwDzqtK1KgUaU4ZsCp/OdP/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bl+qWwpj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bl+qWwpj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710749428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dm4q+REp2L6kDSMs/00A34opsOSLnJxOJ8M5p+BhaQ4=;
	b=Bl+qWwpjdiJoB+avcmHgZpHeRH0WDh69B1X1PEp/NMYbCQx/FkXX8JCbLGrPa7aWvqEBvL
	EMT6pcjAMdD9LfFcFxd49OCmiegHNZZzrEQ1BKN4yycw19DJ33mvlKuM7uSwsk9BJm4L70
	NJX3/pfbKxesJLVWCHq2xjrkdpxoUmQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-y5QfBj60N6C2FsVSD3IwVQ-1; Mon,
 18 Mar 2024 04:10:26 -0400
X-MC-Unique: y5QfBj60N6C2FsVSD3IwVQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F4981C54027;
	Mon, 18 Mar 2024 08:10:26 +0000 (UTC)
Received: from fedora (unknown [10.72.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 33733C01851;
	Mon, 18 Mar 2024 08:10:22 +0000 (UTC)
Date: Mon, 18 Mar 2024 16:10:15 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v2 03/14] io_uring/cmd: make io_uring_cmd_done irq safe
Message-ID: <Zff25z0fPGBPfJs1@fedora>
References: <cover.1710720150.git.asml.silence@gmail.com>
 <faeec0d1e7c740a582f51f80626f61c745ed9a52.1710720150.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faeec0d1e7c740a582f51f80626f61c745ed9a52.1710720150.git.asml.silence@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On Mon, Mar 18, 2024 at 12:41:48AM +0000, Pavel Begunkov wrote:
> io_uring_cmd_done() is called from the irq context and is considered to
> be irq safe, however that's not the case if the driver requires
> cancellations because io_uring_cmd_del_cancelable() could try to take
> the uring_lock mutex.
> 
> Clean up the confusion, by deferring cancellation handling to
> locked task_work if we came into io_uring_cmd_done() from iowq
> or other IO_URING_F_UNLOCKED path.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  io_uring/uring_cmd.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
> index ec38a8d4836d..9590081feb2d 100644
> --- a/io_uring/uring_cmd.c
> +++ b/io_uring/uring_cmd.c
> @@ -14,19 +14,18 @@
>  #include "rsrc.h"
>  #include "uring_cmd.h"
>  
> -static void io_uring_cmd_del_cancelable(struct io_uring_cmd *cmd,
> -		unsigned int issue_flags)
> +static void io_uring_cmd_del_cancelable(struct io_uring_cmd *cmd)
>  {
>  	struct io_kiocb *req = cmd_to_io_kiocb(cmd);
>  	struct io_ring_ctx *ctx = req->ctx;
>  
> +	lockdep_assert_held(&ctx->uring_lock);
> +
>  	if (!(cmd->flags & IORING_URING_CMD_CANCELABLE))
>  		return;
>  
>  	cmd->flags &= ~IORING_URING_CMD_CANCELABLE;
> -	io_ring_submit_lock(ctx, issue_flags);
>  	hlist_del(&req->hash_node);
> -	io_ring_submit_unlock(ctx, issue_flags);
>  }
>  
>  /*
> @@ -44,6 +43,9 @@ void io_uring_cmd_mark_cancelable(struct io_uring_cmd *cmd,
>  	struct io_kiocb *req = cmd_to_io_kiocb(cmd);
>  	struct io_ring_ctx *ctx = req->ctx;
>  
> +	if (WARN_ON_ONCE(ctx->flags & IORING_SETUP_IOPOLL))
> +		return;
> +

This way limits cancelable command can't be used in iopoll context, and
it isn't reasonable, and supporting iopoll has been in ublk todo list,
especially single ring context is shared for both command and normal IO.


Thanks,
Ming

