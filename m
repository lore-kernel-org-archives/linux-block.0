Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B1735F5F7
	for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 06:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776406682; cv=pass; b=mlZg/YsxkKJHswhqo8+9jJHUNjEqOnt6X3m01Kt6fMHv1CRX7BsPv9FV/6QpSi37EnySNxGGQZ6lBjjDjD4gr6ra6Od0nXPTcP228e5JTkiz/t3RMnwwvW6FwIlhSfNf8DKzF6CV3BaYdvHN9jdJOfQx3DHMkAvmTUzKbJuRFgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776406682; c=relaxed/simple;
	bh=CftPVaHbY/sLZyg7fdjKAg/Q4VVFXC/L3LipqZPWB7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DyHadIOw1MognH4i2t5Xy4RaL3t2D5mqC1ZtgEJ37qrqPmlWacWqtCXmjVtojGp2rHRI/HIhQC9Q/HGTnKRVzWneVmXsaUii0oLJJkSbmHsnwbweJbjN0DJCK3gRrvlCVfrQLg3MqWpILqUuBSxKnLZHZPFnxSMMHMi9gF0QhVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Pj+e+9rO; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Pj+e+9rO"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48897fd88ebso3019925e9.2
        for <linux-block@vger.kernel.org>; Thu, 16 Apr 2026 23:17:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776406678; cv=none;
        d=google.com; s=arc-20240605;
        b=LE+VRUFFsz/cFvnDjIk7gzhQs1PvNBXFHuOuIfh9oClXhXJaFg00qw9VVI9Tl3vO51
         EdPZUDrtlwxmLIykgGQDvkaCxVPHjynZ67o+XM5nVS8K2GGtn7G56ERbOWIrNp3q1TNL
         A4cXhCjFG1Zqto5bafnXsryRszfhp7YfK75EIpO7585v/yiZozr7xRgnymTZbIztuSSE
         frRM4LiDvWkUwmXlnrt4Iz6xKrmLeVfwB1KSK7dirF+EfUq25l+lPJW1oVoEn4lzAKqe
         jF8FMW3hzgrvLFuIhhfNLlgKwcKeR5l5Fw3secV9OcwhG2lJWrvVZA58Wkn1/mgDoe8f
         8WJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YKMEI62h4xeSA4wc4eiWLcZ98YwqwCz1YZcyfyucBNw=;
        fh=ilsay+89iWh2mIjTEW8znywpwZSRWKV3tkKNGLboENA=;
        b=dL7wxxYcQbWUoln4rJqikfx+Tx25cC6XULzBYZ/hrGFoOtct2spIEuqMf8ddot6phr
         G9a4auoUO6n58kWPZuC8xALd//qcJU+K8zAq/We0axwC16bcM5wvi47NaAdCLpM5ERBo
         cW3lsf4eVAlfzR82IpMoYgocIA3/YxAiI3oMuixF5Gmd5STNLJycYCq1sKZpfZVe79J5
         bOJWSpJwr31dJTh6LaoJhRkhseodeANoUJ77WTDZ0evdXEVC1lKGXOsr6IEXr7gAFuyJ
         V9Cjf9pg5Cc9E5kt/3VsNh8batDsaVZzs9SmcdtN6bZACb1w7NyJ8lMOWXj5FmeXrkGN
         QZoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776406678; x=1777011478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKMEI62h4xeSA4wc4eiWLcZ98YwqwCz1YZcyfyucBNw=;
        b=Pj+e+9rOGAOsIvl6Lpgw/XMNd0V1JM9H9ggsyuz7i4FaFZnWHAsk/ET9R7IPTwyR1z
         BGgNc4AdSYXSks55nxUJl5xujTnOtC+cZLNlxVQcRg5VV3IU991UcoLd7eO68mD+9qEj
         LZlx1Tz/uWwzc6y+X2+GfwFQkgLdm94YkMxU+a9MiZg8sYY393ODlmgZMATXriSi0D3x
         cl4S3l0rzjuuBSWLFmeBmzHQ5VGXFWWePJZvlbru/0cncC8XDf2Wot0QeKwpq3FNrwGu
         1M+JTuhEpNwzgPkHBjwP9WOfPDRuBY4EXP4YVXKQqjbmATnNaH3b118STCVW63aipeXH
         wUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776406678; x=1777011478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YKMEI62h4xeSA4wc4eiWLcZ98YwqwCz1YZcyfyucBNw=;
        b=lpWB8PcwozjNMGvBkmpihq3HoHxrWgEs1bH10QhUqnjSK3iPbM4zQTFSMw1Pmu/rWC
         6CDSHJNqTLa2Dn0p1tNpnX0mT1n79E4USYB6D2pu4nHR4LrrpXNzyDYoP/AbGLeUO+vc
         3PmJDtDgoX7NNBYT5XPe6VOKsMLY1JSSPIIxXtOfGIhlTf8kc4/cZxnwWuFWRJmblGgj
         eaokiatqbDMYhdBe/xCOvloPrM0RVzIo7yyxuJatGvt4H22l7CAapM4VI5IBxG9EGRN/
         MUnr8gccJUhe8tj55DCtSaK3tlQvsz5G0JMgk86HoI4NCQfYuCi6gWVeQwIfIcZ9nvWq
         XM3g==
