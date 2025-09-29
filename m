Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7698E555
	for <linux-block@vger.kernel.org>; Mon, 29 Sep 2025 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759158137; cv=none; b=FqnscDCTL1OApshbSak3fpSGpvFZdqG2/giiKbpXjXzjAdM3suebNz85QlibwLTuEAKKzc+mds6+KgTiFduGLH9RpoMcQ946F+1WQU1g8pLOERoL5nJw+AeHwwHLvaiBE25dVNw/WQz8kdCaZJj+3pRmBAO/cZD0oSv4yy6FnBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759158137; c=relaxed/simple;
	bh=5mApbppp98IoLmLnjxv5jLlE73kH0Xbow0oj0C24KuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yjyc7jR+f+ZgZVd4w+bwai1fE7lFHCWY7NPnZMrBfsCf0yzxf3DrKADlqZuV626l2tbNU+4a9SRwo7PnygciDQvEJ6gbGwc6cHIZ79GpeE1KlajTndXaM05/IKQStWHPU3wHiQkoSufw42DqBEWG/RfZfkPqsmDBxeDDtqEURxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZxJ4zkZ3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZxJ4zkZ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759158134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qUZ+nrFNJvugmnH/mfkTXbsSGFlwrwfUzJJqGCuNdv4=;
	b=ZxJ4zkZ3KQ/1NkDsHx+ENfpWnzeN5nsOExKcWHLiBT3z7Rz/Jwe7gKxySrddz+RZih9V6f
	uYUaj2VS6XDK+c6TZppGq52bSk5hnjq/AgPirNyUTiJQwZf+2PtF18/yr7LmbmV+v+pYgg
	2NCtXIdlwKOckVa4RQMrGiEoHGeddn4=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-NJ9tJ2ZCMma8jKSN6DMz1g-1; Mon, 29 Sep 2025 11:02:13 -0400
X-MC-Unique: NJ9tJ2ZCMma8jKSN6DMz1g-1
X-Mimecast-MFC-AGG-ID: NJ9tJ2ZCMma8jKSN6DMz1g_1759158132
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5b3e57d9e37so5078171137.0
        for <linux-block@vger.kernel.org>; Mon, 29 Sep 2025 08:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759158132; x=1759762932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUZ+nrFNJvugmnH/mfkTXbsSGFlwrwfUzJJqGCuNdv4=;
        b=btViouJuVX41zIXg9NSyV/EPgvCYlmxFXtwOp4HVaNwi2t7mhrophVdLRrvezpHzNh
         VGAY4QQTD+mB1Jp6I7HqsqAiYBS+D5dp+8yPVKnucdlxPad7KrcvtllBYaDQl9Qasb17
         C1cMrKclvYXNUrKE7vXfxXNb12K5k5VapQb0UIRpswyjhij1dYyh+uN4/C7lXx+qp7Zs
         HZ4llko37Pw8Udor8cm/e5ANcVPPrTMPl+XS9THhnPu6UMNeEUzuM2XjxLqXG90rBCcz
         tfSjvyvf95txeGzwJDeHefMsSnVA9N0+yoL4NC6KBYgMiIGrKjbWAtxIjKGKTpIfqu5L
         Z5Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWdgaqRZB3LlAaKdx9w3BZ8bjKkeCY3DZTTU6m7qKh/ll3v2TjO0++zxk/Tivg4O1J5RwZNkxW9n5C8Jg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUtA82mLmjV4SCgAIBaz4FZwtPpIYGN3W3ArZUuiyKm2G2jQzc
	KhBY1ReTslpYsh6ka9pge2DwBRLfGziPzbuy4Xdzw4A7pTLMNIKl1MDllS1qwzAT/roybRM8gMS
	ppwIbuSH9DZIwoxQhPcvqfBzEW+XFQ9Xcudgx4WAip5onZOm3Eynbrj0JEQC49PxOpUNohqxAl4
	u5cA8iefJZqfC7DLIFEgnQYd+zT6l7UkZfQTwJJtc=
X-Gm-Gg: ASbGncubOXVQ1vANoTUQBR9J7e5ubxQVUHdpkxBmDlwiRjmxnhHrLti12Nfwkt7D5HF
	G89ZXwMBAoR72XdrmMMjg2S4qyw/9Jh4IqhEfV9LnZATzeLsLM8FxMFsvVQdUp5pH83ZiXCSYG3
	o+Srb+W+nFeZG4As5GosfF8Q==
X-Received: by 2002:a05:6102:2907:b0:523:d0d7:b963 with SMTP id ada2fe7eead31-5accfbb9a41mr4570254137.22.1759158128584;
        Mon, 29 Sep 2025 08:02:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5o3Fh5NHpfh14EAFku8FFD1FNX9jDym8l+iTw0lA93A8OiLv/2ttBnLrVEyNpSA/mfjaMgdkDvrTr7K9j8E0=
X-Received: by 2002:a05:6102:2907:b0:523:d0d7:b963 with SMTP id
 ada2fe7eead31-5accfbb9a41mr4569412137.22.1759158121642; Mon, 29 Sep 2025
 08:02:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926121231.32549-1-me@linux.beauty> <9f6acb84-02cb-4f76-bf37-e79b87157f1e@web.de>
 <1999588f143.5af31c76548207.2814872385181806897@linux.beauty>
In-Reply-To: <1999588f143.5af31c76548207.2814872385181806897@linux.beauty>
From: Ming Lei <ming.lei@redhat.com>
Date: Mon, 29 Sep 2025 23:01:50 +0800
X-Gm-Features: AS18NWC9hza2cJywOXBBWmRD7SoOIndJhptqTfOzlEwDEiiwkjBlTEbkxaGHAk8
Message-ID: <CAFj5m9+FGzRV+fsWtsVSHV4JFh9Pit-KFHiKRWtMKBpM9LWBhQ@mail.gmail.com>
Subject: Re: [PATCH] loop: fix backing file reference leak on validation error
To: Li Chen <me@linux.beauty>
Cc: Markus Elfring <Markus.Elfring@web.de>, Li Chen <chenl311@chinatelecom.cn>, 
	linux-block <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	LKML <linux-kernel@vger.kernel.org>, Yang Erkun <yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 8:54=E2=80=AFPM Li Chen <me@linux.beauty> wrote:
>
> Hi Markus,
>
>  ---- On Sun, 28 Sep 2025 21:48:23 +0800  Markus Elfring <Markus.Elfring@=
web.de> wrote ---
>  > =E2=80=A6
>  > > Fix this by calling fput(file) before returning the error.
>  > =E2=80=A6
>  > > +++ b/drivers/block/loop.c
>  > =E2=80=A6
>  >
>  > How do you think about to increase the application of scope-based reso=
urce management?
>  > https://elixir.bootlin.com/linux/v6.17-rc7/source/include/linux/file.h=
#L97
>
> Looks good; I will add a commit to switch to scope-based resource managem=
ent in v2.
> Thanks for your suggestion!

Please don't do it as one bug fix, the whole fix chain needs to
backport, and scope-based
fput is just added in v6.15.

However, you can do it as one cleanup after the fix is merged.

Thanks,

