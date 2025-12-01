Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E9D1E7660
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 08:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764579573; cv=none; b=lfQEuyfjnki1XyfK++J/QmQF3qf4V+rsD7npQ1GRRa4SVZLQTfYSXh45j5TB6OCFNHqJUf5keNZIDV6NGUxWpNqJrHkuUpyGoyAK39SCe9Ces/4x37zHfLQmZwtAESVHJNSnuvpVKRNH/alTS7fcyEtNC536i5PFbcxmgimfV2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764579573; c=relaxed/simple;
	bh=Bv+hwRhAL6bK3ZTLOyqAu71a8n0tTmZKJIk6rA4Hla8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EVVS/wOgnz9BgohSB+BDHZag0WF0X41rtxwmA6RsQWMFfZCSpduoUzbCnS9YqJNb24HKysiYlN8UHz7tPM1uoFmh8KgmZ9W6uKYoSEy2nA4SadOGDro4JRWAWer/xRVoQ638U+824ubJeb1x1yG558BqPxZMKJP5hIUfenI5c5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCNOozFm; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCNOozFm"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8b1f2fbaed7so361682185a.2
        for <linux-block@vger.kernel.org>; Mon, 01 Dec 2025 00:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764579571; x=1765184371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIanSllFqG33Sgl7Ezxh92IDocVsN6LhPgRC6hyS9uI=;
        b=jCNOozFmaeXJgxWmIYq3s1VzP3DneWQwYkNScS5poGKLpedKBlh1roERr3DFLw25Cf
         oqWQXqlSRGrIyMqPU/mMecb8oLZ8JmXh1c9Cdc5KFuz0hKLUY2z80PBgy0oP4Ap3ZIS5
         y3rsMtMH+htInoHFaj623RvJvy1G7JM6DJJ+r0T4IeluSBJWzFjXm8KlrndiIEy5gV6u
         llRZbvYDFaMKPMWTu8vaLSRDqO/kUxw/Yu9ZwkdKL4q7SPDmshA9wbmnC+5XP2p349iF
         sPxjShGcnaD0vkASDL+fq7DCiLyTY4mSYOVG+B86o2vrC219DExDNVpKlfpf10A2Ya60
         xPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764579571; x=1765184371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nIanSllFqG33Sgl7Ezxh92IDocVsN6LhPgRC6hyS9uI=;
        b=EUxtCPjWQsNGaSprHsE9Vams1ICtR0hXuxdUnKqASLrWcMbFviPbznVGUo3SZivS9I
         pEoPDPOEEJx9bvJBLguaGXZAkEmxnKQ9Ox1KWnxhutuFUZ85AyEFhbnFeEBVQfcAzFu+
         Wf5hz4c4/eN5pkFtbskoDgt7IZ5z3TghGov/8cdda0Nrds9QkAqG0WFBDee1N59PL8cO
         SnvamcbUFRXBNmewAgYSXlg7p+VrgNAORz7WyNHnSubxt70s+oFAliTnoAHsmhcD/h2w
         /snGYGp2DDpM7woCARxLJ+xTE2PUJmDaLk5vn6N6vj+4V484cv5UOIx2xLrTazqiIZW0
         jcRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdzr1m7+NYj+vbSRjWAByi/d+s0Ck+Ry9LrPgWk1VqjBsBNZOxbVZGCrmjsxZ9RDntxmMRz5Wzy29g5A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk6Loo3Tv3CqZasc9QStxTTDvdWt5p4tSnExrRWyHd/NqlxCCx
	fYLmDbWpuLeyR8JCKb3AV4Mw8gmRtSRJhHfzcQa63AVLsPegEPS3vjqe7UFMsmUXgz+UMP0YHbP
	N9SlxyJvI10ITEyR66jK8IGcS7dNP3ks=
X-Gm-Gg: ASbGnct3ATQh8o/pTJGsQCEF6pmQfD7jW2gqO2iR5RPZCRHhAJN37q8s6Zsav2zKF97
	3h1kBPErJqU3h3mG1DkphU0/X5/GJ7evdpKCZO8WoOpEfK1qdp2gjy/9cxCaqvIU8VcR1fDHlyO
	WlTxBus13nEynaVNIHzJ9uTlLZBZ18K1rP5wY4J84Q3puOlMH9RHcdlI6OJjqcUgeMqsHI0tQQg
	XMBgtR/tBhtS6q4c4wJt7zTNpvmZNcH7LB+dgkApBfMtur/m22bAY6gMvIA2bsl0URISlhIiG8G
	FFmL
X-Google-Smtp-Source: AGHT+IGtLr3Nq4rRMA1kWvJ23/JQGdN/w3P80vB49a36eyFlSN2VSyqO5InE1vq6DOeQouP27k8n6K4eGa5Bo1kqhjk=
X-Received: by 2002:a05:620a:450d:b0:8b2:f26e:3226 with SMTP id
 af79cd13be357-8b33d23c358mr4556062185a.2.1764579570507; Mon, 01 Dec 2025
 00:59:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128170442.2988502-1-senozhatsky@chromium.org>
 <20251128170442.2988502-2-senozhatsky@chromium.org> <CAGsJ_4yUAw_tzX7z8iizToMB8SDJPNOhFRZNXva_ae46q5vRwg@mail.gmail.com>
 <hgk3zp5hwlcxo6ufiqasvte3hoksy2wb2kta3fime5rprq4org@xaprrqdabvgh>
In-Reply-To: <hgk3zp5hwlcxo6ufiqasvte3hoksy2wb2kta3fime5rprq4org@xaprrqdabvgh>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 1 Dec 2025 16:59:19 +0800
X-Gm-Features: AWmQ_blOS7Nucw2YNUQvfG1rNrEP4YVyGX1irEsw0vGItmVtTPTGRytfhTT1B2o
Message-ID: <CAGsJ_4z6kSvA+Yzqx=JQ4n3jhQRWn4zYMr364-V2Wjyb2wXE0A@mail.gmail.com>
Subject: Re: [PATCH 1/2] zram: introduce compressed data writeback
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Richard Chang <richardycc@google.com>, 
	Brian Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-block@vger.kernel.org, 
	Minchan Kim <minchan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 11:56=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
[...]
> > > zram stores all written back slots raw, which implies that
> > > during writeback zram first has to decompress slots (except
> > > for ZRAM_HUGE slots, which are raw already).  The problem
> > > with this approach is that not every written back page gets
> > > read back (either via read() or via page-fault), which means
> > > that zram basically wastes CPU cycles and battery decompressing
> > > such slots.  This changes with introduction of decompression
> >
> > If a page is swapped out and never read again, does that actually indic=
ate
> > a memory leak in userspace?
>
> No, it just means that there is no page-fault on that page.  E.g. we
> swapped out an unused browser tab and never come back to it within the
> session: e.g. user closed the tab/app, or logged out of session, or
> rebooted the device, or simply powered off (desktop/laptop).

Thanks, Sergey. That makes sense to me. On Android, users don=E2=80=99t hav=
e a
close button, yet apps can still be OOM-killed; those pages are never
swapped in.

Thanks
Barry
