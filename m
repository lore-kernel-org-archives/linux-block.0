Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20768197A8F
	for <linux-block@vger.kernel.org>; Tue, 27 Aug 2024 08:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724745791; cv=none; b=t9QQ3m/Ncuqv0SDZQeUFixVPWGxNfDhasxr5FQc49T+9/fz3uER7UQPtpHqUwPR3OU3mpkWBYUKoI+TCt8/i/ZSC4zQcTN/915b7iJ71sTMHQCS8vEQFzBWCvGg0dCZe5N0lEhO+vQ3TnMFqdjFVnkEqRl14kQiGK5fLo9vM+ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724745791; c=relaxed/simple;
	bh=4MFCsHCbSfsLzCMTMa6Dj5HQcFVkxz2Gp/cD9XJHo4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nY5Ip1QDU02DoE92uszBXUptOonk8RkcjNt6sB47CW21mQe+DESxaeeSJtm1+bQgZ3fcdhIlCZHVu2GYBrQFLMHSJL//geBd1hUWGyAzTNDoGdBOIKtTbXsnJR3YXuOCUb0GlFkysUjyOL0v9e6Lye+uryapm3kzaQIExZ2h3JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cbrabWTo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cbrabWTo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724745789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ffMGKoiHs0yZ815x5dyOzgYe6p4XSSyZPbsnLGfo48c=;
	b=cbrabWTo+0A3P9qMOZk0Xh3b55oLuGLd2FYvgt0uzCerFdrH6/RNEFaZewFcRtyGihsCht
	YfBUUlln9b99hSZTZ4jA/rRoaSj342Kr9rJ0x3tH+JuUMnxMhjywgoe9T+kL2NlMUQWga2
	f/u0XRAvqCrO9Ie4u8OVwjLqwvIrI3U=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-ucY8MDqLMNCENiamOWTC3A-1; Tue, 27 Aug 2024 04:03:06 -0400
X-MC-Unique: ucY8MDqLMNCENiamOWTC3A-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2d6421b8bf9so4199073a91.2
        for <linux-block@vger.kernel.org>; Tue, 27 Aug 2024 01:03:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724745785; x=1725350585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffMGKoiHs0yZ815x5dyOzgYe6p4XSSyZPbsnLGfo48c=;
        b=HRKLqzK9vSqsNByaua75YMdjyyEt+hpUBP4B7HuOXoUnf6uzJFlnKrAcddSZSDC6XU
         CTA0RgkPrIWkbY0o6YMPfS75MQGWnlReaHcv7t+pHOaMevaLkj03P1QDtvfhrzDMbJHm
         OFUVIYMsRg8/O8IZvK7gtSCnVZWa1frv5Dx96ZYhrePiiQ3VHZRU6vrgSJWi12FsFrB8
         G2+fq8vuVuKm+kJdEXR+SpxQdXbBIHCrdvhmBSRjqOBQ/tFrrxnJ/fa1YAOV5UfqxMxw
         usw00NWZm3rwCUYbbWUjDf5Ltbr23Fc4e3vQipywzUCZJCbuwz6xfYGmEG8Ag1kjWSOG
         v3nw==
X-Forwarded-Encrypted: i=1; AJvYcCU9QoemiwMxzRuIgdw4DjmZD4GFuaiGV42vIMWbkKAMcsgjdO1Ap3q7dDFn8CDHry7OwOy462dAU3BwHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKOzC81IGetp3ezk+4SrTkRY+DhthpiycAkob1dq1EeU4Z2+Kc
	pLwQPilM5Y3Zww3LBCPkUI1QZkO0PRoCpOKjqcIG+inPy51ib8CCT+453bQ6brOl2r5OnF0PzQl
	psQ+Oad82FEtyFHuUWGu1N94DElkne8/cpjy3r6gqpdKSZ6zbU3B5cRd1Su+wO6m7bfwVF7vZWO
	ehddaxKSz/HE7ch/tQitCWwtJUfpbe12BRZx8=
X-Received: by 2002:a17:90a:394c:b0:2c9:e24d:bbaa with SMTP id 98e67ed59e1d1-2d8259d4663mr2250650a91.27.1724745784936;
        Tue, 27 Aug 2024 01:03:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCZ0HUn8POci1+wrCfZMzm6mS4ZeB+DcoBO5sIlJ8wwnpW4tPy+dcsyOe2ekJNdcposI/b7etWYGnF60z08I4=
X-Received: by 2002:a17:90a:394c:b0:2c9:e24d:bbaa with SMTP id
 98e67ed59e1d1-2d8259d4663mr2250612a91.27.1724745783995; Tue, 27 Aug 2024
 01:03:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827032218.34744-1-liwang@redhat.com> <8694fd51-67a2-45e2-bda4-f6816e1d612c@oracle.com>
 <CAEemH2djkWMtuTN2=Y5MXZVOACeCm32_Hh0zAJxH7X4Ss1MSuQ@mail.gmail.com> <d431a0a3-a12d-4da0-b8cb-dd349aee8d4d@oracle.com>
In-Reply-To: <d431a0a3-a12d-4da0-b8cb-dd349aee8d4d@oracle.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 27 Aug 2024 16:02:51 +0800
Message-ID: <CAEemH2d9uzDv030eYRs_hsu_PcbVTXR75YPyN4Ux2v9AVxd5Lg@mail.gmail.com>
Subject: Re: [PATCH] loop: Increase bsize variable from unsigned short to
 unsigned int
To: John Garry <john.g.garry@oracle.com>
Cc: linux-kernel@vger.kernel.org, ltp@lists.linux.it, 
	Jan Stancek <jstancek@redhat.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, linux-block@vger.kernel.org, axboe@kernel.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

John Garry <john.g.garry@oracle.com> wrote:

> On 27/08/2024 08:35, Li Wang wrote:
> > On Tue, Aug 27, 2024 at 3:20=E2=80=AFPM John Garry <john.g.garry@oracle=
.com> wrote:
> >>
> >> On 27/08/2024 04:22, Li Wang wrote:
> >>
> >> +linux-block, Jens
> >>
> >>> This change allows the loopback driver to handle larger block sizes
> >>
> >> larger than what? PAGE_SIZE?
> >
> > Yes,
>
> Please then explicitly mention that

Sure.

>
> > system should return EINVAL when the tested bsize is larger than PAGE_S=
IZE.
> > But due to the loop_reconfigure_limits() cast it to 'unsined short' tha=
t
>  > never gets an expected error when testing invalid logical block size.>
> > That's why LTP/ioctl_loop06 failed on a system with 64k (ppc64le) pages=
ize
> > (since kernel-v6.11-rc1 with patches):
> >
> >    9423c653fe6110 ("loop: Don't bother validating blocksize")
> >    fe3d508ba95bc6 ("block: Validate logical block size in blk_validate_=
limits()")
> >
> >
> >
>
> I feel that you should be adding a fixes tag, but it seems that those
> commits only expose the issue, and whatever introduced unsigned short
> usage was not right. Maybe you can just get this included for 6.11,
> where 9423c653fe6110 was introduced.

Ok, we can mention that two commits exposed the problem since v6.11-rc1.
I will send V2 including that. Thanks!

--=20
Regards,
Li Wang

