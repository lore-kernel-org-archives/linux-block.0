Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BAA14EC73
	for <linux-block@vger.kernel.org>; Tue, 23 Sep 2025 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641981; cv=none; b=baR/xdOfFZqtIMF6X9u0WMNdxN7wZ0aRuIisbtrU40Ml0nio6YFIM7SwWhwld06mVYVgsG2ZDugcBYqoSmiPU2ifnENEZtpE94N3VuxUwboEYpvFccHYXTy/wdgvViUfXpCU3rJlxB7nYhORx7+Szn8P4TpbgQv60jMA15Hx+gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641981; c=relaxed/simple;
	bh=leaYlnpusCp0sviLQ30QGe0J2gUEvF7RJCcVhGVbZ14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LjhhlVyQgAIoDWk/voNi6RZdG3iA56mt3DkP031DpJXwXqdg2S95CiNAX6dBL3rUtlmFM3ZD92YYOCDGmzTshMkT9ybmdRMej9C1oLl/TsAJX79IYw7P36+7lkhKwDb0Y5UlNi5zH8VmPUWBilQ7OJdx/H9iRCC8LT7yLUz3NVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=XFBsSAOS; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="XFBsSAOS"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b7a8ceaad3so56348251cf.2
        for <linux-block@vger.kernel.org>; Tue, 23 Sep 2025 08:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1758641979; x=1759246779; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DZbdjr9165OSR3oEX8S38orQ1XZpFhmOJaG/L+oMydw=;
        b=XFBsSAOSkNNBCgIHM/jKfQNGj4uSj9EQlt0cFgJHkFOyOKC7kmCDBKNJMj2KeN6n5y
         v0HP1/T1smZv3jtMbwDhmrogOyQV4/yerCIowlzcsLDu251YPlVtiAaqBbOETPWQ8Mbt
         Ua9/zrGmL9NHQRBwrwVHf9qE05S6H3Sh2DFCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758641979; x=1759246779;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DZbdjr9165OSR3oEX8S38orQ1XZpFhmOJaG/L+oMydw=;
        b=ux2YE63clVo4CBo5JawwtpueHxJT/FrZS5Et5CSJJl3yb4G/hgkKrpFt4eDsaj1vCF
         xxVHQlNkCpSs3q5fs9eEyi6b6suq+49W3BbqJvpIX2w6TJj+pre+4Gg4P/fYrIgzEvhy
         vr17Ixh0wZNygKBuAzkOFqVJemZgV4qlqtta+EWJK8FOCWKfXfgBzE8r/DNOXjfKDP0T
         I7IFNfDJyKVUfH2qcDDcCWSENjqwa4mEEJU8yL0wvdPz3q15F7dqguhXv2uWV3wM05Nb
         vHgC6LTlmxxKgPjFZUEx7+A7W3L8m1bhhzj0uknSr7nH8FFFXI3p3E5m7c8CyY1KiD9E
         ewWw==
X-Forwarded-Encrypted: i=1; AJvYcCWsjG9ZFTL/IvdUG31sfb+c49CwfIs6ZHEVVK8nPPmXf28SMP+Rzg11txCs/0pcOolj3TCpZDcJloTjIg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl1f/cJtJtjbdRm89XcpBScSMg+RXUj6283i5BdLVoNkMpkhEi
	a89nVenyzrh9JcPRJmCBWoe/rC3bWvJoHvpgAXedv6tyObcI4AGk+4emcnhI+tMHSNiNpmSf9w/
	clLIQz3dRaH1AjcE+fQnTw8UIC+Gutb2C7tW8dMiqtj106c+fHf6E
X-Gm-Gg: ASbGncthsTs12iOk8d9VQG9q+TioKbWcdanM4L9/8eOWZTlQFsZFqmovkXVd4q7b0J4
	m1BgmGzKEnJTCKtyPEmgr0c2iL0UU3xe7iWQMnnC47YeXWScv5GKw/celuPiPQbXxhSlMnH6S3s
	aFM+Y7s7eVlX0t9S8I0Xg5XSz5vgWW8PubacHrTdJ4T8GHvp65EvAuVwrvREpPnJY7Zf1m515av
	2FJoPNtdtK/9E9/15GuPGKHnIKs03sMXvOWJmiBLaoO2J1MZ9vmOyOp63I8hlab5YUhhI/NUDYL
	rd2QOfw=
X-Google-Smtp-Source: AGHT+IGspaeUy0TVQz+LKc1fihw58Q7yPvQbyT2d42SL63rUJcZogQsEDyrgJGDuBFJvNYzyLCvEvUn0X00pmc3DhAA=
X-Received: by 2002:a05:622a:1b13:b0:4ba:c079:b0d8 with SMTP id
 d75a77b69052e-4d367081860mr29707731cf.17.1758641978539; Tue, 23 Sep 2025
 08:39:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923002353.2961514-1-joannelkoong@gmail.com> <20250923002353.2961514-14-joannelkoong@gmail.com>
In-Reply-To: <20250923002353.2961514-14-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 23 Sep 2025 17:39:13 +0200
X-Gm-Features: AS18NWD8_t8WUM8mJa_Wrlt8XR1hgYkR6Ub6lG20YNejgtDUqRhxsnnPFLDpPVI
Message-ID: <CAJfpegsBRg6hozmZ1-kfYaOTjn3HYcYMJrGVE_z-gtqXWbT_=w@mail.gmail.com>
Subject: Re: [PATCH v4 13/15] fuse: use iomap for read_folio
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@infradead.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-doc@vger.kernel.org, hsiangkao@linux.alibaba.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Sept 2025 at 02:34, Joanne Koong <joannelkoong@gmail.com> wrote:

>  static int fuse_read_folio(struct file *file, struct folio *folio)
>  {
>         struct inode *inode = folio->mapping->host;
> -       int err;
> +       struct fuse_fill_read_data data = {
> +               .file = file,
> +       };
> +       struct iomap_read_folio_ctx ctx = {
> +               .cur_folio = folio,
> +               .ops = &fuse_iomap_read_ops,
> +               .read_ctx = &data,
>
> -       err = -EIO;
> -       if (fuse_is_bad(inode))
> -               goto out;
> +       };
>
> -       err = fuse_do_readfolio(file, folio, 0, folio_size(folio));
> -       if (!err)
> -               folio_mark_uptodate(folio);
> +       if (fuse_is_bad(inode)) {
> +               folio_unlock(folio);
> +               return -EIO;
> +       }
>
> +       iomap_read_folio(&fuse_iomap_ops, &ctx);

Why is the return value ignored?

Thanks,
Miklos
