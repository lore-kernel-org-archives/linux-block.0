Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793619414;
	b=4az5D6O68PoWeOm1V++822ItH2IFLg9Ati9HScq3WG+aWn/CTaY+w/eZ7glmlIMsoTvB
	 pIRkV5ZQgirIF6/qDhEykRFZJ7gtwmGYqxS8R9lEd8D9fAoqyysUA6pKPh3fR+KExTdub
	 7eYXeHpoUGiWOfBfxFQ61Lw8Ew+PphKiAQ5MRBYzFJZqQUSsGygKBd08VvRqwasJrg4ge
	 9COAr/N7yU1VajVmC1Irf5eKwuTQCKirxqv605FLGvmZc2kLdQORH53TsXWLjZUl9tIRX
	 IatwqHCsZkexo6BApQ4srZGz96mQhm9keNR871xSLV4812zXNZhg5WOQ112p7mxgMiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619414;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=80ZbKnrW2IZYGw7v1ERQO2E3dXCD+w6awQyjKSE3ZYM=;
	b=Lm0SD6WvDVwcLG34vmAqqc4JTnRx1ZUbH5AoRITeCrE124jaNeJQpKn63aG40AnCVakT
	 rTS9gFLFiqUGqSlm48K1XQ5ptx+Yf3pSdxJa+rdMrnBZtCwFQDgUb3E4YBrmyDIlJXo3N
	 XKJXqoHiORGQo/2Kn2fKTyGJHi15Ze9KVs/q9/iJw4EKGm2O1oHiz1JDCfA2OF3Lg04v3
	 kJfsVr2G7YeJ6mKwhVEfPzSxS+iIeLkpP3ANZ9CqxOxJ9L7qldVi5aa92c51HBs9FtYaa
	 0YNs8tvYzm4/0VFcCQtHwmizlYp05eSjQQ/+5Jdpdg2OcXyZ5v6PMXiONiLqnLw7R/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloud.ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=cloud.ionos.com header.i=@cloud.ionos.com header.a=rsa-sha256 header.s=google header.b=OmHjkXQs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E75D606A326
	for <linux-block@vger.kernel.org>; Mon,  2 Nov 2026 11:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E75D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.a=rsa-sha256 header.s=google header.b=OmHjkXQs
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c3fae9338f0so53980166b.2
        for <linux-block@vger.kernel.org>; Mon, 02 Nov 2026 03:36:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793619412; cv=none;
        d=google.com; s=arc-20260327;
        b=a2bJfsp7WyJQTWuxfgcsDgkQKrDBLCppfqQdcvLoqaDV9ho65hZjTjEcmMEx9aq6zE
         tA/8S9g1lvN/BlWnwhSBLFNZOCjKBQcs32ZmGvJ2nYslNexURHD9J4JIBpX/5ktWoC/L
         3Ft4kjKSmWlB7BQ+QSYCaxEcC67WXYbFxqFjTFXuotTV35FAukm8qEn0Y4171upog6Q6
         M+zY+A1qM46xN9XFmQVFikPC1GdACfhc1aL8e+my6bV2Nnq9GoE0fElPrp8RxWQDNIC3
         lLZm8eejVGMVK9Jfz3UTcooD1j4AUd5SWMR5o7Sy8/aL8CZdHVkVzjwVuBf+BwlN0lO+
         b9eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=80ZbKnrW2IZYGw7v1ERQO2E3dXCD+w6awQyjKSE3ZYM=;
        fh=btA9tRKA72FE5lYTs8mUV25mWVQGYYa0X0A3wgN7RWs=;
        b=YEngC2b6ldQWa2XGbDIvtBs/qBsxmm75GSTqixVV0EcJ6iiKChvwt1xjjyLUzBbp9/
         dPMqDH/GEu+33ZKr8Sj47qbhnUeroZgm7Sp6rB4nWRIuzhUgUWc3ppNwksG8pAgu+/hF
         EIWGiAyEAwqhNTtd0Dn7QpybfdGbxUZrRo5Kss400OWogAfFaVExbG6uVupVndwV2uF7
         LKq9UbzTV6lnLhyD8L7k6fkVIoV3B/+H9MBOQ+4xi3sMItMo+sphytEWfsDkCLsS4DEQ
         ZeU/usnZUDrLAbpwOy4XOGXpXmaqo9MsPic1lqKIZNBSLf2cn9SLmun8bfQasg+8PcwC
         883g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google; t=1793619412; x=1794224212; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=80ZbKnrW2IZYGw7v1ERQO2E3dXCD+w6awQyjKSE3ZYM=;
        b=OmHjkXQsTO1mJ1k2kR1Lo33/dtduYEICTGsW1tO1XyoOc09DT6PiEJA2oyhWJUW6Zv
         2/TOEq9MGvea7ynfaSDGvTfvmTAqkQqTRYLsOhJv3nGY8jEFGvM2wwL/LcPS4Z0GbHr6
         +HbX52X781lISIbfOf34mZPb0pNUdjjsL4/GFN+PtGorz9p+XHBtFhLLV7iFLSw+2D8o
         mgv8Dpx9i9pdIcvyVty7rxyxOJYX2jiSBgmuNk8fBRC8F1S7hy3088GpqYv7sQxNcTN0
         mRjCKO240/Qr27AYwwuPCzmb/zA9xTS8el5V8w7pT2WRFyszq31ebP3Zi/LBuWZ5Lfx+
         R1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793619412; x=1794224212;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=80ZbKnrW2IZYGw7v1ERQO2E3dXCD+w6awQyjKSE3ZYM=;
        b=y9wE0FONWbkRsFUeJrMNrn5dQwHm2kZUdiVGMf0c0bfxK2jYyClB/tByjw9UZqgBpd
         BXftTvUlYUU6qm7Npd2w4ivmu2bOzWzMVcpuqlVMFc0EhfZ/xzuIaSefZ4c9kGo9Mx4B
         Bh9u4OeqpfhRnq7Ec+RxJlQeGxrDwc0OnAPTw9zGdOe/kQQmsLVz9QcXBoqtzDMInQJw
         ayRt1UUdoM1Ev2Y7Z51EUTGQo2kGUKfMItrbvtiaNvWzBHwnqDfjRDAqij436UqfTsNm
         BrPma8g7zwLrSMQByztHDBKc2mjt9bNYA89x3F0JH7+wt67JUcTMMq8yWXtNYmvhiuQV
         XbSQ==
