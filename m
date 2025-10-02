Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28132EBDC2
	for <linux-block@vger.kernel.org>; Thu,  2 Oct 2025 13:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759411468; cv=none; b=V/uQR8UH10S7hjPbFrWIB3kgd/e9dh9dGyOOYVWv85fDBrUYEoB4bmPz50Mc5mitnKkV9SoV122nIAgk9zEkzMeZ2KvmyDx8KqnTP+58xAo3OaOKiz2YYw4+/jmDsvCeMcWJsqYnWcobktFAApDSIQnvspB6UtJtBMe1Cqo+7lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759411468; c=relaxed/simple;
	bh=Bzm3UVzy5UmWZcilLMKv+UlC3Okbitce2Is02Gaxtrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cwdD7oVXcsLVAMm6w4MTtec6uW4KDjzqj4KrmRmocoDnSRszWwjeLP5Ief1U1JwJkS2/YswMqwx6vmtI0BLO14a+e0ITSCA4aKDAprRukKdS8SVITk0siFOFah3HdzI5nyAbB4wBb4Tu9cmzNE5eI1LTO6kLOJek7IOgyon30H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-856328df6e1so117159785a.0
        for <linux-block@vger.kernel.org>; Thu, 02 Oct 2025 06:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759411465; x=1760016265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ec+ndxQ3jnu1a8VNviNr06HkWUDsCBC6MfDIjOmWDIU=;
        b=MFsCbVU2FSYdL+f2VGCo5fop7KL1E2XNHHhRMWPRcuT8jBZqUPG/hr7ZUolmgH+K9r
         WaevPDrYf9PYlgyYVqsWstNeegb5Zgigq+H9iobh9VaqN7gDh6xZww/WSZwPJ7OPgISh
         0ZKHYltytfgUuB3LPj8r61/gnsiUKI8ChjA5tC6UPONtpD9EKbrrSVDr0Z3Mrxlsadt+
         LgXLeqN1442wXfWRp44VtZC1Wx7mpcD0I/lzh6L3BzrcdY1+qY7HnADR/UMW4UCpLSqG
         bt3LKnu+0IwaT2599V6ltCrMvMz3jZ8BjQLKjzrk+G+5dEsvRLQgK67Ir/x/hxdQriok
         1OrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWogjqnNlcZD6FIwWdsWXeLX+EmCaT15I2Fe29E7JSfFePmeK3qIIFFJbLHO1TvFNuky/OMgngzrEAIlA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFGrFHppfgxDmfOZSsmuT0LAQUsG8P/dmhEyG65L9qIuAyHaLK
	whrfwt2vYzaI4nw70JX3gfzpwIaIE1Bf2p5zeKKAT6TP46elzw+LNRb4gkYWUfu/Brhrcg==
X-Gm-Gg: ASbGncv2UaLVbju0f3UYZB3m0YR49zTiRky/MfcSSTGFEkVEBhIIROOpVSQqGWiRcwJ
	1B4GyZAynFVDDcy7nYGp6DedIeiQ9pP0pDINIrHK0KXj/Oe+HDQPfbRvUmRuMmIlQP3NArkdlUU
	t+KeOIU1uHs+oyjEHLkfWGyYaLx/G77jLszIhY/uVwwzLAeymZmh0PngNOQZ6E5RrfzE8FhP1Vh
	MP5K9NtBG3lYlAvE9qL41brBTUQS0/bJYIyviuSnaqIOe/4Ez1YybUQM8sLFIENv4m6eHeXbbu4
	ByyTbRi7VOYQ82L2uXtVs8IuSGG1MV4wGN1IlPx7reSSWBehmPhiyETJN+e4mvQRD8Z/xGLPPf2
	zppT9S575ik3E4zhhnTh/1EPcVB+nRKbsnUfiEKWPKwok7m9Gv0OB+Z8vUKzPWA4WO8Dd2esJ/2
	lEXavivkAS
