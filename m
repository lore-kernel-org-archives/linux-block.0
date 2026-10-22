Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792628394;
	b=GUeKmoMI3j5kAFmRLeqjiTuKnfL3iu3W7ticlBD5bqPQm9INFACTw5uhSFKPFerXKnGs
	 Cd7fElARQ5x+GNyErqM6CSbAylOu9ZbvOG5aMQjKP6XVwZnV83i52DNJTifVo/tZSDQXJ
	 /ZhoytVqG0lFWKbdDwZ0geO38RonyeON2YOavJCngObwl45BM07PHJ7ut6dZz6di6GIjB
	 Dj+nGkhpifi4mqRW6voLHnRGC293zGDlIX838Zku95mh4OkEYMhDy6El80adQ4nUJHAmP
	 +jX9Zasg4u63xVPL8lgghMHiXjhj7cu33/zcFqbFdiGM6ntJE1+0A96K5f9LZNgISLA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792628394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7LKanmub9UijD2PMm7UCSGFp6N4jqIqQ+Weyqyg9TkI=;
	b=csc/qO0VU1KG48BY6LlFBfNHi7H9oLVaYkjxJexHJtXfyFjTjoQzq7yu66JfY8UhrrfW
	 hsIjevS/9k1fEN3JiO6BzV7nAL/GGZf0MCb4wG8L6XalRtPrF37JYBQDbUFou48Y7ja/2
	 oJ6etoIde6BPqN9ORqWt0JpMiC6FlY+8WSMHMwZEUDyQ2uo5pUW4Z5YedD8tBKBaZffg/
	 UIjYfcUrD6KVh0fDgFXCKF+al+ZOQSY1z6OZYm7ZCmAiTsjGub2A+T2Bm7+P2n79T79lD
	 ZjD539Lbyp1QJCZT1mQ69KJrVPPHLItqvc3oNmSlE4aqC3HRZluTvBlHV5qL5NTYo6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V+lMSygD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1E1606A31D
	for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 00:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D1E1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V+lMSygD
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93f1cf92c9eso130123485a.0
        for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 17:19:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792628393; cv=none;
        d=google.com; s=arc-20260327;
        b=FBxxV5KH8/ku+glPyOW43naKTylf2PqZ+CO5b45bOBFrlMMaZBzgGLM2a+IcnyhJXz
         RJgbIjYG5ZCYV/v8rPQq8lcUpIhb4MeT4LaFEFxfztEtQykEGMXtP8gSADQZob08Z121
         EPaqg2llkahz/+5I+Q8Tt4RuS6tzxzJLAw8kjFGjrcqmXQQdpopa4xVkJyymw+eKa/tw
         YAJl7kg/Flr/wlos086h9Qb3WuPPLW/jH6wXc8sCbhVjqIr4qJfvnYoKoeGqiMLmHTQu
         DLQ8L3TllrcPyTw+uT5V3xUNYjyadgygg08iEAK6PyKv/ZU/aQtN1NVUqRmuikUlX33a
         LbRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7LKanmub9UijD2PMm7UCSGFp6N4jqIqQ+Weyqyg9TkI=;
        fh=XYXQ76GqRhukE/kAvYUOy2GPmw8hOYPxqldgTcsAwuQ=;
        b=RDrVAjYaoJnvYtryl9WZlyJfco8x2cTanrgtwfo98r/KbO3wWUGTfy99ds/pHs2vio
         4/uMD4KR6V/EXumL7KFn/K34hx8hh5QP1jpK69khtYoBEHoo2F8aDqI7LF5V2aW1lwx0
         SXFPYJ2j++l3IGMRDt1raeMf8TXhiwYJbzIc0lNeYbUqodvvaGBClNtuvlJw1dTYIS5I
         BUzpnrobLsbsDHp8+s/X8T0u73lPMJffw6XkJ0qIsmN3gcaX+V9STp6Z2Xsz8P8a+4/f
         kZriS87WAPL/8aeTZsiQ3VPw9gvHbh0hw29iNXB5kXAJQJHpEHrsFNjMRb0VlPAsx7kk
         IzGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792628393; x=1793233193; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7LKanmub9UijD2PMm7UCSGFp6N4jqIqQ+Weyqyg9TkI=;
        b=V+lMSygDkioU3le7sBUNHYOSh1pbU06Vegu4Z4f0kX6UdH1zb8BoAi3fVMAhcXHY8r
         +3fHz+b/HFHLPB+1JkaAJmQPNRsaXjdGq6gpExrtGJnrR/Ctn3ZguGmWZj2T4O8q+dpT
         n2Jp0sUKMh+ldq2AJNfcso8qvcewYN3I6UJ8RCr/vQVXM4dgoTbXqY1/zwCYNTG3DbJu
         w0Bn3GGB/ZeQXnwojf2jw7oUNT7UNKEmtnDHoxjj9iGbt2CUWzKw3zpKRo57Apk76967
         bcOi1Kfz1M6AnYOFAs/SpICEraAk19LsJ4nFeV83klqTSJczDQt8n+4KxJAC5TMagdyD
         0Z6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792628393; x=1793233193;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7LKanmub9UijD2PMm7UCSGFp6N4jqIqQ+Weyqyg9TkI=;
        b=P8r/tXrcPhaCtHCBvC+BNt9TZNz2acwDRrocN3egWqvTtaPTdVoPV7HwKxy25/lhUi
         NbI5t3nLK5TyY1gjD7iRi7LS5RkLff46b6irzb6iDVpMSpNs2K/3mduLB4nb8c6lmFKs
         McvL0pqr209/Dc6PTVqOvW6vAlMqaq0JrtbvlDlNgErwnpVlihHAw8Fnd2crRqnhNJm+
         xvDVF26N5qURrtTn4NFQ1sTqxiobt9dtxD+3RtnF3RTetyJyUdcULiUcDQN/Lo/qHXM+
         M47Uk722KPu2a6JAoLoQA2dA6SFsWTKOLd4lfzVzuYX4Kg8UjlQnFOcC4UGKNLVT+06U
         oUEw==
