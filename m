Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43A9301476
	for <linux-block@vger.kernel.org>; Fri, 22 Aug 2025 13:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870419; cv=none; b=ndqgzjGhKSw7vQVBGk6nL8TN5QyDL7Dm46VUXkdRFoTpUhlyGflv1TNarAbN0lYtsOFmy0Z8QrONnK6ZpI+twmjXXhOfCLtZu3KpQDAB8gKy7ESxODc4Ehgv3sZ0w63Cm0CcoM30fs2mLLch/PDS8JHygzhsIQtp7GTQWpOpGBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870419; c=relaxed/simple;
	bh=APQoGb7oJHGZ6Mj01fq5MbAELxwQW2xj4Pe4Rxnr6cA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C5BkpPmqzH2KGtnUDxTRqQIW7MP8YDgXeTm8MZPNjp5WVjDndW4WPh148tjgt4I/c7ALD8QBFDBGiEuvxoPNoYxj+Y+yXrY7OaIpxDBgYEqybcThkUUiXHftFvvlYTa/+4+PKGE8qZuCQ47j/oPv2Fa/5DL4cZiECSgKoEG/Qn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cfqqVNDA; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cfqqVNDA"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb78fb04cso278268266b.1
        for <linux-block@vger.kernel.org>; Fri, 22 Aug 2025 06:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1755870415; x=1756475215; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NRu/0FoVw+bU0VwjyXzuUF8CXZhxspV/ZyS4JSE6Hqs=;
        b=cfqqVNDApQweNVxsxTjcec1rnyC2gDXuHW1AhM+piZbNswOinrpjYBqWWmU0mvna3f
         91vNBZWHQHi2Bj5r74DvRUFae28DY9O5qfTKrdwohX6QerdjMJtbeIYS9qMMt54m7H81
         LLhFzh/pugcCU8toxdu+jGQw7fNRuRcNY18xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755870415; x=1756475215;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NRu/0FoVw+bU0VwjyXzuUF8CXZhxspV/ZyS4JSE6Hqs=;
        b=rIJINvLJISEmh43tY3EJoStGwNirzOhQL9qKifR/mcMmUvEDxAyzdo0vhf0Y1RLBc4
         M2NBqTsweWDbsOFbQWo+a88tYonil/zsnqyZqZCWDEhOX4+u0/xkZKmuKz1hvpwrjVTv
         MsAw1pww3abBjjH9vOMHBCeBKF1pUoyNcQy7ye32hfDmulSV0Wl4MBScd+43YcAlqwnE
         Hdxm7CBkYvFNmPb82LasB5WgNOA1/MUjh9hBQ9ShNvRkY+JBpDEeZUI3fyJzqYoLcivG
         OqoNpGjyLLsRNfYRwMUOADP5x27hJrVeshEadsNb2i9DOOlMRWIqpSy6cBzPoduhYdvH
         sCBw==
X-Forwarded-Encrypted: i=1; AJvYcCUUyIi0FyILDD0oLtoCXqTi5Gqz05ggNexfCqRtfDZyhMlrogw0wkbiFmIvNF67m/OvrAc4pvugV1CWSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPXuTpKED9KWkLzKnbAf/lZvTo9nTSp45zFPQMM8SeqeSXz2lU
	MUUr2/AjxTZHDDC9jeR1qZ6dZmMCMl04k0CRSJZuN/n40y0t9aoxfcMXUpvCGEwn7b41A7Hs30W
	9GeNlYag=
X-Gm-Gg: ASbGncuH2ImuxE/WOirsVsIBEbIEi7H3fweX3D/tBASGskF5Sev17tzlyvurNpAeLp+
	gYeFPMxLhyYU7Q4Tz5OTALBNPArsOG31mzwz6aOk/+GQM1kCA0NSEKcdln5IeFf4Y+Zs1pXulqw
	mAFbT35TzQfGgJ1jgcdEBlTLAUQbmJeAvAnF1UGz72wwYBGMtP0Nx+UKAQcJgErUOHL6Whrca9f
	8lm9LqIs3sLXxDqwcSFtrp4TKUJYP+oC2bDF92RKuDPxLVcOLTXrTjQdnBpTTwnxFKy9xKJl9Zn
	c4wzYQt5B1ZPeQbby06cBTFOIUSVUCsPeX1wZ7whksZFZJR74U7tu4C4sPf1ZK7WiupN75LwX9s
	R56GW2IO1vFAAORBy0Dcs72h5dbqyAWz78TZaicWUx4Rf2AinXZW4BoMCVx+dTEdCyKPN7XpBoP
	F4nvJ5pI8=
X-Google-Smtp-Source: AGHT+IHDhqBQmYarPKU+pjZ9XcGXPo4JGNFU7vWSUYw4y7qOL3JUVVlIlFymwnQTzV3MPPwbdRIDTA==
X-Received: by 2002:a17:907:980b:b0:ad8:9997:aa76 with SMTP id a640c23a62f3a-afe295c0defmr257298466b.37.1755870415153;
        Fri, 22 Aug 2025 06:46:55 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe0b8d12e7sm357567366b.98.2025.08.22.06.46.54
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 06:46:55 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6188b5b1f1cso3092583a12.0
        for <linux-block@vger.kernel.org>; Fri, 22 Aug 2025 06:46:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU33lA7LvSFjayVHtv6QNtIhOKhmfh5/j//iRld9hmUtHD/CDv3MOVeG6GGw6JASNz4yPTFfdPMaL7kRw==@vger.kernel.org
X-Received: by 2002:a05:6402:5110:b0:615:6481:d1c with SMTP id
 4fb4d7f45d1cf-61c1b450840mr2274281a12.1.1755870414406; Fri, 22 Aug 2025
 06:46:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755854833.git.christophe.leroy@csgroup.eu> <82b9c88e63a6f1f5926e39471364168b345d84cc.1755854833.git.christophe.leroy@csgroup.eu>
In-Reply-To: <82b9c88e63a6f1f5926e39471364168b345d84cc.1755854833.git.christophe.leroy@csgroup.eu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Aug 2025 09:46:37 -0400
X-Gmail-Original-Message-ID: <CAHk-=whKeVCEtR2mQJQjT2ndSOXGDdb+L0=WoVUQUGumm88VpA@mail.gmail.com>
X-Gm-Features: Ac12FXyg7aT4BFeJsiyaeWdfrE2FPhwu5xUJIJ1D8_vj4L1z_hVeZFuzgKfsNNk
Message-ID: <CAHk-=whKeVCEtR2mQJQjT2ndSOXGDdb+L0=WoVUQUGumm88VpA@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] uaccess: Add speculation barrier to copy_from_user_iter()
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	Andre Almeida <andrealmeid@igalia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Laight <david.laight.linux@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Aug 2025 at 05:58, Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> The results of "access_ok()" can be mis-speculated.  The result is that
> you can end speculatively:
>
>         if (access_ok(from, size))
>                 // Right here

I actually think that we should probably just make access_ok() itself do this.

We don't have *that* many users since we have been de-emphasizing the
"check ahead of time" model, and any that are performance-critical can
these days be turned into masked addresses.

As it is, now we're in the situation that careful places - like
_inline_copy_from_user(), and with your patch  copy_from_user_iter() -
do maybe wethis by hand and are ugly as a result, and lazy and
probably incorrect places don't do it at all.

That said, I don't object to this patch and maybe we should do that
access_ok() change later and independently of any powerpc work.

                 Linus