X-Google-Smtp-Source: AGHT+IGbFEp7dTecoFRKwgC88kZ7uBQC2bhngLb1VH+vluZ8xeILutB5zKhn7xjITM3GhPPNisnc+A==
X-Received: by 2002:a05:620a:a009:b0:878:16ad:3a5d with SMTP id af79cd13be357-87816ad3c92mr280814185a.9.1759411465431;
        Thu, 02 Oct 2025 06:24:25 -0700 (PDT)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com. [209.85.219.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55a944677sm19722171cf.13.2025.10.02.06.24.25
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 06:24:25 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-78ea15d3489so9794596d6.3
        for <linux-block@vger.kernel.org>; Thu, 02 Oct 2025 06:24:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWi78JP6sCEfsXR6LUYrl517PNEU/c7KYNUvLyvu37WgPVl+aSde/OAHK8XBrVAdvwPJn4clbrOrm4+gw==@vger.kernel.org
X-Received: by 2002:a67:f74a:0:b0:5d3:fecb:e4e8 with SMTP id
 ada2fe7eead31-5d3fecbe643mr2057033137.5.1759409779799; Thu, 02 Oct 2025
 05:56:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002081247.51255-1-byungchul@sk.com> <20251002081247.51255-3-byungchul@sk.com>
 <2025100255-tapestry-elite-31b0@gregkh>
In-Reply-To: <2025100255-tapestry-elite-31b0@gregkh>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 2 Oct 2025 14:56:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWXuXh4SVu-ORghAqsZa7U6_mcW44++id9ioUm5Y4KTLw@mail.gmail.com>
X-Gm-Features: AS18NWCmqHU8DKNueQjpF6Ifrv2W5fzYfUTjQ8XBBt-1KrFWqeUHHsvmYo_0fpY
Message-ID: <CAMuHMdWXuXh4SVu-ORghAqsZa7U6_mcW44++id9ioUm5Y4KTLw@mail.gmail.com>
Subject: Re: [PATCH v17 02/47] dept: implement DEPT(DEPendency Tracker)
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org, kernel_team@skhynix.com, 
	torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com, 
	linux-ide@vger.kernel.org, adilger.kernel@dilger.ca, 
	linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org, 
	joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch, 
	duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu, 
	willy@infradead.org, david@fromorbit.com, amir73il@gmail.com, 
	kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org, 
	mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org, 
	vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, 
	cl@linux.com, penberg@kernel.org, rientjes@google.com, vbabka@suse.cz, 
	ngupta@vflare.org, linux-block@vger.kernel.org, josef@toxicpanda.com, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, jlayton@kernel.org, 
	dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org, 
	dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com, 
	melissa.srw@gmail.com, hamohammed.sa@gmail.com, harry.yoo@oracle.com, 
	chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com, 
	max.byungchul.park@gmail.com, boqun.feng@gmail.com, longman@redhat.com, 
	yunseong.kim@ericsson.com, ysk@kzalloc.com, yeoreum.yun@arm.com, 
	netdev@vger.kernel.org, matthew.brost@intel.com, her0gyugyu@gmail.com, 
	corbet@lwn.net, catalin.marinas@arm.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, luto@kernel.org, 
	sumit.semwal@linaro.org, gustavo@padovan.org, christian.koenig@amd.com, 
	andi.shyti@kernel.org, arnd@arndb.de, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com, 
	mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org, 
	samitolvanen@google.com, paulmck@kernel.org, frederic@kernel.org, 
	neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, josh@joshtriplett.org, 
	urezki@gmail.com, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, 
	qiang.zhang@linux.dev, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, chuck.lever@oracle.com, neil@brown.name, 
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org, 
	anna@kernel.org, kees@kernel.org, bigeasy@linutronix.de, clrkwllms@kernel.org, 
	mark.rutland@arm.com, ada.coupriediaz@arm.com, kristina.martsenko@arm.com, 
	wangkefeng.wang@huawei.com, broonie@kernel.org, kevin.brodsky@arm.com, 
	dwmw@amazon.co.uk, shakeel.butt@linux.dev, ast@kernel.org, ziy@nvidia.com, 
	yuzhao@google.com, baolin.wang@linux.alibaba.com, usamaarif642@gmail.com, 
	joel.granados@kernel.org, richard.weiyang@gmail.com, geert+renesas@glider.be, 
	tim.c.chen@linux.intel.com, linux@treblig.org, 
	alexander.shishkin@linux.intel.com, lillian@star-ark.net, 
	chenhuacai@kernel.org, francesco@valla.it, guoweikang.kernel@gmail.com, 
	link@vivo.com, jpoimboe@kernel.org, masahiroy@kernel.org, brauner@kernel.org, 
	thomas.weissschuh@linutronix.de, oleg@redhat.com, mjguzik@gmail.com, 
	andrii@kernel.org, wangfushuai@baidu.com, linux-doc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, linux-i2c@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
	rcu@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Thu, 2 Oct 2025 at 10:25, Greg KH <gregkh@linuxfoundation.org> wrote:
> > @@ -0,0 +1,446 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * DEPT(DEPendency Tracker) - runtime dependency tracker
> > + *
> > + * Started by Byungchul Park <max.byungchul.park@gmail.com>:
> > + *
> > + *  Copyright (c) 2020 LG Electronics, Inc., Byungchul Park
> > + *  Copyright (c) 2024 SK hynix, Inc., Byungchul Park
>
> Nit, it's now 2025 :)

The last non-trivial change to this file was between the last version
posted in 2024 (v14) and the first version posted in 2025 (v15),
so 2024 doesn't sound that off to me.
You are not supposed to bump the copyright year when republishing
without any actual changes.  It is meant to be the work=E2=80=99s first yea=
r
of publication.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
