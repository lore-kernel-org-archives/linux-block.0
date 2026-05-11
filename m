Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65DB47AF5D
	for <linux-block@vger.kernel.org>; Mon, 11 May 2026 18:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523343; cv=pass; b=Rd3OUIe1VI5LxPURnkWY3VO8gU9Uh4m2Tru7q0dUOZqdvaMGjQwAYWi+C+KFjtSfXx9YUeunPxerU8P0Ywnc92TO4Wj5t3JWAKSWh9Hj3kEEE3PruxhD+iELzY5d4k7+V8Y9i316MjbXvd7Fnie86sggXYFCE6Prbz/GKLvrZ2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523343; c=relaxed/simple;
	bh=Gq2oFI7fb9cvE5Ox5L24XethX2AXJ0og/l+ryUAg5Xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWJSxuJhrc6R2GSs6wXY0ehjjo1tbSe8pHVuUU1o8sePTX+eKoRUUdGBUIrDFWPWvfYdabk8Ol/TQEKVIYZQhrxOf1EfhSXrmEO3j2xmOPF8TzOJWhXG3OjhorkpiDo51kQC8Z5h8U+QuWD0ax/1wU7QsdSSbETq8XQhjOXLdM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ri/N4RpS; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ri/N4RpS"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-132d1b2519eso2319442c88.0
        for <linux-block@vger.kernel.org>; Mon, 11 May 2026 11:15:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778523341; cv=none;
        d=google.com; s=arc-20240605;
        b=M1fuQIcBUiPcg6kv/2Y3puzg85CRx5Vnf01bUryQTUsCg1wSNRSTddh3pP2kBhqHiu
         qMuzvQGXqEbhZm6aaX7SPKLJrM+Uc/B2zFOKCaFa5nKOPBMDw8dWVw6y36eVMxtls5dL
         lXOmfjJoJAMXW+fwhYtWelErPD4oX4ISwidJoyxeSDOOhrXhnNZqqXrn6zmzsz+1ABAl
         fC4LiFJmVJdqhU/pfFEsXdEXg9PyYOtKq0cjRFBiGBHVnMKgo21WR0Yjm+6ThE3dkh3f
         QPQcXPK6kn0tqM6PKZpBbbBOeBveSkzj8aSsTbU6170V87IloW99ZjkjuKBmWZMS+Lg3
         9Y8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Gq2oFI7fb9cvE5Ox5L24XethX2AXJ0og/l+ryUAg5Xw=;
        fh=ViS+U0XSm9VrJ40hsLN7BGhztb1Ozd2wap2dS7FknJ4=;
        b=Na5C1nhWHBFvIoXzlG+PHoM6tQ/B68sggt3rDfSgshIZd1NCZDsGmhjlBOcIfQ+hkP
         RJg4QShX4vcCXxphetjQGoqr9eyBOiZVBExK9qZ3Y+Arz404Wyo1E4eNxr5HQG+ABTGu
         V2oe9gpBSWSlYWjLgW8JE45D9dnfzjit31ZKiNFTXaOM4bER8+omDbp53lpBscKiCNL2
         QEV5tqbOzWFv1phwk+UrYvR+gpcNzQoQ037FvNYsD5Rqy1anJLMJSIgKnGw+8xTY2VP/
         c2ppCZ6ylcOpnlE8sQtGRFpdvPw2s7yNPxqcoT567xcSXpz32xaxVDzQ9CWi2NPmSlQn
         a4vA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778523341; x=1779128141; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gq2oFI7fb9cvE5Ox5L24XethX2AXJ0og/l+ryUAg5Xw=;
        b=Ri/N4RpSfFZ6LsHcPouESUv9MOkoBI4Vfi7jDvfzJwhpUpXAM0hL4iAsQ0Qj4gmkj8
         e6solSLImnMAD+P8x2fE9bmRgIYpBwFFp06p0/yOWbTqbyIEHcJJ6usz6dReeGbQT42r
         suH3/0/NPL+nfhPLbr5R0zp9egXx6oulOLA35GbRi2J2XTGdoOtGRgS9C13q4vLAGhV/
         bZ83SxAIn/f6/3t1x+RYD5FuxbqyklSgN0N3bsobMM08eM6q87H2SCPl7wBNdHKg+4F0
         PcWXVPy/Gxsz6xWlfiPZHQrnJUg7XOADxsAaLWIeDGz57TQAffloixqkjkDOBDkYXJZ6
         UBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778523341; x=1779128141;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gq2oFI7fb9cvE5Ox5L24XethX2AXJ0og/l+ryUAg5Xw=;
        b=tWgnXEMUG38Lx99kGuV7nEHZm7TuKPRE104oGdQftwTh6KREeHD+YkqC6Fr2Dc/pM1
         mDiFmwc5evrwf1hC9svjWfktLqegYgzPaszk8nWb4LvpBCjpCAriZsjXWv+71aCh/Et2
         t1Dd6saO8L8hgR9fqfN3ZkN2BpaQdhSSj6P+g6YuXFH45Vg7feX7aESL7B5InXyPRQrq
         hSJkUJnwMChgHBrRliJ6NKEjy52MxFSD1o15hbX+j77a+xvHYJXV/UkGmHS+nSu2c5L+
         ZqWAfFJhkIIKGM0RhNHp0Y822HKd/UA91ubmNfedDDgCccNkNK+nSnx187brgtQ+OL2H
         kG7A==
