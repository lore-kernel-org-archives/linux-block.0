Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5C43DB31B
	for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 02:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789093356; cv=pass; b=oU1g18gYXVBgQLbx7xKJzcSJ70QYvX4lDBWKG5gA/PLjsXiNpZi9INWpWolEOUszI8oNWrajoHjBFbPxR/hTpfq+DTDyr9z2S7+hmWAbjMvYUj6Pwac2mSvwNm4AfRhDOwu5LmTbOaKFj0TjipMsDW0qasqMvzmFIscqXW3Xihc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789093356; c=relaxed/simple;
	bh=Bz0sCgcCcFvltEMwQaua+/B5cZV1CmGcPPxBoEWouf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKGm0vyi2V7hwFZNuHfG2529xe1ug3Vra+6o6YCJrHHeIvQ+nU6bG981UQf7CamNFWmBXWKFFo8G8j1yK3ieNHsCpVG9zOTVhbhKkst/QsIN7q7U51wFRV4I4/Ypv0B6Ll6zUHUNbDWe8o+wM4tRGim95ioAw2g3Z2YgmGudeww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cptcqt6S; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cptcqt6S"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a0de062db5so790037a12.1
        for <linux-block@vger.kernel.org>; Thu, 10 Sep 2026 19:22:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789093353; cv=none;
        d=google.com; s=arc-20260327;
        b=QQCVX3FBbETKHFOtmh+a05s5dM24CLO3comR2FlIS26y0ZTS+VtVoDOAiYeZy4iYFU
         Jsd0nvFH81XizYmG+BrJRBpJN0IeXdSzmRN+1grojm3tclmdMf8YQ9YwDUs36PjHLFgj
         DzQvt3GPBPLrTa8Z8FYnPrj6wsm7Ifq6sL0FfQgijx/zxpPBR1P6Cg4qiNgwj08ksRQJ
         hvMUJFTN8ljbR/C/1kfyt6ibMseqs7D21aKm51Ele66YODHemDkXAfL/jqOK5EIdAglt
         q0VkaDlScX0DdGvDFXXC1SweAiIiHG32uRzeI0kVslgJV5A4OYmOuStSumPaLdFKhhcT
         G0VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zzI+H0AYETX+xpgB1CN8oegHDhglD5FDUHZp3f5RBM0=;
        fh=CDdn3fIAI5hd5xa6NfAMUSNUX9JMg0NhEyafsBhQkgU=;
        b=WYiLvKUiJxsdM8hq9jJ0TCUTphQWjHur+QLIGDjS5FQIn2DL7bYURHcMmI/Dcoyscm
         2LOCWfXPXy2sdJYFd9UAT+y3F4o4Khrycy7IGAizjD+ycP/ywNMvCdkzmAwKT/U0XfBD
         3o7fKAanKeYSKj6yonwlqwjVpaBvNgdCSboEmKXXCUH4w2ocQtWumHnjcssMgXNYgCr/
         JRJ+N3Y9WhxGAYeC23SDNKrnO0LLZ0IWdaCAXrvbZFtfEocU2prCQQihu4AyxHhWNDlW
         fLh65t8/NrmNX6JiyexGTn3G/iCiZJdDPBakF7hbW4NM1DYszD2AcWhPLXIbFXJaz8Rd
         Jy7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789093353; x=1789698153; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zzI+H0AYETX+xpgB1CN8oegHDhglD5FDUHZp3f5RBM0=;
        b=Cptcqt6ScpqGb+URyJ3Ec2fUg3HynYHi4aLZF1yLhpqbeEivPxohoEdtZnwEyJ54Fl
         q6G/qi/2/EsF9tqb79rSNz2BJpx1v8bTzA/WOrvhLJRM8cceKP9QtHqPuOoxZrTxpJVQ
         LwhjR7xA2BK1RNTgt2H3Fq1+Nxf4ru7VM+XP3iZA6/j9C007tx/Uq1kw4b9c1YYgHo+z
         wSNRd+/hP/BDO7+WPuOL0sMBbyV4aUZSjLNKdLQcVqMbiHPJu9CsRvidsZX5vIUJ7Bea
         I9y4x4hLVPaJuTbAKONX0kDQ03FFjybMpQK8zrIQzHUAcuU9W98pO7OFrERVn4VMvc35
         5V9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789093353; x=1789698153;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zzI+H0AYETX+xpgB1CN8oegHDhglD5FDUHZp3f5RBM0=;
        b=Saz1L4wnSjoP/i5La0H3m67HnMZtGjiKbuV87xD623hfGvwHvefr057zlPVSaVaqpQ
         eEsqOtJ5z6J4qyRj61ETvqdnJuoJS4VJQC4qKQaZD03ckWDZwGBLOjYX8DoQP8KPY9XQ
         9XZ5953IXKiBq5M3LRo3cJ2JhhWuSTgYtslHs1U/9NWZHSsuN2OBty+xlWXJhU4fdu5d
         rbY5ct5nZTzGW8TiuWEulA1QqlhQgVnSacMsWXbW5RuHe3f+FbdjWXmcKnz2GZxlefsj
         Po0k5Uj6G4EQ7hT6YkBFs3Zq5iNjdZqQjAAwHzHP2xbhz1JVUQdFnMBKcgfdYb6cdyVA
         w9fg==
