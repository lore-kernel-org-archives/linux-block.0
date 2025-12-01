Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4623E2FFDE0
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 09:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764580185; cv=none; b=SXjD+XQ8T5dB8f5H/IKLsY0erl02NRNBQkFbmzCAsVGc2FHrEnU/uWTlJa4kVw4rAwshfH7X5rsy8mMHaxKPBRtEKHR83oMEYjUFDtL7Ku7waVi5bole9r7pndps88liET350bQxDjloKVaCU7G1qtb78YNiigma4JKh+ntBpag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764580185; c=relaxed/simple;
	bh=Kx8V62bdzY0AXtGnLRhPrCk4wQVL6gBrCWd5JZiOL68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXAfRKnA6Ls3cRVw23Kg5fsIOwik7vyRriZ/bMGSCuSy+kxMu1jnGnL9/xvkIl6kzzcESevPjXgQyTmkGquIzIg7XIFElT6QGL4aDL/XkNHQhdFM3gvdrkM0e3eYKr4aEimAhlN4kSYgQO2PQby4dLajjFej+xlm16W0RfWPkS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j573LCcY; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j573LCcY"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7bb3092e4d7so3989660b3a.0
        for <linux-block@vger.kernel.org>; Mon, 01 Dec 2025 01:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764580184; x=1765184984; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z+fc2m4iUG1wiZG+E93U0Pi2aQIPVm7WNHMpYnRyX3A=;
        b=j573LCcYZ9JR1s87wNfA0u/UnfsUnx9EDG0I89QPY6QKFSX64YMYLEcWWuShuIcggP
         cUlj/WGTfjhpqF6wRbIOQ/YQvlZ7nGc2r3frlDk1n5P96DkTpGE4a4ALSlG6TSCR03WC
         2RRhps5rK+z5T04KINFB7tyqZx4aPOPZO7osU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764580184; x=1765184984;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z+fc2m4iUG1wiZG+E93U0Pi2aQIPVm7WNHMpYnRyX3A=;
        b=J11lwgFZG7/zT2g3Gc2t3j9XJAOJEdvAYQariRrCvmWr9ALylOedEIc6N6QTV+EdOo
         jf/HfsoFpveieR7tN3tn/hI9I+eRo1aGOgiJj98bIbea5JomBVy7CLIyeOUXoYtATLuR
         OaL2oquLq0b9RchG1HLyWoSN1K5hNFhyxF1hQD+PLal8DTfUmvBmGiNu/bR5huuYXw04
         RhUkb43iTFwb5nNk3xah+ZZzQZMoU5wCY5BybHoGuMQIcLw1q2r7xuDmkSC3HQo/XgJK
         h7SNrMC+8SZxJOTQZF9MpvENDL8ejPMi3cJyizeAAifXq8ntKokb8R1v+trCGnDNiI6u
         o8qQ==
X-Forwarded-Encrypted: i=1; AJvYcCXi+1U0gjmjMYW+vHdnn3fzqmAtyCVEPWSB73P+lKj27SW0uvmLaiUTaiulezfn8hG/WrbbMozfK4hcSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPqQwydDINyGf3FnkcXjGvZjYoYGogsmnr2U1L1yKxIkEqwvdX
	EuVFxdkK8zwQ6N47nF4J2plYxOI4xC98JoEYQk1wbIhl0/uKkyvMGGWU7ha0fbQ81Q==
X-Gm-Gg: ASbGncuawVZ6DI++iVuOrjaCE2HfV1ZDqtVhfMXKvHbrkLPdMsBEMRGuygMqCD7Xzud
	rrdDqJ6l/G3IsrpXIugPxTu6P9vSNSZsNNuaetmpwAuIW9O4z4ASvOQJ0v2fW2HgE4S8VrzHFrU
	eqXjOep73UFbjD2Ku+PACwxYBXB90Ojr1OQyuDbQdfmZMLII0sH8l1FdX+uhFtFUO3XYg9bZX52
	sseaof+76/ji/b0CtOrLf68h56guczFWYB2qFiTNSk3Gp8G1GVr2LglhFfbfe0UFq+ceW9jUrfz
	lEcN1LkDirnFQaQKOKznZtbv/N9x8RRsbQH5nc0PI+iHzpoGNR75Ze21thNFrSpThpW3ZReKFXO
	Vic41cHuGYi/y43Hx2bMtYdSDjT66Gyb2BLDHTnxmY0jXUWBuqFl4/X+QmvjvCyJNijvvnLOV05
	qfcAHjnfxFUEnnupqYDaqwET2+f0qrJ9NF+adQUsHzAXdkSszFJ/U=
X-Google-Smtp-Source: AGHT+IGX7ImaHb79oWVYq1C+OQ311g0NlH0NigBQ5PHru076OlZHENu05lVhfiah4JQXAmi8jU1qLw==
X-Received: by 2002:a05:6a21:898b:b0:363:b976:8f79 with SMTP id adf61e73a8af0-363b9769000mr9534581637.43.1764580183494;
        Mon, 01 Dec 2025 01:09:43 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:943c:f651:f00f:2459])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be4fb24872fsm11628836a12.1.2025.12.01.01.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 01:09:43 -0800 (PST)
Date: Mon, 1 Dec 2025 18:09:37 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Barry Song <21cnbao@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Richard Chang <richardycc@google.com>, 
	Brian Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-block@vger.kernel.org, Minchan Kim <minchan@google.com>
Subject: Re: [PATCH 1/2] zram: introduce compressed data writeback
Message-ID: <dt632m4jh2jt5fhnddcbgtdndxh6552hcbwpqeklfx6z7oaihz@lnhskip6whc6>
References: <20251128170442.2988502-1-senozhatsky@chromium.org>
 <20251128170442.2988502-2-senozhatsky@chromium.org>
 <CAGsJ_4yUAw_tzX7z8iizToMB8SDJPNOhFRZNXva_ae46q5vRwg@mail.gmail.com>
 <hgk3zp5hwlcxo6ufiqasvte3hoksy2wb2kta3fime5rprq4org@xaprrqdabvgh>
 <CAGsJ_4z6kSvA+Yzqx=JQ4n3jhQRWn4zYMr364-V2Wjyb2wXE0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4z6kSvA+Yzqx=JQ4n3jhQRWn4zYMr364-V2Wjyb2wXE0A@mail.gmail.com>

On (25/12/01 16:59), Barry Song wrote:
> On Mon, Dec 1, 2025 at 11:56 AM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> [...]
> > > > zram stores all written back slots raw, which implies that
> > > > during writeback zram first has to decompress slots (except
> > > > for ZRAM_HUGE slots, which are raw already).  The problem
> > > > with this approach is that not every written back page gets
> > > > read back (either via read() or via page-fault), which means
> > > > that zram basically wastes CPU cycles and battery decompressing
> > > > such slots.  This changes with introduction of decompression
> > >
> > > If a page is swapped out and never read again, does that actually indicate
> > > a memory leak in userspace?
> >
> > No, it just means that there is no page-fault on that page.  E.g. we
> > swapped out an unused browser tab and never come back to it within the
> > session: e.g. user closed the tab/app, or logged out of session, or
> > rebooted the device, or simply powered off (desktop/laptop).
> 
> Thanks, Sergey. That makes sense to me. On Android, users don’t have a
> close button, yet apps can still be OOM-killed; those pages are never
> swapped in.

I see.  I suppose on android you still can swipe up and terminate
un-needed apps, wouldn't this be the same?  Well, apart from that,
zram is not android-specific, some distros use it on desktops/laptops
as well.
