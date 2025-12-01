Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64F68F5B
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 18:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764612066; cv=none; b=bvJnELwD8xXHhYpR56tHvueXN6puo2MI4RbtwwfDLK2AuxYCMvgeLx8GRywQwdmStKc+uFFExRcHTls8iavw0q8gUxrTpBw/mbIaU9QvU0SCPtSxrTfzMpT5AwmpnaH2ahKJ2DYjq14WeH421l0FO75DTt3K4kIDqCN5zxDxJXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764612066; c=relaxed/simple;
	bh=XtCV8sgrIkC0bXHON+/YLnd0Wg/b5cBse0VLPEK2NYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fM0CXuZsxKz4dosxdkvPUQwiyuO6XfIy+JYnD/FFejalHwr7zsCmKw7JxmWatRyPJazrXjN+lfduHQUu76A426aIH8lD415NMBdoBlnqos9ziyM68JMkObplmLf+6XXzGhosbIkvdEEPWNDC2LIdzVzCUUZGBAh1UnUKGODoNng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rs6mO9/9; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rs6mO9/9"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-882360ca0e2so33249336d6.0
        for <linux-block@vger.kernel.org>; Mon, 01 Dec 2025 10:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764612063; x=1765216863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Cv5hDUAgknH/+rZStNh6n5unAovZ/kZYUXY/NK3DbU=;
        b=Rs6mO9/9HJt9eLQz9Hx3J9TuT/oc9caAy3X+rw+WtBT7MC9wWee5cUnjsm/5eWtBVZ
         41VHOx0DzFTp5UFK0h085MnXGmpS+pFwUNn7oQSMHfUREvqcaL2c5sEtKUeKJ8Fs5xWl
         zjBBNOygN4X0RA7r99cPFWpzfPo/c4LECAKiGT3CY+aowurrGT5W3KkhxQoEk1u8zLPG
         LlttVLQK9faOPEB+gta12NUU5/20YxZ1qECo5NNVVcgVgmIjyt2oLuch6OXGht33sF88
         2aOXKHoEhv7GdTnktbwGwERPO9bE/SkJ1cvyE1gqp+UjtCar24mFlIvkRuDUV0JmeEdU
         +6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764612063; x=1765216863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Cv5hDUAgknH/+rZStNh6n5unAovZ/kZYUXY/NK3DbU=;
        b=FBYu/MXVezV84eSVY0o7n2KgsU0kfOR2GWmRAWkI9OcHMN2yZ4EmdpHURgqtB5vrXs
         pJQaxV7DeuXeWXEAHBNFcxqsu3Vz2/Pi225uQk7xQDMR72Wywt1HjF/HDd0BnsHqV8Ee
         wUBtREZDRpTQzT0XWQUCjzKSA/HT0heECKsHOja2z2NN6TpeS5kIOyYsJcUS0lZrfY8F
         uYjc9cbqtDpmqEWj0ndrR6KioztsWdZ/ugqomax0wVGEQWJAFBlARNWUf5sz8NiqNWLZ
         pjhZT8SLFJRaXSebbkLr9uUSc07GY3WqgMxe2m4GJzzpxsDZS7Utt/hYFnth/KVTGTuY
         vHQw==
X-Forwarded-Encrypted: i=1; AJvYcCUoq1KtvQ0krb6aq+rle2H+La8atRwNrIG/oRUxw9js4HlTD/53JFupjoUv7H359A3EqlKBWcEakqjJzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8gymgwDIlOvLUyjUR4HePsWBPWZ5CbEj8XVteIXT0MTB+pAv+
	0rG5vK9NrTMSafTGCYl2cxjN5tSjw5BYs2eMvJ6ZZUiwwhPvZNo0o+lCeZ/lJxsnYFWM+KhCXv5
	OTCqshamtyVzGHgSSA2Ds6q14rkKdqiY=
