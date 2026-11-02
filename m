Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793619390;
	b=KWARzdlypjflpv2y5l7bdHPo81u0TDVfsMBZaSCUSJ7AwQF4xd7l0fmOQ3ZibLyZTKh5
	 ywKSBNiAE3weauIVQ+POjTgUvlZmGclaZAe/BYPYuswu1zlhH1nus/fvM3AszxbGZbpTL
	 T/91ieYe5RKtO/JiTJcvvjfkHWtp9HKkS2z3dl3QolU++4FM1LMKhbfjYLf0PC5Pyr37U
	 UDXR6ZdB2aKXKdFcb02+D/vxFKllCrEe0KCbtcrzoao/FGdhuQyBEOMPGsU8JfsnL8YTb
	 jgl47U+CLEehAxHrIiA9Rd9GHTxkSfrbu1gTUZNQtPz68IEBy9sBT3b3gKpHR+bfvEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619390;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=UIU1XcGV5NH6W1hKEKKqiMDhlGREzth4L7Uv4sn0EeQ=;
	b=0nAhrfmcCfpjdKNYdyKGLfsKxmjwPuHrL5NUBBDEYkyMYbt1n096+XdpUxVwOH4uqhrj
	 7grQOwHnCe8HYfgOjob6O5e+4WOLnjGI1c/3t/RQyueW86v3DCg4ffDEWOo/nBjx/Vsi+
	 iPDu+dijMEFhyFGpvlvVvqC9ANElma5wHnTK+oZ/etZesMTQcnhtiRS0Ugr0m3cNc0YGV
	 ybqNcI2ziOzhAJmicQTE6jX47Nq7lLh1s2oXBGy+zJzyDDTi5BV4/uLfjn4egxiPVVpR4
	 jmySI0H1q0fvCyh04bakxYGEzQW7b6zJRjq+kBJjBe0bksIZVadMnZf0S/dXSzHIvpg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloud.ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=cloud.ionos.com header.i=@cloud.ionos.com header.a=rsa-sha256 header.s=google header.b="ftbUZpv/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD92606A324
	for <linux-block@vger.kernel.org>; Mon,  2 Nov 2026 11:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABD92606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.a=rsa-sha256 header.s=google header.b=ftbUZpv/
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6afdd46afe0so795410a12.2
        for <linux-block@vger.kernel.org>; Mon, 02 Nov 2026 03:36:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793619388; cv=none;
        d=google.com; s=arc-20260327;
        b=CY0tp7f2+/Sfxmh0/XW+E9SofCGd+AkQgUk7ZNGFetkr7z7ea0A+5uazpB3NAPbIXF
         rKsUicRMscwbTN16Ebi/AND1u8UKR521As8x6vv0+lyez+jflU5C6RW+fvidd1Bcb82u
         4cV7g7yGIrv37EJ4N3T13YjuLxGvzTQ7NOG5lygXJl3ZBVE/VL8Eylp9gQaGwmOJKhau
         Z0AtVL1yVP7LpQpHIlKq3jh6/lTUdRoa0l7OaD47lwty5NSE3hfVgeFMdYd5cUK46ACr
         cYYAYG5iYJEoxN8/6+x6nH+iufjAvZi/0nA5bAxSeKU8UMk1/k/fK71TA/6d/Sl4/Tb2
         BzrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UIU1XcGV5NH6W1hKEKKqiMDhlGREzth4L7Uv4sn0EeQ=;
        fh=btA9tRKA72FE5lYTs8mUV25mWVQGYYa0X0A3wgN7RWs=;
        b=JSSHaKSduQOwxZRgBlexikpjA51pryF350uRUxUW3ygfQ9BadYdvKTuKEajZvNI7JC
         zbKygoz7c2cqSR3K1QGX1clg9D66jrQjNR8n2JSpMyHWvRpiuBujRsXOfruzTNhiKYA1
         2UigMe3wkas0xXLBZSTAPx15ptlkkoPe4VF3Zms5cIU8C4lxdl+nzgY5R+h7MEfGGTpo
         GuJ4C349iJEFqB92OKmZHIYeAnhi8H3jA5a5OhEs/q651fAf7WAum/okA75RHhE+RICt
         gIHn3756i8vR2/Ld4n4nCyjoKRAvsumIJzjnE+gm0fFYWOt4HRRz5Ahl6Q3mYKC8KseI
         fYhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google; t=1793619388; x=1794224188; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UIU1XcGV5NH6W1hKEKKqiMDhlGREzth4L7Uv4sn0EeQ=;
        b=ftbUZpv/o6k8Xda6iMUESjHn9H7plgJEt9uSStS7+GChlBR9PlYulT+r6H2DraS++e
         RnjNuXa1BOeZXQlF03awHjpAcOli8HiQtYJ4A05I4/gdka9982JewcaaniYvt/9xyrBq
         1GTRoF3Z8Eos6PtZx7IU1mjuOKut5fntBRoUeZTle57UPbvq0URky9vNVo4gimLpWJEl
         UKudeFfsQgSb+5ZOmCZU2TWYL8tBg2w70qucrNf10isMoOe/+KrU/FvZQYe5BLV2FJOY
         M/Weh4IaWsCFFBXGNcCtPClqF3matw58X7me0xWLk+VY64B2MdCiNW6wNg4Hz+uiEdGD
         B2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793619388; x=1794224188;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UIU1XcGV5NH6W1hKEKKqiMDhlGREzth4L7Uv4sn0EeQ=;
        b=bzoYVwrlQyZ+ULOZg9a5bE0gQzBz7ZddA6upnXjxiSegYZdFeBju5uqbCXwfUD7fWf
         SU1ZVauhTYlCXhFoUW2AQ2duBcG6o2v/8IuKN5mkx3syHHFxQTI37rveP49bfUaCo1Fv
         yNGOlONXRcoJ+ojFETBfCFqb11kiuV+t8JorUhpTBVT2NcKPcX812hECf0gPof2r8H3s
         0ju4Y2aG4HGZ6MGFmv5tpvhdXl0uwoq4AF0u0cTXVBmdtXgO06rnI4p0E7WDns6hRFOn
         dXbm+DQDOtbCGvSPdJiUD2XaC5eRoqnvC77OddCkJkpiKOJ+nHo+ldyPI4Do88gugD6N
         Kfyg==
