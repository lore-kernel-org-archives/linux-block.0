Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793123121;
	b=2D9xgwb0QeN2QJfLC2gSdLnP2DsfSUZfbVzkTq0E1Cmnp2+LfB2agihQqt86GKcDQJ4H
	 0BQLaYqvtohus3n/fg096MlDT0sjXo6PKDVnp9hHl4xWwxh21Zf0ZAzwjLtp6HTFJzLkw
	 NuW6VFlamc0e0hYUmNGwzXyBZXtzjH4RMxQsetaS+RgGOfNFLukUjTRAzoLt/rAIvfNUq
	 5pAQwBE2AOWYL276zhuoPH0XnmD3R5UqBa1iQ1edv0KXZtd+GVbXV/JghcA4luoJHh5r/
	 cEWXc92z7f0zQ7nwmEmM6LUCC5XV8gOhCOQaa1Cy/aX6LFCGDsj5N0TkI1ET9t5eWFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123121;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=IX+G9SOnBii3qZVcpbPFnOSsikTG2tcrehuOi4LapMY=;
	b=GFPObvOPWenTSdUdyYiXHcYY8qnfBHrB3zVxrJhLroV3Sn7y8wPoXNvLWP5J5qLFvaTG
	 t012W/Jo8509deSFHjLxeRQ7dwt348+eCHsRCr19NSmCu5iDCQNiNrEz0s24Q+h6MRjet
	 Xatx18FErger8UqTdlR2ZmJEAs6PEkfuVByU3Cva5LhV9DqJNEqfb8KdzlTP83UsUn6UT
	 UOc2zVs2fDOanlC60pK69uJJMzjxsl6izTrXjTMFK48Nl3EeP0gLeg053Xm8f42d1Z9Qe
	 DWBdXkTQIZBjg16czMB2D/zLG8qXfoHhWJzaBORu+Xp7CJMxVRuFz7OdM1RcJBHw5ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=WphOdIGY;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D67606A31A
	for <linux-block@vger.kernel.org>; Tue, 27 Oct 2026 17:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71D67606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=WphOdIGY
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e9995ce866so603725ad.0
        for <linux-block@vger.kernel.org>; Tue, 27 Oct 2026 10:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793123120; x=1793727920; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IX+G9SOnBii3qZVcpbPFnOSsikTG2tcrehuOi4LapMY=;
        b=WphOdIGYX/UvFVCsOGsOEjKfuXa3eOMnjlE/oH98dDJE5AQjaP4vNkgndW6hGi8Qni
         QZdRvdRUJLLZxdWp+Zl5qKI6/61I00l5XO0r5L6IQHA+KIM/sH0yAGXaGnzJZWkBHyDV
         Ex06G3DXIJK4/zKiaDdSjjPRmN2knZrMQtV28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793123120; x=1793727920;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IX+G9SOnBii3qZVcpbPFnOSsikTG2tcrehuOi4LapMY=;
        b=B7yQbJhaLJVv6/0YP39Mwz/jPj6FYjf9Di90S6zTtnBpdaCxzMs54YrO71jOnMpSa0
         GIFhy0vJLkbYU5pj8/YYE9RX7idnn6ymwTHUH4O2LKiS3tq8vRF/wI9aWyORFuWKYZUf
         /yf/iMj3DLatKxIZ/SsDKqWHCgMRmbNj6faa+s5v1pNpOsAfXDdgyt1tHzvVvp46+k7J
         83dnqnhxS9LJK1Aellr1CbhFOAsLWxP3cHzFhKj/aaXzu4lj1DIItRapGik07KiyHCRW
         rKrR0GeOryoiZD7VxCHCvBFrmatWtGLNlJRkwVDLmuyzA8irTmF57qgVEMBVDqtS5udf
         OtBQ==
X-Forwarded-Encrypted: i=1; AKwUvBz2mfz5TGOBJYuPFDQYQo0Q5cjl9un6JVxsU5RR1yTFWsi4RMNrzW+l7AUnrtcXnVNnDdPjTH5+g/TPoQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJOFl9fPfdNhhxoApsVju2WtKxu1XgBeXwFAww6QBmRakLedNBH
	K/iujjXvDEvTVMtfx+KuxlWdCExQFofXcwBAM64BtQ0S6mmEu2iywe25BRocOQ8p4R24BKJk6RV
	IDr5dNNqmmQ==
