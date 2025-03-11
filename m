Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5581E0DD1
	for <linux-block@vger.kernel.org>; Tue, 11 Mar 2025 05:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741669380; cv=none; b=JoDUipz8ObN+A2IJiG4zM46A+zlyLcHYq7JsXLdrzF75zVLUEGZ9FHW/ZHzYKDPuDqkMyyTS+3snf6EVPG98gaj93gRkvjDkF7xq4XAtTWdcFvVfgy77lnUqQlqulHzJXmMlruwEhF9R93yXnn3xQjHMNICkJxPti+wKyeqx+g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741669380; c=relaxed/simple;
	bh=3ECEa2t9d5y92Pz32OnF3QpiFge1TDTBvaI3574/zjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yvt89uwbLkCogIpB1VcJHpp2IMOrlMPfR/3xqP4LMNgP/FAyE/nYqTzPsIn3b8+1pgS2sfEOru6fQT0C3haUVUVqoTrFa7bsdVgNVoXQiEigTOM+MuMpGStg9mHlDPq/XlDYqzmdX63MD/nIV+VOL+i3QiMOf9/x2AWSjYf6nJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7UbpngM; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7UbpngM"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e61375c108so4607768a12.1
        for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 22:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741669376; x=1742274176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nU3DsZ1XAulR9Bt1UcDHguhYwisbNbjiLIOTrtdFyTk=;
        b=O7UbpngMo/UkMZPdjaBZ+m2+tEZAhGRwNCdZH4OsRnQJE0xnapSfIrCGsEacv6I4t+
         7nZ4obbSUPuAAW3by+/6h68jfdodGDDO49jasga2QucG3OtJxAa8hbgG6Ntx3t4/Azjk
         huDFol7es/jJjR8BehrGcMvKu2WGaUoDVcF5LvlJRVvLwD5/EuNToEW7tl2RmNn+qTo/
         doydAPohImoDifnqXjljnEsttje4X+ls147zOVKFghMVYZGpH6ds3lFjdEHWMxGE1DK7
         Fh8C3YM6B95chfIiWHqZ38etlp7JPJJlnludEWAaWKE+c+EYrNEl4RpZXYDljet7MQ4S
         w1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741669376; x=1742274176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nU3DsZ1XAulR9Bt1UcDHguhYwisbNbjiLIOTrtdFyTk=;
        b=AJjMad/I4cNxTHnYH+Mcn6vrwmJiza5K+hQVS6Ff3jTmHvYHciLllBV1XtOZEZTjeI
         81U6JAko+C8TezJK3Z6Ck/tW2Giw0vfkLTQFiPjOjVSOnUUmrzMjrsnDsvgKvRgeNSH8
         r2QgZp7SHkifPrM68I9c1vW1oRK+3YzpSx2vCcFr/uDI5HVATGWcSJExm3L99oL8Crvn
         UFQ4urHl0wvVJysl+bDXEt8kIj8Qnq8xYFTbC8JRquTvBeKH0mqsaOrl3hO1zDhszvhP
         u9WJHHRBQkJva2rHnxknXuwQwKNA7zqvyxNj2atM0nTDbZx26vNhjsJcXOIoIyGWeOGf
         mj7Q==
X-Gm-Message-State: AOJu0Yxdj+PT6AWMsxUhjwXu1Bsm0svngAbjQZ9vP7q/YjYe5x1z3MJD
	qbNjh+eTlNFClBjfaxM5QVoc/W0WgDcWM1lx+cQCFqo4GthRMhHRGtoxVn/42JMwS/xDK0dVR9n
	HIdiXr5yUIdsdvLVCvI1dxpaxY40=
X-Gm-Gg: ASbGncsTyqJYWad2kiMGaOwxlRGCWiZCsxcGuzcSvZP6Dj5opGzYl0zCdt6JEV8M82t
	CBKb9PBzja79VnBwsOBWR0vGth9BvqzPj1wxhf4B0WkAoI8wJWY69WrefgReiUSboxUQ35udM2X
	iM5ylZrHRvr3/z1zxJZKezmXXaSw==
X-Google-Smtp-Source: AGHT+IE7p9ESJhaRtmTdHGCk8dKC1MDYNTTHcp542UMCynAJicglEY62j02PsiPON63nvymsVjYo1GJqTYgydaJ1MSA=
X-Received: by 2002:a05:6402:13d0:b0:5e5:c5f5:f5b with SMTP id
 4fb4d7f45d1cf-5e5e249af7bmr18994497a12.26.1741669376163; Mon, 10 Mar 2025
 22:02:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311024144.1762333-1-shinichiro.kawasaki@wdc.com> <20250311024144.1762333-3-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20250311024144.1762333-3-shinichiro.kawasaki@wdc.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 11 Mar 2025 13:02:44 +0800
X-Gm-Features: AQ5f1JqbCkxhn7T9fgxWWXH1RylAmKuYJRnbUWmBaNKkk8A2xfV5IxO-QOVV2tg
Message-ID: <CAJSP0QXZQWSVV60SWDey7i55VqAw7H+W9mQZ1uQyeOLK4TounA@mail.gmail.com>
Subject: Re: [PATCH 2/2] block: change blk_mq_add_to_batch() third argument
 type to blk_status_t
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Alan Adamson <alan.adamson@oracle.com>, virtualization@lists.linux.dev, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	"Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 10:42=E2=80=AFAM Shin'ichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> Commit 1f47ed294a2b ("block: cleanup and fix batch completion adding
> conditions") modified the evaluation criteria for the third argument,
> 'ioerror', in the blk_mq_add_to_batch() function. Initially, the
> function had checked if 'ioerror' equals zero. Following the commit, it
> started checking for negative error values, with the presumption that
> such values, for instance -EIO, would be passed in.
>
> However, blk_mq_add_to_batch() callers do not pass negative error
> values. Instead, they pass status codes defined in various ways:
>
> - NVMe PCI and Apple drivers pass NVMe status code
> - virtio_blk driver passes the virtblk request header status byte
> - null_blk driver passes blk_status_t
>
> These codes are either zero or positive, therefore the revised check
> fails to function as intended. Specifically, with the NVMe PCI driver,
> this modification led to the failure of the blktests test case nvme/039.
> In this test scenario, errors are artificially injected to the NVMe
> driver, resulting in positive NVMe status codes passed to
> blk_mq_add_to_batch(), which unexpectedly processes the failed I/O in a
> batch. Hence the failure.
>
> To correct the ioerror check within blk_mq_add_to_batch(), make all
> callers to uniformly pass the argument as blk_status_t. Modify the
> callers to translate their specific status codes into blk_status_t. For
> this translation, export the helper function nvme_error_status(). Adjust
> blk_mq_add_to_batch() to translate blk_status_t back into the error
> number for the appropriate check.
>
> Fixes: 1f47ed294a2b ("block: cleanup and fix batch completion adding cond=
itions")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  drivers/block/null_blk/main.c | 2 +-
>  drivers/block/virtio_blk.c    | 5 +++--

For virtio_blk:
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
