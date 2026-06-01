Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C69537F756
	for <linux-block@vger.kernel.org>; Mon,  1 Jun 2026 22:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780352497; cv=pass; b=EbsBJQVErM/V3RCtPfSBtjMXYGc+yUEyLo1up3P4OOAeWPXqJdejfFjyEkPVh7SDI2AK+L4gp8agiBBv+I+dm8K4BDWj1I4z2fBV0E+X4fifTBCvsvlsqOsoX3d2c0om2q0C7hkwKFN0NF2QBaAYzeCYPgMR3LXbV2WNsFYk2gI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780352497; c=relaxed/simple;
	bh=KxQkfsKZeivLewXMPpdfYXxGpNj8gOeUAOAB3xPYlpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=muvlp8ZFdFd5WCuwDIlgCzNxhBiXpMR1Gfns4ScOVqJp/6YVs8jloIYZI45F7ekkPCmwJwvuYljO2mlAlJEZaUIyl3Ra7BoLPOd/isM4EzpCN7jVFD/yoGW2UPoUdoz6IgySIMl0Re0zhDHY6LCkYxK4Ldj4/pgZBJyF3pzAgZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMGGw//0; arc=pass smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMGGw//0"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-48611ab8fceso1415405b6e.1
        for <linux-block@vger.kernel.org>; Mon, 01 Jun 2026 15:21:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780352495; cv=none;
        d=google.com; s=arc-20240605;
        b=i3zn0uLbRAkCcLk7ljve7fl7DcbAsHFQrYpaCxbS9vhLjsDdtZxl9p03uWRHuFFx6D
         8rO1HQQ9A2Iso/q2q+HamQFPsompr4AAOYtnWog7PbR+MV4B6P5CKWiZAVAtOsJqmmtX
         yXss3f4uz+tle/QEaUC7+dzV5uG4KtDQRBmxWwWLfl4ft7Tb7YkBOI4YzISJlLE+YbgE
         G5bsgXv5vRXqt4ikUCjpcLKOiqzihbafhmJvqW2IrLZcXAx2MujJcZ1jT4AFBgDtNd0I
         LeNbBtIMK26wlkuTG0BV3bn0uAtYgDVfE6nZ+H9jtIIPrpB7/N2onlMq37i54xveWo4U
         YYgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3BdnP/6TNVAsxcaayiKJjGNALyqAthWM795Wx9+Pzhc=;
        fh=eQZ5Gq/kLzFa7ymh7+87rJphBbkIzj+MvD13e5pS4IQ=;
        b=E/ipTo8/Chkn0VokgYJ+h8SoVY99sU1LrphPvC8Fk8rI0PxA8d3vD7i1qjdrl9kDro
         KpzDGhZyylqkKt4Gdk0U81qVIvY/kCqNj0DcMah51Wceoji5JIcMEUPcbnWR9CA4WeCc
         jVp08qx+XpPXR9xM1PtcBi4ldWdcURrwtVxDdKK2jPVifuAFaQEB+sBHsl+B7QXw2JOg
         4WRky26ENKRED1jm8LUX0L41Ei7LTzHmmcwUR58u7pZSI+jCSiHGReXGbm8I/FCSZpFT
         6Fhn9MMt4pDX+CYUekncUe427jxAVL2HOL/AEwv7yXntHovYqauYFXThinqo9T/7jV7/
         AtoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780352495; x=1780957295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BdnP/6TNVAsxcaayiKJjGNALyqAthWM795Wx9+Pzhc=;
        b=lMGGw//0NCICB/jRxUBpuri3xsaGywnk/nVkrHk4mICtpDOk1R6KQDf8fKvg8uhK+L
         TdpyovsXI2Zk8jMIn6gO/j3VbTfEeCyzjf8c8bDgkNAIYeGNgI9izH8YhQ5IX+TgdJL4
         6lEjlopwhB0j3GyqGF8Z4eZFYsGJUkw6feH8/AsFdIApPH5NOMaBrN/Xry+iCcWEVTZL
         j7jPa31bs8vS8Rs5pA4BcV+PnmbEWY0VJ1OUYnmZYDLPzhluvzybShvH7BAdFws+8mMQ
         XzgBNoNvXN581Wx7KRh+n04Jdp4ph7G+WAkaSs6RVAZNapA2Nh23e67Q/sRNecZXzdi3
         eABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780352495; x=1780957295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3BdnP/6TNVAsxcaayiKJjGNALyqAthWM795Wx9+Pzhc=;
        b=M3Cektw7NsT2AAz4W6w8IgH3t1JS0UzCKGz9kQ1Efs6NQHnSUcO63SNEnBHJXaiXo/
         yt67Qn+XwShzvTgfpnvHH995lTfKiFTxjnxIazJOym8BBzeb7t0+bvCitrb5eogG0Nt8
         hynCbq2kTaFiIzndoE3fddq7RwzRl3sF/eOvevkVBbhfAseUVry6Qm2fgF/+P4IIgKLO
         3OI5vF4gbDNpqmiD3WYsBNi86ks/FqAok05XnrvmQZJnuHd0rMevE0Av11ET4pXab5aC
         Mnybz9Cs87rlldV/3uK9c6lWDWgoxlZzs2M/wQ4WMsPVv85Nt7bjiPG3ZONWuSxKxPbA
         01dQ==