X-Forwarded-Encrypted: i=1; AFNElJ/1BhpZVQMzxXDY4PZhp6LJuZs05Cl5i+lb/a/TO1Tsa3B51z8uxeUUORgvYp1hCEQYTOfXqpQ7mp9EeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1hDaSF2CsaCG0hYwCOkVaDNhmFqbe0JLr8yPQWReb1hSdVRwY
	0gYv/rK9uNOerbhQHsdcn04Va2sjuJ6eJONxFmtFbriKEt7xa0Ccr9xqVbBouZB3K1LKCsOq96j
	6RqOmbjv+vHt/KH7qLw1+AbcgFklSI0ckKNBF1CVR7g==
X-Gm-Gg: AeBDievyNju+LtBwhC7xhYAW1Q0Zv/s6OuYBuNoJSiXMtQowd/3PTMYJdqCpNRQexoR
	5bu1YEvGmze9R/KkskwbXNUN0jZxtf+xE61DU4e/HaM4/bDaImnAQPhslp2Fv4Ya2obCkUJ1FHh
	yH/8nvFUx//1eTNJBEq6wZDnz8G9qZzv4DvqPRFESsusw8Cx9w8yTAtD+6YW8+NBFkCulnM0ATX
	EG3QbrXIfcBIhOI7Zz9TGOOMlrTqLI/XHIq9fzFrb1mNmFG8t5e8SAq5CenqfWnKJ8GD+UX40ri
	TJD+VYmxmMkLeCZPilYAqOHTsU10dR0T06y+Cet8BGzSJPGLc45dxzQNLIOt0sgIC2QeegSEcyF
	WLwl4F31vO7e5qPQ=
X-Received: by 2002:a05:600c:8207:b0:485:3193:6ddb with SMTP id
 5b1f17b1804b1-488fb73cf74mr20471855e9.3.1776406678000; Thu, 16 Apr 2026
 23:17:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206182336.1397715-1-neelx@suse.com> <20260221205606.GA23260@quark>
 <CAPjX3Fet5M2C=1TDNRhrqmanvJ2=aFdtQXfXK7MuxiOkz2rNUw@mail.gmail.com>
 <CAEg-Je80=M9nS=Dmj3FiGfXTEP_fDYytAv0ouN_iu+GzRrHp+A@mail.gmail.com>
 <CAPjX3Ff0=OOWcPHWam0WEGUY-xx860NHQt=igfZ9102-Zj1nOw@mail.gmail.com>
 <CAEg-Je9XevtRv1VLPCQtog6+UrLL32ZWY_TzXVd8mU5Vnp+Nzg@mail.gmail.com>
 <CAPjX3Fep5ZYLuSUY+zhewtcBqW84a+qYfLcc-20soDfMjvkecA@mail.gmail.com> <CAEg-Je8ZFJ0MWobrgNpns1-ovh37FeyuvmaR3QSarF_sg87iVg@mail.gmail.com>
