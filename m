Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7566E1925AD
	for <linux-block@vger.kernel.org>; Mon, 25 Nov 2024 23:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732576423; cv=none; b=tqWXm0R+TYSFNtqFN0DH5ibU5vF3aSFCJmubiFGOCWWCx1RVBLCZeRneN5jepsDYHr7bbiTJ1XCZ/gu3xuLrRg0OqCR8YSzCVXiYHquL1TBHSaypPhhDbkWO1ND73/6pTNewE5TaAxK3Uuqs1QH2uhaVEZPiKYvRixL1tR5OHG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732576423; c=relaxed/simple;
	bh=KVZsvLMcMF7B+5XJvRsy6EnNxud+pPcVbig6ZFELOP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FvYblgd2gps5C/5WQp8lSLCVNnmztTLDOqtuGEcAWIZoH3dDaCF2wcitLyLHjBI6JcdIZ1JFM5ypckqI3mhuRobrKUDxBah1PGJKTexosePLp4CU3NsNJ+4bVBiFsGGluuaHmNQBbIM+LRR0twJSlk9kUTskanlb5lSROgS2Nh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ePppu1GQ; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ePppu1GQ"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6ef0cee54daso16599517b3.3
        for <linux-block@vger.kernel.org>; Mon, 25 Nov 2024 15:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732576420; x=1733181220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1h22yel4a+AVA4skUO0bIJ443dO8U6a44Jcm2JOSrU=;
        b=ePppu1GQrtyNEEN3O/Rqt9I9B37A7SM1mzYZ4CVOy3ewo2ythDYBnSMWtVkyn/gXGw
         KXttxQElikKcKdsuTtIWeEgYYUnA5Aqaq6FmzMgO/BqRcehUGYCWpWEZPJIw30S52DvL
         lUbKmePHi1chJoXaTgdDyR7wSr8TOG0APpgHYxD+hZwQI+yCTMng1Q541/HDEf0TD5dO
         YvgNo8G3q64m0wMYZZsVj8Bu5yUXgxtyAkACiTG+mYtHvy4m+Pcl0Dryl1LuybZpK+tD
         Q41sakQ7P5DlhVMa/YMEVRxLzk0c0i7clGkt40sy2cRQqw5KEymXqkiSI4L0hjECso24
         cbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732576420; x=1733181220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V1h22yel4a+AVA4skUO0bIJ443dO8U6a44Jcm2JOSrU=;
        b=RdKLoRNlreuHQlf7XvHJnjWYKqijvhKlfoqld9+RSJ2dvjer1jY5g3UasobA7ol5r7
         ZAmrDOuKubjgMK82NqwyuJPsJ80Y89VpdQrocenjWxzTxR+3bYF6w1t1c20bZHTtt7lY
         R1XqbYZsJ/H5rRw29GJZXVGRgO01dIuQdQ70taere4z0b3R+yJgVNwpsC2HWtn8BeNYe
         fhFsFCW2l3R4WbyYddyNmClzcVSrCjRyd1II0EBqkgy5ukyR2ZoinmVWvwDJyHHpvM41
         dB29kCg4QYDplizzFdb1+n9esA0vXqgnRANkj4FUK0TsqOhGx4Swi4MP2eenjfSgg9WK
         vZQw==
X-Forwarded-Encrypted: i=1; AJvYcCXb1BFjDYcDGtSX2BPJY0oOAaPfF0rSsKinlGKDzaqEsPkvWujChKr4AiBf8A2RNZr1CiBX2kuwv5PhKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4furG2evoKb8/wQ7YQ6zjFl7b2Q8ZoJX2WkslGPhzX988SY8L
	xst0+8Agd6W8Uw9F14NXtx4K808bpM3b+btLbEzVRrUWZrKJ4/0ArNtgo+U68aakn4ZsDWR1PIm
	A5XXBb5jU0vil8O+z92zFyXXQVno7/1ljxUfiDg==
X-Gm-Gg: ASbGncvOjBLArN2i9Qsyhk3817LeVzp/L8euflvCn6CBLUC2FQ5MKUSFiLqNYw8heAL
	1aRSm6xvH1z79SzpxXwWFQLB+NLssa2U=
