Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00747221FBD
	for <linux-block@vger.kernel.org>; Mon, 13 Apr 2026 20:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776110644; cv=pass; b=TAq0UTL7kicACYDKFlfNOag2dbAozMd30FwxvTlbbkfxZDbzlj7YqVBrRAo7x4rjVWAle23w5aRIaqQYXMnS1015QEZCRUuVi6Q+qDAm+wPSk0qeubVPDayBmKrYt42RBi5jtjCTUWrGiFjl0ILFvuJ01gD+bFkcf0jXa/eAhUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776110644; c=relaxed/simple;
	bh=Hi16Ii4k+nbwcZRrmyAy5J6KxG7QWR0H85R8+r2Ocy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q/ERXSdvyYwIA0F6w7Ar20WgoQebIAj7oDYEkgjGBW00wMkTxvORpF8WxZIjyjG3cw01gzSXa6/QP9j2Z40KH8rP1+/uAN/iYA+WX8WyFUbQPEX2lisEjGoQHVw+SQXtiKlFYZuF1YuB+NMzghkPmJI4N121sDRMBddIqXWtIig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XMKUOrcU; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XMKUOrcU"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12c15414820so3465314c88.0
        for <linux-block@vger.kernel.org>; Mon, 13 Apr 2026 13:04:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776110642; cv=none;
        d=google.com; s=arc-20240605;
        b=FEvjn7ZqcaJJUfICJJDYRSAVr6yYKXhot4l+IIuAoVWq+2y7y0FYETOuopGFUOzXCt
         f5w9amx97VCqhX1TtayJaQ9qGklq35w4lkw/R6izwNVhk8UUJTd9Bvc2NYc8qkKocfoq
         RuJjVYepPFzwSxFtkEALoA7RydlBI0xHqyqx54eSrLLxtT7IwzWrtpQwpp6qJOfwK0iG
         uOkmPFNJEY4c4/yt8ZMXn/SXyAA8ECPjCaFQq3wdkzd3v6s3jMehDBAlZzNQysTzGft4
         BcmPM5dTAwRNFMe6i87nQIVov4a8nK04/JX4LNijQXKh0K+HF9i3hMTat6aokPFsSMc/
         CXzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ERgWLfurQKhgBN1Bmj7S9jkgDQ7gFEaO2fx/24MmK4o=;
        fh=6Je1PF+XVEYtM2idtRMXD63nhXEJ7ImP6OVjavjy5/g=;
        b=F+dvNBtsuRt0iz2QgdLP3DlFHJtmbm2c9biAKaKAuGQ0dpCJOfHh0k0Uup1CQXwvwX
         7JGkq8pQd9Jryo24tVIBBcwWHMt41iKb0ZAzmjf/6ecnZfEkY/V4L5UdeyFWbUcbFyx/
         jKqCQ+SioVHsZgHMA2RmA7rZGqjOGdiYkwpKurl9DT8jeQJRcF81m2SWjsKZ7IC46nzC
         IcCOyhMFz2KrlS//88Qo7J4KRKHzEHDjpvSiW1xkFHJvLpSAcsgdsikm0BrVpGM4rYeN
         RnF3vV97RzHY1JspdxpJtkR0ImWnqMYkC7gdP+R/elVC2rM41NSmjMPkXH3sOs02L3JG
         sQBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776110642; x=1776715442; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ERgWLfurQKhgBN1Bmj7S9jkgDQ7gFEaO2fx/24MmK4o=;
        b=XMKUOrcU2U/R+/E4O34mGmatGQkVO2grDFaiYBK9ZVsmrUvBCCF6aE6TVfo9V4lHoa
         E6fH4OkunivLdc8FpRBIE/pEAV0qjdTVQZGLGazV381rGC8u8g6Mp/qQ2Grga4d9hpRI
         WG1ba77OeivytVwTbJt65M8AWZliw38sEHta73Dw5kv3sn+JQatSIilKyUGnPiQswr5i
         w4yy84C5wc1UF7H6OJWqfRxWMySLY3WmcmiAj8eFkSpZi9amcxZj7ZpQrdXUhg0XLg2T
         bbrbHbH2UQ1JDONfxvho1gKUtrkZu9J+LcPUZjoCUtdbRSxgqJP2nqVXkGU+0XDt7Wo0
         ELbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776110642; x=1776715442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERgWLfurQKhgBN1Bmj7S9jkgDQ7gFEaO2fx/24MmK4o=;
        b=TwuecuJnKji2fWMOsZr2U2A878cHuJDt6ojLWpkcKuFeVPsaUovwTT5AvYl47vSSrg
         ieDR/JJR/SE7VVZztbD2bWdOxDmVl4SWtVeXtnJavKZWaiW7/bzquI3MJRpgelfWlQ8v
         6OB86K1BnwQ6s2+X1pF9lTeeAT5b+L344l/Jxb2VTB91HjFUa5EH+ztGxlESQbJ9sRXH
         nHYIBZgFOe4sDY8IkDxS9L/Tl86O489uJLabKCnR3u49621lFwoFI/CS/Y1ZQruEKeuQ
         Wl2jTA3jAMt+Nxpim55psxrZcM0zRirwqmKpG0qI9F90arlDic5TKjCfIUsBrDVaN9dS
         Vx0Q==
