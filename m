Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E696337E301
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 17:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768239413; cv=pass; b=PGWO//ZRjmAtFQzb1WCmEOoRiChWZSY5viBN7sajnCe9VHbboG4qpZLSPGsUkSeLNLSBwo3xq1M+bWgNxFg/4n7KK+BN23xbSlF92aU+Rh0nYpBq+HBZLDHvC+C0onTZnkov+/0nyNW0SkOmuFhOcPBRQHEgjtLipQFO3ioHCJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768239413; c=relaxed/simple;
	bh=D/E4fDx6+Mx8V77x7SnXPETvK/m4Eg4JzhHx9KR8/qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T+kWlAwkKl8qVtO0vLQ7iK2K9cOdu3EP9O5U4mS5EI0sHvvDhwDm9Gf8yF6EgxQEU2ouPM7pKJx5/cvWpgphYUSNVQCSkDhjMFLhHPFzBH3IabdkEXNY0NkCYK5tD2JIDKdAFJpzJxHgu6e+7mSRWml4QXbZS3E6jxacJKpYRAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bbeNHv0Z; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bbeNHv0Z"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-11ddccf4afdso457448c88.3
        for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 09:36:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768239411; cv=none;
        d=google.com; s=arc-20240605;
        b=dO7sXl9mFVliLR+slS3bD+QOhQjXHfAhzRB/lzaZmPM8rYjWCHi7YeJcopfX3+HCPN
         p00xBFE6SCpHwDkI2SLO20dlpnaN/WHtnIdyS15KcL9vLErrF3v4ASQODPiFcus7YXxz
         WSd0djPfdWXI9tLAIN+qxEu8qh4AO9AECgWCDU6iiXk2pHXF0opKjfyoi2nQUdrh97dl
         jtqJfHVkdmThaRx7hLU2i8hsyixX186spAxwIuqAlU7ZArFSU0h3v0geEgwFhIqa4mPW
         BlAij2RlaKP6/IkRFLWhv3WAcWYw0n7+2/xH3GX/wO57Sy6aS38//Lpzn2r6W/uDnW//
         OjjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7BBCGyjbOvAM/AYNfhRrDUNiTPHGMtFTyGRQUIGm25g=;
        fh=piWN7Hl5YsmsFO30S7xi3XZogGHT5FQ79FNLjGlZoC4=;
        b=imviQR0i+JAZfQnXtPVy/Mb9JOHL7+x2b8hKUjaaiTIG8He3olvHJ4BSjHRquK4hxb
         9t/Cktl89OB1jW0Ysd5hjyJGcyXP50RF6c50GKGuU7aKYPGPvkpZVE23hXipA5FrELqb
         xq+/rRuLIfxUiA59Q92X7BcP6zckWo+sWeqbIfZY4Q4JQId1SFxFdSalAuPibY5YXV4g
         sLZ3QCv6i1ItPGeLS6gBsssYJZ34EFkK5uvCVdWVUSuyzSiTxRZdQD2e2nlYdQRW8QQ8
         rgxZezXB6IOQg8ZsEWMPcIxjR9YFYGHembjy3FB5qVKznfwEK+DZHQeBv1P7t3GCRUOn
         S8ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1768239411; x=1768844211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BBCGyjbOvAM/AYNfhRrDUNiTPHGMtFTyGRQUIGm25g=;
        b=bbeNHv0ZhbmV1gKb3JB3c2QRR2oS7aaywHQnYhLRv0eqZZJ4pw2jE/zW81sBf5/l1x
         8htio/TkvWqaq/e+nI3BeivTtTbfTJNcDjjjnWBvLVpul2Q/rqwbXFbCb101tF7o8oPd
         QBnQ6Vle9rSd3MULibryeucc5RgzgZ0naTItxPKlhA6nVANiR8AfaTmeh2lUg2/I+bX2
         f/u0nf54kD7aG/xJOE/MZ9v1YLpQeMiu1OrKm1rSRCnguMun6fisSDZDdCR+PdgKg1Ql
         ELwUPQ4NsmOMYIVEjbvt4GZOH64rmdF9N5c56LJUjKhl1o4PlYSfUWgev7sQrNNLW178
         1qow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768239411; x=1768844211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7BBCGyjbOvAM/AYNfhRrDUNiTPHGMtFTyGRQUIGm25g=;
        b=PXFTY6vJvjcfaLGrLjoJ9yikB26V8eGXPdXbDSeURpmxoYeIgCoXUjT4pz2cs16RjA
         epbVHs5a6+MQeesFzEjUPlDSsZc/a+74zQRYtrzeRUPCIVkhciMyuNa1I/3rxtmqqvrm
         ZYVlazLH45XD+hDc8BbrH0vCAmNZXD2ihSZvlpGitdMC+lmQX2UXfiT7Q5ZRU2KHOZos
         5uCs6Q+IMCVQCaLJdqScvKczNnElybcAqO0hjSYWKfq7BPdnn1kbhtJRN9kwDGg4e/ba
         4rBsRw3/qa35z6F1u3Y59ZwlWHSoSR6F0dJHkOCtTwjLy6bd0F+fkLItyLQuQ313YWgU
         iTAA==