X-Forwarded-Encrypted: i=1; AKwUvByZKsW1LiDjb4MWK/7kFd4tlPwF8Xy+4+140zWdWfS5w21tVgrsHabca+hcZhoEI9aCO3Xs/oYn+a4jZg==@vger.kernel.org
X-Gm-Message-State: AFuF++kCcN6658D19w3BJehjgho40RcR+4vYb++EyXYqsMC9zVYprNOe
	GiFXtw7iXMlmdb5FMciBgIhF7id2JyToW4tvtMQoT+31uEAQyhdxgv2HrLqxiqfz+IxiDB7D0IA
	+pZKjjIPiiuES/Dm+KKz5T7IHzXk3x/o=
X-Gm-Gg: AYBFou0twnjIwURDypDC+9X41jgIS6nNxabknp1o89qeDgTngRJ1MivSc1ZmwwnkKuU
	cFC4u1L65iElkswjmKfQE9gpDhY5w+Sjqrx54JFeNA9o8yDvj7fGnLtnv3aXscSS5bDbPhCycNr
	F48L2VARi9ZXuMq3rZr7jdZSqu80GAui04vGdp1o71ogluOalCS5lyZymBDCa6ShAHyFSBhMg5h
	ppps/O2TlAPc9TlGcan1QCCiffFAWP1UwH7wtLWpd3WNLKq9Xk5LIPyFZYEYDFTQ9U68Ccyz8Yu
	9tqBvFZFSmE1XP29kQNSeuZ0oE7pUVVpiFl0qX355JmRGaFGWMSqTAy7ESJR30X9DvyzD6E35M8
	Ibk0o3BGiie8=
X-Received: by 2002:a05:6402:50cd:b0:6a8:d72a:3b23 with SMTP id
 4fb4d7f45d1cf-6a9b56f9fccmr842660a12.43.1789093353125; Thu, 10 Sep 2026
 19:22:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911-virtblk_sync_quiesce-v1-1-a883f8f31258@oss.qualcomm.com>
In-Reply-To: <20260911-virtblk_sync_quiesce-v1-1-a883f8f31258@oss.qualcomm.com>
From: Jason Wang <jasowangio@gmail.com>
Date: Fri, 11 Sep 2026 10:22:21 +0800
X-Gm-Features: AcwNN1Uzpxn8BhhthHEzwNinazI3iL-_kocBQlmIkQ9u52465cUbeWR1Pr_TyGY
Message-ID: <CAAf7B_Oi_z7M_A_LwoAs_CAvhuk1NGxvADQssE65_OcTroncXw@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: use synchronous quiesce in virtblk_freeze_priv()
To: Cong Zhang <cong.zhang@oss.qualcomm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>, 
	linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 12:31=E2=80=AFAM Cong Zhang <cong.zhang@oss.qualcom=
m.com> wrote:
>
> Replace blk_mq_quiesce_queue_nowait() with blk_mq_quiesce_queue() in
> virtblk_freeze_priv().
>
> Keep the existing freeze and unfreeze order. The synchronous call waits
> for dispatch code that was already running. The queue remains quiesced
> until virtblk_restore_priv() calls blk_mq_unquiesce_queue().
>
> Fixes: 7678abee0867 ("virtio-blk: don't keep queue frozen during system s=
uspend")
>

Do we need this for -stable?

> Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
> ---
> blk_mq_run_work_fn() can call blk_mq_sched_dispatch_requests() through
> blk_mq_run_dispatch_ops(). The dispatcher checks QUEUE_FLAG_QUIESCED
> while the flag is clear. It can then be preempted before it gets a
> request. At that time, it has no queue usage reference, so
> blk_mq_freeze_queue() does not wait for it.
>
> virtblk_freeze_priv() then calls blk_mq_quiesce_queue_nowait() and
> blk_mq_unfreeze_queue(). A new request can enter the queue. The old
> dispatcher can run again, use its old flag check, get the new request,
> and call virtio_queue_rq(). At the same time, virtblk_freeze_priv() can
> reset the device, delete the virtqueues, and free vblk->vqs. The old
> dispatcher can then use a deleted virtqueue or a NULL vblk->vqs, and the
> kernel can crash.
> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 32bf3ba07a9d..7a570591e040 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1595,7 +1595,7 @@ static int virtblk_freeze_priv(struct virtio_device=
 *vdev)
>
>         /* Ensure no requests in virtqueues before deleting vqs. */
>         memflags =3D blk_mq_freeze_queue(q);
> -       blk_mq_quiesce_queue_nowait(q);
> +       blk_mq_quiesce_queue(q);
>         blk_mq_unfreeze_queue(q, memflags);
>
>         /* Ensure we don't receive any more interrupts */
>
> ---
> base-commit: 50d05c7c76c96b90462f24debacca971d2e86713
> change-id: 20260910-virtblk_sync_quiesce-9b2c88d45416
>
> Best regards,
> --
> Cong Zhang <cong.zhang@oss.qualcomm.com>
>

Other than this,

Acked-by: Jason Wang <jasowangio@gmail.com>

Thanks
