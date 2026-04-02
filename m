Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A9A3A3E74
	for <linux-block@vger.kernel.org>; Thu,  2 Apr 2026 09:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775123248; cv=pass; b=RsSP1NAoh17H7UV+0y29PSncLfZ9KsYMlNMFekxkyBA6UrOOW0H67d0w3WK8OrHvzb3VCkFaxv2T2scfXCOJekKQtYZ38yTPZ0FORzW79j/M558mZw2EWSxIeMaEHc/ZSCj0Xj2gz0SY3CjxOXzIuamP+xuqUO7aGJG854JVB+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775123248; c=relaxed/simple;
	bh=+9fRcog3ZU7tezfUjPEFmOcqhgFL4fet31l7xH8YuOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xex8c/5q8X6g9bpuYYSYsku0ztngaoHSxgBktJ1i0e2DynMlTE1vsbGY/NK6gR9h7SN4acYdtRuNABrSZhDdvQVRq8uaCixnMPVmvhAPLEbzzMawMvoorJQw6zIOk5cxFV6HmGkmfiglxmphGkDofMgL99G5cihoIGGTm3pgIR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IJ245kdO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jaucXP4d; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJ245kdO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jaucXP4d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775123240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n4qDMFtRmKlGdlbffBUpJm7co946MEllLL5NRqeKXts=;
	b=IJ245kdOoALhTVoiAVXvtqoNmVKxi1bBLFrE9It8IDlhZvhuF0AQk6IBmEldn+W8P4nXvf
	IquEEnHQf5Wx2WGIy24QleiuUtZSGoFKH+o6zznqfDFqCAbgVj67pBAyFJvnCTInhvb6Mm
	KO2KivzQWbq4W2cd69VY6s6JXxGSVoo=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-6YeCSFpQN7GZN1bt3w7DnA-1; Thu, 02 Apr 2026 05:47:19 -0400
X-MC-Unique: 6YeCSFpQN7GZN1bt3w7DnA-1
X-Mimecast-MFC-AGG-ID: 6YeCSFpQN7GZN1bt3w7DnA_1775123238
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-604e9bdda95so904596137.3
        for <linux-block@vger.kernel.org>; Thu, 02 Apr 2026 02:47:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775123238; cv=none;
        d=google.com; s=arc-20240605;
        b=YZl2lpjD1YkZr54iypBXtzt2KHk6AFYXo5J2in4fwqYARHXTX8SXtIOOImjnXEfwxR
         m78CP4LryayTRqWO3J8tj75FwYYsEs/ywUKH9EM3BDMQlls+7kRqJkMA6xvI8xe0G7AL
         z4KyMqvMx6eu5wHGfQV5P520NTxdN1UZgaGGrUCRO/zPtZ404GzLyfTrtxf0ATZ+Ih4l
         XjvTLpSO0fNl0amnrTFibewbV8jk4x0VrMFOO+ztW9cYvOwFeKSC1jRKwAmXnGKx3f7x
         dTZ6oj+FlkNuAo8ySB2vGDMrHYh+L7kTA20alysQDMYUN1huK6o0uMxz8QM9kAA4wooU
         jO1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n4qDMFtRmKlGdlbffBUpJm7co946MEllLL5NRqeKXts=;
        fh=q5KXspk5DhbQwFVKtKnx785vT6Qm7cWilhY1l0OOfX8=;
        b=ZhGOGF3xytPaxZffIx6hCQCH7siB+HvgS3ZXBPYEJrzHz6sV9v3k0Fu/hXLuYBOsd5
         UQ8Es/cq4J8lWa2ZDA6MdC9aBBbQZ7eDpKQ6hfvLDTTGQYs0ceJ8ZE/SlK2J74fMFwtj
         8FY76r4cTxFRhSAY3EAoE96X7LmGaFc8xY65E9HBwd6ZrQvHeQMZNujz6OFH/Xi//CBX
         SKZFk4m2d8FkUn4NvuUSUg/8OOTUPO50/M71ZDUb778oCN3cZ/SiOPk7Pt8w9TVCOb/6
         SnE8oZg0rhBZpt9OvDEYmvS3U+V2rU4pQVeq29f6mM7CLWtcE03fkmhTxBBpOG/t1blH
         k1LA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775123238; x=1775728038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4qDMFtRmKlGdlbffBUpJm7co946MEllLL5NRqeKXts=;
        b=jaucXP4dcYPSV0vUuRXA97q4nCRIpynOAD8zM759rfUMyeUJ1sLuCOIAR66f/HU/+W
         OgISfi0pF6DFD/72xgIqoMoUm/EvseZnWqnQYA5gGJITv7nLfkpCUVSTCd+sWMpV0RGU
         9olLb7ob+q8MtgxZFFGTSYIm96ToHch5VH0meMiOOhDzZmBON9i6fBaasqyLy9fQpWiN
         AgNv7JrBeI9K2stuXoCOS/egnNFOWdsGm+EW/diHD2jsNOhgJ/WmHScf6usPURQFJFzi
         K+KjJGb6DYVH1btlYR0UKTQko6QUvufrQE1Ts2/5brCLUhOq/9AE9RAU42FqcFeRQReq
         xgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775123238; x=1775728038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n4qDMFtRmKlGdlbffBUpJm7co946MEllLL5NRqeKXts=;
        b=h3cehCqGiC7wqMIk3STYSbnmcHL+SwdVocbsPLLBVIMahbDlkuBjeN6Ys7KxK1GDiO
         oRQko8clVylLAad4PGcOhRTyaXwh0nsVZzsnk+wPZR+YljSR1BwcWpvXEQwIVcAJ48c1
         ghCgoVUvSyZxpawFLOB+HoaU+Nzqn3XFyQQoq/xASS0CA8IRQy/z6DA/B7UlNcea7qCm
         Hi5oKkpn92rjePQw78dXY1BTyaqdf4so3Ckd6vq7bgL8Gv6yEfs3xtOnXn9wA/4Kp0yC
         Ci8Ozqw60P2tNbXQFu0Fd9Nl9TYLH8+iIXBY/E6Z0YidnKk0Cu+mbGdtTzmbO3NCwT5G
         o7CA==
