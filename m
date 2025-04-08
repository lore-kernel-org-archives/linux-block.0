Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625BD158DD8
	for <linux-block@vger.kernel.org>; Tue,  8 Apr 2025 19:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139516; cv=none; b=NNRQfavSFD5QR35tIm3i4DO7mw6J5rWFJEx1BUNuyNJJQnNRmD/tnSG3UIpxWb1hcTy66Wncg3TO/kiZrk+0CSs1JLKZgs5Wf3razPRjd82aaD8XQjCNaUXbErwwSjnoWmfnCVMVtA7piiAqHt9yaZipSq6JPL+iYCRwiOYgxb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139516; c=relaxed/simple;
	bh=uYEvk4paOdpqxiUcgsh28Wl7W7AiBLrvCQB1VnYQHWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9ZHR2f9SFExj1xGRvlJEpjmXBFiRxX/1I/9y0pvtqSRH3Vwi6X4XdcfBOh6EleZal9q9ZaRghn4zZ2Dh/ty6tyKAoER4knRBvX0BYkV27FuUfUn0tH2rNXnf2HsnJbz51x+UqIqBV4E32diwRXnzwa8wR2PS/yQsX6+YJh3UQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Hno49fkN; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Hno49fkN"
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-6e8fca43972so67523846d6.1
        for <linux-block@vger.kernel.org>; Tue, 08 Apr 2025 12:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744139513; x=1744744313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3qx/7CR29KfS2ed1apBQgXO3iu4Rkmsf1xgikD2tqzA=;
        b=Hno49fkNdg+xeKJcD3KOSD4xs9nQOBBfrT4lRgEULKpCTutcuobPmPnKbvRqFJvtCZ
         ijkC2hypgK+yNZPioeayMHJcQrQ0+i8Dh6O1kEp7NPLZUbeP3Fm+LTjUDrYd8CGm1AdT
         T3pzfdxnjhZHR/mLchhysSupbtuvGdLXxKIqSeW1hm/VxpalQUAIjdMFtStd/R0cwZ7a
         j2vcZ+5ivhbnYojL4AuKZyk9EjUlCObFTQLB8XUTHG18omHbDk96Pu5XBugunhB2s6la
         MRKR/h3xy5lNy3ImUKxnAX+FcAPo8n+7i1dCUKwnrpbRou19Fca4aJgi3X7Nx6ncnrNG
         TXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744139513; x=1744744313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qx/7CR29KfS2ed1apBQgXO3iu4Rkmsf1xgikD2tqzA=;
        b=IkmZX9uFpQxDm+XLT5+ehRttp+wrWcT+41iDVrlhrCpBZ6/Z0wcFx6EQiAgr6K6ZdL
         40ODAQTbkpxwoIph1gCGHW6cv459j75cMVXWCeXfLJ6C3r7hJgrUGXr1lA23CugtD67l
         oT0tZV8IHJNTDIs9cWur8blTANEOjnjoj+q6XGKDaP78t3oKAd5gT+Irv4wwsAPtj6+n
         fiTxsiw1BrcRDVnrAaUQrNjwbJxz4xn9hz+Vlua08zDB+BftgLYILY6yU6PmF2KgyiUV
         G6SnUSmS6BaS9C5KG08OrqHwDK4r7eAazqAG3AFOXc80ZlQfPT2/om77JhWepf1vB/1K
         o+lg==
X-Forwarded-Encrypted: i=1; AJvYcCXzYB/4hKDZuI8IJcp7ifk/dYPgEQ6XISq7aimQA+yq9V3+rhkakhHaQBN4OB+B5dBmpATMr/9ynnun2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKuIKEgdWSZ3rxfTZQ8aC0/bCfC22iqdIYbKidrqnZxcG7VkjS
	pbL6BrNcX1GjRZUoeDT2KR+k74UN7UjqnJHMW55SL22TBK7POtIm5Jul+zT4Zo9ovmwo1UFND4m
	BAoNeH2jt4nIP3vcldkejYNX7gsUU97ZKiHghoSHFGmSnPUod
X-Gm-Gg: ASbGnctjFLj+4l5t1EXHIjWg5FZHpwMGYqVgzKI17R/W2H9ZEF2+4bU8ULMTuqLtzFT
	ul1+DrEWq9oAOUE5wVYHyvCdj3IjQr9KUlkzbt9G3HD7Wl1PBsdpKZ9+urm2KwCOBJ79fI7WS0y
	atgUsi9Uwh3QPeQOldE/MjxkEYtbPlvCKRe7EPpCXjxWqvdeKE30UMWjw8hMxKKXbg4NKj+TEV+
	LF2Bha0L0e5nD5EKpF1Pbfnt9esoEpgr+hXSnwZ3buMhKcNOujeF0hyTMXnj9LDb7CsBtPtZQ1k
	wqVOpzEidtyKR8SQ5wAvC0/Og6wyjPOtb6M=
