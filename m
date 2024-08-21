Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECA01B5ECE
	for <linux-block@vger.kernel.org>; Wed, 21 Aug 2024 11:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724239576; cv=none; b=Btr+mNOMOwhZR/83bZ8+tjUFYZpqbnVsicpQ2agwatotablgqdatrvYebUCJPTV+v9t0eQZviXlq76gYF+GvBGqTQ/if5p4zyalWZI4751vKWvv7HjLT+4CndoFaDH1+skY7etLqWee3YNI6oCXEhUsmF9Ugjl7GycgQC+uMrH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724239576; c=relaxed/simple;
	bh=yElWb9ZZhW2yCbab1ezlmyNGh8hmgcZwBzhzsCJlNjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XpXwOzjD1XqMGuWsJqrxo9zt0LTA5w/iDq4hyY7GVS56hfb7jipzFi8LLac52usIAC9C1aFDdx27pxe8QrnPVVLP8PwNgcnmbw6WiDhSHAqFCHf9VNswVo0RZfaD80eOQXjPIB04woE+YvDR4sfPLEpGsUlUYsNeXYOnWx0i3Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=RXjuQnwY; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="RXjuQnwY"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f3ce5bc6adso42883241fa.1
        for <linux-block@vger.kernel.org>; Wed, 21 Aug 2024 04:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1724239571; x=1724844371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8q/R7X9tHOf4FIWUm9tl55XuJIWX21G4imgxVA6lmzc=;
        b=RXjuQnwYZZp/sxLeELkeg49IO1K1afBS3KD3OuPHubsBmfPmSopTRoYPa3m4Z57MKJ
         UMowmoW0kWdqQzN4uQ16r3yy2vSqDmhmy6IWGy7XjRKo0jJaSHQT5lF5zQrEyhua8/wr
         HzjG9T44cC/fiQgJB2YUzOrRlPLDY/URnPfNafCpBgWorvxqNr5XcSQ08iV6R5nkX37M
         uL+zEbprnPB7SFmwXnwqbbiih+IAUu6ZqvpJvHMPmqaOdXqp0AbXA2KS0QEXONWdVJD4
         sQVOWeWq5o5YSdI7tOigMCy2DCqLxbXr8kcAzhVYIqMG7vX4XCHnQugVN6HlV27vgFFQ
         W2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724239571; x=1724844371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8q/R7X9tHOf4FIWUm9tl55XuJIWX21G4imgxVA6lmzc=;
        b=Mi/ErfLlsmd8R9LrUyBaTqLVMvQ57fDeuUCNZv9TdBB0RoigM4exAS6N9zEmQ5MTyK
         QUiqsXTLg6qBxNHdhPm31+3LDSMA6VJpyXdYYVOpTy4euXUbx2NRfXjbJLTjOGKR1O/l
         Ek3oz41OBqO0BKZKxwHIlwh0LR/8891oa+pjzVS4qKdIX58E3Wvaj3MjZgnhzycEp/g0
         MeAFUPWCRPbJKriw2Pj9kAo4+3n3JUnL3RaM+rBGmZC8FePLJxtUY0Kjm5VL1Bw8Q5KN
         e3Q8nXVacYgQZGxo7wrwF81uC+XoZvichAOr/Qyc1P+ZiVZMJpaOi/K4YaYY5L4dmcDj
         qclA==
X-Gm-Message-State: AOJu0YzyIbLLXTPWPP/fiLF/m7gU/JsRK9UPV9Bcw6oAmSKaqMVmmJtV
	BDd2uhDI+4uFbreYS5VCym5WGHtslY4LNfsadVI4AisxO/Vcd+LVMK3GhZjCpx5nspzeXFS6DZA
	XWXSu8ep+Ewd4yikB97+jLggDEnCHA07hc1HZCeY4xfpkPF9tGVk=
X-Google-Smtp-Source: AGHT+IFl0FXoAR1VtaeKTmF5DiYk75eaCRh1y239UkB5caEytNvlxpOKX+ZjVnuLfKz9sZbVtBemaCDHBTv9X+5DaIU=
X-Received: by 2002:a05:651c:1063:b0:2f3:cd4d:5b90 with SMTP id
 38308e7fff4ca-2f3f891586cmr13750911fa.28.1724239570907; Wed, 21 Aug 2024
 04:26:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809135346.978320-1-haris.iqbal@ionos.com>
In-Reply-To: <20240809135346.978320-1-haris.iqbal@ionos.com>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Wed, 21 Aug 2024 13:25:59 +0200
Message-ID: <CAJpMwyhLMNJYbuLT4h7g5PM9iWQV072qc6fWUSP3F+s4-ypO0Q@mail.gmail.com>
Subject: Re: [PATCH for-next] block/rnbd-srv: Add sanity check and remove
 redundant assignment
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me, bvanassche@acm.org, 
	jinpu.wang@ionos.com, Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 3:54=E2=80=AFPM Md Haris Iqbal <haris.iqbal@ionos.co=
m> wrote:
>
> The bio->bi_iter.bi_size is updated when bio_add_page() is called. So we
> do not need to assign msg->bi_size again to it, since its redudant and
> can also be harmful. Instead we can use it to add a sanity check, which
> checks the locally calculated bi_size, with the one sent in msg.
>
> Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
> ---
>  drivers/block/rnbd/rnbd-srv.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.=
c
> index f6e3a3c4b76c..08ce6d96d04c 100644
> --- a/drivers/block/rnbd/rnbd-srv.c
> +++ b/drivers/block/rnbd/rnbd-srv.c
> @@ -149,15 +149,22 @@ static int process_rdma(struct rnbd_srv_session *sr=
v_sess,
>                         rnbd_to_bio_flags(le32_to_cpu(msg->rw)), GFP_KERN=
EL);
>         if (bio_add_page(bio, virt_to_page(data), datalen,
>                         offset_in_page(data)) !=3D datalen) {
> -               rnbd_srv_err(sess_dev, "Failed to map data to bio\n");
> +               rnbd_srv_err_rl(sess_dev, "Failed to map data to bio\n");
>                 err =3D -EINVAL;
>                 goto bio_put;
>         }
>
> +       bio->bi_opf =3D rnbd_to_bio_flags(le32_to_cpu(msg->rw));
> +       if (bio_has_data(bio) &&
> +           bio->bi_iter.bi_size !=3D le32_to_cpu(msg->bi_size)) {
> +               rnbd_srv_err_rl(sess_dev, "Datalen mismatch:  bio bi_size=
 (%u), bi_size (%u)\n",
> +                               bio->bi_iter.bi_size, msg->bi_size);
> +               err =3D -EINVAL;
> +               goto bio_put;
> +       }
>         bio->bi_end_io =3D rnbd_dev_bi_end_io;
>         bio->bi_private =3D priv;
>         bio->bi_iter.bi_sector =3D le64_to_cpu(msg->sector);
> -       bio->bi_iter.bi_size =3D le32_to_cpu(msg->bi_size);
>         prio =3D srv_sess->ver < RNBD_PROTO_VER_MAJOR ||
>                usrlen < sizeof(*msg) ? 0 : le16_to_cpu(msg->prio);
>         bio_set_prio(bio, prio);
> --
> 2.25.1

Gentle ping.

>