X-Forwarded-Encrypted: i=1; AKwUvBwgICFP6nsoNPVKRjYskCyIXrzGFc14IxriG0Rj6kMl9SCMrlgSA2Yr4GjGecaVEI3qx7S6T2ApiisuWg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKDN6D/3f+wZgOqzRwu5h9jwzP+PnYLvHFpfhDhUJEpe/STLjSi
	KthT+GRhzl5E91TZEjUgP9N9fg4LWl4ic51UJ7J2aVHGL5x28F9ec3/wWnnDmgnfDUnIW4Tu/5b
	kwfxSDJuqclWjuQ/06/EEC6vKVrFZJ/9uJCkQ
X-Gm-Gg: AYBFou1F1lfUYjVroHLnG+QJ1ysRnwm6n48dVkbxyfDTuIAomWx2g/Q8KMu/Apjf0KQ
	RPPR727pLfAyOr8s0hotCCTxyteAHVqCZoobtJIGCtz+fNsQ/3aRnUMVzSNJeIl5+QVGmKlhJWo
	3lIB8l+L36/Dxuq8GtMDAE0sWXsTZTyM5C4JkrH+UfrePn7I+wCFXUq0cc4Lsah1st+k+rowpq3
	IroNrNCDQbYGY7IDE0JoZBTQnUhPC7+YGAAjn5h1asDwjlxIrfQ90XPdJKO8QvaS+A852Uw8GQR
	H65+GLON8daJSS3WtiqyVhIBIzrO8qQ+/B+IvD31kmqqCq1jhzr+0Dl4+5KZ9iG+XXtSveGw/SO
	I9XvJnhouzTEPZbfbz0yjZfLVJ6/kU1btbAr+lw5D8VSh/QAJo3E6GXup5wa4NjfyWSKeapTSDC
	fodjjhm3nE/uoVkjkd+6rl6x/2ErG0oBpITlMck+JwAXbLUt5v
