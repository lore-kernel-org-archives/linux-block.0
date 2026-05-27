Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E95282F00
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 00:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779843233; cv=pass; b=aZ8Tp96flVVKD07Z7uhRISMlJDMDxTdu1v3b2AM93wxV+yEpwkTt3lJqFhRqKARHn+5eKyLsyvBZmuasRf0qBWcWmeJhhS5WMFex1Usrt9L65CJLXeVvRnwiJKMqlwqqVsLvRU8m049OJAU2wCcE8adRdF+1tC4EAahMgjneFE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779843233; c=relaxed/simple;
	bh=jEtZmW4iI6jIA3bRzN5kt8WozNPOZTcP4Cfigf1mbUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7e30qB9sQc/rYNd6TSsftPx4qPGp8lo9jKcfR3bTWe/r2zN5D63gnDO7MFw2DANpVd1gZYEgO3SMdGJjX0rcyxQ+PdrRWAu6YFC0dcF4GcgxZ5JDurw3mhWCoqWFxKKilSBfAv2d+Hl9+FtoTkxxyXR+KQtzYLEpiZ5sRAln+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7tM1C8y; arc=pass smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7tM1C8y"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4854d5cc708so3475521b6e.2
        for <linux-block@vger.kernel.org>; Tue, 26 May 2026 17:53:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779843231; cv=none;
        d=google.com; s=arc-20240605;
        b=ZGzvmsEXkrDJGe+WfzgFf0qzyz9G4bxsflfk+l1rbNMglf+vKkivbgkzDzkP1g/ppH
         VA3FquIhCIgPYLRTqJGALbAVu5hEhLsy4s9NopM3Hiw4iAF2uWADzqYvDWSOjb6aTpq7
         YewZux0f4UMNtxcsQh0DpuV0EFwXLKvOXRqTOkbCLuTHkL+pz4Gh8AJKxPk7I5b1eIqr
         N59709dGsUrhVmoysLYdTA4FELe2MlfANCCtmpcvug7BDrg02JI32mPEQNwoYGhna7GL
         E8HHwETujlnMTDSXzNZhMcsm+YRJ729GD6Rh3tNJWmZxj5ARHogn+j/KrBlcHcbTA3dM
         LxGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Euoe+8m92aVED3ZbjaeLfTLUepBkVK5+E3xInzeEleI=;
        fh=/5bdictZxk31Dc7ysuy6D6fWhC1lon+ivvRzck7hXMI=;
        b=e11TDA1ynsYgDenjAP3n2Phrh6xhqk42BFFKyxqZg81zvGDA79miZO0Q9foEDBJVYF
         Iuf5d6DIuDyaLrc7W6oVqPUMPOlpBLWqPe/8HAS6dbNgNHPNFWfyDrHNfqsW+DnbnRgb
         YuD5shB0GO25keAaPi1g1nr5YHGDSyBiEfaupOCzRLHN9CkU27MkFK8F7Le2O6Vfov11
         4X0gqhMGvVOALp3WM8oon7Y4H71xhNKZnrDL/rkSD5+wPqRQ4EtKoDRV53f9EhjJkoes
         VXAqCZVw53f8yhPs/e8/0nLXPrdgq96Gao3PJ8bIQgp+Yh1KSkCEPCK8N1Elq5Tera7q
         GGhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779843231; x=1780448031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Euoe+8m92aVED3ZbjaeLfTLUepBkVK5+E3xInzeEleI=;
        b=O7tM1C8y0BNd2YbRNorvnWxTci4+vJzFk8hn+hOrHZ/ToK8fSmiz/7YH4mrq1sxZzq
         rxq5P4UV6TU0gfiKcQIPjDr8N+XK6gYeIRa6eSmICv+YJZbtjsUZmV3UpcVjv8YKp9VT
         p8k+k82VSOi7fg5VRq6VSDVLlSWl8ki/BIC/u/wsPniLHuZxzjRJS6nbiSrS0Wb9bkTq
         D4xC3r3A5wxpsW+imZsDduSFSJWFeIubMixJ30sbcDdkBnbm9AFaY3DxwPniQJUL6Gpm
         LVd0a4Hg1WI12ibfH8JkdLSmLbToRsbPK0x/h9TtTS1/DwzIUciFf0Rua4A+zeG2OwRK
         yhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779843231; x=1780448031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Euoe+8m92aVED3ZbjaeLfTLUepBkVK5+E3xInzeEleI=;
        b=cPUzVFaM+79XLVcp7tYhzpqyRrbtt5/yyMov2a/RT1btX0PKjSojQQNjl9nDL9Ljy8
         WupTCerPCmjkTw8AZhlY13Dwhwzj4+HVoNRKNzXyJxqhNZPnlnDnB84sLQ3kkSEusUi3
         XMgSVChYHpujBaAZHuEHweBu4rEJPYq6wD7lb6TBeFXQlPGAz7+bZyQbE7DYU1zskaB+
         YYTzQUL2rS3WLqRsnBPPpbdEBfU/6dgkqkPjHhBFQ7Ay81+BeU8x3NrIqef36JTgfqCo
         XhF4gHqo3tjZmX09yETj0edrfvJpKTA09/1UWSz4G4IIqDLo6ARfCFjz5MfT46/UCZg+
         1zfQ==
