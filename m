Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E421AB53B
	for <linux-block@vger.kernel.org>; Tue, 24 Sep 2024 15:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727193426; cv=none; b=Qn7YRiLmiMkjoibsVpxHKFOVa39E5RUq5FYXTPQFsRDd7s9/q3vtau4jHCoV/FVfMcmVsnI/hd5GouCDU5b+z4oK03/rH+iUV4AEvgl3rGB3K3eeo2VScJ8EA/ii4UslKiqHY6810Rggrl1ORKRNueUCOn+pEGRnEvY7d0SNv3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727193426; c=relaxed/simple;
	bh=HfF3xPBwgBMdFWUNMEBPlkO/CLzT2biAhM9nyeIBxAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RM42y3ztAWcDa9Bhm+wuJqz5lybEdmesupQV6RbjZlLyDCpcNr8IaEbqDTcGqmLpoOrwOh0yrMbNDJlBM0FEeRjU7z4EMAeWvB8tySiVtKEfHEDkbaj0T5qVSyC9cT+Z2wSE0JSX6tFSixEWLHXVSt/kbLPX/2AFb1hI1Mgabj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Er/ATWYF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Er/ATWYF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56819C4CED0
	for <linux-block@vger.kernel.org>; Tue, 24 Sep 2024 15:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727193426;
	bh=HfF3xPBwgBMdFWUNMEBPlkO/CLzT2biAhM9nyeIBxAs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Er/ATWYF25DQ5EMXmBBdjFjYHEloJ+8ThqmcC1CTgDus+lQITMObwmgX5uWWOTdtX
	 Lq4YfC5wOS8q2kTq7Tp3DPOgbqrEwwsErqj4mTkSewTfkqv2qp1AdAYxc49n4FTpGM
	 X+p3/ApjuYJIA2OiRFVAtWQE8/rsjZV0X2vsh8gy4w6GWsnFxZHky6LeKyJOofRKlI
	 uHL0HBNLClaS/bMoTEG7OTQIg+ReHZmMstXtWrqtq0dd79rlbS3tWL5o4CHJJkJKC8
	 q5E0YMG7cBLVLHHLIRQWIQ+yQ59a6BdexZK8Pzl3jDYYdw80Z3LXexZLzdySWxu1Vf
	 S96xvagkzkKTQ==
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a0cb892c6aso370435ab.0
        for <linux-block@vger.kernel.org>; Tue, 24 Sep 2024 08:57:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWZkoLELAcAzls7XZi2wS1BrkDt99/tyhHJMAOQo+JsaI+QdkcZr+O68BX0lxz+KIkDPLRnpFblVVO9dg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhj1fJmoRLvyOQ7mFRSpqd9/FFKiBNBPsbyTJc5Zkr0fvsHm3a
	6Au6+Z//i+4mIH0yJ9u11dkmACtW0RKZxBggOxeviJ9c8JyJl8+XOM4/QE+e9pn4DpZMBlkdn2E
	X9Fn3cTQ5493Nc0Imm2UoX5iSTWkdh25A4q7e
X-Google-Smtp-Source: AGHT+IFFOwTDXsu4A4fHpVGUiYA0bVv8HJZIgQPpTJqUoEUUT6DNdj2eWGxCsubcYJjsTuRrETuq9awjmoQukbkLzT4=
X-Received: by 2002:a05:6e02:1d8f:b0:3a0:b643:7892 with SMTP id
 e9e14a558f8ab-3a1a50878d0mr3543175ab.21.1727193425424; Tue, 24 Sep 2024
 08:57:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923164843.1117010-1-andrej.skvortzov@gmail.com>
 <20240924014241.GH38742@google.com> <d22cff1a-701d-4078-867d-d82caa943bab@linux.vnet.ibm.com>
In-Reply-To: <d22cff1a-701d-4078-867d-d82caa943bab@linux.vnet.ibm.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 24 Sep 2024 08:56:53 -0700
X-Gmail-Original-Message-ID: <CAF8kJuPEg1yKNmVvPbEYGME8HRoTXdHTANm+OKOZwX9B6uEtmw@mail.gmail.com>
Message-ID: <CAF8kJuPEg1yKNmVvPbEYGME8HRoTXdHTANm+OKOZwX9B6uEtmw@mail.gmail.com>
Subject: Re: [PATCH v3] zram: don't free statically defined names
To: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andrey Skvortsov <andrej.skvortzov@gmail.com>, Minchan Kim <minchan@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	stable@vger.kernel.org, Sachin Sant <sachinp@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I also hit this problem in my swap stress test. Sergey pointed me to
this thread.

Just want to add that the fixes works for my setup as well:

Tested-by: Chris Li <chrisl@kernel.org>

Chris


On Tue, Sep 24, 2024 at 1:16=E2=80=AFAM Venkat Rao Bagalkote
<venkat88@linux.vnet.ibm.com> wrote:
>
> Please add below tages to the patch.
>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
>
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
>
> Refer:
> https://lore.kernel.org/lkml/57130e48-dbb6-4047-a8c7-ebf5aaea93f4@linux.v=
net.ibm.com/
>
> Regards,
>
> Venkat.
>
> On 24/09/24 7:12 am, Sergey Senozhatsky wrote:
> > On (24/09/23 19:48), Andrey Skvortsov wrote:
> >> When CONFIG_ZRAM_MULTI_COMP isn't set ZRAM_SECONDARY_COMP can hold
> >> default_compressor, because it's the same offset as ZRAM_PRIMARY_COMP,
> >> so we need to make sure that we don't attempt to kfree() the
> >> statically defined compressor name.
> >>
> >> This is detected by KASAN.
> >>
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>    Call trace:
> >>     kfree+0x60/0x3a0
> >>     zram_destroy_comps+0x98/0x198 [zram]
> >>     zram_reset_device+0x22c/0x4a8 [zram]
> >>     reset_store+0x1bc/0x2d8 [zram]
> >>     dev_attr_store+0x44/0x80
> >>     sysfs_kf_write+0xfc/0x188
> >>     kernfs_fop_write_iter+0x28c/0x428
> >>     vfs_write+0x4dc/0x9b8
> >>     ksys_write+0x100/0x1f8
> >>     __arm64_sys_write+0x74/0xb8
> >>     invoke_syscall+0xd8/0x260
> >>     el0_svc_common.constprop.0+0xb4/0x240
> >>     do_el0_svc+0x48/0x68
> >>     el0_svc+0x40/0xc8
> >>     el0t_64_sync_handler+0x120/0x130
> >>     el0t_64_sync+0x190/0x198
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> >> Fixes: 684826f8271a ("zram: free secondary algorithms names")
> >> Cc: <stable@vger.kernel.org>
> > Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
>
