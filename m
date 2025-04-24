Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE131FC0EA
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 18:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745519329; cv=none; b=VvP1O8sZuU3nnYcZuKUEp984UdQYYZFn69y/Chc/0m2xZcq+vcbNy/mOUQPYCrpmLUgrhr2gIjlDVKMhmXtkRoY5dGUABIdEfSf+x2OYKuwJzit3eSRYbK+As+R4aP8f8rpAa6F6ZGQtTQFzjLP6LascEyfyiRA2HdGWfgXUq8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745519329; c=relaxed/simple;
	bh=2fw2xFj7P/zVtxlbQXcdM2QNVnsHC3V5Cck93HORh0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s76Dvi7xh5VOcqKAACPcAaMUEJvmwVqDQdkzXFCHUozAG+7drlEv+OzqesjnUqQt93lRzIer+SVb/1F3+zBUsA0OvJHnMMCgSLs/b+hcjaXQaGpsh6XqMWIL232iGG6uXJ9dmRVkfM26hw2SckGXTUtLYDdA1U1f9CZhGoaUi6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=U3pRzCrN; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="U3pRzCrN"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b07698318ebso129599a12.2
        for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 11:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745519327; x=1746124127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fw2xFj7P/zVtxlbQXcdM2QNVnsHC3V5Cck93HORh0E=;
        b=U3pRzCrNc0WchRXyjHCQ2KiAdG1buX/GUflzw8LnhhFzk3ra7/y7ZKMQ3k5BQs0yOp
         otZcwQR+I53gQar9HbezK6zQcTNWIH7hgYUong2AM1WeidvUkO8ZPBIKiIec3y8EEo+x
         QGfBSjKMo+ok/4Y4H8sh/rkmlOdnc2XHyLbo3Cp8JOHHyXQ9dBQyWm89JwpB5HJWAZB+
         UEXKwp9GZLTxnQ4/pZ8oBFogxCjOdnplaPBMsxBrRBDQkxlXS7yaU79Nyst9e0qYRN8H
         wmtdCrk37iSyl0nKe5udpcXqVuHHJEUAEnyAA1i8cD+4XNARgxdvNMy93UFyqHud+TcC
         oDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745519327; x=1746124127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2fw2xFj7P/zVtxlbQXcdM2QNVnsHC3V5Cck93HORh0E=;
        b=IlHWgn95OJcBBMuTfSSMTGyunL88ESIs7c673XCc8/C60TzxY9eqV9WMBpJOdd+uPE
         A4kHfe2R9VXSIdpg/VNCv0/Z905JkcN3AOKfAzzSGqsArzO3V7YdSJSfx0l+pP4zJsBr
         Gw5pZYPmL3gnP9onamvF5rjkCebXL96odtpDo4nxjHjO2XLHbxKK0QGMRB8SmfxIEOj9
         LCctBKRbx0F3Zi7c8zeC8vjAclqWFm49y2+WLNUdOG2LuoaZkk02xOMaWpM9DZqy8G/V
         /cMSWaGFTNcftMkq8n/L1Tc2heRiO18i/4CJ0F+O9Gr37WwaA4YkzLFK8bHYtSEK13ZM
         8klw==
X-Gm-Message-State: AOJu0YwTBs6yAMKmFo3biasx6WYUHEQ57JZU5NXIHlo+Fs/X2TMjvhCt
	nzAYAmvVmtnOQk7M//DIy3JsaGiGLTywC5jFrOudMKvzVPYZTjM8ZpRORjl3oDqWKEoJ5Sr/GC0
	PFBd4WqMBPKMVpmEkS4XQfoNUZz/MGPHsL9tPxQ==
X-Gm-Gg: ASbGncuaBF6zLPuQVqHTs+8DHfTs4DdUG4idgA6XN4cd7tGV5vv0cUcpx1eWxiYJUt0
	cSJ5aMNaYw6jpjaVOIavbmXXYGr+iGkFkdoUjaFTHDreyhOwJGvn2GF8guss+EJB6f+fFQvO7fJ
	4/RLz0DUJwDLKi6yvgKLY9qLaUw+sxdz8=
X-Google-Smtp-Source: AGHT+IE9EvgDWBK/qsH8CsvxI91wl7QkpQQp9AeIcRilAQxFR+AmebFHc+W1MWGrkTTVanmWAMeEAAaaN9FaDAMck58=
X-Received: by 2002:a17:90b:4c4c:b0:301:ba2b:3bc6 with SMTP id
 98e67ed59e1d1-309ed58334bmr1717412a91.7.1745519326695; Thu, 24 Apr 2025
 11:28:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <IA1PR12MB606744884B96E0103570A1E9B6852@IA1PR12MB6067.namprd12.prod.outlook.com>
In-Reply-To: <IA1PR12MB606744884B96E0103570A1E9B6852@IA1PR12MB6067.namprd12.prod.outlook.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 24 Apr 2025 11:28:35 -0700
X-Gm-Features: ATxdqUEH426T98gaMe5WG8gZetr-kpkKcH5IGVtZBoGGXZHVa20UxJSOIMbCs3Y
Message-ID: <CADUfDZo=uEno=4-3PJAD+_5sLRMaoFvMUGpckbD3tdbhCxTW4A@mail.gmail.com>
Subject: Re: ublk: RFC fetch_req_multishot
To: Ofer Oshri <ofer@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"ming.lei@redhat.com" <ming.lei@redhat.com>, "axboe@kernel.dk" <axboe@kernel.dk>, 
	Jared Holzman <jholzman@nvidia.com>, Yoav Cohen <yoav@nvidia.com>, 
	Guy Eisenberg <geisenberg@nvidia.com>, Omri Levi <omril@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 11:19=E2=80=AFAM Ofer Oshri <ofer@nvidia.com> wrote=
:
>
> Hi,
>
> Our code uses a single io_uring per core, which is shared among all block=
 devices - meaning each block device on a core uses the same io_uring.
>
> Let=E2=80=99s say the size of the io_uring is N. Each block device submit=
s M UBLK_U_IO_FETCH_REQ requests. As a result, with the current implementat=
ion, we can only support up to P block devices, where P =3D N / M. This mea=
ns that when we attempt to support block device P+1, it will fail due to io=
_uring exhaustion.

What do you mean by "size of the io_uring", the submission queue size?
Why can't you submit all P * M UBLK_U_IO_FETCH_REQ operations in
batches of N?

Best,
Caleb
