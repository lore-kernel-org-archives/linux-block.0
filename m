Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02146D27D
	for <linux-block@vger.kernel.org>; Sun, 21 Apr 2024 12:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713702576; cv=none; b=uiaVZ2KTrQSpJyuDlJS3y9l0SU2rkiY1LWf6PC39xunTJ25D2w6dv3KaPQthBzfsScvwfqp6/CIL5VBTBok/BDZMUGBdmAZNUcrgiDjDtrEkSVfjmwwvMxBEwuVYjasea//Ann87LW5/WiX+4QnIYs+GUptMerDaqNy5yExt8lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713702576; c=relaxed/simple;
	bh=Bam+tnZAFsQcOTabrlruYnZuKosHFKAvgTBudoE1/QY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HEd+vaBB0jsC7rrNrDTjpKHkV69jmf35/xIIcsHmsCKx64CQ0h3Eb1p1pDXnhkzszvWO9k6LUQAoMS8EWCYMnYkq38okujvapXu1L29SOHuXJT/wgNEV81MAGu3Nl7YcFYL9rA+8KAra+4G91cCJ1RNpDyCyz4cHIA2mt9NGdCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TlGn4s+K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TlGn4s+K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713702573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sy/e6b7EdMkat/b8vNzmnm5808mkzwgEft7nfqfXnys=;
	b=TlGn4s+KZtIJfQdWsYY6/KJIpHMS21urQJUBQrUnN/siC1XafZK+XEiQyjMSZsGmDVFXjM
	LtavpJPrRdbE2nhBaDnhYCZhyqbpU/I5SeWIWebhckQQJITiJGAuWetE1zeD1TVX+EHU7R
	/bkNPVv3AD1cqXG48cGDyLcDJHJiCxo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-I9qosPunOrSZZQSi2sRLgA-1; Sun, 21 Apr 2024 08:29:32 -0400
X-MC-Unique: I9qosPunOrSZZQSi2sRLgA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2a4b48d7a19so3279333a91.1
        for <linux-block@vger.kernel.org>; Sun, 21 Apr 2024 05:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713702570; x=1714307370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sy/e6b7EdMkat/b8vNzmnm5808mkzwgEft7nfqfXnys=;
        b=WfcxnTWzg0MgWlIzyehBNLK2E+zMukiM5CPUhvIqIaBCFrbyFdIif4tc7Z2ZMR5zhB
         EjhBoXDdbKEzE/zdPANPxuW+vZKMc/xc0yQEpZ8PSEgpSY7sVUUPL4eNEPcdvuMsTvCi
         EaNjARPyifn4bBsibW/Ag0I6B0TeOZWXW3lcsTDz0272hujmmkv4vtc7OOUMIK7e6/Ia
         C8Ay50l5BgY38haqcA1xh3KDA+GBkhXPEJ2coxhLR4UQGb1Qk655hrtiv+kSzhwnfjz3
         2k2qOEPWe+uSEI6OWJnElIZAlE4Y7UTV9I4b/DFbZbwQJPfvjbIX6Az4io8v7eCWodse
         Z0Bg==
X-Gm-Message-State: AOJu0Yzrc5pmByiz5lO7ZXlFanLJEjmS92c1Nr+D4zBJzp7rxWtrlEKr
	4X5WTXPk6is7+PtX9Q5O4WCsJiisrIszKFUcioYYGLwmorRUG5zUyddjxg6NpFU+9YncjFt0Oi2
	+8USdsijsAzclBVA2F0x1T6Y0reJJ13r2vwBHexVJnvS4ioM1naa/UDtEVazw+kgtSSXX5+vMSV
	9QCgMHRBhkxWYiIgJBcHXegsd2+CQOmSrOHMjyKDQ/x9Riv79h
X-Received: by 2002:a17:90a:4a06:b0:2ac:3af6:915b with SMTP id e6-20020a17090a4a0600b002ac3af6915bmr10220353pjh.1.1713702569958;
        Sun, 21 Apr 2024 05:29:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGT7eZW8lEWSiEo0FoLUFrm4oGZmz7Fw072WAlSkG/kq2pWvC0ypTtHzT6DMUZX+8SH2CZJpOcNjrJFE4dPB7M=
X-Received: by 2002:a17:90a:4a06:b0:2ac:3af6:915b with SMTP id
 e6-20020a17090a4a0600b002ac3af6915bmr10220338pjh.1.1713702569603; Sun, 21 Apr
 2024 05:29:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417104209.2898526-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20240417104209.2898526-1-shinichiro.kawasaki@wdc.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Sun, 21 Apr 2024 20:29:17 +0800
Message-ID: <CAHj4cs9W1Ad7Q8axcbDd4tsuPPz3MBxGGqCNPT6efbkgCnGMwA@mail.gmail.com>
Subject: Re: [PATCH blktests v2 0/2] fix nbd/002
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, nbd@other.debian.org, 
	Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Cannot reproduce the failure within 10000 cycles test now, thanks.

Tested-by: Yi Zhang <yi.zhang@redhat.com>




On Wed, Apr 17, 2024 at 6:42=E2=80=AFPM Shin'ichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> Recently, CKI project found blktests nbd/002 failure. The test case sets =
up the
> connection to the nbd device, then checks partition existence in the devi=
ce to
> confirm that the kernel reads the partition table in the device. Usually,=
 this
> partition read by kernel is completed before the test script checks the
> partition existence. However, the partition read often completes after th=
e
> partition existence check, then the test case fails. I think the test scr=
ipt
> checks the partition existence too early, and this should be fixed in the=
 test
> script.
>
> During this investigation, I noticed that the test case nbd/002 handles t=
he
> ioctl interface and the netlink interface opposite. The first patch fixes=
 this
> wrong interface handling. The second patch addresses the too early partit=
ion
> existence check issue.
>
> Link to v1 patch: https://lore.kernel.org/linux-block/20240319085015.3901=
051-1-shinichiro.kawasaki@wdc.com/
>
> Changes from v1:
> * Added another patch to fix ioctl/netlink interface handling mistake
> * Avoid the nbd/002 failure by repeating the partition existence check
>
> Shin'ichiro Kawasaki (2):
>   nbd/002: fix wrong -L/-nonetlink option usage
>   nbd/002: repeat partition existence check for ioctl interface
>
>  tests/nbd/002 | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
>
> --
> 2.44.0
>


--
Best Regards,
  Yi Zhang

