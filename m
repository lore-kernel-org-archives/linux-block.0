Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E712BE639
	for <linux-block@vger.kernel.org>; Sun,  3 May 2026 05:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777785245; cv=pass; b=IsN8gfLH8lkwxojQre9gLKmhqln5f1bLsak2rqiS55fZ5F2BUXO9+SD6S6cPT/UZTtTKprSBzSaKjBDOQzE44c/YkPPo9E+tuXU98aBZmJJ+toEWGARFAueS7S81H1x2Xshgqkoe1hgjeJabytEQjhSd4HZHlxvAV8vNkNg08vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777785245; c=relaxed/simple;
	bh=Bgg6tRIruHZPLNbPdn4Lx9Egym+DaQ0OL37BLC4LLNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T0WSXRV51397ahJUszyPgKMypR/iXtRX9Bz4i3dybx1UFML3286WiMM++Y7LAqRJxOToTB5p6GYUEeRLKusukVT7ln/StUmCnjZaUN9bsvUZsMOJWpxiR42c8B9lfHPRtPoRPt3y5eHUymzNgMbNLmF23vkokECiafRD900pvQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n56N02sv; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n56N02sv"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79ab5fd969aso33042087b3.0
        for <linux-block@vger.kernel.org>; Sat, 02 May 2026 22:14:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777785242; cv=none;
        d=google.com; s=arc-20240605;
        b=crNGlAAJ146eSuKORPxuRobpC2rPYoYPrhWY4bHw/nroU2ymI4UnbfUdB3Y8oNX/8R
         8U5Rfo1rPP8Oh80YStJpo7njSM2QRwPd5j2Lh40xHa/p3KvMFF4pDh5TL7cQy1o97NzU
         VHj6/c9KjAUqJYZokI1Mui3OnT40y086zJ0yKC1RoltGZfylzmogrNrlBK7xMYBAiBfV
         I2LcGKVJTP6sPkamBs5gJYflm8Ec9JCrnXEL7r7R5AmObtQxklXNI1TzS9UORaCrBCjj
         mrxLAOI4r7Hb4guwWvi0ixj8yvYOP+AYm6by+ssqjeckhtpQM16cxqsNpnN0pBZiFHDg
         LAHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zdcGJAM8jBlmLda8jFwuK8SYIvIOeidaOnoqCWXbNc8=;
        fh=TmmmctC9SqUPSW9kGDwXHtd2SkwnRbZxBQabsLDy5MA=;
        b=KlzNc4bYFe3BjvQbX/osgfcMRF1aQYDN24jiJqU+BcEMnjoUkych2KE5wnx8FMpZM8
         1p1Tu0x17JqsPf/E7sk+stpzyKBmZ/c/e1N8+GmtKF9nkQIJ9XC/N0loHkIXO6XvQSEB
         QE0J10dW2ysEKx5ZBGN7Mpoq1G3XIk2Y7RynwzJ+UNr538bmN3jefQjfpM5CoF0KmgKK
         7oETvUvYwDrT+XYDH0YwcJasHHHV4Zvry5TsDNTjsre7Xxmw54/HA1ahAotYbLtqqV0Q
         gldCtWuPJz08sOAAZKtzymZa16hQtQXUuGEAAkgx6Z+e5+JgGs8GyZM8j9Ey0j84KPxg
         YnGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777785242; x=1778390042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdcGJAM8jBlmLda8jFwuK8SYIvIOeidaOnoqCWXbNc8=;
        b=n56N02svaLVEkuXKSURdyLtwh1ajI7G22Ud1EveZ3FsN+ADYXaGntY1aUlS0EBg2Ul
         aP+/3MWvgA0xksIkv4JcE1QMbOciHc65gYlD0fE0+9F5kHGxWhznefbI1wh5ky/mrr6g
         Gl+uO50aIXhIupcw8Fe9h/AYdEHL3whB3lX2mXlT2/fsLqmr4jA3QgsD/tp219ftMAC3
         WrIUCkmKtsvw/1Ba1gPvS9jIXRROiiN6qYhGjFTY+l3mbArz+toXHGCxFjV8STaLsIIn
         iDSUrYUsMAioBAkHOyJNl2tzoK83ffW1QmYJhtPYngTWRisF21SJChFSHQYNRPvQrcNE
         rgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777785242; x=1778390042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zdcGJAM8jBlmLda8jFwuK8SYIvIOeidaOnoqCWXbNc8=;
        b=FeGSYuiwqCe4qzcu4Z2j1VGyVoXCV3fCmLOgGTYmbml7+0W01Bvf2vqfjtqOJhO22+
         w6Nyy1Q1tW+p62CjcOI6L+deWTXV3iamwZc1Jp3fIWwoWgmHWlB5as6PDA+fagnMQ70/
         py2dZKDE2z1V8GDJ0++t4dpdyQ2zW+6r7RmV8KPpHiH01tBFvGaU+eM9nzG99CQJb7MQ
         F0kyHJmuKnx7BOrPpGCCsWNmMSzz7HMcLYypsY8CDcJ/st7Zf9tM9zztTJTaUI67b+vQ
         0usx1Xfoo5b8GvHpAIRQNAENKU3iTcK6j6YvK6a2cNSceE5qfV1Qc3U4by3CAkv+l1k3
         5wJQ==
