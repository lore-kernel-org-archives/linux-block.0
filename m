Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E481DDD1
	for <linux-block@vger.kernel.org>; Wed, 27 Nov 2024 01:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732672414; cv=none; b=L8DlMaYadYr4YCrH9ncEEgpSrxEp0XtEr33sZ3wqddzcOyCCtwHaD3pZ3XzlTEgt2rVVsWY/Hugt6khDsaoJdo02BMenoPFvdP9XdvDzQD7tWIsf1T4hlFX/5zLMbkfGhMNGXo0sIw9ZSdufEwIStCPDGFhQ/xafTjOj1GuMSV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732672414; c=relaxed/simple;
	bh=eVUXPIhoEQ9sk5EuUXjHFl7x2GIOm63QuXMXe4UU7/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=coSiKc6SZpc57x6F+tu2A1AWLsIWIC6dOoabYID+nDcPkzeu7VJEIMuCOhdNKkeAzxdbuKLdxO8sbRPBo9lFEgg4qM8nN1blW5QrHJXtfRTbo5wLnPM3GzROQXrazVFUkeVsBTrvQ1W5leutwdtMWF9axPzQFfJ24Qcs5COGX58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CD7yKNsi; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CD7yKNsi"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5154fab9889so290738e0c.0
        for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 17:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732672412; x=1733277212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0AUCCL/mLvRf8gjgbHx2zcR9CYPuwNLmm93UWFUa8E=;
        b=CD7yKNsisGrKn1a9OsNpc7IwT8QwvuPxPozz1NUdMI4gzSLMqZpywnvu/vxsl5FOyM
         GOI6bP5Bh+CJQg+yf+PwhPl8TJQcjrM89BvWNIPhc3UZ0ecr62ceHhBwoNRYre9T1koJ
         7DMUgUNkxkVEfYFxEDXIKv8mDTZOhyrz3Bi5HIspJeJdjI9XMC2kt43qxHYTPfATkFAM
         XjZEobWDy2ak+j3LD26ObFPrjNv07uL9fSMo7DJ8/a8jZI22BKM+YOyyT1MC9x1J2S7E
         nzzN4gsBTgMAfG9oCqTO+GWRLM3zUWJTTbi3Ql+dMjeDpjwEbk5+UUgyA1ibQSJHQMB0
         7lVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732672412; x=1733277212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0AUCCL/mLvRf8gjgbHx2zcR9CYPuwNLmm93UWFUa8E=;
        b=QZc50rJSLqGZR4wNQGDH8YOZ8pI6mf/Uiu3TvNkIzHCJlIfPDW8KnTJtoPEB+nkbYT
         +OzED30aN2fRBl0wGLT3xYh3CpfgESEIXJMR0tRmlqUwOJFfqMgpPiFxBZP5sUikqC/a
         nR+PrsgIP4JhZ2b4/oyi6CzjHV5/v5MfNIcnCUMJBWles382nv7jz49YSzk8bsJn1QyQ
         r2c9G0P/xoHmhHAYNAsnUwXAjrreY3HdvGakWUMi7Q2mP0ALOIuIv+wqTJL13PPpIs8m
         lxOuX3Yi6tzOd+JUI7VkfK/HZpnV6aUsJpGIcGQxL/V3FxmlMU2i7i17011TkndXL8gM
         sVeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIQ/E3+JD1QHlqCJdSwlHHY3AP9sDFWnGf36+c5VV4CReIbD/p4VUMlEFBC50tCX22Qip+0X7mPrYSQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyokE361LH4PqjHHsFOxDq2bOZBxp62PaDvG/P8oVT6YDfZHvab
	mBIlMhc40af3kG0S5R8Q0PdV+qwKuNKABwTuUudmFeN6g3bHNtV2dOGqyZnon0AEN0/7FCtfO1X
	ksAi/Ql95piq34u0ycLD6ugS6BcE=
X-Gm-Gg: ASbGnctG4JkwcP5/sFuQbzFeCUi6JfulVUxWoHYV4/UUUWkKRJ1LffQh+Nnjm3QCe68
	/eUL4BnCfgAV4aVfjr2NZGuox/jkGeyUVYhJ+1/iQXfuekRbZY1NATF/Y77JGrnsYaA==
X-Google-Smtp-Source: AGHT+IHdvyNnYVVhR24K2o4YcAKXe8qa4dBbKhzD+IJnr3jWjTUCAuE9PZexcBsndRj6uGAnMgkixQeVHn8RauTLJ9s=
X-Received: by 2002:a05:6102:e0a:b0:4af:3f28:77cc with SMTP id
 ada2fe7eead31-4af4487db32mr2222713137.10.1732672412247; Tue, 26 Nov 2024
 17:53:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121222521.83458-1-21cnbao@gmail.com> <20241121222521.83458-2-21cnbao@gmail.com>
 <20241126053701.GD440697@google.com>
In-Reply-To: <20241126053701.GD440697@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 27 Nov 2024 14:53:21 +1300
Message-ID: <CAGsJ_4w0E1sJtR5BjGUPjD-mr4hehoL9kh9Yyan99Zi75GVP9w@mail.gmail.com>
Subject: Re: [PATCH RFC v3 1/4] mm: zsmalloc: support objects compressed based
 on multiple pages
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, axboe@kernel.dk, 
	bala.seshasayee@linux.intel.com, chrisl@kernel.org, david@redhat.com, 
	hannes@cmpxchg.org, kanchana.p.sridhar@intel.com, kasong@tencent.com, 
	linux-block@vger.kernel.org, minchan@kernel.org, nphamcs@gmail.com, 
	ryan.roberts@arm.com, surenb@google.com, terrelln@fb.com, 
	usamaarif642@gmail.com, v-songbaohua@oppo.com, wajdi.k.feghali@intel.com, 
	willy@infradead.org, ying.huang@intel.com, yosryahmed@google.com, 
	yuzhao@google.com, zhengtangquan@oppo.com, zhouchengming@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 6:37=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (24/11/22 11:25), Barry Song wrote:
> >  static void reset_page(struct page *page)
> >  {
> > -     __ClearPageMovable(page);
> > +     if (PageMovable(page))
> > +             __ClearPageMovable(page);
>
> A side note:
> ERROR: modpost: "PageMovable" [mm/zsmalloc.ko] undefined!

My mistake. It could be if (!__PageMovable(page)). Ideally, we should suppo=
rt
movability for large block compression.

Thanks
Barry
