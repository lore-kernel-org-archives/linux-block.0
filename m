Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD29C154422
	for <linux-block@vger.kernel.org>; Fri, 26 Apr 2024 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714141561; cv=none; b=fCVS6TpRFGKcDLGkesUHHpCQ6BOyR/MdvlEnjhshmxRiqyK8IXwlUEoYch7YK5FZPCYWZd9ADW4G6jF63oqqL3wwIblztH7gT9J3Pl+4sy6ZcoUlqo2TpyhzlJU66p1tspCg8ueAizBBep0nDn+ag7WRw72uX9uJP8aADIMUing=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714141561; c=relaxed/simple;
	bh=R+X6vEPvFdoCJxBIEPLQMPr/wTwjjGdva+cEfV/Afi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i1gXkFsdgWx9DgdgP/JsctYwqk2IOw9ALWqNCDSXc2vltxgTdF5e7oY0sxy7EQBCRqRRVsse9nHpgxxkDrTtYehGRMs9to6yOi38zrFysgXzO9RPEtauqo0Sy8d9BNhVnDwoj+E1SakalLJmaqml1Qn/KcMDuiA94nI5o0ymWHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2SQEIX/0; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2SQEIX/0"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7da9f6c9c17so16940339f.2
        for <linux-block@vger.kernel.org>; Fri, 26 Apr 2024 07:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1714141558; x=1714746358; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SYZdlhOSW2plAcrRNZa4kVgqNxzt+id2KNIRqIUgxH0=;
        b=2SQEIX/067Onznf3PPogeA2vv3fIQ2IDTTWwUS0E3M1LKaIcyhl6rwHwocm3R0WMQ2
         0GSkqKniGnkpwN69me2mJgasxJXZNr6U1g1nOsswzKiMRUlN/S2LBvWgnP/DAI8vo221
         9MfqjzNl/KcVqrgRGat7bLDGIG+obdqahC9mSYM58uTGydS9Tzw2wOZhtzBcICl+Yvk2
         FmpyCKpBZwvwnGL22CrA2iUGUWO38KR7SavdfU9cqO6PVLQfVaPcq1NYCiOkPWNgOYLO
         U8zHh4AYd8u1dakr5XBbQ4qgJbbsKaxdIgXtezypgWMCw2CuRUY2GqGgB+nEbdT96T8R
         aaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714141558; x=1714746358;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SYZdlhOSW2plAcrRNZa4kVgqNxzt+id2KNIRqIUgxH0=;
        b=qAhdbCwwqcvnBmhdA72yqb3wKtlq0Q9C106GPiU6PLOQNyb1eJzKjOf0NliNgxnXii
         g9Z7GINQWOcalmtD2YvQgs1VFFZPyV4Yi3BiuBp8JKPbAlcKOkwTMLU+0KNZKFENFzY6
         5inDryI8BSEKyfWYCbagH9WQEPUFfTAYZM/o4SFjhuZ4Y6u5oUZP8g2gQkcyeGVwSA26
         juzoyZW8LLTPEXL4rDNwPpzI35LdWjAvA8eAUCqCpoG0E2jjwkU1HMROoBh4pJJAJKI+
         ztpPAyDEqA3W2jZ/NyX3C8102p7zC1lvg349Ye+nR0ADsAdwPHFQTRh6W50u9iy7gNcz
         YEcA==
X-Forwarded-Encrypted: i=1; AJvYcCX8J6ZcGm82um3WufLc+gnIrmE1tiY0hTsBL2gup9jG62USsFyxDNnK0YQn7c63JNOV6zWsAYlpP3a+X7ZTEUhepXo9nYWmcuw/Vfk=
X-Gm-Message-State: AOJu0YyDpp5gbHIEfMaOQB9CnumpsaIaj8XA1xUxxz4toHs2SOs3yMgG
	SxCMKuorD0RL5MDPawrbhjWi970gjfUfFKQzth1dgOOGmNgIaHvs+TiYWZTbB91/jqHk2CtXUCc
	f
X-Google-Smtp-Source: AGHT+IHWycOosPVtgbMwTpV7/9CaNBl4iip2iOSTKzHCtn56tUpEKvqQDc9Ko3d1m//8UmZnV2Xyig==
X-Received: by 2002:a05:6e02:1a6d:b0:36b:3c29:8d19 with SMTP id w13-20020a056e021a6d00b0036b3c298d19mr3595304ilv.3.1714141557913;
        Fri, 26 Apr 2024 07:25:57 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id v8-20020a92c6c8000000b0036a1303cc0asm4007216ilm.0.2024.04.26.07.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 07:25:57 -0700 (PDT)
Message-ID: <f3489d0c-2d27-4e27-ae49-df2e9dad2e00@kernel.dk>
Date: Fri, 26 Apr 2024 08:25:56 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] io_uring/rw: add support to send meta along with
 read/write
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, martin.petersen@oracle.com,
 kbusch@kernel.org, hch@lst.de, brauner@kernel.org
Cc: asml.silence@gmail.com, dw@davidwei.uk, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>,
 Nitesh Shetty <nj.shetty@samsung.com>
References: <20240425183943.6319-1-joshi.k@samsung.com>
 <CGME20240425184706epcas5p1d75c19d1d1458c52fc4009f150c7dc7d@epcas5p1.samsung.com>
 <20240425183943.6319-9-joshi.k@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240425183943.6319-9-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> diff --git a/io_uring/rw.c b/io_uring/rw.c