X-Received: by 2002:a05:620a:4505:b0:93f:1dbf:6cf9 with SMTP id
 af79cd13be357-93f57fb7c32mr727310985a.33.1792628392905; Wed, 21 Oct 2026
 17:19:52 -0700 (PDT)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021075322.923-1-hdanton@sina.com> <20261022000822.938-1-hdanton@sina.com>
In-Reply-To: <20261022000822.938-1-hdanton@sina.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 22 Oct 2026 08:19:41 +0800
X-Gm-Features: AclHuK-8o9GQW_xs43Q0Qq_oZJaNk93VFne7SJrKQjUrSEZ5apBJRUVwrXnRIsU
Message-ID: <CAGsJ_4wMQteCGxQ7wxUKP2g96myo91ipF_zedFVVbxKdDrb=bA@mail.gmail.com>
Subject: Re: [PATCH v6 09/13] zram: split zcomp into separate R/W streams
To: Hillf Danton <hdanton@sina.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Brian Geffon <bgeffon@google.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 8:12=E2=80=AFAM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Wed, 21 Oct 2026 15:53:21 +0800 Hillf Danton wrote:
> >On Wed, 21 Oct 2026 13:56:17 +0900 Sergey Senozhatsky wrote:
> >>On (26/10/21 12:23), Hillf Danton wrote:
> >>> On Wed, 21 Oct 2026 11:42:19 +0900 Sergey Senozhatsky wrote:
> >>> > Split struct zcomp_strm into separate compression (Write zcomp_cstr=
m)
> >>> > and decompression (Read zcomp_dstrm) streams, and split zcomp_ops
> >>> > context creation/destruction into create_cctx/destroy_cctx and
> >>> > optional create_dctx/destroy_dctx callbacks.
> >>> >
> >>> > This decouples Read (decompression) and Write (compression) paths s=
o
> >>> > they no longer contend on the same per-CPU stream mutex (Writer vs
> >>> > Reader priority inversion).  Currently, a (low priority) Writer tha=
t
> >>> > holds the stream mutex can be preempted by a (higher priority) Read=
er
> >>> > on the same CPU, which then blocks on that mutex until the Writer g=
ets
> >>> > to run again and releases it, which can take a long time when there
> >>> > are other runnable tasks on that CPU.
> >>> >
> >>> Given lock like mutex, priority inversion happens from Monday to Frid=
ay,
> >>> but I wonder if you are inventing some wheels in 2026 if proxy excuti=
on
> >>> works for you.
> >>
> >> Reader-Writer split is a foundation for further improvements (like
> >> singleton recompression stream and so on).
> >>
> > But that split is not needed at all if PE works, yes?
> >
> Because PE is good at handling complex priority hiarchy. In a simple case=
,
> task1(priority=3D1) is the owner of lock1 with two waiters, task2(priorit=
y=3D2)
> and task3(priority=3D3), while task3 is the owner of lock2 also with two =
waiters,
> task4(priority=3D5) and task5(priority=3D7).
>
> When the number of locks and tasks grows, I have increasing difficulty ev=
en
> describing the lock chain that you in combination with Brian are unable t=
o
> handle. That is why in general PE is prefered over whatever wheels you ca=
n create.
>

I still believe that reducing lock contention is the most correct way
to address  lock
contention.

Proxy execution and other priority-inheritance mechanisms can help in
some cases,
but they also have downsides. For example, allowing a low-priority
task to run at a
high priority can affect other tasks. When many tasks require proxy executi=
on or
priority inheritance, they still compete for the same resources.

So I'd vote for reducing lock contention as the first option. If that
turns out to be
impractical, we can consider priority inheritance.

Best Regards
Barry
