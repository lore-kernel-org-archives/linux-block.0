Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658AA1D88A6
	for <linux-block@vger.kernel.org>; Thu,  2 Oct 2025 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759423780; cv=none; b=fClEO84ERdqoleFFtDkHDClsXU2egDDLpJQJeHT1BYKBHBPNVQMjE5ixjUYki7gcSCTs3AyWsyJnKsyUINIx7CZK9cLBmPXaBOOQ8trhxhc9oEi8tNlQDuL2rcj9qXDYtBIl8In1xqOb/zbQRp8fgyEsoC2dla2qxD5Gyw6QpHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759423780; c=relaxed/simple;
	bh=GPNKqk2IjCezt+iOiIGHZBvYwRYM9eI/at8SyT0aJvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dhv2SKs4HyGzo+oEFUHNXUsR+vUG8XzbC1R+GybU88owL9R3zUNCMNNumjA6SEcwYKmyq//3us+wP+/B87zF2MKuv6UhHyJYJ2BYRhyZtZWoQO17yH/w8SNls7sHg6yMwivz2KUJRNf21V8Q/e126ASAPuzDkujaDSzZA/FoC4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gUhrz9Ub; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gUhrz9Ub"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3e25a4bfd5so249113966b.2
        for <linux-block@vger.kernel.org>; Thu, 02 Oct 2025 09:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759423776; x=1760028576; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ri4QyfvFryudbRTr4zjJak2/cwqBuXGVPepccBH1HNc=;
        b=gUhrz9UbfOdDJBrCyPUJRPx3zM+SAT9D9jE3dSCVTyDEIYB9tZXsih8O+cyEc5sYgc
         jgpoIoviizQHxyH5NsX1UJ/NSPFTlx6mkMb3ecJKBYL2cWz1egAfZfbGm0KJyQ+JNQLS
         umkEo4+Z8Urgdew7nbyf3I4qhSkqPWeFuYN6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759423776; x=1760028576;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ri4QyfvFryudbRTr4zjJak2/cwqBuXGVPepccBH1HNc=;
        b=sCbWcZJagKbjOHt8ItRh9bsJpnpfjlcVLLLZyqjhZfHJHCZVv5ruJr/jjePZNJfIXN
         LAWPkD25Qp56aICRRQWA7t20NCj4UfEOgqLsbmc0aLPnlkIiyZ8WkFKczoivOsvl6Ymt
         mSCMRzyLMr1uiw0fEMo7gAPeMcH0ezgDdp7qwwWnRzTU86PZ5ypp1lzddUZBd4Wi5uTf
         PtS7HBLf8hQsz+FLLxuljExCAx0JQCR/2HTvE2QjFfFqT8NNQE+iIT+9MDVXM5j25VJq
         wrN20WJUpANP/ff91ccGXBPjUH8PXxNKuh9MA8d3H/gT+L/tC3Sq/3WqXdpR0fS1KCkr
         3XAA==
X-Forwarded-Encrypted: i=1; AJvYcCXItTvnrAt874oVRNrpQQVE1S8QKvoaLvKHq15WnUk/XVup4713sgfwp3ZYN1iFVlMaXKW/4SV5VJdilA==@vger.kernel.org
X-Gm-Message-State: AOJu0YziXqtjG238c7V6KceU1jAHWiTcqvA1PrsiV95CxuIggvu8JYfE
	jAc6OLVHYeWl5bmXUoArc1vnrhiR9d9/ByHcy+bL53IEXrDdrLS2fyEBPzSPuyMKuLGpWhCah2G
	sYbnK3ew=
