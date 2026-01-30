Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BEE346AF8
	for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 16:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769789154; cv=pass; b=nBQuYDQCQqirY9lMTbWPY9Sk9xV45vjtyG5ClK1puoERQ0t7dZrzgUb/cWSZwwbOCPoib7TmQ9l7d/EVdRofec8DbXmjY3NH04iJoIrdM4+8UvG37IknECicEZWRTOmIhmlYXXH/8h/yXJkt43xHz+z67MOzFqSo9KbIQdtKpR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769789154; c=relaxed/simple;
	bh=0iGqAXYnUVnFf0gTQRuu89BeJfVib/pSawu/VGhVV4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=huOwPTAz5O2UBsw2F3K7NX9p3Vxi+T0QwFwRKhj6TTGfgVdF4z8mtHqky2ag13g1ev9RGXFlrNABZFtX8k1Nqf4ezKIYOvF6LbRXpbRDE4qeEb9hfPY83lS1KSUQrLhrWq4AizUDoqbMj3Sy8pXFSxhyPkQEOPtk1bo4IMVVBmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=haolZxMZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BWIyS05J; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="haolZxMZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWIyS05J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769789152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0iGqAXYnUVnFf0gTQRuu89BeJfVib/pSawu/VGhVV4U=;
	b=haolZxMZsvydtz2Ar5gSdUyJq0woQcZfa29v8ABcLUA05IQjmO24XFfy3yfUB82HIGMnnp
	Te7jT3Qn4EWop4U0XTzMTiuKtmkkFXn2zCpLg6ZKXOKfqzVmZ3SOmptNXIVaOdYHQSoPaQ
	TV+zzI0DPpFd//rjsSwEe/fJY80AIHw=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-HQ_If-B1N_2nPsCRLqbAOQ-1; Fri, 30 Jan 2026 11:05:48 -0500
X-MC-Unique: HQ_If-B1N_2nPsCRLqbAOQ-1
X-Mimecast-MFC-AGG-ID: HQ_If-B1N_2nPsCRLqbAOQ_1769789148
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-5ec38a3265aso6558068137.1
        for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 08:05:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769789148; cv=none;
        d=google.com; s=arc-20240605;
        b=JPmhgQr66/yImsnYlwKApIUnHpXEK+vle00C8HJMIuJc73CecmSDfkNTCNO8fv/Q8I
         vvuW7LzOtJwaEoDItzE65SktYSfyDnWUfPI4mleUPC+UHgXdaLlIpj80fVB5OnuiAPpq
         UoezNE1611RzylKXGk8UyDE9/tI/1yqs2XVniwCPYzO6D450himKzLJGKJto2vvKpKg/
         aEU0fjOo+vuxh5CjSpYuKWPeB7XKSnajapzWPIQMEFKTvPol93X5hu8/4eNTJLzaOAPX
         a0ORFsLfIN3tmmnqSD1U+Y1xVWPduVHw7kF6HwE4uTEzWFlRV9xNu81ZesjSEUWM0xrR
         iF4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0iGqAXYnUVnFf0gTQRuu89BeJfVib/pSawu/VGhVV4U=;
        fh=qB/Ij0TCJdlnQeaydyMo2ApA0RRzG0qGnlYyoe/H9Qw=;
        b=Guqra1yCruJHkySZizn2T0dVWJZqT/igW5u/hKI+s3OEQKuaUuPOz1RHh+vfPDHK8V
         w+ryhbHTE06xlg/hQS67iAD3RTDtYvohJ+42yqgVBjzSF6AV96tn8VwJMxYTvFZDw2/s
         AZAtMewjwh1HvDj5qdxkg981jZ/TV7ae6NhdRBBzQtPEiSjsQGRRovSQ5M1lo4E0nxtG
         dKrVAEdSuPlhTZqxSDApsslYSUl2PshLz4+joY6WZVtAhwrIyRVfVGSYdNKKs1B2evCN
         SKVoYlcv+p2o1shaKkkZEg2Q+pIS1hvK+Pp3W5+SFkJlpU5Kcq7qlq7VNNmk+plsbU+4
         rk+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769789148; x=1770393948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iGqAXYnUVnFf0gTQRuu89BeJfVib/pSawu/VGhVV4U=;
        b=BWIyS05JTcAljQrlpgXOwEk1ek/8Vi00LE4WPJl+2lnf3Gyc2U0NJ62cgFzA8IwZsZ
         wmml8809qlAvEhgeK9eJZVCuDsYmO8gO3TqE4RMFMo5rKczMjRplkTuMIkN+wf3Umcde
         +1KA+vdBF9QaqWGbMmKcZqcZnIoI556SsMBwbpzJ0XDUvqJyE+kRiZmKxNJppdEBmsuj
         jBK1kkZudKxMaOAdyAV9qEtB26VODRxyWjiTCJ8fUkU6rK852MrGtyLN7c/+DCLe/rTD
         h8rKrgFm2q2g0NetRwrTCL8sJfmiG3yfdHlBVb5G24CfklK1yy7oaI4egRdw49+uM4b+
         k4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769789148; x=1770393948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0iGqAXYnUVnFf0gTQRuu89BeJfVib/pSawu/VGhVV4U=;
        b=p3uQpPx7LEnjaOXAfbJKrfzmSYV4CUoJS+JobnWxHJ79f3aVbY/KYg7XTufF0Euvpl
         3VJr/BayVHU5/S9d2hxYft1ZE2XzwVb58hrrjS9aGlWU0IgoHcP90N+EIvyyBBS+ki58
         Ly23hv0LBiCFvGe4v1fTpOTa8M/+vA8d35LI8h3WJ52+XA9I/lupQs4doeM6ujakqb36
         1EGwT1k9Z2CHqjlh9Qji+/X6Y27AE2/4LT6ZE/wgoZaLCtBfvlOMUw5s7OCrr4kF7DbH
         AShI/78Teontc/c1VaP05zCewB8eQ1g0fn8PLO51nF3pu/YDau7aPNqFefVraxcF7cl3
         fk2g==
