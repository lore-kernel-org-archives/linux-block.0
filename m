Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F49409293
	for <linux-block@vger.kernel.org>; Mon,  3 Aug 2026 13:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785763312; cv=pass; b=bTok5FkI6VeXtqvOHMQc7Hwrh6OLFy0unFCNs78Q4wBU4hE91xJnyUNOEWMNLZ3HcESmllPrJk7CoLNvG5SzTk4QKcdpyNucmkuRq4tu2OoAyPVZOSx8JDjTDiEf08hCkmM69AgNRNtm9kqaBie2zRGorTIRLCz4tIg9S5+7pI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785763312; c=relaxed/simple;
	bh=Pgl5mTcqFOqWGOQn2TZduStirxwuSm2pRwIjZSucJwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p1+JRWmvrygw29tvrysxZGvX7RAJ9EfdOXUR5WMvohLJYCslIb673l21mjmNoWVIM+4sVRyFbznIMEHZix8OMEkYD8t0fLMbBY4jI1WIRYvWiiTumO5YcD4ZLAHNcQ25QCqyMwtugkYdyWB/HYz8CQ9fG/FBTQIUDotg/+tOcII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvxRm/Zc; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvxRm/Zc"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6983f20a8bfso5522352a12.1
        for <linux-block@vger.kernel.org>; Mon, 03 Aug 2026 06:21:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785763289; cv=none;
        d=google.com; s=arc-20260327;
        b=XQZWFjFIjc9GZszSsMIjpfptY1Pd+sLM2BY8R4+5sTgDGtG6QtkcEYNtQ8Cex8fGrg
         BHMCUIW9j/lJUriZ7PsDwA0wZQn9aFds0d8LTlMIMC6Ttvz6VPahezIfMvZIv9GhoeKm
         86xoMEbeBe8R6vba8j2wjFfiuv/+K5oV5fH3o6l47Logq0nVkDBVotLFy0ci2AwmF1pI
         GUySzOq2BcpfV+0bbHMCvAJ79jC474bXmhI+8KXIBRkivjEQZ5wqKaEhNf1WNZb75++8
         Pz7MgwFEZZQWC9QGzC4zY+ZM8xF4ZKTvRBylaHr75s4KT7REaEQL6y8nPyU2in2x8Q4d
         H40w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y/+lXFVTL8yRFLlIHwc83PXR9zbnjKq/x3zTQK5cH9A=;
        fh=TaQ5daE9/9gFXjId19jQtLH3G/4mukmxTKJO82Jz6Bc=;
        b=pTnjJYmdmu36CD0zqla3i6VrdBeIsDWYU15WdWTVUrl1O2q7u78ElTP3tTryuo2DOb
         4O6EvwiL0fbloHdET0EwsVPGcfmzJ8MiYWhA3fXgUwoc23vLfeRkZV51vC9HsW2kFvmL
         l8W9vvwZvG3+BTrZlB/lK57y34DDiAUwHGCC/Uea/sG2OGuXJmAi4kVXDKnqRy3oGEtB
         xKJJaLwzLth8qRiYhUAUCxhZzR4pD41Ydnj5ldzn6PHjwtRr6s4C2d32vG/yIWjvHIp+
         tqRKYp8v3RpZdMUaBBF81JMm6mjcUKSJIVEMEBUCme/jY8eBd2Q3zjh00GuOcl8EG2XD
         TlXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785763289; x=1786368089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y/+lXFVTL8yRFLlIHwc83PXR9zbnjKq/x3zTQK5cH9A=;
        b=dvxRm/ZcGYR2VElqHNvrbIbP9OvHsQkpvLJObV5wRx/fXOfUt29OLPtE+JvxWK2AOQ
         3VhaxWdK9wr8VU9F7OpdHh93UyXYln1zJIFeKxpY8byuq8uH5aOk6evZeGjO9IkqTptd
         6pqSXC4iIsTM5Q5hI3ihgFCpFYQmHAIH17jBmK2nWesFrnXCN+cLlB30cVLoPE7iBxPq
         YNZUhtvw1JycZThdfbfdyNVwsIyNlqZahx8PqEto4vhXRgRne7m4fkHUxVzQMxB0N/A0
         77oJ0UDkdALZBQIED3QKAmbqVImouGpGGwdcCJe4RsLDjGD4I5xyy4Jr8+HbjvOIgaqa
         GxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785763289; x=1786368089;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y/+lXFVTL8yRFLlIHwc83PXR9zbnjKq/x3zTQK5cH9A=;
        b=nQcqWlksfaPKofp5rQTL8bXioSXXEEL9xux8/mMCWArCXuXix2b/xh2JVEDY6SA/xx
         ocUfcCXtQRT7MGt7fVFxvHTiugLJEbPNylqgsyCaVp5ZLwPDcp8Z7pjAWXv+RciWiY2U
         /m8xTU47So95Uhu9ojw6C9VUYXhpLHaQg3oPTKwwy1Kw52uQ7TcBxorha+ZsOQaQX45A
         jJ09fa+PlvqW/8UuP/ExNfl2rHNzH/UKmCsSGu53Vy1NooqlbO3MS5vx26U6E6z9h7MO
         qW5VRUfRvPX/Qxb6ZEleHktODmmj791mJd02Y4VmRPwmuRfEGOvIoBHnVlEilALfB7iq
         oiZQ==