> index 3134a6ece1be..b2c9ac91d5e5 100644
> --- a/io_uring/rw.c
> +++ b/io_uring/rw.c
> @@ -587,6 +623,8 @@ static int kiocb_done(struct io_kiocb *req, ssize_t ret,
>  
>  		req->flags &= ~REQ_F_REISSUE;
>  		iov_iter_restore(&io->iter, &io->iter_state);
> +		if (unlikely(rw->kiocb.ki_flags & IOCB_USE_META))
> +			iov_iter_restore(&io->meta.iter, &io->iter_meta_state);
>  		return -EAGAIN;
>  	}
>  	return IOU_ISSUE_SKIP_COMPLETE;
This puzzles me a bit, why is the restore now dependent on
IOCB_USE_META?

> @@ -768,7 +806,7 @@ static int io_rw_init_file(struct io_kiocb *req, fmode_t mode)
>  	if (!(req->flags & REQ_F_FIXED_FILE))
>  		req->flags |= io_file_get_flags(file);
>  
> -	kiocb->ki_flags = file->f_iocb_flags;
> +	kiocb->ki_flags |= file->f_iocb_flags;
>  	ret = kiocb_set_rw_flags(kiocb, rw->flags);
>  	if (unlikely(ret))
>  		return ret;
> @@ -787,7 +825,8 @@ static int io_rw_init_file(struct io_kiocb *req, fmode_t mode)
>  		if (!(kiocb->ki_flags & IOCB_DIRECT) || !file->f_op->iopoll)
>  			return -EOPNOTSUPP;
>  
> -		kiocb->private = NULL;
> +		if (likely(!(kiocb->ki_flags & IOCB_USE_META)))
> +			kiocb->private = NULL;
>  		kiocb->ki_flags |= IOCB_HIPRI;
>  		kiocb->ki_complete = io_complete_rw_iopoll;
>  		req->iopoll_completed = 0;

Why don't we just set ->private generically earlier, eg like we do for
the ki_flags, rather than have it be a branch in here?

> @@ -853,7 +892,8 @@ static int __io_read(struct io_kiocb *req, unsigned int issue_flags)
>  	} else if (ret == -EIOCBQUEUED) {
>  		return IOU_ISSUE_SKIP_COMPLETE;
>  	} else if (ret == req->cqe.res || ret <= 0 || !force_nonblock ||
> -		   (req->flags & REQ_F_NOWAIT) || !need_complete_io(req)) {
> +		   (req->flags & REQ_F_NOWAIT) || !need_complete_io(req) ||
> +		   (kiocb->ki_flags & IOCB_USE_META)) {
>  		/* read all, failed, already did sync or don't want to retry */
>  		goto done;
>  	}

Would it be cleaner to stuff that IOCB_USE_META check in
need_complete_io(), as that would closer seem to describe why that check
is there in the first place? With a comment.

> @@ -864,6 +904,12 @@ static int __io_read(struct io_kiocb *req, unsigned int issue_flags)
>  	 * manually if we need to.
>  	 */
>  	iov_iter_restore(&io->iter, &io->iter_state);
> +	if (unlikely(kiocb->ki_flags & IOCB_USE_META)) {
> +		/* don't handle partial completion for read + meta */
> +		if (ret > 0)
> +			goto done;
> +		iov_iter_restore(&io->meta.iter, &io->iter_meta_state);
> +	}

Also seems a bit odd why we need this check here, surely if this is
needed other "don't do retry IOs" conditions would be the same?

> @@ -1053,7 +1099,8 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
>  		if (ret2 == -EAGAIN && (req->ctx->flags & IORING_SETUP_IOPOLL))
>  			goto ret_eagain;
>  
> -		if (ret2 != req->cqe.res && ret2 >= 0 && need_complete_io(req)) {
> +		if (ret2 != req->cqe.res && ret2 >= 0 && need_complete_io(req)
> +				&& !(kiocb->ki_flags & IOCB_USE_META)) {
>  			trace_io_uring_short_write(req->ctx, kiocb->ki_pos - ret2,
>  						req->cqe.res, ret2);

Same here. Would be nice to integrate this a bit nicer rather than have
a bunch of "oh we also need this extra check here" conditions.

> @@ -1074,12 +1121,33 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
>  	} else {
>  ret_eagain:
>  		iov_iter_restore(&io->iter, &io->iter_state);
> +		if (unlikely(kiocb->ki_flags & IOCB_USE_META))
> +			iov_iter_restore(&io->meta.iter, &io->iter_meta_state);
>  		if (kiocb->ki_flags & IOCB_WRITE)
>  			io_req_end_write(req);
>  		return -EAGAIN;
>  	}
>  }

Same question here on the (now) conditional restore.

> +int io_rw_meta(struct io_kiocb *req, unsigned int issue_flags)
> +{
> +	struct io_rw *rw = io_kiocb_to_cmd(req, struct io_rw);
> +	struct io_async_rw *io = req->async_data;
> +	struct kiocb *kiocb = &rw->kiocb;
> +	int ret;
> +
> +	if (!(req->file->f_flags & O_DIRECT))
> +		return -EOPNOTSUPP;

Why isn't this just caught at init time when IOCB_DIRECT is checked?

> +	kiocb->private = &io->meta;
> +	if (req->opcode == IORING_OP_READ_META)
> +		ret = io_read(req, issue_flags);
> +	else
> +		ret = io_write(req, issue_flags);
> +
> +	return ret;
> +}

kiocb->private is a bit of an odd beast, and ownership isn't clear at
all. It would make the most sense if the owner of the kiocb (eg io_uring
in this case) owned it, but take a look at eg ocfs2 and see what they do
with it... I think this would blow up as a result.

Outside of that, and with the O_DIRECT thing check fixed, this should
just be two separate functions, one for read and one for write.

-- 
Jens Axboe


