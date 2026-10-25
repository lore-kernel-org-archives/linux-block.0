Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792887536;
	b=NjlMqWmJkuNqbIlxdNyzsenqmEluBahaxXJspsu+I6CnnMwIUzImLtASTuEznHKEMqcA
	 Q+U47WS30xvw+ZdLxcOElSE58mCOoY+ibJavNFIpssuL2buqP0HRqrFDvkDcmQnH1dntX
	 op1n3rlULWHypJMklKXCtnlfwQZwy3SOC4WSHh/vRSwbBZhTMmRhbdUB7l2Flmsc7NQgF
	 ZAEtlwL3QHOKzLLpy+COVBHOxT6hsZtTwl/rTjVX/N3ARiWpwBL1eNDEa1C0PE3qx5Cb0
	 QgeZ0DIC3eBV3FtKQaYnmH6OV8WmwO7MNa9qodwrcXKV8sxT8S8Fz1kIFJRMv5WpD6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792887536;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=NDtHB6+96zNrJiqoESkTVM99RvAu/va7B08qrVOb2CE=;
	b=U9qbDQWJXN23f28BsGvWZlvKE2mVV0iNkV1l3U2PdkCag9WDwhp4t7SAvlSrY2Fg5A0p
	 QTcdUbfwd3L0Z+CWuEcuQe8V5B/Vbii1o9nHEZ9hEXZvWvzTCRDSEYBUgL1Kw8TDE1Cht
	 9krZmaz3HGZfoJz5FHX+BLjfWcrgEIU79FWR+MDQzTHRP4XPZg0zWgKyueL1ClK3VgRUL
	 jdEVPfAJsSwqTxszGz4/NOAJ5662YWfBlPt1OjlB9VGJwMpVDH+7dYGdsrbI8E/kKYKya
	 sed9cVwUJnX/7RqFlHTP9X3QE4olNwz9Q22B97xR9VVMGcFo4FunOU5YftYtaKTBP6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=emjo1Tbg;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44430606A31E
	for <linux-block@vger.kernel.org>; Sun, 25 Oct 2026 00:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44430606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=emjo1Tbg
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so3367069a12.0
        for <linux-block@vger.kernel.org>; Sat, 24 Oct 2026 17:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1792887533; x=1793492333; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NDtHB6+96zNrJiqoESkTVM99RvAu/va7B08qrVOb2CE=;
        b=emjo1TbgduKlQ4wcFFJ6Ln5OcyzL1K6csEayf3f0Zih2UkYsSxLXCbXCyhPgfXmToQ
         rsuIAHM2eQQmbUA0gU6ItX9qYEEzHTNsnt3tw+uN9CMqxDLo2bPW8jpDZPLo+comFVwi
         KJ9ROXDP0vKr/idLGnJ8wnwfj5AotvSKczl+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792887533; x=1793492333;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NDtHB6+96zNrJiqoESkTVM99RvAu/va7B08qrVOb2CE=;
        b=I4mfRuxymlzYAPk17p0PK/mAQn3uxFhYybx/zfJOu/9UyXlKPCgAzyhyaxyimxEUSG
         h1nScbBGnt4IF9XRO+/8J9D2RF5YupF4J9veBWYroRfRKPqGUCMD586zMa49yW5/eOCi
         QgDDrC1Lx7f/SaLv4Vx7uVMvS3tW+EcUvZINB8klNem5ostGHzAD/X7dKRa25e55vwb3
         TcwEsOl/I/B02jySP5MyZrz0qKPSADejicm/CsbmFrK8ly+egGlnhf0M+kM8UO6Qg7hn
         ertzbqXYAeApnhXyTkZC2yg8d80vzWyhDakToDwSQwZfToewdqRXDgDTqrh/B3XHcLgf
         xbwA==
X-Gm-Message-State: AFq9FYK43FkNGUxxP1NrQwi1j4yUkKOIyM4tU9KXuamcu4mR+y82vDNS
	Gooic3PGlhgRcQMKCmoM9CDK3Rh0GG0CxKPo61EVyT9Wgxpf07RraoGRDPWzoFY+T0kvabM/Mvq
	krq128dY=
