Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A280B367F54
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 12:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779884208; cv=pass; b=R4RivgY+a9qegdfazLs2tlmCi035o4INm710nfszwrRD8s4Ot0aKKk3yEAbEKJGh9ChdczBeDGrsa6CdfGhW/qxNrnYBw8+sMu8ImAC9aVuNBSzf5hgnAH4PetCfyEgHeFp/RaTW6+lY7jPu7K1U9/mgQAahLGGJkbt9NB1UpQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779884208; c=relaxed/simple;
	bh=oa1N9Mj7lJow8m1uUuiAPdaGwTIPxd7avWKawT63a6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lb5M9v6RjSTYDM7AKMOHXINreR7o71uZMFG6DQwdY21TmnIzhO5v0TfA5+7OFW6anlTS830lddC+TBh1jaPACB2fjPr2Ujq2WyhSUIWktB+Lu3eyYv+GajuHnVh+i3wwOkAxKWu+GVuTJNC6Dvo3CYowBgt6Gk+Df5Ls4yWdUQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=VDVL2OO3; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="VDVL2OO3"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-39397d63804so65682661fa.2
        for <linux-block@vger.kernel.org>; Wed, 27 May 2026 05:16:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779884204; cv=none;
        d=google.com; s=arc-20240605;
        b=B1vwaFzgOn7NrnGBmMQgGW4AKxWCflSuxVjB3T7Hn8K1yCvwX8Uua6rsxa69Pc4pRk
         m8j8aU3mH3IdYMo1atOf2ZnSuAd/af8RR/pWcjTooImV4636qMsJ+r5UeJsZ59hFBbUx
         o/aOb+Ik1/+EVQndgTkALcM2K9AHagv0EVaCG+zpBbOGMiAikpK/gNjiuVLUEBJiS62d
         B9lIf2VIt4uIPKm1LjERtOyA4sicfr2xA3MYcvop0dBMeT2IguD2eph8T9LI6tfxaew2
         Y3c6l7rUkpamvvKPQp+/IsET8QB1gH/rpHPBcXYs8DRmYmtT8Axbnc7uWbn3XMsUaFKM
         ZBjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oa1N9Mj7lJow8m1uUuiAPdaGwTIPxd7avWKawT63a6E=;
        fh=FZhhE8HxmIuigaicok4NDtL5t0lOVpoFTq76S3Sk7E4=;
        b=KeNV5UI5sayDjtkEDzwZDXIaJV9ZqSDuxiZ2VDOTLdfEx3uDa9NOf8+Etk0I1OYOZi
         plpQqFf2pNHsBSMynQWvcAMgkwbUcEI4S/VZjhZoDsZrEU60+nnBCFWJ44Y5KR9trIRC
         kqUzMOOUxfBZR567Vv5diJiVeT02dAMkXMqztnVUTovelWitFBzj/HE0Ga0bdleUmCMh
         sYk3JaL6olU9CMyL1O75tlz2Q0jlSDOZS+RXfVTVI1EUqyviMfvimpy3yCMUDGFzf4l/
         rV9a3G0U5zoRTaQ9tYv+zdlS/FQ+A8S/NtztPhsWsJaS/5TuHeXu8vs8jNaEzfUQ+Sgx
         bkxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1779884204; x=1780489004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oa1N9Mj7lJow8m1uUuiAPdaGwTIPxd7avWKawT63a6E=;
        b=VDVL2OO3ZIqDa4S+ahvQcBWBWttdurLcOdtzswxJ8MysLK/Jp3ElVszyVSRfQeH3EM
         WaoYOmUlf+SGDhCSZvRWnS3SI9bYq3gdHiFGQeo4GP2w1g8PfWTjej9lAHgh2TK2WCsx
         4I4ef7pmFUGP0TEB609vcz6DeCzoxof+AsUWpYoKO71qMc/9U4CkJQzFYAoFrwo2tfQv
         ZdI4QLvWMolXIhWvt2X3HyLg/p9GwxX4sTh3S89vTF0p5aczKb1l7ai9gJjECJhv4q01
         7egGAIR81O6OsbdzvTwsZ26ECuxfwYi1yJXiqOXh5UNl+ygSI3IB+FJnm3uoOFA8dd6D
         OJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779884204; x=1780489004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oa1N9Mj7lJow8m1uUuiAPdaGwTIPxd7avWKawT63a6E=;
        b=UYVyemlux5ky946w8Aj9JeVHGYidyXnrgxFf7X0IU6MUa8M1+1kwhHQREYe8xfljCX
         0NkOw2K17SKb5IsmD9bYGQo39SIpzovLI6TTbNKcRzTsGCXEX0FCPL1ccOqFM5QyG697
         ucw1NarmFTuSp34NiR38IATpp4IDRNNuGwNLqrJpxiVEnWleCNC6UXiBMqJW9YUyWIHS
         soE8wKBJVf8RSNYsr1pXjpgqdhOfA8kVfYClda0r7izj9EmvcLjoDQUgjt/AifSMx6di
         oBVJc3P9CJt4iUdcUmsIyLjxrNByC3nYFYu7F5i8buIr7o+Q9wvx+DyMSNHDT/CWSjwp
         tNfQ==
