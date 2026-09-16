Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1BD4E66DA
	for <linux-block@vger.kernel.org>; Wed, 16 Sep 2026 12:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561324; cv=pass; b=tHKFQSzHDeRBedK3aFgkMQwq4aXUQCZR0H3g0EGB40dJgCSqpKwxe4a1dIKKruFg+GF4MDBEaj8APGPJD1fXz4eEsv8ccyzoKAtpPZI8OuzUfMbXPGDotRBeXFo+KCuskkr/smkrFU3MKz+f8ziOeLoKpCQLUcV+d/ydNa6dYyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561324; c=relaxed/simple;
	bh=Bq881M2dqm6GKoOZGIh/gzGfZPXNikD/fmFhifV/8bA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b2LZsFVxqTYDm5j54IviBJkHqKbezfgFZ+mLE37lpe5BEz0zN6z/z0XYKN3c7Z8MB1rjFByLZfglMP7SwAgN0DryXyE9wCpoh2ps1IuPYfU1iyOQT2/b5iRXFiKG0CywsvChvj1saSkmkE0mzW+IfE+65wUDjp15cfi3fXoca4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cloud.ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b=aDW7G5DV; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="aDW7G5DV"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff176d7eso7584311fa.3
        for <linux-block@vger.kernel.org>; Wed, 16 Sep 2026 05:22:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789561319; cv=none;
        d=google.com; s=arc-20260327;
        b=C0tnm59pb3UxFgeVA7udzLxvpR93g3vP2e6EX9htJgYCQcXb8VcCL6bYDxixbxS8Lu
         8D9hDZsIOQusANU/E2ftwg+z1BbeWSeBdj/37s0ijLrTNF7EnZc4BdAtlpU9c5tMm6ZB
         1Ft6KGUkN8mOdW0tG4ptR17mCkgBX5C80pYVpASUVeGn4N2OFC5SjDQvcdQzn61Z/Tvt
         EzUnecfeuTu3OJ7prqfMJzlctfUeyKs3VGsGac9Q6tVWVPVKoqRSnUMvmo2JQD+H0HrZ
         xzkpnHu32JM1gAZr388v/J17xdUjFEslT9Crr09ReA3Wibt2bwbdo9nQ12R/RmO0wJ1O
         5uPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WAMMSKRtR5SkKpZeFxgDlMOeMMYKcKQW0S4EL9ByfSk=;
        fh=QIY33n4IlMTVo17frc1XeM62K1lfsF8TXqkyWXCD1mU=;
        b=WCW6yq7VjiEI5Ul3U0XhgNQ8p1b6zMOwECsZ1mBu2P+1dsd00FRs4swZG/ywvENwMI
         dc4GAqZAYIZEk4IJhjKrcLr98HO+DEzQN4K3clvYkXf/hvM5tSjeBW4CykUFOuuzcAQ3
         7CyfwDVB8KNvptTWjoVKZfSyLqLqfnw6NakKlYbBt+ILHBmU05RJjExOkIcY+EhGPpcT
         wAwpYl16l/fr4SgzQBDYhuz4vIGzQD/lccGClDmRkp0RMG6/Pq9XaH/aYWIfIx7M/WHj
         2gVmtvFRDKreiTNAaqCFB/5HQLH+J0zLPlg4LbJFstCLtpejbw4bgj38C6BH5waZywT5
         7Cyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google; t=1789561319; x=1790166119; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WAMMSKRtR5SkKpZeFxgDlMOeMMYKcKQW0S4EL9ByfSk=;
        b=aDW7G5DVZIZguqUQAQZ9d6ieMhNF76o1BAJzGf6emv35elRZYmhWyB4tEdqLklciIr
         5WTgpEoP8+rVGA3a33dzmcpSLqG5mZsZTimKJ+sITg1kQLeXyHkjE/2eItUNrcg97BDl
         WWeOWHaSUOMH1Inp2MjiK+ZkdyZ5+6LHvEFFBwXyAYBvN0CeRA+fLlon3BBb6slYBU5p
         NRcsi4p68+CCxatGA7iNASlxvLQ7RuCDj0ybhTHckpuvz77uVwGXsNoMywIZe3wW7705
         sFEKDwrAgaefhNNBlmNvAGnLn+1P3Gzh8SwWrPncsMUSxY9vsi+OI4Yc8u8oka6s8ei0
         79dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789561319; x=1790166119;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WAMMSKRtR5SkKpZeFxgDlMOeMMYKcKQW0S4EL9ByfSk=;
        b=WifOrR1XqG0V7sUty+/VHxx89Ubb2jy/h4JGT9metLZcFHJEjAq9fjLugRxaTjEs9v
         Wm0fYwz9LtEF5nHEi8SrX4kP1qvI48Zo1RwjfD9QoDT5ElyLAkaUGj9udBK9Z4KEMb/Z
         KlYvAR8WKsl4bsn2HJZkEKuMn7bnrHVZIdQ5Us58NI38kRdimOj1YRGnZ/ZriOcTls/V
         bdZ8RlY1qprUGFVPhgsiU2ET6rOL6D7CpJW9HWLNqHt/7NVaM/5+Uk9oyg9K9tjX2D14
         wYWL4e9g1ZPF+exgKvVeQJdmKo9glaXkWGSxRjyUskyavOHHqmDaW/jy9TZAICIXMG9H
         ba9Q==