X-Gm-Message-State: AFq9FYK3wqaM3XKrGDHH6e+9JS1sUXnz8urJ3DoU4Si2/rDl7SI8H0Zl
	4n79uAwRas9XOiZ2VslL/pa2L9S6zOTqWMzwAj4nc0RWRkJcH2XMo6eylHSWiecx5JSPCd1+rvd
	o7icU2c6PJVS6Mle/nO14zvYJb/I02T8MPnddYWFBLw==
X-Gm-Gg: AYBFou1bLMVoh+fj9aa8o0j11Q7IWZ9Mnnnls3gPeqpfc/5+y4HaNC+PBLFqbyt8WFK
	RX56hNungQxNTjEPfztfTBsUbk7Bf0GRp2q9RSxGl6DENFKmAyTrTrFihe/z4QJC1iBh4qdKtr4
	fMNnKWm3qb1qNsr+OiLzK3dIBhW0jyAEGoN4N2cicuEYPMf1OsN+plQy3LgyEUGb3aKre6/OJ56
	K35ZuyaYaQnC05MMz0DPPni5HYL8EKCY382WsDd3pwQ2r4MC7rYHL3us3ewwr0Pa7lBpQumc9Rz
	XdCLuQDgFa3Ab3TW+vShZn4/Ee0mTz5ef4FPw8ACgiHdAQnfJorjp3GaCRvUPv3jxTp6MtzpvMx
	sO6ivFF+p7mfW0CPZOq+w+kmuUYMuwvvnge6egDZkjHFrUvX/e0uASuE1VxR/y1oeuXoDeQ==
