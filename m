Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459A33594A
	for <linux-block@vger.kernel.org>; Sat,  6 Sep 2025 18:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757184480; cv=none; b=CtGQFxJFm7JqGGD8J7TRb04TIqqBFunBwmTrhJUd+7KHMpQi8lCgmzNGeHA6E3v7e2Cc4ZFvT8tE4qG77BkhqSDs9hu24VHcde3fYghPwZNBiaSz+4XzxE6iJmpxj6gmLCcOiK+F37k7CYIT/4IkssdC10H9zXsrsWETfe5+36o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757184480; c=relaxed/simple;
	bh=udTAB0KLRH0KJLy0mweCUMlJoBpfF1NyRJgUD9mdtMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ewvtv7dp5ttL7R3hpM9fgcKjZrKUV48lHdCH18tVEuVT/pbCQz6TXYXgCoEund6j6UxLs8ban0WbevAgVoAJRncR0vwCdZqw6XcxGdCA08K4VZRehi8Ab2b32sjDtK+OJsj0QQeIVxrdy/rmJG2zcdhJ50woDl/88Uh50IacJGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=e8hGm+a/; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="e8hGm+a/"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24498e93b8fso6024525ad.3
        for <linux-block@vger.kernel.org>; Sat, 06 Sep 2025 11:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1757184477; x=1757789277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofKqOihV0koaQtl5JEXYNozM0XsF7KJ3JW4I2WE4zQs=;
        b=e8hGm+a/sQSPmPRWMD9MccOZh3xlIi4j+x9HkANZ5o+kh16qzrVkz0n9xaiUUXZGgj
         5Rqk5YUh1VPkZvx6iG7lTXFdBoVGl6/uLV35cn8aDfNQ9AkL5XlJGMKRfLwSwe0ZKIN8
         yrS4L6WUcOWxhQeR9cMykI82OQmkoTrRSeGuIB3BjS5EV3PwDwevjlwLMl3JyLGbV9jC
         AsHEXA3YVmXtIwHU7dZ+taPPugCZ0NbGD3tihvExfn86WzDI27pqE+/Hergq6swxR2Ch
         mJQsY+3Zvx7mHFQkj/gOsh/IuIhbN5lfajry/dEXR6snVOX+AgyWzPBaIVBVt81uZZjC
         p1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757184477; x=1757789277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofKqOihV0koaQtl5JEXYNozM0XsF7KJ3JW4I2WE4zQs=;
        b=wwsAIAg+ubwyV/pKTYGa6zRSjy/+RIgwTysR49fDLSbOzlwi1X9opmqgsxb5JCYjTG
         4+Kq6bUFLu8uFQyc/PVLYZCsMlIuOty7ml1qdJMZjx0ffbmNtxt3Zrn5DSd07hBk1uVz
         /p2JDjY7Qd7C7VkpLRrDfRG/pBF5XuYAkEbK1IuAy9mQ0nZCONcg+Fi7TPwt9cliwOZn
         tXF+1giV1zjfVnUCatxk21B0m//dEMZEiQACCYZjYoWCqXtPDUZwrIURtZZiXvxYqCh7
         S6WvxNCEX6nok/mVgmdvXMnTcq7VvmZvRBWXpsvFJSg2ujgpgAX4wH43P6oRzxpm9Ey+
         FjKA==
X-Forwarded-Encrypted: i=1; AJvYcCXkzUOniXe6WTcGwZ3dGYOEn4FqGwc6HnDRQESodyFBAYSXA/SxfkZ26T69s2VI80UV6Uy9ymFuUy/HZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFb2+UI2LmzMjitxD/bxwHfvOMqp0ze39HKTEQ6sOeq3M3bmfZ
	yizxmzetfxnzVDdoPxuOgZL5fQIcn5Rm1ukP7aZ0s9nkaUD1QZ+xjLyxSDm/9JQUsIgi4pUCEap
	AN5+J5o1iblD2RFBNKecoJFbSs30UgUxqvP5SCe+H5Q==
X-Gm-Gg: ASbGnctGf+Qv6hpP6XE8AGq5yDQRL5qLa6UmzLrmROfzwR1SPrOcrR8szCk2+KK4QdF
	NITpDUTfgXO1L8E7gH+/TUU0h4RraNjdjnEk5OPkYuCQVsl1ekplDTfRN//6f8oPIQWYcWybdYe
	NiLPkSyACU9zi481cnI8zI5MOTGbeWH17Yu9yGHZl1i77SkZsi4M9YT5xQJxVPgXCExXsOvJlEN
	iMzGgdCpOZiAvoJtA7DM6M=
