Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A33D43E081
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 09:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785835593; cv=pass; b=dVREZx8Sq26m1vMe76WTb86myyFE3DmIhk8LngUXbmtxE9RxAWWoeFOIsFHwaqYKjaxvjXkh4pqeUwceCbXPoK/nZbmtr7qcLh8w/03dWc0YovWMTLd08Ie7Dk+p0WvT0VIE1owhda8Jb1wq+07FRi4cYgx4gK2kGcYIm66kruE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785835593; c=relaxed/simple;
	bh=K50AO3QCnLnerddofNAF2BYrfsY11pOOebsc9zmParw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YPXH8a8ym8fvJGsISBUxWOCSFPQk50AITC/DjDiXt3hi0xiFFPbb5fG6IkxuhNaaEYJgYelkM2uaiYeodwJLzDsZ3ALLg4BTuBUeQfbfoi+IRQ3kN9vaSVV0KTV/nehZQWagjxtbxArTpeJ4eIX7vQk7dK5Ul1HeRB60fqKGA0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c3Ndk3hK; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c3Ndk3hK"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ccf2360620so38976745ad.3
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2026 02:26:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785835589; cv=none;
        d=google.com; s=arc-20260327;
        b=U7qDzBu5FcyPVuiqH1+r/l4RKgxRga4WKNhBKzR8L+RNRBXNXqly5d3NE4PUi6gTHE
         InCby2Gc4RZAi/aBBMfzXGDfOYaDNdltn93m9RA/+Zm/TKgazgB6UBgqH8hFBpg5U+Xb
         +/D7SMvqQAATn9mUe0Ho8ZkTyarNzdkBrDEjREDHWe5uWGGYGS3xc5PvpRYc5RfMTYLF
         nKVFzNKbuwQq9wyUT8x5PejOJYT549p1EeeRzDbeacXNjt0CTY1KTlZYRTHFsfD4pLOK
         GvHBdDCQKSOKUa7+AEq8yE7Ud51yf7iSCKSPxacga4WE84521usicsjbZX/Xbox7hTM0
         UsuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YLthe8qQ9/fcrV5VYLyjQQxFU86K7sG+SJQSb+OqWOI=;
        fh=friCt3m6ONNsBwFHQiO7P/fRGPjVvIM8PaJqLYgajNU=;
        b=QYAyiuGHORBxRiYi6qB2IBkfyWJu+7JAe8oBCAY+ubbmJ1v4xNUEkk0MGh4Nd9wdSF
         wPF/XIFcMsDAkOf+koTmwgNSIEkeLg2jqSoUvv7+rZ1hiHRdjOYSB5qYdizL4Y8jOptu
         7IMXyuImNTfHjkQkDLFDSSzCk5pflwzek3+AGw4uoYj/Fe+7Q/kcKW5/a+iMC/KNWfC7
         VXoKJ3XlpenZw4KV79LHg5+YZkxXFCj2eN64m18GsIyXWjQ9ztI6PF/Ur+1eIr/KWcvh
         zCmmz18i+liYqTmlp1y6DejO6S/wTnhASlKH3pBm+dpVrpeEX2fjNudOizy9ZLQbIszQ
         VL9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785835589; x=1786440389; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YLthe8qQ9/fcrV5VYLyjQQxFU86K7sG+SJQSb+OqWOI=;
        b=c3Ndk3hKrrWIWXUxHifc6gIrXDWUaxChB4uXZCJUwRuDtpRiD5hsuHT7UeeE5ZGmAI
         uq0AFGcI1DrESgiEldGUJfbRuKXLcbw/nOo6E83bzIIoT8GAmHpUrP7H1u6uL5Zh30A/
         paNJTbqhfpDvkyJ6lawQ99n4zecfY5SORPvm/EK/4R/IYDs6NwbAuUZoLJwILM99vkNf
         c36dDh4xCP0XiaTyJp9LTNR1vsmbpKJeRmooxRO5LAc5NJ1gZxWEFgmv8T3gB9noYr1B
         DwrWCtNLyiIrpAgU0W8cEl/WOlv4vedf749cqhx03Obch+Vfxwhb+7XFsj92xiN8MMju
         P4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785835589; x=1786440389;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YLthe8qQ9/fcrV5VYLyjQQxFU86K7sG+SJQSb+OqWOI=;
        b=X2D1O0nXOwMVjCDjPMuwmCI8jqMqPbBSkgxVGSX2ydjvA8JRdVpW1YpSXPEVzx8hZ3
         nAjz35po3TLoCcWdLq5UvaoiL07dwBb006llBi87VAb3sXvuNFS/7FaawUZqz0UC8nLt
         c4zeek+iWH3pC+5RoYChYyL8hR8jiA5A6fY4IJVCLR6y9Zqt8MVtezPyddWrOGwSPm45
         HlFBMFJ45XPE3PIe4qAXdOM+rvbXcYesq4sXlle4VHOeBZbJDBfytl0QrtieBlLDs2+2
         /lJyCaQI02RdNGLaV52YrN0s+HJhy4by28i2DEW6bRjPtCWCEV6PGdrjsraN6Eh1J+Rd
         T6aw==
