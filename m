Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238CB1C8626
	for <linux-block@vger.kernel.org>; Sat, 29 Nov 2025 09:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764410149; cv=none; b=IamvlpzqY6zZhjE3o/pFyVMhx/N9b/Tw2SeVGtpc60CHUfjNiioTCFZGl1hr3THr5HaDmPoiTcy8ilnrYoXQIG5IiwXiKFqawP/Rs2tMmxnT+1Gv16xi9iSAcsrEIqUGstUQmFoTAnhTf58UOkx+D4/HyI8OIPAGxbeE7wAbzaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764410149; c=relaxed/simple;
	bh=zJ3kmKNfcWPPfnA7WDaF/iaM3rS2BzY8PEgOscaFHV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UTlPpbXIobTQGGDBVVYjN4yA6lMmCk/k8snM2CdmmRyCBkXiZ1PXowl7i3lMiwKc7U0l0vqthJ9X0KfDAGtzf576kXm8ldzSsxjnQ9lqKTFnwpb4pCLeDk301xiEo3bE3fv15KOy2XcuZeTL/hTp1/iXPu1MaiQOp8/fKQtF2ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4usSwCr; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4usSwCr"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b29ff9d18cso234733485a.3
        for <linux-block@vger.kernel.org>; Sat, 29 Nov 2025 01:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764410146; x=1765014946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/iI/7t6PfyA3Rj5l4epnBiBSTkgBrMrR31O4MqJqbk=;
        b=g4usSwCrKKZusAg3AB94IRyybVKnAKZ1Li6OyWnymL4k6OmePmaD58GGjKHKiR12/V
         Ps6haV/FP9PxC7TKiSz/wAWpl8DcNSHLFnSYB5sk6mNQbJLSq0NwzzHiLyytDzCbya7n
         nngfp3uo9ImZLmDm9ikHZArtw1rU4CXIK0oLKbv8c46zJFrAxWYtyCrhuk33WgdcNK59
         LRJy9qpoqGhBzDhEavGhkMmCQK077hXK7p0Su+q64W7pc2dr/3hGpCD7eYrZR2Q5TloS
         gHcOk0wM/8G22tbNsHiuZBmMOl1YPaAwlHVT33TBnYNa2CpmlPebimwm83WgPOYByLz5
         eZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764410146; x=1765014946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A/iI/7t6PfyA3Rj5l4epnBiBSTkgBrMrR31O4MqJqbk=;
        b=vyccBTSsJxm9ly5ldnQiC/VY0PH6KIhoxjpbYrodVa4LWi4F83N8tmMoHM5EvKoN3z
         /p3OsCs2oN19xmQBwYsHPWq4sfcAgBrzJQzKikvZK6CT5KoQJjsZ6hrYslHIkOOSp+uW
         ySm55FgM+EL6kRdVlim55TPb5lx+LrucQRFP+BB6IzigYM4aPq+YoHGBD7tIcO0iD4J/
         AfBkVhrJsIK0wkcqMbuEAtTR1UK3dBUebjWAn1bfqTV1yWwvLfP+6XqW05k+3rjfTxnN
         mryBKnAo9Yj3CYDRtFfrfcqjVv/px3bXPv8EATBwiBJtDI+Bl3ZmqvQsKip7opArp4LN
         53FQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAryyofyPLiZeuu+EZBKXUEc/FOUMtT1iDjdVJFBM8fpPrI0dEfIy222txQrG2vI5dKhy0wu+rgBDeLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUnkCxRKeoRyIxUPwdCEdTu5th3xN3LQLXnJmB56kkvlNHkv/d
	KqgbYkK505Htd3sZqhuR7FT1xj7txuGFdpXnUDTBAbLC/eDIJiN2xpVhrntTG+yivWFqazRpugo
	RwKVWGGYe8NsSFdpLfNP5Ksn99r+R3eA=
X-Gm-Gg: ASbGncu+u9i/mZdHoADT+8CV4/njy74lDTiYFzfhwJoHhFCzY3dSkLacQJy7lSjhBDB
	WEs8JnfPyRG0FrW2qCxM7Z/b4lcSgxyRtlS2uOBipm0PxprPyl2aLWibnFT6degOQkWjRIwEyaF
	GYRN5cTXDd5R4KfFRNpNAt80AS0GQ68w2AI/y7wXa019Nfn5jJr7dk0FgW9xmCnGoQyHoNO5OjM
	Wct8HkhfaKnzLkzsEWakFH5qw6NttrBUky3hdpV6IdHwqSxDQy3nRVr0Tp+NqeS1eDsyA==
X-Google-Smtp-Source: AGHT+IEx5FnoQSqVYE5HkJ4qekuzm872dkwjAjVY0fHIWVwgKTd65EFg6KIctq8t+ydqSEQkx43JpdHpLLiwggx8mXM=
X-Received: by 2002:a05:620a:19a7:b0:8b3:36d5:7544 with SMTP id
 af79cd13be357-8b33d4873e4mr4187792385a.82.1764410145912; Sat, 29 Nov 2025
 01:55:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128170442.2988502-1-senozhatsky@chromium.org> <20251128170442.2988502-2-senozhatsky@chromium.org>
In-Reply-To: <20251128170442.2988502-2-senozhatsky@chromium.org>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 29 Nov 2025 17:55:34 +0800
X-Gm-Features: AWmQ_bm_Hlx6yp0bfipy7ZUUjseiYqdoZMYw-HX6eiK9JohZ6_rLqyBX_3QwRGM
Message-ID: <CAGsJ_4yUAw_tzX7z8iizToMB8SDJPNOhFRZNXva_ae46q5vRwg@mail.gmail.com>
Subject: Re: [PATCH 1/2] zram: introduce compressed data writeback
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Richard Chang <richardycc@google.com>, 
	Brian Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-block@vger.kernel.org, 
	Minchan Kim <minchan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2025 at 1:06=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> From: Richard Chang <richardycc@google.com>
>

Hi Richard, Sergey,

Thanks a lot for developing this. For years, people have been looking for
compressed data writeback to reduce I/O, such as compacting multiple compre=
ssed
blocks into a single page on block devices. I guess this patchset hasn=E2=
=80=99t reached
that point yet, right?

> zram stores all written back slots raw, which implies that
> during writeback zram first has to decompress slots (except
> for ZRAM_HUGE slots, which are raw already).  The problem
> with this approach is that not every written back page gets
> read back (either via read() or via page-fault), which means
> that zram basically wastes CPU cycles and battery decompressing
> such slots.  This changes with introduction of decompression

If a page is swapped out and never read again, does that actually indicate
a memory leak in userspace?

So the main benefit of this patch so far is actually avoiding decompression
for "leaked" anon pages, which might still have a pointer but are
never accessed again?

> on demand, in other words decompression on read()/page-fault.

Thanks
Barry
