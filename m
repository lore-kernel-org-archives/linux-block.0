Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9843208
	for <linux-block@vger.kernel.org>; Thu, 17 Jul 2025 09:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752744811; cv=none; b=Qvkngq3DEGJk6/gAsJBEzDw4GO1VaRDPWLIrb01pBBg+1+GI8kbU/ESG7r02T2eIAqvtmKF9gldGJg2mvwmllLDbQk1x++P/fB1nGUjyPf+SXZLyhaAYHD80THBtpfe9r2RKwY4DOkxA5DNpYzAViMR/NokmEIyx6VEvJGjonA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752744811; c=relaxed/simple;
	bh=TJK9eAn19UQA7O4TOfKHLnfyaq0osxkXLp4lFk6ESNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N62AHbbqVgDBpOxhQRBC3ZzCBPcp5CLbPIk9twsaJx1Hx6IQQbZVsHzOtap9USOCWGdaxauE2q2OkzHjF76gd76XJkuztAOYARYohvl4IhrTTjZx6r0XF5B8S/Vpqm3q2uvObLu0PQgrFb70jfDyq1ZwG8xsYOp+Co9vPr4ty20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MPIGPu/W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPIGPu/W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752744808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aE29yVYTLWdUuiu71tNQZ4kQ0jy17jpFL0yDlkGlUrc=;
	b=MPIGPu/WPe/XvpI0f64PTGH4JXUbZLSRaijH5Pztvdd99s22wBHczd2bx8SYS2c4eXjEei
	WdDGAzRXaOHbFpcMfER87LUi1jZScXyQovhs0cIXsM+ureQ8WdXF4EyRK6rpYIuuIV4+oH
	ZJv7f/enGDEWSeEMFb4KvqwKBBTOy2k=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-1Ljx4adgMdquhd8NG_riYw-1; Thu, 17 Jul 2025 05:33:27 -0400
X-MC-Unique: 1Ljx4adgMdquhd8NG_riYw-1
X-Mimecast-MFC-AGG-ID: 1Ljx4adgMdquhd8NG_riYw_1752744806
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-553d57646d0so941575e87.1
        for <linux-block@vger.kernel.org>; Thu, 17 Jul 2025 02:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752744804; x=1753349604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aE29yVYTLWdUuiu71tNQZ4kQ0jy17jpFL0yDlkGlUrc=;
        b=pp652XvXzGvOMegJItJuuzjJ9o1Q4kPinGoJ+a6ebSyvElIsoQpIm8LcKePtsk0DCj
         k3i7e1kHQWZuct3E7S1DUW8WbAmzuPN2O7oLRiAzID4gG3XMtjq3cNY/Z6IPspnrmBTO
         bNDvB34X7xvtfgaSNJPheAsgfRV3PY6lTU20TrJ2A7tXHEipIjjiYbOLF0A+fAQdApBP
         2QWL/v8dk1HbabvP6+CPR1wwV2e57B14qBm+NIovRolsKSwE58gV1jC7xDHOrh4Yktgo
         aa/Prh3pojjg+MsbnZkOWm9fPG69Gexnq3ei8jwFh6S9WNARvi37Z8IBoOggiAUXnq5G
         /44A==
X-Forwarded-Encrypted: i=1; AJvYcCVcp+JaiNBDwYbFSnybMxtvV94ADNjCalyC0t25GNbwvMxtrRXGspmiKUCvfQY/RLzkzFYNadggoPZYbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAhgrFcJBKj6nqo4ezLBIsfpPwzO53aj8v4C3R1YA1xpfC0nI4
	B+wqXiO+2aCdZ2n5pDWL/a+79HcpIJe3ptfXLB50PgUBCxEgpTHP11K5y1YYhz6yY5H4yNlx/rI
	9DRU1TgjZrzvA/sYQOsJ6wpaQWetZalmIB88DtbUYC/fMnB/xatGu7u2EXaQxNgs+2B0wFuMe76
	kZ31r0hE8mZ3fwlXs+xCm55xCuy2A0SolsEkVxOKxKHn40l3A=