X-Forwarded-Encrypted: i=1; AJvYcCX4Q3TD6VrI2IYdGkN5lGc0V398himieI8wThS45/L0pIZWHkglJcb3GBoaxV6tLsUDMRssYYnAi/uXfg==@vger.kernel.org
X-Gm-Message-State: AOJu0YylPpsnxWLQqJEKJjy9m23WQAZxcQ56EYvGAxNpwudyP+m2KTWU
	+hvGImAp64vuvF1bbvr0E8MMLpnYKLBxXAdyZvUjbn82Ayi9yB2p64V75P1dZpe8qZqNel9LcGI
	cuCTov/Xx/vq3h2M8k5e/GLKpTY5SwtqgJEwtw/bLySLtk2D8SAofNoniwL+gc2vrSlel7fwy4D
	mOZ2JfaiiQz/eA0J5yiQp/EbgChZu0lcybfRVL/1M=
X-Gm-Gg: ATEYQzw6Ln1GixVRkhjXR5B05yiet59lR3iiTCdfT73lzQR+UZTaLhepZkBDG2QxAsE
	JwH24lHZQAn1zCG4O+9MIoHBMK6+TmtTfK0YmzjOBzJ5vO+e++nyk7NFs1C+fJtzSw530Vu4Im+
	zAuxRnMczTJ6A7D1790lemW8iugEWRjB2liIp4svQSjAbYe87S0bEpeiLo7hCaF5OS1ffZvT/D2
	sRSew9+/vSB2XF7ImlA0jp99a8WNBI3+SP7WAU=
X-Received: by 2002:a05:6102:26d1:b0:602:7a74:fbcc with SMTP id ada2fe7eead31-60567ec81aamr2988557137.15.1775123238399;
        Thu, 02 Apr 2026 02:47:18 -0700 (PDT)
X-Received: by 2002:a05:6102:26d1:b0:602:7a74:fbcc with SMTP id
 ada2fe7eead31-60567ec81aamr2988549137.15.1775123238002; Thu, 02 Apr 2026
 02:47:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326144058.2392319-1-ming.lei@redhat.com>
In-Reply-To: <20260326144058.2392319-1-ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Thu, 2 Apr 2026 17:47:07 +0800
X-Gm-Features: AQROBzCexU9L3edGhUQL6F48f5_6dnAnnmS_QLeUXIAOAY4fwbwRn2mCIAvIecw
Message-ID: <CAFj5m9L26JbwCv-njhGts4VqBFUbEb9rFgfUvH1Qv6GtMT_9_Q@mail.gmail.com>
Subject: Re: [PATCH V2] bio: fix kmemleak false positives from percpu bio
 alloc cache
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Yi Zhang <yi.zhang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 10:41=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wro=
te:
>
> When a bio is allocated from the mempool with REQ_ALLOC_CACHE set and
> later completed, bio_put() places it into the per-cpu bio_alloc_cache
> via bio_put_percpu_cache() instead of freeing it back to the
> mempool/slab. The slab allocation remains tracked by kmemleak, but the
> only reference to the bio is through the percpu cache's free_list,
> which kmemleak fails to trace through percpu memory. This causes
> kmemleak to report the cached bios as unreferenced objects.
>
> Use symmetric kmemleak_free()/kmemleak_alloc() calls to properly track
> bios across percpu cache transitions:
>
>  - bio_put_percpu_cache: call kmemleak_free() when a bio enters the
>    cache, unregistering it from kmemleak tracking.
>
>  - bio_alloc_percpu_cache: call kmemleak_alloc() when a bio is taken
>    from the cache for reuse, re-registering it so that genuine leaks
>    of reused bios remain detectable.
>
>  - __bio_alloc_cache_prune: call kmemleak_alloc() before bio_free() so
>    that kmem_cache_free()'s internal kmemleak_free() has a matching
>    allocation to pair with.
>
> Tested-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
>         - rebase on for-7.1/block
>         - add helper of bio_slab_addr()

Hello Jens,

Ping...

Thanks,