X-Forwarded-Encrypted: i=1; AFNElJ/lZY6y2g7nSc4hqzIYtE9kl+ZZdvCOcb6SFbMr8RmEW86jCqWikS4RWgx8SUdaDKBV474B+YENkO/gDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSLNaU1AuTqlli9O1J42QKd1IK/mlEhOd13F5LkYvwpqhOh37f
	tWh7vBLCZKUd/AMeVbGP1WSy5aj78ou10+wIZ/JeAxv4dfYq7ROe5gnYcAbKrCTnD7tUUTzMZNc
	pS9G1U4J6f84QM+0XDAdFKnQj2ruKZxOumwMJPu7g
X-Gm-Gg: Acq92OHtln3q3CX5JU0dI1Wxuvos7vAwDoyLOzjJKuTbYC9Q97KkrTm0eyOW8CjPEff
	TJsKQWgHoM0F7kuBKdC77YlmmQ/0Cahf2j/h/NlnRfm7CHc4XO0lgHbTC2miwtFzO1vIdLihyta
	XFuKOHPemYNbB068MMLh5cZ83Sq1j/CR/929dtdPvar6kp9orddgv/7U9lZmDoQvh7JoE2o2fjI
	m6WC6xVEmCxpsnuAj841p68QmDRN7ZHYgHQWxfPzYx6EbuBsCAj9vIvI7FJUF1wgAhVE/2HkkvW
	/o+4rP+PLNXhH+o+dGnpf2c1Dyk7MMauHvlQeQ3AIfyVWnT7yw==
X-Received: by 2002:a05:7022:2511:b0:12a:b39a:339f with SMTP id
 a92af1059eb24-1319cd2660fmr12214055c88.21.1778523340163; Mon, 11 May 2026
 11:15:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402183950.3626956-1-bvanassche@acm.org> <20260402183950.3626956-3-bvanassche@acm.org>
 <20260409064221.GA8378@lst.de> <CANpmjNMUv5n2VrWGPBOzGg7-r6gf3hH6ZoJYtRsrntY8+_=fQg@mail.gmail.com>
 <2e09806a-d5fe-4581-8024-906be7dca4de@acm.org> <CANpmjNPJPz7qruFw8S=4qoF32snPW-RYrd_BZK6skR_y86CUZg@mail.gmail.com>
 <08078df0-d3e6-4860-b22b-937035d45857@acm.org> <CANpmjNONpHgSzavkbqdbM2N0oCtt2_2+UqBCMWjMaWEcWrCy4w@mail.gmail.com>
 <2a2c46fb-c934-4ecc-b3cb-4e4114a6d6bf@acm.org> <CANpmjNPzuCUKRPFXZ8ckiCE01kc85xzOiMB05Y9OC9J4Lwi61w@mail.gmail.com>
 <CANpmjNM6nERjfhNBE=D93E+HMaQtJWyi9s2qHmLWrmtBFt05vg@mail.gmail.com> <0b5bcac4-f58d-4cb0-9d58-fef74238edb8@acm.org>
In-Reply-To: <0b5bcac4-f58d-4cb0-9d58-fef74238edb8@acm.org>
From: Marco Elver <elver@google.com>
Date: Mon, 11 May 2026 20:15:02 +0200
X-Gm-Features: AVHnY4LV4Jvva6FrTXljUA-Ri8JDZJ0bhywCKET3zioGRo852eRBjSeQuKq3HEE
Message-ID: <CANpmjNPduiwLHUtT=woSoVj07-CJjbTyCpsznt-Hmg6SaV+T6w@mail.gmail.com>
Subject: Re: [PATCH v3 02/12] block/bdev: Annotate the blk_holder_ops callback invocations
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Damien Le Moal <dlemoal@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 May 2026 at 18:37, Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 5/10/26 11:00 PM, Marco Elver wrote:
> > Clang 23 will have function pointer support:
> > https://github.com/llvm/llvm-project/commit/d1e84bb9ad3b6a844cd902cf70e2764cb8126979
>
> Thanks Marco for having implemented function pointer support in Clang!
>
> As you may already have noticed a new version of this patch series has
> been posted that relies on this feature.

Nice.

> Combining -Wthread-safety with
> annotating function pointers with older versions of Clang results in a
> build error. Should a test be added to the kernel build such that
> config WARN_CONTEXT_ANALYSIS can only be enabled if Clang supports
> annotating function pointers?

Ultimately, we'll be bumping the min. version:
https://lore.kernel.org/all/acqELlVC6vEeEF-W@elver.google.com/

Not sure when Peter wanted to pull that in - I believe we wanted to
wait until distros have a reasonably up-to-date Clang 23-dev version
in their repos.

For the time being, you could do this in the subsystems that need it:

CONTEXT_ANALYSIS := $(call clang-min-version, 230000)

... untested though, so please check it works.