X-Google-Smtp-Source: AGHT+IGz3I+Aq4M2Vd11YuEiMXDH6wUhplj+7bBMJ+xt0UKr20VLgEHURzQCfZiJNMCzo8T5NzwJP6UujsI8
X-Received: by 2002:a05:6214:5013:b0:6e8:9d00:3d67 with SMTP id 6a1803df08f44-6f0dbb93912mr5864676d6.15.1744139513109;
        Tue, 08 Apr 2025 12:11:53 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6ef0f149423sm8394516d6.59.2025.04.08.12.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 12:11:53 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 3CA79340353;
	Tue,  8 Apr 2025 13:11:52 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 30AE3E402F2; Tue,  8 Apr 2025 13:11:52 -0600 (MDT)
Date: Tue, 8 Apr 2025 13:11:52 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH 2/2] ublk: don't fail request for recovery & reissue in
 case of ubq->canceling
Message-ID: <Z/V0+NnMBFlPGaBX@dev-ushankar.dev.purestorage.com>
References: <20250408072440.1977943-1-ming.lei@redhat.com>
 <20250408072440.1977943-3-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408072440.1977943-3-ming.lei@redhat.com>

On Tue, Apr 08, 2025 at 03:24:38PM +0800, Ming Lei wrote:
> ubq->canceling is set with request queue quiesced when io_uring context is
> exiting. Recovery & reissue(UBLK_F_USER_RECOVERY_REISSUE) requires
> request to be re-queued and re-dispatch after device is recovered.
> 
> However commit d796cea7b9f3 ("ublk: implement ->queue_rqs()") still may
> fail any request in case of ubq->canceling, this way breaks
> UBLK_F_USER_RECOVERY_REISSUE.

This change actually affects UBLK_F_USER_RECOVERY as long as FAIL_IO
isn't set (regardless of RECOVERY_REISSUE). RECOVERY_REISSUE only
changes behavior for requests that are already in the ublk server when
the ublk server dies, but the code change only affects requests that
come in after ublk server death is already detected. At that point, both
plain USER_RECOVERY and USER_RECOVERY|USER_RECOVERY_REISSUE should see
requests queue instead of completing with error. See below code
snippets:

static inline void __ublk_abort_rq(struct ublk_queue *ubq,
		struct request *rq)
{
	/* We cannot process this rq so just requeue it. */
	if (ublk_nosrv_dev_should_queue_io(ubq->dev))
		blk_mq_requeue_request(rq, false);
	else
		blk_mq_end_request(rq, BLK_STS_IOERR);
}

/*
 * Should I/O issued while there is no ublk server queue? If not, I/O
 * issued while there is no ublk server will get errors.
 */
static inline bool ublk_nosrv_dev_should_queue_io(struct ublk_device *ub)
{
	return (ub->dev_info.flags & UBLK_F_USER_RECOVERY) &&
	       !(ub->dev_info.flags & UBLK_F_USER_RECOVERY_FAIL_IO);
}

> 
> Fix it by calling __ublk_abort_rq() in case of ubq->canceling.
> 
> Reported-by: Uday Shankar <ushankar@purestorage.com>
> Closes: https://lore.kernel.org/linux-block/Z%2FQkkTRHfRxtN%2FmB@dev-ushankar.dev.purestorage.com/
> Fixes: commit d796cea7b9f3 ("ublk: implement ->queue_rqs()")

Will this upset anything parsing these tags? The syntax I've usually
seen doesn't have "commit," i.e.

Fixes: d796cea7b9f3 ("ublk: implement ->queue_rqs()")

> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Code change looks good.

Reviewed-by: Uday Shankar <ushankar@purestorage.com>

> ---
>  drivers/block/ublk_drv.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 41bed67508f2..d6ca2f1097ad 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1371,7 +1371,8 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
>  	return BLK_EH_RESET_TIMER;
>  }
>  
> -static blk_status_t ublk_prep_req(struct ublk_queue *ubq, struct request *rq)
> +static blk_status_t ublk_prep_req(struct ublk_queue *ubq, struct request *rq,
> +				  bool check_cancel)
>  {
>  	blk_status_t res;
>  
> @@ -1390,7 +1391,7 @@ static blk_status_t ublk_prep_req(struct ublk_queue *ubq, struct request *rq)
>  	if (ublk_nosrv_should_queue_io(ubq) && unlikely(ubq->force_abort))
>  		return BLK_STS_IOERR;
>  
> -	if (unlikely(ubq->canceling))
> +	if (check_cancel && unlikely(ubq->canceling))
>  		return BLK_STS_IOERR;
>  
>  	/* fill iod to slot in io cmd buffer */
> @@ -1409,7 +1410,7 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	struct request *rq = bd->rq;
>  	blk_status_t res;
>  
> -	res = ublk_prep_req(ubq, rq);
> +	res = ublk_prep_req(ubq, rq, false);
>  	if (res != BLK_STS_OK)
>  		return res;
>  
> @@ -1441,7 +1442,7 @@ static void ublk_queue_rqs(struct rq_list *rqlist)
>  			ublk_queue_cmd_list(ubq, &submit_list);
>  		ubq = this_q;
>  
> -		if (ublk_prep_req(ubq, req) == BLK_STS_OK)
> +		if (ublk_prep_req(ubq, req, true) == BLK_STS_OK)
>  			rq_list_add_tail(&submit_list, req);
>  		else
>  			rq_list_add_tail(&requeue_list, req);
> -- 
> 2.47.0
> 
