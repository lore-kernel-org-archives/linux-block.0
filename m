Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED3A2DEA9B
	for <linux-block@vger.kernel.org>; Mon,  4 May 2026 08:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777883104; cv=pass; b=ixqbs65wjM7PWFKPalvW2Q1GK6+kQZ/M9IQOup+4uV71C4A0zp+TDwXHnufWnoY+1RQxBD97nz9keYzXWqHeO5lPWnin3IRxz2IkR73+Tu0Z/3rkwvKrk301rsp4j/cQjFU8bSuvoI7FtXL1H86Lv8uot/pB1JwawKhhHvTbZis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777883104; c=relaxed/simple;
	bh=50B2Z+s4Yf1eJw7c+SSWBLTa9fp6lCfkiafN8LV4ncI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fc13qF+P+oHP4sQEe0iW7fLa7UCh+Lu1q09OZ0jhFQ89NsJ32lJ78gofripLkH0XbdbuZRk4x4L1wofoNNZwZprYprrskB/VguTbSNKch0Z8x2xzioXs1p3Rl9FzP2oc5O2O1UxWUiPEiNdMjwQ78ikAY8+6XUYscvF0R+9nJLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=ZwFKW6Xv; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="ZwFKW6Xv"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39380e79936so15062721fa.2
        for <linux-block@vger.kernel.org>; Mon, 04 May 2026 01:25:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777883101; cv=none;
        d=google.com; s=arc-20240605;
        b=hOGf5zbOjiwEjbFy16I+UbDfImu0UWL+Yf/O95hSsKn+DcEtNi44+H4pCl6Oa3MCQY
         9wPAUOKpFU8LPtYRKksWlcBvKJ/a0eW09PkFiFyj9p1rIu+YG72NXoIcdf/aaQRwe/Bl
         jtipVcxKicSJQEl38vrupqtknVq8cnuapziQfrBtYhmXACmcXllxp/lkd8KkztHDti/E
         TyqfnfuDLOsq/Cs9ynjNtD6um73ijWvfL4e+fdFp1i+hIxMAIniiFVOek/dr0KB92dRN
         g1EGTdyLk+/aoDbOkX4aKy5sb87IfXNNTAjvXUrrpymq5R34bqDlvdYZ2L3F+2ci5IMr
         DIEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d5tzrJoeJBcUI9Ju9dlr6+HpOppz4fCD51OB2ckkMu8=;
        fh=BoyZaCEGuHcMzUHH3foywDsTCicMwk79fTZR14tlhzU=;
        b=X7Oez8ZV4Gjaqh+kX0lS2IPPsWoXeqdJv9HXJzNuMvh7peiEt3JRxrZayhweO/TWVs
         Zpjlnn2Oy2bF03k2fSGI2sSl8o2x8DYVcix07d4jOvS39g5QiPFKiNB4gOp5eHszRmi4
         HYw3KukFJSQ0KaCmaBV9Hy1EfJ0S76g21PTIDTn+vO6jBEmQSgNdBXKpj750AC760Iw+
         91EUtBA8UdSIkir2iRqqlJn65zGnJmJtUbwkp1mziahZX5xZeMcssm5uv+U0bjxpFFPY
         BrcQ1KLX1+HrFuppVJ52Asa5SZUEJw/8Z3H2VoHkljaZXQ9pmy9oeaRFm2rvXfKBZFSX
         Fjbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1777883101; x=1778487901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5tzrJoeJBcUI9Ju9dlr6+HpOppz4fCD51OB2ckkMu8=;
        b=ZwFKW6XvS6Uq9fpij5X6vzhc2PinkIq9qL7lhJLX2l3SftxWxj3l9XPJGP7By2vMnU
         nU0PHFpQui8CdfLEJ1T3/Qj56bAqagshckC7+KOuYqAgvU1GKiK2FmNzymh6dq+n2d8v
         4s5bhY1O4ikA60srtKMW8J9esobN+7D5e2YEyLlSjl63xIGJnna6xhLYJtjJZ9ezMx8l
         mPweK/H45K/BO47JFAUjI9heXfnu/cC7dawQ7OUXo5IiEORqmGZsGGT9DvDtt+eUQONz
         lFpgIJolzzwGr61r11AmAI+bm7w97xDenuchK9CaJO1RJafoE6l65i/9HexyRIn1Vnzd
         SwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777883101; x=1778487901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d5tzrJoeJBcUI9Ju9dlr6+HpOppz4fCD51OB2ckkMu8=;
        b=jvCqbj73g8hdWGJk/gViWpLiqwvMoKlZnSc2xQA660wXwyejpelko1NUYn4HS7O03Q
         J8WCFLrYMBIb/KZw7voMZ+dJs3ojA+gyqmGSnzO8W32vjHnH5eRv9N/y2lCLQQaHRFCF
         06+GuagJ9VGIrvbvWtGrUpQnX88c3sCamO5Ca124khzxvsimCemyAHO64GvrR8a/77fD
         7fhiqGYyn8SkJ5L9rhz6fUCBXsRXZWdZoYB2ER9PWwXWIbyR89nxFHdvy9tZ7rlxh1eS
         X9WasRvCRL977xjSDkYpqKmThJ/sTNhkqMnM/P47B899o7UXYb9NqWURrZg+jrkLm2MZ
         zsBA==