X-Forwarded-Encrypted: i=1; AHgh+RpfTzWWBo8JEWPk7hr6aQFd+Z2h9EUke4RylTpWVCymH22vTp+TlizaQqaLic2h3xDjg3+tC8+YKo4r8A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh//0GlRlK+kI5XTjKd+N4OERXSaoU8BeL8vDwCzFtJyqgY8uR
	1EUD3dT+qhNQ6c0J5AlI3l0tvelBKrr0qIPNHVP4dqRzIqF1venDFoJcc3G14eihrI6HhPOcVD7
	iillgQ4iZBEocY2rlklR2ioSiJU2LoPQmW60tnvMC
X-Gm-Gg: AR+sD11oZPNCS0xgCHsGMHZ9V586RKA0fmxDc65xGm8dRgdw/P6xPLP0fcQXHA8A21L
	BIPhpIf3nw2SED7t1s8tG3rzh5TQujkjgJCBFEj5gy5VIkQVXzcC3ahavDs+Krkpco+7t2PfJaR
	DUOT3dQSiKoXAyyR9/Y4O1zsqy6LM0tlPsDn3IFSo0NeznCyw2WvdTXt7UI9b/JIz+No7kIocnU
	iFea7E1Qx9zlTtF82lvWIxKRknvM2ZbKElW5VcAZcw9WLd0N9EuCbCJMj3DYu4zT04/SXa1RoW+
	B1AhVNB8VMbvPpndRbcy1znzX6CCuC6M9FNWGNzqqC1Xas2HH37204Ek/0VxWyjHLmyJt+6u7Pc
	d
X-Received: by 2002:a05:6a21:4cca:b0:3b5:489c:7bb5 with SMTP id
 adf61e73a8af0-3c92a830fa7mr12023714637.28.1785835588470; Tue, 04 Aug 2026
 02:26:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785440858.git.bvanassche@acm.org> <5e1f54d3826b0d479242a9886ca2c7b6eb8cedaf.1785440858.git.bvanassche@acm.org>
 <a438f0ba-e2b0-4fa5-920c-bdbf49769674@linux.ibm.com> <7d5c9498-c471-4715-a264-17a4df4c2559@acm.org>
In-Reply-To: <7d5c9498-c471-4715-a264-17a4df4c2559@acm.org>
From: Marco Elver <elver@google.com>
Date: Tue, 4 Aug 2026 11:25:51 +0200
X-Gm-Features: AUfX_my8yHhiDl1Dl_yhnt4DhYyKV12bHqr2BN2E-c43E-TwA9dgWorP1pVCXFw
Message-ID: <CANpmjNM3-WQNo9djX+P3bWxg24x7jrymiFGJMyJuRrzXBLUHOQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] nbd: Enable lock context analysis
To: Bart Van Assche <bvanassche@acm.org>
Cc: Nilay Shroff <nilay@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Christoph Hellwig <hch@infradead.org>, Damien Le Moal <dlemoal@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Aug 2026 at 20:03, Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 8/3/26 6:26 AM, Nilay Shroff wrote:
> > On 7/31/26 1:28 AM, Bart Van Assche wrote:
> >> @@ -2773,7 +2776,11 @@ static void __exit nbd_cleanup(void)
> >>       /* Also wait for nbd_dev_remove_work() completes */
> >>       destroy_workqueue(nbd_del_wq);
> >> -    idr_destroy(&nbd_index_idr);
> >> +    {
> >> +        __assume_ctx_lock(&nbd_index_mutex);
> >> +        idr_destroy(&nbd_index_idr);
> >> +    }
> >> +
> >
> > Could we instead introduce a scoped __assume_ctx_lock() helper so we
> > don't need the explicit scope here? Alternatively, would annotating
> > nbd_cleanup() with __context_unsafe be a better fit?
> There is code in nbd_cleanup() that must be protected by a mutex so I
> think that we shouldn't annotate nbd_cleanup() with __context_unsafe().

Just 'context_unsafe(idr_destroy(&nbd_index_idr)); /* comment */'
would be fine here I think. I've used that elsewhere for destructors.
It makes sure that the rest of the code is still checked and is as
simple as it gets.

> Introducing a scoped __assume_ctx_lock() might be overkill.

Agree. Note that __assume_ctx_lock() leaks outside the scope, so a
real scoped __assume_ctx_lock() would just do no-op __acquire() and
__release() using the cleanup.h infrastructure (similar to the init
guards I suppose).
