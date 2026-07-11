Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9443B3C1F24
	for <linux-block@vger.kernel.org>; Sat, 11 Jul 2026 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783772002; cv=pass; b=JE6QuXZzK0vfEuMtua+s5NEZFBYiZgBAUVcXkEdIk9EGpwE83z5fqpAqWAQocv95uGZGsoZCFPayGAVCCSuk6a5IZPMSkgTWv1ZmJkz0/CXDHACHg+imT9nY7vGZUN1d47KlkgLtM29N0PyAMzXLfNMZFJJz7MHj3q+zJe5zsB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783772002; c=relaxed/simple;
	bh=80vo3JIjnCsKn8zo158HX4vkfRXd32w7uPzzJAtLaF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJL3tUWJZqdSTatxQvRa9wnGj4qGAaSeLqV0Sr+3TCI41VIGu4P3JFJIkHTBowtaMP8AFbUlgUNWlGDhIV8NDfLHK6yoEDNdguStTElctuDizPGt6c0LRYnZE+dfzdek9L+2qo/yGHM2xEGOCGZcXJu38UAHhWc09mw/f52buTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHFB0fSe; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHFB0fSe"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38096590070so318996a91.3
        for <linux-block@vger.kernel.org>; Sat, 11 Jul 2026 05:13:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783771999; cv=none;
        d=google.com; s=arc-20260327;
        b=L6sZetvMEnLrDxTBdmY2w488zll1N2Ke41S6dz7f9ZEiMNLDPAOwe8czTTG38NwzOh
         ZziTt2TeSJ5F0n+nxMrI/97M6QYh0RSXSMrX/dpXMvdqUw60UHaNvp95rrdCEhNckHrD
         EyXMdMfQDaUXFCCpL9OcEy/6omoIRsjb2aeRAdBgm9JxM+ldhKKeJLEfX1gVkkcchgn2
         NHpcxc7oXFDYHfqejGrGxeEDXS8z8gobXrbBcCIBbSGAYDT2gOdUwykgjmeJM47d8fLb
         ItsnfodHUvlWclEBk5FGo5TCsUh7cyB43GkFOvnNDTMHRX9ILoGmCTtoJrifaL8Tu/Nv
         s2OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=80vo3JIjnCsKn8zo158HX4vkfRXd32w7uPzzJAtLaF0=;
        fh=6qDAb40ZiNK/DnBPMxhBkFE0AwNjFsmb4MqjROD+ies=;
        b=AIJvfBTRUzH6zQq0AUTGP1eKCVqJqzQ/xZo30ADBeA6L6YDMX/oL8cedRBtzlawfhk
         uWp3k8unje2VlfaSA8RfNJF3zw/+QV0Yns30CISDi/slEuxMcxebdG3OI3UxspPwfjQI
         SlxGP3TkKCGLV1II8sOGSFPu3RztVF8bqZYAn3RiNzUUhq7A7uQhyCttak4AqnhWf8SJ
         dpiQ1ltdG5e5Ljv6zCny1KssUhhZDJY5hrZS48THtA/ySfG418Zckm6GeXFPb1C5pT22
         YahjzvVVqd68vXFMPg6X/p8dy5a4mz+HxdTQbRl3EmTnHxczPila1TPuxlKkmn5U9THx
         tPEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783771999; x=1784376799; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=80vo3JIjnCsKn8zo158HX4vkfRXd32w7uPzzJAtLaF0=;
        b=gHFB0fSemSn6s4jVp/EuBtir/qlPGO8Vq2wg3sOO56WQSEm3m1wgLV+PH+YCzCwe4w
         40XUJ8N3llKffVv3KvwlpEx0PwjFhEP4ejwfKckXHhOrs4COlZYMuCDJVCD700HVWfby
         Wef44AYzEvkwlRh4pmvCSPrnSSb+EuoMS7xAp1fqanhd4vgQUbVFs9DMhr/aX2ve4EZi
         XKK9VbugY1ax8izR6ls1BpqL9Fr7yUJMtkts2rZtlWUvAdEs5tvYZoRcRU9pXB0Y6W76
         RQw5PmUpYS6rrCfKNmEtUvADgYNWM7gb8xCEbJGzjwstKv7ju7GWWD5f6bQVByQhgD9b
         Verg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783771999; x=1784376799;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=80vo3JIjnCsKn8zo158HX4vkfRXd32w7uPzzJAtLaF0=;
        b=FwLZuHAlzG4fGnuBuFaT7azYK6zA2okCfxSMkD6PCLGKLZ1aO1fvrgjizxIHX6GyxV
         dM1KiYe+JRbbSuA+jHpfNTv34fISSval8XokvggZCTj3XwwLHJ3RX075wqi51A+8df7H
         Ds06qGSGwjBs1yGAqaip+/g8mleoHpUCV2IxXjb1OJiFuPf0Ypn5TU/Bb+UE6tqJnRPR
         iVXXWprhJj94S77k0MvdGlxH5XYYRFCBllLEQjhvU2fbANNAG0JUV55e6WwDCW+MHEpV
         /fh88IMnGqP7yvMQpAXJV4/tLV/dleehJvY1/B5Nc4IPu8IvsQ6QqYSi7vDPJEdXuCnV
         dSxg==