X-Gm-Gg: ASbGncvj2OSHUQOf0AOwTAYRYsovqIZBzfmGPc+CdEYTN7U5pG959bMu8wRms4/AJLh
	2nQxRPJ9DOsQCUGAIj+ZMvLDYvdMAQldztJ25Gt74RrGRtREhG7XM/ZbhMdwSgKQ5EX2/gUO3sw
	PBySTKxUnudzIxPfkhL8YOMgm0if8vcBOuai8oA/8b2Tn+WxdCf+TnSGE0vuHs9YaBTt+k96dkp
	GURuDuFiOGBPstczZ971Rq1TLBcvnxe/Z5mMEFtOU+qd4AcNk/gHw4uH3t4OPaQqXsmAQ==
X-Google-Smtp-Source: AGHT+IEnbOkdigYB1iQj98S7F9jaLUo3QrdAuXRWdOjI7a48x+UUey6Gq/+jQWJtLQkGjxtXLM65e/8D5hG4jxJawic=
X-Received: by 2002:a05:6214:21e3:b0:880:4bdd:eb99 with SMTP id
 6a1803df08f44-8847c535ee0mr555865046d6.50.1764612054032; Mon, 01 Dec 2025
 10:00:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128170442.2988502-1-senozhatsky@chromium.org>
 <20251128170442.2988502-2-senozhatsky@chromium.org> <CAGsJ_4yUAw_tzX7z8iizToMB8SDJPNOhFRZNXva_ae46q5vRwg@mail.gmail.com>
 <hgk3zp5hwlcxo6ufiqasvte3hoksy2wb2kta3fime5rprq4org@xaprrqdabvgh>
 <CAGsJ_4z6kSvA+Yzqx=JQ4n3jhQRWn4zYMr364-V2Wjyb2wXE0A@mail.gmail.com> <dt632m4jh2jt5fhnddcbgtdndxh6552hcbwpqeklfx6z7oaihz@lnhskip6whc6>
In-Reply-To: <dt632m4jh2jt5fhnddcbgtdndxh6552hcbwpqeklfx6z7oaihz@lnhskip6whc6>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 2 Dec 2025 02:00:40 +0800
X-Gm-Features: AWmQ_blsT8-0VU02RXHfc5H-laUM9-z7RbHLEIjCAqeNoGAxk8cxOLe97lp3ias
Message-ID: <CAGsJ_4zeqWSZP_xujhbWvjK_jUsPrJDJJ4j4QSgjfUvYtqP+mw@mail.gmail.com>
Subject: Re: [PATCH 1/2] zram: introduce compressed data writeback
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Richard Chang <richardycc@google.com>, 
	Brian Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-block@vger.kernel.org, 
	Minchan Kim <minchan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 5:09=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (25/12/01 16:59), Barry Song wrote:
> > On Mon, Dec 1, 2025 at 11:56=E2=80=AFAM Sergey Senozhatsky
> > <senozhatsky@chromium.org> wrote:
> > [...]
> > > > > zram stores all written back slots raw, which implies that
> > > > > during writeback zram first has to decompress slots (except
> > > > > for ZRAM_HUGE slots, which are raw already).  The problem
> > > > > with this approach is that not every written back page gets
> > > > > read back (either via read() or via page-fault), which means
> > > > > that zram basically wastes CPU cycles and battery decompressing
> > > > > such slots.  This changes with introduction of decompression
> > > >
> > > > If a page is swapped out and never read again, does that actually i=
ndicate
> > > > a memory leak in userspace?
> > >
> > > No, it just means that there is no page-fault on that page.  E.g. we
> > > swapped out an unused browser tab and never come back to it within th=
e
> > > session: e.g. user closed the tab/app, or logged out of session, or
> > > rebooted the device, or simply powered off (desktop/laptop).
> >
> > Thanks, Sergey. That makes sense to me. On Android, users don=E2=80=99t=
 have a
> > close button, yet apps can still be OOM-killed; those pages are never
> > swapped in.
>
> I see.  I suppose on android you still can swipe up and terminate
> un-needed apps, wouldn't this be the same?  Well, apart from that,

That=E2=80=99s true, although it=E2=80=99s not typical user behavior :-)

> zram is not android-specific, some distros use it on desktops/laptops
> as well.

Yes, absolutely.
