Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D3E46982D
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 16:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344013; cv=pass; b=P0L19YjElBMP0U7GUK5AsXeE/4uy4nAUz/0MhcyM/zSWp6K582MoeamhUIBKZ8p6UAH5ddBh3aDqCdEfh+02myj9nTS0pbkpSjXLP6vinHafhZ+FOhiDR+w68Yd7mLlhngfnXEjoZE/uppsNyMGCiqmlmnkno06PDpp79+9suB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344013; c=relaxed/simple;
	bh=/YYV8EJ3uAY8vVlHWLu4xPFSaaoxJidP5IaWXw3aYyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPK/ede2tgN+1tuX+5oa+I7nF5UvTSn7RtKGSLv80gx5Cw+klC8wmgOF8LRmGyKU6xkkgCAOBBvpCH0Fjy41rixy3k10JSnjfSLGv7alu2240KN7gJy+Y4BBY+KXj2Q1tgXukB+JeoE/3PnQCx1pR/4g0MtPF5qL9WsNSgO5sjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZnLVGTN; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZnLVGTN"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-698a9f11776so1760230a12.1
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 09:53:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785344010; cv=none;
        d=google.com; s=arc-20260327;
        b=f8RGkT+d9eflMlxSX3y1ojdcLjpf+SZb/ASuS+ir1MQ2003AXcB27/ok2UdpzN8Xwk
         nzfdJnP1DKlDpsf/uwliLUUeyI/MS7SRpmLv83kBxb3l+6osfg/BjCYj3JWDk2ZnWgMW
         CGoKZ0s1gIi+xuDz2eymCQ2UhXL5hkZf1/GR1E6p803f4A3V61561TbdPUnU88IW0ehd
         espniVTh2nS6Au9W5+ys59l6CWupRQSxYJMmwJJ1SuFplGvjS/KDKhVtrUpWBcowpDl6
         dZmVhS2XTAw0cxnGiQ31M0ectOG9hw3+6NRshZClMAXby/jxP3URatWBS1VdLRVO1muN
         pCIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iRO7Ed4PohyaBZ/SmZ+npcgI12Qnh1MLhDgk3TF8jow=;
        fh=7QgYh1Cxh9GxBXnRodm9k8tr9vUxHhTcSK/hoKGEIQs=;
        b=nOFTV32j0VWPlAQutHUyu9jyZlZC/vLZ2klN4HDu9FyidclcZIq/p35PG19qMehc0J
         Tj7qbZQJbfTSk7/VVjP2gbUZBSQSP6nVMiz0a58N9mTaChdAzjYLsIsKV7vM9gSb3vjm
         XwVDutWaPUdm7Agrgs69NgXoSeLusTma/f1ux8FxgNJVr1L4eURvwAb9YZLRaQpfiQXs
         2zb7cx2hCrqTktslulj5N19MXAYQxFMPoo1V81blURwGD2RNNkn6WoRcwHNleo/M54I0
         bm+cijnNBTwiP7xH5YPo4P0aXc2iLESKHTzqo+372dHUbk5TjAxrhQ2CZqVebAemf1K/
         nQaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785344010; x=1785948810; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iRO7Ed4PohyaBZ/SmZ+npcgI12Qnh1MLhDgk3TF8jow=;
        b=bZnLVGTN71+6rOGUEDOF2KKfsBoVzgPc+6KjOtUaxwoQVgAQmK+bgtKyqFpFZyFtJq
         nJFEqB8j7YlMnW8bUNEzJRfJdekDJcM3xXyXgWJfL8WDAjIA3f+W8yZPcnNdDQX6YYPs
         zt8TRyVY0NOcpOxJVRgxQ3PtjdnE21ULXhmra/XwVXzB7WWEeWKmgccKwMgl8IfnmX9e
         NcmoVChs0wbWpUsGydeoisKkkxMd3DGcCAK/J5JcBvgO1tu0OLStdS8VZccIfwTe6wFB
         My0l1BLssPp/A1RJ4FF3WmwVQ3SdB6FnYUo9UJmt9ZOwzK9HEYfhV0xxZNVb2TFtv0WA
         WvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785344010; x=1785948810;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iRO7Ed4PohyaBZ/SmZ+npcgI12Qnh1MLhDgk3TF8jow=;
        b=Ej68aSTJojC/7owBAXSp2HDZgE+YcjdGjg9irTJoPEIjaWbgt6mma+rWGzqFllA7zp
         BFkAsC0+1ARnWseG+JHU0oxpiF1Z2zjMAp4/x8FzG0Cn8mbBXFR2ghOUntOGfF5Zq8oH
         Kf/l+eEBgoaooBZWQer2LRjVL2sDEwit3VgbCz0PRy7m4rTSytx2yuibOTmUyIos8ZG5
         FVq4ab3ZQkdWuP9c+vppjuZ9E6Hn8gAjTtX6YQq4+4zodfAWw4SEfB4Aw6N1XUbGRj+i
         bYUlLaIN7lcxiWb23gImcGVKEtN2O4g33P1iiDJ+zbDqe55ZYsSS065MmL0D2HfY6EV6
         CisQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrig4Hn1G6vMbJqFPoIxsAwfKz0EmK8O4Q2DXUa97aCdQ04SwFuSpREfzsK0XCGUTBDvZVFOhWdylIwxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYsTkIoj6FGzzmQLzrNNZP55GmeFIAQoW56hQUXrYUvYORD/3p
	WGI5YJeVP+8EERlhKerSMBnTR4IEqK8H7K+FBCNgScWXr5hLZ4gzxwqmT9mn0qis/uPExgPF5p/
	3+vWHXvHSsJ0j0YKx2ExVxdJu7JVZEQ==
