Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBB1329C6B
	for <linux-block@vger.kernel.org>; Wed, 15 Apr 2026 10:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776248501; cv=pass; b=CxHNZGOioeKayZ2irRydGgx/nR42aNPcv5aF4kaMV+Pa+K77RgxT5AfgtitKlmKyZJYgkKtf5cWG5dzi8eh2lBKXcnlIgLETYxKU+AtpyZtrX9HtnM9ZPbFrewecsuc/fy82UsprXiNWkHolFEkF/I5uFb5AFtO46edzCKNVg3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776248501; c=relaxed/simple;
	bh=Mp45n7gf0bWphbcLLRl8cG/twkgXRBKxmEorex//enk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cHSXrNf1nGEB2vIveI41KmtpJQqySEjBRFvTeYtaS4bxQjD7dnVykL4CCQ7VkBIaBxSjCXVcbUTTyk7DGCLGXDEMdQtywnnDhvgfFqV8ywzBYQMkUb9RVuhI51Ik97sX+KfDc2cpn/MbE8hLADvd3q2IhxyYLidrHWg2ewiLL4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JHVfTE2d; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JHVfTE2d"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d04fc3bf2so3929909f8f.3
        for <linux-block@vger.kernel.org>; Wed, 15 Apr 2026 03:21:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776248498; cv=none;
        d=google.com; s=arc-20240605;
        b=jjU6h2I3iZxkvzivElIAeSkG21R4POClBcvg18hbOwZZeRsPxMwv6aRuvIkmmIRlYx
         tkcDSSwWO9fUw4my+h0VRg2adg3B+YBGzYhJwW0Pv/7D1skLHNrKVFs7t/PB71ldLJ8r
         XjgevHLeNsNUXA6jTCzJcC7H1tsCS/+D60/Fg8VyJoiGEj2JMdc5/s/y9w/9EYRiskuF
         QxVPx3zgJpthk4JnHcOYXrhJAybmhBDfSNtctbM5c6+jffeuCI4D0fEXM8QHjyjt//8L
         bI0Lgg2QAAcxSByoHmuv6QaE+hOE47zo3T5DIG5nnAZfpcZBHriYjlleaXEe8YxRLGF1
         4uqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4jJcnoVEJ7leDnc7X0jMMrtOneFaKOo08VlNndQ70BY=;
        fh=dA8YLNpAFSdbyeheEBRboJ0pSSSMKzUbApH+6QvawJA=;
        b=k0rOf5Sq31YHqG2Bk+385xJijK6BknW1SAEw2+z38zPnTFZ04Co7mlYb7V1i96l6Yd
         AgYRwdavWSkKRCUH7u+VQCGOz10x4mjBSORT2lH1qjBItef7grK1HXQZAY+nlq1sk08x
         743WIFEwrmWVpOnkWr1KgkiP1aRggm1BgVEstF7aUfaIwmv+v2Pt/plPknizK9M+Pn3p
         +gEMoy7uEHtWxl4m6yXqYPkiS3+oXjqG2FRWgRlAVaQge02xowIR/jBey7TVXc2VJ9ZE
         tURERJ5cptULkhJ7mTQNKodvzU1rPTqUDzV+DenM9ulvgqnpVNjfl1e6E0FftXedQ9HP
         IJYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776248498; x=1776853298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jJcnoVEJ7leDnc7X0jMMrtOneFaKOo08VlNndQ70BY=;
        b=JHVfTE2dXAhTkYAwprQpbt42op74y45gg7jM8KiRePoLE7Ov2U72wArhD41imnii1H
         NzTNXCFcSWbmkgW9FLaw/MKB6cy1QNrBBSi6WDHUQVoFNtv4P62iYMYuk93htmsrcd+x
         JcQy9raiOlbyY/9vGP8iovVI9E70dlG/jAHlbs7+uu+qY8gbtFgiRnaKuxW+FxrPKDhb
         O5LJ3zy9rTw+UL4IqnCKTFvuNfYfrq3zWOS+COqYkyCPNVYsJZffbvm3Y2t16+PsasEE
         657rpRFRP1azuUN1EH+d/XWA7vX3c8ijyZU1Z34xk2yRCz0Z/cX4YyNeuqT07FPiN8M6
         LLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776248498; x=1776853298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4jJcnoVEJ7leDnc7X0jMMrtOneFaKOo08VlNndQ70BY=;
        b=o6ZqRlfeRuPiAm+s+5vKR5VZRxQc2xYhsqbP+QXtDhyYTJrDm5WU+2zheFSJgYeCZT
         gUW0gnSd72AWscWE1VOq+bpjEXtGOE/v37uI8Z1Ootp4VttS76pSsYpaSmFvLwjXR37M
         GS7w9E9Bb78EaC3Rqxw6Cu0Qvu0irycZVNOhcgppH5UYpyeVqpNfH/1VbR7R7t/DLIvB
         yovNSUsQiJol0GRDM9WWR5lzsFiATuvmGFal3f7RxHU0M7mpi66vGWkov0gAkmT/HycO
         K+NRQN1+SxezeWq7/sNDb6eJSa55Ox0tKE5eiICI/15zr16FtS1dyqvucKYU3MwWP/AF
         SaIw==
