Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com [209.85.128.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CD71B0439
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 20:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744663343; cv=none; b=WHK7Re+DhNDKh5NtXc8kA0xpG5pMytU5GqTlk9tSPx+glgr8PnhkiqxfGw3+fMw5pK7hAKlKVMjhXCtPhA1O1jRx2BVmvc6nc8k3ttOFUrNS2YuziS8OKAgbf5uvOn7lUy8gdHd9JW4NLazgchyKU71oAdbaZalYFtLVN6QPym8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744663343; c=relaxed/simple;
	bh=FhMaUs/xxwZhcGp59gFBe/uf5vB0jqoeyYHBorxg7FU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FA4BHpXhx48NhdMKYCGhLfIy+HRN46C1jHr/iuH68b+1dttulVE0e4K0HuYyQjQFOfkCEZHiC1S1IuV6VpG2ZJ5J/6pvwcHFyVN9wZVCcyQ5vrtYVQBMVNhSSchZPAxtO9TQgvuAQH9Q47J/QpCZcWrJRt9IayfcLZ2+IQH3QdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=OLQ9az5P; arc=none smtp.client-ip=209.85.128.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="OLQ9az5P"
Received: by mail-yw1-f227.google.com with SMTP id 00721157ae682-6fee50bfea5so37771947b3.1
        for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 13:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744663340; x=1745268140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H/Eef8ML2lYeugF2kv9NiM9WwobQb8CScwx7LPdho5M=;
        b=OLQ9az5PkNDFZDw+brmkhz7BYpk84aX6E7Zx1QPKNKlxbBOVcKyNmd1HKJ4BHzzlW9
         FRzibh9OJVH7RwDimb4P03Qg/wX145rtNGxlyO3ZLQTFBF/CFGFSob0gMvpXJ5P/Ruz+
         BWxtKdNsn7sXvhlJ10zm8VjHXXFMzi21zD60NsLLr8/YIHNJgYNnglmWaqvuSK5uVvMg
         oFrc02OVjrIVaRXmhEW7H+ezWDhteMZ65mZxBSaZDEnp1FO76Wzd+1INozZmhaW7A58/
         QJc0k2FGn+xyCBkySP0pVwzFo9eU9zKLb6zi7mxczi1JgmSd0014R1t0OwEA7f4/JMtG
         J57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744663340; x=1745268140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/Eef8ML2lYeugF2kv9NiM9WwobQb8CScwx7LPdho5M=;
        b=EdG43EJK9KZvYLYTk83/bk1ucZHKqoGzn1bCc/Swh2H5zj67hnUtdA0KtT/WY+0r6g
         SWJkjVfpQyTZI6NhFGNUgOWPKSXe/R0PY+ZOfR9T4PHq2uOjDHOFwtQ9/Ggv44oqs9yW
         PZ0wC3UcnRgefMUF6KQpPZ1tuZ9ILL1LMkmq0f+n1TrXVJ0JxyiUH1+UjSZwsP7tL1tq
         7lDpjPHVAauHE+tNrXDfCuubZy2tMvuDUAgsNDhmzUNwImIX7A8PaMxmdu0s+aWv1nQW
         zMOANdXkTUNydXkThEutHsM8LoMiFHJEjccviNMwrKcorBKIsO4hzesCbn3OCM9l3qU9
         OEWA==
X-Forwarded-Encrypted: i=1; AJvYcCUAhllmL4z6hWPx61vsAQqu7ym8Ia/JTGebWC2crdymi9b0IpEL6eSINOAFnHWJ5X92GvgELW4ERQdl1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwO/uwtkfW8dKXEmV1Orfuy+3PHvu6wTut2noOCkQ0WW+LXcIyt
	Kb5XTqSEnq7Fzn8rvOTezOF45Q5iHUPUwsZJStMO/vzP4JFMKNMrL4wKcJabXxCv0ROz9GPBg8/
	G7Mn4cZYadugNn1vWTbpznglzGmCnb41Z
X-Gm-Gg: ASbGncvZdd3Flp0Q67hGJF1vm5lpqBMaD2M6GegtrP2IC91tCvSpyGdcPs68bTOt2ZA
	39qCfNAJ6D7a+u7HmioCsi523yWEaTwv1GzojIuLjBkS7+TaO2ufrjuedhCnicG0/L5v/pr9Ly6
	soYPo1/cBKwANW7ysDMQ4GZRwgnTB0fJ941SwIoTfkfhkzJAnxL1xXv2vT/s8DrxMrpa7KGAh4w
	WhDl0qWJzoRaBxK6pMkzENpH6+HjCsJlU6RuLZ9lQON3apLIriwNwlD8RQkeC0BmuA7NwQZgGak
	auBGk2vMAKaLNnMlzCHyjeuY27R/IRlgmgTY/VS06zEsBg==
X-Google-Smtp-Source: AGHT+IEOhGshqduniWso6ORNsPg/jEJXFyaWf9KT2bNUCrJ83N6jcbeQxRyhnubw2VHkZxjWwky+PuhuuNF0
X-Received: by 2002:a05:690c:3607:b0:6fb:9b8c:4b50 with SMTP id 00721157ae682-705599c9835mr256531517b3.13.1744663340430;
        Mon, 14 Apr 2025 13:42:20 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7053e0f4393sm5688327b3.4.2025.04.14.13.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 13:42:20 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id AF5FF3401C3;
	Mon, 14 Apr 2025 14:42:19 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id A1255E402BD; Mon, 14 Apr 2025 14:42:19 -0600 (MDT)
Date: Mon, 14 Apr 2025 14:42:19 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH 8/9] ublk: simplify aborting ublk request
Message-ID: <Z/1zK7ycY+iLZBmL@dev-ushankar.dev.purestorage.com>
References: <20250414112554.3025113-1-ming.lei@redhat.com>
 <20250414112554.3025113-9-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414112554.3025113-9-ming.lei@redhat.com>

