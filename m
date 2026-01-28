Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8722D0615
	for <linux-block@vger.kernel.org>; Wed, 28 Jan 2026 21:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769634514; cv=pass; b=ZCBXJoMt8V3VjqvQ2G+2gcj4Q42YtTKMdl2PJDceYO0tjpoq/z1XKkq+0+WPlhXaxpTT1hiYI+NQYxIhHlii9yqRQgjBShQ7ip4315YRapWWRp1AO+l/+NKX+811bD7yMF5AC/BiYn8P9tjKFMjbhaagly7V8LxpqDq7fomcnhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769634514; c=relaxed/simple;
	bh=WdCPoPS2+IotNKN5S0uT/x14r6akrWfY5ADNSAnmKqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHTX4Q3oSGxuRPAsRJOcSB9fOfbnEMU8zq+6dDcBX+EoxEo5UKcM5VmuiCYsQIL2XTu3XFZE5eXArYB+3/39On7Kc21pMj8vVmLZG22YxszK+FMgf5EhkA8geuzVlN5xttqrLR29+VzhqmfGpCvwFEM6Gq4K4CF3On3dwFTGdDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Y4eSJ43f; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Y4eSJ43f"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64b6f22bc77so52794a12.1
        for <linux-block@vger.kernel.org>; Wed, 28 Jan 2026 13:08:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769634511; cv=none;
        d=google.com; s=arc-20240605;
        b=PGPAExzYaAesVBfT3wqqoxDlY6Wv3u6ebFctZwKKUQFl6yYXsTp7rnwHKKZ/EGntfl
         kmijZaICJm34N8cJGbajN1qKyUCVvC6gGT9CiBRh4EXDSa8ss5uxrQ2+vfDEIOVXLhW2
         E9bXzmSnUfe6TuUDGzvNDYA0zRZOtqntnxDc1cp6SSL66g70Mpx5bicvMdDrDFWT6t5q
         30I/VAdEPYgIt7pLwFPgLK75PrEvcjmolqJi04eUYgEnPxO/lxifRgVa4BzTIYHZoubC
         q2rnBEP+ZoTu+f46hxYrTcX5kE0IpC6VFGF/+SRYXli/9UWlrZ3iZjV2xMXz2/KFwllU
         14XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=chTnTDsINqo+PlkRWxFD8mWcsw1rbIh1AK+dr3GPZ0A=;
        fh=kOPDeVDEZ/5V2koQb/x+/XXr/NmJfo2PO94VHXB4w5k=;
        b=FDrmGqzyOI+SGVTn4LufOH00ZoxGpx7NeRWclEtGUjXcs4DF/6nFEn2awf9i3s/Rfp
         xFXR9dhrfPasHsF5VlxpLmmEotT8ciTG44MRrirqJa7SJko/XTxQSg4B4rgkBfQ798aM
         m26r/sUNuFycBlng9iZ6qRQk4bi1A88gkAf2wHEaZVxEUsp4uIUq2Pb3CFOs9k+aBzdP
         l8b8Ajq0rLKfYY+LPBM2w1/3lZRSXTw7ycM5H/Ezd3NnwvdoUYui4JngqZFG2d1TgqaD
         AlZR8Aj42kd3JZqxWuakgMb5GBq1pU3+8BBer6B1yW2WbERFZWI5eCSAMsdvHUvRTkDT
         1Iog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769634511; x=1770239311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chTnTDsINqo+PlkRWxFD8mWcsw1rbIh1AK+dr3GPZ0A=;
        b=Y4eSJ43fSA8MHe4YrO8YWMqBAsTygv8odCmyXFDIeVTgi5UBEAr87sZmjd8KQAo2o/
         XJsTq+yQ0mxobJBWmqrrGWNekElzbOkqIxYZ3DmZ9w6BFIHkNuWMYIx/auifVJpwaBA8
         hmWDZhIYwAutKp3IbPIVUjiXLaOIPyv4VINIZ1SY4KciHg/wMNe3YWPRv88eOf8F2bxq
         rb0qH1O7hVMnK7o1ED328t0g+U+IPsZBot4aG7VQ0+FzjEhedHT5a1uJfbNANDKNCTwZ
         RIohz0TK9/YM5vcvPG7Pve49W0QQsTP4ggbKsIMsRezwdzEwvy9QCE7zjojSPpl6KbvR
         1hfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769634511; x=1770239311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=chTnTDsINqo+PlkRWxFD8mWcsw1rbIh1AK+dr3GPZ0A=;
        b=atL2dg5KXGfuAPh0vOH62IlG2IYLUP/bS8Z9iMBTbRTyH8yyZOhcnzZCeIrkfetxeB
         QZ2HmqVw0/8niAM58bqmBMQTZ7/ThSmZbAupODXdR2wme2b8T/Mr9+V7gEZFkNClYGHY
         ChPsyTeHhhtj8lxDeTLu3zYLmlcOVZdnglsB6ZQD8iQXpaXlaj/GLfvg8CDVTLprGY65
         FRn8O7Sde4GsUHEXCVrz2skocyVBxGTGqH3sF81/D3nuy8pnlx2VGmYbUbVtQlN7/wws
         OlGf/9cTLEhm9onx9RVHslTCKsaDpWwgMVjoY7HNLK7VooBfcf2YO/lMHYqELtW4ZcBj
         Xz+Q==
