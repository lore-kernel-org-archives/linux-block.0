Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC9118DB3D;
	Thu, 22 May 2025 23:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747957376; cv=none; b=fwbvEKAP9EJWlqCNVQPMx1In0PDZIxYqwDreg/I0KzX4VltjrP2rFYmTnlZzHP5k1JdRWX3WrWxlQj/y7k7iD3MYocMK3fPQk6x/JlI2tF/hCokNuCmPawmVubmSM5pHcxnStAn3WVXJG8pLvtL/sh9UazkNbIfop7SrBrR915Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747957376; c=relaxed/simple;
	bh=bOHBqddXS1gSodftBBdQ0VpvTwtlCZ545QEQJ4w2T2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fRsI+F3KhwcyJLzB4Id5rXyY5Vv33VBZqptH/voX7vdCyZbLiNvaQSry9ThgYsRJZQh/UMj4IPBzLclRBhnR5KgXPuOIJgePVldGf3Tg1sBSv9fBDJcFvfEtiGWPqYqI7u/AaqL4XjmJWR6E73bKhyx0RHwrzNYuum0LW/hEXlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ua96R7sW; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ua96R7sW"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-85e46f5c50fso739496039f.3;
        Thu, 22 May 2025 16:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747957374; x=1748562174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8IxofwsL8T9ReOdXYX7tCLo1899Q9oCBZNmKLml4xN4=;
        b=Ua96R7sWrWY0I55Pct1BtOyQiMrT6AzWMtC/EAzrMcZRbXDsM3fqgZDdmqBuQp3SxR
         St3S2XEq34huSeEeRinwkZSX3Sj3h5aCEVfWyfWvJIgBYVXmnRbAfp1xmEd7pAv0jI/I
         CJNQpfshuf1J4eY8Q5LwzfBsUJDfSzTYUx9Rx8dZEkhaYVvh3GEcn/7DFs0PIejUHJ7f
         TKBjMcysUxNbj1kHY8jvZKwt8Byv4/K4trLIHdewjLB1G+dZPPkemnzTRXIBigiNjdlc
         Dy0xuAollRrTinftTbqzLNtbiXBsTPfiWjs1u/WpLaDREVEFOZrPZHUk/CYLsXYgX+db
         9JAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747957374; x=1748562174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8IxofwsL8T9ReOdXYX7tCLo1899Q9oCBZNmKLml4xN4=;
        b=tbAiuO8Jg8DLarjTyeII3f2bvvuqIfs9KGdx/HOAXjGjE+e+sjA+jlcid6/Raa7OmI
         w/ClapvATF6bKeeoRWMmNBCcVekfHsjCztY1f8zrikPLtfuMmzjCotI6ZhH1OC31n71a
         LWjyVAq+4bjTJxvxPy8LDdzV2KNOU0V1BRjXc8dFTfgbJ1yBd2owxFN28MT+2mOyTVrX
         w9bN+SwEW/CdgTxu2Euyl81JmTVfPshd+l3zpEGpniYKgaPtT/nKzHQ5Kbaw4q3io9hU
         SAgOFVdUU0iIwxHsZ1kezedlzICuujLf5v3sVBYNPEODEN6KFwZsVJj1QAn3X0z9SjCP
         iHqg==
X-Forwarded-Encrypted: i=1; AJvYcCX6/xTSZflvhLvn0V7bzWtPEq/7zD2x+2KW+0XEITDKFGIRSWrXvg1phsV/khGWAV5wBrYTA2Ar0BtKEzaB@vger.kernel.org, AJvYcCXTcqRxH/cvePIJSKXmYoXTXQ6EM60huTM/H80GsJ3A1qDhiPMt3NkKlsJIdSAh+EipfTcHvpB712n30JyuA5MM6WF5@vger.kernel.org, AJvYcCXuVJWIwIsRzNqoUEJ3zskx0s1He7rxz3dN4uvhHjfwvE6YN1f8PGFbd4lEec+Qph+nolS0jo/lKlpR3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRam5CAzJY4r/YquTsWOejYJmixUHFrB+TES0XeHpdSjgNuQRU
	pcH+JyE0y/ObptFx8aOCK7JatpsAHhubk2zGheGDj3Pect+rhRvTHLziDEplVr2nKw03jyoed79
	lH4WmNPHCcWdUuxeBqFHVHtgw240BSjE=
