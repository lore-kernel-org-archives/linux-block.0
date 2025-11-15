Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3E08F4A
	for <linux-block@vger.kernel.org>; Sat, 15 Nov 2025 05:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763184318; cv=none; b=e8j/+OXPKrmwz4IuFHyAk+X7JJ1pU17hl2tory3kQXD+ysguegElN6b7rEHlE29iB8yPBBT2ROP6Y+m5QtTfO/QniKTsqZbSp255HwqBY/rXXwC4RL2PiSliq5YqUo5otkwkeuODjXdL1OA01hDGqjG++qxjC4+8D9z/lEH1mYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763184318; c=relaxed/simple;
	bh=PI8aJbuQtBSuSLmQYG7O6j/TLoE4raIP9vx5HBAZ4jY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMazBMU3rTTtr55r/1NqbzmlUGMO5piO352/oq+GjNA+74+cUdQpHabxjUxIO2zlbvs0evFiBZFEU6Bkj0//H1lQXvOxyW2TKZLh5oVP6ruWCEG4R5pWmrMBBGmLrHh/cGJSVCL3LDE6A+9EJzKES6CVkNJ8+zt8uTfTsnXvW1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=WdZ+YNbn; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WdZ+YNbn"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-343641ceb62so445843a91.1
        for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 21:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1763184315; x=1763789115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBqSl/KJNsEoEzF4Id4EpSCAGNWhU2Sp50US1rgl7MI=;
        b=WdZ+YNbnfK8GWGwKUJzg9vYLp58NwduzrAYM9HcPE3mofzIHApcyB6/WgzwWpTaSwL
         llzWzdO4Gjbp+b1k37iTeNIS5PXTNhS313tLXGskxPwRl/9mmks/cDuaVlNTh6SrL+I7
         4n4a13u+8jYYR1e6JtlAdsIdKJdn+XPlWXnUjSadAIReou0fvdZBXD6ckhIIAnhO2aCN
         VasizZ9cyA5bKHFtXIKKvOv2cwb6GYITm0rgrO8nU3YQhsVJLB78zuSe9DMIiQCOlmFp
         nLu05T/54SrOwfnisp3hgx/n6jwOdY7eEsvUFvIdiJh9kXx+ujNxaHOk5b2v+w30S5AL
         +pZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763184315; x=1763789115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OBqSl/KJNsEoEzF4Id4EpSCAGNWhU2Sp50US1rgl7MI=;
        b=Jpu7QVsD9Ls8rkHesLd3P3ToYUbXSUhaSMRS2AOuzEZ2+9n1eU4XPn4+7kr6fQIcCh
         WWqeuNgS/TLUZIjPAoHV8FnqXqfS+r5mJNIoYK2/fkCpJdX+NQ9pDlupEgSx/NtDjlHc
         MgsmpWmjLIPsR45P22zrreBP18+vqqPOucvvyvZpeEDmn/raBY5Kk7c1M5wuDgTKgOWF
         YWwBenP1NbjhrWkVnXDrNYJkp6k4S+rm8R69aekGdxjqiQy4X8GN7kr/7aVesU7NZFGZ
         V8q1GldI4az61MDKqi6DX2TX7or6yrzB8BTNzzJ8zi1xSGn6aQgN+dKTeMrtNbfbtPsr
         nf7w==
X-Forwarded-Encrypted: i=1; AJvYcCWtpc0y53oq+lAFsQ6eSgjR0TnBLO43k9IC/LQyxV8lwYKaoqnGs1Va5i810tzt6IOyCCeI8K9MxBgH9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyQgdiUx4qpDgF0pS5ThsHlu6KtRaT2sF3qiSvy5gjDPPte7lU
	YQAqW1Xz3NJGD3Ss88OfEmz0TujteQMkPYIhIsSb0viUAMSp3WMTR/3drVStxnVxHCX6DdBBJ9K
	pOEY0UkFYalHXauLVgM9DVrarPWQc/xidVcKqRkrPRQ==
X-Gm-Gg: ASbGncv+G5xDnFkdKdkuHnG2MNzmK1D2g/nfOUI7td1P6sCEKWis5uY3bQGWx3l3DVm
	P2cEdXoKoE+iy5tqr4OJYSZrNe3Hu8iXRHgfGwjvoJCtIQETih+/I7uJAX5zBwkEEwgy/thJ0ys
	fnz6qlBvEviGzCTUMLgrBg+FJqvxXv8JMkJtkvlKM7Ycoc14oJF+hChFOmnIfNW01eCMUUbdd1R
	VvrR2uChSqIDjxrQamL3c46bNq0h8OcURcZk23hmoBP8D137qKKQsE8lvN6KSGHtWVIVf/Z
X-Google-Smtp-Source: AGHT+IHjFLAy+nA3A3pjD88OtZeRDK4UAS+TJjNfjPBiXLfQbIxLKZA36LWCdpECsjSZULSLq5FfzdqzOowIPDvndgs=
X-Received: by 2002:a05:7022:6885:b0:11a:344f:7a74 with SMTP id
 a92af1059eb24-11b4120a7cemr1745646c88.3.1763184315254; Fri, 14 Nov 2025
 21:25:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112093808.2134129-1-ming.lei@redhat.com> <20251112093808.2134129-9-ming.lei@redhat.com>
In-Reply-To: <20251112093808.2134129-9-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 14 Nov 2025 21:25:04 -0800
X-Gm-Features: AWmQ_blBUUQ7YaPw7I7eaqeB361VJtH_C1GQWR4SWjffommd8vUsbYXwcpTnvaA
Message-ID: <CADUfDZoPLwNuxcBLbfLo-JF28Y1df6QL34PrHq8ijOKUw2jt+w@mail.gmail.com>
Subject: Re: [PATCH V3 08/27] ublk: prepare for not tracking task context for
 command batch
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 1:39=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> batch io is designed to be independent of task context, and we will not
> track task context for batch io feature.
>
> So warn on non-batch-io code paths.

I don't see any warning? Remove this sentence from the commit description?

Other than that,
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 1fcca52591c3..c62b2f2057fe 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2254,7 +2254,10 @@ static int __ublk_fetch(struct io_uring_cmd *cmd, =
struct ublk_device *ub,
>
>         ublk_fill_io_cmd(io, cmd);
>
> -       WRITE_ONCE(io->task, get_task_struct(current));
> +       if (ublk_dev_support_batch_io(ub))
> +               WRITE_ONCE(io->task, NULL);
> +       else
> +               WRITE_ONCE(io->task, get_task_struct(current));
>         ublk_mark_io_ready(ub);
>
>         return 0;
> --
> 2.47.0
>
