Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F8218B0F
	for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 04:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768364258; cv=pass; b=qsRvi7k4wuIjsko9p1cwoUvZx4c3I5nqNCxurzGF7uGOjC44OXRZYJi07o2obTIE6WK0ad6M9rPaRNuX1dfx6bieXhkX3SniMB8ttmX8ZMLvmV6WASfXd8DcPTvFs1KhyeLpAyPwNk0OxZfhi8U/rteGxzBsGhtoMVC0/AzM6ZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768364258; c=relaxed/simple;
	bh=H32VidvqQFtCxxNHQog9PbRI04+h9abDbVnH952IaNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UtnLC9QiriZbSRKTJR9Ay3wyHPOkc5B2WAQe2RFW2oaHtf65AbtlYoCOpg1odG/a+Fm2ziFMzctFJlWxpfiJ7MKq+evhOQYKbndsvg3DvuLtploHFuw737I9zGygRe4GkXP94HldmY9Z2CJUap/hd4JTfGfO40ouuSwurUj92ZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=eX7N574E; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="eX7N574E"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-121a15dacd1so661698c88.1
        for <linux-block@vger.kernel.org>; Tue, 13 Jan 2026 20:17:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768364256; cv=none;
        d=google.com; s=arc-20240605;
        b=fAxlifSOuabIqLEoaK4fHFUzdQ1kAaHI6vh/yDrwv6RgLiLcWMEPzHvYJC4Sfcs47V
         kzuC6GMPy8Otn2L4uoJc2rJ5q2BluNCQsv5F4E+3LL3GnqYGO0tPCF2fzPBFsbS1N3w+
         ycRtm/xDLqp2n2Z7n18931cLpn/rNfIo/5ADYmnrTGZF/6GvZAD9KuLDyDvyrnkF9+bW
         ee2swZc6K7ennKTNcYpQ0PIoj6SfB37KyWMfg/ja8h/btdkBsL6FhV7oJxSxR+vIKjI9
         /3UFGqjJAoJhgkOxkd1xozjYqazxJpZd/W7dXcPFfgr1Tiq2+H6u0BDPJXJiDT3ap53M
         GsDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qE+6m/MnTNf3xQNICaY7+Dgd1y8AwvNooJie/PSgVGA=;
        fh=oR7/SYdmI4bW0YFRypuUdmuyOiCSwXEyZDx1dvC3ZHw=;
        b=AoxHkXVdLqnMtOCKha3B94+r8P9F0mwjMyj058PAA8yMjP45r0x3htzTjJ7YHWY+kq
         NnZ0jjebfMa/KBr8o98DWIDWHzfoICaOMRdBDK4+PFSq2VbE2SDbc4PzrGXdAhuDn3fK
         9Sc6zY826tFbdQMnoNyeyfxAqql8gykbeZpu6RA+Ckn+biIm7TtKKC/Hmtlszq8tplpI
         Q6JrajpEY0xrrcds0P6M/hKxOq9xpr1Y3EduXGkHQinafRD6ZakexplEL/yWLM1BQEu0
         pm9zLX8Xxmo5nYVGzLrCcOw77qodruX4q+PyFUWKJwGcEEYpatlUzJ7n5WMaNAJKOZ8d
         ZHYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1768364256; x=1768969056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qE+6m/MnTNf3xQNICaY7+Dgd1y8AwvNooJie/PSgVGA=;
        b=eX7N574E7L5r3ZEU95b+IKl8eEiOWOoBF/3xhR7YfZ8Zt2+rFcgLWyTdBAKyULX2um
         22Uybd97qf9mbcwWhxP812pvwiX7wiV5SaeuK/cFrirr+SaNHtxyKmDSV2qg2sSFrQmk
         CmSmWfKeo6NMoqpaRX/BEPNLGmvnBiHzgp+E120Dt4lb0FzMKLJrjU/iAjjoZiLNTuha
         HFJORfaEc90oOIcALhCv/BWF3rVEZu49oYt3XY/xfXlAdaed2LmzqabhksSBrFypI4FD
         e6sKAA4PqnLkwKOl16ko9RiIIS4E+twcGG94VR75uicBH0DzssWx7bJjODFXClSmHzOZ
         Q7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768364256; x=1768969056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qE+6m/MnTNf3xQNICaY7+Dgd1y8AwvNooJie/PSgVGA=;
        b=XK8GbOHgQTXOxjDukx9QJZjfWAf8AWzEvoUAi/ycysLWSnm4zrRgdz5VaGhLCmd9OO
         h8jQSUFjDMDa7SZqM4Qrx49vJceDFjmNqDY2ro9vvddAkak2gNPUnvfQRhMbdv7nRzHT
         qmQ9ogsRlDuo5IBtuAUFu93UV6A2h55y/YN+ARmEczHn3P7xkpcau06DsVTo9tji8WTr
         SpQ95WrzuPSbi5fS6dNHnfTuChNU6Ue9yqKuWFXfVJ697QZ4ubQsc3P8DRpfn10snF9p
         mF92Tjw1KBgseKZnXnUTe0fjS+64+yDDbN93HnT08q9DP22XxGmTdBj2RvU3uRXUKVDz
         sWeA==