X-Forwarded-Encrypted: i=1; AHgh+Rp1HfK7EDDJXvWryWgeV1IP8kmtoRhaBYoI1iQQ3fZrRgKctsu+OCPKT6zXHIJ3PQTnH6fPuk63eE2S6A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1DiQzIpu5R/MguyMjHXXEDK5AWZ2vSIKKrtT0Tf7Vx0WDyfO/
	f/N66qE4s8S1+STYfAk6yAwM2hMmP+BsABatilsta6vKq2TFCxQbzkiqkQGA1hETWGjTUw/HbwB
	7GgjKLhw0jGrUDTAL3mJBsmqwKbLoA6s=
X-Gm-Gg: AfdE7cmFVIuirIt4DEzxQmDAkmOb/5gIjgiyobYhtuxYEspjuDcatE0ZRNfnnn2bFdH
	JJ8Fi9TWVE5WzKN0GeDQV3gUvA/eXHP3dDqs94TGXfloOPYUYoXdNr5zp6wstWl3jwoxXTiSFQn
	IoCh03TstUkI1PHY0Pn8Ha1sOYYtJ6LEys+eQfPcPBBBjo0Hw5QssB+KIPjuhXVcclPo9ZOqJ1A
	ePd3H79RbilV6qBeVZr8NMad58eRWFrBxMJYM3wMpQOsKG8C8s8xcuyGkCU0ZxWbgmmSEAac54f
	o51mr8J97j9yvc5njFobEe50pGyCdDBJtqz3gSmtjykiDZsP+li8tq4vSGEkvz2dwv0pHwOQbxs
	dX+B9hnZ1f3SG
X-Received: by 2002:a17:90b:4984:b0:380:9cd1:d985 with SMTP id
 98e67ed59e1d1-38dc7c111a8mr1909664a91.6.1783771998816; Sat, 11 Jul 2026
 05:13:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706061928.66713-1-byungchul@sk.com> <20260706061928.66713-40-byungchul@sk.com>
In-Reply-To: <20260706061928.66713-40-byungchul@sk.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 11 Jul 2026 14:13:05 +0200
X-Gm-Features: AUfX_mwWK6GqFCLIKCx9ivosmcno3i0b64L6R15FyNFXSSwj0HKdZlNefQKWcgc
Message-ID: <CANiq72kEo=bGcHNaSA9JZhv4iuE+YDvu0kN+Z7aopVp3=2C+Wg@mail.gmail.com>
Subject: Re: [PATCH v19 39/40] rust: completion: Add __rust_helper to rust_helper_wait_for_completion()
To: Byungchul Park <byungchul@sk.com>, Gary Guo <gary@garyguo.net>
Cc: linux-kernel@vger.kernel.org, max.byungchul.park@gmail.com, 
	kernel_team@skhynix.com, torvalds@linux-foundation.org, 
	damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org, 
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, mingo@redhat.com, 
	peterz@infradead.org, will@kernel.org, tglx@linutronix.de, 
	rostedt@goodmis.org, joel@joelfernandes.org, sashal@kernel.org, 
	daniel.vetter@ffwll.ch, duyuyang@gmail.com, johannes.berg@intel.com, 
	tj@kernel.org, tytso@mit.edu, willy@infradead.org, david@fromorbit.com, 
	amir73il@gmail.com, gregkh@linuxfoundation.org, kernel-team@lge.com, 
	linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org, 
	minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com, sj@kernel.org, 
	jglisse@redhat.com, dennis@kernel.org, cl@linux.com, penberg@kernel.org, 
	rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org, 
	linux-block@vger.kernel.org, josef@toxicpanda.com, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, jlayton@kernel.org, 
	dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org, 
	dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com, 
	melissa.srw@gmail.com, hamohammed.sa@gmail.com, harry.yoo@oracle.com, 
	chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com, boqun.feng@gmail.com, 
	longman@redhat.com, yunseong.kim@ericsson.com, ysk@kzalloc.com, 
	yeoreum.yun@arm.com, netdev@vger.kernel.org, matthew.brost@intel.com, 
	her0gyugyu@gmail.com, corbet@lwn.net, catalin.marinas@arm.com, bp@alien8.de, 
	x86@kernel.org, hpa@zytor.com, luto@kernel.org, sumit.semwal@linaro.org, 
	gustavo@padovan.org, christian.koenig@amd.com, andi.shyti@kernel.org, 
	arnd@arndb.de, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	rppt@kernel.org, surenb@google.com, mcgrof@kernel.org, petr.pavlu@suse.com, 
	da.gomez@kernel.org, samitolvanen@google.com, paulmck@kernel.org, 
	frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, 
	josh@joshtriplett.org, urezki@gmail.com, mathieu.desnoyers@efficios.com, 
	jiangshanlai@gmail.com, qiang.zhang@linux.dev, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, chuck.lever@oracle.com, neil@brown.name, 
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
	linux-rt-devel@lists.linux.dev, 2407018371@qq.com, dakr@kernel.org, 
	neilb@ownmail.net, bagasdotme@gmail.com, wsa+renesas@sang-engineering.com, 
	dave.hansen@intel.com, geert@linux-m68k.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 8:22=E2=80=AFAM Byungchul Park <byungchul@sk.com> wr=
ote:
>
> This is needed to inline these helpers into Rust code, which is required
> for DEPT to play with wait_for_completion().
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>

Apart from what Gary said -- why did you need to do this in a separate
patch in the same series?

Cheers,
Miguel
