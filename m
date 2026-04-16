Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EA33D5240
	for <linux-block@vger.kernel.org>; Thu, 16 Apr 2026 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776350132; cv=none; b=cxpeeJt3VZ2TZFl/Uv1rOF1KVdOEK2lQWmhD3VMibGrKyVZQEqloIH988+6ubLYLlO6zgqpeg8v9tMdTZ2ImIL14cmAfB6uQAD7q+waFr9GhZAquou65biM+sFUwA3QybFTHo26o32DCV2ShUAitHHMKDxTGfUXBxknRJYFahOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776350132; c=relaxed/simple;
	bh=K5gvEiYv3jZzW25PsjZwADfdThiRHyl5G6a/VOIXzvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UxQOhxJ1cDlkZ0FuyDqkf/JSEZ2uxDR8UgqT0xnkh39ARwcPjCB94ufl0EO1sH67wDbCz45OF4QRDZHpc1MvRN+ZotlKbvWPDe4xlIP8tCb6dkg7WgttfTbvNTT/edxWE9vnE7ey5pPNPFjcsHgf1MzSGixUr6ha9mT6fjWz+Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6841e6a5e51so4514066eaf.3
        for <linux-block@vger.kernel.org>; Thu, 16 Apr 2026 07:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776350129; x=1776954929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AI1FEazLMBfRkY6zv90212rOaiThKdBsiK5ZQ2oBKoA=;
        b=kKbWUfMsAbEQ7K7FJlXBf07N/E57iiOwmMObrex8IdpN+xOl4yZ7rdTTjF5UvvrQ3G
         16iW0gJmq/fAS2R9xZWQMfmYqkU3SpC3BPhY2hm6M8bzjCOAUR4YwDabo5py39wClJgN
         RFamLXqWPWKc2oQS3bmaBPmrWdYQojWXdezxhzzh7hZxyLqbxwsRG4Qy7YBak0jSN9Re
         qAz0PHaJgb6giBRavLLntRALoR7s3k7YyCW2KtBZfLDcHumr/yIDrhMU54ZwSq9XQwVB
         PVnkfQHJxXKuwlFasyTmDzNx5bba4JOHb1EoIZG1YiyhRDZFtvD6XLvdtyck8FhSMuoF
         VBPA==
X-Forwarded-Encrypted: i=1; AFNElJ9ocYOrhrZg5iEwxtpSltMaV2FrPEAbMMp5uJz8kmOqguhBNi73rLElfdkC1QBhHe3CUpsd1cgEVPUZIA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4GMv2Fbto/GHBgjfuuvxygZGTE0ICPWCy340Bjtrz8Y5c6AvD
	Uq+QFTWjw9To9iVEhIsh9/nfvWD3eNjRqO5XXhcqO4in6mRltVDIirkNDfHkQg==
X-Gm-Gg: AeBDievWzaGcFWa7bgomRtpwGpzNwYvyGNJ33kuaCDBQKvUIAJqrYAeUUj/tP7FojBh
	d3YpUF619OhOD9anoCloU6GD1L29ZZyp0u5GVHL0pWofZ9IqFiaf4EQlXvjhQ+tlmrJZnxSPxgY
	+3Curz6i3GM9DxWvtUTQGlS2aU5QZ/WEIh6zyNsVoitHeyhdAlcy5AY5+NZR30z+wV2+1uca+m6
	sH2f7dEZEEjIAC4e3j9NQgtfk5yI3dHkRxPM8hvfw5aKo3aDS4M75HBsOXI37Rg9OkIbm9yOEVi
	nwW5VfDZl6mHD95Jn+S92rdIX+tv2X0JvdkBVbvrde+Qn3KpXtXfF7OPHxnyzgoQFQnCd0p/hm7
	IheMcaqkc1ODRl2IKkGRXZAELhQ8XfaSs3k6oU8rsqx33KFB5PNyWNEOfo4oASOU70oRqoAQfVu
	jrujFBP57oyLFb3n6NQmCre8sYyWKAZjmSGGZpgSMkuGDfFEsyUS+TYoAjNtUCo8pai/uyu14GX
	Qu8Wt+QPpS759mY2SPT/X/Lw22RxFFJo3TNPfmUnhZPwbVN+Jmokk5OiLMRfszZA0/768rxMA==
X-Received: by 2002:a05:6820:168b:b0:68a:24af:ac51 with SMTP id 006d021491bc7-68be8be1d25mr11931570eaf.55.1776350129218;
        Thu, 16 Apr 2026 07:35:29 -0700 (PDT)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com. [209.85.210.51])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6946022972fsm39055eaf.6.2026.04.16.07.35.27
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 07:35:27 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7dbdcb85067so6756496a34.1
        for <linux-block@vger.kernel.org>; Thu, 16 Apr 2026 07:35:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+J1Ak+bPSUvbzynbZjMLaqpKsa14LSS/rpPQq6L3fpa4CbvmB7BV7xIR6nA2mNXzap/qan75GkNDJq6g==@vger.kernel.org
