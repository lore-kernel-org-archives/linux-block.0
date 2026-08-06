Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C87E3D667D
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786008466; cv=pass; b=G8W+Qkc7y+QLNoyff4gVbQmuidlLXfXvx7/Ce67h44Fp+zi0IpKsDVsUS2TlqvGc384/js2Sunj/ZoWdhiC0DZ42Klk8EOnXMROlODnlt+CdeDmFvxIG9vu+cexSOcjX0Og9Fnc47MoxwKxrSPS2bvuiZZeaVYY/1is9hJ+6cLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786008466; c=relaxed/simple;
	bh=nq4htvwgzCHixLQLI8fNIOoPdjAuv5lCqxGyFBE8+BM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FfCsvckmeVgLDaud/DuXBOz6tdkbaReZ39Ih8zQvr3q3q/2hvCVzDHWb4+Aq+pn/l5x4FKKcrDKACspdOF9F0wE5khp7x+sRHN8YFsYg0CKGYlY0UHGVXi4L/ywvK4Wz6TEmPJMPuGERkOWGyFdSPPUxBGR0WsJFS49rvfU0DCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BxW0orYO; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BxW0orYO"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-381b831d535so2307451a91.0
        for <linux-block@vger.kernel.org>; Thu, 06 Aug 2026 02:27:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786008464; cv=none;
        d=google.com; s=arc-20260327;
        b=Zzm0+SSNocyIpzWt0tpmi0s16lVAYwORy9YtOJgyGiuz5cMVLW9q+h2uT3vaOaGrxH
         +QtFLo1xmkoXko/JNizqtfnS5VuOKN1QO77nlxfckcVxsIg9BGZ1M3RnqROsVFAUlcE9
         TWMZhuC85/2KGWoPTGq/ZWmQXqX3EbQ0qUqHybEeX8K3ZkgkBdxZMEXHJSiabEzaqxY2
         YE2uyBYd9woaM/aFvUazj8GNZidsndHT0uhSRofb+d6ZFUmdedHjJ2bD/Eo1/2pkWTWa
         S5iokz2+NVdzCCvyQhwjRlaMAv1CXzfKWbbHyTTUgObWP/MGpFEnP56dH4q4udhYuS8g
         4E0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PXoRnAV61QwNMEWiRPP9CHP2WFb4bbeYxGdVTeRfpEM=;
        fh=H9/UVZjYX5GCKg3lHLWtetO8VAyKJ2cMQ29pMs/AvjI=;
        b=s3NE5t0CKCAphCrNyb0aFtU6VoO7tYCYBzT3itnR4hbDcUGSuHxZdsI/2owHjHEKk2
         grJyzMqmyNYD9o/2C2A6jFNYeh3a6+gAhUL+kPzvuA0NBF7ElYAgUEs6Y4s07ZYFRs0z
         NbfNvxBNMxh5guR/irzzbGOllKJigkjab78IFWP4HSizX4JKZHpQQP8DSg2QGYCqNBLj
         1HYPEQCi+/A6WAy2wHjD+SF0aTWKP7BivlFOODwPsL+dRUm52fz85LH1jTxe6wjzZ4OW
         dz9StM4kbKy8Kh8eO45JvZ8Ah1KRfg/Ra25gtb8uvzg/f7KBWPy6HM3/3apW6MtTWiQJ
         zR2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786008464; x=1786613264; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PXoRnAV61QwNMEWiRPP9CHP2WFb4bbeYxGdVTeRfpEM=;
        b=BxW0orYOTg0mKiNPXYmvLkP/c9/+Hp2bMN59w6eJKgG1a/vD2b3HpA8BeCv6xr3yMg
         3mW+c/+SQFgSHULtqEqTDhF9uYjH3UAmKltxcuTvFshpsoWp+Su1xvZKYPkm8k6peO76
         eNNWsGIaqnfs3LlMmXKnQDfDXMY+VR3Tun095jYC3tVk/oXfXsH6DvC+nCN40LF1UcTC
         QD1LdLUN+d1UqvGNF0Sp4Rfm4qIx9XinwGcRHhWkq0tR6mOuiacvQ/YzvFVrBpoYmPjX
         YO0qSwuKKnUA7fuU/bO3rBpr7fzX1L4PObKsz2RoXkOnVq/9PyBOfvaiRDhQcDWQsing
         KHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786008464; x=1786613264;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PXoRnAV61QwNMEWiRPP9CHP2WFb4bbeYxGdVTeRfpEM=;
        b=gmSvuQxXH7GcmBQevlkQl6X5n6jJNWc0ZLScL3BSBsN0JKSpvDYWHA91KVbHCwup8j
         Ke8n1MUfF34XjwcpZQsi2oYGdLSfm3vgc+L8/jWAjxVrbpipImAufBOve49XE/0MuBQD
         mrXochdmMaymhfmAhGrX8s4U50k4lKDgMoVhvbD8gf/jTXI2FKeNkXN+ui2FIutXDOTx
         zw+wJIiz7Qr3hzvCynPOMvzq32t7Ecuhtv2T6eR0sBsJEl+wjWCdu610dRzCocaEwynZ
         upGLUAfsLlUO2LHGDsImn8wBZQOUWeVjzo4BxLvDQaf56c5kI2/r2Tb6BPOPVXZrMj4c
         /ENQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqej1Zm/PzYy6f9t+j1BnlcuD1oNOiIVreot2cuFOF05eO49UOGikfFzS113hXIvLQnSe9Jof9cntWwLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwYgjda14n7p+TR77JztYtBCJiKCxz32aqC01hhzoRoh1hrdn9
	QFDHD85w2AczXUVyqR3cEV/688VSSZNdKW0V+sWLlr1KG6KlSaMGSJLvo1+U3GReOoxiEHrG2d4
	uXXqyPtUFM03ko5k/TV4ylDdIfQFwBw3sR8tzmAQL
