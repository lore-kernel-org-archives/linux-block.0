Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914BABE66
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 03:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708658994; cv=none; b=qH7C1kt2sZXxeEk1426pUrl13a5jNTODnAH6MCERsPnOwY/SkRXrkNqoRz1czqaDQWcmvy9Lzv39Ygx9Gk0zC66rgG+qLKoxkp1lCHp/HZyMqFd6klksx4vqkYar3hQj/mEwMh/19+sUPf1QU0UMvJFQO+CBdxadOToOzXJ302A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708658994; c=relaxed/simple;
	bh=eyCvpH46gDlTVfcQVm2lpTL/PC0lTWSfRNbdJZ+i3F8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JcRCLhjEBmFxCdw/E5D/3T4Kvmj0/Xvbd0jpv1aoRNxIWUxi083Axs8MD25z4jnJOrSHGsHkbnWsXTlAd24ZuadSbqgAyMBpCOowA0yXXrqXGA6GDhoe71QsiHvik88Z8UpWC8MuLr8mcy7R8RvdDQtuKp63ea9lExJ3uYw3PdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gb4yIEN5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gb4yIEN5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708658991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eyCvpH46gDlTVfcQVm2lpTL/PC0lTWSfRNbdJZ+i3F8=;
	b=Gb4yIEN5nNB2dpmpQXMpfqEpCqdcd/8IFEJ910/uX7qmNpzCRiMthB1Qar9HT7omNTX/XN
	vi8CSYBPXDIG/NeMlYS99UmqRjCKATjbr3iNOvHwH5SXvSh5rgSEnoUCtGyf4/i8sRoCHN
	a0PiaqrSu3RjA+3SiMZBunTGjXrARe0=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-ieq6YlgYNKuLonylxXF8cQ-1; Thu, 22 Feb 2024 22:29:49 -0500
X-MC-Unique: ieq6YlgYNKuLonylxXF8cQ-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-47066db30d6so2350137.1
        for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 19:29:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708658989; x=1709263789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyCvpH46gDlTVfcQVm2lpTL/PC0lTWSfRNbdJZ+i3F8=;
        b=CJpxjiY17uAT5CEsoiCK8NGQskO4gRTiWuiac/CwMbcT0tD22h4qndiLljUBX2j5di
         4iZF/tgM9pIMK1HR9luYRI3EMFsCwcFTap8jV/FCFq5AEYNokkmTSnvo0KKMsL5h3/HH
         6BIbg+Xz+eLRZacNNgYwyOBS9bGhXGDYUG3/n/LsdB0bUTpABh9a/SK6A7LlHUzRHuhQ
         dwU6bx+W+9pQYd4iXfBDqn+E8iszYk5e81oiyypD/n6+oomlLNScoX4kFg0u7bwAo2kJ
         LAq6xJkAbLZ5R7vv04MGhV9ygWStwETJuYK1geaSi7Ob6mQnbM2cTklSgBId9qRTr9ox
         SBnw==
X-Gm-Message-State: AOJu0Yz6bbkz6hSwpKOzkMkYec6ETNLmPaMaD//ebyqN8dtpGwbTb336
	27yNoUrUKJyoxolioCoIDLURpxu1jSdbSv+0uxGWhxnEqz9iHNpkp0g0bTPmtlLLu3wLRDM9hC4
	h0sRw6s73bvB0WRlRtu4bzircvHRsgCMwDoI3eqlzugvFKp3i9JJ5H32VXoQDGNcageOUJOG7Rl
	KOGuyqlg5lrPwBJ2Wj1EQoLk1Cwp838sdvtMg=
X-Received: by 2002:a05:6102:2366:b0:470:5648:6f39 with SMTP id o6-20020a056102236600b0047056486f39mr717761vsa.2.1708658989169;
        Thu, 22 Feb 2024 19:29:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmhkAtIKKZnvjgYIbDIM7ZBAnYEwwjvMguMPLADOMxp/sHA/pm0p7XBtNn6wvHUiWLXyYF40noAEPNRSvGFDM=
X-Received: by 2002:a05:6102:2366:b0:470:5648:6f39 with SMTP id
 o6-20020a056102236600b0047056486f39mr717756vsa.2.1708658988916; Thu, 22 Feb
 2024 19:29:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222191922.2130580-1-kbusch@meta.com> <20240222191922.2130580-3-kbusch@meta.com>
In-Reply-To: <20240222191922.2130580-3-kbusch@meta.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Fri, 23 Feb 2024 11:29:38 +0800
Message-ID: <CAFj5m9Kmu_z6qORsri=DidxEnbgaLkP4g4Y418wK3D40oVSYjA@mail.gmail.com>
Subject: Re: [PATCHv3 2/4] block: __blkdev_issue_write_zeroes cleanup
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.org, nilay@linux.ibm.com, 
	chaitanyak@nvidia.com, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 3:20=E2=80=AFAM Keith Busch <kbusch@meta.com> wrote=
:
>
> From: Keith Busch <kbusch@kernel.org>
>
> Use min to calculate the next number of sectors like everyone else.
>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

On Fri, Feb 23, 2024 at 3:21=E2=80=AFAM Keith Busch <kbusch@meta.com> wrote=
:
>
> From: Keith Busch <kbusch@kernel.org>
>
> Use consistent coding style in this file. All the other loops for the
> same purpose use "while (nr_sects)", so they win.
>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

