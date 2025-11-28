Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575C2168BD
	for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 06:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764311243; cv=none; b=lKGYyEe0WVN19whHo9YBuyAdx0dNPSN0kjdyO4f73d94cMnGYu9AaQQJSe95fCKtdSF7S3vgZ2W8ILdueAAX5YKOVLH7Dh4/1bGSOqV1icts18CNz7YR4gtZnrx0AFxTXKVgVGcSs8YtcGb5raHUnc7p7gKN38awxtWS+hypTjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764311243; c=relaxed/simple;
	bh=uxXx2Dt9ovr7xEDXTx3MLSG145z2GZi2DJ1y87yMKcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4pscwVoe6gtsGl5C98lN3nwrzdXBcaa9F5+dhdinppwcnJBgmcRKHykE0pQUviIjsBYQLVmASe8UlqkyJJK1N5wnI8igy4AkvLnycwctrcusC9neaxDBEFHkJfIauSd47/dD6arpVTcwbI/0Dy6RTR5yd9BbeFImH2J9l0LglY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqktlKtM; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqktlKtM"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4eda6a8cc12so14436681cf.0
        for <linux-block@vger.kernel.org>; Thu, 27 Nov 2025 22:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764311240; x=1764916040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNBX+tdFCi976CT3NTPOtFudKzRzrB7upXknWDTBPfs=;
        b=CqktlKtMSvE5zV2ceALEbGv09s3lETxK9XNUOFgNInCKfzq2OsZjQe8yvn04Ne5TLT
         0318phA8KNpGb205+xtT7wB3JlPdf22NPutwA4lIwsdwLOt3UR6BdxC2GrZ8qP2tUfN5
         Y7evJCkbsp+8MnyNg1rSIc6AUeKpkc4GnT2XAu5sPOBSl0TVjhrHM+tFCCHTEKKXzypn
         h/Ql/Eq71VNre09PDoSW6vGc9F13C38NwBtdgL+Vfeu9/ijLMVk4gvY9ANe/V1C64Zmy
         YcrtayvbYVZE3wOBBo5JZ7vmFfUzUTwYeMc6AsZv9IVbAhSkZHJesp5GJPvwSiCm+na5
         aWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764311240; x=1764916040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rNBX+tdFCi976CT3NTPOtFudKzRzrB7upXknWDTBPfs=;
        b=tDeBvt/Uo9E3cxJuotHFe94umyJEPG/gv5+AwGmypagN40YKid5betMedak7/GhB80
         JuPi9rQ6e3835pG2ga4UIvLxWPyK7p2FPOQJO19miIXYq3MBJjyKafqHhO4XiYtnFKcu
         0eYYlfWfXlKgS6TE1W89CoATNNpFY0GRF5E1m71ePOUo/CHoRDRnL9gpHotUkYVBVlX4
         DdulzxIwlTrTWutz62345qXM+6F0ZVTU2AvOtdnno97mp9/nqs4wS5wJThBH/ybxO9SJ
         1YoRcfz8BkrhnTJPvSdjaQ2buqGd+ehEVYuTAFzlD1RpP+0N/97t7qe3vEhD5OGCO9tQ
         9k8w==
X-Forwarded-Encrypted: i=1; AJvYcCU1xwwJFc4FKEwuKfOQCLIVgXM8nWT94QASxJ8FE75pj0XlevE8QW10FrgwaxD+q51gGB8pdhQKytU0+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgqmbD5wRbGUIelIjxfb4H/kE8c1EIT/qe0prxuv5xUspBVSnY
	bNWrTD2rJ4ReEMs/EGxFMR4/k0y7cja4KetZmZ2x9m7sypeKk3lzPCU7Puvp0eyUvyFPOnPBIrh
	ScLVzhGG6IXdN609W2/C8Qx2FGvwAclU=
X-Gm-Gg: ASbGncsVIHbEBLl+abdo4U+QTCqW0OQ+Nry3gHwpNe65EKK0LDtMG/loipmZ3L2Ixm0
	8u+qOz514S+zau0iVQICZek3kOzfEQurAb+iMLLNbGo9JWfDQchitOfOu3wwqkQKoZm8lcfnXdI
	V6mQLlSyq2WG7tQW6vv1KPDxp46kKw0FWnks57FtILAbis3MOCRYdVK3rhwkTBj5OBT6e6AzqZf
	GzK8y7XVjt3ig6xSxoMD0sRIERcHWN82q5gB7dT/oi9tDUdz4vnaKN0tJyfe8WjGINvqsQ=
X-Google-Smtp-Source: AGHT+IHqoxxME/wZYacFTCZmpyvjYqen8b7+sN/d+VbUoZE5rC4JPn9P+8N4Y6c+biawDbsHSmqE9yp/CsWDMeNGoss=
X-Received: by 2002:a05:622a:3d4:b0:4ed:43ae:85f6 with SMTP id
 d75a77b69052e-4ee58911262mr343758661cf.47.1764311240290; Thu, 27 Nov 2025
 22:27:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <20251121081748.1443507-2-zhangshida@kylinos.cn> <aSA_dTktkC85K39o@infradead.org>
 <CAHc6FU7NpnmbOGZB8Z7VwOBoZLm8jZkcAk_2yPANy9=DYS67-A@mail.gmail.com>
 <CANubcdXzxPuh9wweeW0yjprsQRZuBWmJwnEBcihqtvk6n7b=bQ@mail.gmail.com> <aSk5QFHzCwz97Xqw@infradead.org>
In-Reply-To: <aSk5QFHzCwz97Xqw@infradead.org>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Fri, 28 Nov 2025 14:26:44 +0800
X-Gm-Features: AWmQ_blfmVuM70WOWxBT6SLO-nBFz1VQq0RiOHlp-O6KawgJbGDwoH1nduOeubA
Message-ID: <CANubcdVTwitvE8ZP2BRtW28u8ZYBvdobxxXQgDSRWP_FbS1Wmg@mail.gmail.com>
Subject: Re: [PATCH 1/9] block: fix data loss and stale date exposure problems
 during append write
To: Christoph Hellwig <hch@infradead.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christoph Hellwig <hch@infradead.org> =E4=BA=8E2025=E5=B9=B411=E6=9C=8828=
=E6=97=A5=E5=91=A8=E4=BA=94 13:55=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Nov 28, 2025 at 11:22:49AM +0800, Stephen Zhang wrote:
> > Therefore, we could potentially change it to::
> >
> >         if (bio->bi_status && !READ_ONCE(parent->bi_status))
> >                 parent->bi_status =3D bio->bi_status;
> >
> > But as you mentioned, the check might not be critical here. So ultimate=
ly,
> > we can simplify it to:
> >
> >         if (bio->bi_status)
> >                 parent->bi_status =3D bio->bi_status;
>
> It might make sense to just use cmpxchg.  See btrfs_bio_end_io as an
> example (although it is operating on the btrfs_bio structure)
>

Thanks for the suggestion! I learned something new today.

Thanks,
Shida
