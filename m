Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F9819DF6A
	for <linux-block@vger.kernel.org>; Tue, 10 Dec 2024 11:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733829488; cv=none; b=GrdY523UIZOSkj1N2aeL7hp6TlPYyGY8H+X3nM1k/j3oeavmCuIlTlrtZfY+akHD7y7INs5/8O1//wkGkFNEcSNB8u22w9QyTWtBbSyOEgNoklFU5hDx9GK6PFZDNG6/pHoXsBXwfiLISMTJcQd/W34DCwBeJP1MPtM6YC5RQ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733829488; c=relaxed/simple;
	bh=xRkDnvgqhKC7pVvFgMOmw0vw6RnP7LSWwZlo4gH9JyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N9E81opiOFtI8BY6iH2togMWiPEX/8KRo1tQiyJdY/HvPYIQsCyVqFNvWf9ifEOoMqxmn4OYB0blIhlOElr7J4/TVtkvW0xP4gYJzG8kGy4ocZj67JWyV1YUgj5rLn4z/FpUJ32qusMQu9r7YsZKxKFK8wOLjVE9xfKqT5Js/sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UPGhqPdk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPGhqPdk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733829485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/O28FvqUDFtlFEhRs0ZTpEz5523mfxGFot4nFCX4rWw=;
	b=UPGhqPdkiZuKI+Rn/Wqdief+6GW9O5gaLVAsprNkCvwjEjeHFg2ikMGMNkvkJwobx4sgrj
	6wXPmTgBAfcHNobIovIXB9Kw8Z26ypevwMBRGGnqzsSdSli0drzebXAoVQyi3nnmcHBbg7
	Z9TjPA4BipFCeR78QpEmqQ73cnilin8=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-q9yQGyTDNJuQ-7jpaWbtug-1; Tue, 10 Dec 2024 06:18:03 -0500
X-MC-Unique: q9yQGyTDNJuQ-7jpaWbtug-1
X-Mimecast-MFC-AGG-ID: q9yQGyTDNJuQ-7jpaWbtug
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-4af0fdbfbcaso3803598137.0
        for <linux-block@vger.kernel.org>; Tue, 10 Dec 2024 03:18:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733829483; x=1734434283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/O28FvqUDFtlFEhRs0ZTpEz5523mfxGFot4nFCX4rWw=;
        b=L7tIp0Vj0bC4QLFXgyVRiA3Z9yYFQmjSaLWNAT14kHUIi8+GCfuioU5RVY4x1AIsvv
         4uXfHTJJnOKtWpftBLdVPiXJ2F8mad7QgpJMSs1b1lJkMHo6DwpTxiY6JMfYNXY/4tpU
         qglpw/IrM1WSSHrX4gOlveqf58J0x2BvKfl3pu9aEGcImxenG0hr5yGFSdVTLF8Iaqix
         kFaO21LQpomNUGogtfOB7MWohtp2CZyAmqQey9n9mukjhSen4go6xhbHdyWuFVHTjTbX
         /okeePZkfKcIM7YhWZKtvB9+TpflBnER41IFEqxp3fFWsMW50FOwmQy43Rtmudm7Xe4U
         egbg==
X-Forwarded-Encrypted: i=1; AJvYcCUorVuZwtiRLcoLx4MHS1oHDcqSRFKQzdrNO9JHc63+5kInKgNWCC1Viz9qhyuZM0P+GOZyPklR5cAMvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyieHBNbsCsDCVuFb78ojbmlnsNSog5sb7lh1i12nZphfPVzAeN
	D3P6f6p7K/wxSBdWBKd6eS/lvESNml4T6Y6/xcbYEgq9Hi88blo2P/17vAoYDGUjzWavsUmb5BO
	LIsBSlz5bAGIvw0gEVolR+jx2lKQ+Jbqaeb+y5M1EkVtgvYap87cnQxc/aIFiSXDWTovpB2+Lhf
	RLQ5SO4ETDDJP8ond8EbPpUBK7wOeRyZdikPs=
X-Gm-Gg: ASbGnct8nYFFTryKmZA3OKHQqkUoVvy47CJk/gI571zS5tCrAamqLtkjTg57+RHVDPi
	nTIP05M5E5i5fk9O+NKVSgzfLBMNLM1UmMlif
X-Received: by 2002:a05:6102:54a8:b0:4b1:1295:43d2 with SMTP id ada2fe7eead31-4b11973af3dmr2038427137.12.1733829483306;
        Tue, 10 Dec 2024 03:18:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHF7AJlQ4XwlrhYyc/FI8fEAkFBhMhMIGgnfhA9A/41dcNPSUDJR36T+/JNAESZorM0joIEwafHADQlO98lkag=
X-Received: by 2002:a05:6102:54a8:b0:4b1:1295:43d2 with SMTP id
 ada2fe7eead31-4b11973af3dmr2038418137.12.1733829483075; Tue, 10 Dec 2024
 03:18:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <675742b5.050a0220.2477f.0054.GAE@google.com> <20241210104439.1770-1-hdanton@sina.com>
In-Reply-To: <20241210104439.1770-1-hdanton@sina.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Tue, 10 Dec 2024 19:17:52 +0800
Message-ID: <CAFj5m9+LOn130frv+bVuzLOc8a72xnXi-u9WENJdkT0hFOH+tQ@mail.gmail.com>
Subject: Re: [syzbot] [block?] possible deadlock in blk_mq_submit_bio
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+5218c85078236fc46227@syzkaller.appspotmail.com>, 
	boqun.feng@gmail.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 6:45=E2=80=AFPM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Mon, 09 Dec 2024 11:19:17 -0800
> > syzbot has found a reproducer for the following issue on:
> >
> > HEAD commit:    fac04efc5c79 Linux 6.13-rc2
> > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/lin=
ux.git for-kernelci
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D147528f85=
80000
>
> #syz test: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-bl=
ock.git   for-6.14/block

This one looks one real deadlock risk, similar with the following one:

https://lore.kernel.org/linux-block/Z0hkFoFsW5Xv8iKw@fedora/

I will take a look when I get time.

Thanks,

