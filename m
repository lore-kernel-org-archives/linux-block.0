Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66300385D7A
	for <linux-block@vger.kernel.org>; Tue, 25 Aug 2026 07:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787641708; cv=pass; b=po/2ZkPwKRkhYcgx/31qD4Bo1PyAf/937ZClU/KS793vEzGHhRTejKvyMjs8DirB3y4v2LEQHHDM3kxvJUszNMg+vs8FAu9Nvzoxi7QAEuEGlG2K6m8qokTIc3CTO2ghQ2k0kfd4pfXpsScauX6Pxi+KxiDBk45S0ZKn1EB8Hxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787641708; c=relaxed/simple;
	bh=YLC6H3tBQW6nRRMf6LiPtQJuL1Ra+q2lA0+1KSYOB+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tM3/sVhzQcMw5jcM02N6eaggpZfncgxIqQBgmwXTgjpTMIQ0H68StKV4IoulzLH49dxr38SSm1YRVBwXm5nKD8MC8ESaZZFJGc9tnILZdKWBiWCd6IFtRwqj8vgg8GNtDewudjc0E17FmeJlj1Js8LlgLuhpLHdNvLjPZvj1ReI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=QDR9SP0L; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="QDR9SP0L"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c2a449c57so25153261cf.1
        for <linux-block@vger.kernel.org>; Tue, 25 Aug 2026 00:08:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787641705; cv=none;
        d=google.com; s=arc-20260327;
        b=so6G7uGp9yK6NUMiHRGEE0qjl9tEYnzL37ABzV7sBN9tbYZS7vg2XXOUoR7XkuwN7j
         NjGQ/RcIFvv3SAnWUVi7hZ/Ox51T+nYpz2R+/YYfRHnUlfXM6cKnAITje1p3gvWDG3+J
         EwdSKYRvmiVu1mu07Vz/htj6AphussILL/A4VvYbZeUjXtaKchAmSPZhUv6bIwX9tqnf
         ZGcLORlVNDdh1X/RpYNxQb0xvypcH+OGiA5Pbn6A3x21IXxBZj6ZTdwNNeeG7pmjsOE3
         Whzy7q/UIolsjeh5wE2SdimhcVCQUMSbyweqsctP/U2rtr+fldDLOx4b+M5LiYRGb9s9
         7HUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FUPUaRwtppzW7Cz0zNlhCOY1JMoitTGaOwtquxqzhgM=;
        fh=qsGpku+8Vw5jpU/iZ7i+bu19+4TQHqLfiL4+mhRF8qA=;
        b=hkX4H0dVsrYTTy0FMqpsCTWiDkoOEryfhOekzi27b5h9uK8H/qEzFv8nbSrjjJ0qro
         24HjONVHPEuGWZT6z0uaKsc7n0RyJDNw/HqD5Yn3eyU7mLkg591fJ4sNkzlLF5pp9O03
         Z7qEC+WnVquLqT8PvkeS6QIDB1NJWt7s45vJPlo1/ly6DFdKNNMlumrDlWB/60EmNk3k
         nPDT3aguU+l7QTUJHK57CPyCw4cda07ErkA5uYnU9IrliUv3+IHBSZie5vm7daIqDVut
         RsXR5MexJd098+qX1vik/HnxEV4yl53MUy8apNYgHG0/l7a0kSGYA5xM94M2RhagnrT7
         BZZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787641705; x=1788246505; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FUPUaRwtppzW7Cz0zNlhCOY1JMoitTGaOwtquxqzhgM=;
        b=QDR9SP0LBmea2rHSDTV0eo8peqwJDbaSjDSIZdSl90nnAHn/gJupLYGgdHr2FxtVq+
         SFDyJ7cJsc2jPxpn8+S470xOxvgH5AU7+nX9O3JJbgHdOwXUhvfjaj5Rr55JBmEDEWwU
         OsBctqdU+N528P/96TDw3jhV6lMu/TzDWDAr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787641705; x=1788246505;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FUPUaRwtppzW7Cz0zNlhCOY1JMoitTGaOwtquxqzhgM=;
        b=TNM+GF7uJudCiIFcXXrteqdTiArvZ32lsXJZpCAOGgxhYSesjett/QJycRlWR0IMzD
         MfnOP0jmhM2QVTW6ELysbWTlTk2+OxYRhGzpj1v8IGIqhGMmKN2NB6FY7ZdKoSsjiGdk
         89EQ/vrGGIBwzri9+x6uwMMHsaPoN7JN2DH60/7wYXsAqnpY1QvgobLLo1MymdxRvQ8t
         bQ0p8vwFp7xmBuAS6L+j7/auWmr8fuy19cyX0X5VoFX/IwOie9Ezu2Qpsdplx/DWII1M
         36Za/tQVqz+Lk6tdIopdeyCLHwZ4qWSf64LlYLwcZpTtBBAJG0C5FqjMPHx353EiFe0U
         mHbg==
X-Forwarded-Encrypted: i=1; AHgh+Rpo03NacYGXnOOBqar1fWlzofvj4J5OPFkzvgK7IMA7X0kA7f3Bu9nbVQitsTeMvHDP0F92TSu585KhHA==@vger.kernel.org
X-Gm-Message-State: AFuF++kNeI03DB0J3KI73oE+jyltJBg3yES2KuIEC87P5NAZ0O3SMSq0
	P2B1sVAVcdHe/YBwaHZ3t0HIR6Y7zjI5uwQFxHCKL0aXNbEmeh/6BtSwzUtygM8Im+rfhVuvwAG
	n+IpimRS5tYiJfyuJ8eqLnC6sk3ZqsZ3nplpAeKaVrQ==
