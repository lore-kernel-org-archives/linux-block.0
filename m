Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1033C3C01
	for <linux-block@vger.kernel.org>; Tue, 14 Apr 2026 12:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776168544; cv=none; b=elBzijqF4Vfj2+EAUWf/1414dH1dEHuMi84SHysYHexM+XbyufSRDjuOAX9Rz2vtqif7ez0rLYzOp5TbkdO/K1QFMnttdlOCphQ2JfVk/Du/GtIt3Ad1bPx4LgmTffmgJuMAPXmMaYHOTRZT5URJQeCxd3h1g4kg/DNoQtZkLmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776168544; c=relaxed/simple;
	bh=2dKC+bNzART0TN1K0cGjO0fj56UlUraZs5ruQszSvF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZXgyz5tpd4SnPwcwDHg/udY3YBc68VvGgj0Fg68TFZiYDRGuETvb0mXwfjuKUwJpnt+bZkHnmfET99i9GE3tGLqkwJz0fqUIRo2ipZXi2NKJ4IJoxFJHn8yffg0jodLrP5mvqkaM94E9m9KiPstXNWK81aOkbqrq740lQtZrLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=Lq7s86bb; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="Lq7s86bb"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488c21c636dso33116745e9.2
        for <linux-block@vger.kernel.org>; Tue, 14 Apr 2026 05:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1776168541; x=1776773341; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2dKC+bNzART0TN1K0cGjO0fj56UlUraZs5ruQszSvF0=;
        b=Lq7s86bbWgl7HZFmbhLkjJUhPeb56Ly+ZSHa9rnH0vktGsXnPUBFcbWV9unFTi+N41
         I6m7HV1kRjYe4+Z5ZK8BMi6hRodRU/Y0FSg6t7WDOw2mhi/Vh1m0m7wh6uaJVFYSa3a2
         SLR/YOOhzs15rcwrW6E4+fSQq6Uqy1AoA5arLwkOObiBpG2/DHB/D7LegUbWGeEONNSx
         1tkBtQ/8qf9Cc38q+vd7w0+l6fTna1g8WF3aC3B/t5SkxNmPVyf28nrlND4x9pAPhjQM
         eUznqhcfHBMfr2bws+bXMB8uhZy3X1eIJexwb8las6g7xHrMysCCB0cy23kxd/QxsQmh
         O3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776168541; x=1776773341;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dKC+bNzART0TN1K0cGjO0fj56UlUraZs5ruQszSvF0=;
        b=stAy/I4BxwIntwPwemCxvkuGEQQQfXQaCiDG2oKWTRARSL7ugQ2b6b6DIxPOBps2tt
         NA1WPP3vuX7y5a3nnuWPE0fXoUnU7wRacfe5Gv1XKvrbTY2FKEzVSiuJxhmFD1A+VLRS
         zaHLVV0CAtmopJK5tnSTdWiMNvNgY20Dz708aF9/QESOq4/fIKLyDJcypd7RNPrI1DsG
         dry74CY2pmQDi2KVV1RUG82kHmWEFmfjhjFfmfrWHDoZgbJ/zMgxyAsS2PAmcOnqGjHF
         pN64Run4OvR7ehgrqrUVW8K0Y3LVpcB4Rv+6jBS3oz8eAZ9ONNYIS87X4BPr3VE6AJVO
         hQhg==
X-Forwarded-Encrypted: i=1; AFNElJ9iW+lgJrb8C9T4TLHBpB92An/4jbH4sLL/cDEpOKllbbCpwyW6rQv1qPedcNCe5rPwQf3MrMKFhSzIaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDMhEfeJ+JZBco/EeIwHZkLxwlQVKYoIV/RC0/oCSzhXYwwxiY
	7jpfOQTg4FrXfHEeHyUiPLjEcNIZpk6rSmyBxwXdKqaBJiAJmHlQDeg3Pwjvf0DnWdY=
X-Gm-Gg: AeBDievf+33SNEfEAS/Jd9zurFsL1W+GZiYDOL7CY/thEfe2BUC3rnX4Z5VehsCzS+Y
	bnSSlAs8+eTAsrutRcZeRPLY3MNH8Ek7AJleuVpRmM4lxBaDUZ4mK4kbkhN2N2X+FBMztUYUAcJ
	0isQmNBnLXtSjT+0ullnLhPD4sx21sMqosYyAMnbWZ15aWQVce7v1YoPBOl+cq1aM1JFUErqC4O
	Ko2NuAI2RCvd5shL8/bQyswwjQzSiPiMzofBROgYNu51Ifk7xjcAOTPIQucyOs2uMg46YTdeVVv
	8Ce5lWND28B//myjHX3yjRpxHmToMF7eTl2JVR+1vS9B9w+UmjCu/HYbsWoaEXNjKS2HlFeUQnE
	WnVdDE+Lu8Dbsm5e6kTo7CtxS7sSXT702oVQHjDV+YroG2aB+ZCQ8RcvD527Tmon1rk+hXZveft
	OAeHuO3oNnwxqz+GP9qrruVM3w0Jav6UAPxcY+BO+Rxiiht5CTXFnk0WPyuNAh9ec3fTMH4lfA4
	G1vyA==