X-Google-Smtp-Source: AGHT+IEgwZhiK1rR9pEss4yB2/MBxGuFiIOxpC0IuHysvYmViO2ZsmddzZAz/1H8S4RvbyNtVnUa/ZDzKpS9xj676Pc=
X-Received: by 2002:a05:690c:3513:b0:6e3:a7b:49b3 with SMTP id
 00721157ae682-6eee0a63524mr158689697b3.41.1732576420404; Mon, 25 Nov 2024
 15:13:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112170050.1612998-3-hch@lst.de> <20241122050419.21973-1-semen.protsenko@linaro.org>
 <20241122120444.GA25679@lst.de> <CAPLW+4==a515TCD93Kp-8zC8iYyYdh92U=j_emnG5sT_d7z64w@mail.gmail.com>
 <da02f209-8524-4281-a9d3-1b524bd966da@acm.org>
In-Reply-To: <da02f209-8524-4281-a9d3-1b524bd966da@acm.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Mon, 25 Nov 2024 17:13:29 -0600
Message-ID: <CAPLW+4mbxfHJbxvj1CUGSbs-oN_zfnQjWvovB+KYqbyoqtgOKg@mail.gmail.com>
Subject: Re: [PATCH 2/2] block: remove the ioprio field from struct request
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, linux-block@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bart,

On Fri, Nov 22, 2024 at 4:18=E2=80=AFPM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 11/22/24 1:55 PM, Sam Protsenko wrote:
> > On Fri, Nov 22, 2024 at 6:04=E2=80=AFAM Christoph Hellwig <hch@lst.de> =
wrote:
> >>
> >> On Thu, Nov 21, 2024 at 11:04:19PM -0600, Sam Protsenko wrote:
> >>> Hi Christoph,
> >>>
> >>> This patch causes a regression on E850-96 board. Specifically, there =
are
> >>> two noticeable time lags when booting Debian rootfs:
> >>
> >> What storage driver does this board use?  Anything else interesting
> >> about the setup?
> >>
> >
> > It's an Exynos based board with eMMC, so it uses DW MMC driver, with
> > Exynos glue layer on top of it, so:
> >
> >      drivers/mmc/host/dw_mmc.c
> >      drivers/mmc/host/dw_mmc-exynos.c
> >
> > I'm using the regular ARM64 defconfig. Nothing fancy about this setup
> > neither, the device tree with eMMC definition (mmc_0) is here:
> >
> >      arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
> >
> > FWIW, I was able to narrow down the issue to dd_insert_request()
> > function. With this hack the freeze is gone:
> >
> > 8<-------------------------------------------------------------------->=
8
> > diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> > index acdc28756d9d..83d272b66e71 100644
> > --- a/block/mq-deadline.c
> > +++ b/block/mq-deadline.c
> > @@ -676,7 +676,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx
> > *hctx, struct request *rq,
> >          struct request_queue *q =3D hctx->queue;
> >          struct deadline_data *dd =3D q->elevator->elevator_data;
> >          const enum dd_data_dir data_dir =3D rq_data_dir(rq);
> > -       u16 ioprio =3D req_get_ioprio(rq);
> > +       u16 ioprio =3D 0; /* the same as old req->ioprio */
> >          u8 ioprio_class =3D IOPRIO_PRIO_CLASS(ioprio);
> >          struct dd_per_prio *per_prio;
> >          enum dd_prio prio;
> > 8<-------------------------------------------------------------------->=
8
> >
> > Does it tell you anything about where the possible issue can be?
>
> It seems like eMMC devices do not tolerate I/O prioritization. How about
> disabling I/O prioritization for eMMC setups? Is the ioprio cgroup
> controller perhaps activated by the user space software that is running
> on this setup?
>

Can you please elaborate on why eMMC devices might not play well with
prios? Do they lack some particular hardware support, like required
commands? Also, I've noticed (probably) the same issue reported
recently [1] for USB SSD drives. so it'd nice to have some references
showing it's actually the case specifically for eMMC.

Do you know if we have any config options to disable I/O
prioritization? Not sure how exactly we can do that specifically for
eMMC devices too. I'm not an expert in block layer, would appreciate
some help with this one.

For ioprio cgroup: CONFIG_BLK_CGROUP_IOPRIO option is disabled in my
case (ARM64 defconfig), so I don't think it has to do with ioprio
cgroup?

[1] https://lore.kernel.org/all/CAP-bSRbCo7=3DwfUBZ8H7c3Q-7XSG+SB=3DR4MHHNN=
GPvBoinsVSZg@mail.gmail.com/

Thanks!

> Thanks,
>
> Bart.
