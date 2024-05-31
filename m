Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5921F16B
	for <linux-block@vger.kernel.org>; Fri, 31 May 2024 02:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717122758; cv=none; b=koUKFMr4JKeM1gd1qhEj+zmesEJfmDGBM9BLU8Kvdbch48H5TbAEBbCbGEu+n88KpPgr9v43KuKzjAP3OOwyhl2IabyvtNR2oYISX+q18k1CSD9WX6B6LCFV4gAFbDpXNsTY7Mq6QrzExXPM6ndF06dcBGwafBtp0NrS+pAbuCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717122758; c=relaxed/simple;
	bh=UmdoyfNMJhPRJURF5TTfFnZlEcSdWAyzyh/Qi8kB4UA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fcAp6YbHIrhDk5KHboRu/JzEdXoRKDgk0xfx7AMtFHM0wjgaSkQ7dTorNrThXfT8vzHvd23Ysdv8Em4xe58acrlE/mgJ2XgIxuSxwwaQmAXQMZ29DCo4sqhZAOum79HjAlkmy6vVtFmmUPN8yI1DZd4vh7PE0lKKgsNw6eRw86Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hLDaJGRr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLDaJGRr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717122756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2sBt40duyrOiLzh4fUM3fI4kEVnk3flAXDF2Fw7HnCQ=;
	b=hLDaJGRrTTcl+zx530aHvAo/U1Gm22Nt/hVKPyhYEw0Dvsahhcj23bSTNGCu3Te41qPLnL
	p22MjCTulpxbuSp6smQZ7e4wIAIiwAqKMDjK/eshPgI2Z0Qqcm9w5rodFMltYF/zoy6+aI
	LO1x1BZPWCG/5dbyEz27vmdaAY28vow=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-pK5CTQmdOH-SOSX1KsRiLg-1; Thu, 30 May 2024 22:32:33 -0400
X-MC-Unique: pK5CTQmdOH-SOSX1KsRiLg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-70243d69054so922241b3a.0
        for <linux-block@vger.kernel.org>; Thu, 30 May 2024 19:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717122752; x=1717727552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2sBt40duyrOiLzh4fUM3fI4kEVnk3flAXDF2Fw7HnCQ=;
        b=K/l/AJJ1+K64rxaO7q+cs+qph7ouforfbagZTNHXUl3bpUciq8SWGqqlip3ztZRi4u
         y2bPfAWPJ9SM/uD7k+wFilNr+4OALobX6WlYmbnEANS5u26Hu2HEaEInm5nFItpl1/t6
         nN8Vgr0avoFNj358l5VMqEp1Pdk3ERsYNidHLbWxrFhZO/SxI1q2yIQml5OK8CB0mSl9
         5DISJaST/edKH8274abiK0d4RoEa9XIik6F1yHv/AgBsP7Kg6HcyycyD5/Y7RgQR9T4V
         gXfTe9ahSL4WBA9uOhcPTcjcyzmNhNzmxACKDZJHMsFInU7b9JxhiVZwcGMj7SXDxovU
         /WXQ==
X-Gm-Message-State: AOJu0YxaIfzFZcLjrbzzODcVYRGg4RLLrNyyj4AMSTTXVAZ6YJWt9sGq
	oRRIapFkkgVbB1eAeh3pZMF5zgBuZMg1H/Dv7AC71s1ya7GfFwFOW2fMMnirvhPNkWUCTpUhCFK
	iGE4r4IeCJHYuOeEYpEQRb7Cienxh+KV+9Cb55HwbwhPPqQM02+N9nYQJZ3lSuIrVq1Qc5iC32x
	YMdpsMTP2/afw5UPEkAieMcCxvHfopgj8QDm9ATZV9O3IiUQ==
X-Received: by 2002:a05:6a20:7345:b0:1af:d017:c14b with SMTP id adf61e73a8af0-1b26f205d19mr907011637.30.1717122751818;
        Thu, 30 May 2024 19:32:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeebWIfj/VwcwTuIrVn78tYF0sbMCuVze2vRzdwLmSkH7PLSRZ/AgTEgxJbY104ranzToFCNZsD2BYlCvFeOo=
X-Received: by 2002:a05:6a20:7345:b0:1af:d017:c14b with SMTP id
 adf61e73a8af0-1b26f205d19mr906991637.30.1717122751308; Thu, 30 May 2024
 19:32:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9377610cbdc3568c172cd7c5d2e9d36da8dd2cf4.1716312272.git.josef@toxicpanda.com>
 <p7qubalwunuxohkn2rfxejl2jkfpcfqp2d722xra4vmqpiofid@7niwetngzy5u>
 <zv2aiq3nmbvpnk7oiubaxuxv6b4tie26ojfm3nnpboos4sn7qp@rnm7gycicli3> <7n5i56nu4mbewyp437t467bsisuckmdefl63lmsbdj5zc2oz6u@yscit6ywgevj>
In-Reply-To: <7n5i56nu4mbewyp437t467bsisuckmdefl63lmsbdj5zc2oz6u@yscit6ywgevj>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 31 May 2024 10:32:19 +0800
Message-ID: <CAHj4cs8aBLNczLWGbrdDS2RcvfZo+=7Xfsvcb2LrhsD=HcaOTw@mail.gmail.com>
Subject: Re: [PATCH] blktests: fix how we handle waiting for nbd to connect
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 9:47=E2=80=AFAM Shinichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On May 27, 2024 / 07:49, Shinichiro Kawasaki wrote:
> > On May 22, 2024 / 07:02, Shinichiro Kawasaki wrote:
> > > On May 21, 2024 / 13:24, Josef Bacik wrote:
> > > > Because NBD has the old style configure the device directly config =
we
> > > > sometimes have spurious failures where the device wasn't quite read=
y
> > > > before the rest of the test continued.
> > > >
> > > > nbd/002 had been using _wait_for_nbd_connect, however this helper w=
aits
> > > > for the recv task to show up, which actually happens slightly befor=
e the
> > > > size is set and we're actually ready to be read from.  This means w=
e
> > > > would sometimes fail nbd/002 because the device wasn't quite right.
> > > >
> > > > Additionally nbd/001 has a similar issue where we weren't waiting f=
or
> > > > the device to be ready before going ahead with the test, which woul=
d
> > > > cause spurious failures.
> > > >
> > > > Fix this by adjusting _wait_for_nbd_connect to only exit once the s=
ize
> > > > for the device is being reported properly, meaning that it's ready =
to be
> > > > read from.
> > > >
> > > > Then add this call to nbd/001 to eliminate the random failures we w=
ould
> > > > see with this test.
> > > >
> > > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > >
> > > Josef, thank you very much. I've been seeing nbd/001 on my test syste=
m and this
> > > patch avoids it :) The change looks good to me. I will leave it for s=
everal
> > > days before applying it, in case anyone has some more comments.
> >
> > I've applied it. Thanks!
>
> To: Yi Zhang
>
> Yi, I guess this fix may avoid the nbd/002 failure that CKI reports recen=
tly
> [*]. To apply the fix, could you rebase the blktests for CKI runs?

Sure, will apply this patch and verify the failure.

>
> [*] https://datawarehouse.cki-project.org/kcidb/tests/12631448
>


--=20
Best Regards,
  Yi Zhang