X-Forwarded-Encrypted: i=1; AHgh+RrH8mpIPa0A2o5KemAvny7cXdMj5vX/lgePGmIAVeTTYju/wtxEBG9KFE53P5x6ce1RCkTxnDAstAACWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvmbOF3b16PsybpUVem2aVARRRXQIC9DzE9ApCpBcym3cjtoQh
	bISStz2rM/EPplI96CQPOXoco2NqWkGyZIE0AThDSBLJS6nqLjdzmGz6Gg5+W4CsCeJiciIyodM
	nUo9VpOgIJ5x9anochnx6Ed8P0heoyQ==
X-Gm-Gg: AR+sD11MQV1/qXgueF+FHAmMrpQ10OikA8eRRiKEAW3oFayMz69U4m8DRBDjA+GrOua
	KBnROpy5mWNSiHuDyMkLcVAjgRWazdP0DYqmy8r6/79QRDHt1dLqYjOcxY9oaBjexiYE8lxpTBT
	cY55YgoVwmd8NMYDVGpe2QaqH1ja48W5AzdQnlK3naUJi94HNOQoDgjllPyYgbnpO8l89rLtJye
	Sax3L/DrX0iU0+IabVCMwS9oDDjT+KWjUH7OpVQUooC2EiHYcB8CbY/GcWRoetgH1b0hp4IDIJF
	s0y73wF62gp/Xh9+wKVEvbDzkUGXpcjVQ7eOrmNc0LLLlCSx1ggcnXjza+94sXuJUTmSWE1TLls
	6hhRYAaPJI/fFuh4=
X-Received: by 2002:a05:6402:21d9:b0:69c:794d:4862 with SMTP id
 4fb4d7f45d1cf-6a0a7c614f9mr7875783a12.7.1785763288576; Mon, 03 Aug 2026
 06:21:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785596451.git.asml.silence@gmail.com> <c1ab6c0db3853b339a89aee0b1a9c5ac0c48b79e.1785596451.git.asml.silence@gmail.com>
In-Reply-To: <c1ab6c0db3853b339a89aee0b1a9c5ac0c48b79e.1785596451.git.asml.silence@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 3 Aug 2026 18:50:50 +0530
X-Gm-Features: AUfX_mwnLWCAPfRurFp37qU73Xc2KDpD6en6Q3cA2kgelroMq6uNFVC_YKEZqSE
Message-ID: <CACzX3AvwBF32_ODomei3XHSZ=KtRaWLN-_Tfkwv7sV3Ssc3wmw@mail.gmail.com>
Subject: Re: [PATCH v5 02/16] iov_iter: add iterator type for dmabuf maps
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, 
	Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>, 
	William Power <william.power@intel.com>, Phil Cayton <phil.cayton@intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>, 
	Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, 
	Benjamin Marzinski <bmarzins@redhat.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev, 
	nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 1, 2026 at 9:19=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.c=
om> wrote:
> @@ -841,7 +857,7 @@ static unsigned long iov_iter_alignment_bvec(const st=
ruct iov_iter *i)
>
>  unsigned long iov_iter_alignment(const struct iov_iter *i)
>  {
> -       if (likely(iter_is_ubuf(i))) {
> +       if (likely(iter_is_ubuf(i)) || iov_iter_is_dmabuf_map(i)) {
>                 size_t size =3D i->count;
>                 if (size)
>                         return ((unsigned long)i->ubuf + i->iov_offset) |=
 size;

dmabuf_map shares the same union slot as ubuf, so this reads the map
pointer as a user address. gap_alignment() below already returns 0
correctly for dmabuf - this should too. Checked the rest of this patch
(advance/revert/restore) - none of them dereference the union pointer
for dmabuf, so it's isolated to this one spot. Doesn't affect the
current series, nothing reaches this with a dmabuf iter yet.

> @@ -872,7 +888,7 @@ unsigned long iov_iter_gap_alignment(const struct iov=
_iter *i)
>         size_t size =3D i->count;
>         unsigned k;
>
> -       if (iter_is_ubuf(i))
> +       if (iter_is_ubuf(i) || iov_iter_is_dmabuf_map(i))
>                 return 0;