X-Received: by 2002:a05:600c:a11c:b0:487:2671:fb8f with SMTP id 5b1f17b1804b1-488d67fa40fmr168478205e9.8.1776168541312;
        Tue, 14 Apr 2026 05:09:01 -0700 (PDT)
Received: from localhost (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1df12sm106112055e9.4.2026.04.14.05.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 05:09:00 -0700 (PDT)
Date: Tue, 14 Apr 2026 14:08:58 +0200
From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com, 
	linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>, 
	Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 2/4] tools: ynl-gen-c: optionally emit structs and helpers
Message-ID: <ad4ox7ibZoiW-tje@localhost.localdomain>
Mail-Followup-To: Jakub Kicinski <kuba@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org, 
	Lars Ellenberg <lars.ellenberg@linbit.com>, Philipp Reisner <philipp.reisner@linbit.com>, 
	linux-block@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
References: <20260407173356.873887-1-christoph.boehmwalder@linbit.com>
 <20260407173356.873887-3-christoph.boehmwalder@linbit.com>
 <20260412125502.3f8ff576@kernel.org>
 <adzVUdf74CVk2DwJ@localhost.localdomain>
 <20260413104939.5ef4d9dc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260413104939.5ef4d9dc@kernel.org>

On Mon, Apr 13, 2026 at 10:49:39AM -0700, Jakub Kicinski wrote:
>On Mon, 13 Apr 2026 13:48:32 +0200 Christoph Böhmwalder wrote:
>> >Can we just commit the code they output and leave the YNL itself be?
>> >Every single legacy family has some weird quirks the point of YNL
>> >is to get rid of them, not support them all..
>>
>> Fair enough, we could also do that. Though the question then becomes
>> whether we want to keep the YAML spec for the "drbd" family (patch 3 of
>> this series) in Documentation/.
>>
>> I would argue it makes sense to keep it around somewhere so that the old
>> family is somehow documented, but obviously that yaml file won't work
>> with the unmodified generator.
>
>To be clear (correct me if I misunderstood) it looked like we would be
>missing out on "automating" things, so extra work would still need to
>be done in the C code / manually written headers. But pure YNL (eg
>Python or Rust) client _would_ work? They could generate correct
>requests and parse responses, right?

I haven't tested this, but yes, a regular YNL client should work with
this spec. The new flags only influence kernel codegen, so a client
that doesn't know about them could still construct valid messages and
parse responses.

However, if we drop patch 2 completely, the new flags won't be in the
genetlink-legacy schema either, so schema validation would fail when
trying to generate.

>If yes, keeping it makes sense. FWIW all the specs we have for "old"
>networking families (routing etc) also don't replace any kernel code.
>They are purely to enable user space libraries in various languages.
>Whether having broad languages support for drbd or you just have one
>well known user space stack - I dunno.

Well, one of the main motivations for porting the current "drbd" family
to YNL is to get rid of the genl_magic infrastructure. We intend to add
a new modernized "drbd2" family, which will be fully YNL-based from the
start.
But we still need to support the current family via a compat path, and
I would much rather have two YNL-based families than one genl_magic and
one YNL-based. Carrying both sounds like a nightmare.

So the spec proposed in this series would never actually be used to
generate a userspace client, if that's what you're asking. We would
continue to use the current libgenl-based approach, with some userspace
compat shims to make it work with YNL. Then, when "drbd2" comes along,
we could "do things properly".

Might also be worth to mention that we are also experimenting with
Rust-based userspace utilities at the moment, so once we have "drbd2",
there will be a real benefit to having multi-language support.

So I'm fine with whichever route you want to take here, as long as
it enables us to move away from genl_magic.

If we decide to carry the "drbd" spec in-tree, that would then pretty
much only be for documentation purposes. Otherwise there would be
generated code where the spec it was generated from is non-existant,
which may be surprising.

>
>> Maybe keep it, but with a comment at the top that notes that
>> - this family is deprecated and "frozen",
>> - the spec is only for documentation purposes, and
>> - the spec doesn't work with the upstream parser?
>
>The past point needs a clarification, I guess..