X-Gm-Gg: AR+sD101jrPMN6zc/jaMAb4uH7z1vpRY9+acTDNePSaxDvQB92IBNijwJJSooh1/jVM
	eYAlnxdxVqlTihhdkiqzK8Y6z2dQc61rJMFYkkw4D3EQw7JsCar+5HXrmVQG08HDrynXxGdeZPS
	U4dMS3exvPKI946UysaMeHfdrdya1xNYYWoIvm2bdzAAiu+HSfsGNjyE2MbdMknGdOgAC1EmtLt
	sXVxbcrrqJHVLmhkRLIlfE8QVu4lrgNhcfK6uGm+TForHoA4gPt+ub0UFeCdQEDLQzp+tUhWpd0
	mD4Ns+y91g6+mr4PFLvLUSVuwlVt9dYGoRfnjvU1iXoqWhV2B1hKbmfrGymtasPcA1aXBCWxotd
	kOLM=
X-Received: by 2002:ac8:5f53:0:b0:52d:6afd:7db5 with SMTP id
 d75a77b69052e-52df59ec0d3mr342600351cf.25.1787641705339; Tue, 25 Aug 2026
 00:08:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820193343.3852967-1-willy@infradead.org> <20260820193343.3852967-3-willy@infradead.org>
 <CAJfpegvP3i8ZJc2T=+f4rAhZ4E1QcT5+jC6mQPLxtB-yoK9Brw@mail.gmail.com>
 <aoxHOSC9kTPbKeNq@casper.infradead.org> <CAJfpegv3Ak+qNLb=fTSCSz7-taQ3Ui-Hkmqgn4PaGPe=CR4cbQ@mail.gmail.com>
 <aoyKxvdQdeJQfPHj@casper.infradead.org> <CAJfpegtgenUaudDcvecJuV2_WkkVw=gdcB0Eqg=UFKPMZP1uKQ@mail.gmail.com>
 <aoyt5pL7mXYwSqsG@casper.infradead.org>
In-Reply-To: <aoyt5pL7mXYwSqsG@casper.infradead.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 25 Aug 2026 09:08:13 +0200
X-Gm-Features: AcwNN1VLOxg4TFDsQzXPHVySuwqrEIZSjxOFz1CuAgo80c2cUSWOrt0F79eOWzI
Message-ID: <CAJfpegv_SKhArUNBFUtsmkXSn+JzYgOjhFOqVf-Yd9MnsjBY_w@mail.gmail.com>
Subject: Re: [PATCH 2/7] fuse: Use filemap_invalidate_pages()
To: Matthew Wilcox <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-nfs@vger.kernel.org, 
	devel@lists.orangefs.org, Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Aug 2026 at 22:47, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Aug 24, 2026 at 09:33:03PM +0200, Miklos Szeredi wrote:

> > In the second case filemap_write_and_wait_range() won't write protect
> > or unmap the page, so it may become dirty after the writeback.
>
> But that can also happen in the first case.  page_mkwrite() can be called
> immediately after the folio is unlocked, for example.  Or the folio can
> be evicted and replaced with a different folio which is then dirtied.

Let me try to make up a very concrete example.  It's not realistic and
very unlikely to exist, yet something more subtle might be relying on
this behavior.  I don't know.   At this point I'm just trying to show
you that the two are really not equivalent, not that this has any
practical significance.

Let's imagine a distributed filesystem based on fuse.  It wants to
serialize accesses to a file to avoid sub page writes reverting to
stale data on cached writeback.  Cached writeback is unavoidable in
case of writable mmap, so it tries to handle this case correctly by
totally excluding cached aliases existing on different nodes.   If one
node reads a range of pages, that range is invalidated on all other
nodes.

The below example show store to a single page on node A and B with and
without launder_page, starting with both having the page mmapped but
not yet in cache.

1) with launder_page

store on A
  - send READ
  - server checks that no aliases exists
  - returns page
  - page is mapped in address space and dirtied

store on B
  - send READ
  - server sees alias on A, sends INVALIDATE
  - INVALIDATE is processed on A:
     + page is locked,
     + unmapped
     + data written to server via launder_page
     + unlocked
  - returns updated page
  - page is mapped in address space and dirtied

 store on A concurrently with previous store on B
   a) happens before page is unmapped:
      - change is written by launder_page together with previous store
   b) happens after page is unmapped:
      -  page lock waits for writeback to finish
      -  sends READ
      - server sees in progress READ on B
      - wait until READ on B is finished
      - sends INVALIDATE to B
      - ...

2) without launder_page

store on A: same as above

store on B
  - send READ
  - server sees alias on A, sends INVALIDATE
  - INVALIDATE is processed on A:
     + page is written back
     + unmapped
  - returns updated page
  - page is mapped in address space and dirtied

 store on A concurrently with previous store on B
   a) happens before page writeback:
      - change is written together with previous store
   b) happens after page writeback but before unmap:
      - since page is still mapped, store succeeds, page becomes dirty
      - at this point we have differing cache contents on A and B

Thanks,
Miklos