X-Forwarded-Encrypted: i=1; AJvYcCUUqi8SESc7RSov5dHdVMATlXHu9SMInPFtu1kRC/TFmtL/YFQL3MBJBLf9HRgBBDkhVaEZO0qpc3WqVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUrnVrkhKC2FyZGox8GBZEpMpbQR6og2oHXPBmYtdlfTsaPH9A
	Ra2FwWfNb/grKkRYUki+GDjbxBAJLg7D8YzdQRWjESWUT2F4cDs0tyKjrFrL5dKh82iQZd5L9dk
	rLqG4AodisD4Fqah/+R0Ei6Sjjdw0C1sxUWuhA55koer4ApmSiND+5GE=
X-Gm-Gg: AY/fxX6r1lS8NGPGyIw5uNwloHnjC+8cTy+DUgjlTsP+laNqW4ZSIute9FAHxQp6Dmq
	lIKUBHuJclTfWYqTc6vQX6MeBgR/o9A0KcF0xVOZBMdo792HSnzwqcvah9CN5arPvd9pYn3FqW9
	qMRJV7WewH6zipuKADLe60AgIIZAYzoFKhMyQgsFJrghlo9XdefUdQlGiGYCsG1E7XMWCNaWtzm
	M0TBObHE3nT0l4w8xfBU5kJ0Qe762k19fh+IPOcPHWtaa7c36ufR9xsPhcABUzmgzTjnb1z
X-Google-Smtp-Source: AGHT+IGrfBjUgdm272SLeQExeyKWl77uUP8gY5NPGJ7w1eiizdFVP71dmWPUcvbmpDGKdrayDYmibBCyalCyqLEdeSk=
X-Received: by 2002:a05:7022:799:b0:119:e56b:46b7 with SMTP id
 a92af1059eb24-121f8abf499mr10833439c88.1.1768239410496; Mon, 12 Jan 2026
 09:36:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112041209.79445-1-ming.lei@redhat.com> <20260112041209.79445-3-ming.lei@redhat.com>
In-Reply-To: <20260112041209.79445-3-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 12 Jan 2026 09:36:39 -0800
X-Gm-Features: AZwV_Qg6MmDIvNKl9JTSXsKhoO89DKh_1sMu5h1tCmuPDiZvyEhGa2BypiQl8nc
Message-ID: <CADUfDZpnX1yU-+7xDcEtSqTMuaR2q5zgzgMs0Bh3x8+c=1g+_w@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests/ublk: fix garbage output and cleanup on failure
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Seamus Connor <sconnor@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2026 at 8:12=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Fix several issues in kublk:
>
> 1. Initialize _evtfd to -1 in struct dev_ctx to prevent garbage output
>    in foreground mode. Without this, _evtfd is zero-initialized to 0
>    (stdin), and when ublk_send_dev_event() is called on failure, it
>    writes binary data to stdin which appears as garbage on the terminal.

Nice, I always wondered why that happened!