X-Google-Smtp-Source: AGHT+IHLTwGtMoAgUUw2HbD+xAvr601xoEhkjfOlqNijVaZa4+ONs2cYuhY5ktXx3NXhfPGsrxc1CQO8ZmiiAn6NjS8=
X-Received: by 2002:a17:902:d4c4:b0:24c:cfcd:7356 with SMTP id
 d9443c01a7336-251663b6f4emr20259395ad.0.1757184477383; Sat, 06 Sep 2025
 11:47:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901100242.3231000-1-ming.lei@redhat.com> <20250901100242.3231000-6-ming.lei@redhat.com>
In-Reply-To: <20250901100242.3231000-6-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Sat, 6 Sep 2025 11:47:45 -0700
X-Gm-Features: Ac12FXyRU-IeEza65kNWrIaS63vtAZsNF-BSYQZNCrUlQzl31KelZu6Mh0T_dKA
Message-ID: <CADUfDZpbKJqgTNMypCexmF5taaO_Xxx0WHFnGvrfYkoBNkCt8w@mail.gmail.com>
Subject: Re: [PATCH 05/23] ublk: define ublk_ch_batch_io_fops for the coming
 feature F_BATCH_IO
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 3:03=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> Introduces the basic structure for a batched I/O feature in the ublk driv=
er.
> It adds placeholder functions and a new file operations structure,
> ublk_ch_batch_io_fops, which will be used for fetching and committing I/O
> commands in batches. Currently, the feature is disabled and returns
> -EOPNOTSUPP.

Technically the "return -EOPNOTSUPP" isn't even reachable since
ublk_ch_batch_io_fops isn't used yet. I think saying "the feature is
disabled" would be sufficient.

Other than that,
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>


>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index f265795a8d57..a0dfad8a56f0 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -256,6 +256,11 @@ static inline struct request *__ublk_check_and_get_r=
eq(struct ublk_device *ub,
>                 size_t offset);
>  static inline unsigned int ublk_req_build_flags(struct request *req);
>
> +static inline bool ublk_dev_support_batch_io(const struct ublk_device *u=
b)
> +{
> +       return false;
> +}
> +
>  static inline struct ublksrv_io_desc *
>  ublk_get_iod(const struct ublk_queue *ubq, unsigned tag)
>  {
> @@ -2509,6 +2514,12 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *=
cmd, unsigned int issue_flags)
>         return ublk_ch_uring_cmd_local(cmd, issue_flags);
>  }
>
> +static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
> +                                      unsigned int issue_flags)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
>  static inline bool ublk_check_ubuf_dir(const struct request *req,
>                 int ubuf_dir)
>  {
> @@ -2624,6 +2635,16 @@ static const struct file_operations ublk_ch_fops =
=3D {
>         .mmap =3D ublk_ch_mmap,
>  };
>
> +static const struct file_operations ublk_ch_batch_io_fops =3D {
> +       .owner =3D THIS_MODULE,
> +       .open =3D ublk_ch_open,
> +       .release =3D ublk_ch_release,
> +       .read_iter =3D ublk_ch_read_iter,
> +       .write_iter =3D ublk_ch_write_iter,
> +       .uring_cmd =3D ublk_ch_batch_io_uring_cmd,
> +       .mmap =3D ublk_ch_mmap,
> +};
> +
>  static void ublk_deinit_queue(struct ublk_device *ub, int q_id)
>  {
>         int size =3D ublk_queue_cmd_buf_size(ub, q_id);
> @@ -2761,7 +2782,10 @@ static int ublk_add_chdev(struct ublk_device *ub)
>         if (ret)
>                 goto fail;
>
> -       cdev_init(&ub->cdev, &ublk_ch_fops);
> +       if (ublk_dev_support_batch_io(ub))
> +               cdev_init(&ub->cdev, &ublk_ch_batch_io_fops);
> +       else
> +               cdev_init(&ub->cdev, &ublk_ch_fops);
>         ret =3D cdev_device_add(&ub->cdev, dev);
>         if (ret)
>                 goto fail;
> --
> 2.47.0
>