X-Gm-Gg: AR+sD11fjXQKeDtBBgJLljq99bJoC1ZurQcZCmYHjYewbr2Qn1XnTdeTHoYgKZO3L59
	50zlIMbUlcF1IWzRCcT3YoiOdEie7gKdZ9dQ3z+tNJgHWHtva8or0hbT0+PUQdvNSVHf1zSn6YP
	kPyFUPR5Wmq7jx5LTOJEt08aCesCQLyP3mN6G7HMutxC0ouWfaZwuQK36FuCUYxel5DUiM99ah+
	wepjV4qA1AGX//CXQNNQqorWAqqVYr9XWklyTP8XqTrnBH+pWNdRraVxtBnLiKeaDBck29TNaED
	3X8afaFs69Ec4n/kD2+j1xBEgCm+FS1HOwuhJyrb0Gsa8T3QvZ96XYaGGNGcIo1ZIwcC1IFse+a
	8oAmxAQ8DePd6kEtxRA==
X-Received: by 2002:a05:6402:5018:b0:698:ae69:3992 with SMTP id
 4fb4d7f45d1cf-6a0349ec697mr4404066a12.16.1785344009469; Wed, 29 Jul 2026
 09:53:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785274111.git.asml.silence@gmail.com> <CGME20260728213020epcas5p1721e72ba5544abf0b61482da005120d9@epcas5p1.samsung.com>
 <26dcd0ae5c87a3ada5710b14b6894ef343cec6fe.1785274111.git.asml.silence@gmail.com>
 <583fdfb2-5368-467f-a388-6d388859c995@samsung.com> <0df2f832-e8a8-4fdd-a5b6-e08657c2891f@gmail.com>
In-Reply-To: <0df2f832-e8a8-4fdd-a5b6-e08657c2891f@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Wed, 29 Jul 2026 22:22:50 +0530
X-Gm-Features: AUfX_mw2n1ETd8ASN5Vcu4oMSqcqp6oKyV0zFdoD8l7zvxibNrqO80gPOx-5lV8
Message-ID: <CACzX3Atj+hJmF+Au1Yw5KMk--EHy_J=7Yof1aQNkUV0hCrdVEA@mail.gmail.com>
Subject: Re: [PATCH v4 14/14] io_uring/rsrc: add dmabuf backed registered buffers
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: "Anuj Gupta/Anuj Gupta" <anuj20.g@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	io-uring@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>, 
	Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, 
	Benjamin Marzinski <bmarzins@redhat.com>, David Sterba <dsterba@suse.com>, 
	Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev, nvdimm@lists.linux.dev, 
	linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 7:37=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
> >> +static int io_import_dmabuf(struct io_kiocb *req,
> >> +                       int ddir, struct iov_iter *iter,
> >> +                       struct io_mapped_ubuf *imu,
> >> +                       size_t len, size_t offset,
> >> +                       unsigned issue_flags)
> >> +{
> >> +    struct io_regbuf_dma *db =3D imu->priv;
> >> +    struct dma_buf_io_map *map;
> >> +
> >> +    if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
> >> +            return -EOPNOTSUPP;
> >> +    if (!len)
> >> +            return -EFAULT;
> >> +    if (req->file !=3D db->target_file)
> >> +            return -EBADF;
> >> +
> >> +    if (req->flags & REQ_F_DROP_DMABUF) {
> >> +            map =3D req->dmabuf_map;
> >> +            goto init_iter;
> >> +    }
> >
> > O_DIRECT is checked only during registration; we should recheck
> > (file->f_flags & O_DIRECT) per request.
>
> Nobody should be able to clear O_DIRECT, unless I missed something?
> And fwiw, io_uring wouldn't be the right place to do it.
>

fcntl(fd, F_SETFL, flags & ~O_DIRECT) on an already registered, already
open fd succeeds. The consequence is that subsequent I/Os switch to
buffered I/O and cause silent data loss. Something on this path needs
to reject this combination.

> --
> Pavel Begunkov
>
>