>
> 2. Move fail label in ublk_start_daemon() to ensure pthread_join() is
>    called before queue deinit on the error path. This ensures proper
>    thread cleanup when startup fails.
>
> 3. Add async parameter to ublk_ctrl_del_dev() and use async deletion
>    when the daemon fails to start. This prevents potential hangs when
>    deleting a device that failed during startup.
>
> Also fix a debug message format string that was missing __func__ and
> had wrong escape character.

These all look good, but maybe they would make sense as separate commits?

>
> Fixes: 6aecda00b7d1 ("selftests: ublk: add kernel selftests for ublk")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  tools/testing/selftests/ublk/kublk.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftes=
ts/ublk/kublk.c
> index 185ba553686a..0c62a967f2cb 100644
> --- a/tools/testing/selftests/ublk/kublk.c
> +++ b/tools/testing/selftests/ublk/kublk.c
> @@ -153,11 +153,10 @@ static int ublk_ctrl_add_dev(struct ublk_dev *dev)
>         return __ublk_ctrl_cmd(dev, &data);
>  }
>
> -static int ublk_ctrl_del_dev(struct ublk_dev *dev)
> +static int ublk_ctrl_del_dev(struct ublk_dev *dev, bool async)
>  {
>         struct ublk_ctrl_cmd_data data =3D {
> -               .cmd_op =3D UBLK_U_CMD_DEL_DEV,
> -               .flags =3D 0,
> +               .cmd_op =3D async ? UBLK_U_CMD_DEL_DEV_ASYNC: UBLK_U_CMD_=
DEL_DEV,
>         };
>
>         return __ublk_ctrl_cmd(dev, &data);
> @@ -1063,11 +1062,11 @@ static int ublk_start_daemon(const struct dev_ctx=
 *ctx, struct ublk_dev *dev)
>         else
>                 ublk_send_dev_event(ctx, dev, dev->dev_info.dev_id);
>
> + fail:
>         /* wait until we are terminated */
>         for (i =3D 0; i < dev->nthreads; i++)
>                 pthread_join(tinfo[i].thread, &thread_ret);

Is it valid to call pthread_join() on a zeroed pthread_t value? If
ublk_queue_init() fails, there is a goto fail before any of the
tinfo[i].thread have been assigned. And there's no checking of the
return value from pthread_create(), so if pthread_create() fails,
tinfo[i].thread may not be assigned either.

Best,
Caleb

>         free(tinfo);
> - fail:
>         for (i =3D 0; i < dinfo->nr_hw_queues; i++)
>                 ublk_queue_deinit(&dev->q[i]);
>         ublk_dev_unprep(dev);
> @@ -1272,9 +1271,9 @@ static int __cmd_dev_add(const struct dev_ctx *ctx)
>         }
>
>         ret =3D ublk_start_daemon(ctx, dev);
> -       ublk_dbg(UBLK_DBG_DEV, "%s: daemon exit %d\b", ret);
> +       ublk_dbg(UBLK_DBG_DEV, "%s: daemon exit %d\n", __func__, ret);
>         if (ret < 0)
> -               ublk_ctrl_del_dev(dev);
> +               ublk_ctrl_del_dev(dev, true);
>
>  fail:
>         if (ret < 0)
> @@ -1371,7 +1370,7 @@ static int __cmd_dev_del(struct dev_ctx *ctx)
>         if (ret < 0)
>                 ublk_err("%s: stop daemon id %d dev %d, ret %d\n",
>                                 __func__, dev->dev_info.ublksrv_pid, numb=
er, ret);
> -       ublk_ctrl_del_dev(dev);
> +       ublk_ctrl_del_dev(dev, false);
>  fail:
>         ublk_ctrl_deinit(dev);
>
> @@ -1622,6 +1621,7 @@ int main(int argc, char *argv[])
>                 .nr_hw_queues   =3D       2,
>                 .dev_id         =3D       -1,
>                 .tgt_type       =3D       "unknown",
> +               ._evtfd         =3D       -1,
>         };
>         int ret =3D -EINVAL, i;
>         int tgt_argc =3D 1;
> --
> 2.47.0
>
