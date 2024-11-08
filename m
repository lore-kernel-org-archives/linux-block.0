Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0E81BD9D1
	for <linux-block@vger.kernel.org>; Fri,  8 Nov 2024 02:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731034445; cv=none; b=lH2NB9CbUHTvMGcD7HBS4n0Qc3q1cT+zZmLuwRcwXtDjlMX9MbDh5ctGed5RzC2haCJyq7rO//ZuHbhSqAiln95sOyTzFglrUnynVAoh6bGLHhuQJeJkupD2tI+ppZJ59NFJVChZXTxuBKV8NWE8kiQqwxQPdABWmO2/HjdQMW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731034445; c=relaxed/simple;
	bh=cwEqbnHj/TJxnIy+3o2VhKgoUs8GcxvB6wBbbqhMWAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EABo0lloTFpztk1ZnMcItn32LmnQrAGaLsndGQlaoqxxRi3fNGXk+NYl/8zmunWKqrd4WMi6yQKz6CRuW4YAfpjasrmRSbnWNRzE09neTWDkgOmwKEPhAAlwzDz7ZWQMdBZs/vrwE0XeBepps+6yLFuTo2kczDxOGMHqdtgCQEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FceFVNPq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FceFVNPq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731034443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cwEqbnHj/TJxnIy+3o2VhKgoUs8GcxvB6wBbbqhMWAU=;
	b=FceFVNPq5l8l8Sdw4km5N5zUPFVPGe1D8/Z2oOrdlpoDmQ0bZiUbbNIpdymQ4+3F4i2cIA
	4HQ5dxTU0TGp1gswhsHz0yZ76phoX/VnR8EkdIlIbRWWegVWLMY7GdxudKt6dpdY33lYnd
	UdVrE+YvHccYkWWNv2OV0yY3RtgdJv8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-fBXpjrhxMxOfv2W7uIvfzw-1; Thu, 07 Nov 2024 21:54:01 -0500
X-MC-Unique: fBXpjrhxMxOfv2W7uIvfzw-1
X-Mimecast-MFC-AGG-ID: fBXpjrhxMxOfv2W7uIvfzw
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2e2d396c77fso1887789a91.2
        for <linux-block@vger.kernel.org>; Thu, 07 Nov 2024 18:54:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731034441; x=1731639241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwEqbnHj/TJxnIy+3o2VhKgoUs8GcxvB6wBbbqhMWAU=;
        b=qLld2VdHgv3RtQPUcjUznqKZBQciQutmDS8MnrkHgOsJEqQXY2+fmxPwRFiW5P5jiw
         SXAiLcXpT3PmdItr0nlPxhMFX4cH9Lo7g0Rn4HwpgCWUCjXo16KhEJG7zz0c/9FoQaWJ
         ABYo3FiTmaZ7oRf5WvUXOryTJQjo0gzFpxQCCxUAZPqe8pCDb4JymypUkmDQqQTnM2Ab
         6NnIlAQWZ+gwHqQvDDvU3iW0ap0flFVJvPZCsF0gxTDRFZ4TF2f2Itvnf9X33s7Cnitg
         66Jx0Q/gHdWoGkYH4PURlxj+wpLQcwogZ2YpJ7ECPxm2NgLMWhsKNk5H/ivf+CkwojZG
         yDkw==
X-Forwarded-Encrypted: i=1; AJvYcCUYI8LFBStFb1NWJGFh/j6N93MHAL75jgaswOf090VN7PdH4QKsSIfxFRlSA8neAqqkGMVPPuL0KCZhLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCc490adCb0zKbnwOBJtM74EnJR/P6s8oxt+lz+Ky485Ho60Lf
	iGsxGOgWHzz6LC+4+UvjxwUKRUh565kPG160Wuj2Gz5pRhVfrswdSJp6r3IAqMalnbjF8er7emc
	blPVDaXN4cGNxgC7ppt69GyFb+bqP9pxiEFNhCeg5aAt9SpUfDrx3wviGoFy95GV3bjHggO1M+o
	XxjCCRoVwNrJA/CeYDruY4DuAAXh/kHov+TXc=
X-Received: by 2002:a17:90b:3d91:b0:2e2:a029:3b4b with SMTP id 98e67ed59e1d1-2e9b177632bmr1984097a91.28.1731034440892;
        Thu, 07 Nov 2024 18:54:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeAKu6FXOO8aouj3/WFxZQgxhtW8ocCUmDNXhuRcpuePvBO35pclspRsjXFn6dE+pdWYMrEjjMCT0rnXoNyZM=
X-Received: by 2002:a17:90b:3d91:b0:2e2:a029:3b4b with SMTP id
 98e67ed59e1d1-2e9b177632bmr1984080a91.28.1731034440508; Thu, 07 Nov 2024
 18:54:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031030847.3253873-1-qiang4.zhang@linux.intel.com>
 <20241101015101.98111-1-qiang4.zhang@linux.intel.com> <CACGkMEtvrBRd8BaeUiR6bm1xVX4KUGa83s03tPWPHB2U0mYfLA@mail.gmail.com>
 <20241106042828-mutt-send-email-mst@kernel.org>
In-Reply-To: <20241106042828-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 8 Nov 2024 10:53:49 +0800
Message-ID: <CACGkMEv4eq9Ej2d2vKp0S8UdTgf4tjXJ_SAtfZmKxQ3iPxfEOg@mail.gmail.com>
Subject: Re: [PATCH v2] virtio: only reset device and restore status if needed
 in device resume
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qiang4.zhang@linux.intel.com, Paolo Bonzini <pbonzini@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jens Axboe <axboe@kernel.dk>, 
	Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gonglei <arei.gonglei@huawei.com>, 
	"David S. Miller" <davem@davemloft.net>, Viresh Kumar <viresh.kumar@linaro.org>, 
	"Chen, Jian Jun" <jian.jun.chen@intel.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, David Hildenbrand <david@redhat.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Qiang Zhang <qiang4.zhang@intel.com>, 
	virtualization@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-i2c@vger.kernel.org, netdev@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 5:29=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Fri, Nov 01, 2024 at 10:11:11AM +0800, Jason Wang wrote:
> > On Fri, Nov 1, 2024 at 9:54=E2=80=AFAM <qiang4.zhang@linux.intel.com> w=
rote:
> > >
> > > From: Qiang Zhang <qiang4.zhang@intel.com>
> > >
> > > Virtio core unconditionally reset and restore status for all virtio
> > > devices before calling restore method. This breaks some virtio driver=
s
> > > which don't need to do anything in suspend and resume because they
> > > just want to keep device state retained.
> >
> > The challenge is how can driver know device doesn't need rest.
>
> I actually don't remember why do we do reset on restore. Do you?
>

Because the driver doesn't know if the device can keep its state, so
it chooses to start from that.

Thanks