X-Forwarded-Encrypted: i=1; AKwUvBwZyG6Qe4kLJdU0zskNdqXRkWs7YB+nPrPEBJmG/Zh0USEvhDVHqnqKjNQKX9rHU/iJInlZb4JCn5pz2w==@vger.kernel.org
X-Gm-Message-State: AFuF++mzmAxeL/mtn4PvkOTugn51pYqayvvLOB8PLW1lSA6BKtX0n70u
	QOv0J0d3O2tb5i+/FjvOS89yH6dd+hgpcKse9y3HFxVltzYszSAiks82K8JhefF+skfYgrCfgs3
	WU0toM1ci1YKsSjD1FLRiWVRaAJH7RB8CaqnCk/C3SQ==
X-Gm-Gg: AYBFou3NnV8Me94zXdrDkfc31GDhXJeBKBXDlVGWHgbl4f9lK0hyp077jpsiRmaFoJH
	dNUcOI7BIXh4NXqggjeShyaew2oxUsdlES3dlSKbD2ljUaay3aeweM1RmQu6HL5gfQIqK5Vzyq/
	j0O+pJzR/L9xsiBPt5bpKWywqv+lrVKq8lbamSNSpmLWr3nF25OxQQj7T5tXDxGkoV15zYpFujx
	vyg8klN3o8EQEM5UjrIrbDfwGiL+IzreFDaXH98n9uHABvRTtFaA1bIG8Hxw2tkwzyYdzDm4DKY
	dyjuT0o2WkWGabm46sWouyuqkeTooHtAFE3G/RHz11UTH4qWQ/9PVf3JDe0/AwQZ0k+SRqh49LF
	KZSQkB2klYe4aU3dpDw3TOjAK5UU39bj43nhST+lo
X-Received: by 2002:a05:651c:a382:20b0:3a5:b957:d23d with SMTP id
 38308e7fff4ca-3a5dc9c4523mr7083011fa.6.1789561319145; Wed, 16 Sep 2026
 05:21:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916094817.2007756-1-vulab@iscas.ac.cn>
In-Reply-To: <20260916094817.2007756-1-vulab@iscas.ac.cn>
From: Haris Iqbal <haris.iqbal@cloud.ionos.com>
Date: Wed, 16 Sep 2026 14:21:44 +0200
X-Gm-Features: AcwNN1Vj5MCCxsybETxa2RMBFpc8N2_N-J2Oave1MHK29JMnf2xnRGfsiC31dsI
Message-ID: <CAJpMwyia7fYUOq=dj8E2FWnrtjZ9jHjZQSBW2vwB2vRBkbi2eA@mail.gmail.com>
Subject: Re: [PATCH] rnbd-srv: Fix sess_dev use-after-free in process_msg_close()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: axboe@kernel.dk, bvanassche@acm.org, danil.kipnis@cloud.ionos.com, 
	jgg@ziepe.ca, jinpu.wang@ionos.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 11:48=E2=80=AFAM Wentao Liang <vulab@iscas.ac.cn> w=
rote:
>
> process_msg_close() drops the device reference with rnbd_put_sess_dev()
> before using sess_dev again in rnbd_srv_destroy_dev_session_sysfs().
> If that put drops the last kref, e.g. when the device is concurrently
> being torn down through rnbd_srv_sess_dev_force_close(), the waiter in
> rnbd_destroy_sess_dev() is woken up and frees sess_dev, so the
> subsequent rnbd_srv_destroy_dev_session_sysfs() call operates on freed
> memory.
>
> Move the rnbd_put_sess_dev() call after the sysfs teardown so it is the
> last access to sess_dev.
>
> Fixes: 2de6c8de192b ("block/rnbd: server: main functionality")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/block/rnbd/rnbd-srv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.=
c
> index 10e8c438bb43..2ebc2eac384f 100644
> --- a/drivers/block/rnbd/rnbd-srv.c
> +++ b/drivers/block/rnbd/rnbd-srv.c
> @@ -361,10 +361,10 @@ static void process_msg_close(struct rnbd_srv_sessi=
on *srv_sess,
>         if (IS_ERR(sess_dev))
>                 return;
>
> -       rnbd_put_sess_dev(sess_dev);
>         mutex_lock(&srv_sess->lock);
>         rnbd_srv_destroy_dev_session_sysfs(sess_dev);
>         mutex_unlock(&srv_sess->lock);
> +       rnbd_put_sess_dev(sess_dev);

Thanks for the patch.

Sashiko has critical finding about this change.
https://sashiko.dev/#/patchset/20260916094817.2007756-1-vulab%40iscas.ac.cn

Can you please review that?

>  }
>
>  static int process_msg_open(struct rnbd_srv_session *srv_sess,
> --
> 2.34.1
>


--=20

Regards
-Haris