On Mon, Apr 14, 2025 at 07:25:49PM +0800, Ming Lei wrote:
> Now ublk_abort_queue() is moved to ublk char device release handler,
> meantime our request queue is "quiesced" because either ->canceling was
> set from uring_cmd cancel function or all IOs are inflight and can't be
> completed by ublk server, things becomes easy much:
> 
> - all uring_cmd are done, so we needn't to mark io as UBLK_IO_FLAG_ABORTED
> for handling completion from uring_cmd
> 
> - ublk char device is closed, no one can hold IO request reference any more,
> so we can simply complete this request or requeue it for ublk_nosrv_should_reissue_outstanding.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Uday Shankar <ushankar@purestorage.com>

> ---
>  drivers/block/ublk_drv.c | 82 ++++++++++------------------------------
>  1 file changed, 20 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index f827c2ef00a9..37a0cb8011c1 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -122,15 +122,6 @@ struct ublk_uring_cmd_pdu {
>   */
>  #define UBLK_IO_FLAG_OWNED_BY_SRV 0x02
>  
> -/*
> - * IO command is aborted, so this flag is set in case of
> - * !UBLK_IO_FLAG_ACTIVE.
> - *
> - * After this flag is observed, any pending or new incoming request
> - * associated with this io command will be failed immediately
> - */
> -#define UBLK_IO_FLAG_ABORTED 0x04
> -
>  /*
>   * UBLK_IO_FLAG_NEED_GET_DATA is set because IO command requires
>   * get data buffer address from ublksrv.
> @@ -1083,12 +1074,6 @@ static inline void __ublk_complete_rq(struct request *req)
>  	unsigned int unmapped_bytes;
>  	blk_status_t res = BLK_STS_OK;
>  
> -	/* called from ublk_abort_queue() code path */
> -	if (io->flags & UBLK_IO_FLAG_ABORTED) {
> -		res = BLK_STS_IOERR;
> -		goto exit;
> -	}
> -
>  	/* failed read IO if nothing is read */
>  	if (!io->res && req_op(req) == REQ_OP_READ)
>  		io->res = -EIO;
> @@ -1138,47 +1123,6 @@ static void ublk_complete_rq(struct kref *ref)
>  	__ublk_complete_rq(req);
>  }
>  
> -static void ublk_do_fail_rq(struct request *req)
> -{
> -	struct ublk_queue *ubq = req->mq_hctx->driver_data;
> -
> -	if (ublk_nosrv_should_reissue_outstanding(ubq->dev))
> -		blk_mq_requeue_request(req, false);
> -	else
> -		__ublk_complete_rq(req);
> -}
> -
> -static void ublk_fail_rq_fn(struct kref *ref)
> -{
> -	struct ublk_rq_data *data = container_of(ref, struct ublk_rq_data,
> -			ref);
> -	struct request *req = blk_mq_rq_from_pdu(data);
> -
> -	ublk_do_fail_rq(req);
> -}
> -
> -/*
> - * Since ublk_rq_task_work_cb always fails requests immediately during
> - * exiting, __ublk_fail_req() is only called from abort context during
> - * exiting. So lock is unnecessary.
> - *
> - * Also aborting may not be started yet, keep in mind that one failed
> - * request may be issued by block layer again.
> - */
> -static void __ublk_fail_req(struct ublk_queue *ubq, struct ublk_io *io,
> -		struct request *req)
> -{
> -	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
> -
> -	if (ublk_need_req_ref(ubq)) {
> -		struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
> -
> -		kref_put(&data->ref, ublk_fail_rq_fn);
> -	} else {
> -		ublk_do_fail_rq(req);
> -	}
> -}
> -
>  static void ubq_complete_io_cmd(struct ublk_io *io, int res,
>  				unsigned issue_flags)
>  {
> @@ -1670,10 +1614,26 @@ static void ublk_commit_completion(struct ublk_device *ub,
>  		ublk_put_req_ref(ubq, req);
>  }
>  
> +static void __ublk_fail_req(struct ublk_queue *ubq, struct ublk_io *io,
> +		struct request *req)
> +{
> +	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
> +
> +	if (ublk_nosrv_should_reissue_outstanding(ubq->dev))
> +		blk_mq_requeue_request(req, false);
> +	else {
> +		io->res = -EIO;
> +		__ublk_complete_rq(req);
> +	}
> +}
> +
>  /*
> - * Called from ubq_daemon context via cancel fn, meantime quiesce ublk
> - * blk-mq queue, so we are called exclusively with blk-mq and ubq_daemon
> - * context, so everything is serialized.
> + * Called from ublk char device release handler, when any uring_cmd is
> + * done, meantime request queue is "quiesced" since all inflight requests
> + * can't be completed because ublk server is dead.
> + *
> + * So no one can hold our request IO reference any more, simply ignore the
> + * reference, and complete the request immediately
>   */
>  static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
>  {
> @@ -1690,10 +1650,8 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
>  			 * will do it
>  			 */
>  			rq = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], i);
> -			if (rq && blk_mq_request_started(rq)) {
> -				io->flags |= UBLK_IO_FLAG_ABORTED;
> +			if (rq && blk_mq_request_started(rq))
>  				__ublk_fail_req(ubq, io, rq);
> -			}
>  		}
>  	}
>  }
> -- 
> 2.47.0
> 