In-Reply-To: <CAEg-Je8ZFJ0MWobrgNpns1-ovh37FeyuvmaR3QSarF_sg87iVg@mail.gmail.com>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 17 Apr 2026 08:17:47 +0200
X-Gm-Features: AQROBzCA29DldQaGFY1g3w9X-DRSmkbfRlRBH1HuXznzsTGLXoDZj0AOkLhu9Ak
Message-ID: <CAPjX3Ffen=QZvJLdmudBg8LsTnuTOsq1QvXF7eWJtK0Sfr8xnQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/43] btrfs: add fscrypt support
To: Neal Gompa <neal@gompa.dev>
Cc: Eric Biggers <ebiggers@kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Apr 2026 at 16:35, Neal Gompa <neal@gompa.dev> wrote:
> On Wed, Apr 15, 2026 at 6:21=E2=80=AFAM Daniel Vacek <neelx@suse.com> wro=
te:
> > On Wed, 15 Apr 2026 at 07:30, Neal Gompa <neal@gompa.dev> wrote:
> > > On Sat, Feb 28, 2026 at 2:57=E2=80=AFAM Daniel Vacek <neelx@suse.com>=
 wrote:
> > > > On Fri, 27 Feb 2026 at 23:26, Neal Gompa <ngompa13@gmail.com> wrote=
:
> > > > > On Fri, Feb 27, 2026 at 10:55=E2=80=AFAM Daniel Vacek <neelx@suse=
.com> wrote:
> > > > > > On Sat, 21 Feb 2026 at 21:56, Eric Biggers <ebiggers@kernel.org=
> wrote:
> > > > > > > On Fri, Feb 06, 2026 at 07:22:32PM +0100, Daniel Vacek wrote:
> > > > > > > > Hello,
> > > > > > > >
> > > > > > > > These are the remaining parts from former series [1] from O=
mar, Sweet Tea
> > > > > > > > and Josef.  Some bits of it were split into the separate se=
t [2] before.
> > > > > > > >
> > > > > > > > Notably, at this stage encryption is not supported with RAI=
D5/6 setup
> > > > > > > > and send is also isabled for now.
> > > > > > >
> > > > > > > Where does this series apply to?  There's no base-commit or g=
it tree,
> > > > > > > and it doesn't apply to mainline or btrfs/for-next.
> > > > > >
> > > > > > Hi Eric,
> > > > > >
> > > > > > My apologies, I did not explicitly mention the base. I'll do it=
 next time.
> > > > > > This was based on for-next @20260127 (commit 80dbfe6512d9c).
> > > > > > Since then, some changes occurred that will require additional
> > > > > > touches. No wonder it does not apply anymore.
> > > > > >
> > > > >
> > > > > When you make your next revision, can you also provide a tag or b=
ranch
> > > > > that I can use to grab the patches for testing? It would be easie=
r for
> > > > > me than trying to yoink them down from the emails with how many o=
f
> > > > > them there are...
> > > >
> > > > Sure
> > > >
> > >
> > > Ping to ask about the refreshed patch set. With 7.0 out the door, it'=
d
> > > be nice to have an updated set with feedback addressed...
> >
> > Hi Neal,
> >
> > I wanted to post a new iteration last week but I hit some new issues
> > that I'm trying to address now.
> > The WIP is here if you want to have a peek:
> >
> > https://github.com/dvacek/linux-btrfs/tree/fscrypt
> >
> > Note, I'll be force-updating it later so don't take even the v7 tag
> > for granted at this point.
> >
>
> Cool. I've got some travel and stuff going on, so I'll probably only
> get to take another crack at this in a couple of weeks. Do you think
> by then you'll have a finalized v7?

Yeah, it's on track. I expect to have it ready in 1-2 weeks (famous last wo=
rds).

--nX

> --
> =E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=
=EF=BC=81/ Always, there's only one truth!