X-Received: by 2002:a05:6830:3984:b0:7d7:ef0a:1ceb with SMTP id
 46e09a7af769-7dc27e2f0c5mr20103991a34.9.1776350126827; Thu, 16 Apr 2026
 07:35:26 -0700 (PDT)
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
 <CAEg-Je9XevtRv1VLPCQtog6+UrLL32ZWY_TzXVd8mU5Vnp+Nzg@mail.gmail.com> <CAPjX3Fep5ZYLuSUY+zhewtcBqW84a+qYfLcc-20soDfMjvkecA@mail.gmail.com>
In-Reply-To: <CAPjX3Fep5ZYLuSUY+zhewtcBqW84a+qYfLcc-20soDfMjvkecA@mail.gmail.com>
From: Neal Gompa <neal@gompa.dev>
Date: Thu, 16 Apr 2026 10:34:49 -0400
X-Gmail-Original-Message-ID: <CAEg-Je8ZFJ0MWobrgNpns1-ovh37FeyuvmaR3QSarF_sg87iVg@mail.gmail.com>
X-Gm-Features: AQROBzAbu52l_aX8sNV_57C_OXX36_Cyf8egj2w81DfudRRt3HPopShq5pbvZPE
Message-ID: <CAEg-Je8ZFJ0MWobrgNpns1-ovh37FeyuvmaR3QSarF_sg87iVg@mail.gmail.com>
Subject: Re: [PATCH v6 00/43] btrfs: add fscrypt support
To: Daniel Vacek <neelx@suse.com>
Cc: Eric Biggers <ebiggers@kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 6:21=E2=80=AFAM Daniel Vacek <neelx@suse.com> wrote=
:
>
> On Wed, 15 Apr 2026 at 07:30, Neal Gompa <neal@gompa.dev> wrote:
> > On Sat, Feb 28, 2026 at 2:57=E2=80=AFAM Daniel Vacek <neelx@suse.com> w=
rote:
> > > On Fri, 27 Feb 2026 at 23:26, Neal Gompa <ngompa13@gmail.com> wrote:
> > > > On Fri, Feb 27, 2026 at 10:55=E2=80=AFAM Daniel Vacek <neelx@suse.c=
om> wrote:
> > > > > On Sat, 21 Feb 2026 at 21:56, Eric Biggers <ebiggers@kernel.org> =
wrote:
> > > > > > On Fri, Feb 06, 2026 at 07:22:32PM +0100, Daniel Vacek wrote:
> > > > > > > Hello,
> > > > > > >
> > > > > > > These are the remaining parts from former series [1] from Oma=
r, Sweet Tea
> > > > > > > and Josef.  Some bits of it were split into the separate set =
[2] before.
> > > > > > >
> > > > > > > Notably, at this stage encryption is not supported with RAID5=
/6 setup
> > > > > > > and send is also isabled for now.
> > > > > >
> > > > > > Where does this series apply to?  There's no base-commit or git=
 tree,
> > > > > > and it doesn't apply to mainline or btrfs/for-next.
> > > > >
> > > > > Hi Eric,
> > > > >
> > > > > My apologies, I did not explicitly mention the base. I'll do it n=
ext time.
> > > > > This was based on for-next @20260127 (commit 80dbfe6512d9c).
> > > > > Since then, some changes occurred that will require additional
> > > > > touches. No wonder it does not apply anymore.
> > > > >
> > > >
> > > > When you make your next revision, can you also provide a tag or bra=
nch
> > > > that I can use to grab the patches for testing? It would be easier =
for
> > > > me than trying to yoink them down from the emails with how many of
> > > > them there are...
> > >
> > > Sure
> > >
> >
> > Ping to ask about the refreshed patch set. With 7.0 out the door, it'd
> > be nice to have an updated set with feedback addressed...
>
> Hi Neal,
>
> I wanted to post a new iteration last week but I hit some new issues
> that I'm trying to address now.
> The WIP is here if you want to have a peek:
>
> https://github.com/dvacek/linux-btrfs/tree/fscrypt
>
> Note, I'll be force-updating it later so don't take even the v7 tag
> for granted at this point.
>

Cool. I've got some travel and stuff going on, so I'll probably only
get to take another crack at this in a couple of weeks. Do you think
by then you'll have a finalized v7?


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
