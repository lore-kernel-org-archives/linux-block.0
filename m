Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94152E7635
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 08:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758185959; cv=none; b=gpcK0wygbFZW4ddklulsreR1VIHCMtgp9Ue+kEUTK1XCkGOy8WtmJJbZmUJugEMMPOoEF0cX7jSOEjNzSz/93gziy1Y4XpV6cg5XEokxVMJOdW3guwcdXEZ+NGq5hwKNyEXQ7JfBWFAgYMf6/nt6sv1Z8LUq5CD8Q4QzyEzyw+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758185959; c=relaxed/simple;
	bh=unL9Ce+kEywQKcq5iWYa3vbSFUfdn9EBm190tWDHYvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IjVm9WVR9BR/q4aRVYj6wCoKURLTW8wol696H/RkfNCDj4ViG4I8I9iIf5R/CuRBL5rC8tKETWqkk6Lhf7mtdEp8H3XdlOx2r5vh94bvtJRviqAxgAWW9Zt7uZY2eo+sSyB0YTVbpdlNDFyvxk4l+IBM2jqB69B8lK84sDiOpfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Mmz+ItoE; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Mmz+ItoE"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-33c9efd65eeso6237811fa.3
        for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 01:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758185954; x=1758790754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZmPfoqG0iiG2NY0syO47mgLNSYwy8f5A2cvO3evi8k=;
        b=Mmz+ItoEJ8Z5FZjMt2jY/aSr7oj7aThqxij0DZGgtkpV51YMDfs+oOc9pN7riJusai
         008GZweo55Nm685yDy89CgCNv9YeDOKh+QxA5J18FyL18fVpVMpf0hr84bY9bkv0QdXe
         jjk4S4w4u6AfRVBW7q3oYYHG1kTCA1RWpnXQBY/i+Gj3LC/M4fQ8I5eA0o6zDg9qOyya
         q88vhmkHR/nb5sXWLjHy35L4KKFutVNJuW1f48ojOQByMKnT/6ArYiu2YP+fF/KGIaYL
         MyGPQYCycEFTZ1m7wzspDMSqLBtc90IJsbX8WtVlT/2JJrqCFRa5Oxw925bubOrqktIW
         /tFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758185954; x=1758790754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZmPfoqG0iiG2NY0syO47mgLNSYwy8f5A2cvO3evi8k=;
        b=REQ5ga5MBt1O5MHuylGyr7JeutQ4xwzgataJUbBMTjrO9+ui7jk0LMysSlEnlVFQUn
         urteisrv4JkY3PpVbAkraV/dznHt3ydTSn1UOTpkOjGQa2uKGvKxAVC7oxi1t0Bf/F9l
         cZ8HNO7pyEWP0wEM4mwoOftVqQ2WuNA9PCwtiowBqbaw+9FrDBggj7Udc5ao+YIiEq8X
         F4m2bEa7KwwBdBU4Th/HXrgFlkuHFM6vG7UR81TXvXlLid6crnhos58BmzFJC97vvBAG
         769kOxb9qXEdKVxg1WXgAn9OKVejEOsI8WXm7jMLqrh16o0rKi9JgmoNByJrFEYSLBPf
         76HA==
X-Forwarded-Encrypted: i=1; AJvYcCU89ZrhMOBTsg6z2yxnNCfZXKP3Lg90SPyrrSMV1pZmOCieL7hkY/Mk761S2ERCzGrC9e4F+oPj0P2GoA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2yzPqZQbiqsBx/cPM5kMfCJg0VG880ddyvbShanaJAnvPxwIn
	h7mtQtLPB/jmawMVQp51kq+3HmayX9tu5DJoLiZgXBZXJ8ULqf1v/5jQ+M8PA6d496kDtlU/YpS
	ih7GD6K8y/gls1Z5fMytvvoWnt6yKFm64YMMsePH1AA==
X-Gm-Gg: ASbGncvlsV44lAFuxA+ylNWTz+JIiNcM+LqstShKdSC82JzK0hESOXdWCjkF1gYnsEy
	p+9s8oNylz44NeiKHlYUSAgi9TY4LIYAMyP0/hq3I+Z/PQuKadzQGQT1Gtw8sbA5nF1yJjNg7eO
	pY2dOKzBAvKOjhPO+kd+Pow1T38//6EuJoZkI/Nf0wXQF4YfhuVOeWCdlsYaN0xr4W7ioIgDKGx
	N7LMs+bxijRwJ5TJPO1/4Xc3GRMoqVN524ktAt2/B3JUhKP4nBEerDDxQo=
X-Google-Smtp-Source: AGHT+IE82AqZgCsTk+PY/JWZbreeNfzQ9NGfzRX+YkofNIG1aunevV+FhkpoCPJrFrn6mDCYgSk9k8Ijxcn1IEQSyeI=
X-Received: by 2002:a05:651c:19a9:b0:362:75fc:4681 with SMTP id
 38308e7fff4ca-36275fc4983mr4139801fa.29.1758185953688; Thu, 18 Sep 2025
 01:59:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905085141.93357-1-marco.crivellari@suse.com> <175743072839.109608.9014903338772554601.b4-ty@kernel.dk>
In-Reply-To: <175743072839.109608.9014903338772554601.b4-ty@kernel.dk>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Thu, 18 Sep 2025 10:59:02 +0200
X-Gm-Features: AS18NWDpfZjLQbuUq82kSpsqAhb5CTGCYTAr0k0mPYelJg4h9GAlfvANjno1wMM
Message-ID: <CAAofZF4ysVOA05j3NeieeyPgXjJ_43SEKD=mHPrCz6eF4qXhTw@mail.gmail.com>
Subject: Re: [PATCH 0/3] block: replace wq users and add WQ_PERCPU to
 alloc_workqueue() users
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 5:12=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
> Applied, thanks!
>
> [1/3] drivers/block: replace use of system_wq with system_percpu_wq
>       commit: 51723bf92679427bba09a76fc13e1b0a93b680bc
> [2/3] drivers/block: replace use of system_unbound_wq with system_dfl_wq
>       commit: 456cefcb312d90d12dbcf7eaf6b3f7cfae6f622b
> [3/3] drivers/block: WQ_PERCPU added to alloc_workqueue users
>       commit: d7b1cdc9108f46f47a0899597d6fa270f64dd98c

Many thanks, Jens!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product
