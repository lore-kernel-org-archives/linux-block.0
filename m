Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8550A1F600
	for <linux-block@vger.kernel.org>; Thu, 11 Apr 2024 01:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712798680; cv=none; b=V8yX/gSz5vWnpFssZ2J9DFN1Bs58PHUr/orSj0UwnsFyNVQcNnUTNk/ZkYtOjLK9C9BDyDqo1NC9zdDpfaroDzHXG+YNbu2GzAGtl7J7xO+L56Rys6oyg62ZGCS7CH8akRsCAM+uTXtpG8d/TIizM1ncy6OAL07UVyiYwyZrq/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712798680; c=relaxed/simple;
	bh=yp1k9VTm3f4BSddgU3u2LXsXNYiAcpGBztaX4F4dVCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hmG/iQWQjAlNpz0PNnSZLzEGyODnlLZhvWQWiKuHo+srJ5KBfOhDu6XDCg/pqLykeEmao8NW5ZOdfRSXtAn/ZJw3KiAtrS9bT8SC3oEsa/nDx89NXk+FjFfNbGl7e9uxGp+HTsLNyIwE3LYWMzDLNee8LXDq1K9XUOO/hW/UcVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nm8hLq5o; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nm8hLq5o"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4db10f7970aso398767e0c.3
        for <linux-block@vger.kernel.org>; Wed, 10 Apr 2024 18:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712798677; x=1713403477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yKWZpJ699ybogaYOH0MhsiOSasgbjtim+qJVmbIjKA=;
        b=nm8hLq5oIhtuakExOslDl9tiOJsPgsVaUzezSDV2YKN3DrhuiWzxmxnz9+PSRcdVch
         sUzXTvpGAFXCkdV2MTVkddkKohI/bTBB3xbI7pxuf3jNnPyAAZTDurSpdlZW2tCF2yeK
         n/0pg6ErdlHFQvcKmMw37pvZ+scNA97q/Rgbtpm889or+joRT1lFM61zcP0Z79pC7sc5
         zfpXDLAWOUfr1ph1iH2MIlDSSI75QWbBAFT7gDCupE5StF3DlBPeqsow2vvkYPwRkhhB
         5iiiI6eKjIi56DVjfgR+ZCMFAOZH7DMjiZFFLatmYdoAUxi+aVBQy4gOYrb1mmk9lFJA
         aR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712798677; x=1713403477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yKWZpJ699ybogaYOH0MhsiOSasgbjtim+qJVmbIjKA=;
        b=TlnzWxh9wdbcomcPaAlC0ouMdFL481jCjcMB2FmL/9zcrt3IO4sTI740fTl4f6a/NB
         njU+V86mg1YGdxK7caj6upDrShlJZy2aGUi6nn78HNbhjSCqLWo7yLHW9pFz3bEy6/za
         XNLAzg89ITMow7Hs4VXBthkWDRrcKSwBW1fj/dYO56oy3ayBFZT3xZ9NLWQKL2EjrBGj
         MaBRmuZQXnFL3Yre25cYJSgAP2UjsWoLsoH7KXvTdG2SuqwniOYfJSBus7rgcK9Xh7lE
         Y7MHrd2E+ZGZQ7qj4NO+08zHri6tiXHd6rXcd2/jioBTrjEwoXX9DMhChwAlmxO9L2dv
         /Hyg==
X-Forwarded-Encrypted: i=1; AJvYcCUF2mqh2Sn49PeRw4tTvCpeietGJ4Gwl69zKjKtnw4sH4mq+8JLDp5EU+7wIfqVK0vA0sM11IKdnu7M7j5RvQ6GOXoyh1gzEP03QEo=
X-Gm-Message-State: AOJu0Yxz7Fn5kU3R+XAmprExX2srXcafMC47+s3CmHCORBo0dYA72bR2
	WSnAivltyZznWRWtwrP+DAlYmaalkw2ujfZ8Ovic/69tQNAhYRIOS/QtJvl681hSnYzavx4gCPo
	me6cQG2yrJXItjuZZaRdJ+mZWnqo=
X-Google-Smtp-Source: AGHT+IEqDE92kK5vjMNlj7NgFV0G2NKCUkrB4T8FG1hzniRORGjFfj/aBLbGkdiB8MnpgH/ICqdHIwpc91C4/u+9RXU=
X-Received: by 2002:a05:6122:91a:b0:4d3:31fc:4839 with SMTP id
 j26-20020a056122091a00b004d331fc4839mr4409139vka.2.1712798677359; Wed, 10 Apr
 2024 18:24:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327214816.31191-1-21cnbao@gmail.com> <20240327214816.31191-3-21cnbao@gmail.com>
 <20240411004057.GA8743@google.com>
In-Reply-To: <20240411004057.GA8743@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 11 Apr 2024 13:24:26 +1200
Message-ID: <CAGsJ_4xrqkoPHNwdS5TqhHNNod+tc=s6VdWBhCGp7DVQB5Yb1Q@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] zram: support compression at the granularity of multi-pages
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: akpm@linux-foundation.org, minchan@kernel.org, linux-block@vger.kernel.org, 
	axboe@kernel.dk, linux-mm@kvack.org, terrelln@fb.com, chrisl@kernel.org, 
	david@redhat.com, kasong@tencent.com, yuzhao@google.com, 
	yosryahmed@google.com, nphamcs@gmail.com, willy@infradead.org, 
	hannes@cmpxchg.org, ying.huang@intel.com, surenb@google.com, 
	wajdi.k.feghali@intel.com, kanchana.p.sridhar@intel.com, corbet@lwn.net, 
	zhouchengming@bytedance.com, Tangquan Zheng <zhengtangquan@oppo.com>, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 12:41=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (24/03/28 10:48), Barry Song wrote:
> [..]
> > diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_dr=
v.h
> > index 37bf29f34d26..8481271b3ceb 100644
> > --- a/drivers/block/zram/zram_drv.h
> > +++ b/drivers/block/zram/zram_drv.h
> > @@ -38,7 +38,14 @@
> >   *
> >   * We use BUILD_BUG_ON() to make sure that zram pageflags don't overfl=
ow.
> >   */
> > +
> > +#ifdef CONFIG_ZRAM_MULTI_PAGES
> > +#define ZRAM_FLAG_SHIFT (CONT_PTE_SHIFT + 1)
>
> So this is ARM-only?

No, it seems that this aspect was overlooked during the patch cleanup proce=
ss.
Currently, our reliance is solely on !HIGHMEM for the safe utilization of k=
map
for multi-pages.
will fix it in v2.

Thanks
Barry