X-Forwarded-Encrypted: i=1; AFNElJ/f/QmxJVW5e/1WD74WDhbpi6yY2NxvHRkm2wptSuinGNvuXXeaxT6rWS/6wibfirbnA7426AAlvbLwKg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJeyHOVrv9x2NeU/tVSmz7BVdwPyF9rK1LK3J05hAfhQ4mxTqt
	HWXnG1keBG0hG1bSIcbA0GSMvwSXM6pfpccXpWv2EuF37bbsbFAAnjmChB0wCAh0juTDS9n+r7B
	qzuDJI2lolvZD+xoofDkQ14pP78pSTYPSwLv8nnYlzA==
X-Gm-Gg: AeBDiev90gU19t1U2nTSSQ2gi8ZTTjJpwgTYkeNuP/4hlkhgpNRWlVBEXksp8vwinLT
	NapswbZrty7IcHoRfd3UpjEBEunjxM5ywHe0dDO/cWcoz3DxzydzldEPtNzn6ZMYh/YQHkqWxPj
	pj1SqSiRBfHPQDhCnZbnM2MF81wxmkmK2/rrOYGg2oT/buBhkuQW9rMeH5F8LuAPrf/DeDj/yQ1
	J7uHxlqX1Nx0ORcClmgJvr2WVXsbQ5yjsNU1fBHb066hn7kuj0kSrgNHmW60YHsX1+MvoOktbGN
	JK0f4HnYst8iVqFub8ryc0cjRcnwB9P0GZO2niMQZh2oSEgZ1BxHYQRhRcKs9oiULe11afIkxa9
	hC0hJbgUPqeUhFXo=
X-Received: by 2002:a05:6000:4203:b0:43d:9bb5:bd97 with SMTP id
 ffacd0b85a97d-43d9bb5bfa7mr10883975f8f.8.1776248497809; Wed, 15 Apr 2026
 03:21:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206182336.1397715-1-neelx@suse.com> <20260221205606.GA23260@quark>
 <CAPjX3Fet5M2C=1TDNRhrqmanvJ2=aFdtQXfXK7MuxiOkz2rNUw@mail.gmail.com>
 <CAEg-Je80=M9nS=Dmj3FiGfXTEP_fDYytAv0ouN_iu+GzRrHp+A@mail.gmail.com>
 <CAPjX3Ff0=OOWcPHWam0WEGUY-xx860NHQt=igfZ9102-Zj1nOw@mail.gmail.com> <CAEg-Je9XevtRv1VLPCQtog6+UrLL32ZWY_TzXVd8mU5Vnp+Nzg@mail.gmail.com>
In-Reply-To: <CAEg-Je9XevtRv1VLPCQtog6+UrLL32ZWY_TzXVd8mU5Vnp+Nzg@mail.gmail.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 15 Apr 2026 12:21:26 +0200
X-Gm-Features: AQROBzBSgMMSXj8EtJPvx4T66kG_rnjPScVsioJe9OwbOT5kODIuZAteSeQn6x4
Message-ID: <CAPjX3Fep5ZYLuSUY+zhewtcBqW84a+qYfLcc-20soDfMjvkecA@mail.gmail.com>
Subject: Re: [PATCH v6 00/43] btrfs: add fscrypt support
To: Neal Gompa <neal@gompa.dev>
Cc: Eric Biggers <ebiggers@kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Apr 2026 at 07:30, Neal Gompa <neal@gompa.dev> wrote:
> On Sat, Feb 28, 2026 at 2:57=E2=80=AFAM Daniel Vacek <neelx@suse.com> wro=
te:
> > On Fri, 27 Feb 2026 at 23:26, Neal Gompa <ngompa13@gmail.com> wrote:
> > > On Fri, Feb 27, 2026 at 10:55=E2=80=AFAM Daniel Vacek <neelx@suse.com=
> wrote:
> > > > On Sat, 21 Feb 2026 at 21:56, Eric Biggers <ebiggers@kernel.org> wr=
ote:
> > > > > On Fri, Feb 06, 2026 at 07:22:32PM +0100, Daniel Vacek wrote:
> > > > > > Hello,
> > > > > >
> > > > > > These are the remaining parts from former series [1] from Omar,=
 Sweet Tea
> > > > > > and Josef.  Some bits of it were split into the separate set [2=
] before.
> > > > > >
> > > > > > Notably, at this stage encryption is not supported with RAID5/6=
 setup
> > > > > > and send is also isabled for now.
> > > > >
> > > > > Where does this series apply to?  There's no base-commit or git t=
ree,
> > > > > and it doesn't apply to mainline or btrfs/for-next.
> > > >
> > > > Hi Eric,
> > > >
> > > > My apologies, I did not explicitly mention the base. I'll do it nex=
t time.
> > > > This was based on for-next @20260127 (commit 80dbfe6512d9c).
> > > > Since then, some changes occurred that will require additional
> > > > touches. No wonder it does not apply anymore.
> > > >
> > >
> > > When you make your next revision, can you also provide a tag or branc=
h
> > > that I can use to grab the patches for testing? It would be easier fo=
r
> > > me than trying to yoink them down from the emails with how many of
> > > them there are...
> >
> > Sure
> >
>
> Ping to ask about the refreshed patch set. With 7.0 out the door, it'd
> be nice to have an updated set with feedback addressed...

Hi Neal,

I wanted to post a new iteration last week but I hit some new issues
that I'm trying to address now.
The WIP is here if you want to have a peek:

https://github.com/dvacek/linux-btrfs/tree/fscrypt

Note, I'll be force-updating it later so don't take even the v7 tag
for granted at this point.

--nX

> --
> =E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=
=EF=BC=81/ Always, there's only one truth!