X-Gm-Gg: AYBFou2e3LIPymmuKNgH1u5eH+XviZFW3OJ9460jCQanakBF8uxwYqjG91yg9pFzHsa
	tHV/7IFicg2+NmpvyoINyFCFDsE3m0avtFSybGcpi3R7JMom245sB9Y+3ID46aYJm0rkBeJZzg4
	bhQloSiOXcoPeF+kS2oyjYUQbWGajCZ3a6QxvomQc3731Hua1++lkp8NIYKZqHVxjevpeApUbRL
	qU+A12uggMBc7ZaAyizeBRxBEqOXln+fxLjCsrJk/3wzyd3PF/y+rKRY4mMHDm0WEXWL7/+pDhe
	REWsmndOvDf2JS4k3mS11NJkBZlKMn849KicYKwW0rKu8RV8PoOO/KRTYKHCf+mW8H2E/Pmnpeu
	B6jv9at2+i0fLQVN2mAU5lCcrmdqDdS4RKrhSB+qR3YCkMD+nc44lVagXx0NkgFC+loQPjGa530
	TJ5EXBNh5QMvZtEwTtTShiuScz3YA7gkjt/r7h6MzIjvJQ155EcX8/xhRBPSEO0D07/3ZAbhpNe
	txrtLn1DClsi8q5fM88icRf9O3jKsa95xoFudxTu5lMUoL9+IHNKawlkU07q2psJ2LyGkH9Sp1c
	umknRoC/M8OK9zdsmnioEOgEkGioQlesaQ==
X-Received: by 2002:a17:90b:5644:b0:3ab:d45c:59da with SMTP id 98e67ed59e1d1-3adeafd21a8mr8806615a91.40.1793123119759;
        Tue, 27 Oct 2026 10:45:19 -0700 (PDT)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com. [209.85.214.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae40456f65sm4803759a91.13.2026.10.27.10.45.18
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 10:45:19 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e9995ce866so603355ad.0
        for <linux-block@vger.kernel.org>; Tue, 27 Oct 2026 10:45:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzj701Cmp5ZrHUWIyLZmHYOvR++Lh8NQLtNEdyc3J3t+MEwnsYLA2sltzy1/5LcfdOdIcK0GVWKxzcbFQ==@vger.kernel.org
X-Received: by 2002:a17:90b:58e8:b0:3ac:9706:7739 with SMTP id
 98e67ed59e1d1-3adead57cf0mr9005664a91.17.1793123118449; Tue, 27 Oct 2026
 10:45:18 -0700 (PDT)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <b97140d2-df87-4cdf-9f0b-d5ca404d50da@kernel.dk>
In-Reply-To: <b97140d2-df87-4cdf-9f0b-d5ca404d50da@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 27 Oct 2026 07:45:00 -1000
X-Gmail-Original-Message-ID: <CAHk-=whLg-od86aV4HU6yC8EKh6zsVWyyvWVOcrVshvxoQ9dAw@mail.gmail.com>
X-Gm-Features: AclHuK8pwUjVyitH5NtHnOssDqiuKTG-rCghbVipSDMu8Vd4XNbNK-Rtknr7Zew
Message-ID: <CAHk-=whLg-od86aV4HU6yC8EKh6zsVWyyvWVOcrVshvxoQ9dAw@mail.gmail.com>
Subject: Re: [GIT PULL] io_uring dma-buf support for 7.4
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring <io-uring@vger.kernel.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 25 Oct 2026 at 03:30, Jens Axboe <axboe@kernel.dk> wrote:
>
> This adds native dma-buf support to the I/O path

So while doing the trivial resolution, and looking at the code, I note
that blkdev_buffered_write() grew a

    inode_lock_shared
    ..
    inode_unlock_shared

in it. But looking at the two call sites (in blkdev_write_iter()),
_one_ of them already has that inode_lock_shared() on what seems to be
the exact same inode (bdev_file_inode(iocb->ki_filp))

These all went through you in the original block pull:

  1b1be9ea4e34 block: take the inode lock for buffered write fallback
  2fec4fd97cc3 block: take i_rwsem for the direct I/O write fallback

am I missing something? That nested locking looks not just
unnecessary, it looks like deadlock city. I'm surprised lockdep hasn't
complained, but I'm assuming hardly anybody actually uses this path.

                 Linus