X-Forwarded-Encrypted: i=1; AFNElJ9ltd04VsMxMnX6GLlN4jRA1Ko+djnfwSdsPkyP3eE6A6wZB9OS3ms6cTHOr95Ggp6Fw61AO8GsEBdAHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ4qlm+EwIZx454ac5gOMpUTYccP2hIPz8QlfZwhCOPy/oENSm
	oDDTX65q2XlHgp+g34Dd+N0bLDk7i68Bt+qscmHnWHnO/bmj1jtHe+vPimf5SFqGMLBnCqQRz2C
	ijCWnndRT9Ry+EhB4Gyen+2xUYeMITM3MZUON+GcfxQ==
X-Gm-Gg: AeBDietdAg0tq5oOZy7HaqusyfEG2EG2uYEsSRCWFaY79Dtz/OphiGZ2x/9zmGvsLCE
	YtzAFwyktgyicnrYKyN2a2JC9oKTbtT+hIxd5OdSVNAQzuaq3oc2CF3NL6WL21jefhUXrIyMlOJ
	MNtuOEu/GYmasjDFgSECZDegLczM91yVFF70QG8iQsXQyRtrET4B4A8bTTT1Va/MrpkO+RTjAKP
	BG7Oki5ijMprmYxkdtZ9U4RWc3xCZFzx5p/29kilV291zc/KaxtA4DBXe73yn0+kW8kpWOk1f5I
	mghBmsQBCtb5PHK0y4WnSE0SWTbWgxz1OX0x6WwTmNoQJrq2F+DVUt6rWVlQzOI1DSYLkGRoGSk
	v6sdV1KO9fvSZNg==
X-Received: by 2002:a2e:b8d0:0:b0:38e:49e6:a376 with SMTP id
 38308e7fff4ca-393785ab20bmr25114161fa.22.1777883100524; Mon, 04 May 2026
 01:25:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJpMwyiVqqbR3ni+URv0uPnE0Bgt_+d+-_+_t6E3wzfiUOT-cg@mail.gmail.com>
 <afUDV3ue45-shCNU@casper.infradead.org> <afXi9crQyOnqJ4-1@kbusch-mbp>
In-Reply-To: <afXi9crQyOnqJ4-1@kbusch-mbp>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Mon, 4 May 2026 10:24:48 +0200
X-Gm-Features: AVHnY4IFBQNkCdL70YZBETegG4GJzr0i17Pz-ADdOtn2SGkpbvKiXl0-WqsHR5k
Message-ID: <CAJpMwyj0SRLE6+y2aYQ3493f5Qcox-hOfUTKjJQUxhBZ7rLJSw@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] A block level, active-active
 replication solution
To: Keith Busch <kbusch@kernel.org>, Matthew Wilcox <willy@infradead.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org, 
	Jia Li <jia.li@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 2, 2026 at 1:41=E2=80=AFPM Keith Busch <kbusch@kernel.org> wrot=
e:
>
> On Fri, May 01, 2026 at 08:47:35PM +0100, Matthew Wilcox wrote:
> > On Tue, Feb 03, 2026 at 04:09:59PM +0100, Haris Iqbal via Lsf-pc wrote:
> > > We are working on a pair of kernel modules which would offer a new
> > > replication solution in the Linux kernel. It would be a block level,
> > > active-active replication solution for RDMA transport.
> >
> > Why is active-active a good idea?
> >
> > With an active-passive solution, network traffic is directed to the
> > active node.  Over time at some point we get close to saturating the
> > link and performance drops.  At that point, human intervention will
> > occur and the network link will be upgraded.
> >
> > With an active-active solution, traffic goes to each node.  At smoe poi=
nt
> > each link will be about 75% utilised and we won't see any performance
> > problems.  But then a node goes down and all of a sudden the remaining
> > node is being hit with 150% of the link capacity.  There's no gradual
> > degradation here; the whole solution just goes down.

One can always flow-control the traffic so that each node in the
active-active setup serves enough such that the sum of both can be
served by one node too in case of failure.
By restricting the traffic (as in active-passive) during the happy
case (no node failure), which would actually be the major chunk of the
lifetime of such setups, one is under-utilizing the available link and
intentionally accepting lower performance.

Another point is that, for an active-active setup, when one node dies,
for the other surviving node only the reads are doubled, which would
mean roughly 40% increase (if we consider a 30/70 write/read split).

>
> Maybe I'm out of touch with reality, but I could swear active-passive
> setups are often configured such that the passive node for one resource
> is the active node for another. That would also suffer the same link
> capacity issues you're describing.

AFAIK, what you are describing is a more of a clustered raid setup,
where multiple clients write to different defined and protected
sections of the disk.