X-Received: by 2002:a17:906:4bc4:b0:c32:8cbb:fac with SMTP id
 a640c23a62f3a-c4ca7a863bdmr788272266b.3.1793619411915; Mon, 02 Nov 2026
 03:36:51 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028164415.1262013-1-axboe@kernel.dk> <20261028164415.1262013-41-axboe@kernel.dk>
In-Reply-To: <20261028164415.1262013-41-axboe@kernel.dk>
From: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date: Mon, 2 Nov 2026 12:36:41 +0100
X-Gm-Features: AclHuK8svuoxXejxtQrOiCIFxwEGBpvE3P9t_-WF-V82zLMATiJBy_6hjXk6grA
Message-ID: <CAMGffE=pA6AD+5aaiiHmZeG+AXySwhf-CC0rpD0Tus24oQ=iCw@mail.gmail.com>
Subject: Re: [PATCH 40/98] rnbd-srv: publish the sess_dev at the end of OPEN
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Chris Mason <mason@kernel.org>, 
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 5:45=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> From: Chris Mason <mason@kernel.org>
>
> rnbd_sess_dev_alloc() stores the empty sess_dev in the XArray as its
> first step. An IO message with the new ID from another connection can
> find it before bdev_file is set, or hold a reference while a failing
> OPEN frees it after a mere RCU grace period. Both are reachable from any
> host that can open a device.
>
> Reserve the ID with a NULL entry and store the sess_dev once nothing can
> fail anymore. The error path still erases the ID, and no longer needs
> synchronize_rcu().
>
> Fixes: 2de6c8de192b ("block/rnbd: server: main functionality")
> Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
> Cc: Jack Wang <jinpu.wang@ionos.com>
> Signed-off-by: Chris Mason <mason@kernel.org>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Thx!
> ---
>  drivers/block/rnbd/rnbd-srv.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.=
c
> index 1cfa2c580759..1c80e8fe0267 100644
> --- a/drivers/block/rnbd/rnbd-srv.c
> +++ b/drivers/block/rnbd/rnbd-srv.c
> @@ -431,7 +431,7 @@ static struct rnbd_srv_sess_dev
>         if (!sess_dev)
>                 return ERR_PTR(-ENOMEM);
>
> -       error =3D xa_alloc(&srv_sess->index_idr, &sess_dev->device_id, se=
ss_dev,
> +       error =3D xa_alloc(&srv_sess->index_idr, &sess_dev->device_id, NU=
LL,
>                          xa_limit_32b, GFP_NOWAIT);
>         if (error < 0) {
>                 pr_warn("Allocating idr failed, err: %d\n", error);
> @@ -802,6 +802,13 @@ static int process_msg_open(struct rnbd_srv_session =
*srv_sess,
>         list_add(&srv_sess_dev->dev_list, &srv_dev->sess_dev_list);
>         mutex_unlock(&srv_dev->lock);
>
> +       /*
> +        * Nothing fails from here on, so let I/O messages find the sess_=
dev.
> +        * The ID is reserved, so this store allocates nothing.
> +        */
> +       xa_store(&srv_sess->index_idr, srv_sess_dev->device_id, srv_sess_=
dev,
> +                GFP_KERNEL);
> +
>         rnbd_srv_info(srv_sess_dev, "Opened device '%s'\n", srv_dev->name=
);
>
>         kfree(full_path);
> @@ -813,7 +820,6 @@ static int process_msg_open(struct rnbd_srv_session *=
srv_sess,
>
>  free_srv_sess_dev:
>         xa_erase(&srv_sess->index_idr, srv_sess_dev->device_id);
> -       synchronize_rcu();
>         kfree(srv_sess_dev);
>  srv_dev_put:
>         if (open_msg->access_mode !=3D RNBD_ACCESS_RO) {
> --
> 2.56.0
>