X-Gm-Message-State: AFq9FYLdlD0QYYdOpBPnilMYXfsNGxawdU7Pf90H3P/WQzcU/GHuP0w3
	Z+mb+zdoGehnseJ9Y/tbnegHyyOLul1vCBsEXbPMK+CFw/Z1t1V6utbaEp1anlwPar2MYLn3Hrx
	kAFJ0Tris9MiiKb2FAngkcVJeAqIxlW+qNuDu4Ilh/17Ehp3yCDPN9pc=
X-Gm-Gg: AYBFou31DgTFtbS6hGkQkA+BjS/KMtC0Sw5j5P47nHNMpieX4K0ZhfgDrqygypw0Oqf
	qcAhBm49wLonRWxEgZ4hEbCvxQsu/0Rs0aXcqNivjO5MeA6Icppd7/alfvQgH2llDA3giuyL0m2
	xFa70ZSWWIa2r9e0iCp8wdFPRKQKoUVwTPFVzbmO30p+6/DPFtlpoGYS/ArhR/5uTNxnAjG8mwe
	aL10xtTuMPYsVlKfVjTN9F9XdNHN7u8fnynkc5wN7MMuQXuvFVeuVRjTw5So/T93Zr3pVqevd8u
	fgVFcsXpngmkpd+qkwSbznLxg7CEtkiWakgOsYFofzNe2VKbGRlENzqPycSl1bhtQxdrkWU4rwC
	wydEBaPJZ1A48dCzG94IM0d1YY5Qc02Vtbu8qDifHI0mqZyo2Gz0wsRaA1QeHepaQLxKGOQ==
X-Received: by 2002:a17:906:7d07:b0:c49:9a88:75f6 with SMTP id
 a640c23a62f3a-c4ca7a46c3amr777594666b.2.1793619388037; Mon, 02 Nov 2026
 03:36:28 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028164415.1262013-1-axboe@kernel.dk> <20261028164415.1262013-40-axboe@kernel.dk>
In-Reply-To: <20261028164415.1262013-40-axboe@kernel.dk>
From: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date: Mon, 2 Nov 2026 12:36:17 +0100
X-Gm-Features: AclHuK8Y0yaZ3aVypW7I8QBM-1Wik0LEts3NEoZnIjHWpAP1XtDX8NjM_hHZlck
Message-ID: <CAMGffEn=JuUVFGLwqxWrML=0m_0XTzcDCHbrcK0BBAaMCEJXKA@mail.gmail.com>
Subject: Re: [PATCH 39/98] rnbd-srv: fix use-after-free on two CLOSE messages
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Chris Mason <mason@kernel.org>, 
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 5:45=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> From: Chris Mason <mason@kernel.org>
>
> process_msg_close() looks the sess_dev up with a kref, drops it right
> away, and only then takes the session mutex for the teardown. A session
> has several connections handled by different workers, so two CLOSE
> messages for the same ID both finish the lookup before either one tears
> the sess_dev down, and the second one works on freed memory. Any host
> that can open a device on the server can do that.
>
> Take the mutex first and look the ID up with xa_load() under it. The
> second CLOSE then finds nothing.
>
> Fixes: 2de6c8de192b ("block/rnbd: server: main functionality")
> Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
> Cc: Jack Wang <jinpu.wang@ionos.com>
> Signed-off-by: Chris Mason <mason@kernel.org>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Thx!
> ---
>  drivers/block/rnbd/rnbd-srv.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.=
c
> index 1e3de82fd70b..1cfa2c580759 100644
> --- a/drivers/block/rnbd/rnbd-srv.c
> +++ b/drivers/block/rnbd/rnbd-srv.c
> @@ -360,14 +360,15 @@ static void process_msg_close(struct rnbd_srv_sessi=
on *srv_sess,
>
>         trace_process_msg_close(srv_sess, close_msg);
>
> -       sess_dev =3D rnbd_get_sess_dev(le32_to_cpu(close_msg->device_id),
> -                                     srv_sess);
> -       if (IS_ERR(sess_dev))
> -               return;
> -
> -       rnbd_put_sess_dev(sess_dev);
> +       /*
> +        * Each teardown of a sess_dev runs under srv_sess->lock and eras=
es the
> +        * ID, so an entry that is found under the lock is alive.
> +        */
>         mutex_lock(&srv_sess->lock);
> -       rnbd_srv_destroy_dev_session_sysfs(sess_dev);
> +       sess_dev =3D xa_load(&srv_sess->index_idr,
> +                          le32_to_cpu(close_msg->device_id));
> +       if (sess_dev)
> +               rnbd_srv_destroy_dev_session_sysfs(sess_dev);
>         mutex_unlock(&srv_sess->lock);
>  }
>
> --
> 2.56.0
>
