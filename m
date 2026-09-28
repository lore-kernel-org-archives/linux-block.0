Received: from mail-oo2-f36.google.com (mail-oo2-f36.google.com [74.125.231.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553804D37C2
	for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 17:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790618032; cv=pass; b=jCsCRLeH4FQYpcip/HdvG5bgt7Wu1Id5Dmesk76lA3JZprQycfGcWILKlga9f8RJav9U9o0/lRyMv9S4vsQ0Yq+HN4DOYA1On7jC114WoylSH+VXT5bUE8+0nXQgyAS8B+C+e9XF2FLRUgOMUwfCMtO720huMtqIF5a4e3xwIl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790618032; c=relaxed/simple;
	bh=2kNG+wBoo1LXnVxUU7YpNWdNJd2rymZ+d19jEj0AZXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q+n7TAx0ZFTjtTOR4f59A3OndQ/rfmftUEGp5nNiqeH1/ctHwTobIxOlEDuiQQewIiG6gIsC4hE36XeaW9XUAMvp5oihQ6WQkNtf/nK5lqVBtSmWcvssYuWrWy9uKhl9gsHUt1g2f/N36xEg3vTzO9kye4kmBJ+IMqZrhcqq9L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FEsBMcKI; arc=pass smtp.client-ip=74.125.231.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FEsBMcKI"
Received: by mail-oo2-f36.google.com with SMTP id 46e09a7af769-80552a37b55so323033a34.3
        for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 10:53:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790618029; cv=none;
        d=google.com; s=arc-20260327;
        b=OavmV27I6H25dNJjlIaG/yQOVfG52B/T2iThThzQ0K/P+eibe59HOB+VflfQt7Spvr
         cHPL+yFjo4U1N3LKwf4i0YTeFMvfDLtm4O3PRLm4hlbQmOREeEfmIxeTDt0dlfP2N8Ym
         PFoS0HYAiBh+RRmK3MPyrAVWTE9BGq+7ClhWoBNGYU+3fXu/VyOpgRDvf3vY5L9TVGPU
         V/+4ESccS72VgGOOBa+h6Y6VA/ClN3MYF+AYNQBVTmPxb/RyTxzDiLZcaiacu5mTd5i2
         NSNz/GICTMmpVQp5nlX99YMnAyDQT9kclCFR8ojo1jC1RtvIWn2+v6OQMJvginZALFCO
         1wDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pxorRVrnA629ZxhkkzbuPJrftY5VCgA7nPzvnQoi4i8=;
        fh=WPQ1wK6hJa6ySUC+tsJOMPD/H2PLY5RYH9F9INxpSyI=;
        b=dcRsVPdnO/cYC0jYwcnlOmqJvpKwpHp8WJeX6MmTiJrCyr1TCxVqKqH/aXViQcIyTK
         EvsBDzq9cjK2chedOKVqLp4qLNICWabaP3f6BJReA0f4MSmfniW7ysokZqQP4rKBpmGw
         ARY3NYQLVKe2GnfHPOB7QDgN9Hzalqu686yvp9Fi5+Dxxtwq5n90ZVihmXzpiBsLSl8p
         zee0AyDD8AmzcZk1ZxdrFT0LlSpQrbjLUr9OSpHLTEi1oATWiYSkguLaVurpC4oR//Ju
         R3AoNunrTxSmLjXeQeGhSqVYV3HOZ1lGn++AjC1upjlM1M2vuUyuMwP9Yclm97TdTfLW
         09MA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1790618029; x=1791222829; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pxorRVrnA629ZxhkkzbuPJrftY5VCgA7nPzvnQoi4i8=;
        b=FEsBMcKIGfj95sMSo6NPiSGSxjKIY5b2uRvmr2NI0GfUEhege9pHgCandUX1/CE4pQ
         vSeyFstbxNFx3M0wcrOBxGLkDkyY4VjT+2XoVhZODsBtHSPO6yJ9SwO4Vhoz5SZkQgjf
         pMLIbVZf3VjQCsSFzR3okAw2ct6ooi7/rPQ0UDDptK++0lcC8MrnUaGUBfeZBUze6r6/
         SRybZgyNdeHEL/GlqKoO3tZtzgHqcN3gv5OwAWBGENEK5fOblbv+TwAoDI0/w4/ykW/d
         eQ9+EgYzDyZloSMfX5AEIPk3Y3g4MmS/JKbic363fh1xfVCShfZJumyUr+fz0TT7/i0G
         ZMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790618029; x=1791222829;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pxorRVrnA629ZxhkkzbuPJrftY5VCgA7nPzvnQoi4i8=;
        b=eCOntUDSS3vbBbvdAIrY7G1AxXirhiySzdsVcpLn4PPmAUPqT7GnhYxZ7HdtCyVVHM
         ZvP2/Qq1sElHrYqAGDQlIErNeaymjHr2A2raJZedQsd+lbfIhEi/KC+2iqHY/Jl484eL
         9SjIhpogRo+e/93xaZ6d6RNGTYcmECqMHgIPVgUjlVeAShRbDKGv7ONjp4GO1YOqshAL
         CJq/1nx4HXSc8pFAHOWRZCiuS4GA/7CLffjDvvll1TS3gxnFoALvxdLeYxHZ3iqfyZRx
         7eJGyzS61QOEqZCgKO3CjHbA6nSMMlRdBuBXgEl5aZJev1mK6irJR4QWHXwWrlBrzkmy
         nMoA==
X-Forwarded-Encrypted: i=1; AKwUvBwk6U4+Vw8TMkGtI2GLiKxMt3jBEN3c6YvlMpY+CKFzfF8y+mAjT1YXLTnobtUitf2kGAAqhvGu+25vtw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJaamb4qVcurAjHHITRfp0YzjvOhIOqsJliEUzu/s7wNCQIhDGX
	SpLA8gD6d0V/Q8OiQJgJ0qmmpT4tKygQcAk2Rl0oaBM5IukA0HkvrQQk4fESxf8cWTSuODw6FZI
	wjgqvZNIck3u9HtdD3WtFNMJ1lSFtDAWgXgvwAAvyow==
X-Gm-Gg: AYBFou0pmQw7++JCWbcDcMwHChSH5UtRkLNKVCuDmLrUako9FJqxGDevk5GqqqOiGLM
	z7PyxhhM3IxWFzjisoK7qww3gDC8OcAOxCJFEqm8oKrksjNczxvB27TdQkKY2/pEwIlnaq7Z9Wc
	3+onh6I1q7mM3o10zbI6iqKdSFY26I39yMnbMWQXtcfKAGgZRJp6Fu7uuTt8dxlHtCUA5hcC3Q2
	+tw9jtHHG1zsFiF6H+AkRED/q83Q7pBptUooYtSG90OBu2zjrKv032L7uQoywhiUoyYVaxGcKx/
	SYqea6ZHYZoS+Hi4av72pibnXQ+RHUxbTgOW68ytT0nfkSvfOd295UpXaxR1dLR3UsI=
X-Received: by 2002:a05:6870:f10e:b0:447:4cf0:eb19 with SMTP id
 586e51a60fabf-4930bb82a4amr15095600fac.4.1790618029099; Mon, 28 Sep 2026
 10:53:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928-b4-ublk-cancel-stop-v1-0-4a4360232a46@toxicpanda.com> <20260928-b4-ublk-cancel-stop-v1-3-4a4360232a46@toxicpanda.com>
In-Reply-To: <20260928-b4-ublk-cancel-stop-v1-3-4a4360232a46@toxicpanda.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 28 Sep 2026 10:53:38 -0700
X-Gm-Features: AclHuK9nxEm2zBDwrnuiv4JMUs_01csR-Wh_9mfwxHD7EKXDa_-x71ypJIIn4T0
Message-ID: <CADUfDZqDZEM4=uw+By6RnxvLqXbc-iPf8RCUQtQB5_Z_Di84Aw@mail.gmail.com>
Subject: Re: [PATCH 3/9] ublk: publish io->cmd under io->lock in the commit paths
To: Josef Bacik <josef@toxicpanda.com>
Cc: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 9:03=E2=80=AFAM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> io->cmd shares its storage with io->req. FETCH, COMMIT_AND_FETCH and
> NEED_GET_DATA switch the io from one to the other in
> ublk_fill_io_cmd() without a lock of their own. That was fine as long
> as everything else looking at io->cmd ran under the uring_lock of the
> same ring, which is the case for the io_uring cancel callback.
>
> ublk_cancel_cmd() is also called from the control path, from
> ublk_cancel_dev() with IO_URING_F_UNLOCKED, and the next patches add
> more such callers which run while the server still commits requests.
> Nothing orders their reads of io->flags and io->cmd against
> ublk_fill_io_cmd() then. A reader can find UBLK_IO_FLAG_ACTIVE set and
> still pick up the request pointer from the union.
>
> The batch commit path calls ublk_fill_io_cmd() under io->lock already.
> Do the same in the other three callers, so that io->lock covers every
> switch of the union to a command. io->lock is per io and only taken by
> the task which commits that io, so the fast path gains an uncontended
> lock in a cacheline it writes anyway.
>
> ublk_batch_prep_io() calls __ublk_fetch() with io->lock held, which
> makes the order io->lock, then ubq->cancel_lock.
>
> The readers move under io->lock in the next patch.
>
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  drivers/block/ublk_drv.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 50c99b28ef21..17a33539f271 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -3169,6 +3169,9 @@ ublk_fill_io_cmd(struct ublk_io *io, struct io_urin=
g_cmd *cmd)
>  {
>         struct request *req =3D io->req;
>
> +       /* io->cmd shares its storage with io->req, switch them under io-=
>lock */
> +       lockdep_assert_held(&io->lock);
> +
>         io->cmd =3D cmd;
>         io->flags |=3D UBLK_IO_FLAG_ACTIVE;
>         /* now this cmd slot is owned by ublk driver */
> @@ -3338,8 +3341,11 @@ static int ublk_fetch(struct io_uring_cmd *cmd, st=
ruct ublk_device *ub,
>          */
>         mutex_lock(&ub->mutex);
>         ret =3D ublk_validate_io_buf(ub, cmd, &auto_buf);
> -       if (!ret)
> +       if (!ret) {
> +               ublk_io_lock(io);
>                 ret =3D __ublk_fetch(cmd, ub, io, q_id);
> +               ublk_io_unlock(io);
> +       }
>         if (!ret) {
>                 ublk_apply_io_buf(ub, io, cmd, buf_addr, &auto_buf, NULL)=
;
>                 ublk_mark_io_ready(ub, q_id);
> @@ -3496,7 +3502,9 @@ static int ublk_ch_uring_cmd_local(struct io_uring_=
cmd *cmd,
>                 if (ret)
>                         goto out;
>                 io->res =3D result;
> +               ublk_io_lock(io);
>                 req =3D ublk_fill_io_cmd(io, cmd);
> +               ublk_io_unlock(io);

Taking a spinlock for every ublk I/O completion will be very
expensive. Is it not possible all paths calling ublk_cancel_dev() to
wait for all tags to go idle?

Best,
Caleb

>                 ublk_apply_io_buf(ub, io, cmd, addr, &auto_buf, &buf_idx)=
;
>                 if (buf_idx !=3D UBLK_INVALID_BUF_IDX)
>                         io_buffer_unregister(cmd, buf_idx, issue_flags);
> @@ -3514,7 +3522,9 @@ static int ublk_ch_uring_cmd_local(struct io_uring_=
cmd *cmd,
>                  * uring_cmd active first and prepare for handling new re=
queued
>                  * request
>                  */
> +               ublk_io_lock(io);
>                 req =3D ublk_fill_io_cmd(io, cmd);
> +               ublk_io_unlock(io);
>                 io->buf.addr =3D addr;
>                 if (likely(ublk_get_data(ubq, io, req))) {
>                         __ublk_prep_compl_io_cmd(io, req);
>
> --
> 2.55.0
>