X-Forwarded-Encrypted: i=1; AFNElJ/GXVVHsyASAHuArQAEK3JEmsefjEHz+y2eLPCDjxmLCf2NwrjCd2QGCVX4TseLeNS6sG1m2Rpw/6CY3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzO1/ntKZdVHyEApHoe4gAS/07FhQKLgW/RTZCzkAu+CW7Anbxz
	LerLf4nxBq1AGwDsUXAXYXRdA61T3Q6P3DGPD1UXRwYhe7FUHGtlwu8DH6LW+thI5WmvsLXidxh
	gQNfgdVSczHAze6QU9r0Vs0xP5lcDA36tX6OZDdJvlw==
X-Gm-Gg: Acq92OHzeYUg44aJJD8OnKhwZvdXlNj9qtaWR9/TSPoBe6kyrQQApL9iP2HG+4h3BRz
	9M/GDhzn3Xv9LJ9e7FwNJCXzeDNSkUQ2dJ4U6cWCYIb+Ry5arCiE2bdQ+GdAG7FmXj9GULoKpMY
	mWONUsE7jxujgkt4z8YY7OoKeSVxr/1AqWvf7tc3kW2Wff2wwYj3R+HYPRxfMyBbCKCopxUCcZ2
	XMBQmWhcdnTS4MDWvy4aTesVIYfb+0j53FkLr0vtZiNwcxDHioiVAm64YbMgQNYHp56GAAfM8O5
	OWD0gPrWbwzWvKUsp5+gq1I/NuE74kpRJ+hBE9My7ma/b8nwWVQRUskbAmxsz0QxuJJudAaVuy/
	T3y2jdRlQMgoaWA9eWII7PX+SEvIZ1SeBw9u2FvtzGpFV
X-Received: by 2002:a2e:a805:0:b0:396:375:aa86 with SMTP id
 38308e7fff4ca-3960375abf3mr42005021fa.15.1779884203591; Wed, 27 May 2026
 05:16:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJpMwyiVqqbR3ni+URv0uPnE0Bgt_+d+-_+_t6E3wzfiUOT-cg@mail.gmail.com>
 <afm2PewS5Gi5QU61@ryzen9>
In-Reply-To: <afm2PewS5Gi5QU61@ryzen9>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Wed, 27 May 2026 14:16:32 +0200
X-Gm-Features: AVHnY4I1soTfTt9_9uwOHQaReM_04R_LO7E-r_irRoOLfwC04g9Kt2W-ARGJKTI
Message-ID: <CAJpMwyjcUc7n9g0YMbpBPZorUOiyseBOHHKoUhYDriEu5gzLEg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] A block level, active-active replication solution
To: Philipp Reisner <philipp.reisner@linbit.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org, 
	Jia Li <jia.li@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 11:20=E2=80=AFAM Philipp Reisner
<philipp.reisner@linbit.com> wrote:
>
> Am Tue, Feb 03, 2026 at 04:09:59PM +0100 schrieb Haris Iqbal:
> > Hi Haris,
> >
> > We are working on a pair of kernel modules which would offer a new
> > replication solution in the Linux kernel. It would be a block level,
> > active-active replication solution for RDMA transport.
> >
> > The existing block level replication solution in the Linux kernel is
> > DRBD, which is an active-passive solution. The data replication in
> > DRBD happens through 2 network hops.
> >
> >
> > An active-active solution which one can build is by exporting block
> > devices, either through NVMeOF or RNBD/RTRS, over the network, and
> > then creating a raid1 device over it. It would provide a single hop
> > replication solution, but the synchronization during a degraded state
> > goes through 2 hops.
> >
> > The proposed solution would provide an active-active single hop
> > replication, and a single hop synchronization (directly between
> > storage nodes) in case of a degraded state.
> [...]
>
>
> I stumbled across this post because of the newer replies.
>
> I want to point out that we have significantly developed DRBD over the
> last 15 Years as an out-of-tree module. In the past months, we began
> the process of getting all those improvements back into Linux
> upstream.
>
> With that, DRBD9 became multi-node. It does the =E2=80=9Cactive-active si=
ngle
> hop replication=E2=80=9D as it is. The networking part is now abstracted =
into
> transport modules. We have one for TCP, one for load balancing across
> multiple TCP connections, and one for RDMA.
>
> What you are doing here, in DRBD lingo, is a diskless primary
> connected to multiple storage nodes.
>
> Find everything here https://github.com/LINBIT.
> The latest edition of what we bring to the upstreaming discussion:
> https://github.com/LINBIT/linux-drbd/tree/drbd-next

Hi Philipp,

Interesting.
I looked into the diskless primary mode configuration for DRBD, and it
does look similar to what RMR/BRMR offers.
We plan to do comparison runs of DRBD diskless primary mode, and RMR/BRMR.

I see the DRBD version in the current kernel is still 8.x.x.
Do you have an ETA by when can we have version 9 in the kernel?

>
> Philipp