X-Gm-Gg: AYBFou0i3ue1pOPPOzdf4dnqE49cxv0pNxRxfUJ6ibROtYXkRI7wWkkRVPzOfOKeVdK
	r0T5SNgISmYwQQHGEJvGx9memi5TG8CIn2kYrvLISk7pW04sOjLkS48+e0Cyue+Kddpe84ndxYW
	CSd/9sLocFXoHCPU/mH/FFzOPFEkDg+x8ibt2PxyNDAmqmauh4XqLGXeGG/4ITH+zm1zfl2Unxk
	QWjXBEAju+h2jowz8gA+YvX8J+1YTu2mfm4t7pNxxFTM6MPC0vrOToHrLi7AOkdWXIupAYig75Q
	Vb6+lWytMfPOjzbTRdBwc+ejJllNca9sapZu8IjTl6X4dZOJFzmTjPQmUrlBEIIsJw3MjPw/eeQ
	9cAXVfINsgEZAVOaO2ELzDmTkxAwTsWC+3II8cxT04hR44pDj/lbBGovkW19v5+APP28L1qlU3Q
	ievuGrF7dXjhPkbwoenXA8+ZsXwXQEDsznex0M7QjITh8QYlUgcKggh2oRRDRbYO8jIszo185DI
	WIHrzX51e0B6ys8fvmXAtx9yJANBPl0BbjxRc7chTQAJYuGbJqLdrTBfP0eMa/mSYsNzbsA99ky
	AYrkztTJdoEOKx6Xi0PssFOp3mVGhUVa6BF4+m3ujmtOrn+q06WE
X-Received: by 2002:a17:906:9f85:b0:c41:5a0e:3356 with SMTP id a640c23a62f3a-c46bded5befmr334851066b.41.1792887533581;
        Sat, 24 Oct 2026 17:18:53 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd7984e9sm141329666b.74.2026.10.24.17.18.52
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2026 17:18:53 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c3f8d72d7ceso291969566b.3
        for <linux-block@vger.kernel.org>; Sat, 24 Oct 2026 17:18:52 -0700 (PDT)
X-Received: by 2002:a17:907:94c9:b0:c43:ae92:9a9 with SMTP id
 a640c23a62f3a-c46bde9d0a2mr336833266b.33.1792887532752; Sat, 24 Oct 2026
 17:18:52 -0700 (PDT)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <3b7e92f1-77a7-4bf7-a942-83de345bfd1a@kernel.dk> <efe0abd7-edf4-4d2e-a8e8-be4203d7ac3b@kernel.dk>
In-Reply-To: <efe0abd7-edf4-4d2e-a8e8-be4203d7ac3b@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 24 Oct 2026 14:18:36 -1000
X-Gmail-Original-Message-ID: <CAHk-=whdThHmhxSuh2dWw8-+v5caYBdb3AwLyx4YY67_P0qufQ@mail.gmail.com>
X-Gm-Features: AclHuK9aT3lPpMFvhVDJBQzuJ7BjcGMMoUCr8FaVWfE9dfDGm4wWvgVeOHHS2HE
Message-ID: <CAHk-=whdThHmhxSuh2dWw8-+v5caYBdb3AwLyx4YY67_P0qufQ@mail.gmail.com>
Subject: Re: [GIT PULL] Block updates for 7.4-rc
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Oct 2026 at 05:11, Jens Axboe <axboe@kernel.dk> wrote:
>
> On 10/21/26 8:43 AM, Jens Axboe wrote:
> > Hi Linus,
> >
> > Here are the block updates and fixes queued up for the 7.4 merge
> > window. This pull request contains:
>
> Completely forgot to mention that this merge will throw conflicts. Both
> block/bio.c and block/blk-zoned.c will need resolving. Details:

Bah. My resolution ended up being different. But I think mine isn't
actively wrong, and keeps some of the warnings.

Holler if you hate it. Or if I just plain screwed up.

             Linus
