Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A7C1D63D5
	for <linux-block@vger.kernel.org>; Thu, 21 Nov 2024 12:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732193851; cv=none; b=RKjN0Uw2sSovoOmoQoAhokIpg1UhNSsYXTcHZ1XNfdiwJ0p7U5yyWqCctpdCFhhp0v3QdkqyyXYLutU6NeDEdLLWDJB5F43whhnRyBTq1HAgS3DcrDYtV246Ywg8prWGGSc0d/MkqecXqioKlYu3BuMMs/K9F0KsxjmkdosKWk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732193851; c=relaxed/simple;
	bh=ylHjuWNakRh8E+gJ7tY996zVeJrfRe0jQp/b4UYkFo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qMpzz5eHd3NYaklmxafLsxbMbfiYh6Knjd51avVmRfDww26V4nqsVfrNZYxDYQ3bFiuc071vvR9t7LJS1v0eSsgfLRn4cw8p1Y7n/8BcSWWhO+BP0AcMKFe9HBWx1xBDfO7t18WEOG+wdDMD2OvsKCcvUq2zEFYr1sNlPapjGvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bezRPmB4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bezRPmB4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732193848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=myEWuJ/F+H+RLQuXWJV2gYCnDed5CZVEDrBKC4pp6mM=;
	b=bezRPmB48EqMTUTHMA94IggaFkG2VMSJgIXBECIUxnC94zxX28CqIKodVNVvUZGM/BcjBh
	CuBu/ltLr52wpj/SZdzTmBkyYTevXaywv5rs6T7WLU5RSCq7eY3r9IhQe8kpSZBnKe/rk9
	JAjGGLsKQGLujcA8004bW3w8zYLHm5g=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-YHxJittnOrKdEEjDec3Uhg-1; Thu, 21 Nov 2024 07:57:27 -0500
X-MC-Unique: YHxJittnOrKdEEjDec3Uhg-1
X-Mimecast-MFC-AGG-ID: YHxJittnOrKdEEjDec3Uhg
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d41a81a98fso15676776d6.0
        for <linux-block@vger.kernel.org>; Thu, 21 Nov 2024 04:57:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732193846; x=1732798646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=myEWuJ/F+H+RLQuXWJV2gYCnDed5CZVEDrBKC4pp6mM=;
        b=JBSFTaWM0/982X2/MLzZFoRGVZHAVPD/eIk1nr4hS36869M2I966dzdxq9h4tJnf0U
         evx7113RxmAM4rHsL/GCnDfXXarGZznZe1yPi0WlErZVJnOjUkidp9OA7QsJvKCl9QQU
         C7W+6L6GVNJuS2oWT62G3qgLp4YA98vhly6qXAUqID2B6vMTPHXsTFcl+2KdX8gL/g2n
         mOWrYNv758DavpvD4MhuujZ6dSCcgxMIK8CzaMOi/rC8DmHG2Q+GY6Cr9Z30LekYbMnz
         PERQOfpHJjkbkk2HBO+DPX7vFqtcKhA4LxdCQDpcls/ioyWiqQjvS4SlJoVN+eqiA8WL
         ++Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWBYK/cfiAFMfGxGPCi5X0Fpie7lTRRK10AlzmZJHsVYm6DaUfNRKDnhWvSLS7fQ40U4G1jjtMp9lZxFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaXeXPv50cepfKM5Z2A/SEvD1L9ar8hdEoJbYHtzPDKQLfeGEc
	mRHQrbMGJzIj73lnhbsEhEuxLnekWSzCF5Fnx7dqa5z8ZmXwemwAVrYgt19GJnKGf8w8wyx2Xfz
	SqEzoY2IOb1yz8nWXZaxBY8Sh1duZpXIjFu66SehSw0v0yt1m0RyrN+U9ZxQ7lVRdFoCoCiGYwt
	SZ4utHSDY6f12b+0qSAcRBODgbxxXPVKhQEBE=
X-Gm-Gg: ASbGncuCrj3iWPFTOQNbyWQkwtHNKOouUqG9CmJE11X2rAzoNnYvzi2MAxk6yWOGB/6
	icPeT+ae1BfUdc2zN/lJP+hWktS8FZ+M=
X-Received: by 2002:ad4:576b:0:b0:6d4:2211:839 with SMTP id 6a1803df08f44-6d44248a9e4mr55317556d6.23.1732193846673;
        Thu, 21 Nov 2024 04:57:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExxcMFW7Hm6XfsjiH7G0a0FrNfrTzVmvbh3UlhfyiBa68R/OSjJ1WX7q/zGfYyG2TyKo3CdJmpF1SgaR2zc8w=
X-Received: by 2002:ad4:576b:0:b0:6d4:2211:839 with SMTP id
 6a1803df08f44-6d44248a9e4mr55317436d6.23.1732193846463; Thu, 21 Nov 2024
 04:57:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs8OVyxmn4XTvA=y4uQ3qWpdw-x3M3FSUYr-KpE-nhaFEA@mail.gmail.com>
 <7f35cbe9-9e12-498b-b46a-be1f570772fc@linux.ibm.com> <CAHj4cs91daKS2Sexvs3y_m=r=+a+gJdk9=Z+76TdsE6=0nNcYg@mail.gmail.com>
 <9ea5ac64-283c-40e6-a70d-285b81c55c06@linux.ibm.com>
In-Reply-To: <9ea5ac64-283c-40e6-a70d-285b81c55c06@linux.ibm.com>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Thu, 21 Nov 2024 13:57:14 +0100
Message-ID: <CAFL455kkKZ=E=7XB34NjjH8SC3QuHnwityJABRxFNf=vJNMoLg@mail.gmail.com>
Subject: Re: [bug report][regression] blktests nvme/029 failed on latest linux-block/for-next
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Yi Zhang <yi.zhang@redhat.com>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, linux-block <linux-block@vger.kernel.org>, 
	Keith Busch <kbusch@kernel.org>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 21. 11. 2024 v 12:11 odes=C3=ADlatel Nilay Shroff <nilay@linux.ibm.=
com> napsal:
>
>
> +       zero_buf =3D __va(page_to_pfn(ZERO_PAGE(0)) << PAGE_SHIFT);

Question, isn't this equivalent to page_to_virt(ZERO_PAGE(0)) ?

Maurizio