X-Gm-Gg: ASbGncvXOMgvgfZk0WKUaOWXcTKU/rAr2CZgf/zZEFyUqUJ3YmKieYpO+MpmJfj2Os7
	EFOo+9b50oaT75s/5ASqYEtqSJTnVolTbp88nrWpbDsv3hoZSgp9db0IsqYaFW457uzWJrHOm/k
	Ft3H0Kzwo3ph5QdCFtWePo1VarN4kn2frD
X-Google-Smtp-Source: AGHT+IEinbq6VshxzPfx2TAWHoFrFLw2NkVMJD03BeJ5ym1VzfGxKEexCFrXM8zc0aSeCDGViEDkg3148C1WU35WcPs=
X-Received: by 2002:a05:6e02:1a4d:b0:3da:7cb7:79c with SMTP id
 e9e14a558f8ab-3dc932879bdmr9785845ab.13.1747957373671; Thu, 22 May 2025
 16:42:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250518025734.61479-1-kerneljasonxing@gmail.com>
 <CAL+tcoCD5ORW=JqvZg7=uJXkLi-WTG-Szj1k8ya9sX6LcR41jQ@mail.gmail.com> <20250522163418.f14da5eea065296d42ee3497@linux-foundation.org>
In-Reply-To: <20250522163418.f14da5eea065296d42ee3497@linux-foundation.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 23 May 2025 07:42:17 +0800
X-Gm-Features: AX0GCFsrufe-PZ6eOiw3-7s_nUfw5rP0iRMlS5z0ArMQRp0iBeyfFG6iZA-Fzvc
Message-ID: <CAL+tcoBUEpcyt3Vq8_f8Jyo3+1mLtdEH2QEf6nVAOYzRHitfNA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] relayfs: misc changes
To: Andrew Morton <akpm@linux-foundation.org>
Cc: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 7:34=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Fri, 23 May 2025 07:16:35 +0800 Jason Xing <kerneljasonxing@gmail.com>=
 wrote:
>
> > On Sun, May 18, 2025 at 10:57=E2=80=AFAM Jason Xing <kerneljasonxing@gm=
ail.com> wrote:
> > >
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > The series mostly focuses on the error counters which helps every use=
r
> > > debug their own kernel module.
> > >
> > > ---
> > > Note: this series is made on top of this cleanup[1] and unmerged comm=
it[2]
> > > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/log/=
?h=3Dmm-nonmm-unstable
> > > [2]: https://lore.kernel.org/all/20250507134225.63248-1-kerneljasonxi=
ng@gmail.com/
> > >
> > > Jason Xing (4):
> > >   relayfs: support a counter tracking if per-cpu buffers is full
> > >   relayfs: introduce getting relayfs statistics function
> > >   blktrace: use rbuf->stats.full as a drop indicator in relayfs
> > >   relayfs: support a counter tracking if data is too big to write
> > >
> > >  include/linux/relay.h   | 19 ++++++++++++++-
> > >  kernel/relay.c          | 52 +++++++++++++++++++++++++++++++++++----=
--
> > >  kernel/trace/blktrace.c | 22 ++---------------
> > >  3 files changed, 65 insertions(+), 28 deletions(-)
> >
> > Hi Andrew,
> >
> > Any comments on the series?
> >
>
> We're at -rc7 now, so I'll park this for consideration for -rc1.

Okay. IIUC, it seems probably two or three weeks later. I think I'll
keep track of the series and remind you at that time just in case you
might forget it :)

Thanks,
Jason
