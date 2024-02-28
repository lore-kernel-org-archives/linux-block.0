Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6478F7350D
	for <linux-block@vger.kernel.org>; Wed, 28 Feb 2024 12:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709122173; cv=none; b=JHf/tb6N0xwKf+0bhyIZcOM4Zj0G9hLeKeIRCQPILHLXDKF72pTmwMEuDLfU+Isdtxq/B8YWqAtxi++z7BPfaTKBwcBO6BwYCg/xGMhxDIg1zfm9fIXjBM5lJ0KtJQ6DcdP+SUEVAVWyBpRukK+zgSXkhbUF1DZZ1ulnecOva+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709122173; c=relaxed/simple;
	bh=AuzLxoBjTKjSVA320ALgllDJJtFbzaoPVoUxeNeZqhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KflSp9HdwkhCHbXYb/XLdSZRO3TosRESwM+weRZc4jtqk136DpIy50ZDv2BWSDoeXmTtdE1DJ5ONY2vDnXOM/uhmpwEcQ6krgpsE9jNuQ9R/ZFL4JsxWsI0Nk9Tui80qlCw2UTOoRAqbCmOPdnFEfmp5vLmdc5eTTw92q/OFma8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QpVnnJUn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QpVnnJUn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709122169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g6EL9cPhTMAyWmeokXzsYJmYvM8R42YEQq03/6rpHG0=;
	b=QpVnnJUnwvV26mLx9gwfqXwUDbyhtsOLDjGrEZbratcW0/DjYtEOgr6jqGN8sHGF6DqRU7
	xHGxTjG4n7b93heyLAhf01TfVweKA8DpZOsAhYIXNvB3xzpBJRPz8m53OQH/22GWN4CTqO
	Bf/TndTOTtLX7YXfUTA6LHCZjOsZiZs=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127--2CxoA1IMzSCbjhW7e9rKQ-1; Wed, 28 Feb 2024 07:09:07 -0500
X-MC-Unique: -2CxoA1IMzSCbjhW7e9rKQ-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5cfda2f4716so4056983a12.3
        for <linux-block@vger.kernel.org>; Wed, 28 Feb 2024 04:09:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709122145; x=1709726945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6EL9cPhTMAyWmeokXzsYJmYvM8R42YEQq03/6rpHG0=;
        b=FhjzRTyESvQhEiN65gNLjkl51LbS/dtDMY43/rw7YXBiK+dEgBQTP4/7El3siKFRBr
         iGRQ1WlKB8O7exkruFcnQh3Ai2nYEkbF50RmRacmmSSNIa+MQ5sfz+FsWnqH1bE7nJMN
         VRW5IiZYUnFXJ93qEfjNeMoXJi3QlNGXcs6jwygYXKScjF3ud/5Lr9KdpWvPo3qutDhU
         ImhO2mqiTA2FAsDztldXOdYjGVQ14msEdmTDm+yOHb1z9r15Vt8svX7DM2IJO56fisno
         Mp2kRlwYUKWUdR/1JBVn+UyegtIGOBKJsY3GPSceBE2YDWXV9cyA73ewItrBSxJkf1Ys
         AhEg==
X-Forwarded-Encrypted: i=1; AJvYcCWFRajpPmfl6UDkVXjSv2q6uJnVqFfCbnli0oRZQKSEkvOPZGCnk8ffvqNns6ICC0jia1W30GHrivx8g6Reg9tRrHn4TmrYYPvz2CI=
X-Gm-Message-State: AOJu0YxwVOWPthxVgE5isX/h2hC3Ptb1SBXz7JyZSwK/kI+zo4tnFMaW
	/yNwBkuCjX9XAiLZIux14WW8qf11CeKh8HJYvBJoOdJr7tl/0BvhNq9sb/IGUX535i4aEm6us/J
	d9jvBs0+thg0ub3LLsJid8T2zRV/JK5dsSC/Wr3O4P4tlDqU92Ugm0OwUG0DXMEqBHTVhiSaxag
	66nZfO80P5/D3Y3nr2jpXGcJd/ELnJqlIGm44=
X-Received: by 2002:a17:90b:ed7:b0:29a:f766:7eb1 with SMTP id gz23-20020a17090b0ed700b0029af7667eb1mr970900pjb.23.1709122145140;
        Wed, 28 Feb 2024 04:09:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAL2NtuIcb1ggSrgscHzABaov8tWR7lb72b2oO4vsqSCcqUkgX1bnMWtBqKcToHJBlyYlRqIr4Do4MxvqDWMk=
X-Received: by 2002:a17:90b:ed7:b0:29a:f766:7eb1 with SMTP id
 gz23-20020a17090b0ed700b0029af7667eb1mr970880pjb.23.1709122144830; Wed, 28
 Feb 2024 04:09:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs-kfojYC9i0G73PRkYzcxCTex=-vugRFeP40g_URGvnfQ@mail.gmail.com>
 <esesb6dg5omj7e5sdnltnapuuzgmbdfmezcz6owsx2waqayc5q@36yhz4dmrxh6>
In-Reply-To: <esesb6dg5omj7e5sdnltnapuuzgmbdfmezcz6owsx2waqayc5q@36yhz4dmrxh6>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 28 Feb 2024 20:08:49 +0800
Message-ID: <CAHj4cs874FivTdmw=VMJwTzzLFZWb4OKqvNGRN0R0O+Oiv4aYA@mail.gmail.com>
Subject: Re: [bug report]WARNING: CPU: 22 PID: 44011 at fs/iomap/iter.c:51
 iomap_iter+0x32b observed with blktests zbd/010
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, 
	linux-block <linux-block@vger.kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>, 
	"chao@kernel.org" <chao@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 7:09=E2=80=AFPM Shinichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On Feb 19, 2024 / 00:58, Yi Zhang wrote:
> > Hello
> > I reproduced this issue on the latest linux-block/for-next, please
> > help check it and let me know if you need more info/test, thanks.
>
> [...]
>
> > [ 4381.278858] ------------[ cut here ]------------
> > [ 4381.283484] WARNING: CPU: 22 PID: 44011 at fs/iomap/iter.c:51
> > iomap_iter+0x32b/0x350
>
> I can not recreate the WARN and the failure on my test machines. On the o=
ther
> hand, it is repeatedly recreated on CKI test machines since Feb/19/2024 [=
1].
>
>   [1] https://datawarehouse.cki-project.org/issue/2508
>
> I assume that a kernel change triggered the failure.
>
> Yi, is it possible to bisect and identify the trigger commit using CKI te=
st
> machines? The failure is observed with v6.6.17 and v6.6.18 kernel. I gues=
s the
> failure was not observed with v6.6.16 kernel, so I suggest to bisect betw=
een

Sure, will try to bisect it later this week. :)

> v6.6.16 and v6.6.17.
>


--=20
Best Regards,
  Yi Zhang