X-Forwarded-Encrypted: i=1; AFNElJ+9dSIQ9ucMhzon3u2H2QIm/HKJa3as97RkSEQo+eoj5Dk08kx9hEiG1Yu1mcZLNAcFXKeJmk0kDT1AOg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6oORDttztsgMyKTn2112GsMRKZl/bdvQ71u/ybC3ztl0F6oWH
	keN4/F11lY4eEDuxH8y3Gn9G6dAfGz6/WxPniehkmf4364SBmD7eRIfrk+dqTcnbnivYo6pxSLP
	T3qkZUg58ZAT60n+U8a4xsUT1EPjYtlEznQisJDmW
X-Gm-Gg: AeBDievP1gcpScpr0pOMGTp58e7ORDcnERbw+gcHW8QZ7c7XCu9uKG8eMgAXX0MIzws
	3iE++9fwYj1tV1MscUZg8jbbjqTH3iTGThLtr4c4FaWmFX2bpECwuHlRcs0I8GaKrvEwcNdVGxu
	ux7FX+GX18qVhmF8/QBJYrAiL8ln91mxptjCdBRUozp6xJJ9W0QSPzp6CgyXgAMnUZPK72gQijG
	bAbM+xiMgrDvR/HrV05+limWU/G26rLJjJVoh1T9W9jqhwZLL7L6k2EzzEucDl8WV9RDdWjv1FI
	JUxc5rorsrr4sZQ268hmO36xA8FOVArBeY6eig0XATGUN+TklQ==
X-Received: by 2002:a05:7022:f016:b0:12a:6abf:ab1c with SMTP id
 a92af1059eb24-12c352e2905mr7308223c88.11.1776110641420; Mon, 13 Apr 2026
 13:04:01 -0700 (PDT)
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
 <2a2c46fb-c934-4ecc-b3cb-4e4114a6d6bf@acm.org>
In-Reply-To: <2a2c46fb-c934-4ecc-b3cb-4e4114a6d6bf@acm.org>
From: Marco Elver <elver@google.com>
Date: Mon, 13 Apr 2026 22:03:25 +0200
X-Gm-Features: AQROBzCNire6U5tUaix9BT8_5isGdBiFTnjvw_NUMHQR5e01kREuENum-3hJoFU
Message-ID: <CANpmjNPzuCUKRPFXZ8ckiCE01kc85xzOiMB05Y9OC9J4Lwi61w@mail.gmail.com>
Subject: Re: [PATCH v3 02/12] block/bdev: Annotate the blk_holder_ops callback invocations
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Damien Le Moal <dlemoal@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Apr 2026 at 18:06, Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 4/12/26 11:00 PM, Marco Elver wrote:
> > For now, that's intended - focus is on getting rid of false positives.
> > Doing what you suggest above would require abusing the attributes to
> > effectively become type qualifiers; that's generally questionable,
> > because that's not what attributes are meant to do (and reworking TSA
> > to provide real type-qualifiers is an intrusion into the type system
> > that's also a hard sell). So for now, I'll try to do the simpler
> > change, and later may look into adding -Wthread-safety specific
> > warnings that points out such mismatches.
>
> Is there agreement that the Linux kernel Clang build shouldn't break, no
> matter what version of Clang is used to build the kernel (ignoring Clang
> bugs)? If so, I think we either need a new macro to annotate function
> pointers or thread-safety checking has to be disabled for Clang versions
> that do not support annotating function pointers.
>
> If I annotate function pointers with __releases() then the following
> error message is reported with a Clang compiler built from the LLVM main
> branch:

Note the function pointer support hasn't been merged yet - waiting for
someone to review my LLVM PR...

> In file included from block/blk-core.c:16:
> In file included from ./include/linux/module.h:20:
> In file included from ./include/linux/elf.h:6:
> In file included from ./arch/x86/include/asm/elf.h:10:
> In file included from ./arch/x86/include/asm/ia32.h:7:
> In file included from ./include/linux/compat.h:17:
> ./include/linux/fs.h:2309:55: error: use of undeclared identifier 'sb'
>   2309 |         void (*kill_sb) (struct super_block *sb)
> __releases(&sb->s_umount);
>        |
>
> How to prevent such error messages? Is adding the capability to the
> Linux kernel to detect whether or not annotating function pointers is
> supported and introducing a new macro for annotating function pointers
> the only solution?
>
> Additionally, the __release() annotations introduced by this patch will
> have to be surrounded by an #ifdef/#endif pair or thread-safety checking
> in the Linux kernel will have to be disabled for Clang versions that do
> not support adding attributes to function pointers.

Either conditionally enabling differently named macros as you suggest,
or simply bumping the Clang compiler version. I think for Context
Analysis specifically we're better off bumping the required compiler
version, because otherwise we end up with a mess of macros we have to
undo later.

I already sent the patch to bump min. Clang to 23 for Context
Analysis: https://lore.kernel.org/all/acqELlVC6vEeEF-W@elver.google.com/
[1]

While for 1-2 new features we might be fine with more macros (as I
initially tried for the multi-arg guarded_by), I think that doesn't
scale if we need to support more versions and even more features. I
think that's also what Peter suggested, and last I checked he's just
waiting for the dev version of Clang 23 to be new enough to take the
above patch [1].

I hope the function pointer support will land in Clang 23 as well
(when it will be released in ~August). So once the function pointer
support lands, we should definitely bump min. Clang version.

While it's not that convenient that Clang 22 will become unsupported
for Context Analysis, I think in the longer term we're better off
(cleaner code, less quirks, easier to maintain). I think we suspected
we'll have to bump the required version sooner than later - but
hopefully Clang 23 is "the one."   ;-)
