Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EFB304BAF
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 13:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762436584; cv=none; b=XSoDss5RdFMFIdQQRJYvknUD0qr5Ki9jjb5Ff9IAjGFGJQnpnQFe705maPVttNOf4vtoMRCsBof8WkkSTB58TmODUo1mKC438w1/A3fNDCdnyREp1OPIYYmXh9aY0hV8stBL+H4lp+itv/rOUqPau8qdMaRhN6eoGn1+xUfKUeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762436584; c=relaxed/simple;
	bh=yM08vXYgeS+2QUmB9lU/TpbxKmTJ2bayDxKCYSgsODA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j5m5rz/Q84bLAHwhwlVNEzwO7bSo+ckw/jMCi/boEwMr121950nQND3G1X6sT1o508kA0AYjlf/4P57m9jM2IUH2uGopIDbzfvGOkggUkuaKhNSpMA1dRyGsm4bN80vfkniklmdp1lCeLqGZ1TfIEsWmna9fiZbVRxkCmZXBbOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9x5nJ4A; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9x5nJ4A"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-429eb7fafc7so693590f8f.2
        for <linux-block@vger.kernel.org>; Thu, 06 Nov 2025 05:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762436581; x=1763041381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4DaQeGVyB05KYzPS0LHKvWlhb6TnpUA8LWnzGCb6LE=;
        b=l9x5nJ4AF4qOQZd2QseTvTvF/rCgyyJIN6Qv2MsWPmsPJ5d451JTrINWDA8Q80ZAzI
         jyAck/zrgsmhQFqcT6p2/BvTEZu4VTPZd8133qGGTnw6O74kmjSQ6Ap4gTLbhaQDT9QB
         r68iBUc4wxX1MrLQ0jlIaIbh6nUKnpEBd0psRiUjJQpgR2LYFWa4K2YJ2NGt3ecrD2rB
         4g4U3Ci0QpWeZHcbjuaHFfarQncTFQz8+QWo469YWfUiMszgGcNXO1YSLDpP03HppifK
         BAe0mvnkUA32K952D7kSNEQ+R1PbWgm61mqKQ+Afj2AycHhVbB8s1Zk7UbJDd28ymJfZ
         Yi7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762436581; x=1763041381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4DaQeGVyB05KYzPS0LHKvWlhb6TnpUA8LWnzGCb6LE=;
        b=oHBHw7k4X2eLIERgm2q2Ggw2ZRXEqCr1mZinx4rsWH5gRy8n2t7VCo5GsSUnY3TlAF
         F38Q9BXDASDt5UyVxfJJZ10DXLD7x1bBmS7+OYNe2bv57CZ0VPqpe0dDn7K93e6zJnmh
         weq1OR6bQLtF/e9WX12YPQgvz4qS2TQXPE393GmOsdOk4LVKm1mpo677h+b+zyPqEjjn
         LRSEn7qOcfyP6SU1JxbVEwqIkDZn+lSMaMlnVyutBsces2GhpiEfht38wu9eQq/fQJsA
         ITW/QqiZF6nVgqfERyjkxZBIQ46T7MK/FFhh1+YIEgX4kSLRAMdvGhPbAPLovo8wTIfU
         j80w==
X-Forwarded-Encrypted: i=1; AJvYcCUPpFLv67HQliSVTCkVWeelsBU7Yh9cWK7J44gZR0epUzZtpgOu2szX5Cz5P6XbxHw32C1LMjTaH6yoJA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1IuCYQt31pruO8/muuu48cYUmcxakne34hRka1THz38ggmmac
	l2ABpnRyQKdZOZk/AHOUltXv3ng8wwAg4eEd7m3dBDCjELbn5AI2cVsh
X-Gm-Gg: ASbGncsrMHaY/wTLQhefZNfe6EvpC47NMzS6qacIyJ0QnU/BVtOF8OAoQ270L+6HnLj
	bbusWqZ1httOCOzmQpZsXgOz+wXzjHxgfRhxKlJ+/TWloUD7jJdzIA8EDRgquzZq7k6PQWEj7FH
	LB4N2NvGznuGghND1DHOit9GsjUTNHr4h8iLHOVXjev0sCYmxMqpI9pSSjF8JraSyeQGP8NRBmV
	3O6oprqNWsck0X5jtGJhktP3B8Y+1bqhPVTi74iSTGFkEMyIgjb2yGfjy1JT3PqzBB1lhs51dui
	DWpt6/NoTNyaODaOxc8p8idvwwmp9bX1cyRWsmdsJBrQCKEtgyNVN7ztPOoNYFNOnCtbT44PMeL
	HUZeshz/qiaxFTJ5gHxJQl9uisf+Q+nl77NcSp2Ip2dSPhZJyKg/SfljzmAGdGU1ImHCFSjM3jY
	lak5z6mBHRbFvWR2Bf3IrIaw+Z/J9RNUWLp9GrrjQ4nPV/AyXvcgojUZrZC3COB40=
X-Google-Smtp-Source: AGHT+IHDsjJABGBM/pDAFp2o03YAq/Y+Phzta3DyuV5Jfm/SuLEOelkoMEjBy0TTBTORIGeE1uEwkw==
X-Received: by 2002:a05:6000:26c1:b0:426:d81f:483c with SMTP id ffacd0b85a97d-429e33088ddmr6854934f8f.33.1762436580431;
        Thu, 06 Nov 2025 05:43:00 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb42a354sm4888852f8f.20.2025.11.06.05.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:43:00 -0800 (PST)
Date: Thu, 6 Nov 2025 13:42:55 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>, Davidlohr Bueso
 <dave@stgolabs.net>, Andre Almeida <andrealmeid@igalia.com>, Andrew Morton
 <akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, Willem de
 Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Dave Hansen <dave.hansen@linux.intel.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 10/10] powerpc/uaccess: Implement masked user access
Message-ID: <20251106134255.2412971a@pumpkin>
In-Reply-To: <20251106123550.GX4067720@noisy.programming.kicks-ass.net>
References: <cover.1762427933.git.christophe.leroy@csgroup.eu>
	<5c80dddf8c7b1e75f08b3f42bddde891d6ea3f64.1762427933.git.christophe.leroy@csgroup.eu>
	<20251106123550.GX4067720@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Nov 2025 13:35:50 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Nov 06, 2025 at 12:31:28PM +0100, Christophe Leroy wrote:
> 
> > On 32 bits it is more tricky. In theory user space can go up to
> > 0xbfffffff while kernel will usually start at 0xc0000000. So a gap
> > needs to be added in-between. Allthough in theory a single 4k page
                                  Although
> > would suffice, it is easier and more efficient to enforce a 128k gap
> > below kernel, as it simplifies the masking.  
> 
> Do we have the requirement that the first access of a masked pointer is
> within 4k of the initial address?
> 
> Suppose the pointer is to an 16k array, and the memcpy happens to like
> going backwards. Then a 4k hole just won't do.

I think that requiring the accesses be within 4k of the base (or previous
access) is a reasonable restriction.
It is something that needs verifying before code is changed to use
these accessors.

Documenting a big gap is almost more likely to lead to errors!
If 128k is ok, no one is really going to notice code that might
offset by 130k.
OTOH if the (documented) limit is 256 bytes then you don't have to be
careful about accessing structures sequentially, and can safely realign
pointers.
I suspect the mk-1 brain treats 4k and 256 as muchthe same value.

Requiring fully sequential accesses (which the original x86-64 required
because it converted kernel addresses to ~0) would require policing by
the compiler - I tried it once, it horrid.

	David