X-Gm-Message-State: AOJu0Yw4xz/gm9L8sg5hbYLbCD9teCgjXsLxR8MKt1WgRtRPlXGbrCLo
	mAfPVwlb+S44IzvHU8D2B2N7jnYbNejGMkMtnj7F/Skm1xrhIpH4kuBJvhXy4An37GO1AWXyMmI
	02aZpK2O5Tql1Hab8Do1SwXdX6VPvrsmqFz2vHPNl5g==
X-Gm-Gg: AZuq6aLZV73lEBSeLp0aPivZowsI03rXX7czrISdmCqEBuoM9gx+AHNYhEQ9FETsq/h
	aEMKVUu8ILZsCX25qtxDeBAQ1vulVRfsGmykMoYIDIHy8uZbeegey3nVqPpBtrE/BVKxNtD9u+K
	hixEyLoQq/tFEXaOA6CuzuYeQVo/cu3Ric63+v0I+POrv+65ljhPRIrFAdLZibLuR+bsUaiQmAC
	XJRKHJriR+texvSWF+J2Aeo0COdvVfqWxTGnLkYLt2Eu2TDmdkM5qeUAWOaGeLjSpdu5IyooJzk
	E9GZn2s=
X-Received: by 2002:a05:6402:210d:b0:649:9aff:9f42 with SMTP id
 4fb4d7f45d1cf-658b9f15bf0mr1110376a12.0.1769634511599; Wed, 28 Jan 2026
 13:08:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128205636.4003327-1-csander@purestorage.com>
In-Reply-To: <20260128205636.4003327-1-csander@purestorage.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 28 Jan 2026 13:08:17 -0800
X-Gm-Features: AZwV_QhiXUfAT2a-RW9zVduIydFzW2BsU2C_Gr_33TCyB_agWqEJB--xLMICRvk
Message-ID: <CADUfDZqH9NZrQGOkYP9cpWRVkhPT9uiPc3XUfW6X4G=97oeE9w@mail.gmail.com>
Subject: Re: [PATCH] ublk: restore auto buf unregister refcount optimization
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 12:56=E2=80=AFPM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> Commit 1ceeedb59749 ("ublk: optimize UBLK_IO_UNREGISTER_IO_BUF on daemon
> task") optimized ublk request buffer unregistration to use a non-atomic
> reference count decrement when performed on the ublk_io's daemon task.
> The optimization applied to auto buffer unregistration, which happens as
> part of handling UBLK_IO_COMMIT_AND_FETCH_REQ on the daemon task.
> However, commit b749965edda8 ("ublk: remove ublk_commit_and_fetch()")
> reordered the ublk_sub_req_ref() for the completed request before the
> io_buffer_unregister_bvec() call. As a result, task_registered_buffers
> is already 0 when io_buffer_unregister_bvec() calls ublk_io_release()
> and the non-atomic refcount optimization doesn't apply.
> Move the io_buffer_unregister_bvec() call back to before
> ublk_need_complete_req() to restore the reference counting optimization.
>
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> Fixes: b749965edda8 ("ublk: remove ublk_commit_and_fetch()")
> ---
>  drivers/block/ublk_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 7981decd1cee..f864a0f2f572 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -3243,15 +3243,15 @@ static int ublk_ch_uring_cmd_local(struct io_urin=
g_cmd *cmd,
>                 if (ret)
>                         goto out;
>                 io->res =3D result;
>                 req =3D ublk_fill_io_cmd(io, cmd);
>                 ret =3D ublk_config_io_buf(ub, io, cmd, addr, &buf_idx);
> +               if (buf_idx !=3D UBLK_INVALID_BUF_IDX)
> +                       io_buffer_unregister_bvec(cmd, buf_idx, issue_fla=
gs);
>                 compl =3D ublk_need_complete_req(ub, io);
>
>                 /* can't touch 'ublk_io' any more */
> -               if (buf_idx !=3D UBLK_INVALID_BUF_IDX)
> -                       io_buffer_unregister_bvec(cmd, buf_idx, issue_fla=
gs);
>                 if (req_op(req) =3D=3D REQ_OP_ZONE_APPEND)
>                         req->__sector =3D addr;
>                 if (compl)
>                         __ublk_complete_rq(req, io, ublk_dev_need_map_io(=
ub), NULL);

I also noticed that the "can't touch 'ublk_io' any more" comment
doesn't make much sense, as __ublk_complete_rq() still accesses (and
even mutates) the struct ublk_io. Am I misunderstanding the comment?
It looks like this might be a race condition for
UBLK_U_IO_COMMIT_IO_CMDS, as __ublk_complete_rq() is called without
holding the ublk_io spinlock.

Thanks,
Caleb