X-Gm-Message-State: AOJu0YysX3z3pBZSm2JcjIjitzzRhJnNCijKe8MuTSEWizPykBumt8WR
	EJc7SxzcEZxZvtbhz33OqQy18R3zirvTHuR/gydctt7CwDtdV6NPMLeRzUpf/OGfFVE/dKb8FYO
	AjoD91xYZU+4KBe7o/hjFaMjDimgS1hQ=
X-Gm-Gg: AeBDieur3DyrKjBhNIVbSRjgGV3p1vUhyQc52EqVSSXrEcqnSYp6C9Zx1mvs7f5qiSA
	0SCm9lVRmu9MQd26i4PlwluLP2Q2bu8hmob+7jdtIEJA4o/uH9BloEEkKXoF0+mCh1q8xiYbb1X
	DW+RQwJW2iqsKrzjmL2Ivn0rv6BBwuqITn6/RRGCXYuUsSU2FU64uAdi8DG9H80DGPOs/IVwMvy
	WMzMRfGJPlte3WDPqSvK+6oPFNcNQMcsiLLsiSIcdKYVbCtUXMKSuFfBclFSsfsc8cpAZNEvdoc
	9GExLcL3+/Q0OAHo0wYCj4KUgxgQLUMNKCtikk8yNtvpB0mCFoufNMNynNShIkH5XuAR7ldUCW4
	tvEf56zUEd8ttXtXwnw==
X-Received: by 2002:a05:690c:6d82:b0:7bd:8952:132e with SMTP id
 00721157ae682-7bd89521822mr5806557b3.3.1777785241772; Sat, 02 May 2026
 22:14:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322051838.1137822-1-kartikey406@gmail.com>
In-Reply-To: <20260322051838.1137822-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Sun, 3 May 2026 10:43:50 +0530
X-Gm-Features: AVHnY4Ly-1cUEeK9MYq7ONu9W8AXSkGhiqNuKIo0E-YsZ8okhaz5G4KdNlAZAqs
Message-ID: <CADhLXY6uKPhLHTYysPLnK+sy=ZEq-7hGN2rwbzaoHdHj7LfmGA@mail.gmail.com>
Subject: Re: [PATCH] blktrace: reject buf_size smaller than blk_io_trace
To: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, 
	syzbot+ed8bc247f231c1a48e21@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 22, 2026 at 10:48=E2=80=AFAM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
>
> blk_trace_setup() accepts any non-zero buf_size.
> If buf_size < sizeof(struct blk_io_trace), relay_reserve()
> always returns NULL and all trace events are silently dropped.
>
> Reject such values early with -EINVAL.
>
> Reported-by: syzbot+ed8bc247f231c1a48e21@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Ded8bc247f231c1a48e21
> Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
> ---
>  kernel/trace/blktrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 8cd2520b4c99..6cc7d83ed1c2 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -773,7 +773,7 @@ int blk_trace_setup(struct request_queue *q, char *na=
me, dev_t dev,
>         if (ret)
>                 return -EFAULT;
>
> -       if (!buts.buf_size || !buts.buf_nr)
> +       if (buts.buf_size < sizeof(struct blk_io_trace) || !buts.buf_nr)
>                 return -EINVAL;
>
>         buts2 =3D (struct blk_user_trace_setup2) {
> --
> 2.43.0
>

Gentle ping on this patch . Let me know the status of this patch

Thanks
