Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB4F2DC34B
	for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761594693; cv=none; b=rU5UCOfdYbqt6OE8UHnxpOtSTAfekusNwmwwGVt9y/TUreQpmFqcjxcO76JZ05D+IISQoyCSSEwxLB8xeVa/iJG+qBOzv8QdoGI/mH7Oz4j56q8nb8n5B/DDraBxfwHHMpOVunp1cr72ye/CaQND+spA6zOCzuHfZSbLZV+PIIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761594693; c=relaxed/simple;
	bh=LUw2mZCfH1yOBKTSy9rxXAh/jPqUNSJVBaTxVdNrEJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MyFjc8ZKMLVQv58fRLQq6o80hJwHTaZmDLWibQuowsrYUe79ewl1Hjrx/Fp9Wor1u+EKVDadIRzgOPAhwTPDDYE6vIgpZy8eYrrn54e6JKKm7yI/CdHNMDnIY0W4GGqXChrHd7DQNZFKfAICGnr+k/fEv56GBa7U/YFbScJcL1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v1dlgCdz; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v1dlgCdz"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ecfafb92bcso14831cf.1
        for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 12:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761594690; x=1762199490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUw2mZCfH1yOBKTSy9rxXAh/jPqUNSJVBaTxVdNrEJg=;
        b=v1dlgCdzKU2VKZ0tcQYZU9PtfJ+TzPScfLGl+vxfqtwwDx0Fz+gyS9RMoEkK5uhdHK
         IrQDFjyE1qTvzqKbCEq0gE0exVZVi+yT5xqrRJglNH+CmQy3pcG9S+6eJ2TOZsm/zeIh
         XVg4KCVTqjx1cpxfvOgqZt38KgeyUYrobhQZ3Dy4ti+iYalFFqeezm1IsXOd1p3Lq1A5
         KAZ3xncqNFuv2fvLLofC16hE0gxVIdegvos6BuV5yYi5cD0r7t2KWIgM5bXT9yFueV3N
         3EP5N8TBda13BOaWSSA/3htFfO8sq5GMcprsQ2b/3rZ+7IZgbSi+GbFAIukNi1k0mYUJ
         7AbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761594690; x=1762199490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUw2mZCfH1yOBKTSy9rxXAh/jPqUNSJVBaTxVdNrEJg=;
        b=NXEj0xgqUjkgEB6pQOw7Y0PglEYdOQoP/Tun9Tt7XhOg7V1AwdHEv/8YGQHbYIegYo
         B69BuUtbCY7IvRmUXCG/wEXy0Uj+tFxlLEL4Va8/8nw0c/d5wZBHSZEtvCWNDxVhrpBA
         F1C6G2D1V+kVWUr3Vzu+OBLc43eHaqk2ChFv6T2VWJMoXfCvTzUNTvGfx6q55F9zKdEI
         0+75mD46qvoYkH5XK7QYwCwv/M+6DfFR7bjLgac2rzmg1ZlG37zi8QKw87Wwgiqa23XU
         1MK9fpalGagub8lH6s2tSqczrBFdcF+/k5+NVQW+5Zy6aJQZSsCbRlxZyBnK40A1/cs0
         MjEw==
X-Forwarded-Encrypted: i=1; AJvYcCW7XIaZfMdooLQMOcqX73mMjTBq4dujl4luIAYul9cycs5vW1jrkwsG5cr+40Qor+Vqbxd4Y1mnCj8GVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDrPt6/BWwXGFh2xIwybBRp5coZWCDTHr7zzAVADjjrDFBMl2W
	jwp+Ier/uVIog8X0JzhRns+7r1afWkemUUNCL4euHIbszG7n1a9OgbMHFMIq/X35p358rqyIMSa
	9WBeovtBwW3egOoDPjBICb5V+TRijdO1GCLsuPsqu
X-Gm-Gg: ASbGncui9wbqV1Hhu3623o0GV3xTm1VZHZDxKdXQ/t5F9qSZtmqM/+D4qJ0DQ6sxGlK
	XHR0gMWAomGVc4pRlQtwVk7aaHHh1iACMXlaMv+i0tF0stTAdcZEyyn7xMD0RK87aF/lJm4ippe
	2rzg5PyXgUKP4tNrfNpSf+ELEQNx4TRySoOPTc0Hv4su5Yu1qfKfsbeNrBbBvq0eROqu7HvZ0Wj
	YFs/dB6jUVkRPhm29V9NSCWlacf/W4MEtipgndpbUZpN/vSOaLouP0eSOOPfpaij2rYeA==
X-Google-Smtp-Source: AGHT+IEmicxEYEPLgQn38b6v1mJfTIvyLMT/qtHkmyMNLHlEBQmcYJx6gF8JYoLZrM0kAWrtv1hez5d7WlrSFzFFVW4=
X-Received: by 2002:ac8:7fcb:0:b0:4e8:b04a:82e3 with SMTP id
 d75a77b69052e-4ed08f1af35mr1416621cf.10.1761594690047; Mon, 27 Oct 2025
 12:51:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026203611.1608903-1-surenb@google.com> <aP8XMZ_DfJEvrNxL@infradead.org>
In-Reply-To: <aP8XMZ_DfJEvrNxL@infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 27 Oct 2025 12:51:17 -0700
X-Gm-Features: AWmQ_blGO7QUW6nBgXPDBNUnzq3Ln5ah_SLow5ox4iXfcHmzA4G72ZsuhQ4Fq80
Message-ID: <CAJuCfpH1Nmnvmg--T2nYQ4r25pgJhDEo=2-GAXMjWaFU5vH7LQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Guaranteed CMA
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, alexandru.elisei@arm.com, 
	peterx@redhat.com, sj@kernel.org, rppt@kernel.org, mhocko@suse.com, 
	corbet@lwn.net, axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, willy@infradead.org, m.szyprowski@samsung.com, 
	robin.murphy@arm.com, hannes@cmpxchg.org, zhengqi.arch@bytedance.com, 
	shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 11:54=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> Hi Sure,
>
> jsut as last time please don't build empires with abstractions that
> don't have a single user, and instead directly wire up your CMA variant.
> Which actually allows to much more easily review both this submission
> and any future MM changes touching it.

Hi Christoph,
I'm guessing you missed my reply to your comment in the previous
submission: https://lore.kernel.org/all/CAJuCfpFs5aKv8E96YC_pasNjH6=3DeukTu=
S2X8f=3DnBGiiuE0Nwhg@mail.gmail.com/
Please check it out and follow up here or on the original thread.
Thanks,
Suren.


>
