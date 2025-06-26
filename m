Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB60ABA53
	for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 13:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750943901; cv=none; b=q2mocnnaScXxGKxRIoAVziQZfjB9qpxeHfBnWfQiLafKmDYxwa79YUxUzGDUPuiQAkIXxoLcrKtWXYf/WVq3T+i0CG9MXpau9YpKls2BImDjAT4aApYUyZXxSsGI65s87ZxlzT0cgrsAHdqG3+Xt1G/oiBBRPaLtB5ZKQcbkRrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750943901; c=relaxed/simple;
	bh=E150dTFBbcgaTD2RdsdSlPVSto2kCQ8bxGxjKxBdS6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LCnFQsRtKMLExd5tzjcIHp37q08Xw6Pl2IdbER+JxwAYqKWvUGpu3MBXXFlvUSZuEiR/MwGred+k20EpyZUJB3l2HtjqldLgzZz1pvkUgUY9MMQhZpkrY4H+kuzmVWvn1gPC9JrsSOR55EHcZNgKHKDa2r4z1lg8PHFDrgfN0dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KUO0B670; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KUO0B670"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750943899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KvkTm4jKfboZf4Sh6JozVJmLtXbYCDph+ghmY8E0mGM=;
	b=KUO0B670qqm4tR9V3rz/rlbafCtePEnpOioYKO1PuwMQ0uEmhxqnHvRIq4d5saBPUdAuTD
	pkirs/VCVxApFxETm02tJeq/vhrYkEEotUS7AvIErG+NQGjBhPw+j2/YShREn1nsnLAJv2
	phQwEyCinBs/HND1Y2s/bB6VfV/Hs20=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-lISy8zQwMpGNjzdpdFkuxA-1; Thu, 26 Jun 2025 09:18:17 -0400
X-MC-Unique: lISy8zQwMpGNjzdpdFkuxA-1
X-Mimecast-MFC-AGG-ID: lISy8zQwMpGNjzdpdFkuxA_1750943896
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-532d32147ffso307907e0c.0
        for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 06:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750943896; x=1751548696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KvkTm4jKfboZf4Sh6JozVJmLtXbYCDph+ghmY8E0mGM=;
        b=Pek9z/Rt18LVex2FzfSjtgmxJvU7dsofhz3tTx8SNH2b/BgrE/EoPhrNk6z9McBvDL
         GUbn40vGeZ8tHiOwNQPh/JMtdJ87LjjkaNBqU3YyQYXQgpkbpyKxSlBc2Xrk2ccrYP0p
         fjVJACdmeJSgyjaWrzLUQtEE7g1+ZADfH5CL1+0i22b+p1JOsb47iK5yTC8ymb0nXP2Y
         rZwmVeIunhAGc279NhWZxNWsq65FYpbi7yuA2JkBcABnHNlOCJz8GZ771FrachvDu2ns
         rYuAncpnrnTBytXPknBTmF7z69hD4f5QvaQ/LRSpMYta0Nu6v3AaBzYcFri4ADRiY71A
         SGYw==
X-Gm-Message-State: AOJu0Ywdm7tI9RZXsEfku2qefQW+MVErUJz0EWBEeF8IqeLY4w8l4rk+
	ytawgTfhnx/npIWilfGspocCn8lllNSJ9dflAfpJBTXDGPb4ZW70TLBpKpU9huAVK4rKEIA4e3/
	XXoRXUxHM3W+v5rdtktdUu708a8yk4fqsfmGQHVD8hZAiTp8kFaYkovu3tEtCTjiUDCWSR2gzYV
	DYzpW9U2221m/4f7Z3bXGyLuO7WqSqCRxR8gGnkPsUSLwLQwyjwA==
X-Gm-Gg: ASbGnctmT4aHxRaXEdOPY37EDg0+JB0qefCwqFu0943lYVN5jdYu52whzk8l14kSQvp
	ifYzr5nxBzjIVXyXkbGOUPzm6JLqJKFXSlHFsoJvFTF0Y7xVGlPSVwdZZzYrbRb14M2ruc1sUKV
	epdso=
X-Received: by 2002:a05:6122:2a43:b0:530:5996:63a2 with SMTP id 71dfb90a1353d-532ef476490mr5614850e0c.7.1750943896360;
        Thu, 26 Jun 2025 06:18:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb4v0lFUp3iZ4ZNiVTo8o8cPg/rdQTbBmt7LglwdMJdO/fGag9D9pITC8slS4nQjkO/s5GFjf8yrTAMDnfErE=
X-Received: by 2002:a05:6122:2a43:b0:530:5996:63a2 with SMTP id
 71dfb90a1353d-532ef476490mr5614781e0c.7.1750943895952; Thu, 26 Jun 2025
 06:18:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626022046.235018-1-ronniesahlberg@gmail.com>
In-Reply-To: <20250626022046.235018-1-ronniesahlberg@gmail.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Thu, 26 Jun 2025 21:18:02 +0800
X-Gm-Features: Ac12FXz5cS85gMnSjV0ojJS24y4yUePFMvsy3Z_bh6tbQWYDTDUNF0qkyDQLLtI
Message-ID: <CAFj5m9KWcCbP_dzfUOpH5ciRtxnc6Zrbp7JuOHS7orViWK-tjA@mail.gmail.com>
Subject: Re: [PATCH] ublk: sanity check add_dev input for underflow
To: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 10:21=E2=80=AFAM Ronnie Sahlberg
<ronniesahlberg@gmail.com> wrote:
>
> From: Ronnie Sahlberg <rsahlberg@whamcloud.com>
>
> Add additional checks that queue depth and number of queues are
> non-zero.
>
> Signed-off-by: Ronnie Sahlberg <rsahlberg@whamcloud.com>
> ---
>  drivers/block/ublk_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index d36f44f5ee80..471ea0c66dff 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2825,7 +2825,8 @@ static int ublk_ctrl_add_dev(const struct ublksrv_c=
trl_cmd *header)
>         if (copy_from_user(&info, argp, sizeof(info)))
>                 return -EFAULT;
>
> -       if (info.queue_depth > UBLK_MAX_QUEUE_DEPTH || info.nr_hw_queues =
> UBLK_MAX_NR_QUEUES)
> +       if (info.queue_depth > UBLK_MAX_QUEUE_DEPTH || !info.queue_depth =
||
> +           info.nr_hw_queues > UBLK_MAX_NR_QUEUES || !info.nr_hw_queues)
>                 return -EINVAL;

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,