X-Gm-Message-State: AOJu0YyJlV4N54PRpN7VEBUkP/g2Rk0Kc218GkE4qDQsyfKD9BqzN+Ju
	uYnefjoguYwyq34KbZjE/r3vVmw2JNvV20/G1xQ50YS8jPcsQ6kDL7wzrjwVb0pRRbQ4WQae06f
	plqC+oCAGPnxA4l0u9oqzAxmssEdgMDk=
X-Gm-Gg: Acq92OGC0XZ8Od+tQWLxtPc/Nt80s0pxp3W5OYRApMS/qerWAwRomYVcWeUKemfNtdN
	QUWqhncXuVMRgI/AXo4cd1kwARV3LNJLVtfOieocbbRfGaftg1WTvQBJFmLwsi9ZnPPlniq5ae/
	zZ49OIojRJNMSw8MskUi+l5tqylA9KaCPjWOGCL27LVte//Z/IthyYOtKHRrqsTn9Rby9hunO2W
	YX9KoxyW/XaQrsg+8ihKtd1CnA0WumhDoI/5hGeBLgo8ZHO+Su0PqDhMjSdd+qEt11N+z6Ge6Vp
	uqonJ/KQFuPCf8wEVJDrWPCTQgfIktTnRezx2xiVbPX1YYD+vui19RJf4HL7K5alq4gmGd0rGxe
	i1KHXVXb7mOVO4CEhOA==
X-Received: by 2002:a05:6808:190f:b0:484:bbd2:850f with SMTP id
 5614622812f47-4854a3f9656mr11904040b6e.27.1779843230914; Tue, 26 May 2026
 17:53:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526153531.2365935-1-kbusch@meta.com>
In-Reply-To: <20260526153531.2365935-1-kbusch@meta.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 26 May 2026 19:53:39 -0500
X-Gm-Features: AVHnY4LBMVm4MDKwk7VD2JmizIpy3TnfwyqlZBtBUa4c9ZoAIdLdLp6YGHB8D64
Message-ID: <CACVXFVNZsA4HzeHX9cbZU3=Y6ss1jATTFSK_6JO=aygxaZgu3Q@mail.gmail.com>
Subject: Re: [PATCHv2] blk-mq: reinsert cached request to the list
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 10:35=E2=80=AFAM Keith Busch <kbusch@meta.com> wrot=
e:
>
> From: Keith Busch <kbusch@kernel.org>
>
> A previous commit removed an optimization out of caution for a scenario
> that turns out not to be real: all the "queue_exit" goto's are safe to
> reinsert the request into the cached_rq's plug list as they are either
> from a non-blocking path, or a successful merge that already holds the
> queue reference. This optimization is most needed for small sequential
> workloads that successfully merge into larger requests.
>
> Fixes: dc278e9bf2b9 ("blk-mq: pop cached request if it is usable")
> Suggested-by: Ming Lei <tom.leiming@gmail.com>
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v1->v2:
>
>   Actually use the correct rq_list function to return the rq to the
>   list.
>
>  block/blk-mq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 28c2d931e75ea..a24175441380e 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3246,7 +3246,7 @@ void blk_mq_submit_bio(struct bio *bio)
>         if (!rq)
>                 blk_queue_exit(q);
>         else
> -               blk_mq_free_request(rq);
> +               rq_list_add_head(&plug->cached_rqs, rq);
>  }

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks,
Ming Lei
