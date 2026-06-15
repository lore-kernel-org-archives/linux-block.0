Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F7C3D45E9
	for <linux-block@vger.kernel.org>; Mon, 15 Jun 2026 09:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781514860; cv=none; b=AHI+vf2bfIZ/eBSuZ9/sDIAzTWyT8aJHj/uUvSdbApM28LsjE7WyNd634whqEeu1uH5E/0Tl+o1tnuPec6O2oLCt50dkrSa8RFKtz+8TpY0ilTdw3kUsJ9UDCLW371D77k8tGRIoldNDTHaAORkQlRg4mXfLQvBlsaiaMtf/d2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781514860; c=relaxed/simple;
	bh=rx5i3VPx+4mSWrjeoJRSdziRvTWx22OnIiPlAdlXaJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=igKMtGM3dOrMYzeEnPE3icscqsllNIKlwIUrrs30s6kwIp+0Y3EkTe1dCXLChUS4JjqOhmsB7w9msZ+CIcmPhVj1bTcE+QlCSRLJGtRpac+BbFBVCu6kVtZmQESaUAABozPj6548oq9vTshUwS0RVBLB/vmUD62YlfTwVIAsvvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azP4Du+/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azP4Du+/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770351F0155C
	for <linux-block@vger.kernel.org>; Mon, 15 Jun 2026 09:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781514855;
	bh=uUJeAFXXt09c94jeT887u1t44BQncrNmZQ1/OxLwVUA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=azP4Du+/WiFT2KFEJjOrb5bzQ7OtlZDZoUD3/x/vY1dO97ql6KH1AGH5GnUfgnLYf
	 UzC8zmGIJguNr2TysIs/I5wsGBxtVoY6YtwPCrmanZPmNEckaBzL5S6ebR5xXGifs/
	 7Du7ddXDj1jqRtsEOW99zvWz/qC9gxhj2+8nHvCX2wx7fPiVQDe3ZQki19GfzuMvy/
	 DbRCHas1IeMPV7SOBjp/jOxhXBxwzKObbA1so6xSlyBZRGvdBIiud5+kxoZZEIS7WR
	 eKUtRy6tLlsw66ok534YGQNNARna6sZRB/RnjMhtmMB0m94GlERUsyJJpsbcWQyk7c
	 yIvCenSjn5/5w==
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-915aa0a9293so400868185a.1
        for <linux-block@vger.kernel.org>; Mon, 15 Jun 2026 02:14:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8ngF8BqVYnbXPWiqBlpSthU9OBYG5pkRW9hrm5z5aPv/LTxPyNxqBcan1r4sQENPynFlXP2gIME4u4JQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0aZociLHvteLIHjL+0ODGzzyrz62d1N5wbO9vg8Ac2k4t35nX
	9LWZUEFHnkGEUxQcK9l5Lr2LUcsAjXjbnIGLvQfjqCy57rG8gquDM1lv45pp7Ummjki3/dQpF90
	VSWt92QB87JtlFL60Pm7raLvxpcTw1X8=
X-Received: by 2002:a05:620a:171f:b0:915:e8fc:1396 with SMTP id
 af79cd13be357-9161c03e623mr1645007385a.13.1781514854834; Mon, 15 Jun 2026
 02:14:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614-zram-swap-ops-block-register-v1-0-6c1a6639c222@gmail.com>
In-Reply-To: <20260614-zram-swap-ops-block-register-v1-0-6c1a6639c222@gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Mon, 15 Jun 2026 17:14:03 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4yqy3ZnXirSZD0X_1b5qDnyoMLuuSS4mHRcip+CPpvQdg@mail.gmail.com>
X-Gm-Features: AVVi8Cddn7j6HKvYvm1_sm083n__hkLYQ5ZvaULuaYEU5HZ_XQXMl2mMQbb7DQs
Message-ID: <CAGsJ_4yqy3ZnXirSZD0X_1b5qDnyoMLuuSS4mHRcip+CPpvQdg@mail.gmail.com>
Subject: Re: [PATCH 0/3] mm/zram: route block swap I/O through swap_ops
To: Jianyue Wu <wujianyue000@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, Chris Li <chrisl@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Youngjun Park <youngjun.park@lge.com>, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jens Axboe <axboe@kernel.dk>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 14, 2026 at 11:35=E2=80=AFPM Jianyue Wu <wujianyue000@gmail.com=
> wrote:
>
> This series builds on Christoph Hellwig's swap batching rework that
> moves block swap onto struct swap_iocb and per-backend struct
> swap_ops handlers [1].  Christoph's patches unify batching for
> ordinary block devices and swap files.  zram still needs a custom
> path because swap slots map to compressed pages, not disk sectors.
>
> The first patch adds swap_register_block_ops() so a block driver can
> install custom submit_read/submit_write handlers when swapon targets
> its block device.  The default swap_bdev_ops path is unchanged for
> devices that do not register.
>
> The second patch registers zram_swap_ops at module init.  On write,
> the swap core still batches folios into a swap_iocb.  zram maps each
> folio to a slot index and stores it through zram_write_page() instead
> of building one bio per page.  Read handling keeps slot_lock and
> mark_slot_accessed() in one critical section.  Writeback-enabled zram
> falls back to swap_bdev_submit_read() for ZRAM_WB slots.
>
> The third patch moves slot_free_notify into swap_ops next to the
> other zram swap callbacks, and documents the locking contract for
> that hook.
>
> Applied on top of Christoph Hellwig's "better block swap batching and
> a different take on swap_ops" series [1].

Nice. I think it's better to mark it as RFC at this stage.

By the way, besides the architectural refinements, have
you also observed any noticeable performance improvements?

>
> [1] https://lore.kernel.org/linux-mm/?q=3Dbetter+block+swap+batching

Best Regards
Barry