X-Gm-Gg: ASbGncsuSYQ6nEredREPpFL0ya9pJrI9wlSQ0M2N3//UDAs1eO2gtW7iCbOFPsvEry3
	aea/lCsOaPxlYeVZgns+ZIiWVhjG7nol/ky4WCl7F+03K6Ww0ljEEMFGWLDQ+rFqVbyNu7VA0gz
	+NWKwIl9ifw5FaPF7ScqjJ/NYWF+EM2Bhiy2ZJtPmCv9CdnDjm+r0FvsMGpFxnTNKnZiDU4SDRJ
	zPISNzd1ay+w0e/t1IVhjadyKtVAG9laN6b5muZsSPDLsudYfFHsXP4ZqoJTFgb4HGoYUQec/52
	V13aiveZonXyXIuMLgwDG2gFlzpecXxx5jvBup0Kkd0VWbTYXGsz2zKUciQSq3YtYtn/hM6NKro
	O5kVAcp/FS0ewP+pTJHTUML4FKsWy15FlVZF6RabX31C3K+OddqlSR0DY66YaOPdtQGBEvnE85w
	Pd1PGKz15q1kbH149bQUtU
X-Google-Smtp-Source: AGHT+IFrppRavRQceyNtqHwqt7OVwsyqrbVs9x3nFQa/UU0FoP/I2HPlKfrF09Hrcrtsp9s/r+E0SA==
X-Received: by 2002:a17:907:7f25:b0:af9:eace:8a52 with SMTP id a640c23a62f3a-b49c3f7ed2amr12491766b.50.1759423776473;
        Thu, 02 Oct 2025 09:49:36 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b36fsm238133066b.62.2025.10.02.09.49.34
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 09:49:35 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3f5e0e2bf7so244963266b.3
        for <linux-block@vger.kernel.org>; Thu, 02 Oct 2025 09:49:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUsQGF/cAL/vPVn3Ak9ECfOTS8rPyUorawLV2HfZ3JRqH5IEcTWOEIqGLMNXKivSgn+YOTCGQsuSWzYSA==@vger.kernel.org
X-Received: by 2002:a17:906:6a25:b0:b3e:c7d5:4cc2 with SMTP id
 a640c23a62f3a-b49c39360f6mr14187866b.38.1759423774528; Thu, 02 Oct 2025
 09:49:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730074614.2537382-1-nilay@linux.ibm.com> <20250730074614.2537382-3-nilay@linux.ibm.com>
 <25a87311-70fd-4248-86e4-dd5fecf6cc99@gmail.com> <bfba2ef9-ecb7-4917-a7db-01b252d7be04@gmail.com>
 <05b105b8-1382-4ef3-aaaa-51b7b1927036@linux.ibm.com> <1b952f48-2808-4da8-ada2-84a62ae1b124@kernel.dk>
In-Reply-To: <1b952f48-2808-4da8-ada2-84a62ae1b124@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 2 Oct 2025 09:49:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjf1HX1WwREHPs7V_1Hg_54sqOVSr9rNObudEpT9VgQDw@mail.gmail.com>
X-Gm-Features: AS18NWAX_XbsCSn1cSvTBt8Jd93mNINtxqs7sE9J-usQvnLgAAKgdff6fAuW3Hk
Message-ID: <CAHk-=wjf1HX1WwREHPs7V_1Hg_54sqOVSr9rNObudEpT9VgQDw@mail.gmail.com>
Subject: Re: [6.16.9 / 6.17.0 PANIC REGRESSION] block: fix lockdep warning
 caused by lock dependency in elv_iosched_store
To: Jens Axboe <axboe@kernel.dk>
Cc: Nilay Shroff <nilay@linux.ibm.com>, Kyle Sanderson <kyle.leet@gmail.com>, 
	linux-block@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, hch@lst.de, 
	ming.lei@redhat.com, hare@suse.de, sth@linux.ibm.com, gjoyce@ibm.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Oct 2025 at 08:58, Jens Axboe <axboe@kernel.dk> wrote:
>
> Sorry missed thit - yes that should be enough, and agree we should get
> it into stable. Still waiting on Linus to actually pull my trees though,
> so we'll have to wait for that to happen first.

Literally next in my queue, so that will happen in minutes..

           Linus
