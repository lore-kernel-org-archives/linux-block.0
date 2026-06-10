Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D8E392806
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 07:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781076708; cv=pass; b=u6VRZEccZcVu8iAVotzS9WtFr7trxzSq8YjGYOoFpR+ARK0YZtt/SusiG5DaEAlUf2up5KbCrIqHRMHdJKigEsIscqP6WmN8q4CIImJE9F5PM94cECCfVVeiYVVtQcJuFJ7eq4jzOFhNjzl7O9R/i4lkczSTBgHy8MdKADQziDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781076708; c=relaxed/simple;
	bh=/KjY5Dx4jh6UuZw/s6SRCokuMYHJFP0joLVSPvxTjsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NH1ZqWboW9qzer0bICgGY/tniRrQ4zBvKKzfYsWpaP0ESjqcnyLpVKdyskqGJ5Le5MBdxTcvy4RUDPgeB+HLrR/7bXkDQH0EoMUP43g3qub/iRWaWfoE2lEJ02QN1/SOBJj4986j8qo5VOWVToWzpwZdFMVch/vvXQOa/GZM6MA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=INuTvr6l; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="INuTvr6l"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-13809223fd4so6130154c88.1
        for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 00:31:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781076707; cv=none;
        d=google.com; s=arc-20240605;
        b=G/deZI24iHbqmv3mZjtclkoqhnFvfo8HUWCdgGhWnJ36QZ5Ie6llkNqVIPsXb1HfQW
         XwPM3Y8C1CLCjYoS9wqBU9PL8WHhaeDGKoqpf6ZWqacQR6DZkGW6y2HP+LlOItm7mrdP
         /4GWWWqc+NE63jMjK29VT1QxXy9cRvWyaV/XH4+KPl3oUuwXt/QQ4BPo2rfkvacI6j7e
         UDrAsQIONSLfChcw6VKNAlPu4Qvl93GoDpdYk+Vn9uDJPRcAjLbTlhYR8SpzlbNYw2U9
         N+/nicNlXvwmW7Y7mF/WNQatIr5eg8GVBZJBhF7brpIM9Ffo9s1T/jfxfa0yUZzrpIxw
         pMFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BNMgl/DKAB5+2kZHkyVUyRWUh8Xtj0bP4dcUnRrz8co=;
        fh=6VIzULmu7Dc8NwXe4rVh+gZ870pRO2BZlyu1FoWRPiE=;
        b=SX44058xrM+z3TLcYX6kfaYNbiDetSBd9RarOIlKUY5kY+luOca1yncXqleIw9TKbh
         fTWr7hu3SXmfIVatqmGY8VlklTNZXC3264/+Fo62rRcyLuKDuxOeIeTbi5pGy0q41HM+
         CgJkYUvQcNQvjZC2TPBKoVClPMrNkjmrVUaNcUZRcNpsou+Ltz5m21pDSPIXzIKR4Tko
         ageCf1mZ7f4SmjG4B5ZfLaT2v9dlLruxkCj5xJnUY0jJnCXQK4deNPQoKLLau/P3aTNG
         4/SPKCcJ0B2UIQqpTQLd2rnP1neulwXDYi75bOf/7/c8wgmSHnjvaSJdpNLLQ3WEStGf
         Frmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781076707; x=1781681507; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BNMgl/DKAB5+2kZHkyVUyRWUh8Xtj0bP4dcUnRrz8co=;
        b=INuTvr6lYLMjRc5yoyHV7C/sjByxfzTy+Z4ThgOa0jN3Tx+kPlZKFtd41BvN/GEJpH
         qNoQK3IqM1M+Ep9CDmqWEKO0ioGYEBsLXSQyt59wKBSks8kSRo3bZIIgkzDBA0EO4+0L
         p+sNIn8Iz+LznZcTn5o/3aP1GRS1unJKHtoT5R/3+l7rRaVz6dz5tQPlb5kaANVkYEPF
         49+UvgIjfqf3d+ndQL6Kx9mH3KeeaoSr3MStb0kPMIaj41BF4kS5EcF+oew3sTSM3rwP
         zw7jPU/z1rJm1lhzvD2Hsy35mZsDp0aV4ov9WFDWegmk72W5rJaE01Njk/mt0kux3/6v
         aOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781076707; x=1781681507;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNMgl/DKAB5+2kZHkyVUyRWUh8Xtj0bP4dcUnRrz8co=;
        b=lTnyc5sTWHw7ImVL5TDREKBiZSzImWCroxzDK6kpG84vSqooAbJT/kzayaA3iBsb/D
         BOQSY73W+6CRVwU3v2wQwTxU93R+C5QFJiDmXJIwpHiCsUAnHVYMmPprcdeVaQZkbu7I
         UVVAv/HVu6wRuWIlEgcJqT/kMkPiEiv3xKeEcJvheD+g++J8v4y35N+lYQdc85zhmyZb
         r0xBm/JA33oLtlRQtaJwck9WL2RmYNOz7vCySJMMP8mN0HYbgFYKi0m0Q0UC/YJ8V47U
         5HM/gd0L9RSGzaTQrqm6Fmd1yv+LyZeoU9dM9T08WzdDRUTWFNBINIb5v1zw43T+B5ER
         QJ1g==
