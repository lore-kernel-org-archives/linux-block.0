Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9774CA52
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 07:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745478898; cv=none; b=mF6DwqKiBzqVG13TNz3jkvQkSQH9WfwVbYZKJhpPf1IUnlSYiKB0Z/JqW2dt1qYxUZbGCvCWGDUIjFjJyEUrYwpCXK1juW8tmDd0s/w/dMGQIFsdh/1hRMBNjoEpAicz1waCy93WNf4IH76AjDfrxAt4ezkLnVR26kOv4/i88e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745478898; c=relaxed/simple;
	bh=6soEZQ4kJUtvIiqK5puOZE2rScJp6QCdTzCCiUGiRxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CJ6c/d/n4Xvd2tsKk1qxFjkQChR/clrGBJT8giJoFSOeWPUTNRZjDNFTvqH4sYU1JrUzxOWC70pwH02O/58sifU6cRwmTnX/hauPrPFVVtPXxwTM2Q5zF5z2zpYi3AAMGIKT0wSC8Rsy6qltWyXfljflM3Tb5r7T1ELsEqoq+z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Xq6UZQzi; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Xq6UZQzi"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e82396baaeso114259a12.1
        for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 00:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1745478894; x=1746083694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+B8Lq9RDCcRwOgfM91avCJcgWbWbGSMVAU80sQQPWI=;
        b=Xq6UZQzibfvGVdnwkYbd7NWgiWC05fNrhf9y/0ZSiM0Z7LQhJg9XZHgrUjy9LPC99j
         EJQAIft0BEKZ1eMAYzCFRBPZzO3ppYJziFE6SiAKn52n1iYAm5caWnL4YBWtFb6fcqxQ
         0CfgzwaJuLQHEizVRT/eeN7PaJA+owTom8aEJVlA0wQaPK0NCqNL0aAfwD24Jd/rvSEF
         HBb3Cbo6qnumJ5mfHEUtLNFmx7Fmzf5Xli+VaQLix7V19h2Rq120bC7nkBVrdT5/wAPf
         TLYSvFVXw4IuAI1qzXpDXaECS6zheezm/LEyE8700zeehsbQPw3XyXYO4o3KXiQDBtQx
         VgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745478894; x=1746083694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+B8Lq9RDCcRwOgfM91avCJcgWbWbGSMVAU80sQQPWI=;
        b=n1yBYzTkprNsfXhBSNrz9VfXd/YmFfreFa86anQi6EnjukJCiSbAX65y/dPsp89spd
         A7O+peEHehqeLBenC++XAtLYqAdRmEfk7JMsROWmJIexhRhs3X/qzMzCfORLAno7EBel
         YLoToxEm2qyW4mDbCZ3zVHsOOCIVau8UROhhXVW7G1mrO3Tw9A7bL7bZXRxZUxPKGsRs
         zPPbbYnMdkdiqTvsiL8Iw8Usmg+0v2gzuoGh4U8mcQYRVPdva7sUbwmcWLkWFKpuJ2t/
         iolorC/ljaEwfueIbhF81BUiZ9Gb5HRLLRx26xuPQ9CW7QcXeI1cJ+CiXTQubvWVFC9p
         qtBA==
X-Forwarded-Encrypted: i=1; AJvYcCXcz8cG4AC+DT6Ouf9988C4M4+1j6bW3AtdMdkumSp7lZaK0oXJ+njemVMPBbrNaCN3Sx0WhMLTUCulxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4EOjTxSEssKFi17z9hHXhaGyN2HpHg1BH0e1/u82eu2WGpww0
	vvxl9KMPeFnllQCgksax0k3FOGEwMKTZ02M8emrLUoSgzD7aUVPibjEiToOlFecyZIaG+zsdE6p
	GhuT2GP05pmfCS32Ne65hSV6/Bjqm0LpoZCtFJw==
X-Gm-Gg: ASbGncv7uickGRewAoPbdsVZyqOqQd6srEUttco8sY3pjnLG/MGL8A4PuaP+rPgGDzj
	wSRR8xyFWJIUK0+jyplmFJAX//jpsXHuM6WJXoUQnPC+FfTC3HYV8UIvSbHVYhqRtpkyu4HYDd1
	AYo6pW/A3QhNFpRTwiK4C+YFdG6wzjWiHi8qmq2Okk4M/lm12fHpSHLI8=
X-Google-Smtp-Source: AGHT+IEyAiUyJ2mt3265jGzrXL9ewNYPCotZUNj9QN43I8BqsNkYBnMDkmlm1PZ/N97S/0QtxYx3zQ6j0NbtPT1J4KM=
X-Received: by 2002:a05:6402:35cd:b0:5ed:9811:dfdc with SMTP id
 4fb4d7f45d1cf-5f6ddcf7f9emr548541a12.2.1745478894059; Thu, 24 Apr 2025
 00:14:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422142628.1553523-1-hch@lst.de> <20250422142628.1553523-11-hch@lst.de>
In-Reply-To: <20250422142628.1553523-11-hch@lst.de>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Thu, 24 Apr 2025 09:14:43 +0200
X-Gm-Features: ATxdqUFceKzqfCTaFW1t2hUyaQzIpI3Ey7xNjxMyLwpQpyjJSAnOh5Bm8Qq-E8M
Message-ID: <CAMGffEmB1Y22T6JosV+aJrTf9NWAabuJqovy65+mMLsOcx1ktQ@mail.gmail.com>
Subject: Re: [PATCH 10/17] rnbd-srv: use bio_add_virt_nofail
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>, Coly Li <colyli@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Mike Snitzer <snitzer@kernel.org>, 
	Mikulas Patocka <mpatocka@redhat.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, Andreas Gruenbacher <agruenba@redhat.com>, Carlos Maiolino <cem@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>, 
	Johannes Thumshirn <jth@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev, 
	linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 4:27=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Use the bio_add_virt_nofail to add a single kernel virtual address
> to a bio as that can't fail.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/block/rnbd/rnbd-srv.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.=
c
> index 2ee6e9bd4e28..2df8941a6b14 100644
> --- a/drivers/block/rnbd/rnbd-srv.c
> +++ b/drivers/block/rnbd/rnbd-srv.c
> @@ -147,12 +147,7 @@ static int process_rdma(struct rnbd_srv_session *srv=
_sess,
>
>         bio =3D bio_alloc(file_bdev(sess_dev->bdev_file), 1,
>                         rnbd_to_bio_flags(le32_to_cpu(msg->rw)), GFP_KERN=
EL);
> -       if (bio_add_page(bio, virt_to_page(data), datalen,
> -                       offset_in_page(data)) !=3D datalen) {
> -               rnbd_srv_err_rl(sess_dev, "Failed to map data to bio\n");
> -               err =3D -EINVAL;
> -               goto bio_put;
> -       }
> +       bio_add_virt_nofail(bio, data, datalen);
>
>         bio->bi_opf =3D rnbd_to_bio_flags(le32_to_cpu(msg->rw));
>         if (bio_has_data(bio) &&
> --
> 2.47.2
>