X-Gm-Gg: ASbGncsr4Tcga0hjxfbJwx+VuNogGU9CpGuhCB84Mazq9vx8HYC0LEfuiRBTucfGvNn
	EIYkPZP4OOMHCgOPXHIh4FTl/L2/a7P0e2F3O9U75FvCrgE0waZEDj78qACcnemsbJh7end9PQ1
	nAO8PCshWfwnzyfM/NQVsh+g==
X-Received: by 2002:a05:6512:b0a:b0:553:d884:7933 with SMTP id 2adb3069b0e04-55a28aa46f5mr755246e87.6.1752744804511;
        Thu, 17 Jul 2025 02:33:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7IMLladhC0LPsL3TNZzlyHwRH7GH3c+VZ+5m7u9WV++qarVBqppGA5M02rSLiZZu2NckdPrylPN+x3cfgnlA=
X-Received: by 2002:a05:6512:b0a:b0:553:d884:7933 with SMTP id
 2adb3069b0e04-55a28aa46f5mr755243e87.6.1752744804056; Thu, 17 Jul 2025
 02:33:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs9wqRvxxTVMYxPcaCQoedeRNn6CHJ_K5GsqS6YKMHeXiA@mail.gmail.com>
In-Reply-To: <CAHj4cs9wqRvxxTVMYxPcaCQoedeRNn6CHJ_K5GsqS6YKMHeXiA@mail.gmail.com>
From: Xiao Ni <xni@redhat.com>
Date: Thu, 17 Jul 2025 17:33:11 +0800
X-Gm-Features: Ac12FXxhyHtXt-pLZgZ5fAZfVSuqpxld9kFKYNusO1V_aXy8ULxaczUVtO5nm38
Message-ID: <CALTww2_+3zTsbSxr36iscO6q0iV4VYLRE-PNKZ_aCRS5TDCwBw@mail.gmail.com>
Subject: Re: [bug report] blktests md/001 failed with "buffer overflow detected"
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-raid@vger.kernel.org, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yi

Is it possible to use the latest mdadm
https://github.com/md-raid-utilities/mdadm for testing? This problem
should already be fixed.

Best Regards
Xiao



On Thu, Jul 17, 2025 at 3:21=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com> wrot=
e:
>
> Hi
> I reproduced this failure on the latest linux-block/for-next, please
> help check it and let me know if you need any infor/test, thanks.
>
> Environment:
> mdadm-4.3-7.fc43.x86_64
> linux-block/for-next: 522390782310 (HEAD -> for-next, origin/for-next)
> Merge branch 'for-6.17/io_uring' into for-next
>
> Reproducer steps
> # ./check md/001
> md/001 (Raid with bitmap on tcp nvmet with opt-io-size over bitmap
> size) [failed]
>     runtime  3.511s  ...  5.924s
>     --- tests/md/001.out 2025-07-15 06:27:41.496610277 -0400
>     +++ /root/blktests/results/nodev/md/001.out.bad 2025-07-17
> 03:10:50.718820367 -0400
>     @@ -1,3 +1,9 @@
>      Running md/001
>     ++ mdadm --quiet --create /dev/md/blktests_md --level=3D1
> --bitmap=3Dinternal --bitmap-chunk=3D1024K --assume-clean --run
> --raid-devices=3D2 /dev/nvme0n1 missing
>     +*** buffer overflow detected ***: terminated
>     +tests/md/001: line 69:  1835 Aborted                 (core
> dumped) mdadm --quiet --create /dev/md/blktests_md --level=3D1
> --bitmap=3Dinternal --bitmap-chunk=3D1024K --assume-clean --run
> --raid-devices=3D2 /dev/"${ns}" missing
>     ++ mdadm --quiet --stop /dev/md/blktests_md
>     +mdadm: error opening /dev/md/blktests_md: No such file or directory
>     ++ set +x
>     ...
>     (Run 'diff -u tests/md/001.out
> /root/blktests/results/nodev/md/001.out.bad' to see the entire diff)
>
> --
> Best Regards,
>   Yi Zhang
>
>