X-Forwarded-Encrypted: i=1; AFNElJ9zervGarWtuQ5JAednEwbLxqQPmm1oLm1gxGYxm73RkEJUspRtygPNM+6pfMX6bsyhDwqPJ/UAt/xjUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ScExUPMUFPgTekU3WqiBstKuRAUbC+Wj32HeMRcdXw4rJ/4G
	Z1Lfjb+9E9+2m7rhmh381ntCv4HTm4/pFxxlytGoo4qGc8Yst35Y+SOdK+CUy2hVqgA9kwNaSJ2
	dulcdqrKVb9vOieY6OsesXbrfuzEZV/Z/J1bwNik=
X-Gm-Gg: Acq92OErRMSbQlf0L+fWlImJXqxfpr6poQe2iu84CpqRik5ZVmZifB5z9j9MA/5hc+b
	WOCHws+7Hh0mk6D5QnKCs2Mb2FSfK2KB5vSA18iAh9x+v4T9su1JdBvMGZGO1zzPQSZnMjISdwd
	gINoiAx8xdQGqKO9xEZSDfEuSLRTjofREy0fpnONGJ9280R3iZiNBhgGR7SKk8AKQCYjSA2WQz9
	FwAmzVWmJFC2kPQVqrWjMXJRG3emQ0S79chxbLGtcrD/tLr4oKWSfpHfckueOzwqd1Jlwntl0XO
	heWfOGQmUcsS3n4bawWpbsI2oe21p6Q2WuRq2JP4U8+4dHT5Ty/GsR5xpH7dPDmi+BfZQlCUwir
	rP7sEiHtL9j7LngUH5X/DSHmSdPJP
X-Received: by 2002:a05:6808:22a5:b0:467:16e4:d263 with SMTP id
 5614622812f47-485fb61b153mr7764505b6e.44.1780352495232; Mon, 01 Jun 2026
 15:21:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601185544.1180263-1-yun.zhou@windriver.com>
In-Reply-To: <20260601185544.1180263-1-yun.zhou@windriver.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Mon, 1 Jun 2026 17:21:23 -0500
X-Gm-Features: AVHnY4JYPYTP9X70Y4aNRm5ImCSMHZArXYheqmU083lTNLElu8QsxGddC8xS4sM
Message-ID: <CACVXFVNCBKfj_WTR2P+=2bQ94ki-af-eQRAPjg+yQqDzPObn4A@mail.gmail.com>
Subject: Re: [PATCH] ublk: fix null-ptr-deref in ublk_queue_cmd
To: Yun Zhou <yun.zhou@windriver.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 1:55=E2=80=AFPM Yun Zhou <yun.zhou@windriver.com> wr=
ote:
>
> ublk_queue_cmd() dereferences ios[tag].cmd without NULL check. The cmd
> pointer can be NULL when ublk_cancel_cmd() races with IO dispatch during
> server teardown:
>
>   CPU0 (partition scan work)        CPU1 (io_uring cancel callback)
>   ublk_queue_rq()
>     ublk_prep_req() -> OK
>     check canceling -> false
>                                     ublk_start_cancel()
>                                       quiesce, set canceling, unquiesce
>                                     ublk_cancel_cmd()
>                                       io->cmd =3D NULL
>     ublk_queue_cmd()
>       cmd =3D ios[tag].cmd  -> NULL
>       ublk_get_uring_cmd_pdu(cmd) -> null-ptr-deref
>
> The race window exists because ublk_cancel_cmd() can execute between the
> canceling flag check and the cmd dereference in ublk_queue_cmd(). This
> cannot be closed with simple synchronization since blk_mq_quiesce_queue
> only waits for in-flight dispatches, not requests already past the
> canceling check.
>
> Fix by checking cmd for NULL before dereferencing. When NULL, abort the
> request via __ublk_abort_rq() which handles both recovery (requeue) and
> non-recovery (end with IOERR) cases.
>
> Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver=
")
> Reported-by: syzbot+415b9ec753cd2a196087@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D415b9ec753cd2a196087
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>

Hello Yun,

It should have been addressed by the following commit:

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git/commit/?h=
=3Dfor-7.2/block&id=3D1133b93fc7f63defaa2c07d5f49873c14bb74681



Thanks,
Ming Lei