X-Forwarded-Encrypted: i=1; AJvYcCU2hJ7v8DlBGwJ+x5SHfDDoW+ycoRR4n5pMmZg53aggJcW/7sFC35bJqmKfCoLNfCu739rAbtvmOy6bUw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwb8Dyi4snglrSZeYEYdGeNWSOALiD4qJvE5h44yS6msrR32L3
	Utbk9t13J6hqC3eautu2TbisQ6NJQM23hs14FSoxpnBmAuY/lS8cPYA1f7miaQFCmOiey+UEOvt
	qNCedAmX1Udn5+tZXfgvkM3W8YytO8AYCU+bBabizGg==
X-Gm-Gg: AY/fxX4j9GpZm1wZWHykikUNiOJPkOGpsUdpsGD5tCkSLSYXUsC8tTtqfJIOJzOvgbO
	IVxd2SpA3O1pRP1W6aYPCFBjgLXxZXfZBmWUeZ/2D3Nu6ey6zzvW09R2S07xWidRrBeLXYfDamq
	NPDajHpmZxA0Q+ZOhgp+aWvtgkllL+yzCHZ4n26RdGZjk/+foXSEvy+Vg7LQn2gPIrCnDORMsZQ
	YMqDubU0AjTKPsint7xRjdcMm2u8H6Z7cIjtwLiZIP7wYRqx9LMSXNX+BXVIoBMGvNXZdTju3yb
	0mIEe4A=
X-Received: by 2002:a05:701b:2504:b0:11b:1c6d:98ed with SMTP id
 a92af1059eb24-12336a34017mr709026c88.2.1768364255987; Tue, 13 Jan 2026
 20:17:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113085805.233214-1-ming.lei@redhat.com> <20260113085805.233214-4-ming.lei@redhat.com>
In-Reply-To: <20260113085805.233214-4-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 13 Jan 2026 20:17:24 -0800
X-Gm-Features: AZwV_QhapZFaWkVoOBE44PaMvbpNGQdnkAmk2xPJEpphlti4n0MbvyTCGODWWO0
Message-ID: <CADUfDZrpYYM6SuYocO502cv-KtgbkhUmwkp75F4T6Z=oi=F=sg@mail.gmail.com>
Subject: Re: [PATCH 3/3] selftests/ublk: fix garbage output in foreground mode
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Seamus Connor <sconnor@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 12:58=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wro=
te:
>
> Initialize _evtfd to -1 in struct dev_ctx to prevent garbage output
> when running kublk in foreground mode. Without this, _evtfd is
> zero-initialized to 0 (stdin), and ublk_send_dev_event() writes
> binary data to stdin which appears as garbage on the terminal.
>
> Also fix debug message format string.
>
> Fixes: 6aecda00b7d1 ("selftests: ublk: add kernel selftests for ublk")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  tools/testing/selftests/ublk/kublk.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftes=
ts/ublk/kublk.c
> index 65f59e7b6972..f197ad9cc262 100644
> --- a/tools/testing/selftests/ublk/kublk.c
> +++ b/tools/testing/selftests/ublk/kublk.c
> @@ -1274,7 +1274,7 @@ static int __cmd_dev_add(const struct dev_ctx *ctx)
>         }
>
>         ret =3D ublk_start_daemon(ctx, dev);
> -       ublk_dbg(UBLK_DBG_DEV, "%s: daemon exit %d\b", ret);
> +       ublk_dbg(UBLK_DBG_DEV, "%s: daemon exit %d\n", __func__, ret);

Could add __attribute__((format(printf, 2, 3))) to ublk_dbg() so the
compiler can warn about this in the future. Similar for ublk_err() and
ublk_log().

But this fix looks good.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

>         if (ret < 0)
>                 ublk_ctrl_del_dev(dev);
>
> @@ -1620,6 +1620,7 @@ int main(int argc, char *argv[])
>         int option_idx, opt;
>         const char *cmd =3D argv[1];
>         struct dev_ctx ctx =3D {
> +               ._evtfd         =3D       -1,
>                 .queue_depth    =3D       128,
>                 .nr_hw_queues   =3D       2,
>                 .dev_id         =3D       -1,
> --
> 2.47.0
>