X-Gm-Gg: AR+sD11Qc2Oz2/J4kFpS5uelVUGcjMVheetxAsD6bt3OIElDVB8hDhOw/rY00drWjQm
	IYuMZhLRTOhbDRoX/VzYXIXTM79eOj1h6XVQPePoPPF0pXhfnh5xx+gKxat5I6QRqrAvBDmUw7l
	OQE8YLun9C0fL0ZAANwJaqtKSddDyJggtEJheG8y9VkoTA15XnrHxEpgUMZNTz6CvhBzDeScs0O
	vZ0gSsf5DyLtb7qUDcZ/OZFbIkCtzKyRlAf8zCwshdtSDFQTqe309F4kCACZ75e3jxt0nv8xurX
	PYy5qFeM0mrrNslSZ7OWzeIFshpLQtPU1Vsov7UiNXlC0oswPsQI2FdM99TWftKYqXJabndA9w=
	=
X-Received: by 2002:a17:90b:1dc4:b0:38e:49c0:75a7 with SMTP id
 98e67ed59e1d1-3903c537808mr14252957a91.8.1786008463826; Thu, 06 Aug 2026
 02:27:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785440858.git.bvanassche@acm.org> <0b2988ca05e8a2733352a447e0810104b878376a.1785440858.git.bvanassche@acm.org>
 <487841d2-9d55-4873-ab6b-dbd94aa7bb71@linux.ibm.com> <83968777-6f3a-4c21-ac89-fe9ebcbf254d@acm.org>
 <4f4a40a4-082c-4b3a-9fec-5b7fa54c6a62@linux.ibm.com> <4162153b-49bf-444b-9bb8-fc0209f3a0f9@acm.org>
In-Reply-To: <4162153b-49bf-444b-9bb8-fc0209f3a0f9@acm.org>
From: Marco Elver <elver@google.com>
Date: Thu, 6 Aug 2026 11:27:07 +0200
X-Gm-Features: AUfX_mziqh3zSrVPBwZCVQKP27vy8qOrhk6-SYngNn8sryoHgYFZX-K-BTKqAAc
Message-ID: <CANpmjNPSYOnAC5Yjh5nDPKJW3XRQdcqv83hfRhVKS_KQ6DBgfA@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] rbd: Enable lock context analysis
To: Bart Van Assche <bvanassche@acm.org>
Cc: Nilay Shroff <nilay@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Christoph Hellwig <hch@infradead.org>, Damien Le Moal <dlemoal@kernel.org>, 
	Ilya Dryomov <idryomov@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Aug 2026 at 20:24, Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 8/4/26 3:48 AM, Nilay Shroff wrote:
> > However, I still think acquiring_list, running_list, and object_map should
> > ideally be guarded by their respective locks. The fact that some code
> > obtains
> > pointers to these objects before acquiring the corresponding lock makes the
> > locking pattern worth looking at more closely rather than simply leaving
> > these fields unannotated.
>
> Marco, to implement what Nilay is asking I need support for annotating
> function arguments with __guarded_by(). This would not only be useful
> for the rbd driver but also for other Linux kernel drivers, e.g. the
> loop driver. If I try to annotate function arguments in the loop driver
> with __guarded_by() the following error message appears:
>
> drivers/block/loop.c:2002:30: warning: 'guarded_by' attribute only
> applies to non-static data members and global variables
> [-Wignored-attributes]
>   2002 |                 struct list_head *cmd_list
> __guarded_by(&lo->lo_work_lock))
>
> Your opinion about this is welcome.

Can you show the diff you're trying?

It doesn't seem right to me. For one, the source of truth is scattered
around, and it's not all that obvious which arguments should then have
this attribute and which should not.

I wonder if there's a cleaner way to design this, where the source of
truth is centralized (hence the restriction on struct members or
globals) and not scattered around.

In general the analysis warns on __guarded_by fields passed by
pointer, but from what I can tell that wouldn't work here because the
locks should not be acquired before the function call that takes the
pointer.