X-Forwarded-Encrypted: i=1; AJvYcCX14w81U4ls1QE2tquoUAWQ17kZE2m3W3cKVPrVlfFELv4rttpIOR0/V38Z13OZMQ6wGsXehXaUBF7Vbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwatwXpgFAQFAYLtqnK7DHbrk3xR/utEFbp4QEqkZo4h0mzLmwk
	n7uPhOQ/aWpAxESf3lXWZ9dgKqXjgZd67FkozSX51Z2SOGSOepZZBLuJ7jdz8eY+umdDLnVBYl0
	NeOLbFW7kHUnJ4z3RErjUJ6uONqTGt+cITOk1UTxmQdav0gxH0f0W89OYCE5xcp1qvnBgjKHSkU
	jqhePfA3AmMNra5gMrq+U/mpjcxTDzXkYlcmvNQr8=
X-Gm-Gg: AZuq6aKVQZzORH2pGBZNyqxwG7IocOQ+quOSxCGWT3DTo9qe7lGbhJYd/BkjP0B8k9t
	hP48O3thueUgN4DR5XbX7hCTO6/u84M655aTmjVCMQH/t3VYRKHQu2HTKlquzXoymm61Y9dpQBn
	NXnbOMVKMXdpVXlZjqVj46/z5kMHoUuKQtxUYaDj+VO78YENgYdfr8jK8is1NBXntxAPo=
X-Received: by 2002:a05:6102:1610:b0:5dd:a08e:5bac with SMTP id ada2fe7eead31-5f8cdaf1314mr2506363137.6.1769789146365;
        Fri, 30 Jan 2026 08:05:46 -0800 (PST)
X-Received: by 2002:a05:6102:1610:b0:5dd:a08e:5bac with SMTP id
 ada2fe7eead31-5f8cdaf1314mr2506307137.6.1769789144562; Fri, 30 Jan 2026
 08:05:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129224618.975401-1-csander@purestorage.com>
 <20260129224618.975401-3-csander@purestorage.com> <aXzS1iOjZAVEcZ8k@fedora>
In-Reply-To: <aXzS1iOjZAVEcZ8k@fedora>
From: Ming Lei <ming.lei@redhat.com>
Date: Sat, 31 Jan 2026 00:05:33 +0800
X-Gm-Features: AZwV_Qh0-ZZzs4VgJoZDDlOUzbCR8qeO0yE6NTSoiaYFIDtGn7u77a5L3J-SUpE
Message-ID: <CAFj5m9LskF5Gb_iCXBpc0LcJYK1tWQ4mrYntQuf866Mp4EtujA@mail.gmail.com>
Subject: Re: [PATCH 2/4] ublk: don't write to struct ublksrv_ctrl_cmd
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Govindarajulu Varadarajan <govind.varadar@gmail.com>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 11:48=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wro=
te:
>
> On Thu, Jan 29, 2026 at 03:46:15PM -0700, Caleb Sander Mateos wrote:
> > ublk_ctrl_uring_cmd_permission() writes to struct ublksrv_ctrl_cmd's
> > addr and len fields, which is racy because ublksrv_ctrl_cmd is part of
> > the io_uring_sqe, which may lie in userspace-mapped memory. Store the
> > values of addr in len in local variables instead to avoid the race.
> >
> > Fixes: 87213b0d847c ("ublk: allow non-blocking ctrl cmds in IO_URING_F_=
NONBLOCK issue")
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
>
> The simpler approach is to define local `header` variable and copy data t=
o
> it.

Given READ_ONCE() is still needed in patch 3, I'd suggest to fix by adding
local `struct ublksrv_ctrl_cmd` shadow variable in an easy & reliable way.

Thanks,

