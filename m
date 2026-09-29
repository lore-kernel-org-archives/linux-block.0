Received: from mail-oi2-f42.google.com (mail-oi2-f42.google.com [74.125.231.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2562D4E66C0
	for <linux-block@vger.kernel.org>; Tue, 29 Sep 2026 09:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790672603; cv=none; b=MLdsDmLMQSCjk72bhww2tTF7DTlkmnZLNSSfDVXAf6DOWS6NNCeYXdgjAYilq+59u4EgUcDcG6DSUmaYkox9aoh+iamtyPC93thOfI3hCiZVCmzEnxOcCG01bfYgTIzFvd66FPMZ9DHnkyF+tEhnvmIkfIioijts9/0T+kViyNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790672603; c=relaxed/simple;
	bh=xhk9l8xxQFNWZtQaW52fwQ5oIWX98eS9UVwsxlLpHxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1rKEPQxoNZzxK7J6xp+CZkPnkIjdsHmI9m4xb3cSicMBofwaq6REOTDddDtNQhqbfrB3VxXmDw1bGn3qKIrD6QkNiObanFNv57e0r6LmM4bVtZVy9D9kxbmhoBOPJpthWTx6l1x73mT8BbrtyC1O4OUBjOOgjOJYexKBrzMo9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hja9/JYf; arc=none smtp.client-ip=74.125.231.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hja9/JYf"
Received: by mail-oi2-f42.google.com with SMTP id 5614622812f47-4e6eede34baso1368250b6e.0
        for <linux-block@vger.kernel.org>; Tue, 29 Sep 2026 02:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790672590; x=1791277390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7G7xbrBwpX8Qk9XyyBKXMy8SiEP3FiPmOY4KjiWkS7Y=;
        b=Hja9/JYfcko8ZgOk+o/n5RGGDKwYGVpieAFJJOB6vq7A/LfWJeSHI8GLeuwbtHJaQo
         /CvGN/Ui0RslLc5eXgAJYvUX25P3PIgKNi09/N72WfvQg/TOy2KGEq9eXJ3sRL50rqKs
         NSWMU0uTJj+/THjJEQlst8zUZq1Dq8hUSrJATlBKgJpXyCDwZ1DZosP0L6B/V4LWsOBI
         h78tcnNPX4sSJEXvYM3AUSBYraFR/SxOy7leeixxHsLKOkgwtVad9cZqNCGRfR9NaeSJ
         qv+Y+8VeC0xj4UPGnljaRXsnl0ZHBFkKuU0JL3Tb42H7+Rrbjl2bUxm5/QduAc2YbHCZ
         pbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790672590; x=1791277390;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7G7xbrBwpX8Qk9XyyBKXMy8SiEP3FiPmOY4KjiWkS7Y=;
        b=DIhz33k0ZXuqW1n/kXcG0Ky5EM7Vi7a0zEyQ3UjwWJ5+0hgTcbk2fR1BHqPwAK37yT
         o8ta5eQ4HRcQ1d5we6YxzH1m2oUFcqz8iTeRH/MozUxe4E8T5ILXzCfPc12fI93rvK4G
         D7DYRuI9B4uT9DdDD0wx7wbhseypBmOEl8ie3Jln+GjZEsVlqsOHGGgBmd4zyZ8muw+T
         yUN2foOK+xsZBeGK+Ai+mPXfEJedfBVUo2uEupPcdO5elw1r7gELoKVpxbNuDFH/6X64
         4/rES4jNV5jmSmn/thRQdhCwC0gD4e8S6XZAXV+rfivo5xtAnYVAX3XADw8YZOhsjKgZ
         Skuw==
X-Forwarded-Encrypted: i=1; AKwUvBxl1rhNerv1zO/9UTnY81dz2W2IpJgRkR73LbLInB8MPC/MmfDrAI/HACXkTTftczuAzfu03HpO1nqDfw==@vger.kernel.org
X-Gm-Message-State: AFuF++koNRFIx1225NAcGp5E2BsGuYSPRI9Z33PnPZe37Ae3kGnKWlG4
	giPkZj3C/l1JLgks+WH4Vzjx//+xAT81H1eUkWAnE+yANfMGUl74FJnZPAPvtQ==
X-Gm-Gg: AYBFou2gSGZG5EMay3NFI6S66U7XR+7O2bXZ6UNwJbtVlPbM7d580s/eTOx89dDlEgV
	QTfBSAZMNlESlxI4ZSb8bZjh4Zz2ebI0zNJu3lOYQOrzMHcz2VjVaa8vclOWTr+TywVxJQ3FZF1
	cs1MJrpkevm+9kPQxjg3qPcIgYhyFqfrlK+p34gNDI69S9RSgwAII3qYyXcbVFJ7iZwimUXydgh
	ZBJyS0yz6FhIRtWwyZd1XO9M3tb1gHpPh7/D2oV6LG2DvgSNxzFGiiwMp7jfYVmMlBtvwGmS85z
	kRjaNivu2ISlnvQMuNZzWWuB8DFbAjhFbfYf77DIg/soBAdfluMS44PZvoff4y5FgEHCCmBDLzh
	6y6sT72WUpXqDZghnVNpLxh9J3mPVYMa5IjmN7lniyXti6KiPSCKc/6qvMJnSIY8h5xzI7fBUsb
	dThVvwzyGr1gHh5d+gSXCx0ToYxlwlcvSS6hpzZ7ueM/1hCqEwYhCGHvyZ35HqYzsX2gsz0tPY5
	fJ4eeLGwetlrUHS3iddgvnbhX0J9nvIQpPjdZ6CcyvlAHKE5qlUFGorQOyI1WXhgI2+jPXY2BwZ
	mPnTuvUzh7Gwlw==
X-Received: by 2002:a05:6808:4f6c:b0:4e5:79ec:5bf8 with SMTP id 5614622812f47-4e579ec5e82mr7824808b6e.67.1790672589708;
        Tue, 29 Sep 2026 02:03:09 -0700 (PDT)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ebbd25c871sm4044188b6e.15.2026.09.29.02.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 02:03:09 -0700 (PDT)
Date: Tue, 29 Sep 2026 04:03:03 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, nbd@other.debian.org
Subject: Re: [PATCH v2 1/2] nbd: mark the socket dead when a partial send
 times out
Message-ID: <art-x7GV6bebIk1K@fedora-laptop>
References: <20260928091021.2456652-1-joseph.qi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928091021.2456652-1-joseph.qi@linux.alibaba.com>

On Mon, Sep 28, 2026 at 05:10:20PM +0800, Joseph Qi wrote:
> nbd_pending_cmd_work() completes the request with BLK_STS_IOERR once its
> retry loop passes req->deadline, but leaves nsock->pending set.  Nothing
> else clears it: nbd_send_cmd() only does so at its out: label after a
> complete send, and nbd_requeue_cmd() does not touch it.
> 
> Every later request on that socket then takes this branch in
> nbd_handle_cmd():
> 
> 	if (unlikely(nsock->pending && nsock->pending != req)) {
> 		nbd_requeue_cmd(cmd);
> 
> and is requeued again, forever, since the requeue path does not clear
> ->pending either.  If the tag is recycled first, ->pending matches the new
> request instead and nbd_send_cmd() resumes it in place of the abandoned
> one, skipping its header and leaving cmd_cookie alone.
> 
> Neither case leaves a usable socket.  The header went out and the rest of
> the payload never will, so the stream no longer matches what the server
> expects.  Mark the socket dead, which shuts it down and clears the partial
> send state.  nbd_xmit_timeout() does the same for a timed out request and
> only skips it here because NBD_CMD_PARTIAL_SEND makes it defer to this
> work function.
> 
> Without this, a write issued after the deadline fires never completes and
> the device has to be torn down to recover.
> 
> Reproduced by making the resumed send never progress, so the retry loop
> runs out req->deadline.  With the socket marked dead a later request is
> dispatched instead of requeued, and a reconnect afterwards does clean
> O_DIRECT I/O with no oops or warning.
> 
> Fixes: 8337b029f788 ("nbd: fix partial sending")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  drivers/block/nbd.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index ffce519bf008..c2c3dbdd631f 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -838,6 +838,14 @@ static void nbd_pending_cmd_work(struct work_struct *work)
>  		/* don't bother timeout handler for partial sending */
>  		if (READ_ONCE(jiffies) + msecs_to_jiffies(wait_ms) >= deadline) {
>  			cmd->status = BLK_STS_IOERR;
> +			/*
> +			 * The header is on the wire but the rest of the payload
> +			 * never will be, so the stream is out of sync with the
> +			 * server.  Marking the socket dead also drops the stale
> +			 * nsock->pending, which would otherwise make
> +			 * nbd_handle_cmd() requeue every later request forever.
> +			 */
> +			nbd_mark_nsock_dead(nbd, nsock, 1);

Reviewed-by: Ming Lei <tom.leiming@gmail.com>


Thanks,
Ming