X-Forwarded-Encrypted: i=1; AFNElJ9NAZAJDRoh6pwMwdmIpYaOU/ijb8RcwDThNgAMMk6RVIMvbgi2FsPaCEUdLPpjxtGtQUKqaJHq+7p2Xg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ92DUwfc3c98pG7+L/Crwhg5cCUW7wGt7Ckr9jjS7HXDl5pRV
	VZTOmP3JzkuopfzaQGSdZR1Sho+Cxy3D+wLgrUT+eYqVSnfBdlelyZ1X9UsVh4/cNIqCfNj0ePW
	dnNjCHmY8AGueqT7ZmyHQJaUljjlOqqfmXcMJ9MufIKEMUdm23qp6AFpznIo=
X-Gm-Gg: Acq92OEkbamN1cUhG18g336YZstJfgYQ4kzv/KZHIG/pf9gG9R7JjLrVWJ3Z62hKr1o
	9eo2cgw5J/LS4bqtd8ty1BlOAgt0RmSN3sVpLYxzsz1fyTgQMSmrVv1e9NB/ykY3I4uaXoqodeB
	c5/iL5sjYC/VBXd4O+189HCSTt71Yv0GLdfyciE5nmho0GU9k8Jiq+1olLQrudHffIDHX+qSaqW
	6EuttwPpR/7XnjAkHn1nd1c+Hsyn/iViwYDvdGyHbbZPD3iIqUGQATb+2rE1izG1n+8lgs7tgCx
	ln3qU3W1Ccmkxyp8kdsX0UH8ry4BpZyalByGV1kc3bUaRYY3
X-Received: by 2002:a05:7022:ec4:b0:12d:de3f:f3e5 with SMTP id
 a92af1059eb24-138067571bbmr11361996c88.37.1781076705955; Wed, 10 Jun 2026
 00:31:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1781042470.git.bvanassche@acm.org> <aij3e1WKFQunNUS2@infradead.org>
In-Reply-To: <aij3e1WKFQunNUS2@infradead.org>
From: Marco Elver <elver@google.com>
Date: Wed, 10 Jun 2026 09:31:09 +0200
X-Gm-Features: AVVi8CfNgafW-NbVWdR920oF3jCwIX9ec9J4cE9bRdvx89duuOxwH0LLsGAkuwI
Message-ID: <CANpmjNORsF2oExcOphnGgnTt3hJEWP0tB6zua0sTG=n7gJbEZA@mail.gmail.com>
Subject: Re: [PATCH 00/27] Enable lock context analysis in drivers/block/
To: Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jun 2026 at 07:34, Christoph Hellwig <hch@infradead.org> wrote:
>
> Can you please split your series up in a saner way?  A bunch of the
> patches for drivers with their own subdirectories could be merged ASAP,
> but you bundle them with lots of unrelated bits.  Similarly having
> a standalone series for drbd probably makes life easier as you don't
> have to CC random other driver authors on it.
>
> Marco: is there a way to enable the context analysis for parts of
> a directory?  I'm not sure that always converting a whole directory
> is going to be feasible in the long run.

Yes, just:

CONTEXT_ANALYSIS_foo.o := y
CONTEXT_ANALYSIS_bar.o := y
...

Alternatively, if most are to be enabled, and only a few holdouts:

CONTEXT_ANALYSIS := y
CONTEXT_ANALYSIS_foo.o := n
CONTEXT_ANALYSIS_bar.o := n
